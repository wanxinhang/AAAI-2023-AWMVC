function [ZZ] = update_ZZ(Z,W,C,num_p,num_view)
%UPDATE_ZZ 此处显示有关此函数的摘要
%   此处显示详细说明
cnt = zeros(size(Z{1},2),size(W{1},2));
for i=1:num_p
    cnt = cnt+C(i)*Z{i}'*W{i};
end
[U,~,V] = svd(cnt,'econ');
M = U*V';
ZZ = M';
    
end

