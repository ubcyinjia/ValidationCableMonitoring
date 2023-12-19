function P_AC=AD_single_load(num_case,num_phase)

rng("default");
%num_case=2;
%num_phase=5;
num_component=10;

if (num_case<10)
    load('./generated_data/generated_train_data_NE_exp.mat');
else
    load('./generated_data/generated_train_data_E_exp.mat');
end
N_train=N_sample;
file_name=sprintf...
        ('./generated_data/P%d/generated_test_data_P%d_C%d.mat'...
        ,num_phase,num_phase,num_case);
load(file_name);
N_test=N_sample;

ind_load=Load_train==num_case;
Data_train=Data_train(ind_load,:);
N_train=length(Data_train);

[coeff,score,latent,tsquared,explained,mu] = pca(Data_train);

truncated_coeff=coeff(:,1:1:num_component);

compressed_score_train=(Data_train-mu)*truncated_coeff;
reconstructed_train=compressed_score_train*truncated_coeff'+mu;
compressed_score_test=(Data_test-mu)*truncated_coeff;
reconstructed_test=compressed_score_test*truncated_coeff'+mu;

freq_length=length(freq_synthetic);

delta_train=Data_train-reconstructed_train;
delta_test=Data_test-reconstructed_test;
error_test=zeros(N_test,1);
error_train=zeros(N_train,1);

Normalizer=mean(std(Data_train'));

for j=1:1:N_train
    error_train(j)=sqrt(delta_train(j,:)*delta_train(j,:)'/freq_length)/Normalizer;   
end  

for j=1:1:N_test
    error_test(j)=sqrt(delta_test(j,:)*delta_test(j,:)'/freq_length)/Normalizer;
end

mean_error_train=mean(error_train);
std_error_train=std(error_train);

Threshold=zeros(1,3);
Threshold(1)=mean_error_train+std_error_train;
Threshold(2)=mean_error_train+2*std_error_train;
Threshold(3)=mean_error_train+3*std_error_train;

P_FA=zeros(1,3);
P_FA(1)=sum(error_train>Threshold(1))/N_train;
P_FA(2)=sum(error_train>Threshold(2))/N_train;
P_FA(3)=sum(error_train>Threshold(3))/N_train;

P_AC=zeros(1,3);
P_AC(1)=sum(error_test>Threshold(1))/N_test;
P_AC(2)=sum(error_test>Threshold(2))/N_test;
P_AC(3)=sum(error_test>Threshold(3))/N_test;

end





