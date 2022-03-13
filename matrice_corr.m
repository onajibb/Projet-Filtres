
function Rx = matrice_corr(signal)
    rx = autocorrfct(signal); 
    Size = size(signal); 
    Rx = ones(Size(1), Size(1)); 
    for i=1:Size(1)
       for j=1:Size(1)
          if(i-j>=0)
             Rx(i,j) = rx(i-j+1,1);   
          else
             Rx(i,j) = rx(j-i+1,2);  
          end
       end
    end 
end
