function [alpha] = update_alpha(cnt,beta,num_p,num_view)
%UPDATE_ALPHA �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
tmp = zeros(num_p,1);
for i=1:num_p
    for j=1:num_view
        tmp(i) = tmp(i)+cnt(i,j)*beta{i}(j)^2;
    end
end
tmp = ones(num_p,1)./sqrt(tmp);
total = 0;
for i=1:num_p
    total = total+tmp(i);
end
alpha = tmp/total;
end

