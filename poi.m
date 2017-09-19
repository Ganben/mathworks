function p_o = poi(v,in)
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
t0 = 20+273;
i = in(:,1); %unit mA
u = in(:,2); %unit V
p = in(:,3); %unit mW

p_o = -eta*(a_0 - i + i_th0 + a_2*(r_th*(p - i.*u) - t0).^2 - a_3*(r_th*(p - i.*u) - t0).^3 + a_4*(r_th*(p - i.*u) - t0).^4 - a_1*(r_th*(p - i.*u) - t0));
end

