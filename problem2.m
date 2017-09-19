
%problem 2
load('S21_5.mat')


syms Y Z
syms f real
syms tao_p tao_n epsi P_s N_s N_0 k beta G_0 N_s
syms q I_cur eta_i
%exp H(f)
exp1 = Z/((j*2*pi*f)^2 + (j*2*pi*f)*Y + Z)
%exp Y
exp2 = 1/tao_p + 1/tao_n + G_0*P_s/(k+epsi*P_s) -
G_0(N_s-N_0)/(1+epsi*P_s/k)^2
%exp Z
epx3 = 1/(tao_p*tao_n) + G_0*P_s/(tao_p*(k+epsi*P_s)) -
(1-beta)*G_0*(N_s-N_0)/(tao_n*(1+epsi*P_s/k)^2)
% constants:
q = 1.6e-19;

%recommendated values:
eta_i = 0.7;
beta = 1e5;
tao_n = 9.6e-9;
k = 1.5e-8;
G_0 = 1.8e6;
N_0 = 4.97e5;
tao_p = 3.8e-12;
epsi = 4.7e-8;

I_b = 7.5mA %, we get P_0 from problem 1:
P_0 = 1.904mW
%
P_s = P_0;

%}expr for N_s
exp4 = (P_0/(k*tao_p) + G_0*N_0*P_0/(k+epsi*P_0))/(beta/tao_n + G_0*P_0/(k+epsi*P_0)); 

%I_cur expr
exp5 = q/eta_i*(N_s/tao_n + G_0*(N_s - N_0)*P_0/(k + epsi*P_0)) + i_th0 + a_0  + a_1*t^1 + a_2*t^2 + a_3*t^3 + a_4*t^4 ;

%S_s
exp6 =( eta_i*(i - ( i_th0 + a_0  + a_1*t^1 + a_2*t^2 + a_3*t^3 + a_4*t^4))/q - N_s/tao_n )/(G_0*(N_s - N_0));

%according to diagram, lets assume it's single pole model first: https://zh.wikipedia.org/wiki/%E6%B3%A2%E5%BE%B7%E5%9C%96
semilogx(f, S21);
%a pole of the single model can derive:
eqn1 = 1/(2*pi*Y) == 10e10;
% from which can determine 


