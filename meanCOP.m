%Beräknar medelvärde av COP av alla dagar av en viss månad 

%Beräknar COP-medelvärde för exempelvis alla januarimånader (2008-2018)
% anropas med 1,2,3.. för januari,februari, ...
function [medel,total,every]=meanCOP(month)
M = importdata('Uppsala_temperaturer_2008_2018.txt', ' ', 1);


Tute=allthemonth(month); %utetemp alla dagar 

N_days=size(Tute,1);%totala antalet januaridagar
TH=Tradiator(Tute)+ 273.15;
TL=10+273.15;
COPsum=0;
every=[];
for r=1:N_days    
    COP=1/(1-TL/TH(r)); %formel för COP
    COPsum=COPsum+COP;
    every=[every;COP];
end
total=COPsum;
medel=COPsum/N_days;
end
