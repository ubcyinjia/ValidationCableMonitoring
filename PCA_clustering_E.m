clear;

rng("default");
num_component=2;
%num_component=3;

load('./generated_data/generated_train_data_E.mat');
N_train=N_sample;
load('./generated_data/P10/generated_test_data_P10_C12.mat');
N_test=N_sample;

[coeff,score,latent,tsquared,explained,mu] = pca(Data_train);
truncated_coeff=coeff(:,1:1:num_component);

Embedded_train=(Data_train-mu)*truncated_coeff;
clustered_train=dbscan(Embedded_train,0.1,80);
gscatter(Embedded_train(:,1),Embedded_train(:,2),clustered_train);
%scatter3(Embedded_train(:,1),Embedded_train(:,2),...
    %Embedded_train(:,3));%,clustered_train);