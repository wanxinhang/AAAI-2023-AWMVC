function [ZZ] = update_ZZ(Z,W,C,num_p,num_view)
%UPDATE_ZZ �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
cnt = zeros(size(Z{1},2),size(W{1},2));
for i=1:num_p
    cnt = cnt+C(i)*Z{i}'*W{i};
end
[U,~,V] = svd(cnt,'econ');
M = U*V';
ZZ = M';
    
end

