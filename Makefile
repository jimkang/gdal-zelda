set-base-projection:
	python gdalcopyproj.py NE1_50M_SR_W_tenth.tif zelda-overworld-map.tiff

mercator:
	gdalwarp -t_srs EPSG:3395 -r lanczos -wo SOURCE_EXTRA=1000 -co COMPRESS=LZW -te -180 -88.2 180 88.2 -te_srs EPSG:4326 zelda-overworld-map.tiff zelda-overworld-mercator.tiff

plate-carree:
	gdalwarp -t_srs EPSG:32662 -r lanczos -wo SOURCE_EXTRA=1000 -co COMPRESS=LZW zelda-overworld-map.tiff zelda-overworld-plate-carree.tiff

mollweide:
	gdalwarp -t_srs '+proj=moll +lon_0=0 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs' -r lanczos -dstalpha -wo SOURCE_EXTRA=1000 -co COMPRESS=LZW zelda-overworld-map.tiff zelda-overworld-mollweide.tiff

polar-south:
	gdal_translate -of VRT -projwin -180 -60 180 -90 zelda-overworld-map.tiff zelda-overworld-map-south.vrt
	gdalwarp -t_srs EPSG:3976 -ts 7200 0 -r near -dstalpha -wo SOURCE_EXTRA=1000 -co COMPRESS=LZW zelda-overworld-map-south.vrt zelda-overworld-map-sh60-polarstereo-south.tif
	gdal_translate -of PNG -outsize 1400 0 -r bilinear zelda-overworld-map-sh60-polarstereo-south.tif zelda-overworld-map-sh60-polarstereo-south.png
	rm -f zelda-overworld-map-sh60-polarstereo-south.tif

polar-north:
	rm -f zelda-overworld-map-sh60-polarstereo-north.*
	gdal_translate -of VRT -projwin -180 89 180 60 zelda-overworld-map.tiff zelda-overworld-map-north.vrt
	gdalwarp -t_srs EPSG:3976 -ts 7200 0 -r near -dstalpha -wo SOURCE_EXTRA=1000 -co COMPRESS=LZW zelda-overworld-map-north.vrt zelda-overworld-map-sh60-polarstereo-north.tif
	gdal_translate -of PNG -outsize 1400 0 -r bilinear zelda-overworld-map-sh60-polarstereo-north.tif zelda-overworld-map-sh60-polarstereo-north.png
	rm -f zelda-overworld-map-sh60-polarstereo-north.tif

pushall:
	git push origin gh-pages
