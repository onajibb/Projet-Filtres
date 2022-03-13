% daniel avec recouvrement
%N = taille des segments 
%freqquences_init = les fréquences initiales 
%pourcentage_rec = pourcentage de recouvrement 
%spectre =  spectre de puissance

function [moyennes, frequences] = daniel(spectre, frequences_init, N,pourcentage_rec)
    taille = length(spectre);
    recouvrement = N * pourcentage_rec; 
    coef =  N / recouvrement; 
     nombre_segments = ceil(taille/N)  + floor((1/coef)*(taille/N)); %     moyennes = ones(nombre_segments,1); 
    frequences = ones(nombre_segments,1);
    moyenne = ones(nombre_segments,1); 
    for i=1:nombre_segments
        moyennes(i) = mean(spectre((i-1)*N+1 -(i-1)*recouvrement:i*N -(i-1)*recouvrement));
        frequence = [frequences_init((i-1)*N+1 -(i-1)*recouvrement:i*N -(i-1)*recouvrement)];
        frequences(i) = frequence(length(frequence)/2); 
    end
    
end