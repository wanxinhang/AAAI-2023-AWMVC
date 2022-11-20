function [E] = update_E(fea,E,Z,H,alpha,beta,num_p,lambda)
%UPDATE_E 此处显示有关此函数的摘要
%   此处显示详细说明
num_view = length(fea);
G = cell(num_p,1);
for i=1:num_p
    for j=1:num_view
        G{i,j} = fea{j}-H{i,j}*Z{j};
        E{i,j} = solve_l1l2(G{i,j},);
end

