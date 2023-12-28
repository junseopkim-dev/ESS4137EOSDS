%% 1교시
cd C:\Users\kjs\Documents\3-2\EOSDS\practice\subset_0_of_LC09_L1TP_114036_20230805_20230805_02_T1
filename = 'subset_0_of_LC09_L1TP_114036_20230805_20230805_02_T1.tif';

[data,R] = readgeoraster(filename);

data=double(data);

RADIANCE_MULT_BAND_2 = 1.2488E-02;
RADIANCE_MULT_BAND_3 = 1.1521E-02;
RADIANCE_MULT_BAND_4 = 9.7065E-03;

RADIANCE_ADD_BAND_2 = -62.44108;
RADIANCE_ADD_BAND_3 = -57.60534;
RADIANCE_ADD_BAND_4 = -48.53228;

blue_rad=data(:,:,1)*RADIANCE_MULT_BAND_2+RADIANCE_ADD_BAND_2;
green_rad=data(:,:,2)*RADIANCE_MULT_BAND_3+RADIANCE_ADD_BAND_3;
red_rad=data(:,:,3)*RADIANCE_MULT_BAND_4+RADIANCE_ADD_BAND_4;



%map information
info = geotiffinfo(filename);
[AY,AX,Z] = size(data);
height = info.Height;
width = info.Width;
[rows,cols] = meshgrid(1:height,1:width);
[x,y] = pix2map(info.RefMatrix,rows,cols);
[lat,lon] = projinv(info,x,y);

figure,imagesc(lon(:,1),lat(1,:),blue_rad,[0 100]), colorbar, colormap(gray);
axis xy;
xlabel('longiude');
ylabel('latitude');
title('Radiance (blue band)');

%% write binary file(BGR_BSQ.img)
filename = 'BGR_BSQ.img';

dataBSQ = [blue_rad;green_rad;red_rad];

figure,imagesc(dataBSQ,[0 100]), colorbar, colormap(gray); axis image

fid =fopen('dataBSQ.img','wb','b');
fwrite(fid,dataBSQ','float32');
fclose all;

%위 값들 바탕으로 "dataBSQ.hdr" 직접 수동으로 작성.
% float32 => data type =4
% fid=fopen....'b' => byte order =1 //big endian
% blue.hdr 파일 복붙 후 수정하면 좀 더 쉽게 가능

%% 2교시

cd ./Vectorfiles/
ls
S=shaperead('geoje.shp');
whos S
S(1)

%------------------------------------------------

figure,imagesc(lon(:,1),lat(1,:),blue_rad,[0 100]), colorbar, colormap(gray);axis xy;
xlabel('longitude');ylabel('latitute');title('Radiance (blue band)');

hold on, plot(S(157).X,S(157).Y,'b-','linewidth',2);

%------------------------------------------------

in=inpolygon(lon,lat,S(157).X,S(157).Y); 
in=in';
figure, imagesc(in),colorbar

%------------------------------------------------

in = double(in);
in(in==0)=nan;
green_rad_ROI=green_rad.*in;

figure,imagesc(green_rad_ROI,[0 100]),colorbar,colormap(gray);%axis xy;

nanmean(green_rad_ROI(:))

cd C:\Users\kjs\Documents\3-2\EOSDS\practice\subset_0_of_LC09_L1TP_114036_20230805_20230805_02_T1
