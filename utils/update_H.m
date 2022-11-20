function [H] = update_H(fea,E,Z,H,num_p)
%UPDATE_H 此处显示有关此函数的摘要
%   此处显示详细说明
num_view = length(fea);
T = cell(num_p,num_view);
for i=1:num_p
    for j=1:num_view
        T{i,j} = fea{j}-E{i,j};
        H{i,j} = T{i,j}*Z{i}';
    end
end
end

