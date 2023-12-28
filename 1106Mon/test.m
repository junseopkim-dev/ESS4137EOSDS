real_filename = 'i_IW2_VV_sub.img';
imag_filename = 'q_IW2_VV_sub.img';

samples = 4000;
lines = 1400;

fid = fopen(real_filename,'rb','l');
iData=fread(fid, [samples lines], 'float32');
iData = iData';
fclose all;

fid = fopen(imag_filename,'rb','l');
qData=fread(fid, [samples lines], 'float32');
qData = qData';
fclose all;

intensity = iData.^2+qData.^2;
intensity(intensity(:)==0)=nan;

amplitude = sqrt(intensity);

phase = atan2(qData,iData);

figure,
imagesc(intensity, [0 1]);
axis image;
colorbar;
colormap("gray");
title('intensity')


figure,
imagesc(phase, [-pi pi]);
axis image;
colorbar;
colormap("parula")
title('phase')

%%
al =1;
rl = 4;

samples2 = samples/rl;
lines2 = lines/al;

mlc = zeros(lines2,samples2);
intensity_mlc = zeros(lines2,samples2);

for ii = 1:lines2,
    for jj = 1:samples2,
        temp_i = iData(al*(ii-1)+1:(al*ii),rl*(jj-1)+1:(jj*rl));
        temp_q = qData(al*(ii-1)+1:(al*ii),rl*(jj-1)+1:(jj*rl)).*j;

        mlc(ii,jj) = sum(temp_i+temp_q)/(al*rl);
        intensity_mlc(ii,jj)=real(mlc(ii,jj)).^2+imag(mlc(ii,jj)).^2;
    end
end



figure,
imagesc(intensity_mlc,[0 1]);
axis image;
colorbar;
colormap("gray");
title('intensity_mlc');

%%
for ii = 2:lines2-1,
    for jj = 2:samples2-1,
        temp = intensity_mlc((ii-1):(ii+1),(jj-1):(jj+1));
        intensity_mlc_med3by3(ii,jj)=median(temp(:));
    end
end

for ii = 2:lines2-1,
    for jj = 2:samples2-1,
        temp = intensity_mlc((ii-1):(ii+1),(jj-1):(jj+1));
        intensity_mlc_med3by3(ii,jj)=median(temp(:))


figure, imagesc(intensity_mlc_med3by3, [0 1]);
axis image;
colorbar;
colormap('gray');
title('mlc_intensity(median 3*3)')

%%
for ii = 5:lines2-4,
    for jj = 5:samples2-4,
        temp = intensity_mlc((ii-4):(ii+4),(jj-4):(jj+4));
        intensity_mlc_med9by9(ii,jj)=median(temp(:));
    end
end

figure, imagesc(intensity_mlc_med9by9, [0 1]);
axis image;
colorbar;
colormap('gray');
title('mlc_intensity(median 9*9)')

intensity_mlc_med3by3_db = 10*log10(intensity_mlc_med3by3);

figure,
imagesc(intensity_mlc_med3by3_db, [-25 0]);
axis image;
colorbar; colormap("gray");
title('mlc_intensity(med3*3)_dB');

%%
figure;
subplot(1,2,1),histogram(intensity_mlc_med3by3(:),'BinLimits',[0 1]);
title('intensity_mlc');
subplot(1,2,2),histogram(intensity_mlc_med3by3_db(:),'BinLimits',[-50 10]);
title('intensity_mlc(db)');

