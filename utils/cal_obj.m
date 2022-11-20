function [obj] = cal_obj(cnt,cnt1,alpha,beta,C,num_p,num_view)
%CAL_OBJ 此处显示有关此函数的摘要
%   此处显示详细说明
obj=0;
for i=1:num_p
    tmp=0;
    for j=1:num_view
        tmp = tmp+beta{i}(j)^2*cnt(i,j);
    end
    obj = obj+1/2*alpha(i)^2*tmp-C(i)*cnt1(i);
end
end

