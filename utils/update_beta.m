function [beta] = update_beta(cnt,beta,num_p,num_view)
%UPDATE_BETA �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
% size(cnt)
for i=1:num_p
    tmp = cnt(i,:);
    size(tmp)
    tmp = ones(num_view,1)'./sqrt(tmp);
    size(tmp)
    total=0;
    for j=1:num_view
        total=total+tmp(j);
    end
    beta{i}=tmp/total;
end  
end
