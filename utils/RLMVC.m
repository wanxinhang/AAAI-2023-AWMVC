function [ZZ,obj,alpha,beta,C] = RLMVC(fea,num_cluster,num_p,lambda)
%OPM 此处显示有关此函数的摘要
%   此处显示详细说明
maxIter = 100;
num_view = length(fea);
num_sample = size(fea{1},2);

% initialize alpha,H,W,Y,D
alpha = ones(num_p,1)/num_p;
beta = cell(num_p,1);
C = ones(num_p,1)*sqrt(1/num_p);
Z = cell(num_p,1);
E = cell(num_p,num_view);
H = cell(num_p,num_view);
W = cell(num_p,1);
cnt = zeros(num_p,num_view);
cnt1 = ones(num_p,1);
ZZ = zeros(num_cluster,num_sample);
for i=1:num_p
    beta{i} = ones(num_view,1)/num_view;
    Z{i} = zeros(i*num_cluster,num_sample);
    W{i} = zeros(i*num_cluster,num_cluster);
    for j=1:num_cluster
        W{i}(j,j)=1;
    end
    if i*num_cluster<=num_sample
        for j=1:i*num_cluster
            Z{i}(j,j)=1;
        end
    else
        for j=1:num_sample
            Z{i}(j,j)=1;
        end
    end
    for j=1:num_view
        E{i,j} = zeros(size(fea{j},1),num_sample);
    end
end
% initialization end

flag = 1;
iter = 0;
%%
while flag
    iter = iter + 1
    % optimize M
%     if iter>=2
%         cal_obj(fea,alpha,H,Y,D,W,M,num_p,num_cluster,lambda)
%     end
    H = update_H(fea,E,Z,H,num_p);
    ZZ = update_ZZ(Z,W,C,num_p,num_view);
    W = update_W(Z,ZZ,W,num_p);
    Z = update_Z(fea,E,Z,H,ZZ,W,alpha,beta,C,num_p);
    for i=1:num_p
        cnt1(i) = trace(W{i}*ZZ*Z{i}');
        for j=1:num_view
            cnt(i,j) = sum(sum((fea{j}-H{i,j}*Z{i}-E{i,j}).^2));
        end
    end
%     cal_obj(cnt,cnt1,alpha,beta,C,num_p,num_view)
%     beta = update_beta(cnt,beta,num_p,num_view);
%     cal_obj(cnt,cnt1,alpha,beta,C,num_p,num_view)
    alpha = update_alpha(cnt,beta,num_p,num_view);
    cnt_tmp1= cal_obj(cnt,cnt1,alpha,beta,C,num_p,num_view);
    C = update_C(cnt1,num_p);
    cnt_tmp2= cal_obj(cnt,cnt1,alpha,beta,C,num_p,num_view);
   cnt_tmp1-cnt_tmp2
    obj(iter) = cal_obj(cnt,cnt1,alpha,beta,C,num_p,num_view);
    if (iter>2) && (abs((obj(iter)-obj(iter-1))/(obj(iter)))<1e-5 || iter>maxIter)
        flag =0;
    end
end
end

