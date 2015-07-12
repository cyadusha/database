-- Schema: public

-- DROP SCHEMA public;

CREATE SCHEMA public
  AUTHORIZATION postgres;

GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO public;
COMMENT ON SCHEMA public
  IS 'standard public schema';

--1.
SELECT weather.origin, dep_delay, temp, dewp, humid, wind_dir, wind_speed, wind_gust, precip, pressure, visib
FROM flights JOIN weather
ON flights.year = weather.year AND flights.month = weather.month AND flights.day = weather.day AND flights.hour = weather.hour AND flights.origin = weather.origin
WHERE dep_delay > 0 
GROUP BY weather.origin, dep_delay, temp, dewp, humid, wind_dir, wind_speed, wind_gust, precip, pressure, visib
-- The weather conditions associated with the New York City departure delays are dew point, temperature, humidity, wind gust, wind speed, and wind direction.
-- However, in LaGuardia airport, the delays are all different integer numbers. However, the dew point, temperature, humidity, wind gust, wind speed, and wind direction 
-- are the same for all the flights listed.    
--2.
SELECT planes.tailnum, dep_delay, planes.year, COUNT (*) 
FROM flights JOIN planes
ON flights.tailnum = planes.tailnum
WHERE dep_delay > 0
GROUP BY planes.tailnum, dep_delay, planes.year
ORDER BY planes.year
-- Older planes are actually less likely to be delayed because there are more planes that are recently manufactured that get delayed. 

--3. How many flights have landed at a destination that is at a high altitude, meaning greater than or equal
-----to 1,000?

SELECT flights.dest, airports.alt, COUNT(*) 
FROM flights JOIN airports
ON flights.dest = airports.faa
WHERE alt >= 1000
GROUP BY alt, dest
ORDER BY alt, dest 
