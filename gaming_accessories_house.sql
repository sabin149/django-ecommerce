-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 22, 2021 at 08:57 AM
-- Server version: 10.4.18-MariaDB
-- PHP Version: 7.3.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `gaming_accessories_house`
--

-- --------------------------------------------------------

--
-- Table structure for table `app_cart`
--

CREATE TABLE `app_cart` (
  `id` int(11) NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL CHECK (`quantity` >= 0),
  `product_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `app_cart`
--

INSERT INTO `app_cart` (`id`, `quantity`, `product_id`, `user_id`) VALUES
(10, 1, 14, 4);

-- --------------------------------------------------------

--
-- Table structure for table `app_category_choices`
--

CREATE TABLE `app_category_choices` (
  `id` int(11) NOT NULL,
  `title` varchar(200) NOT NULL,
  `slug` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `app_category_choices`
--

INSERT INTO `app_category_choices` (`id`, `title`, `slug`) VALUES
(1, 'Gaming Mouse', 'GamingMouse'),
(2, 'Gaming Headset', 'GamingHeadset'),
(3, 'Gaming Monitor', 'GamingMonitor'),
(4, 'Gaming Keyboard', 'GamingKeyboard'),
(5, 'Gaming Mobile', 'GamingMobile');

-- --------------------------------------------------------

--
-- Table structure for table `app_customer`
--

CREATE TABLE `app_customer` (
  `id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `address` varchar(200) NOT NULL,
  `city` varchar(200) NOT NULL,
  `zipcode` int(11) NOT NULL,
  `province` varchar(50) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `email` varchar(254) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `app_customer`
--

INSERT INTO `app_customer` (`id`, `name`, `address`, `city`, `zipcode`, `province`, `user_id`, `email`) VALUES
(1, 'Sabin', 'kym', 'ktm', 5, 'Province No. 2', 2, 'dangalsabin12@gmail.com'),
(2, 'Sabin Dangal', 'ktm', 'ktm', 12234, 'Gandaki Province', 4, 'dangalsabin12@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `app_orderplaced`
--

CREATE TABLE `app_orderplaced` (
  `id` int(11) NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL CHECK (`quantity` >= 0),
  `ordered_date` datetime(6) NOT NULL,
  `status` varchar(50) NOT NULL,
  `product_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `profile_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `app_orderplaced`
--

INSERT INTO `app_orderplaced` (`id`, `quantity`, `ordered_date`, `status`, `product_id`, `user_id`, `customer_id`, `profile_id`) VALUES
(1, 1, '2021-04-22 06:25:38.951641', 'Accepted', 15, 2, 1, 1),
(2, 5, '2021-04-22 06:25:54.457458', 'Accepted', 14, 2, 1, 1),
(3, 1, '2021-04-22 06:34:30.161155', 'Pending', 10, 4, 2, NULL),
(4, 1, '2021-04-22 06:37:35.204401', 'Pending', 6, 4, 2, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `app_product`
--

CREATE TABLE `app_product` (
  `id` int(11) NOT NULL,
  `title` varchar(200) NOT NULL,
  `slug` varchar(50) NOT NULL,
  `marked_price` int(11) NOT NULL,
  `selling_price` int(11) NOT NULL,
  `description` longtext NOT NULL,
  `brand` varchar(100) NOT NULL,
  `product_image` varchar(100) NOT NULL,
  `category_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `app_product`
--

INSERT INTO `app_product` (`id`, `title`, `slug`, `marked_price`, `selling_price`, `description`, `brand`, `product_image`, `category_id`) VALUES
(1, 'Logitech G502 Hero Gaming Mouse', 'LogitechG502', 50000, 49999, 'Hero 25K sensor through a software update from G HUB, this upgrade is free to all players: Our most advanced, with 1:1 tracking, 400+ ips, and 100 - 25,600 max dpi sensitivity plus zero smoothing, filtering, or acceleration', 'Logitech', 'productimg/logitech_9XftJDC.jpeg', 1),
(2, 'Razer Basilisk X HyperSpeed Wireless Gaming Mouse', 'RazerBasilisk', 45000, 42999, '25% Faster Than Competing Wireless Mice: The all-new, Razer HyperSpeed wireless technology brings together extreme low-latency and interference reduction for true wireless freedom', 'Razer', 'productimg/razer_FBFLxOY.jpeg', 1),
(3, 'Corsair Nightsword RGB Wireless Gaming Mouse', 'CorsairNightswordRGB', 20000, 19999, 'Corsair exclusive software automatically detects the center of gravity in real time, allowing you to adjust weight between 119g and 141g and fine tune balance to perfectly fit your grip', 'Corsair', 'productimg/corsair_E0sipk7.jpeg', 1),
(4, 'Redragon M901 Wired Gaming Mouse', 'RedragonM901WiredGamingMouse', 5000, 4999, 'WIRED GAMING MOUSE; built for PC Gamers -Optical Gaming Mouse up to 12400 DPI via software, 12000 FPS, 1000 Hz polling rate, 50G acceleration. The High-Precision Sensor delivers Pinpoint Accuracy while the Micro Switch ensure longevity, greater durability', 'Redragon', 'productimg/reddrag_XeHrFxG.jpeg', 1),
(5, 'Razer BlackWidow Elite Mechanical Gaming Keyboard', 'RazerBlackWidowElite', 15000, 14999, 'Zero-Compromise Mechanical Switch for Speed & Accuracy: Razer Orange switch technology provides tactile feedback with a quieter click, requiring 45 G of actuation force; ideal for most gaming and typing experiences', 'Razer', 'productimg/razer_67uIkc4.jpg', 4),
(6, 'Logitech G213 Prodigy Gaming Keyboard', 'LogitechG213Prodigy', 4000, 3999, 'Worlds NO. 1 Best Selling Gaming Gear Brand - Based on independent aggregated sales data (FEB ‘19 - FEB’20) of Gaming Keyboard, Mice, & PC Headset in units from: US, CA, CN, JP, KR, TW, TH, ID, DE, FR, RU, UK, SE, TR', 'Logitech', 'productimg/logitech_hHCTy3N.jpg', 4),
(7, 'Corsair K100 RGB Mechanical Gaming Keyboard', 'CorsairK100RGB', 10000, 9999, 'The Corsair K100 RGB is the pinnacle of Corsair keyboards, offering the cutting-edge performance, style, durability, and customization that gamers need to stand above the rest', 'Corsair', 'productimg/corsair_LoPsncM.jpg', 4),
(8, 'SteelSeries Apex 3 RGB Gaming Keyboard', 'SteelSeriesApex3RGBGamingKeyboard', 6000, 5999, 'Ip32 water resistant – Prevents accidental damage from liquid spills\r\n10-zone RGB illumination – Gorgeous color schemes and reactive effects\r\nWhisper quiet gaming switches – Nearly silent use for 20 million low friction keypresses', 'HyperX', 'productimg/hyperx_VD4MEJV.jpg', 4),
(9, 'LG Electronics UltraGear 27GN750-B Gaming Monitor', 'LGElectronics', 30000, 29999, '27” full HD (1920x1080) IPS display\r\n1ms response time and 240Hz refresh rate\r\nNVIDIA G-SYNC Compatible\r\nHDR 10 Compatible\r\n3-Side virtually borderless design\r\nTilt / Height / Pivot adjustable stand', 'LG', 'productimg/lg_9XCL4mC.jpeg', 3),
(10, 'Sceptre Curved 27\" 75Hz LED Gaming Monitor', 'SceptreCurved', 36000, 35000, '27\" Curved monitor up to 75Hz\r\nFast Response Time: Fast response times reduce ghosting & blurring while transitioning pixels, always keeping the enemy & terrain precisely in focus during chaotic moments.', 'Sceptre', 'productimg/sceptre_l6iFoJz.jpeg', 3),
(11, 'ASUS TUF Gaming 32\" 2K HDR Curved Monitor', 'ASUSTUFGaming', 45000, 39999, 'ASUS Extreme Low Motion Blur (ELMB ) technology enables a 1ms response time (MPRT) together with Adaptive-sync, eliminating ghosting and tearing for sharp gaming visuals with high frame rates.', 'ASUS', 'productimg/asustuf_45Dtl7e.jpeg', 3),
(12, 'MSI Full HD Non-Glare Gaming Monitor', 'MSIFullHDNon-Glare', 12700, 11999, 'STUNNING WQHD: Your gaming world, now astoundingly lifelike. Packing in 1.7 times the pixel density of Full HD, WQHD resolution boasts incredibly detailed, pin-sharp images. Experience a fuller view with more space to take in all the action | Operating Temperature: 10~40 ℃', 'MSI', 'productimg/msi_uvWI0I9.jpeg', 3),
(13, 'Razer Kraken Tournament Edition THX 7.1', 'RazerKrakenTournamentEditionTHX', 13000, 12999, 'THX 7.1 Surround Sound Capable: Provides industry-leading audio realism for in-game immersion by providing accurate spatial audio information beyond standard 7.1 surround sound directional cues', 'Razer', 'productimg/razer_49ROjva.jpg', 2),
(14, 'HyperX Cloud Stinger - Gaming Headset', 'HyperXCloudStingerGamingHeadset', 3000, 2999, 'No.1 selling PC gaming headset in the U.S. - Source: The NPD Group, Inc., U.S. retail tracking service, PC headsets, gaming designed, based on units, January-December 2019', 'HyperX', 'productimg/hyperx_leT3pRh.jpg', 2),
(15, 'Corsair HS60 PRO - 7.1 Virtual Surround Sound Gaming Headset', 'CorsairHS60PRO', 9500, 9499, 'Adjustable ear cups fitted with plush memory foam provide exceptional comfort for hours of gameplay\r\nHigh-quality custom-tuned 50mm neodymium Audio drivers deliver superb sound quality with the range to hear everything you need to on the battlefield', 'Corsair', 'productimg/logitech_pR8DkSZ.jpg', 2),
(16, 'ROCCAT Elo 7.1 USB Surround Sound RGB Gaming Headset', 'ROCCAT', 5000, 3999, 'Exceptional 7.1 Surround - Precision-tuned 50 millimeter neodymium drivers deliver exceptional 7.1 surround sound so you can pinpoint enemy locations for a clear competitive advantage', 'SteelSeries', 'productimg/steeelseries_2g1dJKz.jpg', 2),
(17, 'ASUS ZS600KL-S845-8G128G ROG Gaming Smartphone', 'ASUSZS600KL', 85000, 54999, 'The ROG Phone 3 Strix Edition uses the flagship Qualcomm Snapdragon 865 Mobile Platform with advanced 5G mobile communications capabilities. Built for dedicated gamers, it has an amazing new 144 Hz / 1 ms display that leaves the competition standing. Alongside slick features like AirTrigger 3, you’ll find a monster 6000 mAh battery, a unique side-charging design, dual front-facing stereo speakers, and a full range of modular accessories. ROG Phone 3 Strix Edition is everything you’ve always wanted for mobile gaming!', 'ASUS', 'productimg/rog-2_NP7eNlP.jpeg', 5),
(18, 'Nubia RedMagic 5G Gaming Phone', 'NubiaRedMagic5G', 85000, 84999, '【With 6.65 Inches Full HD】:Nubia RedMagic 5S Phone, 1080 x 2340 pixels, 19.5:9 ratio, Low blue light, TUV Rheinland low blue light certification, 144HZ high refresh rate, smooth without smear. Enjoy a smoother experience.', 'Redragon', 'productimg/redmagic_CUuDXye.jpg', 5),
(19, 'Samsung Electronics Galaxy Note 20', 'SamsungElectronicsGalaxyNote20', 95000, 94999, 'S Pen & Samsung Notes: Pen precision meets PC power with S Pen & Samsung Notes; So responsive, it feels like you\'re using a real pen; Jot notes, sketch ideas, then convert into Microsoft Word or PowerPoint, save and sync across all your Galaxy devices', 'Samsung', 'productimg/sam_6VqKGjf.jpeg', 5),
(20, 'Black Shark 3 Gaming Grey 5G Phone', 'BlackShark3', 50000, 49999, 'Network】: You can confirm the network frequency band by consulting the SIM card. (GSM/EDGE：B2(1900)/3(1800)/5(850)/8(900); UMTS/WCDMA: B1(2100)/2(1900)/4(1700/2100)/5(850)/6/8(900)/9(1900)/19(800); CDMA/EVDO：BC0 (800); LTE TDD: B34(2100)/B38(2100)/B39(2100)/40(2100)/41(2100); LTE FDD：B1(2100)/2(1900)/3(1800)/4(1700/2100)/5(850)/ 7', 'Shark', 'productimg/sha_dWr2VoT.jpeg', 5);

-- --------------------------------------------------------

--
-- Table structure for table `app_profile`
--

CREATE TABLE `app_profile` (
  `id` int(11) NOT NULL,
  `firstname` varchar(200) DEFAULT NULL,
  `lastname` varchar(200) DEFAULT NULL,
  `phone` varchar(10) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `email` varchar(254) NOT NULL,
  `profile_pic` varchar(100) NOT NULL,
  `created_date` datetime(6) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `username` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `app_profile`
--

INSERT INTO `app_profile` (`id`, `firstname`, `lastname`, `phone`, `address`, `email`, `profile_pic`, `created_date`, `user_id`, `username`) VALUES
(1, '', '', '', '', '', 'static/uploads/rog.png', '2021-04-22 05:40:35.853647', 2, 'sabin'),
(2, '', '', '', '', '', 'static/uploads/rog.png', '2021-04-22 06:27:12.966919', 3, 'sabin149'),
(3, 'Sabin', 'Dangal', '9968437868', 'kym', 'dangalsabin12@gmail.com', 'static/uploads/rog.png', '2021-04-22 06:27:30.779269', 4, 'sabin1');

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add category_choices', 7, 'add_category_choices'),
(26, 'Can change category_choices', 7, 'change_category_choices'),
(27, 'Can delete category_choices', 7, 'delete_category_choices'),
(28, 'Can view category_choices', 7, 'view_category_choices'),
(29, 'Can add product', 8, 'add_product'),
(30, 'Can change product', 8, 'change_product'),
(31, 'Can delete product', 8, 'delete_product'),
(32, 'Can view product', 8, 'view_product'),
(33, 'Can add customer', 9, 'add_customer'),
(34, 'Can change customer', 9, 'change_customer'),
(35, 'Can delete customer', 9, 'delete_customer'),
(36, 'Can view customer', 9, 'view_customer'),
(37, 'Can add cart', 10, 'add_cart'),
(38, 'Can change cart', 10, 'change_cart'),
(39, 'Can delete cart', 10, 'delete_cart'),
(40, 'Can view cart', 10, 'view_cart'),
(41, 'Can add profile', 11, 'add_profile'),
(42, 'Can change profile', 11, 'change_profile'),
(43, 'Can delete profile', 11, 'delete_profile'),
(44, 'Can view profile', 11, 'view_profile'),
(45, 'Can add order placed', 12, 'add_orderplaced'),
(46, 'Can change order placed', 12, 'change_orderplaced'),
(47, 'Can delete order placed', 12, 'delete_orderplaced'),
(48, 'Can view order placed', 12, 'view_orderplaced');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$216000$0v8POpVMsSSG$GyA+WQn6TBd48wt1KlIQ4NTu4HArRYOMjy+hLXQzZ9w=', '2021-04-22 06:39:39.779247', 1, 'admin', '', '', 'admin@gmail.com', 1, 1, '2021-04-22 05:40:10.833777'),
(2, 'pbkdf2_sha256$216000$nRX0f40TmecC$BOl2HF721Bx/Hsab10r1yUawJRPOY7PMHME41p6geQE=', '2021-04-22 06:26:19.552866', 0, 'sabin', '', '', 'sabin@gmail.com', 0, 1, '2021-04-22 05:40:35.717946'),
(3, 'pbkdf2_sha256$216000$q8W90JN2wYZ5$xwGOHkL0lEeAkscCTHUbzVj8p6/pJWd99puqnni0oek=', NULL, 0, 'sabin149', '', '', 'dangalsabin149@gmail.com', 0, 1, '2021-04-22 06:27:12.826469'),
(4, 'pbkdf2_sha256$216000$ZIZX6d679VJa$LAIr/I2Z5KBFf25CXaKGaDxNdp5G9GMZQRs5j7lVqOM=', '2021-04-22 06:27:51.906483', 0, 'sabin1', '', '', 'dangalsabin1@gmail.com', 0, 1, '2021-04-22 06:27:30.654641');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `django_admin_log`
--

INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
(1, '2021-04-22 06:19:25.117480', '5', '5 Razer BlackWidow Elite Mechanical Gaming Keyboard RazerBlackWidowElite 15000 14999 Razer Zero-Compromise Mechanical Switch for Speed & Accuracy: Razer Orange switch technology provides tactile feedb', 2, '[{\"changed\": {\"fields\": [\"Product image\"]}}]', 8, 1),
(2, '2021-04-22 06:25:38.955317', '1', 'Order: 1', 1, '[{\"added\": {}}]', 12, 1),
(3, '2021-04-22 06:25:54.458751', '2', 'Order: 2', 1, '[{\"added\": {}}]', 12, 1),
(4, '2021-04-22 06:26:06.044839', '6', '6', 3, '', 10, 1),
(5, '2021-04-22 06:26:06.047795', '5', '5', 3, '', 10, 1),
(6, '2021-04-22 06:26:06.052214', '3', '3', 3, '', 10, 1);

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(10, 'app', 'cart'),
(7, 'app', 'category_choices'),
(9, 'app', 'customer'),
(12, 'app', 'orderplaced'),
(8, 'app', 'product'),
(11, 'app', 'profile'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(6, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2021-04-22 05:39:22.560976'),
(2, 'auth', '0001_initial', '2021-04-22 05:39:22.691271'),
(3, 'admin', '0001_initial', '2021-04-22 05:39:22.996202'),
(4, 'admin', '0002_logentry_remove_auto_add', '2021-04-22 05:39:23.066015'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2021-04-22 05:39:23.071999'),
(6, 'app', '0001_initial', '2021-04-22 05:39:23.144804'),
(7, 'app', '0002_cart', '2021-04-22 05:39:23.241545'),
(8, 'app', '0003_auto_20210328_1508', '2021-04-22 05:39:23.373835'),
(9, 'app', '0004_profile_username', '2021-04-22 05:39:23.511005'),
(10, 'app', '0005_auto_20210328_1541', '2021-04-22 05:39:23.554883'),
(11, 'app', '0006_product_user', '2021-04-22 05:39:23.601283'),
(12, 'app', '0007_remove_product_user', '2021-04-22 05:39:23.654141'),
(13, 'app', '0008_remove_orderplaced_customer', '2021-04-22 05:39:23.691520'),
(14, 'app', '0009_orderplaced_customer', '2021-04-22 05:39:23.733426'),
(15, 'app', '0010_auto_20210408_2128', '2021-04-22 05:39:23.838323'),
(16, 'app', '0011_auto_20210409_1103', '2021-04-22 05:39:23.914599'),
(17, 'app', '0012_auto_20210409_1225', '2021-04-22 05:39:23.990794'),
(18, 'app', '0013_remove_customer_user', '2021-04-22 05:39:24.032504'),
(19, 'app', '0014_customer_user', '2021-04-22 05:39:24.075430'),
(20, 'app', '0015_orderplaced_profile', '2021-04-22 05:39:24.124004'),
(21, 'app', '0016_auto_20210411_1944', '2021-04-22 05:39:24.189055'),
(22, 'app', '0017_productimage', '2021-04-22 05:39:24.220426'),
(23, 'app', '0018_auto_20210413_1724', '2021-04-22 05:39:24.275195'),
(24, 'app', '0019_auto_20210413_1825', '2021-04-22 05:39:24.313673'),
(25, 'app', '0020_auto_20210413_2103', '2021-04-22 05:39:24.327835'),
(26, 'app', '0021_product_images', '2021-04-22 05:39:24.350609'),
(27, 'app', '0022_remove_product_images', '2021-04-22 05:39:24.363750'),
(28, 'app', '0023_auto_20210413_2201', '2021-04-22 05:39:24.384642'),
(29, 'app', '0024_productimage', '2021-04-22 05:39:24.418340'),
(30, 'app', '0025_auto_20210413_2249', '2021-04-22 05:39:24.606997'),
(31, 'app', '0026_auto_20210413_2249', '2021-04-22 05:39:24.773467'),
(32, 'app', '0027_auto_20210413_2251', '2021-04-22 05:39:24.785436'),
(33, 'app', '0028_auto_20210413_2301', '2021-04-22 05:39:24.891424'),
(34, 'app', '0029_auto_20210413_2314', '2021-04-22 05:39:24.919351'),
(35, 'app', '0030_auto_20210414_1232', '2021-04-22 05:39:24.963520'),
(36, 'app', '0031_auto_20210414_1243', '2021-04-22 05:39:24.987049'),
(37, 'app', '0032_auto_20210414_1250', '2021-04-22 05:39:25.027288'),
(38, 'app', '0033_remove_product_imageb', '2021-04-22 05:39:25.062224'),
(39, 'app', '0034_auto_20210416_1312', '2021-04-22 05:39:25.071758'),
(40, 'app', '0035_auto_20210416_1315', '2021-04-22 05:39:25.082001'),
(41, 'app', '0036_auto_20210416_1316', '2021-04-22 05:39:25.090951'),
(42, 'app', '0037_auto_20210416_1322', '2021-04-22 05:39:25.100890'),
(43, 'app', '0038_auto_20210417_1813', '2021-04-22 05:39:25.131745'),
(44, 'app', '0039_auto_20210417_1817', '2021-04-22 05:39:25.166666'),
(45, 'app', '0040_auto_20210417_1819', '2021-04-22 05:39:25.199558'),
(46, 'app', '0041_auto_20210417_1822', '2021-04-22 05:39:25.230838'),
(47, 'app', '0042_customer_email', '2021-04-22 05:39:25.249347'),
(48, 'contenttypes', '0002_remove_content_type_name', '2021-04-22 05:39:25.305415'),
(49, 'auth', '0002_alter_permission_name_max_length', '2021-04-22 05:39:25.346287'),
(50, 'auth', '0003_alter_user_email_max_length', '2021-04-22 05:39:25.366162'),
(51, 'auth', '0004_alter_user_username_opts', '2021-04-22 05:39:25.375149'),
(52, 'auth', '0005_alter_user_last_login_null', '2021-04-22 05:39:25.412501'),
(53, 'auth', '0006_require_contenttypes_0002', '2021-04-22 05:39:25.415492'),
(54, 'auth', '0007_alter_validators_add_error_messages', '2021-04-22 05:39:25.424088'),
(55, 'auth', '0008_alter_user_username_max_length', '2021-04-22 05:39:25.440292'),
(56, 'auth', '0009_alter_user_last_name_max_length', '2021-04-22 05:39:25.459028'),
(57, 'auth', '0010_alter_group_name_max_length', '2021-04-22 05:39:25.477520'),
(58, 'auth', '0011_update_proxy_permissions', '2021-04-22 05:39:25.488617'),
(59, 'auth', '0012_alter_user_first_name_max_length', '2021-04-22 05:39:25.505600'),
(60, 'sessions', '0001_initial', '2021-04-22 05:39:25.528310');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('d8927zkpscfle1zab1vv255cbz8ivwwq', '.eJxVjM0OwiAQhN-FsyEL_aF49O4zkF12kaqhSWlPxndXkh40mdN838xLBdy3HPYqa5hZnZVRp9-OMD6kNMB3LLdFx6Vs60y6KfqgVV8XluflcP8OMtbc1t7ANCaO0ImFxL4XZHDGRxJOFiOBY9symI76rwcw4ejtgETOGvX-APzDOEM:1lZShw:jV3RqmVw2fjDTBhgaX-sBH6ct2_Fwq7pJ9PB0TejppM', '2021-05-06 06:21:00.176444');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `app_cart`
--
ALTER TABLE `app_cart`
  ADD PRIMARY KEY (`id`),
  ADD KEY `app_cart_product_id_a4171918_fk_app_product_id` (`product_id`),
  ADD KEY `app_cart_user_id_2bf07879_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `app_category_choices`
--
ALTER TABLE `app_category_choices`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Indexes for table `app_customer`
--
ALTER TABLE `app_customer`
  ADD PRIMARY KEY (`id`),
  ADD KEY `app_customer_user_id_e6e52921_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `app_orderplaced`
--
ALTER TABLE `app_orderplaced`
  ADD PRIMARY KEY (`id`),
  ADD KEY `app_orderplaced_product_id_90c7863a_fk_app_product_id` (`product_id`),
  ADD KEY `app_orderplaced_user_id_3c6fe1e1_fk_auth_user_id` (`user_id`),
  ADD KEY `app_orderplaced_customer_id_9d02fbb6_fk_app_customer_id` (`customer_id`),
  ADD KEY `app_orderplaced_profile_id_48bd4b8a_fk_app_profile_id` (`profile_id`);

--
-- Indexes for table `app_product`
--
ALTER TABLE `app_product`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `app_product_category_id_023742a5_fk_app_category_choices_id` (`category_id`);

--
-- Indexes for table `app_profile`
--
ALTER TABLE `app_profile`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `app_cart`
--
ALTER TABLE `app_cart`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `app_category_choices`
--
ALTER TABLE `app_category_choices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `app_customer`
--
ALTER TABLE `app_customer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `app_orderplaced`
--
ALTER TABLE `app_orderplaced`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `app_product`
--
ALTER TABLE `app_product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `app_profile`
--
ALTER TABLE `app_profile`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `app_cart`
--
ALTER TABLE `app_cart`
  ADD CONSTRAINT `app_cart_product_id_a4171918_fk_app_product_id` FOREIGN KEY (`product_id`) REFERENCES `app_product` (`id`),
  ADD CONSTRAINT `app_cart_user_id_2bf07879_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `app_customer`
--
ALTER TABLE `app_customer`
  ADD CONSTRAINT `app_customer_user_id_e6e52921_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `app_orderplaced`
--
ALTER TABLE `app_orderplaced`
  ADD CONSTRAINT `app_orderplaced_customer_id_9d02fbb6_fk_app_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `app_customer` (`id`),
  ADD CONSTRAINT `app_orderplaced_product_id_90c7863a_fk_app_product_id` FOREIGN KEY (`product_id`) REFERENCES `app_product` (`id`),
  ADD CONSTRAINT `app_orderplaced_profile_id_48bd4b8a_fk_app_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `app_profile` (`id`),
  ADD CONSTRAINT `app_orderplaced_user_id_3c6fe1e1_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `app_product`
--
ALTER TABLE `app_product`
  ADD CONSTRAINT `app_product_category_id_023742a5_fk_app_category_choices_id` FOREIGN KEY (`category_id`) REFERENCES `app_category_choices` (`id`);

--
-- Constraints for table `app_profile`
--
ALTER TABLE `app_profile`
  ADD CONSTRAINT `app_profile_user_id_87d292a0_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
