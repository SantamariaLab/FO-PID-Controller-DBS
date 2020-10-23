function uc=PID_PD(e, K0, Ts, Kp, Ti, Td, lambda, delta, k)
%This function implements a fractional order PID controller where e is the
%error, Ts is the time step, Kp the proportional gain, Ti the integration
%time, Td the derivative time, lambda the integral order, delta the
%derivative order and k the counter.
% This program was created by Antonio Coronel
%

bc=cumprod([1,1-((-lambda+1)./[1:k])]); 
bd=cumprod([1,1-((delta+1)./[1:k])]); 
%
uc = (K0+(1-K0)*abs(e(k)))*(Kp*e(k) + Ti*Ts^(lambda)*memo(e, bc, k) + Td*Ts^(-delta)*memo(e, bd, k));
