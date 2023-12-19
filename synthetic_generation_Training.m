clear;close all;

ob1 = sparameters('./New_Cable/Cable1.S2P');
ob3 = sparameters('./Test5_intact/CASE18.S2P');

abcd_param_1  = s2abcd(ob1.Parameters, 50);
abcd_param_3  = s2abcd(ob3.Parameters, 50);

A_1=reshape(abcd_param_1(1,1,:),1,[]);
B_1=reshape(abcd_param_1(1,2,:),1,[]);
C_1=reshape(abcd_param_1(2,1,:),1,[]);
D_1=reshape(abcd_param_1(2,2,:),1,[]);

A_3=reshape(abcd_param_3(1,1,:),1,[]);
B_3=reshape(abcd_param_3(1,2,:),1,[]);
C_3=reshape(abcd_param_3(2,1,:),1,[]);
D_3=reshape(abcd_param_3(2,2,:),1,[]);

freq_synthetic=ob1.Frequencies(132:1:541);
n_freq=length(freq_synthetic);

A_1=A_1(132:1:541);
B_1=B_1(132:1:541);
C_1=C_1(132:1:541);
D_1=D_1(132:1:541);

A_3=A_3(132:1:541);
B_3=B_3(132:1:541);
C_3=C_3(132:1:541);
D_3=D_3(132:1:541);

A_0=A_1;
B_0=B_1;
C_0=C_1;
D_0=D_1;

N_sample=20000;
Data_train=zeros(N_sample,n_freq);
%Data_test=zeros(N_sample,n_freq);

for rep=1:1:N_sample   

    ZL1=unifrnd(1,20)*exp(1j*2*pi*unifrnd(0,1));
    ZL2=unifrnd(10,100)*exp(1j*2*pi*unifrnd(0,1));
    
    file_number=randi(8)+11;
    file_name=sprintf('./Test5_intact/CASE%d.S2P',file_number);
    ob2 = sparameters(file_name);
    abcd_param_2  = s2abcd(ob2.Parameters, 50);
    
    A_2=reshape(abcd_param_2(1,1,:),1,[]);
    B_2=reshape(abcd_param_2(1,2,:),1,[]);
    C_2=reshape(abcd_param_2(2,1,:),1,[]);
    D_2=reshape(abcd_param_2(2,2,:),1,[]);
    
    A_2=A_2(132:1:541);
    B_2=B_2(132:1:541);
    C_2=C_2(132:1:541);
    D_2=D_2(132:1:541);
    

    for i=1:1:n_freq
        ABCD_CB=[A_1(i),B_1(i);C_1(i),D_1(i)];
        
        ABCD_CBPBCB=[A_2(i),B_2(i);C_2(i),D_2(i)];
        ABCD_PB=inv(ABCD_CB)*ABCD_CBPBCB*inv(ABCD_CB);
        ABCD_syn=ABCD_CB*ABCD_PB*ABCD_CB;
        
        A_0(i)=ABCD_syn(1,1);
        B_0(i)=ABCD_syn(1,2);
        C_0(i)=ABCD_syn(2,1);
        D_0(i)=ABCD_syn(2,2);
    end
    
    ZL=unifrnd(0,50)+1j*unifrnd(-50,50);
    H_0=ZL./(A_0.*ZL+B_0);
    H_3=ZL./(A_3.*ZL+B_3);
    
    Data_train(rep,:)=abs(H_0);
    %Data_test(rep,:)=abs(H_3);
end

figure;
plot(freq_synthetic/1e6,20*log10(mean(Data_train)));hold on;
%plot(freq_synthetic/1e6,20*log10(Data_train));hold on;
%plot(freq_synthetic/1e6,20*log10(Data_test));
xlabel('Frequencies/MHz');
ylabel('CFR')
%legend('synthetic','measure');
grid on;

%save('generated_train_data_E.mat','Data_train','freq_synthetic','N_sample');

