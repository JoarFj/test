%beräknar värmeläckaget 

function [medel,total,every]=meanleak(month)
M = importdata('Uppsala_temperaturer_2008_2018.txt', ' ', 1);

A=allthemonth(month);
N_days=size(A,1);%totala antalet januaridagar

T_inne=21;
every=[];
for r=1:N_days
    T_ute=A(r);
    T_diff=abs(T_inne-T_ute);    %Temperatursskillnad mellan inne och ute
    Heat_leak=2*T_diff*24;    
    every=[every;Heat_leak];% lägger till varje heatleak i en lista "every"
end
total=sum(every); %Summerar varje heatleak
medel=total/N_days;%MEDELVÄRDE PER DAG
end
