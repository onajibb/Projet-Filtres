function [f,DSP] = welch(pourcentage_rec, fenetre, signal, N, NFFT,fmin,fmax,fech)
    
    %% Determination de la densité sepctrale de puissance sur une periode
    
    segments = zeros(1,NFFT);
    recouvrement = N*pourcentage_rec; 
    coef = N / recouvrement; 
    nombre_segment = ceil(length(signal)/N) + (1/coef) *(length(signal)/N); 

    for i=1:nombre_segment
        segment = [signal((i-1)*N+1 -(i-1)*recouvrement: i*N -(i-1)*recouvrement)]; % décomposer 
        segment = segment .* fenetre'; 
        segments(i,:) = (abs(fftshift(fft(segment,NFFT))).^2)/N;

    end

    DSP = mean(segments); %moyenne
    
    
    %% La DSP sur les periodes demandées
    
    % Frequence d'interet 
    fmin=round(fmin/(fech/NFFT))*(fech/NFFT);
    fmax=round(fmax/(fech/NFFT))*(fech/NFFT);
    f = fmin : fech/NFFT : fmax-fech/NFFT;
    plage=fmax-fmin;
    % nombre de points d'interet
    Nplage=((plage)/fech)*NFFT;
    fmin=mod(fmin+fech/2,fech)-fech/2;
    FinPeriode=mod(((fech/2-fmin)/fech)*NFFT,NFFT);
    Periode=NFFT;

    if(Nplage<=FinPeriode)
        Pi=((fmin+fech/2)/fech)*NFFT/Periode;
        Pf=((fmin+plage+fech/2)/fech)*NFFT/Periode;       
        s=DSP(1+round(Pi*end):round(Pf*end));
    
    elseif(Nplage>FinPeriode)
        
        P=((fmin+fech/2)/fech)*NFFT/Periode;
        s=DSP(1+round(P*end):end);
        Nplage=Nplage-((fech/2-fmin)/fech)*NFFT;
        
        while(Nplage>Periode)
            s=[s DSP];
            Nplage=Nplage-Periode;
        end
        PF=Nplage/Periode;
        s=[s DSP(1:round(PF*end))];
        
    end


    DSP=s;
    
    
    

end