%Fractional order controllers increase the robustness of closed-loop deep
%brain stimulation systems
% Antonio Coronel, J. Francisco Gomez Aguilar, Ivanka Stamova and Fidel Santamaria
%This program was made by Antonio Coronel
%This program generates only the Figure 4a and Figure 4b, if you want to generate the
%data, please use the code from Figure 2 and run the simulations with the
%proper values (see the paper).
%PLEASE REFER OUR WORK WHEN USING IT.

clc
clear all
close all
 
load Stable.mat
clear t
h=1e-4;
t0=2.4;
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
t0=2.4;
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

t=t-2.5;
figure
% subplot(2,1,1)
hold on
plot(t,Xs,'LineWidth', 2)
hold on
plot(t,Xs2,'LineWidth', 2)
box off
legend('STN; $\alpha=1.5$, $\beta=0.5, K_{i}$=5788, $K_{d}$=2.55',...
    'STN; $\alpha=1.5$, $\beta=0.5, K_{i}$=5788, $K_{d}$=3.35')
legend boxoff
xlabel('Time [s]','fontsize',15)
ylabel('Firing rate [spk/s]','fontsize',15)
xlim([-0.1 0.4])
axis([-0.1 0.4 5 40])

figure
subplot(2,1,1)
hold on
plot(t,memki,'LineWidth', 2)
hold on
plot(t,memki2,'LineWidth', 2)
box off
legend('Memory trace in the integral; $\alpha=1.5$, $\beta=0.5, K_{i}$=5788, $K_{d}$=2.55',...
    'Memory trace in the integral; $\alpha=1.5$, $\beta=0.5, K_{i}$=5788, $K_{d}$=3.35')
legend boxoff
xlabel('Time [s]','fontsize',15)
ylabel('Memory trace [spk/s]','fontsize',15)
xlim([-0.1 0.4])
ylim([-0.1 0.1])

subplot(2,1,2)
hold on
plot(t,memkd,'LineWidth', 2)
hold on
plot(t,memkd2,'LineWidth', 2)
hold on
plot(t(1235),memkd2(1235),'rs','LineWidth',2,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor',1/255*[42 98 70],...
                'MarkerSize',5);
box off
legend('Memory trace in the derivative; $\alpha=1.5$, $\beta=0.5, K_{i}$=5788, $K_{d}$=3.35',...
    'Memory trace in the derivative; $\alpha=1.5$, $\beta=0.5, K_{i}$=5788, $K_{d}$=2.55',...
    'Over-compensation in the memory trace')

legend boxoff
xlabel('Time [s]','fontsize',15)
ylabel('Memory trace [spk/s]','fontsize',15)
xlim([-0.1 0.4])
ylim([-350 650])
box off
