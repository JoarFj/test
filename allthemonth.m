%Hämtar Temp_ute för alla dagar av en viss månad ( 2008-2018)

%anropas med 1,2,3... för januari
function A=allthemonth(month)

M = importdata('Uppsala_temperaturer_2008_2018.txt', ' ', 1);
 

%N=size(M.data(:,1),1);

N = length(M.data(:,1));

B=[];
for r=1:N
    if M.data(r,2)==month 
        B=[B;M.data(r,4)]; %fyller B-vektorn med den valda månaden
    end
end

A=B;
end