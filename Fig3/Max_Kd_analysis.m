%Fractional order controllers increase the robustness of closed-loop deep
%brain stimulation systems
% Antonio Coronel, J. Francisco Gomez Aguilar, Ivanka Stamova and Fidel Santamaria
%This program was made by Antonio Coronel
%This program generates and analize the data in order to analize and getting the Max range for Kd and
%generate the Figure 3
%PLEASE REFER OUR WORK WHEN USING IT.

clc
clear all
close all
t0=0;
T=5;
h=1e-4;
t=(t0:h:T)';
q=1.0;

alf=(1:0.1:1.9)';
bet=(1:-0.1:0.1)';
% alf=1;
% bet=1;
%Starting gains
Kp=15;
Ki=115;
Kd=0.15;
Max_gain=ones(length(alf),1);
Max_gain(1)=Kd; %Initial value to compute the Max Gains for each order, 
%change this value depending of what gain range are you calculating

for k=1:length(bet)
gains=[Kp;Ki;Max_gain(k)]; % Select the gain range to compute
ord=[alf(1);bet(k)]; %In each iteration a different order in de derivative is 
%teasted, change this variable depending of what gain range are you computing
%ord=[alf(k);bet(1)]; uncomment if you want to calculate the Ki range

Wxx=[10.2;20.0;12.3;9.2;139.4]; %Do NOT change the synaptic weights

%Change in orders  %DO not modify these lines
ord2c=2;ordfac=1; 
OM=repmat(ord',10,1);
ordrange=linspace(ord(ord2c),ord(ord2c)*ordfac,10)';
OM(:,ord2c)=ordrange';

%Change in the gains
gain2c=3; %In you are changing the gain Kd
gain2c=2; %In you are changing the gain Ki
gainfac=1.8; %gain to var multiply for a factor gainfac
GM=repmat(gains',10,1);
gainrange=linspace(gains(gain2c),gains(gain2c)*gainfac,10)';
GM(:,gain2c)=gainrange';

%Do NOT modify these lines
s2a=1;s2am=1;
WM=repmat(Wxx',10,1);
trange=linspace(Wxx(s2a),Wxx(s2a)*s2am,10)';
WM(:,s2a)=trange';

parfor v=1:length(trange)
    out(:,:,v)=FControl_STN(q,OM(v,:),GM(v,:),...
        WM(v,:),...
        t0,T,h);
end
mfinal=squeeze(mean(out(round(0.5/h):end,1,:),1));
convergeF=(abs(mfinal-21.8)<2.1); % Determinates if the STN converges to the desired STN
aux=find(convergeF); %Find the each gain in which the STN converges to the desired STN
Max_gain(k+1)=gainrange(max(aux)); %Determinates the maximum gain in which the STN converges

end
Max_KF=Max_gain(2:11);

figure
plot(bet,Max_KF,'black','LineWidth', 4)
xlabel('$\beta$','fontsize',15)
ylabel('$K_{d}$','fontsize',15)
box off
