#!/bin/sh
#
#	mksfpcg.sh
#	create and fill a Star Finder RPG Player Charecter generation database
#
#CREATE USER 'lllrjs'@'localhost';
#GRANT ALL ON sfpcg.* TO 'lllrjs'@'localhost';
#
#	Backstory
#
#

NN="NULL, NULL"			#column fillers
DB=sfpcg			#database name
DC=/tmp/db$DB			#database command file
TC=/tmp/db${DB}tc		#Table command file
EOT="\t\t\t\t\t);"		#End of Table
TFK=tfk

#rm -f $DC			#delete old /tmp file
#CREATE TEMPORARY TABLE $TFK ( Name VARCHAR(64) NOT NULL );
echo -n "" >$TC			#overwrite existing file
cat <<__EOF >$DC		#overwrite existing file
CREATE OR REPLACE DATABASE $DB;
use $DB;
__EOF

for TABLE in 	label raceFk HomeFk themeFk	\
		genderFk classFk alignFk	\
		skillFk featFk 	LangFk		\
		PlayerC	abilityFk WorldFk	\
		professionFk factionFk		\
		LifSciFk PhySciFk		\
		ArmorFk weaponFk mechhackFk
do

TP=$TABLE	#Table Prefix column names
unset TP	#do not prefix column names

PK=ID		#primary key column name
cat <<__EOF >>$DC
#
#	${TABLE}
#
CREATE OR REPLACE TABLE ${TABLE} (
ID INT AUTO_INCREMENT NOT NULL,
${TP}Name VARCHAR(64) NOT NULL,
${TP}Note VARCHAR(128) DEFAULT NULL,
__EOF
case "$TABLE" in
	"LangFk")
#		INSERT INTO tbl_name VALUES (1, "row 1"), (2, "row 2");
	echo -e "INSERT INTO $TABLE (${TP}Name, ${TP}Note) VALUES 				\n
		('Akitonian',	'inhabitants of Akiton'),					\n
		('Lashunta',	'aka Castrovelian, lashuntas, Castrovel'),			\n
		('Brethedan',	'inhabitants of Bretheda, Liavara, and their moons'),		\n
		('Eoxian',	'inhabitants of Eox'),						\n
		('Aklo',	'inhabitants of Aucturn, Dominion of the Black'),		\n
		('Kasatha',	'kasathas'),							\n
		('Shirren',	'shirrens'),							\n
		('Triaxian',	'inhabitants of Triaxus'),					\n
		('Vercite',	'inhabitants of Verces'),					\n
		('Vesk',	'vesk, inhabitants of the Veskarium'),				\n
		('Ysoki',	'ysoki'),							\n
		('Abyssal',	'demons, chaotic evil outsiders, inhabitants of the Abyss'),	\n
		('Aquan',	'inhabitants of the Plane of Water'),				\n
		('Arkanen',	'inhabitants of Arkanen and Osoro'),				\n
		('Auran',	'inhabitants of the Plane of Air'),				\n
		('Azlanti',	'Azlanti, inhabitants of the Azlanti Star Empire'),		\n
		('Celestial',	'angels, good outsiders, good-aligned planes inhabitants'),	\n
		('Draconic',	'dragons, reptilian humanoids, Triaxian dragonkin'),		\n
		('Drow',	'drow, many residents of Apostae'),				\n
		('Dwarven',	'dwarves'),							\n
		('Elven',	'drow, elves, half-elves'),					\n
		('Gnome',	'gnomes'),							\n
		('Goblin',	'bugbears, goblins, hobgoblins'),				\n
		('Halfling',	'halflings'),							\n
		('Ignan',	'inhabitants of the Plane of Fire'),				\n
		('Infernal',	'devils, lawful evil outsiders, inhabitants of Hell'),		\n
		('Kalo',	'kalo, inhabitants of Kalo-Mahoi'),				\n
		('Nchaki',	'inhabitants of Nchak'),					\n
		('Orc',		'orcs, half-orcs'),						\n
		('Sarcesian',	'sarcesians'),							\n
		('Shobhad',	'shobhads'),							\n
		('Terran',	'inhabitants of the Plane of Earth'),				\n
		('Common',	'almost everywhere');" >>$TC
	;;
	"WorldFk")
	;;
	"HomeFk")
	echo -e "INSERT INTO $TABLE (${TP}Name, ${TP}Note) VALUES							\n
		('Aballon',		'closest planet the sun, craters, deserts, & mountains, drab'),			\n
		('Castrovel',		'Hot, humid, jungles, swamps, intense storms & tides, saurians, moldstorms'),	\n
		('Golarion',		'(lost)')									\n
		('Absalom Station',	'primary home of humanitya, center of interstellar trade & governance'),	\n
		('Akiton',		'thasteron mining, unregulated place of criminals, fugitives, & lost'),		\n
		('Verces',		'tidal locked, iron-hard plants, legendary pilots, massive Skydock shipyard'),	\n
		('Idari',		'Ancient Kasathan colony ship'),						\n
		('The Diaspora',	'asteroids formed by Damiar and Iovo catastrophe millennia ago'),		\n
		('Eox',			'the majority of creatures encountered on Eox are undead'),			\n
		('Triaxus',		'eccentric slow orbit, humanoid ryphorians, dragon-ruled Drakelands'),		\n
		('Liavara',		'Gas Giant, Dreamers, space-whales, keji swarms, tarenake'),			\n
		('Bretheda',		'Gas Giant, barathus, Sopeth Corporation'),					\n
		('Apostae',		'rocky planetoid, extinct ilee, drow house (family-run corporations)'),		\n
		('Aucturn',		'living thing—an immature near-deific Great Old One),				\n
		('Arkanen',		'(Liavara Moon)'),								\n
		('Osoro',		'(Liavara Moon)'),								\n
		('Melos',		'(Liavara Moon)'),								\n
		('Hallas',		'(inhospitable) (Liavara Moon)'),						\n
		('Nchak',		'(Liavara Moon)'),								\n
		('Kalo-Mahoi',		'(Bretheda Moon)'),								\n
		('Marata',		'(Bretheda Moon)'),								\n
		('Thyst',		'(inhospitable) (Bretheda Moon)'),						\n
		('Varos',		'(inhospitable) (Bretheda Moon)'),						\n
		('Chamari',		'(uninhabited) (Bretheda Moon)'),						\n
		('Cynosure',		'Desna’s palace populated, by Spheres'),					\n
		('Ironstar',		'space station equipped with Drift engine'),					\n
		('Kasath',		NULL),										\n
		('Lausill',		'advanced aquatic civilizations, incredible body-augmentation'),		\n
		('Taru Seco',		'binary system, bizarre metropolitan ruins of advanced long-vanished people.'),	\n
		('Xio',			'anyone who has attempted approach has disappears without a trace'),		\n
		('Arquand',		'self-aware planet reacting to the desires & fears of resident life-forms'),	\n
		('Azlanti Star Empire',	NULL),										\n
		('Daegox 4',		'Inescapable Corporate Prison'),						\n
		('Daimalko',		'Ruins and Rampaging Colossi'),							\n
		('Embroi',		'Iron Thrall of Hell (slave world)'),						\n
		('Jedarat',		'vacation resort-world (under construction)',					\n
		('Lothun',		'Terraforming Gone Haywire (inhospitable)'),					\n
		('Orikolai',		NULL),										\n
		('Orry',		'10 massive swaths of land, & several dozen smaller formations'),		\n
		('Preluria',		'inhabited by oozing psychic green gas'),					\n
		('Riven Shroud',	'Dyson sphere: Solar Starship Graveyard'),					\n
		('Shadari',		'draeliks, Unmaker aeon entity'),						\n
		('Tabori Cluster',	'stars: Deepwater, Ixo, Jordan’s World, Veran, & Vodorae'),			\n
		('The Veskarium',	'Vesk eight-planet home system) );"	 >>$TC						\n
	;;
	"factionFk")
	;;
	"professionFk")
#	ALTER TABLE t1 ADD x INT;
#	echo "ALTER TABLE $TABLE ADD ability CHAR(3)"
        echo "${TP}ability CHAR(3) NOT NULL," >>$DC
	echo -e "INSERT INTO $TABLE (${TP}Name, ${TP}Note) VALUES							\n
Forensic Accountant (INT)
Actor (CHA)
Archaeologist (INT)
Architect (INT)
Artist (CHA)
Bounty Hunter (WIS)
Comedian (CHA)
Con Artist (CHA)
Cook (WIS)
Corporate Professional (INT)
Counselor (WIS)
Courtesan (CHA)
Dancer (CHA)
Dockworker (WIS)
Electrician (INT)
Farmer (WIS)
Gambler (WIS)
General Contractor (WIS)
Herbalist (WIS)
Lab Technician (INT)
Lawyer (INT)
Maintenance Worker (WIS)
Manager (WIS)
Mathematician (INT)
Mercenary (WIS)
Merchant (WIS)
Miner (WIS)
Musician (CHA)
Orator (CHA)
Philosopher (INT)
Poet (CHA)
Politician (CHA)
Professor (INT)
Psychologist (INT)
Smuggler (WIS)
Video Personality (CHA)
VidGamer (INT)
Writer (CHA)
	;;
	"mechackFk")
	;;
	"label")
	;;
	"armorFk")
	;;
	"raceFk")
        echo "${TP}Homeworld VARCHAR(64) NOT NULL," >>$DC
	;;
	"themeFk")
	;;
	"genderFk")
	;;
	"classFk")
	;;
	"alignFk")
	;;
	"skillFk")
	;;
	"featFk")
	;;
	"abilityFk")
	PK=Name					#use different primary key
	TP="_"					#avoid generating SQL keyword column ID
	for AB in STR DEX CON INT WIS CHA do
		echo -e "INSERT INTO $TABLE (${TP}Name) VALUES $TP$AB
		
        echo "${TP}$AD CHAR(3) NOT NULL," >>$DC
        echo "${TP}STR CHAR(3) NOT NULL," >>$DC
        echo "${TP}DEX CHAR(3) NOT NULL," >>$DC
        echo "${TP}CON CHAR(3) NOT NULL," >>$DC
        echo "${TP}INT CHAR(3) NOT NULL," >>$DC
        echo "${TP}WIS CHAR(3) NOT NULL," >>$DC
        echo "${TP}CHA CHAR(3) NOT NULL," >>$DC
	for AB in STR DEX CON INT WIS CHA
	do
		echo -e  "INSERT INTO $TABLE (Name) VALUES\"$AB\")"
	done
	done
	unset TP
	;;
	"weaponFk")
        echo "${TP}Level INT NOT NULL," >>$DC
        echo "${TP}Price INT NOT NULL," >>$DC
        echo "${TP}Damage INT NOT NULL," >>$DC
        echo "${TP}MaxRange INT NOT NULL," >>$DC
        echo "${TP}Critical INT NOT NULL," >>$DC
        echo "${TP}Capacity INT NOT NULL," >>$DC
        echo "${TP}Usages INT NOT NULL," >>$DC
        echo "${TP}Bulk INT NOT NULL," >>$DC
        echo "${TP}Special INT NOT NULL," >>$DC
	;;
	esac

#echo "_EoT INT COMMENT 'End of Table'" >>$DC
echo "PRIMARY KEY ( $PK )" >>$DC
echo -e "$EOT" >>$DC
done

less $TC $DC
