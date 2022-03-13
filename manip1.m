clc;
clear;
close all;

%% Paramètres

fech = 1e4;
fmin = fech;
fmax= fech+1000;
signal=randn(1,10000);
NFFT=256;


%% Approche par spectre de puissance

Spectre = abs(fftshift(fft(signal,NFFT)).^2)/NFFT;

%% Approche par spectrogramme

Max = ceil(length(signal)/NFFT)-1;
segments = zeros(Max,NFFT);

%%Algo
for i=1:Max-1
    segment = [signal((i-1)*NFFT+1:i*NFFT)]; % décomposer
    segments(i,:) = (abs(fftshift(fft(segment,NFFT))).^2)/NFFT;
end

DSP = mean(segments); %moyenne

%% Comparaison entre les deux approches
f = -fech/2 : fech/NFFT : fech/2-fech/NFFT;
figure();
hold on
semilogy(f,DSP,'r','linewidth',1);
semilogy(f,Spectre,'b','linewidth',1);
hold off
xlabel('Fréquence');
ylabel('Signal');
xticks([-fech/2 -fech/4 0 fech/4 fech/2])
xticklabels({'-fech/2','-fech/4','0','fech/4','fech/2'})
legend('Densité spectrale de puissance','Spectre de puissance');

%%
fminTest=mod(fmin,fech);
if(fminTest~=fmin)
    fmin=mod(fmin,fech)-fech/2;
end
fmaxTest=mod(fmax,fech);
if(fmaxTest~=fmax)
    fmax=mod(fmax,fech)-fech/2;
end


%Test=DSP(round(1+NFFT*(fmin/fech+0.5)):round(1+NFFT*(fmax/fech+0.5)));


