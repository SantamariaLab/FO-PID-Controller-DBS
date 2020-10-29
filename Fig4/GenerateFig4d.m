%Fractional order controllers increase the robustness of closed-loop deep
%brain stimulation systems
% Antonio Coronel, J. Francisco Gomez Aguilar, Ivanka Stamova and Fidel Santamaria
%This program was made by Antonio Coronel
%This program generates only the Figure 4d, if you want to generate the
%data, please use the code from Figure 2 and run the simulations with the
%proper values (see the paper).
%PLEASE REFER OUR WORK WHEN USING IT.

clc
clear all
close all
set(groot, 'defaultAxesTickLabelInterpreter','latex'); 
set(groot, 'defaultLegendInterpreter','latex');
set(0, 'DefaultTextInterpreter', 'latex')
 
load Stable.mat

clear t
h=1e-4;
t0=2.5;
T=2.9;
t=(t0:h:T)';
auxXs=out(:,1,9);
auxXg=out(:,1,9);

auxmemki=out(:,3,9);
auxmemkd=out(:,4,9);

Xs=auxXs((t0/h):(T/h));
Xg=auxXg((t0/h):(T/h));

memki=auxmemki((t0/h):(T/h));
memkd=auxmemkd((t0/h):(T/h));

clear out
load Oscillatory.mat
h=1e-4;
t0=2.5;
T=2.9;
t=(t0:h:T)';


auxXs2=out(:,1,7);
auxXg2=out(:,1,7);

auxmemki2=out(:,3,7);
auxmemkd2=out(:,4,7);

Xs2=auxXs2((t0/h):(T/h));
Xg2=auxXg2((t0/h):(T/h));

memki2=auxmemki2((t0/h):(T/h));
memkd2=auxmemkd2((t0/h):(T/h));

figure
subplot(2,1,1)
plot(Xs,memkd,'LineWidth',2)
hold on
plot(Xs(1),memkd(1),'o','LineWidth',2,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','white',...
                'MarkerSize',10); 
            hold on
plot(Xs(end),memkd(end),'o','LineWidth',2,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','white',...
                'MarkerSize',10);
legend('Controlled system',...
    'STN=21.8, Memory trace=0, $t=0$ s',...
    'STN=21.8, Memory trace=0, $t=200$ ms','Location','southwest')
legend boxoff
xlabel('STN [spk/s]','fontsize',15)
ylabel('Memory trace [spk/s]','fontsize',15)
axis([0 40 -450 450])
box off

subplot(2,1,2)
plot(Xs2,memkd2,'Color',1/255*[216 82 24],'LineWidth',2)
hold on
plot(Xs2(1),memkd2(1),'rs','LineWidth',2,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor',1/255*[42 98 70],...
                'MarkerSize',10); 
            hold on
plot(Xs2(end),memkd2(end),'rs','LineWidth',2,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor',1/255*[216 41 1],...
                'MarkerSize',10);
            legend('Non-controlled system',...
    'STN=21.8, Memory trace=0, $t=0$ s',...
    'STN=21.8, Memory trace=0, $t=200$ ms','Location','southwest')
legend boxoff
xlabel('STN [spk/s]','fontsize',15)
ylabel('Memory trace [spk/s]','fontsize',15)
axis([0 40 -450 450])
box off
