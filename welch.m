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

end
