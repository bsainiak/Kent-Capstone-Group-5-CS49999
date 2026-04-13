-- Load Script for Portfolio Database

PRAGMA foreign_keys = ON;

BEGIN;
	
INSERT INTO Events (EventID, EventName, Series, EventDate, Location) VALUES (1, 'Classic 24 at Daytona', 'HSR', '2024', 'Daytona');
INSERT INTO Events (EventID, EventName, Series, EventDate, Location) VALUES (2, 'The Mitty', 'HSR', '2025', 'Road Atlanta');
INSERT INTO Events (EventID, EventName, Series, EventDate, Location) VALUES (3, 'Michelin GT Ford Mustang  Challenge', 'IMSA', '2025', 'Virginia International Raceway');
INSERT INTO Events (EventID, EventName, Series, EventDate, Location) VALUES (4, 'Michelin GT MX5 Cup', 'IMSA', '2025', 'Virginia International Raceway');
INSERT INTO Events (EventID, EventName, Series, EventDate, Location) VALUES (5, 'Michelin GT Pilot Challenge', 'IMSA', '2025', 'Virginia International Raceway');
INSERT INTO Events (EventID, EventName, Series, EventDate, Location) VALUES (6, 'Michelin GT VP Raceing Sportscar', 'IMSA', '2025', 'Virginia International Raceway');
INSERT INTO Events (EventID, EventName, Series, EventDate, Location) VALUES (7, 'Michelin GT Weathertech Sportscar', 'IMSA', '2025', 'Virginia International Raceway');
INSERT INTO Events (EventID, EventName, Series, EventDate, Location) VALUES (8, 'GT America', 'SRO', '2025', 'Barber Motorsports Park');
INSERT INTO Events (EventID, EventName, Series, EventDate, Location) VALUES (9, 'GT World Challenge America', 'SRO', '2025', 'Barber Motorsports Park');
INSERT INTO Events (EventID, EventName, Series, EventDate, Location) VALUES (10, 'GT4 America', 'SRO', '2025', 'Barber Motorsports Park');
INSERT INTO Events (EventID, EventName, Series, EventDate, Location) VALUES (11, 'TC America', 'SRO', '2025', 'Barber Motorsports Park');
INSERT INTO Events (EventID, EventName, Series, EventDate, Location) VALUES (12, 'Toyota GR Cup', 'SRO', '2025', 'Barber Motorsports Park');
INSERT INTO Events (EventID, EventName, Series, EventDate, Location) VALUES (13, 'SVRA 2025', 'SVRA', '2025', 'Road Atlanta');
INSERT INTO Events (EventID, EventName, Series, EventDate, Location) VALUES (14, 'TA-GT', 'Trans-AM', '2025', 'Road Atlanta');
INSERT INTO Events (EventID, EventName, Series, EventDate, Location) VALUES (15, 'TA2', 'Trans-AM', '2025', 'Road Atlanta');

INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (1, 1, './images/photos/Daytona01', X'cb85a55fabafc5868b0c91b08e6c376da002fa8f95b8d02b1d91f19245615ea4', 0.1);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (2, 1, './images/photos/Daytona02', X'8586a2d8a683a64a261a36f2d278ca26bd24f0a4e17a707d6d8bb3e9da7da873', 0.1);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (3, 1, './images/photos/Daytona003', X'4c6b2f5425a3d8a2fed5eda97a6d0cb4d31b357f7eb3383a391c46943b17c6e1', 0.1);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (4, 1, './images/photos/Daytona04', X'956810dff4f7a0201f7f694efb1e421981596dbe3285d410dabc087a599793f6', 0.1);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (5, 1, './images/photos/Daytona005', X'9172cae3cba9bb43cb66eb25c8214e72e17ab4f23582157ea6eca9a557cad541', 0.1);

INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (6, 2, './images/photos/Mitty01', X'15683ce54ddb50fa055d6cc4aaf7ef046ce048b8f9dc9010ebe6c3308ce5c627', 0.9);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (7, 2, './images/photos/Mitty02', X'4cde58a6d90da4799652a4b2942658099f79ce0279ce91de1e385155ec36c8d5', 0.9);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (8, 2, './images/photos/Mitty03', X'1ae83b378ea136cb9ecc70071c1a1434cf8e59316a8abf742a4eb7d409f354bd', 0.9);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (9, 2, './images/photos/Mitty04', X'a561a1be7c812af69d030c512007297cc05e01f2a4a86150dc0c5fb902875183', 0.9);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (10, 2, './images/photos/Mitty05', X'3c22f3d830b02ab90c0c05ac91602158c6208f514492394f8c3b94ba550ca6e8', 0.9);

INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (11, 3, './images/photos/FordMustang01', X'a066a2654b0b4c1f2ba96bd2d0b4f7f0adf952d608639ea1813c7e90db94b1ef', 0.1);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (12, 3, './images/photos/FordMustang02', X'702fcc03f8951e510e00f8bc7673728fe3120a397173e660ac0f101b61046315', 0.1);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (13, 3, './images/photos/FordMustang03', X'18b27a93bba80fd8ba1e720999d4f2316f2c398eb45fd1e39dc2f4fa48aa0b4b', 0.1);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (14, 3, './images/photos/FordMustang04', X'1c99f12fc3283e2d96cccb1688bd3bee90de2fffd66607446c7a995c69de81d3', 0.1);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (15, 3, './images/photos/FordMustang05', X'7b9abf332c820a4f94a5d8e346dad6da417d530228ee9e18051faa565975500a', 0.1);

INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (16, 4, './images/photos/MX501', X'c0795283e7780a065f84e40b5400d0c0210fddbbfa3c04910c98d473f89e16df', 0.2);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (17, 4, './images/photos/MX502', X'15dc9174579c2f2c1e7cd5126ba6f5a05ebd92cece59bb9e5c2efd16d4014c8b', 0.2);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (18, 4, './images/photos/MX503', X'0a616196079f24cf3ca1e21898ee1b0df14358949c63a066e437c045c8303656', 0.2);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (19, 4, './images/photos/MX504', X'61eb96145d8ab98f7db0389238d461d7ed225d8cdc90bcd453c9cb3ad449fb3b', 0.2);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (20, 4, './images/photos/MX505', X'2f4effa18873d4fc6e02630f176b589a3d19c3975b8ea78cdb2d9fe7ea73e283', 0.2);

INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (21, 5, './images/photos/Pilot01', X'19e1dd9020f5e589f378cc9c003c5156739e7778ffc23f9236fd915276287189', 0.3);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (22, 5, './images/photos/Pilot02', X'c2f72bdb3dc484f9446ba16eb84751c0dab6d91e1666e03fa2d2739c5de2e024', 0.3);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (23, 5, './images/photos/Pilot03', X'90a43b45f1e56085f8d20972b7c6d89553c05b98192795dd39c2741e9a033e15', 0.3);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (24, 5, './images/photos/Pilot04', X'08268e6872e90607c46b45e91a4c6c188ae47f93892af8bb38b28d0f10040802', 0.3);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (25, 5, './images/photos/Pilot05', X'c5b26f52a339b642d73e63e0920d10eefbe9f984e64d6f1301afd107d618c5ad', 0.3);

INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (26, 6, './images/photos/VP01', X'8dbee481847da73cf5a17a828726e3f733c5dd10f71bd44907885304c2efb897', 0.4);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (27, 6, './images/photos/VP02', X'8c8ca084143af935b70a9d9fc68df681e42597940611f9b8c414a8a787c29dad', 0.4);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (28, 6, './images/photos/VP03', X'779a5d91edbcd08bc0ce7e691beed972c52bb2ab71439e0e6eac81a406f32303', 0.4);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (29, 6, './images/photos/VP04', X'f77a2792cb77f15fe1524ddc6dc4151185f2728ca1159ba6c3e8f74472bb9ffd', 0.4);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (30, 6, './images/photos/VP05', X'5ce99cc9a5f398f180356901995e0a76add1f39c61ca2270730c9f4e1616b530', 0.4);

INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (31, 7, './images/photos/Weathertech01', X'88e7a1ca75eafb509ece6ebdf2af8f2da99a4aeb8c91042a28c22199fefc1d24', 0.5);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (32, 7, './images/photos/Weathertech02', X'cfdcae4d061ad89570c0af432e88b42940776066297cee8a194af6daf9d26f2e', 0.5);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (33, 7, './images/photos/Weathertech03', X'05e841fe7763452e7ec0c482a93fdd4630a8640059fd69e8e78eb80384ed7f48', 0.5);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (34, 7, './images/photos/Weathertech04', X'92d5df46bb842ff735eb06cacabb91f4f53b424f93c39eb78a11ac39ba77b5b0', 0.5);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (35, 7, './images/photos/Weathertech05', X'29e8cca0b708bd531b1825fb3d71f9800bbd3e54582e32720c486fe63bc5b6b4', 0.5);

INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (36, 8, './images/photos/GTAmerica01', X'd3b6672fd38cc99d10de03414412c39baabf0ac5794f70e2d538eabf9f63f392', 0.6);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (37, 8, './images/photos/GTAmerica02', X'888fe2fdc19a54325d6c330e3859f18e8568a4959eaa8052f2cd76482da48a41', 0.6);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (38, 8, './images/photos/GTAmerica03', X'c5b26c856b83225f126f5200c092abc93738b05fb131d8dfb1fdb6d631086f7e', 0.6);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (39, 8, './images/photos/GTAmerica04', X'1c73633bd4c8cdc390a228299114832f69320ad80e9aa6e43a15b3dd9127605a', 0.6);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (40, 8, './images/photos/GTAmerica05', X'b21154c5a9cc55e34d9fdd2d21e47849f0ed04de31d6fdde297708e2a1abfee7', 0.6);

INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (41, 9, './images/photos/GTWorld01', X'825f3f11e68d0f4aa0f1f02b3adba6fdd9f5a3f5637ec7707f75eb08eff97631', 0.7);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (42, 9, './images/photos/GTWorld02', X'fa8cf1af9d1d011cfe8c1a2d0f1143139fc1c666e598a3214e8894cf9cebfd5f', 0.7);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (43, 9, './images/photos/GTWorld03', X'f1ba72d52834befdbe12fca017eac97623c4543c25a3c819c3fa0e7c01b6f037', 0.7);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (44, 9, './images/photos/GTWorld04', X'8c9fd83f7e18cf462fc46cab09cab6034b37bb191c514accc60e0b2f5d3874d9', 0.7);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (45, 9, './images/photos/GTWorld05', X'a385556947b76b0b8f2acb55096f8da13c7b653b8cc9b12386f70db6bf3b373f', 0.7);

INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (46, 10, './images/photos/GT4America01', X'8c922e5de7c62d82944945de32b9cec8d407112b72e6826284d8151383540517', 0.8);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (47, 10, './images/photos/GT4America02', X'e49e0f9ec8d7433062a569b2866157fe3f93d8bb65d4d8cbcff7cc23d37d0e47', 0.8);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (48, 10, './images/photos/GT4America03', X'98e24cc7db69c2a45970f91c1e22bec5080477ca8ae8711a2c83ef174832d6a3', 0.8);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (49, 10, './images/photos/GT4America04', X'24b1a546dfb873047d62308cac7d3a912938dc3bbba597cb390b8a7d805eeaa6', 0.8);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (50, 10, './images/photos/GT4America05', X'84acaba23e8fa7f9ba3424c39c74091333aed01a90ee57b1e221a62987abf9aa', 0.8);

INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (51, 11, './images/photos/TCAmerica01', X'89eafed5bcf94cc087afc9bbe2a2f16c2d1d82b491c97a809e32462775b7274c', 0.9);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (52, 11, './images/photos/TCAmerica02', X'57c23ad1c7170c21c1cca84ba855a87940b820428307013af734028ca43c8526', 0.9);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (53, 11, './images/photos/TCAmerica03', X'9df87dc69214839a68657ad1d14e89b65db57bc0d3fc6e5fa19edf42c5161247', 0.9);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (54, 11, './images/photos/TCAmerica04', X'fbd6a3d8fe2d648113039d4152e09c9991c204437dbdeb5b9911c78d54784d69', 0.9);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (55, 11, './images/photos/TCAmerica05', X'6538d116e2f6579bb4bc47eba016b7a84636488e426f779948833a6d54784570', 0.9);

INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (56, 12, './images/photos/ToyotaGR01', X'8e0275ff34c671efb88b8c5d8dd43404faa9a98444c6210536640a7c158ba5a9', 1.0);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (57, 12, './images/photos/ToyotaGR02', X'86cf0cba32bb4cff64ab0b5f0e6408e6e25841a32c5383dd8028e82c0d2f7b4d', 1.0);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (58, 12, './images/photos/ToyotaGR03', X'1688cc872884c086cc9a7644bc0e1d2726a37544d95a0962a25a29d7b026d57b', 1.0);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (59, 12, './images/photos/ToyotaGR04', X'060ea6fc62b0bb4a396efa9589252898b60bae76fe9146fc0daa53fdff2f7aed', 1.0);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (60, 12, './images/photos/ToyotaGR05', X'774ff69200e4ccda436bac9735d8fd2ddbe3f593004c2353648f73735980378f', 1.0);

INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (61, 13, './images/photos/SVRA01', X'84cf17367f37d70263919f40300e93122f8dbd2aa829f482fe9c792263712cba', 0.1);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (62, 13, './images/photos/SVRA02', X'6156a7b49078276c8d3b19a6e57e2b4f5048399f71e639d513399e5fcd2194b0', 0.2);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (63, 13, './images/photos/SVRA03', X'cd9a8a8f9aa0b68eed31ca4c64cd1857b17c6c3a30fd73637edbc458b1daf6e6', 0.3);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (64, 13, './images/photos/SVRA04', X'0ce40e246038d271f9bf977423e03a181453a67d689a03289aa7582fc0965f3d', 0.4);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (65, 13, './images/photos/SVRA05', X'96338611200ceafa8003d5c30adf20d88d2c5d74ca4ae2523b891d7be085ffd1', 0.5);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (66, 13, './images/photos/SVRA06', X'e840f361fe0023cc1f4617bf20b713b090be2dc46cf501678d8aa7ee50259780', 0.6);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (67, 13, './images/photos/SVRA07', X'cde0be575da1a7cf3a4a8bcfeab010a6107b4cf5d0d4ca5c9b82c01fe5e93404', 0.7);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (68, 13, './images/photos/SVRA08', X'8d4226e7b0ece44cd4eb5b4dd0cb1b0891d938d662f67f0c55fbd20dc8e27680', 0.8);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (69, 13, './images/photos/SVRA09', X'9afaaee8b1b3877df5b827f5aa386abb8b280a9cceec5380908969c9116b2d12', 0.9);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (70, 13, './images/photos/SVRA10', X'36165285877b672b902233c637d31e6b510e9b3d34a579f13818a302d40bb0b8', 1.0);

INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (71, 14, './images/photos/TATG01', X'2f83650a0b934e29970e1cec2158f62b7ca1f23259b25c018816f7741d4ecfda', 0.33);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (72, 14, './images/photos/TATG02', X'13d528afdef687d46ffdd518912eb45b5dd00df1edabc6660bb331cd86ada756', 0.33);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (73, 14, './images/photos/TATG03', X'55358416f8ed609aa48d278cd2fc76acba62491ec1137dbeae5265933a0e0f3c', 0.33);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (74, 14, './images/photos/TATG04', X'efb2f7f708d64a51618de63c227094c6ef84426447113d650b506007849ce744', 0.33);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (75, 14, './images/photos/TATG05', X'4caf614f7c5ca7a854c646c2fadf0a0986eab7daf734eb8b4f7856b05027026b', 0.33);

INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (76, 15, './images/photos/TA201', X'a1a547074fdca934112060da05632d67c62cc16e38a5e27039acdfc56a589361', 0.66);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (77, 15, './images/photos/TA202', X'84c5da9319086bc7fc3258b9e7206d960cf861d17741fc19dad35481acfd3a56', 0.66);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (78, 15, './images/photos/TA203', X'f5229bf30cbb681abc8e5775516d818b97d4f8e0b07dd5422a3cfcfd28ab81ec', 0.66);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (79, 15, './images/photos/TA204', X'48fc361e47178c58d2a2ec35e3fcc5207416a1921f41eb1d0fa115f2a530eb1e', 0.66);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (80, 15, './images/photos/TA205', X'1e02efd669a1b90fc45081520f6875b4bdaede478ac50aef7e41c30c7c082cb6', 0.66);

COMMIT;