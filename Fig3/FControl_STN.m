function X=FControl_STN(ord,ORD,GAINS,Wxx,tini,tfin,st)

%System

t0=tini;
T=tfin;
h=st;
t=(t0:h:T)';

q=ord;
alf=ORD(1);
bet=ORD(2);

Kp=GAINS(1);
Ki=GAINS(2);
Kd=GAINS(3);

delt=6e-3;
delt2=4e-3;

m=round(delt/h);
m2=round(delt2/h);

N=(T-t0)/h;

Ms=300;
Mg=400;
Bs=17;
Bg=75;

Wgs=1.12;
Wsg=19.0;
Wgg=6.60;
Wcs=2.42;
Wxg=15.1;

Ctx=27;   %Vs
Str=2;  %Vg

TauS=60;
TauG=140;

%Initial conditions
Xs_in=0;
Xg_in=0;

Xs=Xs_in*ones(N,1);
Xg=Xg_in*ones(N,1);

% Set point
Xsd=21.8;

%%%%% Binomial coeff computed
c1=ones(length(t),1); 
c2=ones(length(t),1);

%Begin coeff

cp1=1; cp2=1;

for n=1:length(t)
    c1(n)=(1-(1+q)/n)*cp1;
    c2(n)=(1-(1+q)/n)*cp2;
    cp1=c1(n); cp2=c2(n);    
end

u=zeros(N,1);
ki_mem=zeros(N+1,1);
kd_mem=zeros(N+1,1);

e=zeros(N,1);

K0=1;

for k=(m+2):N+1
    
    Fs=(Ms)/(1+(((Ms-Bs)/(Bs))*exp(-4*1000*t(k-m-1)/Ms)));
    Fg=(Mg)/(1+(((Mg-Bg)/(Bg))*exp(-4*1000*t(k-m-1)/Mg)));
    e(k-m-1)=Xsd-Xs(k-m-1);
    
    if k>(N/2)
        
        Wgs=Wxx(1);
        Wsg=Wxx(2);
        Wgg=Wxx(3);
        Wcs=Wxx(4);
        Wxg=Wxx(5);  
        
    end
        bc=cumprod([1,1-((-alf+1)./[1:k])]); 
        bd=cumprod([1,1-((bet+1)./[1:k])]); 

        ki_mem(k-m-1)=h^(alf)*memo(e, bc, k-m-1);
        kd_mem(k-m-1)=h^(-bet)*memo(e, bd, k-m-1);
    
    u(k-m-1) = (K0+(1-K0)*abs(e(k-m-1)))*(Kp*e(k-m-1) + Ki*h^(alf)*memo(e, bc, k-m-1) + Kd*h^(-bet)*memo(e, bd, k-m-1));
    
    Xs(k)=(h^q*(((Fs*(-Wgs*Xg(k-1-m)+Wcs*Ctx+u(k-1-m)))-Xs(k-1-m))/TauS))- memo(Xs,c1,k);
    
    Xg(k)=(h^q*(((Fg*(Wsg*Xs(k-1-m)-Wgg*Xg(k-1-m2)-Wxg*Str))-Xg(k-1-m))/TauG))- memo(Xg,c2,k);
    
    
end

for n=1:N+1
    X(n,1)=Xs(n);
    X(n,2)=Xg(n);
    X(n,3)=ki_mem(n);
    X(n,4)=kd_mem(n);
    
end
