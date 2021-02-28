function medel=meantest3(month)

[medel1,total1,every1]=meanleak(month);
[medel2,total2,every2]=meanCOP(month);

% E = E_leak/COP för vektorerna

E_cons=every1./every2; 

medel=sum(E_cons)/size(E_cons,1);

end