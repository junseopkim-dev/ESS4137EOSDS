cd C:\Users\kjs\Documents\3-2\EOSDS\practice\subset_0_of_LC09_L1TP_114036_20230805_20230805_02_T1

%% 방법 1 : green.img 이용

ls %현재 디렉토리 내 파일 목록 출력

% * 방법 1 : green.img 이용
filename='green.img';
%'filename'이라는 변수에 'green.img'라는 문자열 저장

fid = fopen(filename,'rb','b');
%'fid'라는 변수에 fopen함수에 'filename', 'rb', 'b' 입력해 나온 return값 저장.
%'rb' = read binary, 'b' = big endian

fid

% fid = 3이라면, 문제없음 의미

%samples, lines 값은 'green.hdr'파일로부터 확인
samples = 1500;
lines = 1000;
green_dn=fread(fid,[samples lines],'uint16');
%'green_dn' 변수 선언. target = 변수명 'fid', matrix = [samples lines], 정확도 : 'uint16'
green_dn=green_dn';
%매트랩 특성상 값을 세로로 읽는 경향 때문에, 전치행렬로 변환해주는 작업 필요(Transpose)


fclose all;
%green의 채널값은 3, 찾고자 하는 값은 reflectance이므로,
% 'LC09_L1TP_114036_20230805_20230805_02_T1_MTL.txt'파일로부터
% 'REFLECTANCE_ADD_BAND_3', 'REFLECTANCE_MULT_BAND_3' 값 찾아내 입력
REFLECTANCE_ADD_BAND_3 = -0.100000;
REFLECTANCE_MULT_BAND_3 = 2.0000E-05;
%공식 적용
green_ref = green_dn*REFLECTANCE_MULT_BAND_3+REFLECTANCE_ADD_BAND_3;
%출력

figure, imagesc(green_ref,[0 0.3]), colorbar, colormap(gray);
% green.img를 이용해 green의 reflectance 출력 완료

%% * 방법 2 : tif 이용

ls %현재 디렉토리 내 파일 목록 출력

filename='subset_0_of_LC09_L1TP_114036_20230805_20230805_02_T1.tif';
% 'subset_0_of_LC09_L1TP_114036_20230805_20230805_02_T1.tif'파일 사용

[data,R]=readgeoraster(filename);
%[data, R] => 데이터, 헤더파일

data=double(data);
% ★ 중요. data에 double 씌우기

whos
%data가 uint16에서 double로 변환됨 확인가능.

green_ref=(data(:,:,2)*REFLECTANCE_MULT_BAND_3+REFLECTANCE_ADD_BAND_3);
%공식 적용 data(:,:,2)로 적용하는 것에 유의, 숫자 2의 의미 : LANDSAT8의 첫번째는 coastal aerosol,
%블루부터 저장하므로 3-1

figure,imagesc(green_ref,[0 0.3]),colorbar,colormap(gray);
%이미지 출력, map 정보 X

%map information 입력
info = geotiffinfo(filename);
[AY,AX,Z]=size(data);
height = info.Height;
width = info.Width;
[rows,cols] = meshgrid(1:height,1:width);
[x,y] = pix2map(info.RefMatrix,rows,cols);
[lat,lon] = projinv(info,x,y);
%------------정보입력완료--------------


figure,imagesc(lon(:,1),lat(1,:),green_ref,[0 0.3]), colorbar, colormap(gray); axis xy;
% 이미지 출력, 이때 위도, 경도에 대한 정보 추가된 것 확인 가능
xlabel('longitude');ylabel('latitute');title('Reflectance (green band)');
%이미지 출력, 이때 위도, 경도에 대한 정보 및 축 제목, 큰 제목 추가된 것 확인 가능