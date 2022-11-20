function [W] = update_W(Z,ZZ,W,num_p)
%UPDATE_W 此处显示有关此函数的摘要
%   此处显示详细说明
U = cell(num_p,1);
V = cell(num_p,1);
T = cell(num_p,1);
for i=1:num_p
    T{i} = Z{i}*ZZ';
    [U{i},~,V{i}] = svd(T{i},'econ');
    W{i} = U{i}*V{i}';
end

