%Fractional order controllers increase the robustness of closed-loop deep
%brain stimulation systems
% Antonio Coronel, J. Francisco Gomez Aguilar, Ivanka Stamova and Fidel Santamaria
%This program was made by Antonio Coronel
%This program generates the Figure 2
%PLEASE REFER OUR WORK WHEN USING IT.

clc
clear
close all
t0=0;
T=5;
%Fractional order in the system, we used 1 for all the Figs of the paper
%since we are testing only the fractional dynamics in the controller
q=1;

Kp=15;
Ki=115;
Kd=0.15;
%Fractional integral and derivative orders
alf=1;
bet=1;

h=1e-3; %time step
t=(t0:h:T)';
%System delay
delt=6e-3;
delt2=4e-3;

m=round(delt/h);
m2=round(delt2/h);
N=(T-t0)/h;
%System and activation function parameters
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
Xs2=Xs_in*ones(N,1);
Xg2=Xg_in*ones(N,1);
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
e=zeros(N,1);
K0=1;
for k=(m+2):N+1
    Fs=(Ms)/(1+(((Ms-Bs)/(Bs))*exp(-4*1000*t(k-m-1)/Ms)));
    Fg=(Mg)/(1+(((Mg-Bg)/(Bg))*exp(-4*1000*t(k-m-1)/Mg)));
   
    e(k-m-1)=Xsd-Xs(k-m-1);
    if k>(N/2)

       Fs=(Ms)/(1+(((Ms-Bs)/(Bs))*exp(-4*1000*t(k-(N/2))/Ms)));
       Fg=(Mg)/(1+(((Mg-Bg)/(Bg))*exp(-4*1000*t(k-(N/2))/Mg)));
        Wgs=10.12;
        Wsg=20.0;
        Wgg=12.3;
        Wcs=9.2;
        Wxg=139.4;               
    end
    u(k-1-m)=PID_PD(e, K0, h, Kp , Ki, Kd, alf, bet, k-m-1);
    Xs(k)=(h^q*(((Fs*(-Wgs*Xg(k-1-m)+Wcs*Ctx+u(k-1-m)))-Xs(k-1-m))/TauS))- memo(Xs,c1,k); 
    Xg(k)=(h^q*(((Fg*(Wsg*Xs(k-1-m)-Wgg*Xg(k-1-m2)-Wxg*Str))-Xg(k-1-m))/TauG))- memo(Xg,c2,k);  
    Xs2(k)=(h^q*(((Fs*(-Wgs*Xg2(k-1-m)+Wcs*Ctx))-Xs2(k-1-m))/TauS))- memo(Xs2,c1,k); 
    Xg2(k)=(h^q*(((Fg*(Wsg*Xs2(k-1-m)-Wgg*Xg2(k-1-m2)-Wxg*Str))-Xg2(k-1-m))/TauG))- memo(Xg2,c2,k);  
end

%%
t2=(0:h/2:2.5)';
t2=(t2-1.25);
% t=(t-2.5);
close all
figure
subplot(2,1,1)
plot(t2,Xs,'black','LineWidth', 2)
hold on
plot(t2,Xg,'black--','LineWidth', 2)
box off
legend('STN','GP')
legend boxoff
xlabel('Time [s]','fontsize',15)
ylabel('Firing rate [spk/s]','fontsize',15)
axis([-0.1 1 0 75])

subplot(2,1,2)
plot(t2,Xs2,'black','LineWidth', 2)
hold on
plot(t2,Xg2,'black--','LineWidth', 2)
xlabel('Time [s]','fontsize',15)
ylabel('Firing rate [spk/s]','fontsize',15)
axis([-0.1 1 0 75])
box off
