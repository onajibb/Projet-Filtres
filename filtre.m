% H représentant la réponse impulsionnelle du filtre d'intéret 

function H = filtre(signal,f,fech)
    rx = xcorr(signal); 
    rx_new = rx(floor(length(rx)/2)+1:length(rx)); 
    Rx = toeplitz(rx_new); 
    Size = size(signal); 
    a = ones(Size(1),1); 
    for ii=1:Size(1)
        a(ii) = exp((-j*(ii-1)*2*pi*f)/fech);  
    end
    H = inv(Rx)*a./(a'*inv(Rx)*a); 
end