
%problem 1
%{
organize parameters first:
eta = 0.5
i_th0 = 0.3e-3
r_th = 2.6e3*1e-3 (mW~)
a_0 = 1.246e-3
a_1 = -2.545e-5
a_2 = 2.908e-7
a_3 = -2.531e-10
a_4 = 1.022e-12
t_0 = 20 + 273 %K
%}
%the equation can be re-organized by following statements
syms i u p t
syms eta i_th0 r_th a_0 a_1 a_2 a_3 a_4 t_0

exp1 = eta*(i-i_th0-a_0 -a_1*t^1 - a_2*t^2-a_3*t^3 - a_4*t^4 );

exp2 = t_0 + (i*u-p)*r_th;

expr_p = subs(exp1, t, exp2)


%%then we have three way to find the parameters for dataset U I P
% curve fitting: https://cn.mathworks.com/help/matlab/math/example-curve-fitting-via-optimization.html
% optimizing: https://cn.mathworks.com/help/matlab/math/optimizing-nonlinear-functions.html
% machine learning: https://cn.mathworks.com/help/stats/nonlinear-regression-1.html
%fun =  @poi(v, V);

% we choose this method: non linear regression
% https://cn.mathworks.com/help/stats/nonlinear-regression-1.html#btcg0wd
load('L-I-20C.mat');
V = [I U P];
%step 1: use curve fitting toolbox: custom equation to fit the initial eta
%and other parameters, those parameters are (some + original value):
v0 = [ 1.246e-3, -2.545e-5, 2.908e-7, -2.531e-10, 1.022e-12, 0.2749, 0.3, 2.6];
%then use fitnlm nonlinear regression
mdl = fitnlm(V, P, @poi, v0)
%we have get optimized parameters
v_optimized = table2array(mdl.Coefficients(:,1))
%parameter for model 1 (old un improved)
%[0.647406123904325;0.890093081570153;-0.00629197067468293;1.39999580648606e-05;-1.00193267010158e-08;0.118287357618833;0.946159603823576;4.08825381904842]];
%plot t0 =20, for other temp, change t0 in the function 
p20 = poi(v_optimized, V); %result check good
plot(I, p20, I, P)
% we should replace the p and u for the function inputs;
% so defined another func of U = f(I) to derive U
% we use a exponential curve fitting (2-terms) to get this funcs:
% U = 1.973*exp(0.0292*I)- 0.6044*exp(-0.7988*I)
p10 = poi_t(v_optimized, V, 10); %and so on for 30 90, unimproved model
p30 = poi_t(v_optimized, V, 30);
p50 = poi_t(v_optimized, V, 50);
p70 = poi_t(v_optimized, V, 70);
p90 = poi_t(v_optimized, V, 90);

%improvements 1: when the p == 0, the discontinous part can be ripped off;
mdl2 = fitnlm(V(39:end,:), P(39:end), @poi, v_optimized)
v_op2 = table2array(mdl2.Coefficients(:,1));
%[ 0.6437, 0.8178,-0.0060, 1.418e-5, -1.0611e-8, 0.1623,0.9424, 3.2926]
%plot others and find the max t for the question (P<2mW @4-8mA)
resa = zeros(size(I));
for t=60:10:90
    resa = poi_t(v_optimized, V, t); %can change new model's data
    
    if max(resa)<2
        max_temp = t
        break
    end
end
% answer: the max_temp = 90 (old model) 
%answer the max_temp = 60 (new model) use this one
p10i = poi_t(v_op2, V, 10); %and so on for 30 90, improved model
p30i = poi_t(v_op2, V, 30);
p50i = poi_t(v_op2, V, 50);
p70i = poi_t(v_op2, V, 70);
p90i = poi_t(v_op2, V, 90);

%more improvements: add the I U temperature characteristics;


