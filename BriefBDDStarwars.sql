-- GENRE (enum) --
create type Gender as enum (
    'female',
    'male',
    'hermaphrodite',
    'NA'
    );
-- pour les couleurs on utilise une méthode de conception : 1 enum par type de couleur --
-- pour les véhicules (constructeurs, modèle, classe), pour essayer, on utilise une autre méthode de conception
-- COULEURS (enum) --
create type HairColor as enum (
    'blond',
    'brown',
    'grey',
    'black',
    'auburn',
    'white',
    'grey',
    'none',
    'NA'
    );
create type SkinColor as enum (
    'fair',
    'gold',
    'white',
    'blue'
    'light',
    'red',
    'green',
    'green-tan',
    'brown',
    'dark',
    'brown mottle',
    'mottled green',
    'orange',
    'yellow',
    'pale',
    'silver',
    'grey',
    'NA'
);
create type EyeColor as enum (
  'blue',
    'yellow',
    'red',
    'brown'
    'blue-gray',
    'black',
    'orange',
    'pink',
    'hazel',
    'NA'
);
-- CLASSIFICATION (enum) --
create type Classification as enum (
'gastropod',
    'mammal',
    'reptilian',
    'amphobian',
    'insectoid',
    'artificial',
    'NA'
);
-- DESIGNATION (enum) --
create type Designation as enum (
    'sentient'
    );
-- LANGUAGE (enum) --
create type Langage as enum (
    'Aleena',
'besalisk',
'Cerean',
'Chagria',
'Clawdite',
'Dosh',
'Dugese',
'Ewokese',
'Galactic basic',
'Geonosian',
'Gungan basic',
'Huttese',
'Iktotchese',
'Kaleesh',
'Kaminoan',
'Kel Dor',
'Mirialan',
'Mon Calamarian',
'Muun',
'NA',
'Nautila',
'Neimoidia',
'Quermian',
'Shyriiwook',
'Skakoan',
'Sullutese',
'Togruti',
'Toydarian',
'Tundan',
'Twi leki',
'Utapese',
'vulpterish',
'Xextese',
'Zabraki'
);
-- CLIMAT (enum) --
create type Climate as enum (
    'temperate',
    'tropical'
    'frozen',
    'murky',
    'arid',
    'windy'
    'arid',
    'hot',
    'frigid',
    'humid',
    'artic',
    'subartic',
        'NA'
    );
-- TERRAIN (enum) --
create type Terrain as enum (
'grasslands',
'jungle', 'rainforests',
'tundra', 'ice caves', 'mountain ranges',
'swamp',
'gas giant',
'forests', 'mountains', 'lakes',
'grassy hills',
'cityscape',
'ocean',
'rock', 'desert', 'barren'
'scrublands', 'savanna', 'canyons', 'sinkholes',
'volcanoes', 'lava rivers','caves',
'rivers',
'airless asteroid',
'glaciers','ice canyons',
'fungus forests',
 'fields', 'rock arches',
'caves', 'volcanoes',
'grass',
'cityscape',
'plains', 'urban', 'hills',
'jurban'
    );
-- PLANET (table) --
create table Planet (
  id serial
    constraint planet_pk
      primary key,
      name varchar,
      rotationPeriod int,
      orbitalPeriod int,
      diameter int,
      climate Climate,
      gravity numeric(3,2),
      terrain Terrain[],
      surfaceWater int,
      population int
);
-- SPECIES (table) --
create table Species
(
    id              serial
        constraint species_pk
            primary key,
    name            varchar,
    classification  Classification,
    designation     Designation,
    averageHeight   int,
    skinColor       SkinColor[],
    hairColors      HairColor[],
    eyeColors       EyeColor[],
    averageLifespan int,
    langage        Langage,
    homeWorld      int
        constraint species_planet_fk
            references Planet
            on delete cascade
);
-- CHARACTERS (table) --
create table Characters (
      id              serial
        constraint characters_pk
            primary key,
            nom varchar,
            height int,
            mass numeric (6,3),
            skinColor SkinColor[],
            hairColor HairColor[],
            eyeColor EyeColor[],
            birthyear varchar,
            gender Gender,
            homeWorld      int
        constraint characters_planet_fk
            references Planet
            on delete cascade,
            species       int
        constraint characters_species_fk
            references Species
            on delete cascade
);
-- pour les véhicules on conceptualise différemment par rapport aux couleurs --
-- MODE DE TRANSPORT (enum)
create type TransportMode as enum (
    'starship',
    'vehicle'
    );
-- MODEL (enum) de starship ou de vehicle --
-- à compléter --
create type Model as enum (
'Executor-class star dreadnought',
    'Sentinel-class landing craft'
);
-- MODEL DE TRANSPORT (table)
create table TransportModel (
    id              serial
        constraint transportmodel_pk
            primary key,
            model Model,
            transport TransportMode
);
-- MANUFACTURER (enum) de starship et/ou de vehicle --
-- à compléter --
create type Manufacturer as enum (
'Kuat Drive Yards, Fondor Shipyards',
    'Sienar Fleet Systems, Cyngus Spaceworks'
);
-- MANUFACTURER DE TRANSPORT (table)
create table TransportManufacturer (
    id              serial
        constraint transportmanufacturer_pk
            primary key,
            manufacturer Manufacturer,
            transport TransportMode
);
-- TRANSPORTCLASS (enum) de starship ou de vehicle --
-- à compléter --
create type TransportClass as enum (
'Star dreadnought',
    'landing craft'
);
-- CLASS DE TRANSPORT (table)
create table TransportClass (
    id              serial
        constraint transportclass_pk
            primary key,
            transportClass TransportClass,
            transport TransportMode
);
-- TRANSPORT (table) liste des engins de transport
create table Transport (
    id              serial
        constraint transport_pk
            primary key,
            name varchar,
            type TransportMode,
            model       int
        constraint transport_model_fk
            references TransportModel
            on delete cascade,
            manufacturer int
            constraint transport_manufacturer_fk
            references TransportManufacturer
            on delete cascade,
         costsInCredits int,
         length real,
         maxAtmosphericSpeed int,
         crew int,
         passengers int,
         cargoCapacity int,
         consumables varchar,
         hyperdriveRating numeric (2,1),
         mglt int,
         transportClass int
        constraint transport_class_fk
            references TransportClass
            on delete cascade
);

