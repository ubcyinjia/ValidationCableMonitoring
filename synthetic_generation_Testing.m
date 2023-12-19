clear;close all;

phase_number=5;

%for case_number=12:1:19
for case_number=2:1:9    


    ob3 = sparameters(sprintf('./Test%d_intact/CASE%d.S2P',phase_number,case_number));
    file_name=sprintf('generated_test_data_P%d_C%d.mat',phase_number,case_number);
    abcd_param_3  = s2abcd(ob3.Parameters, 50);

    A_3=reshape(abcd_param_3(1,1,:),1,[]);
    B_3=reshape(abcd_param_3(1,2,:),1,[]);
    C_3=reshape(abcd_param_3(2,1,:),1,[]);
    D_3=reshape(abcd_param_3(2,2,:),1,[]);

    freq_synthetic=ob3.Frequencies(132:1:541);
    n_freq=length(freq_synthetic);

    A_3=A_3(132:1:541);
    B_3=B_3(132:1:541);
    C_3=C_3(132:1:541);
    D_3=D_3(132:1:541);

    N_sample=5000;
    Data_test=zeros(N_sample,n_freq);

    for rep=1:1:N_sample
    
        ZL=unifrnd(0,50)+1j*unifrnd(-50,50);
        H_3=ZL./(A_3.*ZL+B_3);
    
        Data_test(rep,:)=abs(H_3);
    end

    save(file_name,'Data_test','freq_synthetic','N_sample');

end
