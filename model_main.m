
%{
double eta i_th0 r_th a_0 a_1 a_2 a_3 a_4;

t_0 = 20; % Kelvin;
% define the syms for vars
double p t u i;


eta = 0.5
i_th0 = 0.3e-3
r_th = 2.6e3*1e-3 (mW~)
a_0 = 1.246e-3
a_1 = -2.545e-5
a_2 = 2.908e-7
a_3 = -2.531e-10
a_4 = 1.022e-12

%load data


%due to no linearity of semi conductor properties, we deduct the junction voltage
R = (U(38)-U(1))/(I(38)-I(1));


exp1 = eta*(i-i_th0-a_0 -a_1*t^1 - a_2*t^2-a_3*t^3 - a_4*t^4 );
exp1s = eta*(i-i_th0 - a_0);

exp2 = t_0 + (i*u-p)*r_th;
exp3 = t_0 + (i*(u-0.9)-p)*r_th; %consider junction vol
exp4 = t_0 + (i^2*R)*r_th; %consider resistor model

eqn1 = p == eta*(i-i_th0-a_0 -a_1*t^1 - a_2*t^2-a_3*t^3 - a_4*t^4 );
eqn2 = t == t_0 + (i*u-p)*r_th;
%}
%test parameters
%eqt_0_3f = subs(eqn2, {u,i,p}, {U(39), I(39), P(39)})
%S01 = solve(eqt_0_3f, 'MaxDegree', 4, 'Real', true, 'ReturnConditions', true)
%tt_0 = vpa(S01.t)
%hopefully we have got t of initial point
%result is no, the temperature is tooo high. so let's update the initial parameters.
%find eta near P(I) ~ 0 point

% i find the eta should be near 0.3
%eta = 0.275;
% then the Ith0 and Ioff should be 0.371. consider I<4A has good
% linearity, i_th0 and a_0 should be 0.371 == ioff_0
%ioff_0 = I(39)-P(39)/eta
% then use min search for r_th a1 -- a4
% prepare a functions


%%then we have three way to find the parameters for dataset U I P
% curve fitting: https://cn.mathworks.com/help/matlab/math/example-curve-fitting-via-optimization.html
% optimizing: https://cn.mathworks.com/help/matlab/math/optimizing-nonlinear-functions.html
% machine learning: https://cn.mathworks.com/help/stats/nonlinear-regression-1.html
%fun =  @poi(v, V);
load('L-I-20C.mat');
V = [I U P];
v0 = [ 1.246e-3, -2.545e-5, 2.908e-7, -2.531e-10, 1.022e-12, 0.2749, 0.3, 2.6]
%bestx = fminsearch(fun, v0)
mdl = fitnlm(V, P, @poi, v0)
