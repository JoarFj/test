%mainfil för Termo Matlabuppgift 1
M = importdata('Uppsala_temperaturer_2008_2018.txt', ' ', 1);
Q= importdata('Uppsala_stralning_2008_2018.txt', ' ', 1);

%konstanter

T_inne=21;

%--------------Uppgift (1)--------------

%%Beräknar husets värmeläckage för alla dagar under perioden 2008-2017,
%%används för (iii)

N=size(M.data(:,1),1);
Heat_leak=[];
for r=1:N
    T_ute=M.data(r,4); %hämtar utetemp från kolumn 4
    T_diff=abs(T_inne-T_ute);%temperaturskillnad inne/ute
    Leak=2*T_diff*24; %dagens värmeläckage per dag (2MJ * 24h*tempskillnad)
    Heat_leak=[Heat_leak;Leak]; %lägger till alla heatleaks i listan heat_leak
end
% 
% 
disp('Husets värmeläckage för alla dagar under perioden är Heat_leak.');


%Visualiserar medelvärdet av värmeläckaget över  årets månader dvs månad 1-12
y=[];
for i=1:12
    Y=meanleak(i);
    y=[y,Y];%
end
x=[1:12];%månader

figure
plot(x,y,'o')
title('Medelvärde av värmeläckaget av en genomsnittsdag för årets månader');
xlabel('Årets Månader');
ylabel('Medelvärde värmeläckage [MJ]');
% 
% 
% %-------------------------(ii)-----------------------
% 
% %Beräknar COP av alla dagar under perioden 2008-2017
% 
Tute=[];
for r=1:N %för varje dag
    Tute=[Tute;M.data(r,4)];%hämta utetemp 
end
% 
TH=Tradiator(Tute) + 273.15; % Radiatorfunktionen anropas för hela T_ute-vektorn ovan, +273 för Kelvin
TL=10 + 273.15; %givet i uppgift


COP2=[];
for r=1:N  %för varje dag
    
    COP= 1/(1-TL/TH(r)) %beräkna COP
    
    COP2=[COP2;COP]; %lista COP
end

disp('COP för alla dagar under perioden är COP2.');
% 
% 
%Visualiserar medelvärdet av COPn över månaderna
yy=[];
for i=1:12
    Y=meanCOP(i);
    yy=[yy,Y];%append
end

% (ii)- plot
figure
plot(x,yy,'--')
title('Medelvärdet av COPn över månaderna')
xlabel('Månader')
ylabel('Medelvärde COP');
% 
% %-------------------------(iii)-----------------------
% 
% %Beräknar energiförbrukningen av alla dagar under perioden 2008-2017
E_day=Heat_leak./COP2;
disp('Energiförbrukningen för alla dagar under perioden är E_day.');

%Visualiserar medelvärdet av Energiförbrukningen över månaderna
yyy=[];
for i=1:12
    Y=meantest3(i);
    yyy=[yyy,Y];%appendar in värden i listan
end

%(iii)-plot
y4=(2.777*10^(-1)).*yyy; %omvandlar vektorn från MJ till kwH


figure
x = [1:12]
plot(x,y4,'o-')
title('Medelvärdet av Energiförbrukningen över månaderna')
xlabel('Månader')
ylabel('Medelvärde Energiförbrukning [kWh]');

%----------------------------------------------

%------Uppgift 2-------------------------------
%total energiförbrukning för
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
title('Årlig energiförbrukning kWh ');
xlabel('År');
ylabel('Energiförbrukning [kWh]');
% ------------------------------------------------




%-----uppgift 3------------------------------------
A=Q.data(:,4);%strålningsdata
S=A*100*0.07*24/277;%energi solcell [W]

SS=S*24*3600;%energi solcell [J]
N1=size(Q.data(:,4),1);





% for r=1:N1%för varje rad 
%     if S(r)>E_day(r)% Solcellen kan ej bidra mer än pumpens förbrukning
%         S(r)=E_day(r);%ersätt solenergi = pumpenergi
%     end
% end

for r = 1:length(S) %för varje rad 
    if S(r)>E_day(r)%
        S(r)=0;
    else
        S(r)=E_day(r)- S(r) ;%ersätt
    end
end



%beräkna vilken procent av den årliga energiförbrukningen som levererades av solcellerna.
procent = 1-(sum(S)/sum(E_day))

%uppgift 3 plot
%S är nu sparade energin varje dag
figure

plot(1:length(S),S,'-')
xlabel('antal dagar')
ylabel('Sparade energin/dag')
title('Plottade sparade energin per dag över 10 år');




