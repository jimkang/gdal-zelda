gdal-zelda
==================

Following along with [Robert Simmon's GDAL articles](https://medium.com/planet-stories/a-gentle-introduction-to-gdal-part-2-map-projections-gdalwarp-e05173bd710a), except in Hyrule.

Legend of Zelda game map rip [found here](http://www.oldgames.sk/en/game/legend-of-zelda/download/9339/), thanks to whoever originally ripped it!

To run gdalwarp to create different projects of your own non-real world maps:
------------

- Clone this repo.
- [Install GDAL.](https://medium.com/planet-stories/a-gentle-introduction-to-gdal-part-1-a3253eb96082)
- Modify `set-base-projection` in the Makefile to use your TIFF file instead of `zelda-overworld-map.tiff`. What `set-base-projection` does is copy projection info from a GeoTIFF file (from Rob Simmon's excellent article), into a non-Geo TIFF file, like the file you probably have. It uses a hacked-up version of `gdalcopyproj.py` to do that. In order to make it work, for your image, you need to modify the `geotransform` tuple in that file.

The second and sixth elements of that tuple are the west-east resolution and the north-south resolution, respectively. If your image is the same size as `NE1_50M_SR_W_tenth.tif` (3600x1800), then the geotransform needs not be changed. If it does not, then you need to set those elements to :

    geotransform = (
        geotransform[0],
        geotransform[1] * 3600/<the width of your image>,
        geotransform[2],
        geotransform[3],
        geotransform[4],
        geotransform[5] * 1800/<the height of your image>
    )

- Then, you can run `make mercator`, `make mollweide`, `make polar-south`, and `make polar-north` to generate the different projections of your image. Read [A Gentle Introduction to GDAL, Part 2](https://medium.com/planet-stories/a-gentle-introduction-to-gdal-part-2-map-projections-gdalwarp-e05173bd710a) to get explanations of the commands in those targets!

License
-------

MIT.
