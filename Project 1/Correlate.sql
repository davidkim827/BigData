CREATE TABLE CORRELATE (
	SizeRank DECIMAL(15,4)
);

LOAD DATA LOCAL INFILE '/home/2019/nyu/spring/6513/keh384/P1/SizeRankings.csv' INTO TABLE CORRELATE FIELDS TERMINATED BY ',' ENCLOSED BY '\"' LINES TERMINATED BY '\n' IGNORE 1 LINES;

DELETE FROM CORRELATE WHERE (select MOD(SizeRank,4))!=1;

ALTER TABLE CORRELATE ADD SizeRanki DECIMAL(15,4);

SET @SIZERANKAVG = (SELECT AVG(SizeRank) FROM CORRELATE);

UPDATE CORRELATE 
SET SizeRanki = SizeRank - @SIZERANKAVG;

ALTER TABLE CORRELATE ADD SizeRankCol VARCHAR(10);

UPDATE CORRELATE
SET SizeRankCol = CONCAT('c',CAST(SizeRank AS UNSIGNED));

CREATE TABLE CORRELATEX (c1 DECIMAL(15,4), c5 DECIMAL(15,4), c9 DECIMAL(15,4), c13 DECIMAL(15,4), c17 DECIMAL(15,4), c21 DECIMAL(15,4), c25 DECIMAL(15,4), c29 DECIMAL(15,4), c33 DECIMAL(15,4), c37 DECIMAL(15,4), c41 DECIMAL(15,4), c45 DECIMAL(15,4), c49 DECIMAL(15,4), c53 DECIMAL(15,4), c57 DECIMAL(15,4), c61 DECIMAL(15,4), c65 DECIMAL(15,4), c69 DECIMAL(15,4), c73 DECIMAL(15,4), c77 DECIMAL(15,4), c81 DECIMAL(15,4), c85 DECIMAL(15,4), c89 DECIMAL(15,4), c93 DECIMAL(15,4), c97 DECIMAL(15,4), c101 DECIMAL(15,4), c105 DECIMAL(15,4), c109 DECIMAL(15,4), c113 DECIMAL(15,4), c117 DECIMAL(15,4), c121 DECIMAL(15,4), c125 DECIMAL(15,4), c129 DECIMAL(15,4), c133 DECIMAL(15,4), c137 DECIMAL(15,4), c141 DECIMAL(15,4), c145 DECIMAL(15,4), c149 DECIMAL(15,4), c153 DECIMAL(15,4), c157 DECIMAL(15,4), c161 DECIMAL(15,4), c165 DECIMAL(15,4), c169 DECIMAL(15,4), c173 DECIMAL(15,4), c177 DECIMAL(15,4), c181 DECIMAL(15,4), c185 DECIMAL(15,4), c189 DECIMAL(15,4), c193 DECIMAL(15,4), c197 DECIMAL(15,4), c201 DECIMAL(15,4), c205 DECIMAL(15,4), c209 DECIMAL(15,4), c213 DECIMAL(15,4), c217 DECIMAL(15,4), c221 DECIMAL(15,4), c225 DECIMAL(15,4), c229 DECIMAL(15,4), c233 DECIMAL(15,4), c237 DECIMAL(15,4), c241 DECIMAL(15,4), c245 DECIMAL(15,4), c249 DECIMAL(15,4), c253 DECIMAL(15,4), c257 DECIMAL(15,4), c261 DECIMAL(15,4), c265 DECIMAL(15,4), c269 DECIMAL(15,4), c273 DECIMAL(15,4), c277 DECIMAL(15,4), c281 DECIMAL(15,4), c285 DECIMAL(15,4), c289 DECIMAL(15,4), c293 DECIMAL(15,4), c297 DECIMAL(15,4), c301 DECIMAL(15,4), c305 DECIMAL(15,4), c309 DECIMAL(15,4), c313 DECIMAL(15,4), c317 DECIMAL(15,4), c321 DECIMAL(15,4), c325 DECIMAL(15,4), c329 DECIMAL(15,4), c333 DECIMAL(15,4), c337 DECIMAL(15,4), c341 DECIMAL(15,4), c345 DECIMAL(15,4), c349 DECIMAL(15,4), c353 DECIMAL(15,4), c357 DECIMAL(15,4), c361 DECIMAL(15,4), c365 DECIMAL(15,4), c369 DECIMAL(15,4), c373 DECIMAL(15,4), c377 DECIMAL(15,4), c381 DECIMAL(15,4), c385 DECIMAL(15,4), c389 DECIMAL(15,4), c393 DECIMAL(15,4), c397 DECIMAL(15,4), c401 DECIMAL(15,4), c405 DECIMAL(15,4), c409 DECIMAL(15,4), c413 DECIMAL(15,4), c417 DECIMAL(15,4), c421 DECIMAL(15,4), c425 DECIMAL(15,4), c429 DECIMAL(15,4), c433 DECIMAL(15,4), c437 DECIMAL(15,4), c441 DECIMAL(15,4), c445 DECIMAL(15,4), c449 DECIMAL(15,4), c453 DECIMAL(15,4), c457 DECIMAL(15,4), c461 DECIMAL(15,4), c465 DECIMAL(15,4), c469 DECIMAL(15,4), c473 DECIMAL(15,4), c477 DECIMAL(15,4));

INSERT INTO CORRELATEX SELECT (c394913 - (select avg(c394913) from uscities)) AS yMINybr1, (c394974 - (select avg(c394974) from uscities)) AS yMINybr5, (c394347 - (select avg(c394347) from uscities)) AS yMINybr9, (c394976 - (select avg(c394976) from uscities)) AS yMINybr13, (c395121 - (select avg(c395121) from uscities)) AS yMINybr17, (c394982 - (select avg(c394982) from uscities)) AS yMINybr21, (c395055 - (select avg(c395055) from uscities)) AS yMINybr25, (c394735 - (select avg(c394735) from uscities)) AS yMINybr29, (c395059 - (select avg(c395059) from uscities)) AS yMINybr33, (c394862 - (select avg(c394862) from uscities)) AS yMINybr37, (c394807 - (select avg(c394807) from uscities)) AS yMINybr41, (c394425 - (select avg(c394425) from uscities)) AS yMINybr45, (c395031 - (select avg(c395031) from uscities)) AS yMINybr49, (c394619 - (select avg(c394619) from uscities)) AS yMINybr53, (c394308 - (select avg(c394308) from uscities)) AS yMINybr57, (c394753 - (select avg(c394753) from uscities)) AS yMINybr61, (c394561 - (select avg(c394561) from uscities)) AS yMINybr65, (c394648 - (select avg(c394648) from uscities)) AS yMINybr69, (c395134 - (select avg(c395134) from uscities)) AS yMINybr73, (c395235 - (select avg(c395235) from uscities)) AS yMINybr77, (c394399 - (select avg(c394399) from uscities)) AS yMINybr81, (c394528 - (select avg(c394528) from uscities)) AS yMINybr85, (c395075 - (select avg(c395075) from uscities)) AS yMINybr89, (c395113 - (select avg(c395113) from uscities)) AS yMINybr93, (c394549 - (select avg(c394549) from uscities)) AS yMINybr97, (c394770 - (select avg(c394770) from uscities)) AS yMINybr101, (c395244 - (select avg(c395244) from uscities)) AS yMINybr105, (c394995 - (select avg(c394995) from uscities)) AS yMINybr109, (c395050 - (select avg(c395050) from uscities)) AS yMINybr113, (c394439 - (select avg(c394439) from uscities)) AS yMINybr117, (c394972 - (select avg(c394972) from uscities)) AS yMINybr121, (c395146 - (select avg(c395146) from uscities)) AS yMINybr125, (c394697 - (select avg(c394697) from uscities)) AS yMINybr129, (c394332 - (select avg(c394332) from uscities)) AS yMINybr133, (c395107 - (select avg(c395107) from uscities)) AS yMINybr137, (c395028 - (select avg(c395028) from uscities)) AS yMINybr141, (c394488 - (select avg(c394488) from uscities)) AS yMINybr145, (c394609 - (select avg(c394609) from uscities)) AS yMINybr149, (c394622 - (select avg(c394622) from uscities)) AS yMINybr153, (c394741 - (select avg(c394741) from uscities)) AS yMINybr157, (c394387 - (select avg(c394387) from uscities)) AS yMINybr161, (c753875 - (select avg(c753875) from uscities)) AS yMINybr165, (c395171 - (select avg(c395171) from uscities)) AS yMINybr169, (c394459 - (select avg(c394459) from uscities)) AS yMINybr173, (c395114 - (select avg(c395114) from uscities)) AS yMINybr177, (c395030 - (select avg(c395030) from uscities)) AS yMINybr181, (c394378 - (select avg(c394378) from uscities)) AS yMINybr185, (c394565 - (select avg(c394565) from uscities)) AS yMINybr189, (c395162 - (select avg(c395162) from uscities)) AS yMINybr193, (c394960 - (select avg(c394960) from uscities)) AS yMINybr197, (c395202 - (select avg(c395202) from uscities)) AS yMINybr201, (c394559 - (select avg(c394559) from uscities)) AS yMINybr205, (c394651 - (select avg(c394651) from uscities)) AS yMINybr209, (c394539 - (select avg(c394539) from uscities)) AS yMINybr213, (c395009 - (select avg(c395009) from uscities)) AS yMINybr217, (c394306 - (select avg(c394306) from uscities)) AS yMINybr221, (c395125 - (select avg(c395125) from uscities)) AS yMINybr225, (c394428 - (select avg(c394428) from uscities)) AS yMINybr229, (c394598 - (select avg(c394598) from uscities)) AS yMINybr233, (c394685 - (select avg(c394685) from uscities)) AS yMINybr237, (c394900 - (select avg(c394900) from uscities)) AS yMINybr241, (c395215 - (select avg(c395215) from uscities)) AS yMINybr245, (c395098 - (select avg(c395098) from uscities)) AS yMINybr249, (c395232 - (select avg(c395232) from uscities)) AS yMINybr253, (c394802 - (select avg(c394802) from uscities)) AS yMINybr257, (c394661 - (select avg(c394661) from uscities)) AS yMINybr261, (c395213 - (select avg(c395213) from uscities)) AS yMINybr265, (c394546 - (select avg(c394546) from uscities)) AS yMINybr269, (c394932 - (select avg(c394932) from uscities)) AS yMINybr273, (c394778 - (select avg(c394778) from uscities)) AS yMINybr277, (c395095 - (select avg(c395095) from uscities)) AS yMINybr281, (c394804 - (select avg(c394804) from uscities)) AS yMINybr285, (c394630 - (select avg(c394630) from uscities)) AS yMINybr289, (c395173 - (select avg(c395173) from uscities)) AS yMINybr293, (c394953 - (select avg(c394953) from uscities)) AS yMINybr297, (c394928 - (select avg(c394928) from uscities)) AS yMINybr301, (c394655 - (select avg(c394655) from uscities)) AS yMINybr305, (c394821 - (select avg(c394821) from uscities)) AS yMINybr309, (c394410 - (select avg(c394410) from uscities)) AS yMINybr313, (c394847 - (select avg(c394847) from uscities)) AS yMINybr317, (c753887 - (select avg(c753887) from uscities)) AS yMINybr321, (c394859 - (select avg(c394859) from uscities)) AS yMINybr325, (c394644 - (select avg(c394644) from uscities)) AS yMINybr329, (c394682 - (select avg(c394682) from uscities)) AS yMINybr333, (c394452 - (select avg(c394452) from uscities)) AS yMINybr337, (c394994 - (select avg(c394994) from uscities)) AS yMINybr341, (c395088 - (select avg(c395088) from uscities)) AS yMINybr345, (c394762 - (select avg(c394762) from uscities)) AS yMINybr349, (c394701 - (select avg(c394701) from uscities)) AS yMINybr353, (c394496 - (select avg(c394496) from uscities)) AS yMINybr357, (c394360 - (select avg(c394360) from uscities)) AS yMINybr361, (c395092 - (select avg(c395092) from uscities)) AS yMINybr365, (c394365 - (select avg(c394365) from uscities)) AS yMINybr369, (c394591 - (select avg(c394591) from uscities)) AS yMINybr373, (c394432 - (select avg(c394432) from uscities)) AS yMINybr377, (c394652 - (select avg(c394652) from uscities)) AS yMINybr381, (c394556 - (select avg(c394556) from uscities)) AS yMINybr385, (c395122 - (select avg(c395122) from uscities)) AS yMINybr389, (c394987 - (select avg(c394987) from uscities)) AS yMINybr393, (c753889 - (select avg(c753889) from uscities)) AS yMINybr397, (c395201 - (select avg(c395201) from uscities)) AS yMINybr401, (c394545 - (select avg(c394545) from uscities)) AS yMINybr405, (c394887 - (select avg(c394887) from uscities)) AS yMINybr409, (c394384 - (select avg(c394384) from uscities)) AS yMINybr413, (c395230 - (select avg(c395230) from uscities)) AS yMINybr417, (c394449 - (select avg(c394449) from uscities)) AS yMINybr421, (c395178 - (select avg(c395178) from uscities)) AS yMINybr425, (c394526 - (select avg(c394526) from uscities)) AS yMINybr429, (c395129 - (select avg(c395129) from uscities)) AS yMINybr433, (c394894 - (select avg(c394894) from uscities)) AS yMINybr437, (c394916 - (select avg(c394916) from uscities)) AS yMINybr441, (c394535 - (select avg(c394535) from uscities)) AS yMINybr445, (c753894 - (select avg(c753894) from uscities)) AS yMINybr449, (c394962 - (select avg(c394962) from uscities)) AS yMINybr453, (c395206 - (select avg(c395206) from uscities)) AS yMINybr457, (c753871 - (select avg(c753871) from uscities)) AS yMINybr461, (c394758 - (select avg(c394758) from uscities)) AS yMINybr465, (c753921 - (select avg(c753921) from uscities)) AS yMINybr469, (c394418 - (select avg(c394418) from uscities)) AS yMINybr473, (c395236 - (select avg(c395236) from uscities)) AS yMINybr477 FROM uscities where months >= 201612 and months <= 201712;


SELECT * INTO OUTFILE '/var/lib/mysql-files/CORRELATEX.csv' FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' FROM CORRELATEX;

-- Once the csv it there, we run one more instance of the R Transpose script CreateCorrelateXCSV.r

-- scp '/Users/katherine/CORRELATEXtranspose_update.csv' keh384@12.42.205.8:"/home/2019/nyu/spring/6513/keh384/P1"

DROP TABLE CORRELATEX;

CREATE TABLE CORRELATEX (
SizeRankingCor VARCHAR(10),
c201612 DECIMAL(15,4),
c201701 DECIMAL(15,4),	
c201702 DECIMAL(15,4),
c201703 DECIMAL(15,4),	
c201704 DECIMAL(15,4),	
c201705 DECIMAL(15,4),
c201706 DECIMAL(15,4),
c201707 DECIMAL(15,4),
c201708 DECIMAL(15,4),
c201709 DECIMAL(15,4),
c201710 DECIMAL(15,4),
c201711 DECIMAL(15,4),
c201712 DECIMAL(15,4)
);

LOAD DATA LOCAL INFILE '/home/2019/nyu/spring/6513/keh384/P1/CORRELATEXtranspose_update.csv' INTO TABLE CORRELATEX FIELDS TERMINATED BY ',' ENCLOSED BY '\"' LINES TERMINATED BY '\n' IGNORE 1 LINES;

CREATE TABLE FINAL AS (SELECT * FROM CORRELATE INNER JOIN CORRELATEX ON CORRELATE.SizeRankCol=CORRELATEX.SizeRankingCor);


ALTER TABLE FINAL ADD result DECIMAL(15,4);

-- Correlation Try number 1
UPDATE FINAL 
SET result = 
(SizeRanki* c201612+SizeRanki*c201701+SizeRanki*c201702+SizeRanki* c201703+SizeRanki*c201704+SizeRanki* c201705+SizeRanki*c201706+SizeRanki* c201707+SizeRanki*c201708+SizeRanki* c201709+SizeRanki*c201710+SizeRanki* c201711+SizeRanki*c201712)/ (SELECT SQRT(SizeRanki*SizeRanki*13+
c201612*c201612 + c201701*c201701 + c201702*c201702 + c201703*c201703 + c201704*c201704 + c201705*c201705 + c201706*c201706 + c201707*c201707 + c201708*c201708 + c201709*c201709 + c201710*c201710 + c201711*c201711 + c201712*c201712
));

-- Correlation Try number 2
ALTER TABLE FINAL ADD ab DECIMAL(15,4);
ALTER TABLE FINAL ADD a2 DECIMAL(15,4);
ALTER TABLE FINAL ADD b2 DECIMAL(15,4);
UPDATE FINAL set ab = SizeRanki* c201612;
UPDATE FINAL set a2 = SizeRanki* SizeRanki;
UPDATE FINAL set b2 = c201612* c201612;
UPDATE FINAL SET result = (select SUM(ab))/ (select sqrt ((select SUM(a2))+ (select SUM(b2)) ) );