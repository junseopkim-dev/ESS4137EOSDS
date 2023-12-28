%% read nc_data
dataInfo = ncinfo('GLDAS_NOAH025_M.A202102.021.nc4');

%% lat & lon

lat = ncread('GLDAS_NOAH025_M.A202102.021.nc4','lat');
lon = ncread('GLDAS_NOAH025_M.A202102.021.nc4','lon');

lat2 = lat * ones(1,1440);
lon2 = ones(600,1)*lon';

%% read rain precipitation rate
rn=ncread('GLDAS_NOAH025_M.A202102.021.nc4','Rainf_tavg');
rn = rn';

%% plot rain precipitation rate

figure, geoshow(lat2,lon2,rn,'displaytype','surface');
colorbar; axis([-180 180 -60 90]); box on;
xlabel('Longitude'),ylabel('Latitude');
title('Rain Precipiitation rate (kg m-2 s-1)');

%% 1-1 SoilMoi0_10cm_inst

%% read SoilMoi0_10cm_inst
rn1=ncread('GLDAS_NOAH025_M.A202102.021.nc4','SoilMoi0_10cm_inst');
rn1 = rn1';

%% plot SoilMoi0_10cm_inst

figure, geoshow(lat2,lon2,rn1,'displaytype','surface');
colorbar; axis([-180 180 -60 90]); box on;
xlabel('Longitude'),ylabel('Latitude');
title('SoilMoi0_10cm_inst');

%% 1-2 'SoilMoi10_40cm_inst'

%% read 'SoilMoi10_40cm_inst'
rn2=ncread('GLDAS_NOAH025_M.A202102.021.nc4','SoilMoi10_40cm_inst');
rn2 = rn2';

%% plot SoilMoi0_10cm_inst

figure, geoshow(lat2,lon2,rn2,'displaytype','surface');
colorbar; axis([-180 180 -60 90]); box on;
xlabel('Longitude'),ylabel('Latitude');
title('SoilMoi10_40cm_inst');

%% 1-3 'SoilMoi40_100cm_inst'

%% read 'SoilMoi40_100cm_inst'
rn3=ncread('GLDAS_NOAH025_M.A202102.021.nc4','SoilMoi40_100cm_inst');
rn3 = rn3';

%% plot 'SoilMoi40_100cm_inst'

figure, geoshow(lat2,lon2,rn3,'displaytype','surface');
colorbar; axis([-180 180 -60 90]); box on;
xlabel('Longitude'),ylabel('Latitude');
title('SoilMoi40_100cm_inst');


%% 1-4 'SoilMoi100_200cm_inst'

%% read 'SoilMoi100_200cm_inst'
rn4=ncread('GLDAS_NOAH025_M.A202102.021.nc4','SoilMoi100_200cm_inst');
rn4 = rn4';

%% plot 'SoilMoi100_200cm_inst'

figure, geoshow(lat2,lon2,rn4,'displaytype','surface');
colorbar; axis([-180 180 -60 90]); box on;
xlabel('Longitude'),ylabel('Latitude');
title('SoilMoi100_200cm_inst');




%% 2-1 'SoilTMP0_10cm_inst'

%% read 'SoilTMP0_10cm_inst'
rn5=ncread('GLDAS_NOAH025_M.A202102.021.nc4','SoilTMP0_10cm_inst');
rn5 = rn5';

%% plot 'SoilTMP0_10cm_inst'

figure, geoshow(lat2,lon2,rn5,'displaytype','surface');
colorbar; axis([-180 180 -60 90]); box on;
xlabel('Longitude'),ylabel('Latitude');
title('SoilTMP0_10cm_inst');

%% 2-2 'SoilTMP10_40cm_inst'

%% read 'SoilTMP10_40cm_inst'
rn6=ncread('GLDAS_NOAH025_M.A202102.021.nc4','SoilTMP10_40cm_inst');
rn6 = rn6';

%% plot 'SoilTMP10_40cm_inst'

figure, geoshow(lat2,lon2,rn6,'displaytype','surface');
colorbar; axis([-180 180 -60 90]); box on;
xlabel('Longitude'),ylabel('Latitude');
title('SoilTMP10_40cm_inst');

%% 2-3 'SoilTMP40_100cm_inst'

%% read 'SoilTMP40_100cm_inst'
rn7=ncread('GLDAS_NOAH025_M.A202102.021.nc4','SoilTMP40_100cm_inst');
rn7 = rn7';

%% plot 'SoilTMP10_40cm_inst'

figure, geoshow(lat2,lon2,rn7,'displaytype','surface');
colorbar; axis([-180 180 -60 90]); box on;
xlabel('Longitude'),ylabel('Latitude');
title('SoilTMP40_100cm_inst');


%% 2-4 'SoilTMP100_200cm_inst'

%% read 'SoilTMP100_200cm_inst'
rn8=ncread('GLDAS_NOAH025_M.A202102.021.nc4','SoilTMP100_200cm_inst');
rn8 = rn8';

%% plot 'SoilTMP100_200cm_inst'

figure, geoshow(lat2,lon2,rn8,'displaytype','surface');
colorbar; axis([-180 180 -60 90]); box on;
xlabel('Longitude'),ylabel('Latitude');
title('SoilTMP100_200cm_inst');