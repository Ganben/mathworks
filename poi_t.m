function p_o = poi(v,in, t)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
a_0 = v(1);
a_1 = v(2);
a_2 = v(3);
a_3 = v(4);
a_4 = v(5);
eta = v(6);
i_th0 = v(7);
r_th = v(8); %unit C/mW
t0 = 273+t; %can be updated by parameter passing;
i = in(:,1); %unit mA
%u = in(:,2); %unit V
%p = in(:,3); %unit mW
u = 1.973*exp(0.0292*i)- 0.6044*exp(-0.7988*i); % derived from curve fitting
syms p;
p_o = zeros(size(i));
for n=1:size(i);
    %for each i u value we solve the equation of p
    if i(n) <= 0.38
        continue
    end
    assume(p, 'real'); %solve in real
    eqn = p == -eta*(a_0 - i(n) + i_th0 + a_2*(r_th*(p - i(n)*u(n)) - t0)^2 - a_3*(r_th*(p - i(n)*u(n)) - t0)^3 + a_4*(r_th*(p - i(n)*u(n)) - t0)^4 - a_1*(r_th*(p - i(n)*u(n)) - t0));
    Sv = vpasolve(eqn, p, [0 4]); %constrain the possible result range
    if Sv
        p_o(n) = Sv;
    end
end

end

