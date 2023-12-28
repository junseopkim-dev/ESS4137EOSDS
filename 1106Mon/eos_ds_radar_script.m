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