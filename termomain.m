%mainfil f�r Termo Matlabuppgift 1
M = importdata('Uppsala_temperaturer_2008_2018.txt', ' ', 1);
Q= importdata('Uppsala_stralning_2008_2018.txt', ' ', 1);

%konstanter

T_inne=21;

%--------------Uppgift (1)--------------

%%Ber�knar husets v�rmel�ckage f�r alla dagar under perioden 2008-2017,
%%anv�nds f�r (iii)

N=size(M.data(:,1),1);
Heat_leak=[];
for r=1:N
    T_ute=M.data(r,4); %h�mtar utetemp fr�n kolumn 4
    T_diff=abs(T_inne-T_ute);%temperaturskillnad inne/ute
    Leak=2*T_diff*24; %dagens v�rmel�ckage per dag (2MJ * 24h*tempskillnad)
    Heat_leak=[Heat_leak;Leak]; %l�gger till alla heatleaks i listan heat_leak
end
% 
% 
disp('Husets v�rmel�ckage f�r alla dagar under perioden �r Heat_leak.');


%Visualiserar medelv�rdet av v�rmel�ckaget �ver  �rets m�nader dvs m�nad 1-12
y=[];
for i=1:12
    Y=meanleak(i);
    y=[y,Y];%
end
x=[1:12];%m�nader

figure
plot(x,y,'o')
title('Medelv�rde av v�rmel�ckaget av en genomsnittsdag f�r �rets m�nader');
xlabel('�rets M�nader');
ylabel('Medelv�rde v�rmel�ckage [MJ]');
% 
% 
% %-------------------------(ii)-----------------------
% 
% %Ber�knar COP av alla dagar under perioden 2008-2017
% 
Tute=[];
for r=1:N %f�r varje dag
    Tute=[Tute;M.data(r,4)];%h�mta utetemp 
end
% 
TH=Tradiator(Tute) + 273.15; % Radiatorfunktionen anropas f�r hela T_ute-vektorn ovan, +273 f�r Kelvin
TL=10 + 273.15; %givet i uppgift


COP2=[];
for r=1:N  %f�r varje dag
    
    COP= 1/(1-TL/TH(r)) %ber�kna COP
    
    COP2=[COP2;COP]; %lista COP
end

disp('COP f�r alla dagar under perioden �r COP2.');
% 
% 
%Visualiserar medelv�rdet av COPn �ver m�naderna
yy=[];
for i=1:12
    Y=meanCOP(i);
    yy=[yy,Y];%append
end

% (ii)- plot
figure
plot(x,yy,'--')
title('Medelv�rdet av COPn �ver m�naderna')
xlabel('M�nader')
ylabel('Medelv�rde COP');
% 
% %-------------------------(iii)-----------------------
% 
% %Ber�knar energif�rbrukningen av alla dagar under perioden 2008-2017
E_day=Heat_leak./COP2;
disp('Energif�rbrukningen f�r alla dagar under perioden �r E_day.');

%Visualiserar medelv�rdet av Energif�rbrukningen �ver m�naderna
yyy=[];
for i=1:12
    Y=meantest3(i);
    yyy=[yyy,Y];%appendar in v�rden i listan
end

%(iii)-plot
y4=(2.777*10^(-1)).*yyy; %omvandlar vektorn fr�n MJ till kwH


figure
x = [1:12]
plot(x,y4,'o-')
title('Medelv�rdet av Energif�rbrukningen �ver m�naderna')
xlabel('M�nader')
ylabel('Medelv�rde Energif�rbrukning [kWh]');

%----------------------------------------------

%------Uppgift 2-------------------------------
%total energif�rbrukning f�r
E1=sum((E_day(1:366)));% (2008)
E2=sum((E_day(367:732))); % (2009)
E3=sum((E_day(733:1096))); %(2010)
E4=sum((E_day(1097:1461)));%% (2011)
E5=sum((E_day(1462:1827)));%% (2012)
E6=sum((E_day(1828:2192)));%% (2013)
E7=sum((E_day(2193:2557))); %(2014)
E8=sum((E_day(2558:2922))); %% (2015)
E9=sum((E_day(2923:3288))); %% (2016)
E10=sum((E_day(3289:3653)));%% (2017)
% 
% 
% 
EE=(2.777e-1).*[E1 E2 E3 E4 E5 E6 E7 E8 E9 E10];%omvandling MJ->kWh
xx=[2008 2009 2010 2011 2012 2013 2014 2015 2016 2017];

figure
plot(xx,EE,'x-')
title('�rlig energif�rbrukning kWh ');
xlabel('�r');
ylabel('Energif�rbrukning [kWh]');
% ------------------------------------------------




%-----uppgift 3------------------------------------
A=Q.data(:,4);%str�lningsdata
S=A*100*0.07*24/277;%energi solcell [W]

SS=S*24*3600;%energi solcell [J]
N1=size(Q.data(:,4),1);





% for r=1:N1%f�r varje rad 
%     if S(r)>E_day(r)% Solcellen kan ej bidra mer �n pumpens f�rbrukning
%         S(r)=E_day(r);%ers�tt solenergi = pumpenergi
%     end
% end

for r = 1:length(S) %f�r varje rad 
    if S(r)>E_day(r)%
        S(r)=0;
    else
        S(r)=E_day(r)- S(r) ;%ers�tt
    end
end



%ber�kna vilken procent av den �rliga energif�rbrukningen som levererades av solcellerna.
procent = 1-(sum(S)/sum(E_day))

%uppgift 3 plot
%S �r nu sparade energin varje dag
figure

plot(1:length(S),S,'-')
xlabel('antal dagar')
ylabel('Sparade energin/dag')
title('Plottade sparade energin per dag �ver 10 �r');




