function [C] = update_C(cnt1,num_p)
%UPDATE_C �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
cnt = 0;
for i=1:num_p
    cnt = cnt+cnt1(i)^2;
end
C = cnt1/sqrt(cnt);
end

