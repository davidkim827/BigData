-- Large cities:
(SELECT (STDDEV(c394913)+STDDEV(c753899)+STDDEV(c394463)+STDDEV(c394514)+STDDEV(c394974)+STDDEV(c395209)+STDDEV(c394692)+STDDEV(c394856)+STDDEV(c394347)+STDDEV(c394404))/10 FROM uscities WHERE months >= 201612 and months <= 201712); 

-- Small cities:
(SELECT (STDDEV(c394718)+STDDEV(c395004)+STDDEV(c395236)+STDDEV(c753925)+STDDEV(c753874)+STDDEV(c395130)+STDDEV(c395241)+STDDEV(c395227)+STDDEV(c394418)+STDDEV(c394687))/10 FROM uscities WHERE months >= 201612 and months <= 201712); 