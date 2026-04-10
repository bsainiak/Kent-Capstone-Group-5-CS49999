-- Load Script for Portfolio Database

PRAGMA foreign_keys = ON;

BEGIN;
	
-- Events
INSERT INTO Events (EventID, EventName, Series, EventDate, Location) VALUES (1, 'Classic 24 at Daytona', 'HSR', '2024', 'Daytona');
INSERT INTO Events (EventID, EventName, Series, EventDate, Location) VALUES (2, 'The Mitty', 'HSR', '2025', 'Road Atlanta');
INSERT INTO Events (EventID, EventName,Series, EventDate, Location) VALUES (3, 'Michelin GT Ford Mustang Challenge', 'IMSA', '2025', 'Verginia International Raceway');
INSERT INTO Events (EventID, EventName,Series, EventDate, Location) VALUES (4, 'Michelin GT MX5 Cup', 'IMSA', '2025', 'Verginia International Raceway');
INSERT INTO Events (EventID, EventName,Series, EventDate, Location) VALUES (5, 'Michelin GT Pilot Challenge', 'IMSA', '2025', 'Verginia International Raceway');
INSERT INTO Events (EventID, EventName,Series, EventDate, Location) VALUES (6, 'Michelin GT VP Racing Sportscar', 'IMSA', '2025', 'Verginia International Raceway');
INSERT INTO Events (EventID, EventName,Series, EventDate, Location) VALUES (7, 'Michelin GT Weathertech Sportscar', 'IMSA', '2025', 'Verginia International Raceway');
INSERT INTO Events (EventID, EventName,Series, EventDate, Location) VALUES (8, 'GT America', 'SRO', '2025', 'Barber Motorsports Park');
INSERT INTO Events (EventID, EventName,Series, EventDate, Location) VALUES (9, 'GT World Challange America', 'SRO', '2025', 'Barber Motorsports Park');
INSERT INTO Events (EventID, EventName,Series, EventDate, Location) VALUES (10, 'GT4 America', 'SRO', '2025', 'Barber Motorsports Park');
INSERT INTO Events (EventID, EventName,Series, EventDate, Location) VALUES (11, 'TC America', 'SRO', '2025', 'Barber Motorsports Park');
INSERT INTO Events (EventID, EventName,Series, EventDate, Location) VALUES (12, 'Toyota GR Cup', 'SRO', '2025', 'Barber Motorsports Park');
INSERT INTO Events (EventID, Series, EventDate, Location) VALUES (13, 'SVRA', '2025', 'Road Atlanta');
INSERT INTO Events (EventID, EventName,Series, EventDate, Location) VALUES (14, 'TA-GT', 'Trans-AM', '2025', 'Road Atlanta');
INSERT INTO Events (EventID, EventName,Series, EventDate, Location) VALUES (15, 'TA2', 'Trans-AM', '2025', 'Road Atlanta');

-- Images
-- Classic 24 at Daytona, 2024
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (1, 1, '/images/Photos/HSR/Classic 24 at Daytona 2024/_DSC9396', X'e302e23b1ad11fbdb6aedb0e53660bcc', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (2, 1, '/images/Photos/HSR/Classic 24 at Daytona 2024/_DSC9419', X'8ca5de5f4b4a2061a793707cd1b59c12', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (3, 1, '/images/Photos/HSR/Classic 24 at Daytona 2024/_DSC9429', X'ba839331e073bb0f46a59f81d8d70ea4', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (4, 1, '/images/Photos/HSR/Classic 24 at Daytona 2024/_DSC9467', X'af2a328f19b7882e6857a9d52cf889e0', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (5, 1, '/images/Photos/HSR/Classic 24 at Daytona 2024/_DSC9482', X'0892a22c4e83821c31644799adf65860', 1.00);
 INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (6, 1, '/images/Photos/HSR/Classic 24 at Daytona 2024/_DSC9490 1', X'309bf9b3526398ceb57ce746937f3763', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (7, 1, '/images/Photos/HSR/Classic 24 at Daytona 2024/_DSC9512', X'357ccb73e6bb35f61609c5eda135d962', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (8, 1, '/images/Photos/HSR/Classic 24 at Daytona 2024/_DSC9531', X'c67b4a613de259ae37805361d46fc22d', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (9, 1, '/images/Photos/HSR/Classic 24 at Daytona 2024/_DSC9538', X'61196e60f7e4fc6d3cb3e3edda4f356b', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (10, 1, '/images/Photos/HSR/Classic 24 at Daytona 2024/_DSC9693', X'0ce48b73a262e823acae22fc5fd082d3', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (11, 1, '/images/Photos/HSR/Classic 24 at Daytona 2024/_DSC9695', X'570eb1dd796d4f1d68d5422627f34972', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (12, 1, '/images/Photos/HSR/Classic 24 at Daytona 2024/_DSC9701', X'0da6997e1cac7b907588b7f49a4de58d', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (13, 1, '/images/Photos/HSR/Classic 24 at Daytona 2024/_DSC9710', X'45837e41375612c2cd5bc6d9f3bd150e', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (14, 1, '/images/Photos/HSR/Classic 24 at Daytona 2024/DSC07601', X'0f8399393d95622818194aff5f16b978', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (15, 1, '/images/Photos/HSR/Classic 24 at Daytona 2024/DSC07606', X'22f70829adcd1c2b8bcd8c3a51179804', 1.00);

-- The Mitty, 2025
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (16, 2, '/images/Photos/HSR/The Mitty 2025/_DSC3461', X'2cbbdc05f936c9fb1f31ae153e0c93d2', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (17, 2, '/images/Photos/HSR/The Mitty 2025/_DSC3491', X'61a76fa90ad9c00298c60a828dde586b', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (18, 2, '/images/Photos/HSR/The Mitty 2025/_DSC3498', X'c406aa03637749f991590a39c5281165', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (19, 2, '/images/Photos/HSR/The Mitty 2025/_DSC3584', X'2ef462461ca978aafad341341301f026', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (20, 2, '/images/Photos/HSR/The Mitty 2025/_DSC3588', X'a4f00e1dbc2b302ed684e115e0ebd63a', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (21, 2, '/images/Photos/HSR/The Mitty 2025/_DSC3610', X'6558665938d8b4bd0e1ea28a3a778284', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (22, 2, '/images/Photos/HSR/The Mitty 2025/_DSC3650', X'cc734f1c60fcd6deffbc029154a6042a', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (23, 2, '/images/Photos/HSR/The Mitty 2025/_DSC3694', X'37d20c382de63029dd5a27297fd2d03c', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (24, 2, '/images/Photos/HSR/The Mitty 2025/_DSC3829', X'721e750342f901381406f607aee5383b', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (25, 2, '/images/Photos/HSR/The Mitty 2025/_DSC3966', X'cd44f47d21ec96417c98b9c4631bf88d', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (26, 2, '/images/Photos/HSR/The Mitty 2025/_DSC3999', X'b18148d0acec73299629f8228959b46a', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (27, 2, '/images/Photos/HSR/The Mitty 2025/_DSC4029', X'6ad46bb554b9b5a6bd92a68dfe0f8159', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (28, 2, '/images/Photos/HSR/The Mitty 2025/_DSC4110', X'a2c8088500534e22d9f56a8fedfa1cfc', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (29, 2, '/images/Photos/HSR/The Mitty 2025/_DSC4111', X'b67ddf642cea321476c50dc6314b327f', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (30, 2, '/images/Photos/HSR/The Mitty 2025/_DSC4145', X'aa1d8b5ad9b3202fa21510d39f4dbe69', 1.00);

-- SVRA Road Atlanta, 2025
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (31, 13, '/images/Photos/SVRA/Road Atlanta 2025/DSC_0593', X'fbdef5fbe0cad48759f190b89cd808a0', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (32, 13, '/images/Photos/SVRA/Road Atlanta 2025/DSC_0594', X'285cbaf9271cd161a10dd1a0de5aa538', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (33, 13, '/images/Photos/SVRA/Road Atlanta 2025/DSC_0598', X'9a002887d459b662ff4aaf8be34b6d7b', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (34, 13, '/images/Photos/SVRA/Road Atlanta 2025/DSC_0603', X'2d85ba5f2109971794e0d4ace746dfcb', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (35, 13, '/images/Photos/SVRA/Road Atlanta 2025/DSC_0604', X'19aef5342880895e90014fc8ae7dc6fa', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (36, 13, '/images/Photos/SVRA/Road Atlanta 2025/DSC_0616', X'9964ef7b371e47023ce94eccee2159a9', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (37, 13, '/images/Photos/SVRA/Road Atlanta 2025/DSC_0621', X'da87236891b108f54b9dce3592976c73', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (38, 13, '/images/Photos/SVRA/Road Atlanta 2025/DSC_0655', X'ff5bae8e6c4b72bb9c1b3d874681eaf8', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (39, 13, '/images/Photos/SVRA/Road Atlanta 2025/DSC_0656', X'e0f66e0022fa6fa6605c65d9f5df9f1f', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (40, 13, '/images/Photos/SVRA/Road Atlanta 2025/DSC_0658', X'c6b765eead219c3b87ae804d92b6697b', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (41, 13, '/images/Photos/SVRA/Road Atlanta 2025/DSC_0730', X'fe61e0a62dbb7bbb20b01e271b6d506b', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (42, 13, '/images/Photos/SVRA/Road Atlanta 2025/DSC_0738', X'e17ba496e0ed4f3406b1602cf06f0944', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (43, 13, '/images/Photos/SVRA/Road Atlanta 2025/DSC_0740', X'34076e3a7ee72d6818f37e2cc3813946', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (44, 13, '/images/Photos/SVRA/Road Atlanta 2025/DSC_0754', X'9ad3ba174f6ff303926ba1b398bad32a', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (45, 13, '/images/Photos/SVRA/Road Atlanta 2025/DSC_0755', X'551edda8e0343b45363194364df9a20f', 1.00);

-- Trans-Am TA-GT, 2025
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (46, 14, '/images/Photos/Trans Am/Road Atlanta 2025/TA-GT/_DSC2664', X'193696e9f7f2ed1189e9668b62834194', 1.00);
 INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (47, 14, '/images/Photos/Trans Am/Road Atlanta 2025/TA-GT/_DSC2667 1', X'19277b611853036f85b27d2c02acfcc6', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (48, 14, '/images/Photos/Trans Am/Road Atlanta 2025/TA-GT/_DSC2669', X'ccab995b46f1c43dafa597172ee2da32', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (49, 14, '/images/Photos/Trans Am/Road Atlanta 2025/TA-GT/_DSC2675', X'47372462daa3cc76123661edcae4ded5', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (50, 14, '/images/Photos/Trans Am/Road Atlanta 2025/TA-GT/_DSC2686', X'7142dc87bafcddf9e10d6d65429a11c5', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (51, 14, '/images/Photos/Trans Am/Road Atlanta 2025/TA-GT/_DSC2703', X'cb9e71c4c4d6364200d02a4e0f26252b', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (52, 14, '/images/Photos/Trans Am/Road Atlanta 2025/TA-GT/_DSC2707', X'e622222a167fa6f4eee3efb6348855ea', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (53, 14, '/images/Photos/Trans Am/Road Atlanta 2025/TA-GT/_DSC2708', X'e7ea7e0f9273a0f8ec604263ad453ca8', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (54, 14, '/images/Photos/Trans Am/Road Atlanta 2025/TA-GT/_DSC2712', X'732a190e63cdc00f7c4bb1423ded1e77', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (55, 14, '/images/Photos/Trans Am/Road Atlanta 2025/TA-GT/_DSC2714', X'b4307d6624f4e8c4ff7445669dce736d', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (56, 14, '/images/Photos/Trans Am/Road Atlanta 2025/TA-GT/_DSC2727', X'd6c4adb48ae26c2879536f52ba0c4ba2', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (57, 14, '/images/Photos/Trans Am/Road Atlanta 2025/TA-GT/_DSC2728', X'0d312f6f97b94b63d9ee79d95ffb6d44', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (58, 14, '/images/Photos/Trans Am/Road Atlanta 2025/TA-GT/_DSC2734', X'105c8e952d64728408c2aa7c485e840d', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (59, 14, '/images/Photos/Trans Am/Road Atlanta 2025/TA-GT/_DSC2735', X'c4ca680900b68bab615422f12b5bbd62', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (60, 14, '/images/Photos/Trans Am/Road Atlanta 2025/TA-GT/_DSC2737', X'e1f7e7ca8622bb632589138d56a8f9b7', 1.00);

-- Trans-AM TA2, 2025
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (61, 15, '/images/Photos/Trans Am/Road Atlanta 2025/TA2/_DSC2532', X'c35a1064ba8cf9ef28a4bed34e7db923', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (62, 15, '/images/Photos/Trans Am/Road Atlanta 2025/TA2/_DSC2542', X'16cf07c56fca69cfc64acf92e4d293dd', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (63, 15, '/images/Photos/Trans Am/Road Atlanta 2025/TA2/_DSC2544', X'5c70ab2abcba40db951d57e37406a97c', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (64, 15, '/images/Photos/Trans Am/Road Atlanta 2025/TA2/_DSC2578', X'6465d6d0e923fdaa1f4b155599598f8e', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (65, 15, '/images/Photos/Trans Am/Road Atlanta 2025/TA2/_DSC3431', X'a4946bfcbfd8499c02bd12d00420c20c', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (66, 15, '/images/Photos/Trans Am/Road Atlanta 2025/TA2/_DSC3434', X'b5a02a9df2f9cca60f3280bc358f777c', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (67, 15, '/images/Photos/Trans Am/Road Atlanta 2025/TA2/_DSC3436', X'e78bfc3d325951741f2aaeb9221fc4d0', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (68, 15, '/images/Photos/Trans Am/Road Atlanta 2025/TA2/_DSC3441', X'39cb5963c95cffdaf1cbdb10639f0533', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (69, 15, '/images/Photos/Trans Am/Road Atlanta 2025/TA2/_DSC3452', X'51bc991035b970d7935b35a3c20e5cff', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (70, 15, '/images/Photos/Trans Am/Road Atlanta 2025/TA2/_DSC3454', X'5a07919bbcafb48d2132ba97eda7a572', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (71, 15, '/images/Photos/Trans Am/Road Atlanta 2025/TA2/DSC_0131', X'd72b71bfe70a5bb38d04a0f2acee112d', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (72, 15, '/images/Photos/Trans Am/Road Atlanta 2025/TA2/DSC_0172', X'ec968c8ce0d3ce039b6439c2c74d0800', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (73, 15, '/images/Photos/Trans Am/Road Atlanta 2025/TA2/DSC_0174', X'8b21cd805d8dbb99fe9045e35635767e', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (74, 15, '/images/Photos/Trans Am/Road Atlanta 2025/TA2/DSC_0175', X'6f29f1c227065cc6f835102c8c222342', 1.00);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (75, 15, '/images/Photos/Trans Am/Road Atlanta 2025/TA2/DSC_0176', X'322dddfdd0154fab4a7644820244de0a', 1.00);

-- IMSA Michelin GT Ford Mustang Challenge
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (76, 3, '/images/Photos/IMSA/Michelin GT Challenge at VIR - 2025/Ford Mustang Challenge/_DSC5696', X'f4990e403d619a7a62de7a4757ed21d9', 1.50);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (77, 3, '/images/Photos/IMSA/Michelin GT Challenge at VIR - 2025/Ford Mustang Challenge/_DSC5700', X'0cec896de46daf5df1d3f103c8c9d0ac', 1.50);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (78, 3, '/images/Photos/IMSA/Michelin GT Challenge at VIR - 2025/Ford Mustang Challenge/_DSC5701', X'53e4c7914f97b90d04032c629c1ccd77', 1.50);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (79, 3, '/images/Photos/IMSA/Michelin GT Challenge at VIR - 2025/Ford Mustang Challenge/_DSC5702', X'7251b188d9f96fbf895b9ec719632c99', 1.50);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (80, 3, '/images/Photos/IMSA/Michelin GT Challenge at VIR - 2025/Ford Mustang Challenge/_DSC5703', X'8ce0928609836970241bd3ac80b05432', 1.50);

-- IMSA Michelin GT MX5 Cup
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (81, 4, '/images/Photos/IMSA/Michelin GT Challenge at VIR - 2025/MX5 Cup/_DSC0555', X'd126827c74659fe50a4e006fb2f767a4', 1.25);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (82, 4, '/images/Photos/IMSA/Michelin GT Challenge at VIR - 2025/MX5 Cup/_DSC0556', X'a92d4c95506c2f225e9da0c25044b910', 1.25);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (83, 4, '/images/Photos/IMSA/Michelin GT Challenge at VIR - 2025/MX5 Cup/_DSC0557', X'406ccfb18980643f8f2d76523054e6cc', 1.25);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (84, 4, '/images/Photos/IMSA/Michelin GT Challenge at VIR - 2025/MX5 Cup/_DSC0565', X'fcd9ff168e94005ce02449bf415d65c1', 1.25);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (85, 4, '/images/Photos/IMSA/Michelin GT Challenge at VIR - 2025/MX5 Cup/_DSC0567', X'b31ac3fb831b4ecd81b9301fc520f4dd', 1.25);

-- IMSA Michelin GT Pilot Challenge
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (86, 5, '/images/Photos/IMSA/Michelin GT Challenge at VIR - 2025/Pilot Challenge/_DSC5538', X'a287294b320eaccc0b535bee67bdafc7', 1.75);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (87, 5, '/images/Photos/IMSA/Michelin GT Challenge at VIR - 2025/Pilot Challenge/_DSC5545', X'c62afc573bb6e7b298a00d9cecb1a304', 1.75);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (88, 5, '/images/Photos/IMSA/Michelin GT Challenge at VIR - 2025/Pilot Challenge/_DSC5549', X'1a9095e5d29f05896f4537c11aad4e57', 1.75);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (89, 5, '/images/Photos/IMSA/Michelin GT Challenge at VIR - 2025/Pilot Challenge/_DSC5566', X'b814fe9fd571c49c41624779c99c8efb', 1.75);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (90, 5, '/images/Photos/IMSA/Michelin GT Challenge at VIR - 2025/Pilot Challenge/_DSC5575', X'4b11ce3a01bd33b39892f487aa793305', 1.75);

-- IMSA Michelin GT VP Racing Sportscar
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (91, 6, '/images/Photos/IMSA/Michelin GT Challenge at VIR - 2025/VP Racing SportsCar Challenge/_DSC5783', X'd50f5e0ee63a9e36066863b9142678c2', 0.75);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (92, 6, '/images/Photos/IMSA/Michelin GT Challenge at VIR - 2025/VP Racing SportsCar Challenge/_DSC5784', X'7dc554f51acdc92f8e25e5fb0a9f10f0', 0.75);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (93, 6, '/images/Photos/IMSA/Michelin GT Challenge at VIR - 2025/VP Racing SportsCar Challenge/_DSC5785', X'8604ee3645c7318014551501d13855cc', 0.75);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (94, 6, '/images/Photos/IMSA/Michelin GT Challenge at VIR - 2025/VP Racing SportsCar Challenge/_DSC5786', X'd682e2e098edf6e4270df987cf942113', 0.75);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (95, 6, '/images/Photos/IMSA/Michelin GT Challenge at VIR - 2025/VP Racing SportsCar Challenge/_DSC5788', X'9bc19d4868112a8b09a1e2c089528507', 0.75);

-- IMSA Michelin GT Weathertech Sportscar
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (96, 7, '/images/Photos/IMSA/Michelin GT Challenge at VIR - 2025/Weathertech Sportscar Challenge/_DSC0105', X'5c3b51d6e58fd1ca7c2f4c358df27db7', 0.25);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (97, 7, '/images/Photos/IMSA/Michelin GT Challenge at VIR - 2025/Weathertech Sportscar Challenge/_DSC0109', X'bb978efea8ffba8bfb90022a65633710', 0.25);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (98, 7, '/images/Photos/IMSA/Michelin GT Challenge at VIR - 2025/Weathertech Sportscar Challenge/_DSC0119', X'7e6e474c4d43424513dbc11f9beaaafa', 0.25);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (99, 7, '/images/Photos/IMSA/Michelin GT Challenge at VIR - 2025/Weathertech Sportscar Challenge/_DSC0124', X'7323db79c4bdb20f1f8dc2f58ea442cd', 0.25);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (100, 7, '/images/Photos/IMSA/Michelin GT Challenge at VIR - 2025/Weathertech Sportscar Challenge/_DSC0128', X'8889b84728a108876f1ee781ce5a3e55', 0.25);

-- SRO GT America
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (101, 8, '/images/Photos/SRO Motorsports America/Barber Motorsports Park - 2025/GT America/_DSC0813', X'd4c44143e6e268ea73789779fd6a1c5a', 0.50);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (102, 8, '/images/Photos/SRO Motorsports America/Barber Motorsports Park - 2025/GT America/_DSC0816', X'5d25561239003c1e13906c0285536532', 0.50);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (103, 8, '/images/Photos/SRO Motorsports America/Barber Motorsports Park - 2025/GT America/_DSC0818', X'f6c488a4e5973d7519bbeaf4a292b64a', 0.50);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (104, 8, '/images/Photos/SRO Motorsports America/Barber Motorsports Park - 2025/GT America/_DSC0821', X'45a4da34613740a2e7d756a0f7b7c088', 0.50);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (105, 8, '/images/Photos/SRO Motorsports America/Barber Motorsports Park - 2025/GT America/_DSC0823', X'7d4c13251c7c7783d5dc1798a420cc54', 0.50);

-- SRO GT World Challenge America
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (106, 9, '/images/Photos/SRO Motorsports America/Barber Motorsports Park - 2025/GT World Challenge America/_DSC0159', X'2cf8316b20f7482c051eade9835a58a8', 0.99);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (107, 9, '/images/Photos/SRO Motorsports America/Barber Motorsports Park - 2025/GT World Challenge America/_DSC0160', X'30bb560127d2bf8f96d9ada65aa7e7eb', 0.99);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (108, 9, '/images/Photos/SRO Motorsports America/Barber Motorsports Park - 2025/GT World Challenge America/_DSC0161', X'9831a79a99f7fe7bde306c317e54967e', 0.99);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (109, 9, '/images/Photos/SRO Motorsports America/Barber Motorsports Park - 2025/GT World Challenge America/_DSC0163', X'e2a6ea8dd0d26f846cb8136818e96040', 0.99);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (110, 9, '/images/Photos/SRO Motorsports America/Barber Motorsports Park - 2025/GT World Challenge America/_DSC0164', X'54eef0445a6cdf91f808045709f2fe69', 0.99);

-- SRO GT4 America
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (111, 10, '/images/Photos/SRO Motorsports America/Barber Motorsports Park - 2025/GT4 America/_DSC0380', X'ebc830e3a6e9c0ca0b29a130e0b83ecd', 1.20);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (112, 10, '/images/Photos/SRO Motorsports America/Barber Motorsports Park - 2025/GT4 America/_DSC0382', X'28326b34e1e418d0fecde2f9cb97b3fa', 1.20);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (113, 10, '/images/Photos/SRO Motorsports America/Barber Motorsports Park - 2025/GT4 America/_DSC0386', X'e82aaba64f222af2019fbba73bc21638', 1.20);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (114, 10, '/images/Photos/SRO Motorsports America/Barber Motorsports Park - 2025/GT4 America/_DSC0399', X'6cf26e2dd90e12b433e99b61a84222f7', 1.20);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (115, 10, '/images/Photos/SRO Motorsports America/Barber Motorsports Park - 2025/GT4 America/_DSC0400', X'fa8eeabfd251defe00b3272ffea3d664', 1.20);

-- TC America
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (116, 11, '/images/Photos/SRO Motorsports America/Barber Motorsports Park - 2025/TC America/_DSC0774', X'94d9b15ac89b01a1ca0efeb91db001f1', 1.80);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (117, 11, '/images/Photos/SRO Motorsports America/Barber Motorsports Park - 2025/TC America/_DSC0775', X'4f8ad92aaeee2ee376c7e4611286dd2a', 1.80);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (118, 11, '/images/Photos/SRO Motorsports America/Barber Motorsports Park - 2025/TC America/_DSC0777', X'116f78cad6ebe296a07c99a21854c054', 1.80);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (119, 11, '/images/Photos/SRO Motorsports America/Barber Motorsports Park - 2025/TC America/_DSC0779', X'792d193032f9ce02e2bfb8a4c7936e2c', 1.80);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (120, 11, '/images/Photos/SRO Motorsports America/Barber Motorsports Park - 2025/TC America/_DSC0802', X'52bcb7939cf3a933c3cc5f43efcf4c88', 1.80);

-- Toyota GR Cup
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (121, 12, '/images/Photos/SRO Motorsports America/Barber Motorsports Park - 2025/Toyota GR Cup/_DSC0038', X'a02cd77d350b33edcbef3dec48c1aa95', 1.11);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (122, 12, '/images/Photos/SRO Motorsports America/Barber Motorsports Park - 2025/Toyota GR Cup/_DSC0040', X'3726c3a2db9e704c8768dc8407036979', 1.22);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (123, 12, '/images/Photos/SRO Motorsports America/Barber Motorsports Park - 2025/Toyota GR Cup/_DSC0042', X'e6fb23ed63cc97bff5baf725f8cc1685', 1.44);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (124, 12, '/images/Photos/SRO Motorsports America/Barber Motorsports Park - 2025/Toyota GR Cup/_DSC0046', X'c926359178c64e0e19f3e87c12b550b1', 1.66);
INSERT INTO Images (ImageID, EventID, FilePath, Checksum, Cost) VALUES (125, 12, '/images/Photos/SRO Motorsports America/Barber Motorsports Park - 2025/Toyota GR Cup/_DSC0048', X'4d1adad9cdc9f428e9e20008f20e0a5d', 1.88);


-- Subjects (optional)
-- INSERT INTO Subjects (SubjectID, DriverName)
-- VALUES (, '');

-- Junction table last
-- INSERT INTO PhotoSubjects (ImageID, SubjectID)
-- VALUES (, );

COMMIT;