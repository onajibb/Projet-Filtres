
clc;
clear;
close all;

%% Paramètres

fech = 1e5;
fmin =  -(3.4).*fech;
fmax= 3.*fech;
signal=randn(1,10000);
NFFT=256;


%% Approche par spectre de puissance

Spectre = abs(fftshift(fft(signal,NFFT)).^2)/NFFT;


%% Approche par spectrogramme

N = 100; 
pourcentage_rec = 0.95;
fenetre = rectwin(N);
[f,DSP] = welch(pourcentage_rec, fenetre, signal, N, NFFT,fmin,fmax,fech);%moyenne %moyenne


%% Approche par la méthode  des rectangles

puissance = 0; 
for i=1:length(DSP) 
    puissance = puissance + abs(DSP(i))*fech/NFFT;  
end

%% Approche par la méthode des trapèzes

puissance_t = 0;
for j=1:(length(DSP)-1)
    puissance_t = puissance_t + ((abs(DSP(j)) + abs(DSP(j+1)))*fech/NFFT)/2;
end

%% Comparaison entre les deux approches
fmin=round(fmin/(fech/NFFT))*(fech/NFFT);
fmax=round(fmax/(fech/NFFT))*(fech/NFFT);
%f = fmin : fech/NFFT : fmax-fech/NFFT;
figure();
hold on
semilogy(f,DSP,'r','linewidth',1);
ylim([0 10]);
hold off
xlabel('Fréquence');
ylabel('Signal');
%xticks([-fech/2 -fech/4 0 fech/4 fech/2])
%xticklabels({'-fech/2','-fech/4','0','fech/4','fech/2'})
legend('DSP');


