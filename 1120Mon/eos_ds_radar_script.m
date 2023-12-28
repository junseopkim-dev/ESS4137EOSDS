%%
real_filename = 'i_IW2_VV_sub.img';
imag_filename = 'q_IW2_VV_sub.img';

%%
samples = 4000;
lines = 1400;

%% real part
fid = fopen(real_filename,'rb','l');
iData=fread(fid,[samples lines],'float32');
iData=iData';
fclose all;

%% imaginary part
fid = fopen(imag_filename,'rb','l');
qData = fread(fid,[samples lines], 'float32');
qData = qData';
fclose all;

%% SLC (single look comples) - intensity
Intensity = (iData.^2+qData.^2);
Intensity(Intensity(:)==0) = nan; % 0인 값은 nan으로 만든다.

%% SLC - phase
phase = atan2(qData,iData);

%%
figure;
imagesc(Intensity,[0 1]); 
axis image;
colorbar ;
colormap(gray);
title('SLC-Intensity')

figure;
imagesc(phase,[-pi pi]);
axis image;
colorbar;
colormap(parula);
title('SLC-Phase(radian)')

%% 문제
%{
iData(1400, 4000) %(lines,samples) = (row,col)
qData(1400,4000)

% What is a complex value in row = 100, column = 200?
fprintf('1번 답 :  \n')
iData(100,200)
qData(100,200)


% What is the phase of a complex value at row = 100, column = 200?
fprintf('2번 답 :  \n') 
phase(100,200)


% What is the amplitude of a complex value at row = 100, column = 200?
fprintf('3번 답 :  \n') 
Amplitude = sqrt(qData.^2 + iData.^2);

Amplitude(100,200)
%}

%% 1113Mon, MLC (multi look complex) intensity 
rl=4; % number_of_range_looks
al=1; % number_of_azimuth_looks

samples2=samples/rl;
lines2=lines/al; 

mlc=zeros(lines2,samples2);
Intensity_mlc=zeros(lines2,samples2);

for ii=1:lines2,
    for jj=1:samples2,
        temp_i=iData(al*(ii-1)+1:al*ii,rl*(jj-1)+1:rl*jj);
        temp_q=qData(al*(ii-1)+1:al*ii,rl*(jj-1)+1:rl*jj).*j;

        mlc(ii,jj)=sum(temp_i + temp_q)/(rl*al);
        Intensity_mlc(ii,jj)= real(mlc(ii,jj)).^2 + imag(mlc(ii,jj)).^2;
    end
end

figure,imagesc(Intensity_mlc,[0 1]);
axis image;
colorbar;colormap(gray);
title('MLC-Intensity')

%% filtering (median 3by3)
Intensity_mlc_med3by3=zeros(lines2,samples2);
for ii=2:lines2-1,
    for jj=2:samples2-1,
        temp=Intensity_mlc(ii-1:ii+1,jj-1:jj+1);
        Intensity_mlc_med3by3(ii,jj)=median(temp(:));
    end
end
figure,imagesc(Intensity_mlc_med3by3,[0 1]); axis image;
colorbar;colormap(gray);
title('MLC-Intensity(median 3by3)')

%% 문제
% What is the value of Intensity(1000,600)?
fprintf('1번 답 :  %.8f \n',Intensity(1000,600))
Intensity(1000,600)

% What is the value of Intensity_mlc(1000,600)?
fprintf('2번 답 :  %.8f \n',Intensity_mlc(1000,600))
Intensity_mlc(1000,600)

% What is the value of Intensity_mlc(1000,600)?
fprintf('3번 답 :  %.8f \n',Intensity_mlc_med3by3(1000,600))
Intensity_mlc_med3by3(1000,600)

%% 11월 20일 수업

%% filtering (median 9 by 9)
Intensity_mlc_med9by9=zeros(lines2,samples2);

for ii=5:lines2-4,
    for jj=5:samples2-4,
        temp=Intensity_mlc(ii-4:ii+4,jj-4:jj+4);
        Intensity_mlc_med9by9(ii,jj)=median(temp(:));
    end
end

figure,imagesc(Intensity_mlc_med9by9,[0 1]); axis image;
colorbar;colormap(gray);
title('MLC-Intensity(median 9by9)')

%% filtering (median 5 by 5)
Intensity_mlc_med5by5=zeros(lines2,samples2);

for ii=3:lines2-2,
    for jj=3:samples2-2,
        temp=Intensity_mlc(ii-2:ii+2,jj-2:jj+2);
        Intensity_mlc_med5by5(ii,jj)=median(temp(:));
    end
end

figure,imagesc(Intensity_mlc_med5by5,[0 1]); axis image;
colorbar;colormap(gray);
title('MLC-Intensity(median 5by5)')

%% conversion to dB
Intensity_mlc_med5by5_dB = 10*log10(Intensity_mlc_med5by5);

figure,imagesc(Intensity_mlc_med5by5_dB,[-25 0]); axis image;
colorbar;colormap(gray);
title('MLC-Intensity(median 5by5)(dB)')

%% histogram
figure;
subplot(1,2,1),histogram(Intensity_mlc_med5by5(:),'BinLimits',[0 1]);
title('Intensity-MLC (median 5*5)')
subplot(1,2,2),histogram(Intensity_mlc_med5by5_dB(:),'BinLimits',[-50 10]);
title('Intensity-MLC (dB)')

%% 문제 

% What is your radar viewing geometry??
% 원본과 비교했을 때, 상화 뒤집힌 상태.
%Ascending, right-side looking

% What is the value of Intensity_mlc_med5by5(1000,600)?
fprintf('2번 답 :  %.8f \n',Intensity_mlc_med5by5(1000,600))
Intensity_mlc_med5by5(1000,600)

% What is the value of Intensity_mlc_med5by5_dB(1000,600)?
fprintf('3번 답 :  %.8f \n',Intensity_mlc_med5by5_dB(1000,600))
Intensity_mlc_med5by5_dB(1000,600)