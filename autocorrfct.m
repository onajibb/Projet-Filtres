
function rx = autocorrfct(signal)
    Size = size(signal); 
    rx = ones(Size(1),2);
    for ii=1:Size(1)
        realisations_pos = ones(Size(2),1);
        realisations_neg = ones(Size(2),1);
        for jj=1:Size(2)
            realisations_pos(jj) = signal(ii+1-1,jj)*conj(signal(1,jj)); 
            realisations_neg(jj) = conj(signal(ii+1-1,jj))*signal(1,jj); 
        end
        moyenne = mean(realisations_pos); 
        moyenne_n = mean(realisations_neg); 
        rx(ii,1) = moyenne;
        rx(ii,2) = moyenne_n; 
    end
end