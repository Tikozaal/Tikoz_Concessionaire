INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES 
	('society_concess','concess',1)
;

INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES 
	('society_concess','concess',1)
;

INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES 
	('society_concess', 'concess', 1)
;

INSERT INTO `jobs` (`name`, `label`) VALUES
('concess', "concessionnaire")
;

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
('concess', 0, 'novice', 'Apprenti', 200, 'null', 'null'),
('concess', 1, 'expert', 'Vendeur', 400, 'null', 'null'),
('concess', 2, 'chef', "Expert", 600, 'null', 'null'),
('concess', 3, 'boss', 'Patron', 1000, 'null', 'null')
;


CREATE TABLE `owned_vehicles` (
  `id` int(20) NOT NULL,
  `nom` varchar(30) NOT NULL,
  `owner` varchar(80) NOT NULL,
  `name` varchar(30) NOT NULL,
  `label` varchar(30) NOT NULL,
  `vehicle` longtext DEFAULT NULL,
  `plate` varchar(12) NOT NULL,
  `type` varchar(20) NOT NULL DEFAULT 'car',
  `stored` int(2) NOT NULL,
  `reprog` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `tikoz_concessgarage` (
  `id` int(4) NOT NULL,
  `name` varchar(30) NOT NULL,
  `label` varchar(30) NOT NULL,
  `body` longtext NOT NULL,
  `prix` int(8) NOT NULL,
  `plate` varchar(15) NOT NULL,
  `stored` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `vehicles` (
  `id` int(4) NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `label` varchar(30) NOT NULL,
  `price` int(11) NOT NULL,
  `category` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


INSERT INTO `vehicles` (`id`, `name`, `label`, `price`, `category`) VALUES
(35, 'Blade', 'blade', 22500, 'muscle'),
(36, 'Buccaneer', 'buccaneer', 22500, 'muscle'),
(37, 'Buccaneer Rider', 'buccaneer2', 22500, 'muscle'),
(39, 'Chino Luxe', 'chino2', 22500, 'muscle'),
(40, 'Coquette BlackFin', 'coquette3', 22500, 'muscle'),
(41, 'Dominator', 'dominator', 25000, 'muscle'),
(42, 'Dukes', 'dukes', 25000, 'muscle'),
(43, 'Gauntlet', 'gauntlet', 25000, 'muscle'),
(44, 'Hotknife', 'hotknife', 25000, 'muscle'),
(45, 'Faction', 'faction', 25000, 'muscle'),
(46, 'Faction Rider', 'faction2', 25000, 'muscle'),
(47, 'Faction XL', 'faction3', 25000, 'muscle'),
(48, 'Nightshade', 'nightshade', 25000, 'muscle'),
(49, 'Phoenix', 'phoenix', 25000, 'muscle'),
(50, 'Picador', 'picador', 25000, 'muscle'),
(51, 'Sabre Turbo', 'sabregt', 25500, 'muscle'),
(52, 'Sabre GT', 'sabregt2', 25500, 'muscle'),
(53, 'Slam Van', 'slamvan3', 25500, 'muscle'),
(54, 'Tampa', 'tampa', 25500, 'muscle'),
(55, 'Virgo', 'virgo', 25500, 'muscle'),
(56, 'Vigero', 'vigero', 25500, 'muscle'),
(57, 'Voodoo', 'voodoo', 25500, 'muscle'),
(58, 'Blista', 'blista', 25500, 'compacts'),
(59, 'Brioso R/A', 'brioso', 25500, 'compacts'),
(60, 'Issi', 'issi2', 25500, 'compacts'),
(61, 'Panto', 'panto', 25500, 'compacts'),
(62, 'Prairie', 'prairie', 25500, 'compacts'),
(63, 'Bison', 'bison', 25500, 'vans'),
(64, 'Bobcat XL', 'bobcatxl', 25500, 'vans'),
(65, 'Burrito', 'burrito3', 25500, 'vans'),
(66, 'Burrito', 'gburrito2', 25500, 'vans'),
(67, 'Camper', 'camper', 25500, 'vans'),
(68, 'Gang Burrito', 'gburrito', 25500, 'vans'),
(69, 'Journey', 'journey', 25500, 'vans'),
(70, 'Minivan', 'minivan', 25500, 'vans'),
(71, 'Moonbeam', 'moonbeam', 25500, 'vans'),
(72, 'Moonbeam Rider', 'moonbeam2', 25500, 'vans'),
(73, 'Paradise', 'paradise', 25500, 'vans'),
(74, 'Rumpo', 'rumpo', 25500, 'vans'),
(75, 'Rumpo Trail', 'rumpo3', 25500, 'vans'),
(76, 'Surfer', 'surfer', 25500, 'vans'),
(77, 'Youga', 'youga', 25500, 'vans'),
(78, 'Youga Luxuary', 'youga2', 25500, 'vans'),
(79, 'Asea', 'asea', 25500, 'sedans'),
(80, 'Cognoscenti', 'cognoscenti', 25500, 'sedans'),
(81, 'Emperor', 'emperor', 25500, 'sedans'),
(82, 'Fugitive', 'fugitive', 25500, 'sedans'),
(83, 'Glendale', 'glendale', 25500, 'sedans'),
(84, 'Intruder', 'intruder', 25500, 'sedans'),
(85, 'Premier', 'premier', 25500, 'sedans'),
(86, 'Primo Custom', 'primo2', 25500, 'sedans'),
(87, 'Regina', 'regina', 25500, 'sedans'),
(88, 'Schafter', 'schafter2', 25500, 'sedans'),
(89, 'Stretch', 'stretch', 25500, 'sedans'),
(90, 'Super Diamond', 'superd', 25500, 'sedans'),
(91, 'Tailgater', 'tailgater', 25500, 'sedans'),
(92, 'Warrener', 'warrener', 25500, 'sedans'),
(93, 'Washington', 'washington', 25500, 'sedans'),
(94, 'Baller', 'baller2', 25500, 'suvs'),
(95, 'Baller Sport', 'baller3', 25500, 'suvs'),
(96, 'Cavalcade', 'cavalcade2', 25500, 'suvs'),
(97, 'Contender', 'contender', 25500, 'suvs'),
(98, 'Dubsta', 'dubsta', 25500, 'suvs'),
(99, 'Dubsta Luxuary', 'dubsta2', 25500, 'suvs'),
(100, 'Fhantom', 'fq2', 25500, 'suvs'),
(101, 'Grabger', 'granger', 25500, 'suvs'),
(102, 'Gresley', 'gresley', 25500, 'suvs'),
(103, 'Huntley S', 'huntley', 25500, 'suvs'),
(104, 'Landstalker', 'landstalker', 25500, 'suvs'),
(105, 'Mesa', 'mesa', 25500, 'suvs'),
(106, 'Mesa Trail', 'mesa3', 25500, 'suvs'),
(107, 'Patriot', 'patriot', 25500, 'suvs'),
(108, 'Radius', 'radi', 25500, 'suvs'),
(109, 'Rocoto', 'rocoto', 25500, 'suvs'),
(110, 'Seminole', 'seminole', 25500, 'suvs'),
(111, 'XLS', 'xls', 25500, 'suvs'),
(112, 'Btype', 'btype', 25500, 'sportsclassics'),
(113, 'Btype Luxe', 'btype3', 25500, 'sportsclassics'),
(114, 'Btype Hotroad', 'btype2', 25500, 'sportsclassics'),
(115, 'Casco', 'casco', 25500, 'sportsclassics'),
(116, 'Coquette Classic', 'coquette2', 25500, 'sportsclassics'),
(117, 'Manana', 'manana', 25500, 'sportsclassics'),
(118, 'Monroe', 'monroe', 25500, 'sportsclassics'),
(119, 'Pigalle', 'pigalle', 25500, 'sportsclassics'),
(120, 'Stinger', 'stinger', 25500, 'sportsclassics'),
(121, 'Stinger GT', 'stingergt', 25500, 'sportsclassics'),
(122, 'Stirling GT', 'feltzer3', 25500, 'sportsclassics'),
(123, 'Z-Type', 'ztype', 25500, 'sportsclassics'),
(124, 'Bifta', 'bifta', 25500, 'offroad'),
(125, 'Bf Injection', 'bfinjection', 25500, 'offroad'),
(126, 'Blazer', 'blazer', 25500, 'offroad'),
(127, 'Blazer Sport', 'blazer4', 25500, 'offroad'),
(128, 'Brawler', 'brawler', 25500, 'offroad'),
(129, 'Bubsta 6x6', 'dubsta3', 25500, 'offroad'),
(130, 'Dune Buggy', 'dune', 25500, 'offroad'),
(131, 'Guardian', 'guardian', 25500, 'offroad'),
(132, 'Rebel', 'rebel2', 25500, 'offroad'),
(133, 'Sandking', 'sandking', 25500, 'offroad'),
(134, 'The Liberator', 'monster', 25500, 'offroad'),
(135, 'Trophy Truck', 'trophytruck', 25500, 'offroad'),
(136, 'Trophy Truck Limited', 'trophytruck2', 25500, 'offroad'),
(137, 'Cognoscenti Cabrio', 'cogcabrio', 25500, 'coupes'),
(138, 'Exemplar', 'exemplar', 25500, 'coupes'),
(139, 'F620', 'f620', 25500, 'coupes'),
(140, 'Felon', 'felon', 25500, 'coupes'),
(141, 'Felon GT', 'felon2', 25500, 'coupes'),
(142, 'Jackal', 'jackal', 25500, 'coupes'),
(143, 'Oracle XS', 'oracle2', 25500, 'coupes'),
(144, 'Sentinel', 'sentinel', 25500, 'coupes'),
(145, 'Sentinel XS', 'sentinel2', 25500, 'coupes'),
(146, 'Windsor', 'windsor', 25500, 'coupes'),
(147, 'Windsor Drop', 'windsor2', 25500, 'coupes'),
(148, 'Zion', 'zion', 25500, 'coupes'),
(149, 'Zion Cabrio', 'zion2', 25500, 'coupes'),
(150, '9F', 'ninef', 25500, 'sports'),
(151, '9F Cabrio', 'ninef2', 25500, 'sports'),
(152, 'Alpha', 'alpha', 25500, 'sports'),
(153, 'Banshee', 'banshee', 25500, 'sports'),
(154, 'Bestia GTS', 'bestiagts', 25500, 'sports'),
(155, 'Buffalo', 'buffalo', 25500, 'sports'),
(156, 'Buffalo S', 'buffalo2', 25500, 'sports'),
(157, 'Carbonizzare', 'carbonizzare', 25500, 'sports'),
(158, 'Comet', 'comet2', 25500, 'sports'),
(159, 'Coquette', 'coquette', 25500, 'sports'),
(160, 'Drift Tampa', 'tampa2', 25500, 'sports'),
(161, 'Elegy', 'elegy2', 25500, 'sports'),
(162, 'Feltzer', 'feltzer2', 25500, 'sports'),
(163, 'Furore GT', 'furoregt', 25500, 'sports'),
(164, 'Fusilade', 'fusilade', 25500, 'sports'),
(165, 'Jester', 'jester', 25500, 'sports'),
(166, 'Jester(Racecar)', 'jester2', 25500, 'sports'),
(167, 'Khamelion', 'khamelion', 25500, 'sports'),
(168, 'Kuruma', 'kuruma', 25500, 'sports'),
(169, 'Lynx', 'lynx', 25500, 'sports'),
(170, 'Mamba', 'mamba', 25500, 'sports'),
(171, 'Massacro', 'massacro', 25500, 'sports'),
(172, 'Massacro(Racecar)', 'massacro2', 25500, 'sports'),
(173, 'Omnis', 'omnis', 25500, 'sports'),
(174, 'Penumbra', 'penumbra', 25500, 'sports'),
(175, 'Rapid GT', 'rapidgt', 25500, 'sports'),
(176, 'Rapid GT Convertible', 'rapidgt2', 25500, 'sports'),
(177, 'Schafter V12', 'schafter3', 25500, 'sports'),
(178, 'Seven 70', 'seven70', 25500, 'sports'),
(179, 'Sultan', 'sultan', 25500, 'sports'),
(180, 'Surano', 'surano', 25500, 'sports'),
(181, 'Tropos', 'tropos', 25500, 'sports'),
(182, 'Verlierer', 'verlierer2', 25500, 'sports'),
(183, 'Adder', 'adder', 25500, 'super'),
(184, 'Banshee 900R', 'banshee2', 25500, 'super'),
(185, 'Bullet', 'bullet', 25500, 'super'),
(186, 'Cheetah', 'cheetah', 25500, 'super'),
(187, 'Entity XF', 'entityxf', 25500, 'super'),
(188, 'ETR1', 'sheava', 25500, 'super'),
(189, 'FMJ', 'fmj', 25500, 'super'),
(190, 'Infernus', 'infernus', 25500, 'super'),
(191, 'Osiris', 'osiris', 25500, 'super'),
(192, 'Pfister', 'pfister811', 25500, 'super'),
(193, 'RE-7B', 'le7b', 25500, 'super'),
(194, 'Reaper', 'reaper', 25500, 'super'),
(195, 'Sultan RS', 'sultanrs', 25500, 'super'),
(196, 'T20', 't20', 25500, 'super'),
(197, 'Turismo R', 'turismor', 25500, 'super'),
(198, 'Tyrus', 'tyrus', 25500, 'super'),
(199, 'Vacca', 'vacca', 25500, 'super'),
(200, 'Voltic', 'voltic', 25500, 'super'),
(201, 'X80 Proto', 'prototipo', 25500, 'super'),
(202, 'Zentorno', 'zentorno', 25500, 'super'),
(203, 'Akuma', 'AKUMA', 25500, 'motorcycles'),
(204, 'Avarus', 'avarus', 25500, 'motorcycles'),
(205, 'Bagger', 'bagger', 25500, 'motorcycles'),
(206, 'Bati 801', 'bati', 25500, 'motorcycles'),
(207, 'Bati 801RR', 'bati2', 25500, 'motorcycles'),
(208, 'BF400', 'bf400', 25500, 'motorcycles'),
(209, 'BMX (velo)', 'bmx', 25500, 'motorcycles'),
(210, 'Carbon RS', 'carbonrs', 25500, 'motorcycles'),
(211, 'Chimera', 'chimera', 25500, 'motorcycles'),
(212, 'Cliffhanger', 'cliffhanger', 25500, 'motorcycles'),
(213, 'Cruiser (velo)', 'cruiser', 25500, 'motorcycles'),
(214, 'Daemon', 'daemon', 25500, 'motorcycles'),
(215, 'Daemon High', 'daemon2', 25500, 'motorcycles'),
(216, 'Defiler', 'defiler', 25500, 'motorcycles'),
(217, 'Double T', 'double', 25500, 'motorcycles'),
(218, 'Enduro', 'enduro', 25500, 'motorcycles'),
(219, 'Esskey', 'esskey', 25500, 'motorcycles'),
(220, 'Faggio', 'faggio', 25500, 'motorcycles'),
(221, 'Vespa', 'faggio2', 25500, 'motorcycles'),
(222, 'Fixter (velo)', 'fixter', 25500, 'motorcycles'),
(223, 'Gargoyle', 'gargoyle', 25500, 'motorcycles'),
(224, 'Hakuchou', 'hakuchou', 25500, 'motorcycles'),
(225, 'Hakuchou Sport', 'hakuchou2', 25500, 'motorcycles'),
(226, 'Hexer', 'hexer', 25500, 'motorcycles'),
(227, 'Innovation', 'innovation', 25500, 'motorcycles'),
(228, 'Manchez', 'manchez', 25500, 'motorcycles'),
(229, 'Nemesis', 'nemesis', 25500, 'motorcycles'),
(230, 'Nightblade', 'nightblade', 25500, 'motorcycles'),
(231, 'PCJ-600', 'pcj', 25500, 'motorcycles'),
(232, 'Ruffian', 'ruffian', 25500, 'motorcycles'),
(233, 'Sanchez', 'sanchez', 25500, 'motorcycles'),
(234, 'Sanchez Sport', 'sanchez2', 25500, 'motorcycles'),
(235, 'Sanctus', 'sanctus', 25500, 'motorcycles'),
(236, 'Scorcher (velo)', 'scorcher', 25500, 'motorcycles'),
(237, 'Sovereign', 'sovereign', 25500, 'motorcycles'),
(238, 'Shotaro Concept', 'shotaro', 25500, 'motorcycles'),
(239, 'Thrust', 'thrust', 25500, 'motorcycles'),
(240, 'Tri bike (velo)', 'tribike3', 25500, 'motorcycles'),
(241, 'Vader', 'vader', 25500, 'motorcycles'),
(242, 'Vortex', 'vortex', 25500, 'motorcycles'),
(243, 'Woflsbane', 'wolfsbane', 25500, 'motorcycles'),
(244, 'Zombie', 'zombiea', 25500, 'motorcycles'),
(245, 'Zombie Luxuary', 'zombieb', 25500, 'motorcycles'),
(246, 'blazer5', 'blazer5', 25500, 'offroad'),
(247, 'Ruiner 2', 'ruiner2', 25500, 'muscle'),
(248, 'Voltic 2', 'voltic2', 25500, 'super'),
(249, 'Ardent', 'ardent', 25500, 'sportsclassics'),
(250, 'Oppressor', 'oppressor', 25500, 'super'),
(251, 'Visione', 'visione', 25500, 'super'),
(252, 'Retinue', 'retinue', 25500, 'sportsclassics'),
(253, 'Cyclone', 'cyclone', 25500, 'super'),
(254, 'Rapid GT3', 'rapidgt3', 25500, 'sportsclassics'),
(255, 'raiden', 'raiden', 25500, 'sports'),
(256, 'Yosemite', 'yosemite', 25500, 'muscle'),
(257, 'Deluxo', 'deluxo', 25500, 'sportsclassics'),
(258, 'Pariah', 'pariah', 25500, 'sports'),
(259, 'Stromberg', 'stromberg', 25500, 'sports'),
(260, 'SC 1', 'sc1', 25500, 'super'),
(261, 'riata', 'riata', 25500, 'offroad'),
(262, 'Hermes', 'hermes', 25500, 'muscle'),
(263, 'Savestra', 'savestra', 25500, 'sportsclassics'),
(264, 'Streiter', 'streiter', 25500, 'sports'),
(265, 'Kamacho', 'kamacho', 25500, 'offroad'),
(266, 'GT 500', 'gt500', 25500, 'sportsclassics'),
(267, 'Z190', 'z190', 25500, 'sportsclassics'),
(268, 'Viseris', 'viseris', 25500, 'sportsclassics'),
(269, 'Autarch', 'autarch', 25500, 'super'),
(270, 'Comet 5', 'comet5', 25500, 'sports'),
(271, 'Neon', 'neon', 25500, 'sports'),
(272, 'Revolter', 'revolter', 25500, 'sports'),
(273, 'Sentinel3', 'sentinel3', 25500, 'sports'),
(274, 'Hustler', 'hustler', 25500, 'muscle');


CREATE TABLE `vehicles_categories` (
  `id` int(4) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `label` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


INSERT INTO `vehicles_categories` (`id`, `name`, `label`) VALUES
(1, 'supersportives', 'Supersportives'),
(2, 'sportives', 'Sportives'),
(3, 'sportives classiques', 'Sportives Classiques'),
(4, 'coupés', 'Coupés'),
(5, 'muscle', 'Muscle'),
(6, 'berlines', 'Berlines'),
(7, 'compactes', 'Compactes'),
(8, 'suv', 'SUV'),
(9, 'offroad', 'Off Road'),
(10, 'vans', 'Vans'),
(11, 'vélos', 'Vélos'),
(12, 'véhicules commerciaux', 'Véhicules commerciaux'),
(13, 'véhicules industriels', 'Véhicules industriels');

ALTER TABLE `owned_vehicles`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `tikoz_concessgarage`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `vehicles`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `vehicles_categories`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `owned_vehicles`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

ALTER TABLE `tikoz_concessgarage`
  MODIFY `id` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

ALTER TABLE `vehicles`
  MODIFY `id` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=275;

ALTER TABLE `vehicles_categories`
  MODIFY `id` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
COMMIT;
