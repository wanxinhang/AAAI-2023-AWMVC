function [Z] = update_Z(fea,E,Z,H,ZZ,W,alpha,beta,C,num_p)
%UPDATE_Z 此处显示有关此函数的摘要
%   此处显示详细说明
num_view = length(fea);
U = cell(num_p,1);
V = cell(num_p,1);
T = cell(num_p,num_view);
M = cell(num_p,1);
CNT = cell(num_p,1);
for i=1:num_p
    CNT{i} = zeros(size(Z{1},2),size(W{i},1));
    for j=1:num_view
        T{i,j} = fea{j}-E{i,j};
        CNT{i} = CNT{i}+alpha(i)^2*beta{i}(j)^2*T{i,j}'*H{i,j};
    end
    CNT{i} = CNT{i}+C(i)*ZZ'*W{i}';
    [U{i},~,V{i}] = svd(CNT{i},'econ');
    M{i} = U{i}*V{i}';
    Z{i} = M{i}';
end
end
