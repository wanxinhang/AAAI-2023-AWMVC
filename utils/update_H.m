function [H] = update_H(fea,E,Z,H,num_p)
%UPDATE_H �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
num_view = length(fea);
T = cell(num_p,num_view);
for i=1:num_p
    for j=1:num_view
        T{i,j} = fea{j}-E{i,j};
        H{i,j} = T{i,j}*Z{i}';
    end
end
end

