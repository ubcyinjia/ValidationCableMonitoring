clear;

num_component=20;

load('./generated_data/generated_train_data_E.mat');
N_train=N_sample;
load('./generated_data/P10/generated_test_data_P10_C12_2.mat');
N_test=N_sample;

[coeff,score,latent,tsquared,explained,mu] = pca(Data_train);

truncated_coeff=coeff(:,1:1:num_component);

compressed_score_train=(Data_train-mu)*truncated_coeff;
reconstructed_train=compressed_score_train*truncated_coeff'+mu;

compressed_score_test=(Data_test-mu)*truncated_coeff;
reconstructed_test=compressed_score_test*truncated_coeff'+mu;
    

delta_train=Data_train-reconstructed_train;
delta_test=Data_test-reconstructed_test;

freq_length=length(freq_synthetic);

error_train=zeros(N_train,1);
error_test=zeros(N_test,1);

Normalizer=mean(std(Data_train'));

for j=1:1:N_train
    error_train(j)=sqrt(delta_train(j,:)*delta_train(j,:)'/freq_length)/Normalizer;   
end    
    
for j=1:1:N_test
    error_test(j)=sqrt(delta_test(j,:)*delta_test(j,:)'/freq_length)/Normalizer;
end
    
result_error_train=sum(error_train)/N_train
result_error_test=sum(error_test)/N_test