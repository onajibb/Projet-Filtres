clc
clear all
close 


%% Paramètres

fech = 1e4;
fichier=load("./signal_radar_config2");
signal = fichier.y; 
fmin =  -(3.4).*fech;
fmax= 3.*fech;

N = 1000; % nombre de points dont on va calculer la puissance
Size = size(signal); 

%% Calcul de la puissance  
% en supposant le processus aléatoire ergodique 

H = filtre(signal,100,fech);  
rx = xcorr(signal); 
rx_new = rx(floor(length(rx)/2)+1:length(rx)); 
rx_exp = autocorrfct(signal); 
Rx = toeplitz(rx_new); 

%boucle des différentes fréquences

frequences = -fech/2:fech/N:fech*((1/2)-1/N); 
puissance = ones(N,1); 
for f=1:N
    H = filtre(signal,frequences(f),fech); 
    puissance(f) = H'*Rx*H; 
end


%% Figures 
figure();
hold on
semilogy(frequences,puissance,'r','linewidth',1);

