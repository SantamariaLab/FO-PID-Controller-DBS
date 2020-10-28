%Fractional order controllers increase the robustness of closed-loop deep
%brain stimulation systems
% Antonio Coronel, J. Francisco Gomez Aguilar, Ivanka Stamova and Fidel Santamaria
%This program was made by Antonio Coronel
%This program generates only the Figure 3, if you want to generate the
%data, please refear to the Codes titled: Max_Ki_analysis.m and Max_Kd_analysis.m
%PLEASE REFER OUR WORK WHEN USING IT.
clc
clear all
close all
 alf=(1:0.1:1.9)';
 bet=(1:-0.1:0.1)';

valuealf=[1967;2708;3603;4450;5392;6733;8523;11206;14337;17020];
valuebet=[0.19;0.32;0.55;1.01;1.75;2.95;5.35;8.20;14.68;21.03];

figure
plot(alf,valuealf,'black','LineWidth', 4)
xlabel('$\alpha$','fontsize',15)
ylabel('$K_{i}$','fontsize',15)
box off
figure
plot(bet,valuebet,'black','LineWidth', 4)
xlabel('$\beta$','fontsize',15)
ylabel('$K_{d}$','fontsize',15)
box off
