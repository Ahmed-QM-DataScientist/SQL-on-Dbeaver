-- Get the Top 3 athletes who have won the most gold medals. And where are they from ?
   
Select name,team, count(*) as Gold_Medals
from Olympics where medal = 'Gold'
group by name, team
order by Gold_Medals desc
Limit 3;
   
   -- Results:
   
"name"	"team"	"gold_medals"
"Michael Fred Phelps, II"	"United States"	23
"Raymond Clarence ""Ray"" Ewry"	"United States"	10
"Frederick Carlton ""Carl"" Lewis"	"United States"	9


--Which 10 country won the most medals silver and Gold ?

select team, count(*) from Olymbics 
where  medal in ('Gold', 'Silver')
group by team
order by count desc
limit 10;

-- Results:
"team"	"count"
"United States"	3986
"Soviet Union"	1774
"Germany"	1306
"Great Britain"	1101
"Italy"	1043
"France"	973
"Sweden"	927
"Canada"	835
"Australia"	795
"Hungary"	762

--Did not expect that US will take the first place xd

 -- How old were the Participants ?
SELECT CAST(Age AS INTEGER), COUNT(*) AS Participants
FROM Olymbics 
WHERE Age <> 'NA'
GROUP BY Age
ORDER BY Participants DESC;

-- Results:
"age"	"participants"
23	21875
24	21720
22	20814
25	19707
21	19164
26	17675
27	16025
20	15258
28	14043
19	11643
29	11463
30	9488
18	8152
31	7559
32	6246
17	5376
33	4800
34	3985
16	3852
35	3133
36	2503
15	2203
37	1953
38	1612
39	1405
40	1210
41	953
42	866
14	837
43	793
44	683
45	584
46	429
47	408
48	407
49	362
50	278
52	244
53	200
51	199
13	187
54	162
56	131
55	104
60	88
59	87
65	84
58	84
57	69
61	68
62	62
69	60
63	56
12	39
71	33
66	31
64	30
70	28
67	25
68	25
72	24
11	13
74	12
73	8
76	7
75	4
88	3
80	3
77	2
81	2
97	1
84	1
96	1
10	1


- so the most participants age between 23-29 , min. Age was 10 and max. was 97


-- how many medals won every country ?
 
 
 
WITH medal_counts AS (
    SELECT nC.region as country,
           medal, count(1) as total_medals 
    FROM olymbics OL
    JOIN noc_regions NC ON NC.noc = OL.noc
    WHERE medal <> 'NA'
    GROUP BY nc.region,medal
), 
medal_pivot AS (
    SELECT country,
           SUM(CASE WHEN medal = 'Gold' THEN total_medals ELSE 0 END) AS gold,
           SUM(CASE WHEN medal = 'Silver' THEN total_medals ELSE 0 END) AS silver,
           SUM(CASE WHEN medal = 'Bronze' THEN total_medals ELSE 0 END) AS bronze
    FROM medal_counts
    GROUP BY country
),
Medal_ranks as(
SELECT country,
       COALESCE(gold, 0) AS gold,
       COALESCE(silver, 0) AS silver,
       COALESCE(bronze, 0) AS bronze,
	   ROW_NUMBER() OVER (ORDER BY gold DESC, silver DESC, bronze DESC) AS rank
FROM medal_pivot)

SELECT country, gold, silver, bronze, rank
FROM medal_ranks
ORDER BY rank;

-- Results:
"country"	"gold"	"silver"	"bronze"	"rank"
"USA"	5276	3282	2716	1
"Russia"	3198	2340	2356	2
"Germany"	2602	2390	2520	3
"UK"	1356	1478	1302	4
"Italy"	1150	1062	1062	5
"France"	1002	1220	1332	6
"Sweden"	958	1044	1070	7
"Canada"	926	876	902	8
"Hungary"	864	664	742	9
"Norway"	756	722	588	10
"Australia"	736	918	1044	11
"China"	702	698	586	12
"Netherlands"	574	680	826	13
"Japan"	494	618	714	14
"South Korea"	442	464	370	15
"Finland"	396	540	864	16
"Denmark"	358	482	354	17
"Switzerland"	350	496	536	18
"Cuba"	328	258	232	19
"Romania"	322	400	584	20
"Serbia"	314	444	320	21
"India"	276	38	80	22
"Czech Republic"	246	524	518	23
"Poland"	234	390	506	24
"Spain"	220	486	272	25
"Brazil"	218	350	382	26
"Austria"	216	372	312	27
"Belgium"	196	394	346	28
"Argentina"	182	184	182	29
"New Zealand"	180	112	164	30
"Greece"	124	218	168	31
"Croatia"	116	108	74	32
"Bulgaria"	108	288	288	33
"Ukraine"	94	104	200	34
"Pakistan"	84	90	68	35
"Turkey"	80	54	56	36
"Jamaica"	76	150	88	37
"Kenya"	68	82	62	38
"South Africa"	64	94	104	39
"Uruguay"	62	4	60	40
"Mexico"	60	52	108	41
"Belarus"	48	88	142	42
"Nigeria"	46	60	92	43
"Ethiopia"	44	18	44	44
"Kazakhstan"	40	50	64	45
"Cameroon"	40	2	2	46
"Iran"	36	42	58	47
"Zimbabwe"	34	8	2	48
"North Korea"	32	32	70	49
"Slovakia"	30	38	26	50
"Bahamas"	28	22	30	51
"Estonia"	26	24	50	52
"Fiji"	26	0	0	53
"Indonesia"	22	34	26	54
"Uzbekistan"	20	14	34	55
"Ireland"	18	26	26	56
"Thailand"	18	16	26	57
"Slovenia"	16	26	54	58
"Georgia"	16	12	36	59
"Azerbaijan"	14	24	50	60
"Trinidad"	14	16	44	61
"Egypt"	14	16	24	62
"Lithuania"	12	14	96	63
"Morocco"	12	10	24	64
"Colombia"	10	18	28	65
"Algeria"	10	8	16	66
"Portugal"	8	22	52	67
"Luxembourg"	8	8	0	68
"Taiwan"	6	56	36	69
"Latvia"	6	38	26	70
"Chile"	6	18	40	71
"Tunisia"	6	6	14	72
"Dominican Republic"	6	4	4	73
"Mongolia"	4	20	28	74
"Armenia"	4	10	18	75
"Venezuela"	4	6	20	76
"Uganda"	4	6	4	77
"Liechtenstein"	4	4	10	78
"Peru"	2	28	0	79
"Vietnam"	2	6	0	80
"Puerto Rico"	2	4	12	81
"Syria"	2	4	4	82
"Israel"	2	2	14	83
"Haiti"	2	2	10	84
"Individual Olympic Athletes"	2	2	6	85
"Tajikistan"	2	2	4	86
"Costa Rica"	2	2	4	87
"Ivory Coast"	2	2	2	88
"Bahrain"	2	2	2	89
"Grenada"	2	2	0	90
"Ecuador"	2	2	0	91
"Burundi"	2	2	0	92
"Panama"	2	0	4	93
"Mozambique"	2	0	2	94
"Suriname"	2	0	2	95
"United Arab Emirates"	2	0	2	96
"Kosovo"	2	0	0	97
"Nepal"	2	0	0	98
"Jordan"	2	0	0	99
"Paraguay"	0	34	0	100
"Iceland"	0	30	4	101
"Montenegro"	0	28	0	102
"Malaysia"	0	22	10	103
"Namibia"	0	8	0	104
"Philippines"	0	6	14	105
"Moldova"	0	6	10	106
"Lebanon"	0	4	4	107
"Tanzania"	0	4	0	108
"Sri Lanka"	0	4	0	109
"Ghana"	0	2	44	110
"Saudi Arabia"	0	2	10	111
"Qatar"	0	2	8	112
"Kyrgyzstan"	0	2	4	113
"Zambia"	0	2	2	114
"Niger"	0	2	2	115
"Curacao"	0	2	0	116
"Sudan"	0	2	0	117
"Cyprus"	0	2	0	118
"Senegal"	0	2	0	119
"Gabon"	0	2	0	120
"Tonga"	0	2	0	121
"Botswana"	0	2	0	122
"Guatemala"	0	2	0	123
"Virgin Islands, US"	0	2	0	124
"Afghanistan"	0	0	4	125
"Kuwait"	0	0	4	126
"Barbados"	0	0	2	127
"Monaco"	0	0	2	128
"Guyana"	0	0	2	129
"Mauritius"	0	0	2	130
"Macedonia"	0	0	2	131
"Eritrea"	0	0	2	132
"Togo"	0	0	2	133
"Djibouti"	0	0	2	134
"Iraq"	0	0	2	135
"Bermuda"	0	0	2	136


