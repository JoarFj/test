%funktion för elementet enligt uppgiftsbeskrivning
% används för uppgift
function TH=Tradiator(Tute)

N=size(Tute,1);
TH=[];
for r=1:N
    
    if Tute(r)<-4
        th=36.44-0.64*Tute(r);

    elseif Tute(r)>21
        th=21;

    elseif Tute(r)<=4 && Tute(r)>=-4
        th=39;

    elseif Tute(r)>4 && Tute(r) <=21
        th=43.26-1.06*Tute(r);
    end
    TH=[TH;th];
    
end

end