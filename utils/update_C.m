function [C] = update_C(cnt1,num_p)
%UPDATE_C 此处显示有关此函数的摘要
%   此处显示详细说明
cnt = 0;
for i=1:num_p
    cnt = cnt+cnt1(i)^2;
end
C = cnt1/sqrt(cnt);
end

