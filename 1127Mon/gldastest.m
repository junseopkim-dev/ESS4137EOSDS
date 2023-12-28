datainfo=ncinfo('GLDAS_NOAH025_M.A202102.021.nc4');

lat = ncread('GLDAS_NOAH025_M.A202102.021.nc4','lat');
lon = ncread('GLDAS_NOAH025_M.A202102.021.nc4','lon');

lat2 = lat * ones(1, 1440);

lon2 = ones(600,1)*lon';

rn = ncread('GLDAS_NOAH025_M.A202102.021.nc4','Rainf_tavg');
rn=rn';

figure,geoshow(lat2,lon2,rn,'displaytype','surface');
colorbar; axis([-180 180 -60 90]);
box on;
xlabel('lon');
