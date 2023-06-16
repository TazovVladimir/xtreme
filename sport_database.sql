-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jun 16, 2023 at 06:46 AM
-- Server version: 5.6.51
-- PHP Version: 7.1.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sport_database`
--

-- --------------------------------------------------------

--
-- Table structure for table `all_catalog`
--

CREATE TABLE `all_catalog` (
  `id` int(255) NOT NULL,
  `category` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `sex` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` varchar(500) NOT NULL,
  `old_price` int(255) NOT NULL,
  `new_price` int(255) NOT NULL,
  `size` int(255) NOT NULL,
  `color` varchar(255) NOT NULL,
  `count_in_store` int(255) NOT NULL,
  `count` int(255) NOT NULL,
  `manufacturer` varchar(255) NOT NULL,
  `material` varchar(255) NOT NULL,
  `weight` int(255) NOT NULL,
  `img1` varchar(255) NOT NULL,
  `img2` varchar(255) NOT NULL,
  `img3` varchar(255) NOT NULL,
  `img4` varchar(255) NOT NULL,
  `img5` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `all_catalog`
--

INSERT INTO `all_catalog` (`id`, `category`, `type`, `sex`, `title`, `description`, `old_price`, `new_price`, `size`, `color`, `count_in_store`, `count`, `manufacturer`, `material`, `weight`, `img1`, `img2`, `img3`, `img4`, `img5`) VALUES
(1, 'clothes', 'jackets', 'мужской', 'Dickies New Sarpy', 'New Sarpy Jacket - прочный бомбер с капюшоном с классической отделкой и обработкой.', 0, 4500, 56, 'black', 10, 0, 'Dickies', '100% полиамид', 0, 'dickies-new-sarpy1.jpg', 'dickies-new-sarpy2.jpg', 'dickies-new-sarpy3.jpg', 'dickies-new-sarpy4.jpg', 'dickies-new-sarpy5.jpg'),
(2, 'clothes', 'jackets', 'мужской', 'Dickies Waldenburg', 'Waldenburg — это элегантная зимняя куртка из прочного и легкого рипстопа с прочным водоотталкивающим покрытием и карманами из полярного флиса и подкладкой воротника, что делает эту теплую и удобную непромокаемую куртку для любой осенней и зимней погоды.', 0, 6610, 60, 'white', 3, 0, 'Dickies', 'ЛЕГКИЙ РИПСТОП, 100% НЕЙЛОН, 45 ГСМ', 0, 'dickies-waldenburg1.jpg', 'dickies-waldenburg2.jpg', 'dickies-waldenburg3.jpg', 'dickies-waldenburg4.jpg', 'dickies-waldenburg5.jpg'),
(3, 'clothes', 't_shirt', 'мужской', 'Nike Strike 22', 'В футболке Nike Jersey Strike 22 ты будешь чувствовать комфорт и уверенность в себе даже во время самых напряженных матчей', 5000, 3800, 52, 'black', 1, 0, 'Nike', '100% полиэстер', 0, 'nike-strike1.jpg', 'nike-strike2.jpg', '', '', ''),
(4, 'clothes', 't_shirt', 'мужской', 'O´neill Wetsuits', 'Недавно модернизированный Reactor 2 спроектирован для обеспечения максимальной производительности. Идеальное сочетание растяжения и долговечности. Свежие цвета и графика со стилем, который создан, чтобы длиться долго.', 0, 2800, 48, 'black', 64, 0, 'O´neill', '100% полиэстер', 0, 'O_neill1.jpg', 'O_neill2.jpg', '', '', ''),
(5, 'clothes', 'jackets', 'мужской', 'Powerslide Long', 'Мужской трикотаж Powerslides с длинным рукавом разработан, чтобы держать вас в тепле, оставаясь при этом аэродинамическим.', 0, 6544, 60, 'blue', 32, 0, 'Powerslide', 'Легкий высокоэластичный неопрен Superflex толщиной 2 мм.', 0, 'powerslide-long-sleeve1.jpg', 'powerslide-long-sleeve2.jpg', 'powerslide-long-sleeve3.jpg', 'powerslide-long-sleeve4.jpg', ''),
(6, 'clothes', 'jackets', 'мужской', 'Billabong Absolute', 'Верх гидрокостюма с длинным рукавом Absolute Jack для мужчин 2/2 мм.', 0, 4000, 65, 'blue', 5, 0, 'Billabong', 'Легкий высокоэластичный неопрен Superflex толщиной 2 мм.\r\n80% неопрен, 20% нейлон.', 0, 'billabong-absolute1.jpg', 'billabong-absolute2.jpg', '', '', ''),
(7, 'clothes', 'jackets', 'мужской', 'Dickies Crafted Camo', 'Изготовленная камуфляжная куртка.', 6434, 5433, 56, 'black', 0, 0, 'Dickies', 'Материал: 100% полиамид', 0, 'dickies-crafted-camo1.jpg', 'dickies-crafted-camo2.jpg', 'dickies-crafted-camo3.jpg', 'dickies-crafted-camo4.jpg', 'dickies-crafted-camo5.jpg'),
(8, 'clothes', 't_shirt', 'мужской', 'Billabong Unity', 'Мужская футболка с коротким рукавом Unity Stacked.', 0, 999, 68, 'white', 0, 0, 'Billabong', 'Ткань хлопчатобумажная (160 г / м2).', 0, 'billabong-unity-stacked1.jpg', 'billabong-unity-stacked2.jpg', '', '', ''),
(9, 'clothes', 't_shirt', 'мужской', 'Nike Strike 22', 'Emerica Indy Bar Футболка с коротким рукавом', 1766, 1500, 50, 'white', 0, 0, 'Emerica', '100% хлопок', 0, 'emerica-indy-bar1.jpg', '', '', '', ''),
(10, 'clothes', 'trousers', 'мужской', 'Kappa Vant', 'Мужские леггинсы VANT относятся к спортивной коллекции Kappa. Идеально подходит для тренировок в холодном климате.', 0, 999, 56, 'black', 5, 0, 'Kappa', '88% полиэстер, 12% эластан', 0, 'kappa-vant1.jpg', '', '', '', ''),
(11, 'clothes', 'trousers', 'мужской', 'Sixs PNX WB Merinos', 'Sixs PNX WB Merinos Длинные брюки', 0, 4500, 50, 'black', 0, 0, 'Sixs', 'Ткань', 0, 'sixs-pnx-wb-merinos1.jpg', '', '', '', ''),
(12, 'clothes', 'trousers', 'мужской', 'Powerslide Team', 'Мужские гоночные костюмы Powerslides предназначены для разрезания воздуха', 0, 5555, 68, 'blue', 5, 0, 'Powerslide', '88% полиэстер, 12% эластан', 0, 'powerslide-team1.jpg', 'powerslide-team2.jpg', 'powerslide-team3.jpg', '', ''),
(13, 'clothes', 'trousers', 'мужской', 'Billabong Operator', 'Billabong Operator Graphene Леггинсы', 2382, 2000, 56, 'black', 19, 0, 'Billabong', 'Переработанный полиэстер и эластан с графеном', 0, 'billabong-operator-graphene1.jpg', 'billabong-operator-graphene2.jpg', '', '', ''),
(14, 'shoes', 'sneakers', 'мужской', 'adidas Sportswear', 'adidas Sportswear VS Pace Кросовки', 0, 2400, 43, 'white', 0, 0, 'adidas', 'Синтетическая кожа 3 полосы на внешней стороне', 700, 'adidas-sportswear-vs-pace1.jpg', 'adidas-sportswear-vs-pace2.jpg', 'adidas-sportswear-vs-pace3.jpg', 'adidas-sportswear-vs-pace4.jpg', 'adidas-sportswear-vs-pace5.jpg'),
(15, 'shoes', 'boots', 'мужской', 'Dc Shoes Peary', 'Зимние мужские ботинки на шнуровке из жемчужной кожи', 0, 4500, 44, 'black', 9, 0, 'Dc Shoes', 'Кожаные зимние ботинки', 800, 'dc-shoes-peary1.jpg', 'dc-shoes-peary2.jpg', 'dc-shoes-peary3.jpg', 'dc-shoes-peary4.jpg', 'dc-shoes-peary5.jpg'),
(16, 'shoes', 'sneakers', 'мужской', 'Dc Shoes Woodland', 'Мужские кожаные ботинки с подкладкой из шерпы', 4985, 4500, 42, 'brown', 0, 0, 'Dc Shoes', 'Кожа/Подкладка Текстиль/Подошва Резина', 750, 'dc-shoes-woodland1.jpg', 'dc-shoes-woodland2.jpg', 'dc-shoes-woodland3.jpg', 'dc-shoes-woodland4.jpg', 'dc-shoes-woodland5.jpg'),
(17, 'inventory', 'skateboard', 'унисекс', 'Marvel Wooden 31', 'БОЛЬШОЙ ДЕРЕВЯННЫЙ СКЕЙТБОРД MARVEL COMICS. Деревянный скейтборд, украшенный модными узорами Marvel. Идеально подходит для использования на тротуарах, площадях и городских аллеях', 0, 2500, 31, 'white', 11, 0, 'Marvel', '9-слойная кленовая древесина Алюминий', 2400, 'marvel-wooden-31-1.jpg', 'marvel-wooden-31-2.jpg', 'marvel-wooden-31-3.jpg', 'marvel-wooden-31-4.jpg', ''),
(18, 'inventory', 'skateboard', 'унисекс', 'Globe Goodstock', 'Classic Resin 7 Hard Rock клен в комплекте с подшипниками ABEC 7', 5775, 4500, 31, 'black', 3, 0, 'Globe', 'Дерево', 2500, 'globe-goodstock-8.13-1.jpg', 'globe-goodstock-8.13-2.jpg', 'globe-goodstock-8.13-3.jpg', 'globe-goodstock-8.13-4.jpg', ''),
(19, 'inventory', 'skateboard', 'унисекс', 'Street Surfing Wave', 'Street surfing Wave Original Radiance Оригинальная волновая доска Radiance.', 5161, 3765, 34, 'black', 3, 0, 'Street Surfing', 'Пластмасса', 2000, 'street-surfing-wave-original-radiance-1.jpg', 'street-surfing-wave-original-radiance-2.jpg', 'street-surfing-wave-original-radiance-3.jpg', 'street-surfing-wave-original-radiance-4.jpg', 'street-surfing-wave-original-radiance-5.jpg'),
(20, 'inventory', 'skateboard', 'унисекс', 'Tony Hawk SS 180', 'ONY HAWK SS 180 Complete Captain Mini Skateboard 7.375´´ Multicolor — это высококачественный скейтборд, разработанный для фристайла. Компактный размер 7,375 дюйма идеально подходит для молодых райдеров или тех, кто предпочитает меньшую доску.', 0, 3000, 29, 'black', 26, 0, 'Tony Hawk', 'Дерево', 2400, 'tony-hawk-ss-180-1.jpg', 'tony-hawk-ss-180-2.jpg', '', '', ''),
(21, 'inventory', 'roller_skates', 'унисекс', 'Powerslide Next Core', 'Powerslide Next Core Black 80 Это одни из лучших хардшелл коньков 80 мм.', 0, 6000, 45, 'black', 6, 0, 'Powerslide', 'пластик, армированный стекловолокном', 1500, 'powerslide-next-core-80-1.jpg', 'powerslide-next-core-80-2.jpg', 'powerslide-next-core-80-3.jpg', 'powerslide-next-core-80-4.jpg', 'powerslide-next-core-80-5.jpg'),
(22, 'inventory', 'roller_skates', 'унисекс', 'Usd Skates Sway', 'Модель USD Sway 57 мм можно охарактеризовать как:\r\nстильный, с чистым и простым дизайном и отличными функциями, которые вы можете получить за свои деньги.\r\nМожет быть, лучший стартовый агрессивный скейт.', 0, 3056, 38, 'white', 33, 0, 'Usd', 'пластик, армированный стекловолокном', 1777, 'usd-skates-sway-57-1.jpg', 'usd-skates-sway-57-2.jpg', 'usd-skates-sway-57-3.jpg', 'usd-skates-sway-57-4.jpg', 'usd-skates-sway-57-5.jpg'),
(23, 'inventory', 'roller_skates', 'унисекс', 'Rollerblade RB DA', 'RB DA отлично подходит для тех, кто хочет чего-то сложного, маневренного и быстрого с технологией RB. Этот модернизированный коньк RB оснащен водородными колесами и подшипниками Twincam для повышенной производительности', 0, 4333, 41, 'black', 5, 0, 'Rollerblade', 'пластик, армированный стекловолокном', 1600, 'rollerblade-rb-da-1.jpg', 'rollerblade-rb-da-2.jpg', 'rollerblade-rb-da-3.jpg', 'rollerblade-rb-da-4.jpg', 'rollerblade-rb-da-5.jpg'),
(24, 'inventory', 'helmet', 'унисекс', 'POC Obex MIPS', 'Obex MIPS Helmet - это шлем для взрослых, рекомендованный для занятий зимними видами спорта, например, для катания на горных лыжах. Среди особенностей, которые вы найдете в этой модели, выделяется ее легкая конструкция с покрытием EPS', 2843, 2600, 52, 'black', 0, 0, 'POC', 'пластмасса', 1400, 'poc-obex-mips-1.jpg', 'poc-obex-mips-2.jpg', 'poc-obex-mips-3.jpg', 'poc-obex-mips-4.jpg', ''),
(25, 'inventory', 'snowboard', 'унисекс', 'Burton Custom X', 'Pro-caliber — это сильное заявление для любой доски, но мужские сноуборды Burton Custom X Snowboard неоднократно доставляли удовольствие самым требовательным сноубордистам благодаря точному дизайну и мощному двигателю.', 0, 5220, 154, 'black', 4, 0, 'Burton', 'дерево, стекловолокно, с дополнительными усилениями из углепластика и кевлара', 3000, 'burton-custom-x-1.jpg', '', '', '', ''),
(26, 'inventory', 'ski', 'унисекс', 'Line Wallisch Shorty', 'Со всеми технологиями своего старшего брата, LINE Tom Wallisch Shorty обладает солидным ударом в упаковке размером с пинту. Обладая тем же легким весом и ощущением бомбардировщика, что и TW Pro, TW Shorty обеспечивает высокую производительность, необходимую для тренировок следующей супернеизвестной суперзвезды', 9854, 9500, 139, 'black', 6, 0, 'Line', 'деревянного сердечника: макроблок осины', 840, 'line-wallisch-shorty-1.jpg', 'line-wallisch-shorty-2.jpg', 'line-wallisch-shorty-3.jpg', 'line-wallisch-shorty-4.jpg', 'line-wallisch-shorty-5.jpg'),
(27, 'inventory', 'helmet', 'унисекс', 'K2 Skate Varsity', 'K2 SKATE Varsity Pro Helmet Grey — идеальный выбор для любителей скейтборда, которые хотят оставаться в безопасности на улицах. Изготовленный из высококачественных материалов, этот шлем обеспечивает превосходную защиту головы, независимо от того, насколько сильно вы напрягаетесь', 3221, 3032, 52, 'white', 0, 0, 'K2', 'пластмасса', 1200, 'k2-skate-varsity-pro-1.jpg', 'k2-skate-varsity-pro-2.jpg', '', '', ''),
(28, 'inventory', 'ski', 'унисекс', 'Rossignol Sender 94', 'Настоящие лыжи для фрирайда. Когда вас манят свежие трассы, новый Sender 94 Ti сочетает в себе легкость и маневренность, а также производительность на спуске по мокрой дороге, что дает вам свободу исследовать и кататься на подходах и выездах', 4356, 3322, 186, 'grey', 0, 0, 'Rossignol', 'деревянного сердечника: макроблок осины', 840, 'rossignol-sender-94-1.jpg', 'rossignol-sender-94-2.jpg', 'rossignol-sender-94-3.jpg', 'rossignol-sender-94-4.jpg', ''),
(29, 'inventory', 'snowboard', 'унисекс', 'Burton Instigator', 'Если вы ищете свой первый сноуборд , решение должно быть единодушным: Burton Instigator Flat Top . Эта эффективная и инновационная доска идеально подходит для райдеров, которые хотят легкого движения без суеты в гору, с отличной гибкостью и долговечностью, как ее главными достоинствами.', 0, 5443, 140, 'black', 42, 0, 'Burton', 'дерево, стекловолокно, с дополнительными усилениями из углепластика и кевлара', 3000, 'burton-instigator-1.jpg', '', '', '', ''),
(30, 'inventory', 'skateboard', 'унисекс', 'Playlife Vinyl', 'Со скейтбордом Playlife Vinyl Classic White вы можете путешествовать по своему городу и исследовать его. Это небольшая доска на 22 дюйма, которую легко носить с собой, и при необходимости с высокой скоростью', 0, 2300, 30, 'white', 2, 0, 'Playlife', 'Дерево', 2100, 'playlife-vinyl-classic-22-1.jpg', 'playlife-vinyl-classic-22-2.jpg', 'playlife-vinyl-classic-22-3.jpg', 'playlife-vinyl-classic-22-4.jpg', ''),
(31, 'inventory', 'ski', 'унисекс', 'Head Absolut Joy SLR', 'Удобный в использовании Absolut Joy имеет легкую, но прочную конструкцию и форму, которая делает короткие повороты взрывными. С помощью absolut Joy вы можете резать вельвет и делать из снега железнодорожные пути. Разработанный для передней части, Absolute Joy имеет деревянный сердечник и легкую конструкцию из материалов, которые ценятся за их высокое соотношение прочности и веса. Наконечник-рокер и тонкая талия делают начало поворота легким для грумеров', 0, 7641, 153, 'white', 15, 0, 'Head', 'деревянного сердечника: макроблок осины', 840, 'head-absolut-joy-slr-joy-1.jpg', 'head-absolut-joy-slr-joy-2.jpg', 'head-absolut-joy-slr-joy-3.jpg', 'head-absolut-joy-slr-joy-4.jpg', 'head-absolut-joy-slr-joy-5.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `id` int(255) NOT NULL,
  `user_id` int(255) NOT NULL,
  `item_id` int(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `price` int(255) NOT NULL,
  `img` varchar(255) NOT NULL,
  `color` varchar(255) NOT NULL,
  `size` int(255) NOT NULL,
  `quantity` int(255) NOT NULL,
  `selected` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`id`, `user_id`, `item_id`, `title`, `price`, `img`, `color`, `size`, `quantity`, `selected`) VALUES
(1, 7, 33, '111', 1111, 'about-anime-7bc8eacf.png', 'black', 40, 2, 'true'),
(8, 13, 30, 'Playlife Vinyl', 2300, 'playlife-vinyl-classic-22-1.jpg', 'white', 30, 1, 'true'),
(10, 8, 22, 'Usd Skates Sway', 3056, 'usd-skates-sway-57-1.jpg', 'white', 38, 1, 'false'),
(12, 8, 17, 'Marvel Wooden 31', 2500, 'marvel-wooden-31-1.jpg', 'white', 31, 3, 'false'),
(15, 9, 20, 'Tony Hawk SS 180', 3000, 'tony-hawk-ss-180-1.jpg', 'black', 29, 1, 'false'),
(16, 9, 8, 'Billabong Unity', 999, 'billabong-unity-stacked1.jpg', 'white', 68, 2, 'false'),
(18, 7, 47, 'Дамир', 1000, '8ebe5d3e-003b-4cf2-9501-487d8552594b.jpg', 'white', 42, 1, 'true'),
(20, 9, 13, 'Billabong Operator', 2000, 'billabong-operator-graphene1.jpg', 'black', 56, 1, 'true');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(255) NOT NULL,
  `user_id` int(255) NOT NULL,
  `item_id` int(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `price` int(255) NOT NULL,
  `img` varchar(255) NOT NULL,
  `color` varchar(255) NOT NULL,
  `size` int(255) NOT NULL,
  `quantity` int(255) NOT NULL,
  `status` varchar(255) NOT NULL,
  `point` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `item_id`, `title`, `price`, `img`, `color`, `size`, `quantity`, `status`, `point`) VALUES
(83, 7, 27, 'K2 Skate Varsity', 9096, 'k2-skate-varsity-pro-1.jpg', 'white', 52, 3, 'accepted', 'Пункт выдачи №2'),
(84, 12, 13, 'Billabong Operator', 2000, 'billabong-operator-graphene1.jpg', 'black', 56, 1, 'completed', 'Пункт выдачи №1'),
(85, 12, 3, 'Nike Strike 22', 3800, 'nike-strike1.jpg', 'black', 52, 1, 'send', 'Пункт выдачи №1'),
(86, 7, 7, 'Dickies Crafted Camo', 5433, 'dickies-crafted-camo1.jpg', 'black', 56, 1, 'completed', 'Пункт выдачи №4'),
(87, 7, 21, 'Powerslide Next Core', 12000, 'powerslide-next-core-80-1.jpg', 'black', 45, 2, 'completed', 'Пункт выдачи №1'),
(88, 7, 12, 'Powerslide Team', 11110, 'powerslide-team1.jpg', 'blue', 68, 2, 'send', 'Пункт выдачи №1'),
(89, 7, 30, 'Playlife Vinyl', 2300, 'playlife-vinyl-classic-22-1.jpg', 'white', 30, 1, 'send', 'Пункт выдачи №4'),
(90, 7, 25, 'Burton Custom X', 10440, 'burton-custom-x-1.jpg', 'black', 154, 2, 'completed', 'Пункт выдачи №2'),
(91, 7, 32, '234234', 846, '84f81484-ccc5-4ec7-ab4d-2573634326d7.jpg', 'white', 40, 2, 'completed', 'Пункт выдачи №2'),
(92, 7, 15, 'Dc Shoes Peary', 4500, 'dc-shoes-peary1.jpg', 'black', 44, 1, 'completed', 'Проспект Мира, 71/23'),
(93, 7, 13, 'Billabong Operator', 4000, 'billabong-operator-graphene1.jpg', 'black', 56, 2, 'send', 'Комарова, 13'),
(94, 13, 25, 'Burton Custom X', 10440, 'burton-custom-x-1.jpg', 'black', 154, 2, 'completed', 'Проспект Мира, 71/23'),
(95, 13, 21, 'Powerslide Next Core', 6000, 'powerslide-next-core-80-1.jpg', 'black', 45, 1, 'completed', 'Комарова, 13'),
(96, 13, 15, 'Dc Shoes Peary', 4500, 'dc-shoes-peary1.jpg', 'black', 44, 1, 'completed', 'Цветочный бульвар, 8'),
(97, 13, 3, 'Nike Strike 22', 3800, 'nike-strike1.jpg', 'black', 52, 1, 'send', 'Цветочный бульвар, 8'),
(98, 13, 17, 'Marvel Wooden 31', 5000, 'marvel-wooden-31-1.jpg', 'white', 31, 2, 'accepted', 'Проспект Мира, 71/23'),
(99, 8, 15, 'Dc Shoes Peary', 4500, 'dc-shoes-peary1.jpg', 'black', 44, 1, 'completed', 'Проспект Мира, 71/23'),
(100, 8, 7, 'Dickies Crafted Camo', 5433, 'dickies-crafted-camo1.jpg', 'black', 56, 1, 'completed', 'Проспект Мира, 71/23'),
(101, 8, 20, 'Tony Hawk SS 180', 3000, 'tony-hawk-ss-180-1.jpg', 'black', 29, 1, 'accepted', 'Проспект Мира, 71/23'),
(102, 9, 22, 'Usd Skates Sway', 3056, 'usd-skates-sway-57-1.jpg', 'white', 38, 1, 'completed', 'Проспект Мира, 71/23'),
(103, 9, 6, 'Billabong Absolute', 4000, 'billabong-absolute1.jpg', 'blue', 65, 1, 'send', 'Проспект Мира, 71/23'),
(104, 9, 3, 'Nike Strike 22', 7600, 'nike-strike1.jpg', 'black', 52, 2, 'accepted', 'Проспект Мира, 71/23');

-- --------------------------------------------------------

--
-- Table structure for table `point`
--

CREATE TABLE `point` (
  `id` int(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `latitude` float NOT NULL,
  `longitude` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `point`
--

INSERT INTO `point` (`id`, `name`, `latitude`, `longitude`) VALUES
(1, 'Пункт выдачи №1 \"4 - комплекс\"', 55.7334, 52.4059);

-- --------------------------------------------------------

--
-- Table structure for table `rev`
--

CREATE TABLE `rev` (
  `id` int(255) NOT NULL,
  `item_id` varchar(255) NOT NULL,
  `user_id` varchar(255) NOT NULL,
  `item_title` varchar(255) NOT NULL,
  `text` varchar(255) NOT NULL,
  `user_avatar` varchar(255) NOT NULL,
  `date` date NOT NULL,
  `user_name` varchar(255) NOT NULL,
  `status` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `rev`
--

INSERT INTO `rev` (`id`, `item_id`, `user_id`, `item_title`, `text`, `user_avatar`, `date`, `user_name`, `status`) VALUES
(6, '13', '7', 'Billabong Operator', 'Все отлично, мне понравились данные брюки', 'def.png', '2023-06-09', 'Владимир', 0),
(7, '16', '7', 'Dc Shoes Woodland', 'Маломерят', 'def.png', '2023-06-09', 'Владимир', 1),
(8, '31', '7', 'Head Absolut Joy SLR', 'Как раз хотел начать заниматься спортом!!', 'def.png', '2023-06-09', 'Владимир', 0),
(9, '20', '7', 'Tony Hawk SS 180', 'Неплохой борд', 'def.png', '2023-06-09', 'Владимир', 1),
(11, '7', '8', 'Dickies Crafted Camo', 'Классная куртка', 'd887c362-f469-476f-9181-5acba7e98be0.jpg', '2023-06-16', 'Денис', 1),
(12, '7', '13', 'Dickies Crafted Camo', 'Супер', 'ec8f35d6-6753-46f3-9808-6ff986359677.jpg', '2023-06-16', 'Леха', 1),
(13, '21', '13', 'Powerslide Next Core', 'Как раз хотел для лета купить', 'ec8f35d6-6753-46f3-9808-6ff986359677.jpg', '2023-06-16', 'Леха', 1),
(14, '19', '13', 'Street Surfing Wave', 'А я думал что это гироскутер', 'ec8f35d6-6753-46f3-9808-6ff986359677.jpg', '2023-06-16', 'Леха', 1),
(15, '30', '13', 'Playlife Vinyl', 'Это же лонгборд?', 'ec8f35d6-6753-46f3-9808-6ff986359677.jpg', '2023-06-16', 'Леха', 1),
(16, '14', '9', 'adidas Sportswear', 'не похоже на оригинал', '8ebe5d3e-003b-4cf2-9501-487d8552594b.jpg', '2023-06-16', 'Дамир', 1),
(17, '22', '9', 'Usd Skates Sway', 'все отлично', '8ebe5d3e-003b-4cf2-9501-487d8552594b.jpg', '2023-06-16', 'Дамир', 1),
(18, '13', '9', 'Billabong Operator', 'текст', '8ebe5d3e-003b-4cf2-9501-487d8552594b.jpg', '2023-06-16', 'Дамир', 1),
(19, '49', '9', '1', 'павпавпавпав', '8ebe5d3e-003b-4cf2-9501-487d8552594b.jpg', '2023-06-16', 'Дамир', 0);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `login` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `avatar` varchar(255) NOT NULL,
  `admin` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `login`, `password`, `avatar`, `admin`) VALUES
(7, 'Владимир', 'vladimir', '$2b$10$CGQI6ISzhZDDuTrPnezxcehIliGfQaIB5X6WdNJZjQKc/d20SBiu.', 'Bz8zf1aHDVi.jpg', 1),
(8, 'Денис', 'denis', '$2b$10$JUwLGP8EhgDthJaW.SRQRekR6HVrbXfPDkNFbnVJhq6k2b9Iqhrs.', 'd887c362-f469-476f-9181-5acba7e98be0.jpg', 0),
(9, 'Дамир', 'damir', '$2b$10$xVlwVILRoUgYhOLKNSMETemfpPyHO3I/gK7REbG/IxL176MGyjG.G', '8ebe5d3e-003b-4cf2-9501-487d8552594b.jpg', 0),
(10, 'Альмир', 'almir', '$2b$10$narUz6ecCG1VXPGWY04MH.LtZSY0j/LaNrVs//yW3gNUaEIz5ZkWC', 'almir.jpg', 0),
(11, 'Никита', 'nik', '$2b$10$0OJpvLC.gVAIRFP3Zc0viOyJ6vqG90gs.9RQHVdN2vpKTST.xEB4.', 'denis.jpg', 0),
(12, 'Никита', 'nikitata', '$2b$10$wikau4i4VrcMoBK5.W3ZyOHnSYJDJ6n9Qsk8ykt1QP2Q/3GJ3DtKW', 'def.png', 0),
(13, 'Леха', 'lexa', '$2b$10$ezQCzm9KKlw2BUcDhunFceWPVYfV7JIxiy252H1PnPY6k4o8F5E7K', 'ec8f35d6-6753-46f3-9808-6ff986359677.jpg', 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `all_catalog`
--
ALTER TABLE `all_catalog`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `point`
--
ALTER TABLE `point`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rev`
--
ALTER TABLE `rev`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `all_catalog`
--
ALTER TABLE `all_catalog`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=105;

--
-- AUTO_INCREMENT for table `point`
--
ALTER TABLE `point`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `rev`
--
ALTER TABLE `rev`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
