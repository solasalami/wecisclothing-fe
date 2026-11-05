-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 05, 2026 at 08:02 PM
-- Server version: 8.0.46-cll-lve
-- PHP Version: 8.4.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `weciscl1_clothingdb`
--
CREATE DATABASE IF NOT EXISTS `weciscl1_clothingdb` DEFAULT CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci;
USE `weciscl1_clothingdb`;

-- --------------------------------------------------------

--
-- Table structure for table `oc_address`
--

CREATE TABLE `oc_address` (
  `address_id` int NOT NULL,
  `customer_id` int NOT NULL,
  `firstname` varchar(32) NOT NULL,
  `lastname` varchar(32) NOT NULL,
  `company` varchar(40) NOT NULL,
  `address_1` varchar(128) NOT NULL,
  `address_2` varchar(128) NOT NULL,
  `city` varchar(128) NOT NULL,
  `postcode` varchar(10) NOT NULL,
  `country_id` int NOT NULL DEFAULT '0',
  `zone_id` int NOT NULL DEFAULT '0',
  `custom_field` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_address`
--

INSERT INTO `oc_address` (`address_id`, `customer_id`, `firstname`, `lastname`, `company`, `address_1`, `address_2`, `city`, `postcode`, `country_id`, `zone_id`, `custom_field`) VALUES
(1, 1, 'admin', 'admin', '', 'mumbai', '', 'mumbai', '123456', 222, 3516, ''),
(6, 11, 'Sola', 'Salami', 'TBG', 'Lekki', 'Lekki', 'Lagos', '23401', 156, 2412, ''),
(7, 12, 'Sola', 'S', 'TCB', 'NNNN', '', 'ddd', 'dfdd', 156, 2388, '');

-- --------------------------------------------------------

--
-- Table structure for table `oc_api`
--

CREATE TABLE `oc_api` (
  `api_id` int NOT NULL,
  `username` varchar(64) NOT NULL,
  `key` text NOT NULL,
  `status` tinyint(1) NOT NULL,
  `date_added` datetime NOT NULL,
  `date_modified` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_api`
--

INSERT INTO `oc_api` (`api_id`, `username`, `key`, `status`, `date_added`, `date_modified`) VALUES
(1, 'Default', 'N6FO7WifSP551RefVHFhNjybwaMfwWd2aJIMNM9Tx2UtFndpfCHD9YBlumYZJZdpnMBq4wxmfHcPKuGQb9P9t3RC5G29sOrfB6xOe43DSlafwgt0dLFHbVlbJKSO0cHifOG5y1Lsc8K2lj1tG997CIE4rkjc3JD2JXStV5jX8kWuZ31HDP0ThGeneyMnyWhYarrVvMdUMGWpQboPpr7F63xuEJeEOmeGEC289uWSzn3pdpf6aMO38Zgnt8JxFYx4', 1, '2018-02-20 12:18:37', '2018-02-20 12:18:37'),
(2, 'Default', '2eaLA43WFIbzyNT7z9sqRYpFVJCaRhZXyszu8drBPgGmgUIY4IN1bMLhUrusprH7nylaGeq1RWbOrkeqCsLhPyggyi0vwYjY1kTNjtvJTYCNNX6EnjkTT7rNw8EIpYrQ1c0po22Tyj3rLo0ajxsdEz3HCGLHQNj9Lg0hzY3xrxqlZ5y7KAP4o6oobdPUHpi1AWmY2FoVnRL35WDfXTjkkFogqkGFb3yuyvmsqXISCLhuUiJ4mpP3b1UTc85H2R6K', 1, '2018-03-09 06:57:25', '2018-03-09 06:57:25'),
(3, 'Default', 'gFzN9K5DxkEjUTjzuLVf8tlnQBC4hnxvCyK2vfHFCJISj2XViOZPpCj6dsS769V4lmX13q3WWutxe4HhGmEvJ6FrOvgDy7yYEGd00T1wy7zQtarcX4m5qj0u6ynGA4PZClXS80UDLxFX6nXq2nyjBRVJ2PbVwzJE0mSm8cIw393WfHoF3JhdfqfdspKbcXeK0PrHBKAOWz9qRyZ4CyCzKMI6qYsT7LifpdGQAOHIiwNTAbOBTk1n50zAvspy4pom', 1, '2018-03-15 05:32:07', '2018-03-15 05:32:07'),
(4, 'Default', 'qDwVFhjffMBnjMAabH6Qz4JTKeqQlWDYzGnvDeTFPuvEfG11xdTxlcxMrAlA27otwq2IBPu52N3z1paW5ZS0uPFvxBLlfeY9Ima1tCkyVj70TK7Zhjgd5Nvhn6jbr91ATu2EWwSzFDe8dhwhXM5dHYhtrN0O5itwqUCCArlTjJ3mD2ErT06dGjU0GFy4ksEgrpAS1kVqBPYXB8WES8cOnMbAGPdxg1uK4LI3AF0fLPaowXDbSxXHzmDLMbMtvBHN', 1, '2018-05-28 18:00:20', '2018-05-28 18:00:20'),
(5, 'Default', 'VPZGMKY2nu0pMKW0FcHJ43Gf9Dm3mWC9C8GDCe6nzZJ6mGM5znqDc0OJIBnvrlWN9nEGBubm95MrnCGf727rE1ZBFioUXKntUPVxWAaNqXCkwo5cyoye9EOrw73mlRtUdcEjJK82rtppnKb7WlEXeDiwOyCZ93P7HuM2RUfIlvMIFuZ7u4gTeCGPG345qXABxzw1w3wza8I0PpMTOv0xU234DNyu9dJuZy65JQ8x7MLOxUEbTnnbRc0h0wUUeRW5', 1, '2019-02-04 09:49:58', '2019-02-04 09:49:58'),
(6, 'Default', 'fHFAZCDY6qwtivL7wwarWrEkyRI6kZR2mV3k09mQZXgQoLrzKvgpOIgNKjX88zhkgyIn65VOSHK6WVODDZCFqUb1fs4oXS1Us8N96ixUFz2U46MWMoPK94AaGIgGtHBdauQFkifVFvzsRADwIBAaxS4IG9mw9br1BF7C2Bz4va38ZeYg1AmvemiU9ZvudE2VUfmuuafm5ctvOs29nuAO8lfkUjc07r07nzPz6p5M0jYnoSj855l7j9t16nl6df9n', 1, '2019-03-12 09:54:19', '2019-03-12 09:54:19'),
(7, 'Default', 'TDAwYDaBzxvTM8ttN1TbYRlA3NsFuC2OSGvYOckweAlveucZQGkcfubHV2m3tKA0q0caaMGsAz0EQue7x1GWSf6pRUTYvEJQUPIb02khlqV4XgP7YsOssaBk6zJc04zNxrrECMdVsKu5P1swSKXsBUJ0eP6tbgaeo1Z8EydGBpzNgPXiWoTrSCJEn4FENKPzzgZahhrTxlz6Pu70wkoAIJKJVuorTy56bZtedyP3YNtK1K2ZdtNeL3LXnmJUzjGz', 1, '2019-03-15 10:38:00', '2019-03-15 10:38:00'),
(8, 'Default', '4ALXPKynZ7AnxbRVOW4lehSXvg8H9WT9N58WXer27ga6cWVprtJphNuAzB4RohSit6uodZ2yw2GT9f1NEXJEdFLCB3DDInE6mnWkw4hsweF5o2qlniqyqvlivk3yC6Rk4CdxVQxvcSR6sUj0HHL229SO6LceZvM6Atbi2bPBMj6eyHTR6ElGQCd3JpGrvHWNQVoGdqH4kzOSTDVuG4Ie0iNQtI39m36Xa0pdOX17pmXnCtv4o2N0sq20wtMKFS7S', 1, '2019-04-27 09:12:17', '2019-04-27 09:12:17'),
(9, 'Default', 'sBWn0DXilCrmdTQrq503PjtDX7NqfLVOUUcS9JcgmDWJtjfka9cTpXL2XD7DeIowM2WBgIGSazRITDG1XPnkEX5vULhulFsQgWVT44TbcuGaP8mGNlAhJJU5gVvUtndRIP4zayicI8mPNPDY21173g0TmWjEej4guurvN5FG6FzMgqDxm9Kz53DA57GiBvn9iTSDjbzWQJM2FfXILFm99Km504ixo0GU5mVdjDTBgy2inND5u1miXfmbuQreVJC2', 1, '2019-05-25 04:44:58', '2019-05-25 04:44:58'),
(10, 'Default', 'rIuxXRnyXmkHq4Ib4YXjZeZE3Y7E8nsNqlsbNduoryOcYTUlBfpEZnZfBB0tGBG8KXg9ajVfIuTsFbDJrjlQkf4mXc61pQsDgHFHmccoJFCyfodkrCMj6z36P7tc9g3OTlp0BREHqRDaAXPs908lRXdicASy9OWg7wuhHpxJuoTUrKkfUKP5l0LltKY94ocnapIHI8VW8yazPDnrbd6K5QGGPq7fL1s8nUhqCV1U9JQu8puvHD8tgvXi9HPTTekd', 1, '2019-10-03 11:41:56', '2019-10-03 11:41:56'),
(11, 'Default', 'GGUUOrSQYHCx8dIIVi6tLZNeEKEPJxOyXq0kuSg1CZTE1sqy4iwinfBtZGmob42dgHtSVwoE6rTm3v4TR5jv3i34V5R5aWA9QsULC9qTQbxdfvcnimkN62NZyE1xp9awo7OTy63hJiP6aSC6Dij3GVNmVFpVmaq2USYjMdcw9ntHgkEzsHf5cbNOAx6byBqgPGKsbwzw0K7WTxvHwQr2Q8Tqb5S7XeB9rG0GFCVubrFPxsdZThJBkdYdsEOS4alV', 1, '2020-03-26 18:56:38', '2020-03-26 18:56:38'),
(12, 'Default', 'Wqn8o29YcdPR9VkYzKwtR991IpLh3qpymi9M64lb5xmQEL7dNuIuvm2nucsy0YyAWJ4aVvBBm5yaGnNr0bUx6ZFyR0C8NOIusgWxHaQptqSs4rIBMzRgGaWSsi7XS16xZrfjgLndDbxx3s5Od8vVLtqODr2RvVL43NQVEYeIlxTaxuw1VYrYcXgRNqrUA8QahLiO6OlbHvDaQsowQpsG9GRotLRPPwajJTtrtT4NQNyLFShko9NrhuxtN0LMLJnl', 1, '2020-06-26 05:12:48', '2020-06-26 05:12:48'),
(13, 'Default', 'gUlg8D3qs1gXSnBzASK3ssV3WTdqipyEZd7WLZUouu8VW292yGc9OfUSLGe8zf8h7E6TagrZQ1Tn0wL4PiToTR71NwsbeHgzXzT3WKDNSV69byisH2NkDlL0Mlm2ypxfcS4ctlTI0GlWDEt4rQKOP5qHwCbg3HmVe54fN5RdeYCn7cMPbWQGqH0zdA15kjblZB0gIHJoMWgLFDpVtLn81YjVk9Be6rDizpY8f7PRBJiMuC0b6oPDjrBR5PmpE1Gr', 1, '2021-01-15 06:35:28', '2021-01-15 06:35:28'),
(14, 'Default', 'C5SSYbHKCmYNXDHcgCGBrHajo6BAWh16hvlWtsNb8q6dDmsjwXMZ7IcHAlhq47hYp54CwY6DlX8WXOGoOmGIsysttJAYnqXLUOePklqqgcVf2ULQ7vn5CIkxU6GYu7p34SG8SbAu5F12eoqLVeHHEqYZW5o6kj7E6EhyUbg0cwqnoRx1rxuDVRpYEvJ61LuqYiEQ4osh1OOuWk5TzlImj9CG4LNEDN09TredPr0eCb5DuZQ2BE58MBAm6zcnoulR', 1, '2021-01-25 07:30:49', '2021-01-25 07:30:49'),
(15, 'Default', '0lynHJUkqLW0IQpQTa1KPYFdBJD1LRXss5h20tyPQtl4dcjuOQ50kV1xuVzjdH6p6v6oORYJqkjTn45dgzJUDpK5gCJat6a4pa8nwXMFjXIK6DHZ5pjPK3r1ksMs21dCVrg2vKb3nXeu4VIy5ELOTSlw2jNMLLH9qWXOFW6pmaIOeT3fEeZnMNpD9bezTey2ToujnTTqUMeKOyPzzlAM3oKmuejsFf8YctFXDyPfmCqDyjNsF8Thfta7Oja5C61v', 1, '2021-01-28 08:54:28', '2021-01-28 08:54:28'),
(16, 'Default', 'xKzEbUNK4Rj2otu8hppq5NlUTnEwXowKlnE6q16WfNdGftBlxDusska586yjyjunnR6QSmrD0os48UoINEEpfJLn28pMSxcbEjPSpHxtd0G7rkFz7xEb1FBV2M7f4IpZuIDmjPNPDxotk1sLcTPDK7RfMTrsC37HApiY5GEj9BayGfARtSsbGnNcET9pLeHMKyZCK0uCHEFOHU5T9rpTVmcDQnKsLcmMz12mLTereaSZXVpdeHogXuOMxPsHWdvx', 1, '2021-03-01 05:29:19', '2021-03-01 05:29:19'),
(17, 'Default', 'PxHly2Y2UW7pES3I0ZOgGTgOrO1H18PevHXDaCON0cetb11LPP1h6VQwePS7FZNzXg7hmBw2GQFANd3Z7SetZKMTyimRU4dIcLuxNVjz3bgBoEvGMdJly5gUxZIKcbFWJOIXK7rpxFDGXe50Qf5yP9UwyqQk9PZo0BM6klTsDmIkLLmFlVuYWVXdIgjkiUU0cKMfj695RdYhuuWXxlPMT22C5YjH5Hqsm17eyWhJItwNG9jKMlzHeAsZJ7bWZ6uT', 1, '2021-03-08 12:46:20', '2021-03-08 12:46:20'),
(18, 'Default', 'TB6fuwg2YuTyqc3gUUwqzG5DVteAzxX02YhJOnQi7VCpGVx0i56koF9SekcrmRbTgfVxk0vHpkoalqVGKMWIjk7ZgrtXODNmvuuGN6E8PC3bVyzysa0pN6HpGpI3xzaGUmbn2bxy5lnRfssctYiypKcaTenHzjKXny7EKEMJFihrOGIppNcCTtfw2ZFnl4n6jfnzbdoXEVdh52gzfWavWat48y4aqTna40UvYTUjdamDCmq90wtR0xWo6NxfPW7Y', 1, '2025-04-04 23:13:54', '2025-04-04 23:13:54');

-- --------------------------------------------------------

--
-- Table structure for table `oc_api_ip`
--

CREATE TABLE `oc_api_ip` (
  `api_ip_id` int NOT NULL,
  `api_id` int NOT NULL,
  `ip` varchar(40) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_api_ip`
--

INSERT INTO `oc_api_ip` (`api_ip_id`, `api_id`, `ip`) VALUES
(1, 18, '160.19.36.25'),
(2, 18, '102.91.92.185'),
(3, 18, '102.44.195.237');

-- --------------------------------------------------------

--
-- Table structure for table `oc_api_session`
--

CREATE TABLE `oc_api_session` (
  `api_session_id` int NOT NULL,
  `api_id` int NOT NULL,
  `session_id` varchar(32) NOT NULL,
  `ip` varchar(40) NOT NULL,
  `date_added` datetime NOT NULL,
  `date_modified` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_api_session`
--

INSERT INTO `oc_api_session` (`api_session_id`, `api_id`, `session_id`, `ip`, `date_added`, `date_modified`) VALUES
(12, 18, 'cc854005838e4d952a1e0bd2a4', '102.44.195.237', '2025-05-04 18:38:15', '2025-05-04 18:38:15'),
(9, 18, 'd9f2e05af3095a181624dcfc77', '102.44.195.237', '2025-05-04 18:37:15', '2025-05-04 18:37:47'),
(8, 18, 'f127f9b32a7e0e0022c3a1b939', '102.44.195.237', '2025-05-04 18:37:03', '2025-05-04 18:37:03'),
(11, 18, 'a9b134294bc55f268d5bc0460c', '102.44.195.237', '2025-05-04 18:37:55', '2025-05-04 18:37:55'),
(10, 18, '3db06654a38c106b0be12e90f3', '102.44.195.237', '2025-05-04 18:37:54', '2025-05-04 18:37:54');

-- --------------------------------------------------------

--
-- Table structure for table `oc_attribute`
--

CREATE TABLE `oc_attribute` (
  `attribute_id` int NOT NULL,
  `attribute_group_id` int NOT NULL,
  `sort_order` int NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_attribute`
--

INSERT INTO `oc_attribute` (`attribute_id`, `attribute_group_id`, `sort_order`) VALUES
(1, 6, 1),
(2, 6, 5),
(3, 6, 3),
(4, 3, 1),
(5, 3, 2),
(6, 3, 3),
(7, 3, 4),
(8, 3, 5),
(9, 3, 6),
(10, 3, 7),
(11, 3, 8);

-- --------------------------------------------------------

--
-- Table structure for table `oc_attribute_description`
--

CREATE TABLE `oc_attribute_description` (
  `attribute_id` int NOT NULL,
  `language_id` int NOT NULL,
  `name` varchar(64) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_attribute_description`
--

INSERT INTO `oc_attribute_description` (`attribute_id`, `language_id`, `name`) VALUES
(1, 1, 'Description'),
(2, 1, 'No. of Cores'),
(4, 1, 'test 1'),
(5, 1, 'test 2'),
(6, 1, 'test 3'),
(7, 1, 'test 4'),
(8, 1, 'test 5'),
(9, 1, 'test 6'),
(10, 1, 'test 7'),
(11, 1, 'test 8'),
(3, 1, 'Clockspeed'),
(1, 2, 'Description'),
(2, 2, 'No. of Cores'),
(4, 2, 'test 1'),
(5, 2, 'test 2'),
(6, 2, 'test 3'),
(7, 2, 'test 4'),
(8, 2, 'test 5'),
(9, 2, 'test 6'),
(10, 2, 'test 7'),
(11, 2, 'test 8'),
(3, 2, 'Clockspeed');

-- --------------------------------------------------------

--
-- Table structure for table `oc_attribute_group`
--

CREATE TABLE `oc_attribute_group` (
  `attribute_group_id` int NOT NULL,
  `sort_order` int NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_attribute_group`
--

INSERT INTO `oc_attribute_group` (`attribute_group_id`, `sort_order`) VALUES
(3, 2),
(4, 1),
(5, 3),
(6, 4);

-- --------------------------------------------------------

--
-- Table structure for table `oc_attribute_group_description`
--

CREATE TABLE `oc_attribute_group_description` (
  `attribute_group_id` int NOT NULL,
  `language_id` int NOT NULL,
  `name` varchar(64) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_attribute_group_description`
--

INSERT INTO `oc_attribute_group_description` (`attribute_group_id`, `language_id`, `name`) VALUES
(3, 1, 'Memory'),
(4, 1, 'Technical'),
(5, 1, 'Motherboard'),
(6, 1, 'Processor'),
(3, 2, 'Memory'),
(4, 2, 'Technical'),
(5, 2, 'Motherboard'),
(6, 2, 'Processor');

-- --------------------------------------------------------

--
-- Table structure for table `oc_banner`
--

CREATE TABLE `oc_banner` (
  `banner_id` int NOT NULL,
  `name` varchar(64) NOT NULL,
  `status` tinyint(1) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_banner`
--

INSERT INTO `oc_banner` (`banner_id`, `name`, `status`) VALUES
(6, 'HP Products', 0),
(7, 'Home Page Slideshow', 1),
(8, 'Manufacturers', 1),
(9, 'Left banner', 1);

-- --------------------------------------------------------

--
-- Table structure for table `oc_banner_image`
--

CREATE TABLE `oc_banner_image` (
  `banner_image_id` int NOT NULL,
  `banner_id` int NOT NULL,
  `language_id` int NOT NULL,
  `title` varchar(64) NOT NULL,
  `link` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  `sort_order` int NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_banner_image`
--

INSERT INTO `oc_banner_image` (`banner_image_id`, `banner_id`, `language_id`, `title`, `link`, `image`, `sort_order`) VALUES
(101, 6, 1, 'HP Banner', 'index.php?route=product/manufacturer/info&amp;manufacturer_id=7', 'catalog/demo/compaq_presario.jpg', 0),
(298, 8, 2, 'Nintendo', '', 'catalog/7.png', 0),
(297, 8, 2, 'Starbucks', '', 'catalog/6.png', 0),
(296, 8, 2, 'Dell', '', 'catalog/5.png', 0),
(295, 8, 2, 'Disney', '', 'catalog/4.png', 0),
(300, 9, 2, 'Left banner', '#', 'catalog/left-banner-1.jpg', 0),
(126, 6, 2, 'HP Banner', 'index.php?route=product/manufacturer/info&amp;manufacturer_id=7', 'catalog/demo/compaq_presario.jpg', 0),
(294, 8, 2, 'Harley Davidson', '', 'catalog/3.png', 0),
(293, 8, 2, 'Canon', '', 'catalog/2.png', 0),
(292, 8, 2, 'Burger King', '', 'catalog/1.png', 0),
(291, 8, 1, 'Starbucks', '', 'catalog/1.png', 0),
(290, 8, 1, 'Nintendo', '', 'catalog/2.png', 0),
(289, 8, 1, 'Dell', '', 'catalog/3.png', 0),
(288, 8, 1, 'Disney', '', 'catalog/4.png', 0),
(299, 9, 1, 'Left banner', '#', 'catalog/left-banner-1.jpg', 0),
(308, 7, 1, 'Mainbanner4', '#', 'catalog/Wecis/banner 4.jpeg', 4),
(306, 7, 1, 'Mainbanner2', '#', 'catalog/Wecis/banner 2.jpeg', 2),
(307, 7, 1, 'Mainbanner3', '#', 'catalog/Wecis/banner 3.jpeg', 3),
(287, 8, 1, 'Harley Davidson', '', 'catalog/5.png', 0),
(286, 8, 1, 'Canon', '', 'catalog/6.png', 0),
(285, 8, 1, 'Burger King', '', 'catalog/7.png', 0),
(305, 7, 1, 'Mainbanner1', '#', 'catalog/Wecis/banner 1.jpeg', 1),
(309, 7, 1, 'Mainbanner5', '#', 'catalog/Wecis/banner 5.jpeg', 0),
(310, 7, 2, 'Mainbanner1', '#', 'catalog/main-banner-1.jpg', 1),
(311, 7, 2, 'Mainbanner2', '#', 'catalog/main-banner-2.jpg', 2);

-- --------------------------------------------------------

--
-- Table structure for table `oc_blogger`
--

CREATE TABLE `oc_blogger` (
  `blogger_id` int NOT NULL,
  `module_id` int NOT NULL,
  `status` int NOT NULL DEFAULT '0',
  `image` varchar(255) DEFAULT NULL,
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_blogger`
--

INSERT INTO `oc_blogger` (`blogger_id`, `module_id`, `status`, `image`, `date_added`, `date_modified`) VALUES
(1, 43, 1, 'catalog/Wecis/blogs/We15.jpg', '2020-02-28 11:19:34', '2025-05-04 18:17:22'),
(3, 43, 1, 'catalog/Wecis/blogs/We14.jpg', '2020-02-14 11:20:51', '2025-05-04 18:15:33'),
(4, 43, 1, 'catalog/Wecis/blogs/We13 (1).jpg', '2020-02-18 11:21:26', '2025-05-04 18:17:00');

-- --------------------------------------------------------

--
-- Table structure for table `oc_blogger_comment`
--

CREATE TABLE `oc_blogger_comment` (
  `blogger_comment_id` int NOT NULL,
  `blogger_id` int NOT NULL,
  `approved` int NOT NULL DEFAULT '0',
  `author` varchar(64) NOT NULL DEFAULT '',
  `email` varchar(96) NOT NULL,
  `date_added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_blogger_comment`
--

INSERT INTO `oc_blogger_comment` (`blogger_comment_id`, `blogger_id`, `approved`, `author`, `email`, `date_added`) VALUES
(1, 1, 0, 'admin', 'admin22@localhost.com', '2021-02-02 14:27:32'),
(2, 4, 0, 'admin', 'admin22@localhost.com', '2021-02-02 14:52:06');

-- --------------------------------------------------------

--
-- Table structure for table `oc_blogger_comment_description`
--

CREATE TABLE `oc_blogger_comment_description` (
  `blogger_comment_id` int NOT NULL DEFAULT '0',
  `language_id` int NOT NULL DEFAULT '0',
  `comment` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_blogger_comment_description`
--

INSERT INTO `oc_blogger_comment_description` (`blogger_comment_id`, `language_id`, `comment`) VALUES
(1, 1, 'Nulla quis rutrum justo. Vivamus facilisis, sapien nec faucibus vulputate, ipsum ipsum eleifend diam, ac fringilla elit arcu ac erat. Phasellus elementum fringilla gravida. Cras placerat ante vel porta maximus. Nam dignissim vestibulum est, at lacinia ipsum hendrerit a'),
(2, 1, 'Nulla quis rutrum justo. Vivamus facilisis, sapien nec faucibus vulputate, ipsum ipsum eleifend diam, ac fringilla elit arcu ac erat. Phasellus elementum fringilla gravida. Cras placerat ante vel porta maximus. Nam dignissim vestibulum est, at lacinia ipsum hendrerit a');

-- --------------------------------------------------------

--
-- Table structure for table `oc_blogger_description`
--

CREATE TABLE `oc_blogger_description` (
  `blogger_id` int NOT NULL DEFAULT '0',
  `language_id` int NOT NULL DEFAULT '0',
  `title` varchar(64) NOT NULL DEFAULT '',
  `description` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_blogger_description`
--

INSERT INTO `oc_blogger_description` (`blogger_id`, `language_id`, `title`, `description`) VALUES
(1, 2, 'History of Wecis Clothing', '&lt;p data-start=&quot;120&quot; data-end=&quot;446&quot; class=&quot;&quot;&gt;At &lt;strong data-start=&quot;123&quot; data-end=&quot;142&quot;&gt;Wecis Clothings&lt;/strong&gt;, we are redefining fashion by blending the richness of African heritage with contemporary design. Our brand offers &lt;strong data-start=&quot;258&quot; data-end=&quot;310&quot;&gt;premium African-inspired menswear and womenswear&lt;/strong&gt;\r\n tailored for the modern global citizen. Each piece tells a story—rooted\r\n in culture, elevated with elegance, and crafted with precision.&lt;/p&gt;\r\n&lt;p data-start=&quot;448&quot; data-end=&quot;649&quot; class=&quot;&quot;&gt;Our commitment is simple: &lt;strong data-start=&quot;474&quot; data-end=&quot;500&quot;&gt;Style without borders.&lt;/strong&gt; With &lt;strong data-start=&quot;506&quot; data-end=&quot;528&quot;&gt;worldwide delivery&lt;/strong&gt;, we ensure that wherever you are—Lagos, London, New York, or Tokyo—you can wear your identity with pride and confidence.&lt;/p&gt;\r\n&lt;p data-start=&quot;651&quot; data-end=&quot;793&quot; class=&quot;&quot;&gt;Wecis Clothings is more than fashion. It’s &lt;strong data-start=&quot;694&quot; data-end=&quot;717&quot;&gt;a cultural movement&lt;/strong&gt;, a statement of excellence, and a celebration of Africa on the world stage.&lt;/p&gt;\r\n&lt;p data-start=&quot;795&quot; data-end=&quot;847&quot; class=&quot;&quot;&gt;Join us in making African fashion a global language.&lt;/p&gt;&lt;br&gt;    '),
(1, 1, 'History of Wecis Clothing', '&lt;p data-start=&quot;120&quot; data-end=&quot;446&quot; class=&quot;&quot;&gt;At &lt;strong data-start=&quot;123&quot; data-end=&quot;142&quot;&gt;Wecis Clothings&lt;/strong&gt;, we are redefining fashion by blending the richness of African heritage with contemporary design. Our brand offers &lt;strong data-start=&quot;258&quot; data-end=&quot;310&quot;&gt;premium African-inspired menswear and womenswear&lt;/strong&gt; tailored for the modern global citizen. Each piece tells a story—rooted in culture, elevated with elegance, and crafted with precision.&lt;/p&gt;\r\n&lt;p data-start=&quot;448&quot; data-end=&quot;649&quot; class=&quot;&quot;&gt;Our commitment is simple: &lt;strong data-start=&quot;474&quot; data-end=&quot;500&quot;&gt;Style without borders.&lt;/strong&gt; With &lt;strong data-start=&quot;506&quot; data-end=&quot;528&quot;&gt;worldwide delivery&lt;/strong&gt;, we ensure that wherever you are—Lagos, London, New York, or Tokyo—you can wear your identity with pride and confidence.&lt;/p&gt;\r\n&lt;p data-start=&quot;651&quot; data-end=&quot;793&quot; class=&quot;&quot;&gt;Wecis Clothings is more than fashion. It’s &lt;strong data-start=&quot;694&quot; data-end=&quot;717&quot;&gt;a cultural movement&lt;/strong&gt;, a statement of excellence, and a celebration of Africa on the world stage.&lt;/p&gt;\r\n&lt;p data-start=&quot;795&quot; data-end=&quot;847&quot; class=&quot;&quot;&gt;Join us in making African fashion a global language.&lt;/p&gt;&lt;br&gt;    '),
(4, 2, 'African Women Prints In Nigeria - Ankara', '&lt;p data-start=&quot;40&quot; data-end=&quot;197&quot; class=&quot;&quot;&gt;&lt;span class=&quot;relative -mx-px my-[-0.2rem] rounded px-px py-[0.2rem] transition-colors duration-100 ease-in-out&quot;&gt;Wecis\r\n Clothing stands at the forefront of contemporary African fashion, \r\nseamlessly blending traditional Ankara prints with modern design \r\nsensibilities.&lt;/span&gt; &lt;span class=&quot;relative -mx-px my-[-0.2rem] rounded px-px py-[0.2rem] transition-colors duration-100 ease-in-out&quot;&gt;Based\r\n in Lagos, Nigeria, with flagship stores in Ikeja and Victoria Island, \r\nWecis Clothing has carved a niche for itself by offering vibrant, \r\nstylish, and culturally resonant apparel that appeals to a global \r\naudience.&lt;/span&gt; ​&lt;span class=&quot;ms-1 inline-flex max-w-full items-center relative top-[-0.094rem] animate-[show_150ms_ease-in]&quot;&gt;&lt;a href=&quot;https://www.instagram.com/wecisclothing/?hl=en&amp;amp;utm_source=chatgpt.com&quot; target=&quot;_blank&quot; rel=&quot;noopener&quot; class=&quot;flex h-4.5 overflow-hidden rounded-xl px-2 text-[0.5625em] font-medium text-token-text-secondary! bg-[#F4F4F4]! dark:bg-[#303030]! transition-colors duration-150 ease-in-out&quot;&gt;&lt;span class=&quot;relative start-0 bottom-0 flex h-full w-full items-center&quot;&gt;&lt;span class=&quot;flex h-4 w-full items-center justify-between overflow-hidden&quot;&gt;&lt;span class=&quot;max-w-full grow truncate overflow-hidden text-center&quot;&gt;Instagram&lt;/span&gt;&lt;/span&gt;&lt;/span&gt;&lt;/a&gt;&lt;/span&gt;&lt;/p&gt;\r\n&lt;p data-start=&quot;199&quot; data-end=&quot;356&quot; class=&quot;&quot;&gt;&lt;span class=&quot;relative -mx-px my-[-0.2rem] rounded px-px py-[0.2rem] transition-colors duration-100 ease-in-out&quot;&gt;The\r\n brand\'s women\'s collection showcases the versatility and richness of \r\nAnkara fabric, transforming it into chic dresses, sophisticated \r\njumpsuits, and elegant two-piece ensembles.&lt;/span&gt; &lt;span class=&quot;relative -mx-px my-[-0.2rem] rounded px-px py-[0.2rem] transition-colors duration-100 ease-in-out&quot;&gt;Each\r\n piece is a testament to meticulous craftsmanship, featuring bold \r\npatterns and contemporary cuts that celebrate African heritage while \r\ncatering to modern fashion tastes.&lt;/span&gt; ​&lt;/p&gt;\r\n&lt;p data-start=&quot;358&quot; data-end=&quot;481&quot; class=&quot;&quot;&gt;&lt;span class=&quot;relative -mx-px my-[-0.2rem] rounded px-px py-[0.2rem] transition-colors duration-100 ease-in-out&quot;&gt;Wecis\r\n Clothing\'s commitment to quality and authenticity is evident in their \r\ndesign process, where traditional motifs are reimagined through a \r\ncontemporary lens.&lt;/span&gt; &lt;span class=&quot;relative -mx-px my-[-0.2rem] rounded px-px py-[0.2rem] transition-colors duration-100 ease-in-out&quot;&gt;This\r\n approach not only honors the cultural significance of Ankara prints but\r\n also positions them within the global fashion narrative, making \r\nAfrican-inspired designs accessible and appealing to a diverse \r\nclientele.&lt;/span&gt;​&lt;/p&gt;\r\n&lt;p data-start=&quot;483&quot; data-end=&quot;648&quot; class=&quot;&quot;&gt;&lt;span class=&quot;relative -mx-px my-[-0.2rem] rounded px-px py-[0.2rem] transition-colors duration-100 ease-in-out&quot;&gt;The\r\n brand\'s active presence on social media platforms, particularly \r\nInstagram, serves as a dynamic showcase of their latest collections and \r\nfashion inspirations.&lt;/span&gt; &lt;span class=&quot;relative -mx-px my-[-0.2rem] rounded px-px py-[0.2rem] transition-colors duration-100 ease-in-out&quot;&gt;Through\r\n engaging visuals and storytelling, Wecis Clothing connects with a broad\r\n audience, fostering a community that appreciates the fusion of \r\ntradition and modernity in fashion.&lt;/span&gt; ​&lt;/p&gt;\r\n&lt;p data-start=&quot;650&quot; data-end=&quot;775&quot; class=&quot;&quot;&gt;&lt;span class=&quot;relative -mx-px my-[-0.2rem] rounded px-px py-[0.2rem] transition-colors duration-100 ease-in-out&quot;&gt;With\r\n worldwide delivery options, Wecis Clothing ensures that their unique \r\nblend of African aesthetics and contemporary fashion reaches customers \r\nacross the globe.&lt;/span&gt; &lt;span class=&quot;relative -mx-px my-[-0.2rem] rounded px-px py-[0.2rem] transition-colors duration-100 ease-in-out&quot;&gt;Their\r\n dedication to excellence and cultural expression makes them a standout \r\nbrand for those seeking to embrace African-inspired fashion with a \r\nmodern twist.&lt;/span&gt;&lt;/p&gt;&lt;br&gt;&lt;br&gt;  '),
(4, 1, 'African Women Prints In Nigeria - Ankara', '&lt;p data-start=&quot;40&quot; data-end=&quot;197&quot; class=&quot;&quot;&gt;&lt;span class=&quot;relative -mx-px my-[-0.2rem] rounded px-px py-[0.2rem] transition-colors duration-100 ease-in-out&quot;&gt;Wecis Clothing stands at the forefront of contemporary African fashion, seamlessly blending traditional Ankara prints with modern design sensibilities.&lt;/span&gt; &lt;span class=&quot;relative -mx-px my-[-0.2rem] rounded px-px py-[0.2rem] transition-colors duration-100 ease-in-out&quot;&gt;Based in Lagos, Nigeria, with flagship stores in Ikeja and Victoria Island, Wecis Clothing has carved a niche for itself by offering vibrant, stylish, and culturally resonant apparel that appeals to a global audience.&lt;/span&gt; ​&lt;span class=&quot;ms-1 inline-flex max-w-full items-center relative top-[-0.094rem] animate-[show_150ms_ease-in]&quot;&gt;&lt;a href=&quot;https://www.instagram.com/wecisclothing/?hl=en&amp;amp;utm_source=chatgpt.com&quot; target=&quot;_blank&quot; rel=&quot;noopener&quot; class=&quot;flex h-4.5 overflow-hidden rounded-xl px-2 text-[0.5625em] font-medium text-token-text-secondary! bg-[#F4F4F4]! dark:bg-[#303030]! transition-colors duration-150 ease-in-out&quot;&gt;&lt;span class=&quot;relative start-0 bottom-0 flex h-full w-full items-center&quot;&gt;&lt;span class=&quot;flex h-4 w-full items-center justify-between overflow-hidden&quot;&gt;&lt;span class=&quot;max-w-full grow truncate overflow-hidden text-center&quot;&gt;Instagram&lt;/span&gt;&lt;/span&gt;&lt;/span&gt;&lt;/a&gt;&lt;/span&gt;&lt;/p&gt;\r\n&lt;p data-start=&quot;199&quot; data-end=&quot;356&quot; class=&quot;&quot;&gt;&lt;span class=&quot;relative -mx-px my-[-0.2rem] rounded px-px py-[0.2rem] transition-colors duration-100 ease-in-out&quot;&gt;The brand\'s women\'s collection showcases the versatility and richness of Ankara fabric, transforming it into chic dresses, sophisticated jumpsuits, and elegant two-piece ensembles.&lt;/span&gt; &lt;span class=&quot;relative -mx-px my-[-0.2rem] rounded px-px py-[0.2rem] transition-colors duration-100 ease-in-out&quot;&gt;Each piece is a testament to meticulous craftsmanship, featuring bold patterns and contemporary cuts that celebrate African heritage while catering to modern fashion tastes.&lt;/span&gt; ​&lt;/p&gt;\r\n&lt;p data-start=&quot;358&quot; data-end=&quot;481&quot; class=&quot;&quot;&gt;&lt;span class=&quot;relative -mx-px my-[-0.2rem] rounded px-px py-[0.2rem] transition-colors duration-100 ease-in-out&quot;&gt;Wecis Clothing\'s commitment to quality and authenticity is evident in their design process, where traditional motifs are reimagined through a contemporary lens.&lt;/span&gt; &lt;span class=&quot;relative -mx-px my-[-0.2rem] rounded px-px py-[0.2rem] transition-colors duration-100 ease-in-out&quot;&gt;This approach not only honors the cultural significance of Ankara prints but also positions them within the global fashion narrative, making African-inspired designs accessible and appealing to a diverse clientele.&lt;/span&gt;​&lt;/p&gt;\r\n&lt;p data-start=&quot;483&quot; data-end=&quot;648&quot; class=&quot;&quot;&gt;&lt;span class=&quot;relative -mx-px my-[-0.2rem] rounded px-px py-[0.2rem] transition-colors duration-100 ease-in-out&quot;&gt;The brand\'s active presence on social media platforms, particularly Instagram, serves as a dynamic showcase of their latest collections and fashion inspirations.&lt;/span&gt; &lt;span class=&quot;relative -mx-px my-[-0.2rem] rounded px-px py-[0.2rem] transition-colors duration-100 ease-in-out&quot;&gt;Through engaging visuals and storytelling, Wecis Clothing connects with a broad audience, fostering a community that appreciates the fusion of tradition and modernity in fashion.&lt;/span&gt; ​&lt;/p&gt;\r\n&lt;p data-start=&quot;650&quot; data-end=&quot;775&quot; class=&quot;&quot;&gt;&lt;span class=&quot;relative -mx-px my-[-0.2rem] rounded px-px py-[0.2rem] transition-colors duration-100 ease-in-out&quot;&gt;With worldwide delivery options, Wecis Clothing ensures that their unique blend of African aesthetics and contemporary fashion reaches customers across the globe.&lt;/span&gt; &lt;span class=&quot;relative -mx-px my-[-0.2rem] rounded px-px py-[0.2rem] transition-colors duration-100 ease-in-out&quot;&gt;Their dedication to excellence and cultural expression makes them a standout brand for those seeking to embrace African-inspired fashion with a modern twist.&lt;/span&gt;&lt;/p&gt;&lt;br&gt;  '),
(3, 2, 'Agbada a traditional wear for sophisticated men', '&lt;p data-start=&quot;120&quot; data-end=&quot;189&quot; class=&quot;&quot;&gt;&lt;strong data-start=&quot;120&quot; data-end=&quot;189&quot;&gt;Agbada: Regal Attire and Cultural Pride in Nigerian Men\'s Fashion&lt;/strong&gt;&lt;/p&gt;\r\n&lt;p data-start=&quot;191&quot; data-end=&quot;725&quot; class=&quot;&quot;&gt;Agbada is more than just clothing; it is a &lt;strong data-start=&quot;234&quot; data-end=&quot;283&quot;&gt;symbol of prestige, power, and cultural pride&lt;/strong&gt; among Nigerian men. This traditional attire, typically worn for significant ceremonies, celebrations, and formal gatherings, consists of a wide-sleeved flowing outer robe, an inner long-sleeved shirt, and trousers (known as “sokoto”). Worn primarily by the Yoruba people but embraced across various ethnic groups in Nigeria, the Agbada reflects both &lt;strong data-start=&quot;634&quot; data-end=&quot;657&quot;&gt;heritage and status&lt;/strong&gt;, making it one of the most iconic garments in West African fashion.&lt;/p&gt;\r\n&lt;p data-start=&quot;727&quot; data-end=&quot;1248&quot; class=&quot;&quot;&gt;Crafted from luxurious fabrics such as brocade, lace, or aso-oke, the Agbada is often &lt;strong data-start=&quot;813&quot; data-end=&quot;852&quot;&gt;embroidered with intricate patterns&lt;/strong&gt; that tell stories or represent tribal affiliations, family crests, or personal achievements. Colors are chosen not just for aesthetic appeal but also for their symbolic meanings—royal blue for strength, white for purity, and gold for prosperity. The attention to detail in the embroidery and fabric choice transforms Agbada into &lt;strong data-start=&quot;1182&quot; data-end=&quot;1208&quot;&gt;a wearable work of art&lt;/strong&gt;, often handed down through generations.&lt;/p&gt;\r\n&lt;p data-start=&quot;1250&quot; data-end=&quot;1735&quot; class=&quot;&quot;&gt;In modern times, Agbada has evolved beyond its traditional roots, becoming a &lt;strong data-start=&quot;1327&quot; data-end=&quot;1362&quot;&gt;fashion-forward statement piece&lt;/strong&gt; among Nigerian men at weddings, award shows, and high-society events. Contemporary designers have reimagined Agbada with sleeker silhouettes, bolder colors, and creative cuts that blend traditional aesthetics with modern luxury. Celebrities, grooms, and dignitaries now wear Agbada not just to celebrate culture, but to express &lt;strong data-start=&quot;1691&quot; data-end=&quot;1734&quot;&gt;individuality, confidence, and elegance&lt;/strong&gt;.&lt;/p&gt;\r\n&lt;p data-start=&quot;1737&quot; data-end=&quot;2133&quot; class=&quot;&quot;&gt;The resurgence of Agbada in global fashion highlights a broader movement of &lt;strong data-start=&quot;1813&quot; data-end=&quot;1845&quot;&gt;African cultural reawakening&lt;/strong&gt; and pride. From the streets of Lagos to runways in Paris, Nigerian designers are bringing Agbada into mainstream consciousness. It’s now common to see Agbada featured in photoshoots, music videos, and international fashion publications, showcasing &lt;strong data-start=&quot;2094&quot; data-end=&quot;2132&quot;&gt;Africa’s influence on global style&lt;/strong&gt;.&lt;/p&gt;\r\n&lt;p data-start=&quot;2135&quot; data-end=&quot;2525&quot; class=&quot;&quot;&gt;Ultimately, Agbada is more than just attire—it is a &lt;strong data-start=&quot;2187&quot; data-end=&quot;2227&quot;&gt;declaration of identity and heritage&lt;/strong&gt;. Whether styled in its majestic traditional form or given a modern twist, Agbada continues to command respect, admiration, and awe. As Nigerian men continue to embrace and redefine their culture through fashion, Agbada remains a timeless symbol of &lt;strong data-start=&quot;2476&quot; data-end=&quot;2524&quot;&gt;dignity, celebration, and African excellence&lt;/strong&gt;.&lt;/p&gt;&lt;br&gt;  '),
(3, 1, 'Agbada a traditional wear for sophisticated men', '&lt;p data-start=&quot;120&quot; data-end=&quot;189&quot; class=&quot;&quot;&gt;&lt;strong data-start=&quot;120&quot; data-end=&quot;189&quot;&gt;Agbada: Regal Attire and Cultural Pride in Nigerian Men\'s Fashion&lt;/strong&gt;&lt;/p&gt;\r\n&lt;p data-start=&quot;191&quot; data-end=&quot;725&quot; class=&quot;&quot;&gt;Agbada is more than just clothing; it is a &lt;strong data-start=&quot;234&quot; data-end=&quot;283&quot;&gt;symbol of prestige, power, and cultural pride&lt;/strong&gt; among Nigerian men. This traditional attire, typically worn for significant ceremonies, celebrations, and formal gatherings, consists of a wide-sleeved flowing outer robe, an inner long-sleeved shirt, and trousers (known as “sokoto”). Worn primarily by the Yoruba people but embraced across various ethnic groups in Nigeria, the Agbada reflects both &lt;strong data-start=&quot;634&quot; data-end=&quot;657&quot;&gt;heritage and status&lt;/strong&gt;, making it one of the most iconic garments in West African fashion.&lt;/p&gt;\r\n&lt;p data-start=&quot;727&quot; data-end=&quot;1248&quot; class=&quot;&quot;&gt;Crafted from luxurious fabrics such as brocade, lace, or aso-oke, the Agbada is often &lt;strong data-start=&quot;813&quot; data-end=&quot;852&quot;&gt;embroidered with intricate patterns&lt;/strong&gt; that tell stories or represent tribal affiliations, family crests, or personal achievements. Colors are chosen not just for aesthetic appeal but also for their symbolic meanings—royal blue for strength, white for purity, and gold for prosperity. The attention to detail in the embroidery and fabric choice transforms Agbada into &lt;strong data-start=&quot;1182&quot; data-end=&quot;1208&quot;&gt;a wearable work of art&lt;/strong&gt;, often handed down through generations.&lt;/p&gt;\r\n&lt;p data-start=&quot;1250&quot; data-end=&quot;1735&quot; class=&quot;&quot;&gt;In modern times, Agbada has evolved beyond its traditional roots, becoming a &lt;strong data-start=&quot;1327&quot; data-end=&quot;1362&quot;&gt;fashion-forward statement piece&lt;/strong&gt; among Nigerian men at weddings, award shows, and high-society events. Contemporary designers have reimagined Agbada with sleeker silhouettes, bolder colors, and creative cuts that blend traditional aesthetics with modern luxury. Celebrities, grooms, and dignitaries now wear Agbada not just to celebrate culture, but to express &lt;strong data-start=&quot;1691&quot; data-end=&quot;1734&quot;&gt;individuality, confidence, and elegance&lt;/strong&gt;.&lt;/p&gt;\r\n&lt;p data-start=&quot;1737&quot; data-end=&quot;2133&quot; class=&quot;&quot;&gt;The resurgence of Agbada in global fashion highlights a broader movement of &lt;strong data-start=&quot;1813&quot; data-end=&quot;1845&quot;&gt;African cultural reawakening&lt;/strong&gt; and pride. From the streets of Lagos to runways in Paris, Nigerian designers are bringing Agbada into mainstream consciousness. It’s now common to see Agbada featured in photoshoots, music videos, and international fashion publications, showcasing &lt;strong data-start=&quot;2094&quot; data-end=&quot;2132&quot;&gt;Africa’s influence on global style&lt;/strong&gt;.&lt;/p&gt;\r\n&lt;p data-start=&quot;2135&quot; data-end=&quot;2525&quot; class=&quot;&quot;&gt;Ultimately, Agbada is more than just attire—it is a &lt;strong data-start=&quot;2187&quot; data-end=&quot;2227&quot;&gt;declaration of identity and heritage&lt;/strong&gt;. Whether styled in its majestic traditional form or given a modern twist, Agbada continues to command respect, admiration, and awe. As Nigerian men continue to embrace and redefine their culture through fashion, Agbada remains a timeless symbol of &lt;strong data-start=&quot;2476&quot; data-end=&quot;2524&quot;&gt;dignity, celebration, and African excellence&lt;/strong&gt;.&lt;/p&gt;&lt;br&gt;  ');

-- --------------------------------------------------------

--
-- Table structure for table `oc_cart`
--

CREATE TABLE `oc_cart` (
  `cart_id` int UNSIGNED NOT NULL,
  `api_id` int NOT NULL,
  `customer_id` int NOT NULL,
  `session_id` varchar(32) NOT NULL,
  `product_id` int NOT NULL,
  `recurring_id` int NOT NULL,
  `option` text NOT NULL,
  `quantity` int NOT NULL,
  `date_added` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_cart`
--

INSERT INTO `oc_cart` (`cart_id`, `api_id`, `customer_id`, `session_id`, `product_id`, `recurring_id`, `option`, `quantity`, `date_added`) VALUES
(19, 0, 1, '317800ccc82ddeb7069e1cb5ce', 48, 0, '[]', 1, '2019-10-03 12:36:58'),
(20, 0, 6, 'f9169e298e9a151e2df7cfb83c', 31, 0, '[]', 1, '2021-01-19 12:22:02'),
(21, 0, 6, 'f9169e298e9a151e2df7cfb83c', 32, 0, '[]', 1, '2021-01-19 12:22:03'),
(34, 0, 3, 'ac86a83d70cdaab270b85aceae', 36, 0, '[]', 2, '2021-01-22 12:21:34'),
(35, 0, 3, 'ac86a83d70cdaab270b85aceae', 40, 0, '[]', 1, '2021-01-22 12:21:34'),
(36, 0, 3, 'ac86a83d70cdaab270b85aceae', 43, 0, '[]', 1, '2021-01-22 12:21:34'),
(43, 0, 3, 'ac86a83d70cdaab270b85aceae', 35, 0, '{\"224\":\"13\"}', 3, '2021-01-23 15:41:50'),
(44, 0, 3, 'ac86a83d70cdaab270b85aceae', 34, 0, '[]', 1, '2021-01-23 15:42:57'),
(50, 0, 7, '5cca16acae1df853453f069dfe', 43, 0, '{\"251\":\"nothing\\n\",\"252\":\"2021-01-23\",\"253\":\"05:48\",\"254\":\"2021-01-23 05:48\"}', 1, '2021-02-02 10:43:12'),
(51, 0, 10, '3bb80ec89f0df7a2921586f650', 47, 0, '{\"228\":[\"17\"],\"227\":\"test\",\"225\":\"2011-04-22\"}', 1, '2021-02-03 11:38:41'),
(53, 0, 3, 'ac86a83d70cdaab270b85aceae', 32, 0, '{\"235\":\"2021-01-20\",\"236\":\"18:27\",\"237\":\"2021-01-20 18:27\"}', 1, '2021-03-03 11:13:59'),
(71, 0, 11, '04aa4e36cb3681272064fe3bf9', 52, 0, '{\"283\":\"fff\",\"281\":\"16:22\",\"282\":\"2021-01-10 16:22\"}', 1, '2025-04-18 05:07:05');

-- --------------------------------------------------------

--
-- Table structure for table `oc_category`
--

CREATE TABLE `oc_category` (
  `category_id` int NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `parent_id` int NOT NULL DEFAULT '0',
  `top` tinyint(1) NOT NULL,
  `column` int NOT NULL,
  `sort_order` int NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL,
  `date_added` datetime NOT NULL,
  `date_modified` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_category`
--

INSERT INTO `oc_category` (`category_id`, `image`, `parent_id`, `top`, `column`, `sort_order`, `status`, `date_added`, `date_modified`) VALUES
(25, 'catalog/category-banner.jpg', 0, 1, 1, 1, 1, '2009-01-31 01:04:25', '2026-05-09 20:26:58'),
(27, '', 20, 0, 0, 2, 1, '2009-01-31 01:55:34', '2026-05-21 11:03:02'),
(20, 'catalog/category-banner.jpg', 0, 1, 3, 1, 1, '2009-01-05 21:49:43', '2025-05-01 18:30:54'),
(24, 'catalog/category-banner.jpg', 0, 1, 1, 5, 1, '2009-01-20 02:36:26', '2025-04-19 20:37:29'),
(17, 'catalog/category-banner.jpg', 0, 1, 1, 1, 1, '2009-01-03 21:08:57', '2026-05-21 11:04:04'),
(28, '', 25, 0, 0, 2, 1, '2009-02-02 13:11:12', '2025-04-19 20:27:30'),
(26, '', 20, 0, 1, 2, 1, '2009-01-31 01:55:14', '2025-04-19 20:21:55'),
(30, '', 25, 0, 0, 2, 1, '2009-02-02 13:11:59', '2026-05-21 11:05:47'),
(31, '', 25, 0, 0, 2, 1, '2009-02-03 14:17:24', '2026-05-21 11:05:25'),
(32, '', 25, 0, 0, 2, 1, '2009-02-03 14:17:34', '2026-05-09 20:27:34'),
(35, '', 25, 0, 0, 2, 1, '2010-09-17 10:06:48', '2026-05-21 11:04:55'),
(37, '', 43, 0, 0, 3, 1, '2010-09-18 14:03:39', '2026-05-09 20:25:19'),
(38, '', 43, 0, 0, 3, 1, '2010-09-18 14:03:51', '2026-05-09 20:24:18'),
(39, '', 43, 0, 0, 3, 1, '2010-09-18 14:04:17', '2025-04-19 20:26:07'),
(40, '', 43, 0, 0, 4, 1, '2010-09-18 14:05:36', '2025-04-19 20:24:04'),
(43, '', 20, 0, 0, 2, 1, '2010-09-18 14:06:49', '2026-05-09 20:19:32'),
(49, '', 27, 0, 0, 1, 1, '2010-11-07 11:14:04', '2025-05-01 18:24:33'),
(50, '', 27, 0, 0, 2, 1, '2010-11-07 11:14:23', '2025-05-01 18:26:29'),
(51, '', 27, 0, 0, 3, 1, '2010-11-07 11:14:38', '2025-05-01 18:23:23'),
(52, '', 27, 0, 0, 3, 1, '2010-11-07 11:16:09', '2026-05-21 11:01:58'),
(53, '', 26, 0, 0, 3, 1, '2010-11-07 11:28:53', '2026-05-21 11:02:24'),
(54, '', 26, 0, 0, 2, 1, '2010-11-07 11:29:16', '2025-05-01 18:29:47'),
(55, '', 26, 0, 0, 3, 1, '2010-11-08 10:31:32', '2025-05-01 18:27:33'),
(56, '', 26, 0, 0, 4, 1, '2010-11-08 10:31:50', '2025-05-01 18:28:02'),
(59, '', 0, 1, 1, 3, 1, '2018-12-29 11:00:51', '2025-04-19 20:20:35'),
(60, '', 0, 1, 1, 3, 1, '2018-12-29 11:02:20', '2025-04-19 20:19:36'),
(61, '', 25, 1, 1, 2, 1, '2025-04-19 20:34:42', '2026-05-09 20:28:03');

-- --------------------------------------------------------

--
-- Table structure for table `oc_category_description`
--

CREATE TABLE `oc_category_description` (
  `category_id` int NOT NULL,
  `language_id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `meta_title` varchar(255) NOT NULL,
  `meta_description` varchar(255) NOT NULL,
  `meta_keyword` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_category_description`
--

INSERT INTO `oc_category_description` (`category_id`, `language_id`, `name`, `description`, `meta_title`, `meta_description`, `meta_keyword`) VALUES
(32, 1, 'Hut couture', '', 'Turtle Neck', '', ''),
(20, 1, 'Men', '&lt;p data-start=&quot;112&quot; data-end=&quot;523&quot; class=&quot;&quot;&gt;At &lt;strong data-start=&quot;115&quot; data-end=&quot;134&quot;&gt;Wecis Clothings&lt;/strong&gt;, our men’s wear collection is designed for the modern man who values style, culture, and confidence. We blend timeless African fabrics—like Ankara, brocade, and aso-oke—with contemporary tailoring to deliver outfits that are bold, refined, and unapologetically elegant. Whether for weddings, traditional ceremonies, or urban street style, our pieces embody both heritage and high fashion.&lt;/p&gt;\r\n&lt;p data-start=&quot;525&quot; data-end=&quot;951&quot; class=&quot;&quot;&gt;From intricately embroidered Agbadas to sharp two-piece Kaftans and modern senator sets, each garment is crafted with precision and purpose. We pay close attention to fit, detail, and finishing, ensuring that every outfit not only turns heads but also tells a story of African excellence. Our color palettes range from deep earthy tones to vibrant prints, empowering men to express themselves confidently through their attire.&lt;/p&gt;\r\n&lt;p data-start=&quot;953&quot; data-end=&quot;1294&quot; class=&quot;&quot;&gt;With &lt;strong data-start=&quot;958&quot; data-end=&quot;980&quot;&gt;worldwide delivery&lt;/strong&gt;, Wecis Clothings makes it easy for men across the globe to embrace African-inspired fashion. Whether you’re dressing for legacy or leisure, our men’s wear collection offers a statement of pride, tradition, and contemporary masculinity. At Wecis, we don’t just make clothes—we &lt;strong data-start=&quot;1257&quot; data-end=&quot;1293&quot;&gt;craft culture with a modern edge&lt;/strong&gt;.&lt;/p&gt;&lt;br&gt;', 'Men', 'men', ''),
(49, 1, 'Office Suit', '', 'Office Suit', '', ''),
(40, 1, 'Short Sleeves', '', 'Console', '', ''),
(28, 2, 'Baseball', '', 'Baseball', '', ''),
(31, 1, 'Short dress', '', 'Polo Collar', '', ''),
(59, 1, 'Kaftan', '', 'Componenets', '', ''),
(60, 1, 'Bubu', '', 'Tablets', '', ''),
(27, 1, 'Suit', '', 'Monitors', '', ''),
(50, 1, 'Conductor', '', 'Conductor', '', ''),
(35, 1, 'Pants', '', 'Wide Neck', '', ''),
(28, 1, 'Causal', '', 'Baseball', '', ''),
(32, 2, 'Turtle Neck', '', 'Turtle Neck', '', ''),
(54, 1, 'Round NeckShirts', '', 'Round NeckShirts', '', ''),
(56, 1, 'Customised T-Shirts', '', 'Customised T-Shirts', '', ''),
(51, 1, 'Safari Plain', '', 'Safari Plain', '', ''),
(24, 2, 'Fila', '', 'Fila', '', ''),
(26, 2, 'Accessories', '', 'Accessories', '', ''),
(43, 1, 'Agbada', '', 'Agbada', '', ''),
(27, 2, 'Clothing', '', 'Clothing', '', ''),
(26, 1, 'Causal', '', 'Accessories', '', ''),
(55, 1, 'Trousers', '', 'Trousers', '', ''),
(49, 2, 'Office Suit', '', 'Office Suit', '', ''),
(51, 2, 'Safari Plain', '', 'Safari Plain', '', ''),
(50, 2, 'Conductor', '', 'Conductor', '', ''),
(55, 2, 'Wallets &amp; Belts', '', 'Wallets &amp; Belts', '', ''),
(53, 1, 'Shirts', '', 'Shirts', '', ''),
(38, 2, 'Formal Shoes', '', 'Formal Shoes', '', ''),
(39, 1, 'Plaited Short Sleeves', '', 'Gaming Mousepad', '', ''),
(40, 2, 'Climbing Shoes', '', 'Climbing Shoes', '', ''),
(60, 2, 'Duffel Coat', '', 'Duffel Coat', '', ''),
(59, 2, 'Scarf &amp; Blazer', '', 'Scarf &amp; Blazer', '', ''),
(31, 2, 'Polo Collar', '', 'Polo Collar', '', ''),
(35, 2, 'Wide Neck', '', 'Wide Neck', '', ''),
(17, 2, 'Blush Shirt', '', 'Blush Shirt', '', ''),
(53, 2, 'Shirts', '', 'Shirts', '', ''),
(43, 2, 'Footwear', '', 'Footwear', '', ''),
(39, 2, 'Flip-Flops', '', 'Flip-Flops', '', ''),
(24, 1, 'Fila', '', 'Fila', '', ''),
(37, 1, 'Long Sleeves without Curfs', '', 'Long Sleeves without Curfs', '', ''),
(30, 1, 'Skirt and blouse', '', 'Baby Doll', '', ''),
(61, 1, 'Long dress', '&lt;p&gt;Long dress&lt;/p&gt;', 'Long dress', 'Long dress', 'Long dress'),
(52, 2, 'Safari with Stripes', '', 'Safari with Stripes', '', ''),
(52, 1, 'Safari with Stripes', '', 'Safari with Stripes', '', ''),
(56, 2, 'Customised T-Shirts', '', 'Customised T-Shirts', '', ''),
(54, 2, 'Round NeckShirts', '', 'Round NeckShirts', '', ''),
(20, 2, 'Men', '&lt;p data-start=&quot;112&quot; data-end=&quot;523&quot; class=&quot;&quot;&gt;At &lt;strong data-start=&quot;115&quot; data-end=&quot;134&quot;&gt;Wecis Clothings&lt;/strong&gt;,\r\n our men’s wear collection is designed for the modern man who values \r\nstyle, culture, and confidence. We blend timeless African fabrics—like \r\nAnkara, brocade, and aso-oke—with contemporary tailoring to deliver \r\noutfits that are bold, refined, and unapologetically elegant. Whether \r\nfor weddings, traditional ceremonies, or urban street style, our pieces \r\nembody both heritage and high fashion.&lt;/p&gt;\r\n&lt;p data-start=&quot;525&quot; data-end=&quot;951&quot; class=&quot;&quot;&gt;From intricately embroidered\r\n Agbadas to sharp two-piece Kaftans and modern senator sets, each \r\ngarment is crafted with precision and purpose. We pay close attention to\r\n fit, detail, and finishing, ensuring that every outfit not only turns \r\nheads but also tells a story of African excellence. Our color palettes \r\nrange from deep earthy tones to vibrant prints, empowering men to \r\nexpress themselves confidently through their attire.&lt;/p&gt;\r\n&lt;p data-start=&quot;953&quot; data-end=&quot;1294&quot; class=&quot;&quot;&gt;With &lt;strong data-start=&quot;958&quot; data-end=&quot;980&quot;&gt;worldwide delivery&lt;/strong&gt;,\r\n Wecis Clothings makes it easy for men across the globe to embrace \r\nAfrican-inspired fashion. Whether you’re dressing for legacy or leisure,\r\n our men’s wear collection offers a statement of pride, tradition, and \r\ncontemporary masculinity. At Wecis, we don’t just make clothes—we &lt;strong data-start=&quot;1257&quot; data-end=&quot;1293&quot;&gt;craft culture with a modern edge&lt;/strong&gt;.&lt;/p&gt;&lt;br&gt;&lt;br&gt;', 'Men', 'Example of category description', ''),
(25, 2, 'Women', '&lt;p data-start=&quot;101&quot; data-end=&quot;534&quot; class=&quot;&quot;&gt;At &lt;strong data-start=&quot;104&quot; data-end=&quot;123&quot;&gt;Wecis Clothings&lt;/strong&gt;, our women’s wear collection celebrates the strength, grace, and beauty of the modern African woman. Inspired by traditional Ankara prints and reimagined through contemporary silhouettes, our pieces are designed to make bold statements—whether you’re attending a wedding, hosting a cultural event, or simply owning your everyday style. Each outfit is crafted to embody elegance, confidence, and cultural pride.&lt;/p&gt;\r\n&lt;p data-start=&quot;536&quot; data-end=&quot;943&quot; class=&quot;&quot;&gt;From flowing gowns to tailored jumpsuits, chic two-piece sets to stylish wrap dresses, every Wecis garment is a fusion of artistry and precision. Our designs highlight the richness of African textiles with vibrant colors, daring cuts, and fine detailing that flatter all body types. We don’t just follow trends—we set them by redefining how African fashion is worn and experienced by women around the world.&lt;/p&gt;\r\n&lt;p data-start=&quot;945&quot; data-end=&quot;1278&quot; class=&quot;&quot;&gt;With &lt;strong data-start=&quot;950&quot; data-end=&quot;997&quot;&gt;global delivery and a commitment to quality&lt;/strong&gt;, Wecis Clothings ensures that women everywhere can access timeless African fashion with a modern twist. Whether you\'re dressing for legacy, leadership, or leisure, our collection is designed to empower you to stand out and own your identity—with elegance stitched into every seam.&lt;/p&gt;\r\n&lt;p&gt;&lt;br&gt;&lt;/p&gt;', 'Women', '', ''),
(25, 1, 'Women', '&lt;p data-start=&quot;101&quot; data-end=&quot;534&quot; class=&quot;&quot;&gt;At &lt;strong data-start=&quot;104&quot; data-end=&quot;123&quot;&gt;Wecis Clothings&lt;/strong&gt;, our women’s wear collection celebrates the strength, grace, and beauty of the modern African woman. Inspired by traditional Ankara prints and reimagined through contemporary silhouettes, our pieces are designed to make bold statements—whether you’re attending a wedding, hosting a cultural event, or simply owning your everyday style. Each outfit is crafted to embody elegance, confidence, and cultural pride.&lt;/p&gt;\r\n&lt;p data-start=&quot;536&quot; data-end=&quot;943&quot; class=&quot;&quot;&gt;From flowing gowns to tailored jumpsuits, chic two-piece sets to stylish wrap dresses, every Wecis garment is a fusion of artistry and precision. Our designs highlight the richness of African textiles with vibrant colors, daring cuts, and fine detailing that flatter all body types. We don’t just follow trends—we set them by redefining how African fashion is worn and experienced by women around the world.&lt;/p&gt;\r\n&lt;p data-start=&quot;945&quot; data-end=&quot;1278&quot; class=&quot;&quot;&gt;With &lt;strong data-start=&quot;950&quot; data-end=&quot;997&quot;&gt;global delivery and a commitment to quality&lt;/strong&gt;, Wecis Clothings ensures that women everywhere can access timeless African fashion with a modern twist. Whether you\'re dressing for legacy, leadership, or leisure, our collection is designed to empower you to stand out and own your identity—with elegance stitched into every seam.&lt;/p&gt;\r\n&lt;p&gt;&lt;br&gt;&lt;/p&gt;', 'Women', '', ''),
(38, 1, 'Long Sleeves with Curfs', '', 'Long Sleeves with Curfs', '', ''),
(37, 2, 'Sandles', '', 'Sandles', '', ''),
(61, 2, 'Long dress', '', 'Long dress', '', ''),
(17, 1, 'Safari', '', 'Software', '', ''),
(30, 2, 'Baby Doll', '', 'Baby Doll', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `oc_category_filter`
--

CREATE TABLE `oc_category_filter` (
  `category_id` int NOT NULL,
  `filter_id` int NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_category_filter`
--

INSERT INTO `oc_category_filter` (`category_id`, `filter_id`) VALUES
(17, 1),
(17, 2),
(17, 3),
(17, 4),
(17, 5),
(17, 6),
(17, 7),
(17, 9),
(17, 10),
(17, 11),
(20, 1),
(20, 2),
(20, 3),
(20, 4),
(20, 5),
(20, 6),
(20, 7),
(20, 9),
(20, 10),
(20, 11),
(24, 1),
(24, 2),
(24, 3),
(24, 4),
(24, 5),
(24, 6),
(24, 7),
(24, 9),
(24, 10),
(24, 11),
(25, 1),
(25, 2),
(25, 3),
(25, 4),
(25, 5),
(25, 6),
(25, 7),
(25, 9),
(25, 10),
(25, 11),
(26, 1),
(26, 2),
(26, 3),
(26, 4),
(26, 5),
(26, 6),
(26, 7),
(26, 9),
(26, 10),
(26, 11),
(27, 1),
(27, 2),
(27, 3),
(27, 4),
(27, 5),
(27, 6),
(27, 7),
(27, 9),
(27, 10),
(27, 11),
(28, 1),
(28, 2),
(28, 3),
(28, 4),
(28, 5),
(28, 6),
(28, 7),
(28, 9),
(28, 10),
(28, 11),
(30, 1),
(30, 2),
(30, 3),
(30, 4),
(30, 5),
(30, 6),
(30, 7),
(30, 9),
(30, 10),
(30, 11),
(31, 1),
(31, 2),
(31, 3),
(31, 4),
(31, 5),
(31, 6),
(31, 7),
(31, 9),
(31, 10),
(31, 11),
(32, 1),
(32, 2),
(32, 3),
(32, 4),
(32, 5),
(32, 6),
(32, 7),
(32, 9),
(32, 10),
(32, 11),
(35, 1),
(35, 2),
(35, 3),
(35, 4),
(35, 5),
(35, 6),
(35, 7),
(35, 9),
(35, 10),
(35, 11),
(43, 1),
(43, 2),
(43, 3),
(43, 4),
(43, 5),
(43, 6),
(43, 7),
(43, 9),
(43, 10),
(43, 11),
(61, 1);

-- --------------------------------------------------------

--
-- Table structure for table `oc_category_path`
--

CREATE TABLE `oc_category_path` (
  `category_id` int NOT NULL,
  `path_id` int NOT NULL,
  `level` int NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_category_path`
--

INSERT INTO `oc_category_path` (`category_id`, `path_id`, `level`) VALUES
(25, 25, 0),
(28, 25, 0),
(28, 28, 1),
(35, 25, 0),
(35, 35, 1),
(30, 25, 0),
(30, 30, 1),
(31, 25, 0),
(31, 31, 1),
(32, 25, 0),
(32, 32, 1),
(20, 20, 0),
(27, 20, 0),
(27, 27, 1),
(26, 20, 0),
(26, 26, 1),
(24, 24, 0),
(39, 20, 0),
(37, 43, 1),
(40, 43, 1),
(17, 17, 0),
(37, 20, 0),
(37, 37, 2),
(38, 20, 0),
(38, 38, 2),
(39, 43, 1),
(39, 39, 2),
(40, 20, 0),
(40, 40, 2),
(43, 20, 0),
(43, 43, 1),
(38, 43, 1),
(56, 20, 0),
(55, 20, 0),
(54, 20, 0),
(53, 20, 0),
(52, 27, 1),
(49, 27, 1),
(49, 49, 2),
(50, 20, 0),
(50, 50, 2),
(51, 20, 0),
(51, 51, 2),
(52, 20, 0),
(52, 52, 2),
(51, 27, 1),
(50, 27, 1),
(49, 20, 0),
(53, 26, 1),
(53, 53, 2),
(54, 26, 1),
(54, 54, 2),
(55, 26, 1),
(55, 55, 2),
(56, 26, 1),
(56, 56, 2),
(59, 59, 0),
(60, 60, 0),
(61, 25, 0),
(61, 61, 1);

-- --------------------------------------------------------

--
-- Table structure for table `oc_category_to_layout`
--

CREATE TABLE `oc_category_to_layout` (
  `category_id` int NOT NULL,
  `store_id` int NOT NULL,
  `layout_id` int NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_category_to_layout`
--

INSERT INTO `oc_category_to_layout` (`category_id`, `store_id`, `layout_id`) VALUES
(20, 0, 0),
(25, 0, 0),
(17, 0, 0),
(24, 0, 0),
(27, 0, 0),
(26, 0, 0),
(43, 0, 0),
(28, 0, 0),
(35, 0, 0),
(30, 0, 0),
(31, 0, 0),
(49, 0, 0),
(50, 0, 0),
(51, 0, 0),
(52, 0, 0),
(53, 0, 0),
(54, 0, 0),
(55, 0, 0),
(56, 0, 0),
(38, 0, 0),
(37, 0, 0),
(39, 0, 0),
(40, 0, 0),
(32, 0, 0),
(59, 0, 0),
(60, 0, 0),
(61, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `oc_category_to_store`
--

CREATE TABLE `oc_category_to_store` (
  `category_id` int NOT NULL,
  `store_id` int NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_category_to_store`
--

INSERT INTO `oc_category_to_store` (`category_id`, `store_id`) VALUES
(17, 0),
(20, 0),
(24, 0),
(25, 0),
(26, 0),
(27, 0),
(28, 0),
(30, 0),
(31, 0),
(32, 0),
(35, 0),
(37, 0),
(38, 0),
(39, 0),
(40, 0),
(43, 0),
(49, 0),
(50, 0),
(51, 0),
(52, 0),
(53, 0),
(54, 0),
(55, 0),
(56, 0),
(59, 0),
(60, 0),
(61, 0);

-- --------------------------------------------------------

--
-- Table structure for table `oc_country`
--

CREATE TABLE `oc_country` (
  `country_id` int NOT NULL,
  `name` varchar(128) NOT NULL,
  `iso_code_2` varchar(2) NOT NULL,
  `iso_code_3` varchar(3) NOT NULL,
  `address_format` text NOT NULL,
  `postcode_required` tinyint(1) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_country`
--

INSERT INTO `oc_country` (`country_id`, `name`, `iso_code_2`, `iso_code_3`, `address_format`, `postcode_required`, `status`) VALUES
(1, 'Afghanistan', 'AF', 'AFG', '', 0, 1),
(2, 'Albania', 'AL', 'ALB', '', 0, 1),
(3, 'Algeria', 'DZ', 'DZA', '', 0, 1),
(4, 'American Samoa', 'AS', 'ASM', '', 0, 1),
(5, 'Andorra', 'AD', 'AND', '', 0, 1),
(6, 'Angola', 'AO', 'AGO', '', 0, 1),
(7, 'Anguilla', 'AI', 'AIA', '', 0, 1),
(8, 'Antarctica', 'AQ', 'ATA', '', 0, 1),
(9, 'Antigua and Barbuda', 'AG', 'ATG', '', 0, 1),
(10, 'Argentina', 'AR', 'ARG', '', 0, 1),
(11, 'Armenia', 'AM', 'ARM', '', 0, 1),
(12, 'Aruba', 'AW', 'ABW', '', 0, 1),
(13, 'Australia', 'AU', 'AUS', '', 0, 1),
(14, 'Austria', 'AT', 'AUT', '', 0, 1),
(15, 'Azerbaijan', 'AZ', 'AZE', '', 0, 1),
(16, 'Bahamas', 'BS', 'BHS', '', 0, 1),
(17, 'Bahrain', 'BH', 'BHR', '', 0, 1),
(18, 'Bangladesh', 'BD', 'BGD', '', 0, 1),
(19, 'Barbados', 'BB', 'BRB', '', 0, 1),
(20, 'Belarus', 'BY', 'BLR', '', 0, 1),
(21, 'Belgium', 'BE', 'BEL', '{firstname} {lastname}\r\n{company}\r\n{address_1}\r\n{address_2}\r\n{postcode} {city}\r\n{country}', 0, 1),
(22, 'Belize', 'BZ', 'BLZ', '', 0, 1),
(23, 'Benin', 'BJ', 'BEN', '', 0, 1),
(24, 'Bermuda', 'BM', 'BMU', '', 0, 1),
(25, 'Bhutan', 'BT', 'BTN', '', 0, 1),
(26, 'Bolivia', 'BO', 'BOL', '', 0, 1),
(27, 'Bosnia and Herzegovina', 'BA', 'BIH', '', 0, 1),
(28, 'Botswana', 'BW', 'BWA', '', 0, 1),
(29, 'Bouvet Island', 'BV', 'BVT', '', 0, 1),
(30, 'Brazil', 'BR', 'BRA', '', 0, 1),
(31, 'British Indian Ocean Territory', 'IO', 'IOT', '', 0, 1),
(32, 'Brunei Darussalam', 'BN', 'BRN', '', 0, 1),
(33, 'Bulgaria', 'BG', 'BGR', '', 0, 1),
(34, 'Burkina Faso', 'BF', 'BFA', '', 0, 1),
(35, 'Burundi', 'BI', 'BDI', '', 0, 1),
(36, 'Cambodia', 'KH', 'KHM', '', 0, 1),
(37, 'Cameroon', 'CM', 'CMR', '', 0, 1),
(38, 'Canada', 'CA', 'CAN', '', 0, 1),
(39, 'Cape Verde', 'CV', 'CPV', '', 0, 1),
(40, 'Cayman Islands', 'KY', 'CYM', '', 0, 1),
(41, 'Central African Republic', 'CF', 'CAF', '', 0, 1),
(42, 'Chad', 'TD', 'TCD', '', 0, 1),
(43, 'Chile', 'CL', 'CHL', '', 0, 1),
(44, 'China', 'CN', 'CHN', '', 0, 1),
(45, 'Christmas Island', 'CX', 'CXR', '', 0, 1),
(46, 'Cocos (Keeling) Islands', 'CC', 'CCK', '', 0, 1),
(47, 'Colombia', 'CO', 'COL', '', 0, 1),
(48, 'Comoros', 'KM', 'COM', '', 0, 1),
(49, 'Congo', 'CG', 'COG', '', 0, 1),
(50, 'Cook Islands', 'CK', 'COK', '', 0, 1),
(51, 'Costa Rica', 'CR', 'CRI', '', 0, 1),
(52, 'Cote D\'Ivoire', 'CI', 'CIV', '', 0, 1),
(53, 'Croatia', 'HR', 'HRV', '', 0, 1),
(54, 'Cuba', 'CU', 'CUB', '', 0, 1),
(55, 'Cyprus', 'CY', 'CYP', '', 0, 1),
(56, 'Czech Republic', 'CZ', 'CZE', '', 0, 1),
(57, 'Denmark', 'DK', 'DNK', '', 0, 1),
(58, 'Djibouti', 'DJ', 'DJI', '', 0, 1),
(59, 'Dominica', 'DM', 'DMA', '', 0, 1),
(60, 'Dominican Republic', 'DO', 'DOM', '', 0, 1),
(61, 'East Timor', 'TL', 'TLS', '', 0, 1),
(62, 'Ecuador', 'EC', 'ECU', '', 0, 1),
(63, 'Egypt', 'EG', 'EGY', '', 0, 1),
(64, 'El Salvador', 'SV', 'SLV', '', 0, 1),
(65, 'Equatorial Guinea', 'GQ', 'GNQ', '', 0, 1),
(66, 'Eritrea', 'ER', 'ERI', '', 0, 1),
(67, 'Estonia', 'EE', 'EST', '', 0, 1),
(68, 'Ethiopia', 'ET', 'ETH', '', 0, 1),
(69, 'Falkland Islands (Malvinas)', 'FK', 'FLK', '', 0, 1),
(70, 'Faroe Islands', 'FO', 'FRO', '', 0, 1),
(71, 'Fiji', 'FJ', 'FJI', '', 0, 1),
(72, 'Finland', 'FI', 'FIN', '', 0, 1),
(74, 'France, Metropolitan', 'FR', 'FRA', '{firstname} {lastname}\r\n{company}\r\n{address_1}\r\n{address_2}\r\n{postcode} {city}\r\n{country}', 1, 1),
(75, 'French Guiana', 'GF', 'GUF', '', 0, 1),
(76, 'French Polynesia', 'PF', 'PYF', '', 0, 1),
(77, 'French Southern Territories', 'TF', 'ATF', '', 0, 1),
(78, 'Gabon', 'GA', 'GAB', '', 0, 1),
(79, 'Gambia', 'GM', 'GMB', '', 0, 1),
(80, 'Georgia', 'GE', 'GEO', '', 0, 1),
(81, 'Germany', 'DE', 'DEU', '{company}\r\n{firstname} {lastname}\r\n{address_1}\r\n{address_2}\r\n{postcode} {city}\r\n{country}', 1, 1),
(82, 'Ghana', 'GH', 'GHA', '', 0, 1),
(83, 'Gibraltar', 'GI', 'GIB', '', 0, 1),
(84, 'Greece', 'GR', 'GRC', '', 0, 1),
(85, 'Greenland', 'GL', 'GRL', '', 0, 1),
(86, 'Grenada', 'GD', 'GRD', '', 0, 1),
(87, 'Guadeloupe', 'GP', 'GLP', '', 0, 1),
(88, 'Guam', 'GU', 'GUM', '', 0, 1),
(89, 'Guatemala', 'GT', 'GTM', '', 0, 1),
(90, 'Guinea', 'GN', 'GIN', '', 0, 1),
(91, 'Guinea-Bissau', 'GW', 'GNB', '', 0, 1),
(92, 'Guyana', 'GY', 'GUY', '', 0, 1),
(93, 'Haiti', 'HT', 'HTI', '', 0, 1),
(94, 'Heard and Mc Donald Islands', 'HM', 'HMD', '', 0, 1),
(95, 'Honduras', 'HN', 'HND', '', 0, 1),
(96, 'Hong Kong', 'HK', 'HKG', '', 0, 1),
(97, 'Hungary', 'HU', 'HUN', '', 0, 1),
(98, 'Iceland', 'IS', 'ISL', '', 0, 1),
(99, 'India', 'IN', 'IND', '', 0, 1),
(100, 'Indonesia', 'ID', 'IDN', '', 0, 1),
(101, 'Iran (Islamic Republic of)', 'IR', 'IRN', '', 0, 1),
(102, 'Iraq', 'IQ', 'IRQ', '', 0, 1),
(103, 'Ireland', 'IE', 'IRL', '', 0, 1),
(104, 'Israel', 'IL', 'ISR', '', 0, 1),
(105, 'Italy', 'IT', 'ITA', '', 0, 1),
(106, 'Jamaica', 'JM', 'JAM', '', 0, 1),
(107, 'Japan', 'JP', 'JPN', '', 0, 1),
(108, 'Jordan', 'JO', 'JOR', '', 0, 1),
(109, 'Kazakhstan', 'KZ', 'KAZ', '', 0, 1),
(110, 'Kenya', 'KE', 'KEN', '', 0, 1),
(111, 'Kiribati', 'KI', 'KIR', '', 0, 1),
(112, 'North Korea', 'KP', 'PRK', '', 0, 1),
(113, 'South Korea', 'KR', 'KOR', '', 0, 1),
(114, 'Kuwait', 'KW', 'KWT', '', 0, 1),
(115, 'Kyrgyzstan', 'KG', 'KGZ', '', 0, 1),
(116, 'Lao People\'s Democratic Republic', 'LA', 'LAO', '', 0, 1),
(117, 'Latvia', 'LV', 'LVA', '', 0, 1),
(118, 'Lebanon', 'LB', 'LBN', '', 0, 1),
(119, 'Lesotho', 'LS', 'LSO', '', 0, 1),
(120, 'Liberia', 'LR', 'LBR', '', 0, 1),
(121, 'Libyan Arab Jamahiriya', 'LY', 'LBY', '', 0, 1),
(122, 'Liechtenstein', 'LI', 'LIE', '', 0, 1),
(123, 'Lithuania', 'LT', 'LTU', '', 0, 1),
(124, 'Luxembourg', 'LU', 'LUX', '', 0, 1),
(125, 'Macau', 'MO', 'MAC', '', 0, 1),
(126, 'FYROM', 'MK', 'MKD', '', 0, 1),
(127, 'Madagascar', 'MG', 'MDG', '', 0, 1),
(128, 'Malawi', 'MW', 'MWI', '', 0, 1),
(129, 'Malaysia', 'MY', 'MYS', '', 0, 1),
(130, 'Maldives', 'MV', 'MDV', '', 0, 1),
(131, 'Mali', 'ML', 'MLI', '', 0, 1),
(132, 'Malta', 'MT', 'MLT', '', 0, 1),
(133, 'Marshall Islands', 'MH', 'MHL', '', 0, 1),
(134, 'Martinique', 'MQ', 'MTQ', '', 0, 1),
(135, 'Mauritania', 'MR', 'MRT', '', 0, 1),
(136, 'Mauritius', 'MU', 'MUS', '', 0, 1),
(137, 'Mayotte', 'YT', 'MYT', '', 0, 1),
(138, 'Mexico', 'MX', 'MEX', '', 0, 1),
(139, 'Micronesia, Federated States of', 'FM', 'FSM', '', 0, 1),
(140, 'Moldova, Republic of', 'MD', 'MDA', '', 0, 1),
(141, 'Monaco', 'MC', 'MCO', '', 0, 1),
(142, 'Mongolia', 'MN', 'MNG', '', 0, 1),
(143, 'Montserrat', 'MS', 'MSR', '', 0, 1),
(144, 'Morocco', 'MA', 'MAR', '', 0, 1),
(145, 'Mozambique', 'MZ', 'MOZ', '', 0, 1),
(146, 'Myanmar', 'MM', 'MMR', '', 0, 1),
(147, 'Namibia', 'NA', 'NAM', '', 0, 1),
(148, 'Nauru', 'NR', 'NRU', '', 0, 1),
(149, 'Nepal', 'NP', 'NPL', '', 0, 1),
(150, 'Netherlands', 'NL', 'NLD', '', 0, 1),
(151, 'Netherlands Antilles', 'AN', 'ANT', '', 0, 1),
(152, 'New Caledonia', 'NC', 'NCL', '', 0, 1),
(153, 'New Zealand', 'NZ', 'NZL', '', 0, 1),
(154, 'Nicaragua', 'NI', 'NIC', '', 0, 1),
(155, 'Niger', 'NE', 'NER', '', 0, 1),
(156, 'Nigeria', 'NG', 'NGA', '', 0, 1),
(157, 'Niue', 'NU', 'NIU', '', 0, 1),
(158, 'Norfolk Island', 'NF', 'NFK', '', 0, 1),
(159, 'Northern Mariana Islands', 'MP', 'MNP', '', 0, 1),
(160, 'Norway', 'NO', 'NOR', '', 0, 1),
(161, 'Oman', 'OM', 'OMN', '', 0, 1),
(162, 'Pakistan', 'PK', 'PAK', '', 0, 1),
(163, 'Palau', 'PW', 'PLW', '', 0, 1),
(164, 'Panama', 'PA', 'PAN', '', 0, 1),
(165, 'Papua New Guinea', 'PG', 'PNG', '', 0, 1),
(166, 'Paraguay', 'PY', 'PRY', '', 0, 1),
(167, 'Peru', 'PE', 'PER', '', 0, 1),
(168, 'Philippines', 'PH', 'PHL', '', 0, 1),
(169, 'Pitcairn', 'PN', 'PCN', '', 0, 1),
(170, 'Poland', 'PL', 'POL', '', 0, 1),
(171, 'Portugal', 'PT', 'PRT', '', 0, 1),
(172, 'Puerto Rico', 'PR', 'PRI', '', 0, 1),
(173, 'Qatar', 'QA', 'QAT', '', 0, 1),
(174, 'Reunion', 'RE', 'REU', '', 0, 1),
(175, 'Romania', 'RO', 'ROM', '', 0, 1),
(176, 'Russian Federation', 'RU', 'RUS', '', 0, 1),
(177, 'Rwanda', 'RW', 'RWA', '', 0, 1),
(178, 'Saint Kitts and Nevis', 'KN', 'KNA', '', 0, 1),
(179, 'Saint Lucia', 'LC', 'LCA', '', 0, 1),
(180, 'Saint Vincent and the Grenadines', 'VC', 'VCT', '', 0, 1),
(181, 'Samoa', 'WS', 'WSM', '', 0, 1),
(182, 'San Marino', 'SM', 'SMR', '', 0, 1),
(183, 'Sao Tome and Principe', 'ST', 'STP', '', 0, 1),
(184, 'Saudi Arabia', 'SA', 'SAU', '', 0, 1),
(185, 'Senegal', 'SN', 'SEN', '', 0, 1),
(186, 'Seychelles', 'SC', 'SYC', '', 0, 1),
(187, 'Sierra Leone', 'SL', 'SLE', '', 0, 1),
(188, 'Singapore', 'SG', 'SGP', '', 0, 1),
(189, 'Slovak Republic', 'SK', 'SVK', '{firstname} {lastname}\r\n{company}\r\n{address_1}\r\n{address_2}\r\n{city} {postcode}\r\n{zone}\r\n{country}', 0, 1),
(190, 'Slovenia', 'SI', 'SVN', '', 0, 1),
(191, 'Solomon Islands', 'SB', 'SLB', '', 0, 1),
(192, 'Somalia', 'SO', 'SOM', '', 0, 1),
(193, 'South Africa', 'ZA', 'ZAF', '', 0, 1),
(194, 'South Georgia &amp; South Sandwich Islands', 'GS', 'SGS', '', 0, 1),
(195, 'Spain', 'ES', 'ESP', '', 0, 1),
(196, 'Sri Lanka', 'LK', 'LKA', '', 0, 1),
(197, 'St. Helena', 'SH', 'SHN', '', 0, 1),
(198, 'St. Pierre and Miquelon', 'PM', 'SPM', '', 0, 1),
(199, 'Sudan', 'SD', 'SDN', '', 0, 1),
(200, 'Suriname', 'SR', 'SUR', '', 0, 1),
(201, 'Svalbard and Jan Mayen Islands', 'SJ', 'SJM', '', 0, 1),
(202, 'Swaziland', 'SZ', 'SWZ', '', 0, 1),
(203, 'Sweden', 'SE', 'SWE', '{company}\r\n{firstname} {lastname}\r\n{address_1}\r\n{address_2}\r\n{postcode} {city}\r\n{country}', 1, 1),
(204, 'Switzerland', 'CH', 'CHE', '', 0, 1),
(205, 'Syrian Arab Republic', 'SY', 'SYR', '', 0, 1),
(206, 'Taiwan', 'TW', 'TWN', '', 0, 1),
(207, 'Tajikistan', 'TJ', 'TJK', '', 0, 1),
(208, 'Tanzania, United Republic of', 'TZ', 'TZA', '', 0, 1),
(209, 'Thailand', 'TH', 'THA', '', 0, 1),
(210, 'Togo', 'TG', 'TGO', '', 0, 1),
(211, 'Tokelau', 'TK', 'TKL', '', 0, 1),
(212, 'Tonga', 'TO', 'TON', '', 0, 1),
(213, 'Trinidad and Tobago', 'TT', 'TTO', '', 0, 1),
(214, 'Tunisia', 'TN', 'TUN', '', 0, 1),
(215, 'Turkey', 'TR', 'TUR', '', 0, 1),
(216, 'Turkmenistan', 'TM', 'TKM', '', 0, 1),
(217, 'Turks and Caicos Islands', 'TC', 'TCA', '', 0, 1),
(218, 'Tuvalu', 'TV', 'TUV', '', 0, 1),
(219, 'Uganda', 'UG', 'UGA', '', 0, 1),
(220, 'Ukraine', 'UA', 'UKR', '', 0, 1),
(221, 'United Arab Emirates', 'AE', 'ARE', '', 0, 1),
(222, 'United Kingdom', 'GB', 'GBR', '', 1, 1),
(223, 'United States', 'US', 'USA', '{firstname} {lastname}\r\n{company}\r\n{address_1}\r\n{address_2}\r\n{city}, {zone} {postcode}\r\n{country}', 0, 1),
(224, 'United States Minor Outlying Islands', 'UM', 'UMI', '', 0, 1),
(225, 'Uruguay', 'UY', 'URY', '', 0, 1),
(226, 'Uzbekistan', 'UZ', 'UZB', '', 0, 1),
(227, 'Vanuatu', 'VU', 'VUT', '', 0, 1),
(228, 'Vatican City State (Holy See)', 'VA', 'VAT', '', 0, 1),
(229, 'Venezuela', 'VE', 'VEN', '', 0, 1),
(230, 'Viet Nam', 'VN', 'VNM', '', 0, 1),
(231, 'Virgin Islands (British)', 'VG', 'VGB', '', 0, 1),
(232, 'Virgin Islands (U.S.)', 'VI', 'VIR', '', 0, 1),
(233, 'Wallis and Futuna Islands', 'WF', 'WLF', '', 0, 1),
(234, 'Western Sahara', 'EH', 'ESH', '', 0, 1),
(235, 'Yemen', 'YE', 'YEM', '', 0, 1),
(237, 'Democratic Republic of Congo', 'CD', 'COD', '', 0, 1),
(238, 'Zambia', 'ZM', 'ZMB', '', 0, 1),
(239, 'Zimbabwe', 'ZW', 'ZWE', '', 0, 1),
(242, 'Montenegro', 'ME', 'MNE', '', 0, 1),
(243, 'Serbia', 'RS', 'SRB', '', 0, 1),
(244, 'Aaland Islands', 'AX', 'ALA', '', 0, 1),
(245, 'Bonaire, Sint Eustatius and Saba', 'BQ', 'BES', '', 0, 1),
(246, 'Curacao', 'CW', 'CUW', '', 0, 1),
(247, 'Palestinian Territory, Occupied', 'PS', 'PSE', '', 0, 1),
(248, 'South Sudan', 'SS', 'SSD', '', 0, 1),
(249, 'St. Barthelemy', 'BL', 'BLM', '', 0, 1),
(250, 'St. Martin (French part)', 'MF', 'MAF', '', 0, 1),
(251, 'Canary Islands', 'IC', 'ICA', '', 0, 1),
(252, 'Ascension Island (British)', 'AC', 'ASC', '', 0, 1),
(253, 'Kosovo, Republic of', 'XK', 'UNK', '', 0, 1),
(254, 'Isle of Man', 'IM', 'IMN', '', 0, 1),
(255, 'Tristan da Cunha', 'TA', 'SHN', '', 0, 1),
(256, 'Guernsey', 'GG', 'GGY', '', 0, 1),
(257, 'Jersey', 'JE', 'JEY', '', 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `oc_coupon`
--

CREATE TABLE `oc_coupon` (
  `coupon_id` int NOT NULL,
  `name` varchar(128) NOT NULL,
  `code` varchar(20) NOT NULL,
  `type` char(1) NOT NULL,
  `discount` decimal(15,4) NOT NULL,
  `logged` tinyint(1) NOT NULL,
  `shipping` tinyint(1) NOT NULL,
  `total` decimal(15,4) NOT NULL,
  `date_start` date NOT NULL DEFAULT '0000-00-00',
  `date_end` date NOT NULL DEFAULT '0000-00-00',
  `uses_total` int NOT NULL,
  `uses_customer` varchar(11) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `date_added` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_coupon`
--

INSERT INTO `oc_coupon` (`coupon_id`, `name`, `code`, `type`, `discount`, `logged`, `shipping`, `total`, `date_start`, `date_end`, `uses_total`, `uses_customer`, `status`, `date_added`) VALUES
(4, '-10% Discount', '2222', 'P', 10.0000, 0, 0, 0.0000, '2014-01-01', '2020-01-01', 10, '10', 0, '2009-01-27 13:55:03'),
(5, 'Free Shipping', '3333', 'P', 0.0000, 0, 1, 100.0000, '2014-01-01', '2014-02-01', 10, '10', 0, '2009-03-14 21:13:53'),
(6, '-10.00 Discount', '1111', 'F', 10.0000, 0, 0, 10.0000, '2014-01-01', '2020-01-01', 100000, '10000', 0, '2009-03-14 21:15:18');

-- --------------------------------------------------------

--
-- Table structure for table `oc_coupon_category`
--

CREATE TABLE `oc_coupon_category` (
  `coupon_id` int NOT NULL,
  `category_id` int NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `oc_coupon_history`
--

CREATE TABLE `oc_coupon_history` (
  `coupon_history_id` int NOT NULL,
  `coupon_id` int NOT NULL,
  `order_id` int NOT NULL,
  `customer_id` int NOT NULL,
  `amount` decimal(15,4) NOT NULL,
  `date_added` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `oc_coupon_product`
--

CREATE TABLE `oc_coupon_product` (
  `coupon_product_id` int NOT NULL,
  `coupon_id` int NOT NULL,
  `product_id` int NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `oc_currency`
--

CREATE TABLE `oc_currency` (
  `currency_id` int NOT NULL,
  `title` varchar(32) NOT NULL,
  `code` varchar(3) NOT NULL,
  `symbol_left` varchar(12) NOT NULL,
  `symbol_right` varchar(12) NOT NULL,
  `decimal_place` char(1) NOT NULL,
  `value` double(15,8) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `date_modified` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_currency`
--

INSERT INTO `oc_currency` (`currency_id`, `title`, `code`, `symbol_left`, `symbol_right`, `decimal_place`, `value`, `status`, `date_modified`) VALUES
(1, 'Pound Sterling', 'GBP', '£', '', '2', 0.61250001, 1, '2014-09-25 14:40:00'),
(2, 'US Dollar', 'USD', '$', '', '2', 1500.00000000, 1, '2025-04-18 03:49:27'),
(3, 'Euro', 'EUR', '', '€', '2', 0.78460002, 1, '2014-09-25 14:40:00'),
(4, 'Nigerian Naira', 'NGN', '₦', '', '2', 1.00000000, 1, '2025-04-19 23:11:47');

-- --------------------------------------------------------

--
-- Table structure for table `oc_customer`
--

CREATE TABLE `oc_customer` (
  `customer_id` int NOT NULL,
  `customer_group_id` int NOT NULL,
  `store_id` int NOT NULL DEFAULT '0',
  `language_id` int NOT NULL,
  `firstname` varchar(32) NOT NULL,
  `lastname` varchar(32) NOT NULL,
  `email` varchar(96) NOT NULL,
  `telephone` varchar(32) NOT NULL,
  `fax` varchar(32) NOT NULL,
  `password` varchar(40) NOT NULL,
  `salt` varchar(9) NOT NULL,
  `cart` text,
  `wishlist` text,
  `newsletter` tinyint(1) NOT NULL DEFAULT '0',
  `address_id` int NOT NULL DEFAULT '0',
  `custom_field` text NOT NULL,
  `ip` varchar(40) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `safe` tinyint(1) NOT NULL,
  `token` text NOT NULL,
  `code` varchar(40) NOT NULL,
  `date_added` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_customer`
--

INSERT INTO `oc_customer` (`customer_id`, `customer_group_id`, `store_id`, `language_id`, `firstname`, `lastname`, `email`, `telephone`, `fax`, `password`, `salt`, `cart`, `wishlist`, `newsletter`, `address_id`, `custom_field`, `ip`, `status`, `safe`, `token`, `code`, `date_added`) VALUES
(1, 1, 0, 1, 'admin', 'admin', 'admin@localhost.com', '1234567891', '', 'dde174b4a4e99de1738b7c1e92aec6fd815a65fa', 'bMga217VL', NULL, NULL, 0, 1, '', '192.168.0.152', 1, 0, '', '', '2018-03-01 05:27:47'),
(4, 1, 0, 1, 'admin', 'admin', 'demo@codezeel.com', 'demo@codezeel.com', '', '3eaee048f34666890ecdebed6ecf454657ae9875', 'Ef0CaT0Hl', NULL, NULL, 0, 0, '', '116.73.194.54', 1, 0, '', '', '2019-03-15 11:11:58'),
(11, 1, 0, 1, 'Sola', 'Salami', 'sola@yopmail.com', '+2348025046135', '', 'dbe7bfcbd99cab63e4d2d9b0237afa7622ed35a0', 'NoQMpxXP8', NULL, NULL, 0, 6, '', '174.2.2.79', 1, 0, '', '', '2025-04-17 19:15:32'),
(12, 1, 0, 1, 'Sola', 'S', 'solas@yopmail.com', '08025046135', '', '2f9e505b77340fcb0107ecaaeb0e5adf838e2e71', '866CYQN1d', NULL, NULL, 0, 7, '', '102.44.195.237', 1, 0, '', '', '2025-05-01 18:37:13');

-- --------------------------------------------------------

--
-- Table structure for table `oc_customer_activity`
--

CREATE TABLE `oc_customer_activity` (
  `customer_activity_id` int NOT NULL,
  `customer_id` int NOT NULL,
  `key` varchar(64) NOT NULL,
  `data` text NOT NULL,
  `ip` varchar(40) NOT NULL,
  `date_added` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `oc_customer_affiliate`
--

CREATE TABLE `oc_customer_affiliate` (
  `customer_id` int NOT NULL,
  `company` varchar(40) NOT NULL,
  `website` varchar(255) NOT NULL,
  `tracking` varchar(64) NOT NULL,
  `commission` decimal(4,2) NOT NULL DEFAULT '0.00',
  `tax` varchar(64) NOT NULL,
  `payment` varchar(6) NOT NULL,
  `cheque` varchar(100) NOT NULL,
  `paypal` varchar(64) NOT NULL,
  `bank_name` varchar(64) NOT NULL,
  `bank_branch_number` varchar(64) NOT NULL,
  `bank_swift_code` varchar(64) NOT NULL,
  `bank_account_name` varchar(64) NOT NULL,
  `bank_account_number` varchar(64) NOT NULL,
  `custom_field` text NOT NULL,
  `status` tinyint(1) NOT NULL,
  `date_added` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `oc_customer_approval`
--

CREATE TABLE `oc_customer_approval` (
  `customer_approval_id` int NOT NULL,
  `customer_id` int NOT NULL,
  `type` varchar(9) NOT NULL,
  `date_added` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `oc_customer_group`
--

CREATE TABLE `oc_customer_group` (
  `customer_group_id` int NOT NULL,
  `approval` int NOT NULL,
  `sort_order` int NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_customer_group`
--

INSERT INTO `oc_customer_group` (`customer_group_id`, `approval`, `sort_order`) VALUES
(1, 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `oc_customer_group_description`
--

CREATE TABLE `oc_customer_group_description` (
  `customer_group_id` int NOT NULL,
  `language_id` int NOT NULL,
  `name` varchar(32) NOT NULL,
  `description` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_customer_group_description`
--

INSERT INTO `oc_customer_group_description` (`customer_group_id`, `language_id`, `name`, `description`) VALUES
(1, 1, 'Default', 'test'),
(1, 2, 'Default', 'test');

-- --------------------------------------------------------

--
-- Table structure for table `oc_customer_history`
--

CREATE TABLE `oc_customer_history` (
  `customer_history_id` int NOT NULL,
  `customer_id` int NOT NULL,
  `comment` text NOT NULL,
  `date_added` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `oc_customer_ip`
--

CREATE TABLE `oc_customer_ip` (
  `customer_ip_id` int NOT NULL,
  `customer_id` int NOT NULL,
  `ip` varchar(40) NOT NULL,
  `date_added` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_customer_ip`
--

INSERT INTO `oc_customer_ip` (`customer_ip_id`, `customer_id`, `ip`, `date_added`) VALUES
(1, 1, '219.91.237.34', '2018-03-01 05:27:47'),
(2, 1, '123.201.227.244', '2018-03-15 08:34:42'),
(7, 4, '116.73.194.54', '2019-03-15 11:11:59'),
(8, 1, '192.168.0.152', '2019-08-07 13:46:06'),
(18, 11, '174.2.2.79', '2025-04-17 19:15:32'),
(20, 12, '102.44.195.237', '2025-05-01 18:37:14');

-- --------------------------------------------------------

--
-- Table structure for table `oc_customer_login`
--

CREATE TABLE `oc_customer_login` (
  `customer_login_id` int NOT NULL,
  `email` varchar(96) NOT NULL,
  `ip` varchar(40) NOT NULL,
  `total` int NOT NULL,
  `date_added` datetime NOT NULL,
  `date_modified` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_customer_login`
--

INSERT INTO `oc_customer_login` (`customer_login_id`, `email`, `ip`, `total`, `date_added`, `date_modified`) VALUES
(7, 'admin@localhost.com', '192.168.0.158', 5, '2021-01-19 06:40:33', '2021-01-21 08:51:26'),
(9, '', '192.168.0.158', 17, '2021-01-21 08:48:11', '2025-11-17 07:28:08'),
(10, 'admin@localhost.com', '192.168.0.151', 1, '2021-01-23 10:11:46', '2021-01-23 10:11:46'),
(11, 'admin@localhost.com', '116.72.3.223', 1, '2021-01-25 08:36:43', '2021-01-25 08:36:43'),
(12, '', '192.168.0.157', 1, '2021-02-02 05:11:04', '2021-02-02 05:11:04'),
(13, 'admin@localhost.co', '192.168.0.157', 1, '2021-02-02 05:11:09', '2021-02-02 05:11:09'),
(16, 'amin', '160.19.36.25', 1, '2025-04-06 20:24:45', '2025-04-06 20:24:45'),
(15, 'admin@localhost.com', '192.168.0.157', 1, '2021-03-03 05:43:49', '2021-03-03 05:43:49'),
(26, 'editor', '45.128.133.231', 6, '2026-03-16 17:24:43', '2026-03-16 19:25:48'),
(21, 'the wecis', '102.88.106.88', 1, '2025-07-31 09:06:24', '2025-07-31 09:06:24'),
(24, 'wecisclothing', '205.147.16.206', 6, '2026-03-16 14:16:36', '2026-03-16 15:29:36'),
(25, 'administrator', '45.128.133.231', 17, '2026-03-16 15:14:07', '2026-07-26 05:35:38'),
(27, 'manager', '149.50.216.195', 5, '2026-03-16 19:27:02', '2026-03-16 19:47:16'),
(30, 'qphoria', '70.36.127.31', 4, '2026-04-10 12:11:44', '2026-05-01 23:57:54'),
(29, 'opencart_system', '162.222.203.72', 1, '2026-04-06 05:08:02', '2026-04-06 05:08:02'),
(31, 'colbey', '77.83.106.123', 1, '2026-05-03 12:03:32', '2026-05-03 12:03:32'),
(33, 'opencartspecialist', '74.81.37.252', 1, '2026-05-10 08:48:41', '2026-05-10 08:48:41'),
(36, 'test', '104.238.31.92', 8, '2026-07-24 18:33:23', '2026-07-25 10:03:07'),
(37, 'admin123', '64.137.54.87', 2, '2026-08-25 14:34:07', '2026-08-26 00:28:37'),
(38, 'admin1', '64.137.54.86', 1, '2026-08-27 03:00:44', '2026-08-27 03:00:44'),
(39, 'password', '64.137.54.86', 1, '2026-08-27 17:00:59', '2026-08-27 17:00:59');

-- --------------------------------------------------------

--
-- Table structure for table `oc_customer_online`
--

CREATE TABLE `oc_customer_online` (
  `ip` varchar(40) NOT NULL,
  `customer_id` int NOT NULL,
  `url` text NOT NULL,
  `referer` text NOT NULL,
  `date_added` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `oc_customer_reward`
--

CREATE TABLE `oc_customer_reward` (
  `customer_reward_id` int NOT NULL,
  `customer_id` int NOT NULL DEFAULT '0',
  `order_id` int NOT NULL DEFAULT '0',
  `description` text NOT NULL,
  `points` int NOT NULL DEFAULT '0',
  `date_added` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `oc_customer_search`
--

CREATE TABLE `oc_customer_search` (
  `customer_search_id` int NOT NULL,
  `store_id` int NOT NULL,
  `language_id` int NOT NULL,
  `customer_id` int NOT NULL,
  `keyword` varchar(255) NOT NULL,
  `category_id` int DEFAULT NULL,
  `sub_category` tinyint(1) NOT NULL,
  `description` tinyint(1) NOT NULL,
  `products` int NOT NULL,
  `ip` varchar(40) NOT NULL,
  `date_added` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `oc_customer_transaction`
--

CREATE TABLE `oc_customer_transaction` (
  `customer_transaction_id` int NOT NULL,
  `customer_id` int NOT NULL,
  `order_id` int NOT NULL,
  `description` text NOT NULL,
  `amount` decimal(15,4) NOT NULL,
  `date_added` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `oc_customer_wishlist`
--

CREATE TABLE `oc_customer_wishlist` (
  `customer_id` int NOT NULL,
  `product_id` int NOT NULL,
  `date_added` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_customer_wishlist`
--

INSERT INTO `oc_customer_wishlist` (`customer_id`, `product_id`, `date_added`) VALUES
(3, 47, '2021-01-25 09:03:04'),
(3, 43, '2021-01-22 12:21:34'),
(1, 45, '2019-08-07 13:53:31'),
(1, 47, '2019-08-07 13:53:19'),
(1, 48, '2019-10-03 12:36:59'),
(5, 43, '2021-01-01 11:33:59'),
(6, 31, '2021-01-19 12:30:02'),
(6, 32, '2021-01-19 12:30:06'),
(3, 40, '2021-01-22 12:21:34'),
(3, 48, '2021-01-25 08:37:54'),
(7, 47, '2021-02-02 10:42:14'),
(7, 43, '2021-02-02 10:42:16');

-- --------------------------------------------------------

--
-- Table structure for table `oc_custom_field`
--

CREATE TABLE `oc_custom_field` (
  `custom_field_id` int NOT NULL,
  `type` varchar(32) NOT NULL,
  `value` text NOT NULL,
  `validation` varchar(255) NOT NULL,
  `location` varchar(10) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `sort_order` int NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `oc_custom_field_customer_group`
--

CREATE TABLE `oc_custom_field_customer_group` (
  `custom_field_id` int NOT NULL,
  `customer_group_id` int NOT NULL,
  `required` tinyint(1) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `oc_custom_field_description`
--

CREATE TABLE `oc_custom_field_description` (
  `custom_field_id` int NOT NULL,
  `language_id` int NOT NULL,
  `name` varchar(128) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `oc_custom_field_value`
--

CREATE TABLE `oc_custom_field_value` (
  `custom_field_value_id` int NOT NULL,
  `custom_field_id` int NOT NULL,
  `sort_order` int NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `oc_custom_field_value_description`
--

CREATE TABLE `oc_custom_field_value_description` (
  `custom_field_value_id` int NOT NULL,
  `language_id` int NOT NULL,
  `custom_field_id` int NOT NULL,
  `name` varchar(128) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `oc_download`
--

CREATE TABLE `oc_download` (
  `download_id` int NOT NULL,
  `filename` varchar(160) NOT NULL,
  `mask` varchar(128) NOT NULL,
  `date_added` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `oc_download_description`
--

CREATE TABLE `oc_download_description` (
  `download_id` int NOT NULL,
  `language_id` int NOT NULL,
  `name` varchar(64) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `oc_event`
--

CREATE TABLE `oc_event` (
  `event_id` int NOT NULL,
  `code` varchar(64) NOT NULL,
  `trigger` text NOT NULL,
  `action` text NOT NULL,
  `status` tinyint(1) NOT NULL,
  `sort_order` int NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_event`
--

INSERT INTO `oc_event` (`event_id`, `code`, `trigger`, `action`, `status`, `sort_order`) VALUES
(1, 'activity_customer_add', 'catalog/model/account/customer/addCustomer/after', 'event/activity/addCustomer', 1, 0),
(2, 'activity_customer_edit', 'catalog/model/account/customer/editCustomer/after', 'event/activity/editCustomer', 1, 0),
(3, 'activity_customer_password', 'catalog/model/account/customer/editPassword/after', 'event/activity/editPassword', 1, 0),
(4, 'activity_customer_forgotten', 'catalog/model/account/customer/editCode/after', 'event/activity/forgotten', 1, 0),
(5, 'activity_transaction', 'catalog/model/account/customer/addTransaction/after', 'event/activity/addTransaction', 1, 0),
(6, 'activity_customer_login', 'catalog/model/account/customer/deleteLoginAttempts/after', 'event/activity/login', 1, 0),
(7, 'activity_address_add', 'catalog/model/account/address/addAddress/after', 'event/activity/addAddress', 1, 0),
(8, 'activity_address_edit', 'catalog/model/account/address/editAddress/after', 'event/activity/editAddress', 1, 0),
(9, 'activity_address_delete', 'catalog/model/account/address/deleteAddress/after', 'event/activity/deleteAddress', 1, 0),
(10, 'activity_affiliate_add', 'catalog/model/account/customer/addAffiliate/after', 'event/activity/addAffiliate', 1, 0),
(11, 'activity_affiliate_edit', 'catalog/model/account/customer/editAffiliate/after', 'event/activity/editAffiliate', 1, 0),
(12, 'activity_order_add', 'catalog/model/checkout/order/addOrderHistory/before', 'event/activity/addOrderHistory', 1, 0),
(13, 'activity_return_add', 'catalog/model/account/return/addReturn/after', 'event/activity/addReturn', 1, 0),
(14, 'mail_transaction', 'catalog/model/account/customer/addTransaction/after', 'mail/transaction', 1, 0),
(15, 'mail_forgotten', 'catalog/model/account/customer/editCode/after', 'mail/forgotten', 1, 0),
(16, 'mail_customer_add', 'catalog/model/account/customer/addCustomer/after', 'mail/register', 1, 0),
(17, 'mail_customer_alert', 'catalog/model/account/customer/addCustomer/after', 'mail/register/alert', 1, 0),
(18, 'mail_affiliate_add', 'catalog/model/account/customer/addAffiliate/after', 'mail/affiliate', 1, 0),
(19, 'mail_affiliate_alert', 'catalog/model/account/customer/addAffiliate/after', 'mail/affiliate/alert', 1, 0),
(20, 'mail_voucher', 'catalog/model/checkout/order/addOrderHistory/after', 'extension/total/voucher/send', 1, 0),
(21, 'mail_order_add', 'catalog/model/checkout/order/addOrderHistory/before', 'mail/order', 1, 0),
(22, 'mail_order_alert', 'catalog/model/checkout/order/addOrderHistory/before', 'mail/order/alert', 1, 0),
(23, 'statistics_review_add', 'catalog/model/catalog/review/addReview/after', 'event/statistics/addReview', 1, 0),
(24, 'statistics_return_add', 'catalog/model/account/return/addReturn/after', 'event/statistics/addReturn', 1, 0),
(25, 'statistics_order_history', 'catalog/model/checkout/order/addOrderHistory/after', 'event/statistics/addOrderHistory', 1, 0),
(26, 'admin_mail_affiliate_approve', 'admin/model/customer/customer_approval/approveAffiliate/after', 'mail/affiliate/approve', 1, 0),
(27, 'admin_mail_affiliate_deny', 'admin/model/customer/customer_approval/denyAffiliate/after', 'mail/affiliate/deny', 1, 0),
(28, 'admin_mail_customer_approve', 'admin/model/customer/customer_approval/approveCustomer/after', 'mail/customer/approve', 1, 0),
(29, 'admin_mail_customer_deny', 'admin/model/customer/customer_approval/denyCustomer/after', 'mail/customer/deny', 1, 0),
(30, 'admin_mail_reward', 'admin/model/customer/customer/addReward/after', 'mail/reward', 1, 0),
(31, 'admin_mail_transaction', 'admin/model/customer/customer/addTransaction/after', 'mail/transaction', 1, 0),
(32, 'admin_mail_return', 'admin/model/sale/return/addReturn/after', 'mail/return', 1, 0),
(33, 'admin_mail_forgotten', 'admin/model/user/user/editCode/after', 'mail/forgotten', 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `oc_extension`
--

CREATE TABLE `oc_extension` (
  `extension_id` int NOT NULL,
  `type` varchar(32) NOT NULL,
  `code` varchar(32) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_extension`
--

INSERT INTO `oc_extension` (`extension_id`, `type`, `code`) VALUES
(1, 'payment', 'cod'),
(2, 'total', 'shipping'),
(3, 'total', 'sub_total'),
(4, 'total', 'tax'),
(5, 'total', 'total'),
(6, 'module', 'banner'),
(7, 'module', 'carousel'),
(8, 'total', 'credit'),
(9, 'shipping', 'flat'),
(10, 'total', 'handling'),
(11, 'total', 'low_order_fee'),
(12, 'total', 'coupon'),
(13, 'module', 'category'),
(14, 'module', 'account'),
(15, 'total', 'reward'),
(16, 'total', 'voucher'),
(19, 'module', 'slideshow'),
(20, 'theme', 'default'),
(21, 'dashboard', 'activity'),
(22, 'dashboard', 'sale'),
(23, 'dashboard', 'recent'),
(24, 'dashboard', 'order'),
(25, 'dashboard', 'online'),
(26, 'dashboard', 'map'),
(27, 'dashboard', 'customer'),
(28, 'dashboard', 'chart'),
(29, 'report', 'sale_coupon'),
(31, 'report', 'customer_search'),
(32, 'report', 'customer_transaction'),
(33, 'report', 'product_purchased'),
(34, 'report', 'product_viewed'),
(35, 'report', 'sale_return'),
(36, 'report', 'sale_order'),
(37, 'report', 'sale_shipping'),
(38, 'report', 'sale_tax'),
(39, 'report', 'customer_activity'),
(40, 'report', 'customer_order'),
(41, 'report', 'customer_reward'),
(42, 'module', 'html'),
(43, 'module', 'filter'),
(44, 'module', 'special'),
(45, 'module', 'information'),
(46, 'module', 'newsletters'),
(48, 'module', 'blogger'),
(63, 'payment', 'paystack'),
(57, 'analytics', 'google'),
(60, 'captcha', 'basic'),
(61, 'module', 'codezeeltabs');

-- --------------------------------------------------------

--
-- Table structure for table `oc_extension_install`
--

CREATE TABLE `oc_extension_install` (
  `extension_install_id` int NOT NULL,
  `extension_download_id` int NOT NULL,
  `filename` varchar(255) NOT NULL,
  `date_added` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `oc_extension_path`
--

CREATE TABLE `oc_extension_path` (
  `extension_path_id` int NOT NULL,
  `extension_install_id` int NOT NULL,
  `path` varchar(255) NOT NULL,
  `date_added` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `oc_filter`
--

CREATE TABLE `oc_filter` (
  `filter_id` int NOT NULL,
  `filter_group_id` int NOT NULL,
  `sort_order` int NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_filter`
--

INSERT INTO `oc_filter` (`filter_id`, `filter_group_id`, `sort_order`) VALUES
(4, 1, 0),
(3, 1, 0),
(2, 1, 0),
(1, 1, 1),
(7, 2, 3),
(6, 2, 2),
(5, 2, 1),
(9, 3, 1),
(10, 3, 2),
(11, 3, 3);

-- --------------------------------------------------------

--
-- Table structure for table `oc_filter_description`
--

CREATE TABLE `oc_filter_description` (
  `filter_id` int NOT NULL,
  `language_id` int NOT NULL,
  `filter_group_id` int NOT NULL,
  `name` varchar(64) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_filter_description`
--

INSERT INTO `oc_filter_description` (`filter_id`, `language_id`, `filter_group_id`, `name`) VALUES
(3, 1, 1, 'Yellow'),
(2, 1, 1, 'Red'),
(1, 1, 1, 'Blue'),
(6, 1, 2, 'Medium'),
(5, 1, 2, 'Small'),
(9, 1, 3, '5'),
(10, 1, 3, '10'),
(11, 1, 3, '15'),
(7, 1, 2, 'Large'),
(4, 1, 1, 'Green'),
(3, 2, 1, 'Yellow'),
(2, 2, 1, 'Red'),
(1, 2, 1, 'Blue'),
(6, 2, 2, 'Medium'),
(5, 2, 2, 'Small'),
(9, 2, 3, '5'),
(10, 2, 3, '10'),
(11, 2, 3, '15'),
(7, 2, 2, 'Large'),
(4, 2, 1, 'Green');

-- --------------------------------------------------------

--
-- Table structure for table `oc_filter_group`
--

CREATE TABLE `oc_filter_group` (
  `filter_group_id` int NOT NULL,
  `sort_order` int NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_filter_group`
--

INSERT INTO `oc_filter_group` (`filter_group_id`, `sort_order`) VALUES
(1, 1),
(2, 2),
(3, 3);

-- --------------------------------------------------------

--
-- Table structure for table `oc_filter_group_description`
--

CREATE TABLE `oc_filter_group_description` (
  `filter_group_id` int NOT NULL,
  `language_id` int NOT NULL,
  `name` varchar(64) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_filter_group_description`
--

INSERT INTO `oc_filter_group_description` (`filter_group_id`, `language_id`, `name`) VALUES
(1, 1, 'Color'),
(2, 1, 'Size'),
(3, 1, 'Weight'),
(1, 2, 'Color'),
(2, 2, 'Size'),
(3, 2, 'Weight');

-- --------------------------------------------------------

--
-- Table structure for table `oc_geo_zone`
--

CREATE TABLE `oc_geo_zone` (
  `geo_zone_id` int NOT NULL,
  `name` varchar(32) NOT NULL,
  `description` varchar(255) NOT NULL,
  `date_added` datetime NOT NULL,
  `date_modified` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_geo_zone`
--

INSERT INTO `oc_geo_zone` (`geo_zone_id`, `name`, `description`, `date_added`, `date_modified`) VALUES
(3, 'UK VAT Zone', 'UK VAT', '2009-01-06 23:26:25', '2025-04-18 05:01:25'),
(5, 'NGN VAT ZONE', 'NGN VAT ZONE', '2025-04-18 05:00:30', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `oc_information`
--

CREATE TABLE `oc_information` (
  `information_id` int NOT NULL,
  `bottom` int NOT NULL DEFAULT '0',
  `sort_order` int NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_information`
--

INSERT INTO `oc_information` (`information_id`, `bottom`, `sort_order`, `status`) VALUES
(3, 1, 3, 1),
(4, 1, 1, 1),
(5, 1, 4, 1),
(6, 1, 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `oc_information_description`
--

CREATE TABLE `oc_information_description` (
  `information_id` int NOT NULL,
  `language_id` int NOT NULL,
  `title` varchar(64) NOT NULL,
  `description` mediumtext NOT NULL,
  `meta_title` varchar(255) NOT NULL,
  `meta_description` varchar(255) NOT NULL,
  `meta_keyword` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_information_description`
--

INSERT INTO `oc_information_description` (`information_id`, `language_id`, `title`, `description`, `meta_title`, `meta_description`, `meta_keyword`) VALUES
(4, 2, 'About Us', '&lt;p data-start=&quot;120&quot; data-end=&quot;446&quot; class=&quot;&quot;&gt;At &lt;strong data-start=&quot;123&quot; data-end=&quot;142&quot;&gt;Wecis Clothings&lt;/strong&gt;, we are redefining fashion by blending the richness of African heritage with contemporary design. Our brand offers &lt;strong data-start=&quot;258&quot; data-end=&quot;310&quot;&gt;premium African-inspired menswear and womenswear&lt;/strong&gt;\r\n tailored for the modern global citizen. Each piece tells a story—rooted\r\n in culture, elevated with elegance, and crafted with precision.&lt;/p&gt;\r\n&lt;p data-start=&quot;448&quot; data-end=&quot;649&quot; class=&quot;&quot;&gt;Our commitment is simple: &lt;strong data-start=&quot;474&quot; data-end=&quot;500&quot;&gt;Style without borders.&lt;/strong&gt; With &lt;strong data-start=&quot;506&quot; data-end=&quot;528&quot;&gt;worldwide delivery&lt;/strong&gt;, we ensure that wherever you are—Lagos, London, New York, or Tokyo—you can wear your identity with pride and confidence.&lt;/p&gt;\r\n&lt;p data-start=&quot;651&quot; data-end=&quot;793&quot; class=&quot;&quot;&gt;Wecis Clothings is more than fashion. It’s &lt;strong data-start=&quot;694&quot; data-end=&quot;717&quot;&gt;a cultural movement&lt;/strong&gt;, a statement of excellence, and a celebration of Africa on the world stage.&lt;/p&gt;\r\n&lt;p data-start=&quot;795&quot; data-end=&quot;847&quot; class=&quot;&quot;&gt;Join us in making African fashion a global language.&lt;/p&gt;&lt;br&gt;', 'About Us', 'aboutus', 'aboutus'),
(4, 1, 'About Us', '&lt;p data-start=&quot;120&quot; data-end=&quot;446&quot; class=&quot;&quot;&gt;At &lt;strong data-start=&quot;123&quot; data-end=&quot;142&quot;&gt;Wecis Clothings&lt;/strong&gt;, we are redefining fashion by blending the richness of African heritage with contemporary design. Our brand offers &lt;strong data-start=&quot;258&quot; data-end=&quot;310&quot;&gt;premium African-inspired menswear and womenswear&lt;/strong&gt; tailored for the modern global citizen. Each piece tells a story—rooted in culture, elevated with elegance, and crafted with precision.&lt;/p&gt;\r\n&lt;p data-start=&quot;448&quot; data-end=&quot;649&quot; class=&quot;&quot;&gt;Our commitment is simple: &lt;strong data-start=&quot;474&quot; data-end=&quot;500&quot;&gt;Style without borders.&lt;/strong&gt; With &lt;strong data-start=&quot;506&quot; data-end=&quot;528&quot;&gt;worldwide delivery&lt;/strong&gt;, we ensure that wherever you are—Lagos, London, New York, or Tokyo—you can wear your identity with pride and confidence.&lt;/p&gt;\r\n&lt;p data-start=&quot;651&quot; data-end=&quot;793&quot; class=&quot;&quot;&gt;Wecis Clothings is more than fashion. It’s &lt;strong data-start=&quot;694&quot; data-end=&quot;717&quot;&gt;a cultural movement&lt;/strong&gt;, a statement of excellence, and a celebration of Africa on the world stage.&lt;/p&gt;\r\n&lt;p data-start=&quot;795&quot; data-end=&quot;847&quot; class=&quot;&quot;&gt;Join us in making African fashion a global language.&lt;/p&gt;&lt;br&gt;', 'About Us', '', ''),
(6, 1, 'Delivery Information', '&lt;span style=&quot;color: rgb(128, 128, 128); font-family: Roboto, sans-serif; font-size: 15px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: 0.9px; orphans: 2; text-align: center; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;&quot;&gt;We ship worldwide and ensure you get the services your deserve to your doorstep&lt;/span&gt;', 'Delivery Information', '', ''),
(6, 2, 'Delivery Information', '&lt;div class=&quot;aboutus&quot;&gt;\r\n&lt;h3&gt;100% Fully Responsive&lt;/h3&gt;\r\n&lt;div class=&quot;image1&quot;&gt; &lt;/div&gt;\r\n&lt;div class=&quot;about-content&quot;&gt;These days Mobile is the handiest device to access internet. Hence your website must be mobile accessible as compatibility.&lt;/div&gt;\r\n&lt;/div&gt;\r\n&lt;div class=&quot;aboutus&quot;&gt;\r\n&lt;h3&gt;Cross Browser Compatibility&lt;/h3&gt;\r\n&lt;div class=&quot;image2&quot;&gt; &lt;/div&gt;\r\n&lt;div class=&quot;about-content&quot;&gt;Cross-browser means web application works with all versions of all browsers. To claim cross-browser compatibility, the website is nowadays expected to support browsers.&lt;/div&gt;\r\n&lt;/div&gt;\r\n&lt;div class=&quot;aboutus&quot;&gt;\r\n&lt;h3&gt;Dedicated support team&lt;/h3&gt;\r\n&lt;div class=&quot;image3&quot;&gt; &lt;/div&gt;\r\n&lt;div class=&quot;about-content&quot;&gt;Our support team guarantees to respond you within 24 working hours. We will process tickets and respond you to in the queue order.&lt;/div&gt;\r\n&lt;/div&gt;\r\n&lt;div class=&quot;aboutus&quot;&gt;\r\n&lt;h3&gt;High Quality Products&lt;/h3&gt;\r\n&lt;div class=&quot;image4&quot;&gt; &lt;/div&gt;\r\n&lt;div class=&quot;about-content&quot;&gt;Website design can do wonders for your traffic. Giving a fresh look to your website makes your visitors think that you care for them and are ready to change with time.&lt;/div&gt;\r\n&lt;/div&gt;', 'Delivery Information', '', ''),
(3, 2, 'Privacy Policy', '&lt;p data-start=&quot;310&quot; data-end=&quot;583&quot; class=&quot;&quot;&gt;At &lt;strong data-start=&quot;313&quot; data-end=&quot;332&quot;&gt;Wecis Clothings&lt;/strong&gt;,\r\n we value your privacy and are committed to protecting your personal \r\ndata. This Privacy Policy outlines how we collect, use, share, and \r\nsafeguard your information when you visit our website, make purchases, \r\nor interact with us through other channels.&lt;/p&gt;\r\n&lt;hr data-start=&quot;585&quot; data-end=&quot;588&quot; class=&quot;&quot;&gt;\r\n&lt;h2 data-start=&quot;590&quot; data-end=&quot;622&quot; class=&quot;&quot;&gt;1. &lt;strong data-start=&quot;596&quot; data-end=&quot;622&quot;&gt;Information We Collect&lt;/strong&gt;&lt;/h2&gt;\r\n&lt;p data-start=&quot;624&quot; data-end=&quot;679&quot; class=&quot;&quot;&gt;We collect the following types of personal information:&lt;/p&gt;\r\n&lt;ul data-start=&quot;681&quot; data-end=&quot;1154&quot;&gt;&lt;li data-start=&quot;681&quot; data-end=&quot;730&quot; class=&quot;&quot;&gt;\r\n&lt;p data-start=&quot;683&quot; data-end=&quot;730&quot; class=&quot;&quot;&gt;&lt;strong data-start=&quot;683&quot; data-end=&quot;700&quot;&gt;Identity Data&lt;/strong&gt;: Name, gender, date of birth.&lt;/p&gt;\r\n&lt;/li&gt;&lt;li data-start=&quot;731&quot; data-end=&quot;809&quot; class=&quot;&quot;&gt;\r\n&lt;p data-start=&quot;733&quot; data-end=&quot;809&quot; class=&quot;&quot;&gt;&lt;strong data-start=&quot;733&quot; data-end=&quot;749&quot;&gt;Contact Data&lt;/strong&gt;: Email address, phone number, billing and shipping address.&lt;/p&gt;\r\n&lt;/li&gt;&lt;li data-start=&quot;810&quot; data-end=&quot;951&quot; class=&quot;&quot;&gt;\r\n&lt;p data-start=&quot;812&quot; data-end=&quot;951&quot; class=&quot;&quot;&gt;&lt;strong data-start=&quot;812&quot; data-end=&quot;828&quot;&gt;Payment Data&lt;/strong&gt;: Credit/debit card details and payment transaction history (processed securely via trusted third-party payment providers).&lt;/p&gt;\r\n&lt;/li&gt;&lt;li data-start=&quot;952&quot; data-end=&quot;1066&quot; class=&quot;&quot;&gt;\r\n&lt;p data-start=&quot;954&quot; data-end=&quot;1066&quot; class=&quot;&quot;&gt;&lt;strong data-start=&quot;954&quot; data-end=&quot;972&quot;&gt;Technical Data&lt;/strong&gt;: IP address, browser type, operating system, device identifiers, and website usage analytics.&lt;/p&gt;\r\n&lt;/li&gt;&lt;li data-start=&quot;1067&quot; data-end=&quot;1154&quot; class=&quot;&quot;&gt;\r\n&lt;p data-start=&quot;1069&quot; data-end=&quot;1154&quot; class=&quot;&quot;&gt;&lt;strong data-start=&quot;1069&quot; data-end=&quot;1087&quot;&gt;Marketing Data&lt;/strong&gt;: Preferences for receiving communications and promotional content.&lt;/p&gt;\r\n&lt;/li&gt;&lt;/ul&gt;\r\n&lt;hr data-start=&quot;1156&quot; data-end=&quot;1159&quot; class=&quot;&quot;&gt;\r\n&lt;h2 data-start=&quot;1161&quot; data-end=&quot;1198&quot; class=&quot;&quot;&gt;2. &lt;strong data-start=&quot;1167&quot; data-end=&quot;1198&quot;&gt;How We Use Your Information&lt;/strong&gt;&lt;/h2&gt;\r\n&lt;p data-start=&quot;1200&quot; data-end=&quot;1260&quot; class=&quot;&quot;&gt;We use your personal information for the following purposes:&lt;/p&gt;\r\n&lt;ul data-start=&quot;1262&quot; data-end=&quot;1590&quot;&gt;&lt;li data-start=&quot;1262&quot; data-end=&quot;1299&quot; class=&quot;&quot;&gt;\r\n&lt;p data-start=&quot;1264&quot; data-end=&quot;1299&quot; class=&quot;&quot;&gt;To process and deliver your orders.&lt;/p&gt;\r\n&lt;/li&gt;&lt;li data-start=&quot;1300&quot; data-end=&quot;1361&quot; class=&quot;&quot;&gt;\r\n&lt;p data-start=&quot;1302&quot; data-end=&quot;1361&quot; class=&quot;&quot;&gt;To communicate with you about your purchases and inquiries.&lt;/p&gt;\r\n&lt;/li&gt;&lt;li data-start=&quot;1362&quot; data-end=&quot;1404&quot; class=&quot;&quot;&gt;\r\n&lt;p data-start=&quot;1364&quot; data-end=&quot;1404&quot; class=&quot;&quot;&gt;To personalize your shopping experience.&lt;/p&gt;\r\n&lt;/li&gt;&lt;li data-start=&quot;1405&quot; data-end=&quot;1454&quot; class=&quot;&quot;&gt;\r\n&lt;p data-start=&quot;1407&quot; data-end=&quot;1454&quot; class=&quot;&quot;&gt;To improve our website, products, and services.&lt;/p&gt;\r\n&lt;/li&gt;&lt;li data-start=&quot;1455&quot; data-end=&quot;1539&quot; class=&quot;&quot;&gt;\r\n&lt;p data-start=&quot;1457&quot; data-end=&quot;1539&quot; class=&quot;&quot;&gt;To send you promotional offers, updates, and newsletters (only with your consent).&lt;/p&gt;\r\n&lt;/li&gt;&lt;li data-start=&quot;1540&quot; data-end=&quot;1590&quot; class=&quot;&quot;&gt;\r\n&lt;p data-start=&quot;1542&quot; data-end=&quot;1590&quot; class=&quot;&quot;&gt;To comply with legal and regulatory obligations.&lt;/p&gt;\r\n&lt;/li&gt;&lt;/ul&gt;\r\n&lt;hr data-start=&quot;1592&quot; data-end=&quot;1595&quot; class=&quot;&quot;&gt;\r\n&lt;h2 data-start=&quot;1597&quot; data-end=&quot;1629&quot; class=&quot;&quot;&gt;3. &lt;strong data-start=&quot;1603&quot; data-end=&quot;1629&quot;&gt;Sharing of Information&lt;/strong&gt;&lt;/h2&gt;\r\n&lt;p data-start=&quot;1631&quot; data-end=&quot;1705&quot; class=&quot;&quot;&gt;We do &lt;strong data-start=&quot;1637&quot; data-end=&quot;1659&quot;&gt;not sell your data&lt;/strong&gt;. However, we may share your information with:&lt;/p&gt;\r\n&lt;ul data-start=&quot;1707&quot; data-end=&quot;2025&quot;&gt;&lt;li data-start=&quot;1707&quot; data-end=&quot;1839&quot; class=&quot;&quot;&gt;\r\n&lt;p data-start=&quot;1709&quot; data-end=&quot;1839&quot; class=&quot;&quot;&gt;&lt;strong data-start=&quot;1709&quot; data-end=&quot;1750&quot;&gt;Trusted third-party service providers&lt;/strong&gt; who help us operate our website, process payments, fulfill orders, or conduct marketing.&lt;/p&gt;\r\n&lt;/li&gt;&lt;li data-start=&quot;1840&quot; data-end=&quot;1942&quot; class=&quot;&quot;&gt;\r\n&lt;p data-start=&quot;1842&quot; data-end=&quot;1942&quot; class=&quot;&quot;&gt;&lt;strong data-start=&quot;1842&quot; data-end=&quot;1891&quot;&gt;Law enforcement agencies or regulatory bodies&lt;/strong&gt; if required by law or to protect our legal rights.&lt;/p&gt;\r\n&lt;/li&gt;&lt;li data-start=&quot;1943&quot; data-end=&quot;2025&quot; class=&quot;&quot;&gt;\r\n&lt;p data-start=&quot;1945&quot; data-end=&quot;2025&quot; class=&quot;&quot;&gt;&lt;strong data-start=&quot;1945&quot; data-end=&quot;1980&quot;&gt;Delivery and logistics partners&lt;/strong&gt; to ensure timely shipping of your purchases.&lt;/p&gt;\r\n&lt;/li&gt;&lt;/ul&gt;\r\n&lt;p data-start=&quot;2027&quot; data-end=&quot;2119&quot; class=&quot;&quot;&gt;All third-party partners are bound by data protection agreements to secure your information.&lt;/p&gt;\r\n&lt;hr data-start=&quot;2121&quot; data-end=&quot;2124&quot; class=&quot;&quot;&gt;\r\n&lt;h2 data-start=&quot;2126&quot; data-end=&quot;2156&quot; class=&quot;&quot;&gt;4. &lt;strong data-start=&quot;2132&quot; data-end=&quot;2156&quot;&gt;Cookies and Tracking&lt;/strong&gt;&lt;/h2&gt;\r\n&lt;p data-start=&quot;2158&quot; data-end=&quot;2210&quot; class=&quot;&quot;&gt;We use cookies and similar tracking technologies to:&lt;/p&gt;\r\n&lt;ul data-start=&quot;2212&quot; data-end=&quot;2322&quot;&gt;&lt;li data-start=&quot;2212&quot; data-end=&quot;2239&quot; class=&quot;&quot;&gt;\r\n&lt;p data-start=&quot;2214&quot; data-end=&quot;2239&quot; class=&quot;&quot;&gt;Enhance site performance.&lt;/p&gt;\r\n&lt;/li&gt;&lt;li data-start=&quot;2240&quot; data-end=&quot;2267&quot; class=&quot;&quot;&gt;\r\n&lt;p data-start=&quot;2242&quot; data-end=&quot;2267&quot; class=&quot;&quot;&gt;Understand user behavior.&lt;/p&gt;\r\n&lt;/li&gt;&lt;li data-start=&quot;2268&quot; data-end=&quot;2322&quot; class=&quot;&quot;&gt;\r\n&lt;p data-start=&quot;2270&quot; data-end=&quot;2322&quot; class=&quot;&quot;&gt;Offer targeted advertisements and marketing content.&lt;/p&gt;\r\n&lt;/li&gt;&lt;/ul&gt;\r\n&lt;p data-start=&quot;2324&quot; data-end=&quot;2393&quot; class=&quot;&quot;&gt;You can manage your cookie preferences through your browser settings.&lt;/p&gt;\r\n&lt;hr data-start=&quot;2395&quot; data-end=&quot;2398&quot; class=&quot;&quot;&gt;\r\n&lt;h2 data-start=&quot;2400&quot; data-end=&quot;2421&quot; class=&quot;&quot;&gt;5. &lt;strong data-start=&quot;2406&quot; data-end=&quot;2421&quot;&gt;Your Rights&lt;/strong&gt;&lt;/h2&gt;\r\n&lt;p data-start=&quot;2423&quot; data-end=&quot;2445&quot; class=&quot;&quot;&gt;You have the right to:&lt;/p&gt;\r\n&lt;ul data-start=&quot;2447&quot; data-end=&quot;2686&quot;&gt;&lt;li data-start=&quot;2447&quot; data-end=&quot;2499&quot; class=&quot;&quot;&gt;\r\n&lt;p data-start=&quot;2449&quot; data-end=&quot;2499&quot; class=&quot;&quot;&gt;Access the personal information we hold about you.&lt;/p&gt;\r\n&lt;/li&gt;&lt;li data-start=&quot;2500&quot; data-end=&quot;2554&quot; class=&quot;&quot;&gt;\r\n&lt;p data-start=&quot;2502&quot; data-end=&quot;2554&quot; class=&quot;&quot;&gt;Request correction of inaccurate or incomplete data.&lt;/p&gt;\r\n&lt;/li&gt;&lt;li data-start=&quot;2555&quot; data-end=&quot;2615&quot; class=&quot;&quot;&gt;\r\n&lt;p data-start=&quot;2557&quot; data-end=&quot;2615&quot; class=&quot;&quot;&gt;Withdraw consent for marketing communications at any time.&lt;/p&gt;\r\n&lt;/li&gt;&lt;li data-start=&quot;2616&quot; data-end=&quot;2686&quot; class=&quot;&quot;&gt;\r\n&lt;p data-start=&quot;2618&quot; data-end=&quot;2686&quot; class=&quot;&quot;&gt;Request deletion of your data (subject to certain legal exceptions).&lt;/p&gt;\r\n&lt;/li&gt;&lt;/ul&gt;\r\n&lt;p data-start=&quot;2688&quot; data-end=&quot;2761&quot; class=&quot;&quot;&gt;To exercise your rights, please contact us at &lt;strong data-start=&quot;2734&quot; data-end=&quot;2760&quot;&gt;[insert contact email]&lt;/strong&gt;.&lt;/p&gt;\r\n&lt;hr data-start=&quot;2763&quot; data-end=&quot;2766&quot; class=&quot;&quot;&gt;\r\n&lt;h2 data-start=&quot;2768&quot; data-end=&quot;2791&quot; class=&quot;&quot;&gt;6. &lt;strong data-start=&quot;2774&quot; data-end=&quot;2791&quot;&gt;Data Security&lt;/strong&gt;&lt;/h2&gt;\r\n&lt;p data-start=&quot;2793&quot; data-end=&quot;2967&quot; class=&quot;&quot;&gt;We take appropriate \r\ntechnical and organizational measures to secure your personal \r\ninformation and protect it from unauthorized access, disclosure, \r\nalteration, or destruction.&lt;/p&gt;\r\n&lt;hr data-start=&quot;2969&quot; data-end=&quot;2972&quot; class=&quot;&quot;&gt;\r\n&lt;h2 data-start=&quot;2974&quot; data-end=&quot;3002&quot; class=&quot;&quot;&gt;7. &lt;strong data-start=&quot;2980&quot; data-end=&quot;3002&quot;&gt;Children’s Privacy&lt;/strong&gt;&lt;/h2&gt;\r\n&lt;p data-start=&quot;3004&quot; data-end=&quot;3124&quot; class=&quot;&quot;&gt;Our services are not directed to children under 13 years old, and we do not knowingly collect personal data from minors.&lt;/p&gt;\r\n&lt;hr data-start=&quot;3126&quot; data-end=&quot;3129&quot; class=&quot;&quot;&gt;\r\n&lt;h2 data-start=&quot;3131&quot; data-end=&quot;3163&quot; class=&quot;&quot;&gt;8. &lt;strong data-start=&quot;3137&quot; data-end=&quot;3163&quot;&gt;Changes to This Policy&lt;/strong&gt;&lt;/h2&gt;\r\n&lt;p data-start=&quot;3165&quot; data-end=&quot;3285&quot; class=&quot;&quot;&gt;We may update this Privacy Policy from time to time. Changes will be posted on this page with an updated effective date.&lt;/p&gt;\r\n&lt;hr data-start=&quot;3287&quot; data-end=&quot;3290&quot; class=&quot;&quot;&gt;\r\n&lt;h2 data-start=&quot;3292&quot; data-end=&quot;3312&quot; class=&quot;&quot;&gt;9. &lt;strong data-start=&quot;3298&quot; data-end=&quot;3312&quot;&gt;Contact Us&lt;/strong&gt;&lt;/h2&gt;\r\n&lt;p data-start=&quot;3314&quot; data-end=&quot;3418&quot; class=&quot;&quot;&gt;If you have questions or concerns about this Privacy Policy or your personal data, please contact us at:&lt;/p&gt;\r\n&lt;p data-start=&quot;3420&quot; data-end=&quot;3560&quot; class=&quot;&quot;&gt;&lt;strong data-start=&quot;3420&quot; data-end=&quot;3439&quot;&gt;Wecis Clothings&lt;/strong&gt;&lt;br data-start=&quot;3439&quot; data-end=&quot;3442&quot;&gt;\r\n&lt;b&gt;Email&lt;/b&gt;: info@wecisclothing.com&lt;br data-start=&quot;3471&quot; data-end=&quot;3474&quot;&gt;\r\n&lt;b&gt;Phone&lt;/b&gt;: +234&amp;nbsp; 803 364 0090&lt;br data-start=&quot;3502&quot; data-end=&quot;3505&quot;&gt;\r\n&lt;b&gt;Address&lt;/b&gt;: NO 3 Adeniyi Jones Avenue, Ikeja and 49 Adeola Odeku, Victoria Island, Lagos, Nigeria&lt;/p&gt;&lt;br&gt;&lt;br&gt;', 'Privacy Policy', '', ''),
(3, 1, 'Privacy Policy', '&lt;p data-start=&quot;310&quot; data-end=&quot;583&quot; class=&quot;&quot;&gt;At &lt;strong data-start=&quot;313&quot; data-end=&quot;332&quot;&gt;Wecis Clothings&lt;/strong&gt;, we value your privacy and are committed to protecting your personal data. This Privacy Policy outlines how we collect, use, share, and safeguard your information when you visit our website, make purchases, or interact with us through other channels.&lt;/p&gt;\r\n&lt;hr data-start=&quot;585&quot; data-end=&quot;588&quot; class=&quot;&quot;&gt;\r\n&lt;h2 data-start=&quot;590&quot; data-end=&quot;622&quot; class=&quot;&quot;&gt;1. &lt;strong data-start=&quot;596&quot; data-end=&quot;622&quot;&gt;Information We Collect&lt;/strong&gt;&lt;/h2&gt;\r\n&lt;p data-start=&quot;624&quot; data-end=&quot;679&quot; class=&quot;&quot;&gt;We collect the following types of personal information:&lt;/p&gt;\r\n&lt;ul data-start=&quot;681&quot; data-end=&quot;1154&quot;&gt;&lt;li data-start=&quot;681&quot; data-end=&quot;730&quot; class=&quot;&quot;&gt;\r\n&lt;p data-start=&quot;683&quot; data-end=&quot;730&quot; class=&quot;&quot;&gt;&lt;strong data-start=&quot;683&quot; data-end=&quot;700&quot;&gt;Identity Data&lt;/strong&gt;: Name, gender, date of birth.&lt;/p&gt;\r\n&lt;/li&gt;&lt;li data-start=&quot;731&quot; data-end=&quot;809&quot; class=&quot;&quot;&gt;\r\n&lt;p data-start=&quot;733&quot; data-end=&quot;809&quot; class=&quot;&quot;&gt;&lt;strong data-start=&quot;733&quot; data-end=&quot;749&quot;&gt;Contact Data&lt;/strong&gt;: Email address, phone number, billing and shipping address.&lt;/p&gt;\r\n&lt;/li&gt;&lt;li data-start=&quot;810&quot; data-end=&quot;951&quot; class=&quot;&quot;&gt;\r\n&lt;p data-start=&quot;812&quot; data-end=&quot;951&quot; class=&quot;&quot;&gt;&lt;strong data-start=&quot;812&quot; data-end=&quot;828&quot;&gt;Payment Data&lt;/strong&gt;: Credit/debit card details and payment transaction history (processed securely via trusted third-party payment providers).&lt;/p&gt;\r\n&lt;/li&gt;&lt;li data-start=&quot;952&quot; data-end=&quot;1066&quot; class=&quot;&quot;&gt;\r\n&lt;p data-start=&quot;954&quot; data-end=&quot;1066&quot; class=&quot;&quot;&gt;&lt;strong data-start=&quot;954&quot; data-end=&quot;972&quot;&gt;Technical Data&lt;/strong&gt;: IP address, browser type, operating system, device identifiers, and website usage analytics.&lt;/p&gt;\r\n&lt;/li&gt;&lt;li data-start=&quot;1067&quot; data-end=&quot;1154&quot; class=&quot;&quot;&gt;\r\n&lt;p data-start=&quot;1069&quot; data-end=&quot;1154&quot; class=&quot;&quot;&gt;&lt;strong data-start=&quot;1069&quot; data-end=&quot;1087&quot;&gt;Marketing Data&lt;/strong&gt;: Preferences for receiving communications and promotional content.&lt;/p&gt;\r\n&lt;/li&gt;&lt;/ul&gt;\r\n&lt;hr data-start=&quot;1156&quot; data-end=&quot;1159&quot; class=&quot;&quot;&gt;\r\n&lt;h2 data-start=&quot;1161&quot; data-end=&quot;1198&quot; class=&quot;&quot;&gt;2. &lt;strong data-start=&quot;1167&quot; data-end=&quot;1198&quot;&gt;How We Use Your Information&lt;/strong&gt;&lt;/h2&gt;\r\n&lt;p data-start=&quot;1200&quot; data-end=&quot;1260&quot; class=&quot;&quot;&gt;We use your personal information for the following purposes:&lt;/p&gt;\r\n&lt;ul data-start=&quot;1262&quot; data-end=&quot;1590&quot;&gt;&lt;li data-start=&quot;1262&quot; data-end=&quot;1299&quot; class=&quot;&quot;&gt;\r\n&lt;p data-start=&quot;1264&quot; data-end=&quot;1299&quot; class=&quot;&quot;&gt;To process and deliver your orders.&lt;/p&gt;\r\n&lt;/li&gt;&lt;li data-start=&quot;1300&quot; data-end=&quot;1361&quot; class=&quot;&quot;&gt;\r\n&lt;p data-start=&quot;1302&quot; data-end=&quot;1361&quot; class=&quot;&quot;&gt;To communicate with you about your purchases and inquiries.&lt;/p&gt;\r\n&lt;/li&gt;&lt;li data-start=&quot;1362&quot; data-end=&quot;1404&quot; class=&quot;&quot;&gt;\r\n&lt;p data-start=&quot;1364&quot; data-end=&quot;1404&quot; class=&quot;&quot;&gt;To personalize your shopping experience.&lt;/p&gt;\r\n&lt;/li&gt;&lt;li data-start=&quot;1405&quot; data-end=&quot;1454&quot; class=&quot;&quot;&gt;\r\n&lt;p data-start=&quot;1407&quot; data-end=&quot;1454&quot; class=&quot;&quot;&gt;To improve our website, products, and services.&lt;/p&gt;\r\n&lt;/li&gt;&lt;li data-start=&quot;1455&quot; data-end=&quot;1539&quot; class=&quot;&quot;&gt;\r\n&lt;p data-start=&quot;1457&quot; data-end=&quot;1539&quot; class=&quot;&quot;&gt;To send you promotional offers, updates, and newsletters (only with your consent).&lt;/p&gt;\r\n&lt;/li&gt;&lt;li data-start=&quot;1540&quot; data-end=&quot;1590&quot; class=&quot;&quot;&gt;\r\n&lt;p data-start=&quot;1542&quot; data-end=&quot;1590&quot; class=&quot;&quot;&gt;To comply with legal and regulatory obligations.&lt;/p&gt;\r\n&lt;/li&gt;&lt;/ul&gt;\r\n&lt;hr data-start=&quot;1592&quot; data-end=&quot;1595&quot; class=&quot;&quot;&gt;\r\n&lt;h2 data-start=&quot;1597&quot; data-end=&quot;1629&quot; class=&quot;&quot;&gt;3. &lt;strong data-start=&quot;1603&quot; data-end=&quot;1629&quot;&gt;Sharing of Information&lt;/strong&gt;&lt;/h2&gt;\r\n&lt;p data-start=&quot;1631&quot; data-end=&quot;1705&quot; class=&quot;&quot;&gt;We do &lt;strong data-start=&quot;1637&quot; data-end=&quot;1659&quot;&gt;not sell your data&lt;/strong&gt;. However, we may share your information with:&lt;/p&gt;\r\n&lt;ul data-start=&quot;1707&quot; data-end=&quot;2025&quot;&gt;&lt;li data-start=&quot;1707&quot; data-end=&quot;1839&quot; class=&quot;&quot;&gt;\r\n&lt;p data-start=&quot;1709&quot; data-end=&quot;1839&quot; class=&quot;&quot;&gt;&lt;strong data-start=&quot;1709&quot; data-end=&quot;1750&quot;&gt;Trusted third-party service providers&lt;/strong&gt; who help us operate our website, process payments, fulfill orders, or conduct marketing.&lt;/p&gt;\r\n&lt;/li&gt;&lt;li data-start=&quot;1840&quot; data-end=&quot;1942&quot; class=&quot;&quot;&gt;\r\n&lt;p data-start=&quot;1842&quot; data-end=&quot;1942&quot; class=&quot;&quot;&gt;&lt;strong data-start=&quot;1842&quot; data-end=&quot;1891&quot;&gt;Law enforcement agencies or regulatory bodies&lt;/strong&gt; if required by law or to protect our legal rights.&lt;/p&gt;\r\n&lt;/li&gt;&lt;li data-start=&quot;1943&quot; data-end=&quot;2025&quot; class=&quot;&quot;&gt;\r\n&lt;p data-start=&quot;1945&quot; data-end=&quot;2025&quot; class=&quot;&quot;&gt;&lt;strong data-start=&quot;1945&quot; data-end=&quot;1980&quot;&gt;Delivery and logistics partners&lt;/strong&gt; to ensure timely shipping of your purchases.&lt;/p&gt;\r\n&lt;/li&gt;&lt;/ul&gt;\r\n&lt;p data-start=&quot;2027&quot; data-end=&quot;2119&quot; class=&quot;&quot;&gt;All third-party partners are bound by data protection agreements to secure your information.&lt;/p&gt;\r\n&lt;hr data-start=&quot;2121&quot; data-end=&quot;2124&quot; class=&quot;&quot;&gt;\r\n&lt;h2 data-start=&quot;2126&quot; data-end=&quot;2156&quot; class=&quot;&quot;&gt;4. &lt;strong data-start=&quot;2132&quot; data-end=&quot;2156&quot;&gt;Cookies and Tracking&lt;/strong&gt;&lt;/h2&gt;\r\n&lt;p data-start=&quot;2158&quot; data-end=&quot;2210&quot; class=&quot;&quot;&gt;We use cookies and similar tracking technologies to:&lt;/p&gt;\r\n&lt;ul data-start=&quot;2212&quot; data-end=&quot;2322&quot;&gt;&lt;li data-start=&quot;2212&quot; data-end=&quot;2239&quot; class=&quot;&quot;&gt;\r\n&lt;p data-start=&quot;2214&quot; data-end=&quot;2239&quot; class=&quot;&quot;&gt;Enhance site performance.&lt;/p&gt;\r\n&lt;/li&gt;&lt;li data-start=&quot;2240&quot; data-end=&quot;2267&quot; class=&quot;&quot;&gt;\r\n&lt;p data-start=&quot;2242&quot; data-end=&quot;2267&quot; class=&quot;&quot;&gt;Understand user behavior.&lt;/p&gt;\r\n&lt;/li&gt;&lt;li data-start=&quot;2268&quot; data-end=&quot;2322&quot; class=&quot;&quot;&gt;\r\n&lt;p data-start=&quot;2270&quot; data-end=&quot;2322&quot; class=&quot;&quot;&gt;Offer targeted advertisements and marketing content.&lt;/p&gt;\r\n&lt;/li&gt;&lt;/ul&gt;\r\n&lt;p data-start=&quot;2324&quot; data-end=&quot;2393&quot; class=&quot;&quot;&gt;You can manage your cookie preferences through your browser settings.&lt;/p&gt;\r\n&lt;hr data-start=&quot;2395&quot; data-end=&quot;2398&quot; class=&quot;&quot;&gt;\r\n&lt;h2 data-start=&quot;2400&quot; data-end=&quot;2421&quot; class=&quot;&quot;&gt;5. &lt;strong data-start=&quot;2406&quot; data-end=&quot;2421&quot;&gt;Your Rights&lt;/strong&gt;&lt;/h2&gt;\r\n&lt;p data-start=&quot;2423&quot; data-end=&quot;2445&quot; class=&quot;&quot;&gt;You have the right to:&lt;/p&gt;\r\n&lt;ul data-start=&quot;2447&quot; data-end=&quot;2686&quot;&gt;&lt;li data-start=&quot;2447&quot; data-end=&quot;2499&quot; class=&quot;&quot;&gt;\r\n&lt;p data-start=&quot;2449&quot; data-end=&quot;2499&quot; class=&quot;&quot;&gt;Access the personal information we hold about you.&lt;/p&gt;\r\n&lt;/li&gt;&lt;li data-start=&quot;2500&quot; data-end=&quot;2554&quot; class=&quot;&quot;&gt;\r\n&lt;p data-start=&quot;2502&quot; data-end=&quot;2554&quot; class=&quot;&quot;&gt;Request correction of inaccurate or incomplete data.&lt;/p&gt;\r\n&lt;/li&gt;&lt;li data-start=&quot;2555&quot; data-end=&quot;2615&quot; class=&quot;&quot;&gt;\r\n&lt;p data-start=&quot;2557&quot; data-end=&quot;2615&quot; class=&quot;&quot;&gt;Withdraw consent for marketing communications at any time.&lt;/p&gt;\r\n&lt;/li&gt;&lt;li data-start=&quot;2616&quot; data-end=&quot;2686&quot; class=&quot;&quot;&gt;\r\n&lt;p data-start=&quot;2618&quot; data-end=&quot;2686&quot; class=&quot;&quot;&gt;Request deletion of your data (subject to certain legal exceptions).&lt;/p&gt;\r\n&lt;/li&gt;&lt;/ul&gt;\r\n&lt;p data-start=&quot;2688&quot; data-end=&quot;2761&quot; class=&quot;&quot;&gt;To exercise your rights, please contact us at &lt;strong data-start=&quot;2734&quot; data-end=&quot;2760&quot;&gt;[insert contact email]&lt;/strong&gt;.&lt;/p&gt;\r\n&lt;hr data-start=&quot;2763&quot; data-end=&quot;2766&quot; class=&quot;&quot;&gt;\r\n&lt;h2 data-start=&quot;2768&quot; data-end=&quot;2791&quot; class=&quot;&quot;&gt;6. &lt;strong data-start=&quot;2774&quot; data-end=&quot;2791&quot;&gt;Data Security&lt;/strong&gt;&lt;/h2&gt;\r\n&lt;p data-start=&quot;2793&quot; data-end=&quot;2967&quot; class=&quot;&quot;&gt;We take appropriate technical and organizational measures to secure your personal information and protect it from unauthorized access, disclosure, alteration, or destruction.&lt;/p&gt;\r\n&lt;hr data-start=&quot;2969&quot; data-end=&quot;2972&quot; class=&quot;&quot;&gt;\r\n&lt;h2 data-start=&quot;2974&quot; data-end=&quot;3002&quot; class=&quot;&quot;&gt;7. &lt;strong data-start=&quot;2980&quot; data-end=&quot;3002&quot;&gt;Children’s Privacy&lt;/strong&gt;&lt;/h2&gt;\r\n&lt;p data-start=&quot;3004&quot; data-end=&quot;3124&quot; class=&quot;&quot;&gt;Our services are not directed to children under 13 years old, and we do not knowingly collect personal data from minors.&lt;/p&gt;\r\n&lt;hr data-start=&quot;3126&quot; data-end=&quot;3129&quot; class=&quot;&quot;&gt;\r\n&lt;h2 data-start=&quot;3131&quot; data-end=&quot;3163&quot; class=&quot;&quot;&gt;8. &lt;strong data-start=&quot;3137&quot; data-end=&quot;3163&quot;&gt;Changes to This Policy&lt;/strong&gt;&lt;/h2&gt;\r\n&lt;p data-start=&quot;3165&quot; data-end=&quot;3285&quot; class=&quot;&quot;&gt;We may update this Privacy Policy from time to time. Changes will be posted on this page with an updated effective date.&lt;/p&gt;\r\n&lt;hr data-start=&quot;3287&quot; data-end=&quot;3290&quot; class=&quot;&quot;&gt;\r\n&lt;h2 data-start=&quot;3292&quot; data-end=&quot;3312&quot; class=&quot;&quot;&gt;9. &lt;strong data-start=&quot;3298&quot; data-end=&quot;3312&quot;&gt;Contact Us&lt;/strong&gt;&lt;/h2&gt;\r\n&lt;p data-start=&quot;3314&quot; data-end=&quot;3418&quot; class=&quot;&quot;&gt;If you have questions or concerns about this Privacy Policy or your personal data, please contact us at:&lt;/p&gt;\r\n&lt;p data-start=&quot;3420&quot; data-end=&quot;3560&quot; class=&quot;&quot;&gt;&lt;strong data-start=&quot;3420&quot; data-end=&quot;3439&quot;&gt;Wecis Clothings&lt;/strong&gt;&lt;br data-start=&quot;3439&quot; data-end=&quot;3442&quot;&gt;\r\n&lt;b&gt;Email&lt;/b&gt;: info@wecisclothing.com&lt;br data-start=&quot;3471&quot; data-end=&quot;3474&quot;&gt;\r\n&lt;b&gt;Phone&lt;/b&gt;: +234&amp;nbsp; 803 364 0090&lt;br data-start=&quot;3502&quot; data-end=&quot;3505&quot;&gt;\r\n&lt;b&gt;Address&lt;/b&gt;: NO 3 Adeniyi Jones Avenue, Ikeja and 49 Adeola Odeku, Victoria Island, Lagos, Nigeria&lt;/p&gt;&lt;br&gt;', 'Privacy Policy', '', ''),
(5, 2, 'Terms &amp; Conditions', '&lt;p data-start=&quot;259&quot; data-end=&quot;509&quot; class=&quot;&quot;&gt;Welcome to &lt;strong data-start=&quot;270&quot; data-end=&quot;289&quot;&gt;Wecis Clothings&lt;/strong&gt;.\r\n These Terms and Conditions (“Terms”) govern your use of our website and\r\n services. By accessing or purchasing from our platform, you agree to be\r\n bound by these Terms. If you do not agree, please do not use our \r\nservices.&lt;/p&gt;\r\n&lt;hr data-start=&quot;511&quot; data-end=&quot;514&quot; class=&quot;&quot;&gt;\r\n&lt;h2 data-start=&quot;516&quot; data-end=&quot;540&quot; class=&quot;&quot;&gt;1. &lt;strong data-start=&quot;522&quot; data-end=&quot;540&quot;&gt;Use of Website&lt;/strong&gt;&lt;/h2&gt;\r\n&lt;p data-start=&quot;542&quot; data-end=&quot;809&quot; class=&quot;&quot;&gt;You agree to use this \r\nwebsite for lawful purposes only and in a way that does not infringe the\r\n rights of others or restrict their enjoyment of the website. You may \r\nnot use our site to distribute spam, transmit viruses, or engage in any \r\nharmful or unlawful activities.&lt;/p&gt;\r\n&lt;hr data-start=&quot;811&quot; data-end=&quot;814&quot; class=&quot;&quot;&gt;\r\n&lt;h2 data-start=&quot;816&quot; data-end=&quot;846&quot; class=&quot;&quot;&gt;2. &lt;strong data-start=&quot;822&quot; data-end=&quot;846&quot;&gt;Products and Pricing&lt;/strong&gt;&lt;/h2&gt;\r\n&lt;p data-start=&quot;848&quot; data-end=&quot;1132&quot; class=&quot;&quot;&gt;All prices are listed in [&lt;span style=&quot;color: rgb(71, 71, 71); font-family: &amp;quot;Google Sans&amp;quot;, Arial, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;&quot;&gt;₦&lt;/span&gt;\r\n / Nigerian Naira] and are subject to change without notice. We reserve \r\nthe right to modify or discontinue any product at any time. Product \r\nimages are for illustration purposes; actual colors and patterns may \r\nvary slightly due to lighting and fabric variation.&lt;/p&gt;\r\n&lt;hr data-start=&quot;1134&quot; data-end=&quot;1137&quot; class=&quot;&quot;&gt;\r\n&lt;h2 data-start=&quot;1139&quot; data-end=&quot;1167&quot; class=&quot;&quot;&gt;3. &lt;strong data-start=&quot;1145&quot; data-end=&quot;1167&quot;&gt;Orders and Payment&lt;/strong&gt;&lt;/h2&gt;\r\n&lt;ul data-start=&quot;1169&quot; data-end=&quot;1455&quot;&gt;&lt;li data-start=&quot;1169&quot; data-end=&quot;1221&quot; class=&quot;&quot;&gt;\r\n&lt;p data-start=&quot;1171&quot; data-end=&quot;1221&quot; class=&quot;&quot;&gt;Orders are confirmed upon receipt of full payment.&lt;/p&gt;\r\n&lt;/li&gt;&lt;li data-start=&quot;1222&quot; data-end=&quot;1279&quot; class=&quot;&quot;&gt;\r\n&lt;p data-start=&quot;1224&quot; data-end=&quot;1279&quot; class=&quot;&quot;&gt;We accept payments through secure third-party gateways.&lt;/p&gt;\r\n&lt;/li&gt;&lt;li data-start=&quot;1280&quot; data-end=&quot;1399&quot; class=&quot;&quot;&gt;\r\n&lt;p data-start=&quot;1282&quot; data-end=&quot;1399&quot; class=&quot;&quot;&gt;Wecis Clothings reserves the right to cancel any order at our discretion, with a full refund issued where applicable.&lt;/p&gt;\r\n&lt;/li&gt;&lt;li data-start=&quot;1400&quot; data-end=&quot;1455&quot; class=&quot;&quot;&gt;\r\n&lt;p data-start=&quot;1402&quot; data-end=&quot;1455&quot; class=&quot;&quot;&gt;Once an order is placed, changes may not be possible.&lt;/p&gt;\r\n&lt;/li&gt;&lt;/ul&gt;\r\n&lt;hr data-start=&quot;1457&quot; data-end=&quot;1460&quot; class=&quot;&quot;&gt;\r\n&lt;h2 data-start=&quot;1462&quot; data-end=&quot;1493&quot; class=&quot;&quot;&gt;4. &lt;strong data-start=&quot;1468&quot; data-end=&quot;1493&quot;&gt;Shipping and Delivery&lt;/strong&gt;&lt;/h2&gt;\r\n&lt;ul data-start=&quot;1495&quot; data-end=&quot;1770&quot;&gt;&lt;li data-start=&quot;1495&quot; data-end=&quot;1585&quot; class=&quot;&quot;&gt;\r\n&lt;p data-start=&quot;1497&quot; data-end=&quot;1585&quot; class=&quot;&quot;&gt;We deliver &lt;strong data-start=&quot;1508&quot; data-end=&quot;1521&quot;&gt;worldwide&lt;/strong&gt;. Shipping fees and delivery timelines are provided at checkout.&lt;/p&gt;\r\n&lt;/li&gt;&lt;li data-start=&quot;1586&quot; data-end=&quot;1684&quot; class=&quot;&quot;&gt;\r\n&lt;p data-start=&quot;1588&quot; data-end=&quot;1684&quot; class=&quot;&quot;&gt;We are not responsible for delays due to customs, local courier issues, or force majeure events.&lt;/p&gt;\r\n&lt;/li&gt;&lt;li data-start=&quot;1685&quot; data-end=&quot;1770&quot; class=&quot;&quot;&gt;\r\n&lt;p data-start=&quot;1687&quot; data-end=&quot;1770&quot; class=&quot;&quot;&gt;Customers are responsible for any customs duties or taxes imposed by their country.&lt;/p&gt;\r\n&lt;/li&gt;&lt;/ul&gt;\r\n&lt;hr data-start=&quot;1772&quot; data-end=&quot;1775&quot; class=&quot;&quot;&gt;\r\n&lt;h2 data-start=&quot;1777&quot; data-end=&quot;1808&quot; class=&quot;&quot;&gt;5. &lt;strong data-start=&quot;1783&quot; data-end=&quot;1808&quot;&gt;Returns and Exchanges&lt;/strong&gt;&lt;/h2&gt;\r\n&lt;ul data-start=&quot;1810&quot; data-end=&quot;2150&quot;&gt;&lt;li data-start=&quot;1810&quot; data-end=&quot;1923&quot; class=&quot;&quot;&gt;\r\n&lt;p data-start=&quot;1812&quot; data-end=&quot;1923&quot; class=&quot;&quot;&gt;Items can be returned or exchanged within &lt;strong data-start=&quot;1854&quot; data-end=&quot;1864&quot;&gt;30 days&lt;/strong&gt; of receipt if unworn, unwashed, and in original condition.&lt;/p&gt;\r\n&lt;/li&gt;&lt;li data-start=&quot;1924&quot; data-end=&quot;1988&quot; class=&quot;&quot;&gt;\r\n&lt;p data-start=&quot;1926&quot; data-end=&quot;1988&quot; class=&quot;&quot;&gt;Custom or made-to-order items are &lt;strong data-start=&quot;1960&quot; data-end=&quot;1976&quot;&gt;not eligible&lt;/strong&gt; for return.&lt;/p&gt;\r\n&lt;/li&gt;&lt;li data-start=&quot;1989&quot; data-end=&quot;2065&quot; class=&quot;&quot;&gt;\r\n&lt;p data-start=&quot;1991&quot; data-end=&quot;2065&quot; class=&quot;&quot;&gt;Refunds are processed upon inspection and may take up to 14 business days.&lt;/p&gt;\r\n&lt;/li&gt;&lt;li data-start=&quot;2066&quot; data-end=&quot;2150&quot; class=&quot;&quot;&gt;\r\n&lt;p data-start=&quot;2068&quot; data-end=&quot;2150&quot; class=&quot;&quot;&gt;Shipping costs for returns are borne by the customer unless the item is defective.&lt;/p&gt;\r\n&lt;/li&gt;&lt;/ul&gt;\r\n&lt;hr data-start=&quot;2152&quot; data-end=&quot;2155&quot; class=&quot;&quot;&gt;\r\n&lt;h2 data-start=&quot;2157&quot; data-end=&quot;2188&quot; class=&quot;&quot;&gt;6. &lt;strong data-start=&quot;2163&quot; data-end=&quot;2188&quot;&gt;Intellectual Property&lt;/strong&gt;&lt;/h2&gt;\r\n&lt;p data-start=&quot;2190&quot; data-end=&quot;2413&quot; class=&quot;&quot;&gt;All content on this website, including logos, designs, images, and text, is the property of &lt;strong data-start=&quot;2282&quot; data-end=&quot;2301&quot;&gt;Wecis Clothings&lt;/strong&gt; and protected by intellectual property laws. Unauthorized use, copying, or distribution is strictly prohibited.&lt;/p&gt;\r\n&lt;hr data-start=&quot;2415&quot; data-end=&quot;2418&quot; class=&quot;&quot;&gt;\r\n&lt;h2 data-start=&quot;2420&quot; data-end=&quot;2453&quot; class=&quot;&quot;&gt;7. &lt;strong data-start=&quot;2426&quot; data-end=&quot;2453&quot;&gt;Limitation of Liability&lt;/strong&gt;&lt;/h2&gt;\r\n&lt;p data-start=&quot;2455&quot; data-end=&quot;2692&quot; class=&quot;&quot;&gt;To the fullest extent \r\npermitted by law, Wecis Clothings shall not be liable for any indirect, \r\nincidental, or consequential damages arising from the use of our \r\nproducts or services. We do not guarantee uninterrupted access to our \r\nwebsite.&lt;/p&gt;\r\n&lt;hr data-start=&quot;2694&quot; data-end=&quot;2697&quot; class=&quot;&quot;&gt;\r\n&lt;h2 data-start=&quot;2699&quot; data-end=&quot;2716&quot; class=&quot;&quot;&gt;8. &lt;strong data-start=&quot;2705&quot; data-end=&quot;2716&quot;&gt;Privacy&lt;/strong&gt;&lt;/h2&gt;\r\n&lt;p data-start=&quot;2718&quot; data-end=&quot;2861&quot; class=&quot;&quot;&gt;Your use of our website is also governed by our &lt;a data-start=&quot;2766&quot; data-end=&quot;2785&quot; class=&quot;&quot; rel=&quot;noopener&quot; href=&quot;https://www.wecisclothing.com/index.php?route=information/information&amp;amp;information_id=5&quot; target=&quot;_blank&quot;&gt;Privacy Policy&lt;/a&gt;, which outlines how we collect, use, and protect your personal information.&lt;/p&gt;\r\n&lt;hr data-start=&quot;2863&quot; data-end=&quot;2866&quot; class=&quot;&quot;&gt;\r\n&lt;h2 data-start=&quot;2868&quot; data-end=&quot;2891&quot; class=&quot;&quot;&gt;9. &lt;strong data-start=&quot;2874&quot; data-end=&quot;2891&quot;&gt;Governing Law&lt;/strong&gt;&lt;/h2&gt;\r\n&lt;p data-start=&quot;2893&quot; data-end=&quot;3045&quot; class=&quot;&quot;&gt;These Terms are governed \r\nby the laws of the Federal Republic of Nigeria. Any disputes shall be \r\nresolved in the competent courts of Lagos State, Nigeria.&lt;/p&gt;&lt;br&gt;&lt;br&gt;', 'Terms &amp; Conditions', '', ''),
(5, 1, 'Terms &amp; Conditions', '&lt;p data-start=&quot;259&quot; data-end=&quot;509&quot; class=&quot;&quot;&gt;Welcome to &lt;strong data-start=&quot;270&quot; data-end=&quot;289&quot;&gt;Wecis Clothings&lt;/strong&gt;. These Terms and Conditions (“Terms”) govern your use of our website and services. By accessing or purchasing from our platform, you agree to be bound by these Terms. If you do not agree, please do not use our services.&lt;/p&gt;\r\n&lt;hr data-start=&quot;511&quot; data-end=&quot;514&quot; class=&quot;&quot;&gt;\r\n&lt;h2 data-start=&quot;516&quot; data-end=&quot;540&quot; class=&quot;&quot;&gt;1. &lt;strong data-start=&quot;522&quot; data-end=&quot;540&quot;&gt;Use of Website&lt;/strong&gt;&lt;/h2&gt;\r\n&lt;p data-start=&quot;542&quot; data-end=&quot;809&quot; class=&quot;&quot;&gt;You agree to use this website for lawful purposes only and in a way that does not infringe the rights of others or restrict their enjoyment of the website. You may not use our site to distribute spam, transmit viruses, or engage in any harmful or unlawful activities.&lt;/p&gt;\r\n&lt;hr data-start=&quot;811&quot; data-end=&quot;814&quot; class=&quot;&quot;&gt;\r\n&lt;h2 data-start=&quot;816&quot; data-end=&quot;846&quot; class=&quot;&quot;&gt;2. &lt;strong data-start=&quot;822&quot; data-end=&quot;846&quot;&gt;Products and Pricing&lt;/strong&gt;&lt;/h2&gt;\r\n&lt;p data-start=&quot;848&quot; data-end=&quot;1132&quot; class=&quot;&quot;&gt;All prices are listed in [&lt;span style=&quot;color: rgb(71, 71, 71); font-family: &amp;quot;Google Sans&amp;quot;, Arial, sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;&quot;&gt;₦&lt;/span&gt; / Nigerian Naira] and are subject to change without notice. We reserve the right to modify or discontinue any product at any time. Product images are for illustration purposes; actual colors and patterns may vary slightly due to lighting and fabric variation.&lt;/p&gt;\r\n&lt;hr data-start=&quot;1134&quot; data-end=&quot;1137&quot; class=&quot;&quot;&gt;\r\n&lt;h2 data-start=&quot;1139&quot; data-end=&quot;1167&quot; class=&quot;&quot;&gt;3. &lt;strong data-start=&quot;1145&quot; data-end=&quot;1167&quot;&gt;Orders and Payment&lt;/strong&gt;&lt;/h2&gt;\r\n&lt;ul data-start=&quot;1169&quot; data-end=&quot;1455&quot;&gt;&lt;li data-start=&quot;1169&quot; data-end=&quot;1221&quot; class=&quot;&quot;&gt;\r\n&lt;p data-start=&quot;1171&quot; data-end=&quot;1221&quot; class=&quot;&quot;&gt;Orders are confirmed upon receipt of full payment.&lt;/p&gt;\r\n&lt;/li&gt;&lt;li data-start=&quot;1222&quot; data-end=&quot;1279&quot; class=&quot;&quot;&gt;\r\n&lt;p data-start=&quot;1224&quot; data-end=&quot;1279&quot; class=&quot;&quot;&gt;We accept payments through secure third-party gateways.&lt;/p&gt;\r\n&lt;/li&gt;&lt;li data-start=&quot;1280&quot; data-end=&quot;1399&quot; class=&quot;&quot;&gt;\r\n&lt;p data-start=&quot;1282&quot; data-end=&quot;1399&quot; class=&quot;&quot;&gt;Wecis Clothings reserves the right to cancel any order at our discretion, with a full refund issued where applicable.&lt;/p&gt;\r\n&lt;/li&gt;&lt;li data-start=&quot;1400&quot; data-end=&quot;1455&quot; class=&quot;&quot;&gt;\r\n&lt;p data-start=&quot;1402&quot; data-end=&quot;1455&quot; class=&quot;&quot;&gt;Once an order is placed, changes may not be possible.&lt;/p&gt;\r\n&lt;/li&gt;&lt;/ul&gt;\r\n&lt;hr data-start=&quot;1457&quot; data-end=&quot;1460&quot; class=&quot;&quot;&gt;\r\n&lt;h2 data-start=&quot;1462&quot; data-end=&quot;1493&quot; class=&quot;&quot;&gt;4. &lt;strong data-start=&quot;1468&quot; data-end=&quot;1493&quot;&gt;Shipping and Delivery&lt;/strong&gt;&lt;/h2&gt;\r\n&lt;ul data-start=&quot;1495&quot; data-end=&quot;1770&quot;&gt;&lt;li data-start=&quot;1495&quot; data-end=&quot;1585&quot; class=&quot;&quot;&gt;\r\n&lt;p data-start=&quot;1497&quot; data-end=&quot;1585&quot; class=&quot;&quot;&gt;We deliver &lt;strong data-start=&quot;1508&quot; data-end=&quot;1521&quot;&gt;worldwide&lt;/strong&gt;. Shipping fees and delivery timelines are provided at checkout.&lt;/p&gt;\r\n&lt;/li&gt;&lt;li data-start=&quot;1586&quot; data-end=&quot;1684&quot; class=&quot;&quot;&gt;\r\n&lt;p data-start=&quot;1588&quot; data-end=&quot;1684&quot; class=&quot;&quot;&gt;We are not responsible for delays due to customs, local courier issues, or force majeure events.&lt;/p&gt;\r\n&lt;/li&gt;&lt;li data-start=&quot;1685&quot; data-end=&quot;1770&quot; class=&quot;&quot;&gt;\r\n&lt;p data-start=&quot;1687&quot; data-end=&quot;1770&quot; class=&quot;&quot;&gt;Customers are responsible for any customs duties or taxes imposed by their country.&lt;/p&gt;\r\n&lt;/li&gt;&lt;/ul&gt;\r\n&lt;hr data-start=&quot;1772&quot; data-end=&quot;1775&quot; class=&quot;&quot;&gt;\r\n&lt;h2 data-start=&quot;1777&quot; data-end=&quot;1808&quot; class=&quot;&quot;&gt;5. &lt;strong data-start=&quot;1783&quot; data-end=&quot;1808&quot;&gt;Returns and Exchanges&lt;/strong&gt;&lt;/h2&gt;\r\n&lt;ul data-start=&quot;1810&quot; data-end=&quot;2150&quot;&gt;&lt;li data-start=&quot;1810&quot; data-end=&quot;1923&quot; class=&quot;&quot;&gt;\r\n&lt;p data-start=&quot;1812&quot; data-end=&quot;1923&quot; class=&quot;&quot;&gt;Items can be returned or exchanged within &lt;strong data-start=&quot;1854&quot; data-end=&quot;1864&quot;&gt;30 days&lt;/strong&gt; of receipt if unworn, unwashed, and in original condition.&lt;/p&gt;\r\n&lt;/li&gt;&lt;li data-start=&quot;1924&quot; data-end=&quot;1988&quot; class=&quot;&quot;&gt;\r\n&lt;p data-start=&quot;1926&quot; data-end=&quot;1988&quot; class=&quot;&quot;&gt;Custom or made-to-order items are &lt;strong data-start=&quot;1960&quot; data-end=&quot;1976&quot;&gt;not eligible&lt;/strong&gt; for return.&lt;/p&gt;\r\n&lt;/li&gt;&lt;li data-start=&quot;1989&quot; data-end=&quot;2065&quot; class=&quot;&quot;&gt;\r\n&lt;p data-start=&quot;1991&quot; data-end=&quot;2065&quot; class=&quot;&quot;&gt;Refunds are processed upon inspection and may take up to 14 business days.&lt;/p&gt;\r\n&lt;/li&gt;&lt;li data-start=&quot;2066&quot; data-end=&quot;2150&quot; class=&quot;&quot;&gt;\r\n&lt;p data-start=&quot;2068&quot; data-end=&quot;2150&quot; class=&quot;&quot;&gt;Shipping costs for returns are borne by the customer unless the item is defective.&lt;/p&gt;\r\n&lt;/li&gt;&lt;/ul&gt;\r\n&lt;hr data-start=&quot;2152&quot; data-end=&quot;2155&quot; class=&quot;&quot;&gt;\r\n&lt;h2 data-start=&quot;2157&quot; data-end=&quot;2188&quot; class=&quot;&quot;&gt;6. &lt;strong data-start=&quot;2163&quot; data-end=&quot;2188&quot;&gt;Intellectual Property&lt;/strong&gt;&lt;/h2&gt;\r\n&lt;p data-start=&quot;2190&quot; data-end=&quot;2413&quot; class=&quot;&quot;&gt;All content on this website, including logos, designs, images, and text, is the property of &lt;strong data-start=&quot;2282&quot; data-end=&quot;2301&quot;&gt;Wecis Clothings&lt;/strong&gt; and protected by intellectual property laws. Unauthorized use, copying, or distribution is strictly prohibited.&lt;/p&gt;\r\n&lt;hr data-start=&quot;2415&quot; data-end=&quot;2418&quot; class=&quot;&quot;&gt;\r\n&lt;h2 data-start=&quot;2420&quot; data-end=&quot;2453&quot; class=&quot;&quot;&gt;7. &lt;strong data-start=&quot;2426&quot; data-end=&quot;2453&quot;&gt;Limitation of Liability&lt;/strong&gt;&lt;/h2&gt;\r\n&lt;p data-start=&quot;2455&quot; data-end=&quot;2692&quot; class=&quot;&quot;&gt;To the fullest extent permitted by law, Wecis Clothings shall not be liable for any indirect, incidental, or consequential damages arising from the use of our products or services. We do not guarantee uninterrupted access to our website.&lt;/p&gt;\r\n&lt;hr data-start=&quot;2694&quot; data-end=&quot;2697&quot; class=&quot;&quot;&gt;\r\n&lt;h2 data-start=&quot;2699&quot; data-end=&quot;2716&quot; class=&quot;&quot;&gt;8. &lt;strong data-start=&quot;2705&quot; data-end=&quot;2716&quot;&gt;Privacy&lt;/strong&gt;&lt;/h2&gt;\r\n&lt;p data-start=&quot;2718&quot; data-end=&quot;2861&quot; class=&quot;&quot;&gt;Your use of our website is also governed by our &lt;a data-start=&quot;2766&quot; data-end=&quot;2785&quot; class=&quot;&quot; rel=&quot;noopener&quot; href=&quot;https://www.wecisclothing.com/index.php?route=information/information&amp;amp;information_id=5&quot; target=&quot;_blank&quot;&gt;Privacy Policy&lt;/a&gt;, which outlines how we collect, use, and protect your personal information.&lt;/p&gt;\r\n&lt;hr data-start=&quot;2863&quot; data-end=&quot;2866&quot; class=&quot;&quot;&gt;\r\n&lt;h2 data-start=&quot;2868&quot; data-end=&quot;2891&quot; class=&quot;&quot;&gt;9. &lt;strong data-start=&quot;2874&quot; data-end=&quot;2891&quot;&gt;Governing Law&lt;/strong&gt;&lt;/h2&gt;\r\n&lt;p data-start=&quot;2893&quot; data-end=&quot;3045&quot; class=&quot;&quot;&gt;These Terms are governed by the laws of the Federal Republic of Nigeria. Any disputes shall be resolved in the competent courts of Lagos State, Nigeria.&lt;/p&gt;&lt;br&gt;', 'Terms &amp; Conditions', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `oc_information_to_layout`
--

CREATE TABLE `oc_information_to_layout` (
  `information_id` int NOT NULL,
  `store_id` int NOT NULL,
  `layout_id` int NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_information_to_layout`
--

INSERT INTO `oc_information_to_layout` (`information_id`, `store_id`, `layout_id`) VALUES
(4, 0, 0),
(6, 0, 0),
(3, 0, 0),
(5, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `oc_information_to_store`
--

CREATE TABLE `oc_information_to_store` (
  `information_id` int NOT NULL,
  `store_id` int NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_information_to_store`
--

INSERT INTO `oc_information_to_store` (`information_id`, `store_id`) VALUES
(3, 0),
(4, 0),
(5, 0),
(6, 0);

-- --------------------------------------------------------

--
-- Table structure for table `oc_language`
--

CREATE TABLE `oc_language` (
  `language_id` int NOT NULL,
  `name` varchar(32) NOT NULL,
  `code` varchar(5) NOT NULL,
  `locale` varchar(255) NOT NULL,
  `image` varchar(64) NOT NULL,
  `directory` varchar(32) NOT NULL,
  `sort_order` int NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_language`
--

INSERT INTO `oc_language` (`language_id`, `name`, `code`, `locale`, `image`, `directory`, `sort_order`, `status`) VALUES
(1, 'English', 'en-gb', 'en-US,en_US.UTF-8,en_US,en-gb,english', 'gb.png', 'english', 1, 1),
(2, 'Arabic', 'ar', 'ar', '', '', 2, 0);

-- --------------------------------------------------------

--
-- Table structure for table `oc_layout`
--

CREATE TABLE `oc_layout` (
  `layout_id` int NOT NULL,
  `name` varchar(64) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_layout`
--

INSERT INTO `oc_layout` (`layout_id`, `name`) VALUES
(1, 'Home'),
(2, 'Product'),
(3, 'Category'),
(4, 'Default'),
(5, 'Manufacturer'),
(6, 'Account'),
(7, 'Checkout'),
(8, 'Contact'),
(9, 'Sitemap'),
(10, 'Affiliate'),
(11, 'Information'),
(12, 'Compare'),
(13, 'Search'),
(14, 'Codezeel Blog');

-- --------------------------------------------------------

--
-- Table structure for table `oc_layout_module`
--

CREATE TABLE `oc_layout_module` (
  `layout_module_id` int NOT NULL,
  `layout_id` int NOT NULL,
  `code` varchar(64) NOT NULL,
  `position` varchar(14) NOT NULL,
  `sort_order` int NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_layout_module`
--

INSERT INTO `oc_layout_module` (`layout_module_id`, `layout_id`, `code`, `position`, `sort_order`) VALUES
(4223, 13, 'html.35', 'footerbottom', 0),
(4222, 13, 'html.55', 'footerright', 1),
(4205, 11, 'html.35', 'footerbottom', 0),
(4212, 5, 'html.35', 'footerbottom', 0),
(4184, 14, 'html.35', 'footerbottom', 0),
(4204, 11, 'html.55', 'footerright', 1),
(4170, 3, 'html.35', 'footerbottom', 0),
(4156, 6, 'html.35', 'footerbottom', 0),
(4169, 3, 'html.55', 'footerright', 1),
(4183, 14, 'html.55', 'footerright', 1),
(4182, 14, 'newsletters', 'footerright', 0),
(4191, 12, 'html.35', 'footerbottom', 0),
(4198, 4, 'html.35', 'footerbottom', 0),
(4197, 4, 'html.55', 'footerright', 1),
(4203, 11, 'newsletters', 'footerright', 0),
(4211, 5, 'html.55', 'footerright', 1),
(4221, 13, 'newsletters', 'footerright', 0),
(4190, 12, 'html.55', 'footerright', 1),
(4177, 7, 'html.35', 'footerbottom', 0),
(4176, 7, 'html.55', 'footerright', 1),
(4155, 6, 'html.55', 'footerright', 1),
(4162, 10, 'html.35', 'footerbottom', 0),
(4168, 3, 'newsletters', 'footerright', 0),
(4175, 7, 'newsletters', 'footerright', 0),
(4181, 14, 'html.52', 'footerleft', 0),
(4189, 12, 'newsletters', 'footerright', 0),
(4187, 12, 'special.80', 'column_left', 2),
(4196, 4, 'newsletters', 'footerright', 0),
(4195, 4, 'html.52', 'footerleft', 0),
(4202, 11, 'html.52', 'footerleft', 0),
(4210, 5, 'newsletters', 'footerright', 0),
(4209, 5, 'html.52', 'footerleft', 0),
(4220, 13, 'html.52', 'footerleft', 0),
(4229, 9, 'html.35', 'footerbottom', 0),
(4154, 6, 'newsletters', 'footerright', 0),
(4161, 10, 'html.55', 'footerright', 1),
(4160, 10, 'newsletters', 'footerright', 0),
(4167, 3, 'html.52', 'footerleft', 0),
(4174, 7, 'html.52', 'footerleft', 0),
(4173, 7, 'special.80', 'column_left', 2),
(4179, 14, 'banner.32', 'column_left', 1),
(4188, 12, 'html.52', 'footerleft', 0),
(4020, 8, 'html.35', 'footerbottom', 0),
(4019, 8, 'html.55', 'footerright', 1),
(4194, 4, 'special.80', 'column_left', 2),
(4208, 5, 'special.80', 'column_left', 2),
(4219, 13, 'special.80', 'column_left', 2),
(4227, 9, 'newsletters', 'footerright', 0),
(4228, 9, 'html.55', 'footerright', 1),
(4275, 1, 'newsletters', 'footerright', 0),
(4274, 1, 'html.52', 'footerleft', 0),
(4153, 6, 'html.52', 'footerleft', 0),
(4159, 10, 'html.52', 'footerleft', 0),
(4166, 3, 'special.80', 'column_left', 3),
(4172, 7, 'banner.32', 'column_left', 1),
(4171, 7, 'category', 'column_left', 0),
(4186, 12, 'banner.32', 'column_left', 1),
(4018, 8, 'newsletters', 'footerright', 0),
(4193, 4, 'banner.32', 'column_left', 1),
(4192, 4, 'category', 'column_left', 0),
(4201, 11, 'information', 'column_left', 2),
(4200, 11, 'banner.32', 'column_left', 1),
(4207, 5, 'banner.32', 'column_left', 1),
(4218, 13, 'banner.32', 'column_left', 1),
(4226, 9, 'html.52', 'footerleft', 0),
(4152, 6, 'information', 'column_left', 1),
(4158, 10, 'information', 'column_left', 1),
(4180, 14, 'information', 'column_left', 2),
(4225, 9, 'information', 'column_left', 1),
(4165, 3, 'banner.32', 'column_left', 2),
(4273, 1, 'blogger.43', 'content_bottom', 6),
(4272, 1, 'carousel.29', 'content_bottom', 5),
(4271, 1, 'html.78', 'content_bottom', 4),
(4270, 1, 'html.73', 'content_bottom', 3),
(4216, 2, 'html.35', 'footerbottom', 0),
(4151, 6, 'account', 'column_left', 0),
(4157, 10, 'account', 'column_left', 0),
(4164, 3, 'filter', 'column_left', 1),
(4163, 3, 'category', 'column_left', 0),
(4185, 12, 'category', 'column_left', 0),
(4017, 8, 'html.52', 'footerleft', 0),
(4199, 11, 'category', 'column_left', 0),
(4206, 5, 'category', 'column_left', 0),
(4215, 2, 'html.55', 'footerright', 1),
(4214, 2, 'newsletters', 'footerright', 0),
(4217, 13, 'category', 'column_left', 0),
(4224, 9, 'account', 'column_left', 0),
(4178, 14, 'category', 'column_left', 0),
(4269, 1, 'html.77', 'content_bottom', 2),
(4268, 1, 'html.76', 'content_bottom', 1),
(4213, 2, 'html.52', 'footerleft', 0),
(4267, 1, 'codezeeltabs.79', 'content_bottom', 0),
(4266, 1, 'slideshow.27', 'content_top', 0),
(4276, 1, 'html.55', 'footerright', 1),
(4277, 1, 'html.35', 'footerbottom', 0);

-- --------------------------------------------------------

--
-- Table structure for table `oc_layout_route`
--

CREATE TABLE `oc_layout_route` (
  `layout_route_id` int NOT NULL,
  `layout_id` int NOT NULL,
  `store_id` int NOT NULL,
  `route` varchar(64) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_layout_route`
--

INSERT INTO `oc_layout_route` (`layout_route_id`, `layout_id`, `store_id`, `route`) VALUES
(509, 6, 0, 'account/%'),
(510, 10, 0, 'affiliate/%'),
(511, 3, 0, 'product/category'),
(524, 1, 0, 'common/home'),
(518, 2, 0, 'product/product'),
(516, 11, 0, 'information/information'),
(512, 7, 0, 'checkout/%'),
(493, 8, 0, 'information/contact'),
(520, 9, 0, 'information/sitemap'),
(515, 4, 0, ''),
(517, 5, 0, 'product/manufacturer'),
(514, 12, 0, 'product/compare'),
(519, 13, 0, 'product/search'),
(513, 14, 0, 'information/blogger/blogs');

-- --------------------------------------------------------

--
-- Table structure for table `oc_length_class`
--

CREATE TABLE `oc_length_class` (
  `length_class_id` int NOT NULL,
  `value` decimal(15,8) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_length_class`
--

INSERT INTO `oc_length_class` (`length_class_id`, `value`) VALUES
(1, 1.00000000),
(2, 10.00000000),
(3, 0.39370000);

-- --------------------------------------------------------

--
-- Table structure for table `oc_length_class_description`
--

CREATE TABLE `oc_length_class_description` (
  `length_class_id` int NOT NULL,
  `language_id` int NOT NULL,
  `title` varchar(32) NOT NULL,
  `unit` varchar(4) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_length_class_description`
--

INSERT INTO `oc_length_class_description` (`length_class_id`, `language_id`, `title`, `unit`) VALUES
(1, 1, 'Centimeter', 'cm'),
(2, 1, 'Millimeter', 'mm'),
(3, 1, 'Inch', 'in'),
(1, 2, 'Centimeter', 'cm'),
(2, 2, 'Millimeter', 'mm'),
(3, 2, 'Inch', 'in');

-- --------------------------------------------------------

--
-- Table structure for table `oc_location`
--

CREATE TABLE `oc_location` (
  `location_id` int NOT NULL,
  `name` varchar(32) NOT NULL,
  `address` text NOT NULL,
  `telephone` varchar(32) NOT NULL,
  `fax` varchar(32) NOT NULL,
  `geocode` varchar(32) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `open` text NOT NULL,
  `comment` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `oc_manufacturer`
--

CREATE TABLE `oc_manufacturer` (
  `manufacturer_id` int NOT NULL,
  `name` varchar(64) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `sort_order` int NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_manufacturer`
--

INSERT INTO `oc_manufacturer` (`manufacturer_id`, `name`, `image`, `sort_order`) VALUES
(5, 'HTC', 'catalog/demo/htc_logo.jpg', 0),
(6, 'Palm', 'catalog/demo/palm_logo.jpg', 0),
(7, 'Hewlett-Packard', 'catalog/demo/hp_logo.jpg', 0),
(8, 'WecisMen', 'catalog/demo/apple_logo.jpg', 0),
(9, 'WecisWomen', 'catalog/demo/canon_logo.jpg', 0),
(10, 'Sony', 'catalog/demo/sony_logo.jpg', 0);

-- --------------------------------------------------------

--
-- Table structure for table `oc_manufacturer_to_store`
--

CREATE TABLE `oc_manufacturer_to_store` (
  `manufacturer_id` int NOT NULL,
  `store_id` int NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_manufacturer_to_store`
--

INSERT INTO `oc_manufacturer_to_store` (`manufacturer_id`, `store_id`) VALUES
(5, 0),
(6, 0),
(7, 0),
(8, 0),
(9, 0),
(10, 0);

-- --------------------------------------------------------

--
-- Table structure for table `oc_marketing`
--

CREATE TABLE `oc_marketing` (
  `marketing_id` int NOT NULL,
  `name` varchar(32) NOT NULL,
  `description` text NOT NULL,
  `code` varchar(64) NOT NULL,
  `clicks` int NOT NULL DEFAULT '0',
  `date_added` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `oc_modification`
--

CREATE TABLE `oc_modification` (
  `modification_id` int NOT NULL,
  `extension_install_id` int NOT NULL,
  `name` varchar(64) NOT NULL,
  `code` varchar(64) NOT NULL,
  `author` varchar(64) NOT NULL,
  `version` varchar(32) NOT NULL,
  `link` varchar(255) NOT NULL,
  `xml` mediumtext NOT NULL,
  `status` tinyint(1) NOT NULL,
  `date_added` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `oc_module`
--

CREATE TABLE `oc_module` (
  `module_id` int NOT NULL,
  `name` varchar(64) NOT NULL,
  `code` varchar(32) NOT NULL,
  `setting` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_module`
--

INSERT INTO `oc_module` (`module_id`, `name`, `code`, `setting`) VALUES
(30, 'Category', 'banner', '{\"name\":\"Category\",\"banner_id\":\"6\",\"width\":\"182\",\"height\":\"182\",\"status\":\"1\"}'),
(29, 'Brands Home Page', 'carousel', '{\"name\":\"Brands Home Page\",\"banner_id\":\"8\",\"width\":\"183\",\"height\":\"75\",\"status\":\"1\"}'),
(27, 'Mainbanner Slideshow - Home Page', 'slideshow', '{\"name\":\"Mainbanner Slideshow - Home Page\",\"banner_id\":\"7\",\"width\":\"1800\",\"height\":\"718\",\"status\":\"1\"}'),
(31, 'Banner 1', 'banner', '{\"name\":\"Banner 1\",\"banner_id\":\"6\",\"width\":\"182\",\"height\":\"182\",\"status\":\"1\"}'),
(32, 'Left Banner - Sidebar', 'banner', '{\"name\":\"Left Banner - Sidebar\",\"banner_id\":\"9\",\"width\":\"285\",\"height\":\"320\",\"status\":\"1\"}'),
(52, 'Store Information Block - Footer Left', 'html', '{\"name\":\"Store Information Block - Footer Left\",\"module_description\":{\"1\":{\"title\":\"\",\"description\":\"&lt;div class=&quot;contact-block&quot;&gt;\\r\\n&lt;div class=&quot;footer-logo&quot; width=&quot;200&quot; height=&quot;49&quot;&gt;&lt;\\/div&gt;\\r\\n&lt;div class=&quot;desc&quot;&gt;You can find us or contact us using the s&lt;span style=&quot;font-family: inherit;&quot;&gt;tore information&lt;\\/span&gt;&lt;\\/div&gt;\\r\\n&lt;ul&gt;\\r\\n&lt;li&gt;&lt;i class=&quot;fa fa-map-marker&quot;&gt;&lt;\\/i&gt;&lt;span&gt;&amp;nbsp;Wecis Clothing Store&lt;br&gt;No 9 Adeola Odeku Street, Victoria Island, Lagos, Nigeria&lt;\\/span&gt;&lt;\\/li&gt;\\r\\n&lt;li&gt;&lt;i class=&quot;fa fa-envelope-o&quot;&gt;&lt;\\/i&gt;&lt;a href=&quot;mailto:sales@wecisclothing.com&quot;&gt;&lt;span&gt;sales@wecisclothing.com&lt;\\/span&gt;&lt;\\/a&gt;&lt;\\/li&gt;\\r\\n&lt;\\/ul&gt;\\r\\n&lt;\\/div&gt;\"},\"2\":{\"title\":\"\",\"description\":\"&lt;div class=&quot;contact-block&quot;&gt;\\r\\n&lt;div class=&quot;footer-logo&quot;&gt;&lt;\\/div&gt;&lt;br&gt;&lt;div class=&quot;desc&quot;&gt;You can find us or contact us using the s&lt;span style=&quot;font-family: inherit;&quot;&gt;tore information&lt;\\/span&gt;&lt;\\/div&gt;\\r\\n&lt;ul&gt;&lt;li&gt;&lt;i class=&quot;fa fa-map-marker&quot;&gt;&lt;\\/i&gt;&lt;span&gt;&amp;nbsp;Wecis Clothing Store&lt;br&gt;No 9 Adeola Odeku Street, Victoria Island, Lagos, Nigeria&lt;\\/span&gt;&lt;\\/li&gt;&lt;li&gt;&lt;i class=&quot;fa fa-envelope-o&quot;&gt;&lt;\\/i&gt;&lt;a href=&quot;mailto:sales@wecisclothing.com&quot;&gt;&lt;span&gt;sales@wecisclothing.com&lt;\\/span&gt;&lt;\\/a&gt;&lt;\\/li&gt;&lt;\\/ul&gt;&lt;\\/div&gt;\"}},\"status\":\"1\"}'),
(35, 'Payment Logo Block - Footer Bottom', 'html', '{\"name\":\"Payment Logo Block - Footer Bottom\",\"module_description\":{\"1\":{\"title\":\"\",\"description\":\"&lt;div class=&quot;paiement_logo_block footer-block&quot;&gt;\\r\\n&lt;img src=&quot;image\\/catalog\\/visa.png&quot; alt=&quot;visa&quot; width=&quot;38&quot; height=&quot;23&quot;&gt;\\r\\n&lt;img src=&quot;image\\/catalog\\/master_card.png&quot; alt=&quot;master_card&quot; width=&quot;38&quot; height=&quot;23&quot;&gt;&amp;nbsp;&lt;\\/div&gt;\"},\"2\":{\"title\":\"\",\"description\":\"&lt;div class=&quot;paiement_logo_block footer-block&quot;&gt;\\r\\n&lt;img src=&quot;image\\/catalog\\/visa.png&quot; alt=&quot;visa&quot; width=&quot;38&quot; height=&quot;23&quot;&gt;\\r\\n&lt;img src=&quot;image\\/catalog\\/master_card.png&quot; alt=&quot;master_card&quot; width=&quot;38&quot; height=&quot;23&quot;&gt;&amp;nbsp;&lt;\\/div&gt;\"}},\"status\":\"1\"}'),
(43, 'Blogs - Home page', 'blogger', '{\"module_id\":\"43\",\"name\":\"Blogs - Home page\",\"status\":\"1\",\"width\":\"1085\",\"height\":\"629\",\"limit\":\"6\",\"char_limit\":\"100\",\"comments\":\"1\",\"login\":\"0\",\"auto_approve\":\"0\"}'),
(55, 'Social CMS Block -  Footer Right', 'html', '{\"name\":\"Social CMS Block -  Footer Right\",\"module_description\":{\"1\":{\"title\":\"\",\"description\":\"&lt;div class=&quot;social-block&quot;&gt;\\r\\n    &lt;ul&gt;\\r\\n      &lt;li class=&quot;facebook&quot;&gt;&lt;a href=&quot;#&quot;&gt;&lt;span&gt;Facebook&lt;\\/span&gt;&lt;\\/a&gt;&lt;\\/li&gt;\\r\\n      &lt;li class=&quot;twitter&quot;&gt;&lt;a href=&quot;#&quot;&gt;&lt;span&gt;Twitter&lt;\\/span&gt;&lt;\\/a&gt;&lt;\\/li&gt;\\r\\n      &lt;li class=&quot;youtube&quot;&gt;&lt;a href=&quot;#&quot;&gt;&lt;span&gt;YouTube&lt;\\/span&gt;&lt;\\/a&gt;&lt;\\/li&gt;\\r\\n      \\r\\n      &lt;li class=&quot;instagram&quot;&gt;&lt;a href=&quot;https:\\/\\/www.instagram.com\\/wecisclothing\\/?hl=en&quot; target=&quot;_blank&quot;&gt;&lt;span&gt;Instagram&lt;\\/span&gt;&lt;\\/a&gt;&lt;\\/li&gt;\\r\\n \\t&lt;\\/ul&gt;\\r\\n&lt;\\/div&gt;\"},\"2\":{\"title\":\"\",\"description\":\"&lt;div class=&quot;social-block&quot;&gt;\\r\\n    &lt;ul&gt;\\r\\n      &lt;li class=&quot;facebook&quot;&gt;&lt;a href=&quot;#&quot;&gt;&lt;span&gt;Facebook&lt;\\/span&gt;&lt;\\/a&gt;&lt;\\/li&gt;\\r\\n      &lt;li class=&quot;twitter&quot;&gt;&lt;a href=&quot;#&quot;&gt;&lt;span&gt;Twitter&lt;\\/span&gt;&lt;\\/a&gt;&lt;\\/li&gt;\\r\\n      &lt;li class=&quot;youtube&quot;&gt;&lt;a href=&quot;#&quot;&gt;&lt;span&gt;YouTube&lt;\\/span&gt;&lt;\\/a&gt;&lt;\\/li&gt;\\r\\n      &lt;li class=&quot;pinterest&quot;&gt;&lt;a href=&quot;#&quot;&gt;&lt;span&gt;Pinterest&lt;\\/span&gt;&lt;\\/a&gt;&lt;\\/li&gt;\\r\\n      &lt;li class=&quot;instagram&quot;&gt;&lt;a href=&quot;#&quot;&gt;&lt;span&gt;Instagram&lt;\\/span&gt;&lt;\\/a&gt;&lt;\\/li&gt;\\r\\n \\t&lt;\\/ul&gt;\\r\\n&lt;\\/div&gt;\"}},\"status\":\"1\"}'),
(73, 'Banner CMS Block - Home Page', 'html', '{\"name\":\"Banner CMS Block - Home Page\",\"module_description\":{\"1\":{\"title\":\"\",\"description\":\"&lt;div id=&quot;czbannercmsblock&quot; class=&quot;block czbanners&quot;&gt; \\r\\n&lt;div class=&quot;czbanner_container container&quot;&gt;\\r\\n&lt;div class=&quot;cmsbanners&quot;&gt;\\r\\n&lt;div class=&quot;one-half cmsbanner-part1&quot;&gt;\\r\\n&lt;div class=&quot;cmsbanner-inner&quot;&gt;\\r\\n&lt;div class=&quot;cmsbanner cmsbanner1&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;banner-anchor&quot;&gt;&lt;img src=&quot;image\\/catalog\\/cms-banner-1.jpg&quot; alt=&quot;cms-banner1&quot; class=&quot;banner-image1&quot;&gt;&lt;\\/a&gt;&lt;div class=&quot;cmsbanner-text&quot;&gt;\\r\\n&lt;div class=&quot;main-title&quot;&gt;Custom Men&amp;nbsp;&lt;span&gt;Collection&lt;\\/span&gt;&lt;\\/div&gt;\\r\\n&lt;div class=&quot;shopnow&quot;&gt;&lt;a class=&quot;shop-now&quot; href=&quot;#&quot;&gt;Shop Now&lt;\\/a&gt;&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;div class=&quot;one-half cmsbanner-part2&quot;&gt;\\r\\n&lt;div class=&quot;cmsbanner-inner&quot;&gt;\\r\\n&lt;div class=&quot;cmsbanner cmsbanner2&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;banner-anchor&quot;&gt;&lt;img src=&quot;image\\/catalog\\/cms-banner-2.jpg&quot; alt=&quot;cms-banner2&quot; class=&quot;banner-image2&quot;&gt;&lt;\\/a&gt;&lt;div class=&quot;cmsbanner-text&quot;&gt;\\r\\n&lt;div class=&quot;main-title&quot;&gt;Fantastic African &lt;span&gt;Women Designs&lt;\\/span&gt;&lt;\\/div&gt;\\r\\n&lt;div class=&quot;shopnow&quot;&gt;&lt;a class=&quot;shop-now&quot; href=&quot;#&quot;&gt;Shop Now&lt;\\/a&gt;&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\"},\"2\":{\"title\":\"\",\"description\":\"&lt;div id=&quot;czbannercmsblock&quot; class=&quot;block czbanners&quot;&gt; \\r\\n&lt;div class=&quot;czbanner_container container&quot;&gt;\\r\\n&lt;div class=&quot;cmsbanners&quot;&gt;\\r\\n&lt;div class=&quot;one-half cmsbanner-part1&quot;&gt;\\r\\n&lt;div class=&quot;cmsbanner-inner&quot;&gt;\\r\\n&lt;div class=&quot;cmsbanner cmsbanner1&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;banner-anchor&quot;&gt;&lt;img src=&quot;image\\/catalog\\/cms-banner-1.jpg&quot; alt=&quot;cms-banner1&quot; class=&quot;banner-image1&quot;&gt;&lt;\\/a&gt;\\r\\n&lt;div class=&quot;cmsbanner-text&quot;&gt;\\r\\n&lt;div class=&quot;offer-title&quot;&gt;30% Discount&lt;\\/div&gt;\\r\\n&lt;div class=&quot;main-title&quot;&gt;Custom T-shirts&lt;span&gt;Collection&lt;\\/span&gt;&lt;\\/div&gt;\\r\\n&lt;div class=&quot;shopnow&quot;&gt;&lt;a class=&quot;shop-now&quot; href=&quot;#&quot;&gt;Shop Now&lt;\\/a&gt;&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;div class=&quot;one-half cmsbanner-part2&quot;&gt;\\r\\n&lt;div class=&quot;cmsbanner-inner&quot;&gt;\\r\\n&lt;div class=&quot;cmsbanner cmsbanner2&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;banner-anchor&quot;&gt;&lt;img src=&quot;image\\/catalog\\/cms-banner-2.jpg&quot; alt=&quot;cms-banner2&quot; class=&quot;banner-image2&quot;&gt;&lt;\\/a&gt;\\r\\n&lt;div class=&quot;cmsbanner-text&quot;&gt;\\r\\n&lt;div class=&quot;offer-title&quot;&gt;20% Discount&lt;\\/div&gt;\\r\\n&lt;div class=&quot;main-title&quot;&gt;Graceful European&lt;span&gt;Woman&lt;\\/span&gt;&lt;\\/div&gt;\\r\\n&lt;div class=&quot;shopnow&quot;&gt;&lt;a class=&quot;shop-now&quot; href=&quot;#&quot;&gt;Shop Now&lt;\\/a&gt;&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\"}},\"status\":\"1\"}'),
(77, 'Service CMS Block - Home Page', 'html', '{\"name\":\"Service CMS Block - Home Page\",\"module_description\":{\"1\":{\"title\":\"\",\"description\":\"&lt;div id=&quot;czservicecmsblock&quot;&gt;\\r\\n&lt;div class=&quot;service_container container&quot;&gt;\\r\\n&lt;div class=&quot;service-area&quot;&gt;\\r\\n&lt;div class=&quot;service-fourth service1&quot;&gt;\\r\\n&lt;div class=&quot;service-icon icon1&quot;&gt;&lt;\\/div&gt;\\r\\n&lt;div class=&quot;service-content&quot;&gt;\\r\\n&lt;div class=&quot;service-heading&quot;&gt;Worldwide Shipping&lt;\\/div&gt;\\r\\n&lt;div class=&quot;service-description&quot;&gt;We ship worldwide and ensure you get the services your deserve.&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;div class=&quot;service-fourth service2&quot;&gt;\\r\\n&lt;div class=&quot;service-icon icon2&quot;&gt;&lt;\\/div&gt;\\r\\n&lt;div class=&quot;service-content&quot;&gt;\\r\\n&lt;div class=&quot;service-heading&quot;&gt;Easy 30 Day Returns&lt;\\/div&gt;\\r\\n&lt;div class=&quot;service-description&quot;&gt;If you are not satisfied you can return the items in 30 days.&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;div class=&quot;service-fourth service3&quot;&gt;\\r\\n&lt;div class=&quot;service-icon icon3&quot;&gt;&lt;\\/div&gt;\\r\\n&lt;div class=&quot;service-content&quot;&gt;\\r\\n&lt;div class=&quot;service-heading&quot;&gt;Money Back Guarantee&lt;\\/div&gt;\\r\\n&lt;div class=&quot;service-description&quot;&gt;We promise to refund your money when there are&amp;nbsp; genuine concerns on our deliverables.&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;div class=&quot;service-fourth service4&quot;&gt;\\r\\n&lt;div class=&quot;service-icon icon4&quot;&gt;&lt;\\/div&gt;\\r\\n&lt;div class=&quot;service-content&quot;&gt;\\r\\n&lt;div class=&quot;service-heading&quot;&gt;Easy Online Support&lt;\\/div&gt;Our customer service agents are available to resolve your issues 247&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\"},\"2\":{\"title\":\"\",\"description\":\"&lt;div id=&quot;czservicecmsblock&quot;&gt;\\r\\n&lt;div class=&quot;service_container container&quot;&gt;\\r\\n&lt;div class=&quot;service-area&quot;&gt;\\r\\n&lt;div class=&quot;service-fourth service1&quot;&gt;\\r\\n&lt;div class=&quot;service-icon icon1&quot;&gt;&lt;\\/div&gt;\\r\\n&lt;div class=&quot;service-content&quot;&gt;\\r\\n&lt;div class=&quot;service-heading&quot;&gt;Worldwide Shipping&lt;\\/div&gt;\\r\\n&lt;div class=&quot;service-description&quot;&gt;Lorem Ipsum is simply dummy text book printing typesetting industry.&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;div class=&quot;service-fourth service2&quot;&gt;\\r\\n&lt;div class=&quot;service-icon icon2&quot;&gt;&lt;\\/div&gt;\\r\\n&lt;div class=&quot;service-content&quot;&gt;\\r\\n&lt;div class=&quot;service-heading&quot;&gt;Easy 30 Day Returns&lt;\\/div&gt;\\r\\n&lt;div class=&quot;service-description&quot;&gt;Lorem Ipsum is simply dummy text book printing typesetting industry.&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;div class=&quot;service-fourth service3&quot;&gt;\\r\\n&lt;div class=&quot;service-icon icon3&quot;&gt;&lt;\\/div&gt;\\r\\n&lt;div class=&quot;service-content&quot;&gt;\\r\\n&lt;div class=&quot;service-heading&quot;&gt;Money Back Guarantee&lt;\\/div&gt;\\r\\n&lt;div class=&quot;service-description&quot;&gt;Lorem Ipsum is simply dummy text book printing typesetting industry.&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;div class=&quot;service-fourth service4&quot;&gt;\\r\\n&lt;div class=&quot;service-icon icon4&quot;&gt;&lt;\\/div&gt;\\r\\n&lt;div class=&quot;service-content&quot;&gt;\\r\\n&lt;div class=&quot;service-heading&quot;&gt;Easy Online Support&lt;\\/div&gt;\\r\\n&lt;div class=&quot;service-description&quot;&gt;Lorem Ipsum is simply dummy text book printing typesetting industry.&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\"}},\"status\":\"1\"}'),
(76, 'Sub Banner CMS Block - Home Page ', 'html', '{\"name\":\"Sub Banner CMS Block - Home Page \",\"module_description\":{\"1\":{\"title\":\"\",\"description\":\"&lt;div id=&quot;czsubbannercmsblock&quot; class=&quot;block czsubbanners&quot;&gt; \\r\\n&lt;div class=&quot;czsubbanner_container container&quot;&gt;\\r\\n&lt;div class=&quot;subbanners&quot;&gt;\\r\\n&lt;div class=&quot;one-half subbanner-part1&quot;&gt;\\r\\n&lt;div class=&quot;subbanner-inner&quot;&gt;\\r\\n&lt;div class=&quot;subbanner subbanner1&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;banner-anchor&quot;&gt;&lt;img src=&quot;image\\/catalog\\/sub-banner-1.jpg&quot; alt=&quot;sub-banner1&quot; class=&quot;banner-image1&quot;&gt;&lt;\\/a&gt;&lt;div class=&quot;subbanner-text&quot;&gt;\\r\\n&lt;div class=&quot;main-title&quot;&gt;Leather Saddle&lt;span&gt;Bag Style&lt;\\/span&gt;&lt;\\/div&gt;\\r\\n&lt;div class=&quot;shopnow&quot;&gt;&lt;a class=&quot;shop-now&quot; href=&quot;#&quot;&gt;Shop Now&lt;\\/a&gt;&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;div class=&quot;one-half subbanner-part2&quot;&gt;\\r\\n&lt;div class=&quot;subbanner-inner&quot;&gt;\\r\\n&lt;div class=&quot;subbanner subbanner2&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;banner-anchor&quot;&gt;&lt;img src=&quot;image\\/catalog\\/sub-banner-2.jpg&quot; alt=&quot;sub-banner2&quot; class=&quot;banner-image2&quot;&gt;&lt;\\/a&gt;&lt;div class=&quot;subbanner-text&quot;&gt;\\r\\n&lt;div class=&quot;main-title&quot;&gt;Leather Loafers&lt;span&gt;Shoes&lt;\\/span&gt;&lt;\\/div&gt;\\r\\n&lt;div class=&quot;shopnow&quot;&gt;&lt;a class=&quot;shop-now&quot; href=&quot;#&quot;&gt;Shop Now&lt;\\/a&gt;&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt; \\r\\n&lt;\\/div&gt;\"},\"2\":{\"title\":\"\",\"description\":\"&lt;div id=&quot;czsubbannercmsblock&quot; class=&quot;block czsubbanners&quot;&gt; \\r\\n&lt;div class=&quot;czsubbanner_container container&quot;&gt;\\r\\n&lt;div class=&quot;subbanners&quot;&gt;\\r\\n&lt;div class=&quot;one-half subbanner-part1&quot;&gt;\\r\\n&lt;div class=&quot;subbanner-inner&quot;&gt;\\r\\n&lt;div class=&quot;subbanner subbanner1&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;banner-anchor&quot;&gt;&lt;img src=&quot;image\\/catalog\\/sub-banner-1.jpg&quot; alt=&quot;sub-banner1&quot; class=&quot;banner-image1&quot;&gt;&lt;\\/a&gt;\\r\\n&lt;div class=&quot;subbanner-text&quot;&gt;\\r\\n&lt;div class=&quot;offer-title&quot;&gt;25% Discount&lt;\\/div&gt;\\r\\n&lt;div class=&quot;main-title&quot;&gt;Leather Saddle&lt;span&gt;Bag Style&lt;\\/span&gt;&lt;\\/div&gt;\\r\\n&lt;div class=&quot;shopnow&quot;&gt;&lt;a class=&quot;shop-now&quot; href=&quot;#&quot;&gt;Shop Now&lt;\\/a&gt;&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;div class=&quot;one-half subbanner-part2&quot;&gt;\\r\\n&lt;div class=&quot;subbanner-inner&quot;&gt;\\r\\n&lt;div class=&quot;subbanner subbanner2&quot;&gt;&lt;a href=&quot;#&quot; class=&quot;banner-anchor&quot;&gt;&lt;img src=&quot;image\\/catalog\\/sub-banner-2.jpg&quot; alt=&quot;sub-banner2&quot; class=&quot;banner-image2&quot;&gt;&lt;\\/a&gt;\\r\\n&lt;div class=&quot;subbanner-text&quot;&gt;\\r\\n&lt;div class=&quot;offer-title&quot;&gt;30% Discount&lt;\\/div&gt;\\r\\n&lt;div class=&quot;main-title&quot;&gt;Leather Loafers&lt;span&gt;Shoes&lt;\\/span&gt;&lt;\\/div&gt;\\r\\n&lt;div class=&quot;shopnow&quot;&gt;&lt;a class=&quot;shop-now&quot; href=&quot;#&quot;&gt;Shop Now&lt;\\/a&gt;&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt; \\r\\n&lt;\\/div&gt;\"}},\"status\":\"1\"}'),
(78, 'Testimonial CMS Block - Home Page', 'html', '{\"name\":\"Testimonial CMS Block - Home Page\",\"module_description\":{\"1\":{\"title\":\"\",\"description\":\"&lt;div id=&quot;cztestimonialcmsblock&quot; class=&quot;testimonial&quot;&gt;\\r\\n&lt;div class=&quot;testimonial_container container&quot;&gt;\\r\\n&lt;div class=&quot;testimonial_wrapper&quot;&gt;\\r\\n&lt;div class=&quot;testimonial-area&quot;&gt;\\r\\n&lt;div class=&quot;customNavigation&quot;&gt;&lt;a class=&quot;btn prev cztestimonial_prev&quot;&gt;prev&lt;\\/a&gt; &lt;a class=&quot;btn next cztestimonial_next&quot;&gt;next&lt;\\/a&gt;&lt;\\/div&gt;\\r\\n&lt;ul id=&quot;testimonial-carousel&quot; class=&quot;owl-carousel&quot;&gt;\\r\\n&lt;li class=&quot;slider-item&quot;&gt;\\r\\n&lt;div class=&quot;testimonial-item&quot;&gt;\\r\\n&lt;div class=&quot;item cms_face&quot;&gt;\\r\\n&lt;div class=&quot;product_inner_cms&quot;&gt;\\r\\n&lt;div class=&quot;testimonial-image&quot;&gt;\\r\\n&lt;div class=&quot;quote_img&quot;&gt;&lt;\\/div&gt;&lt;img src=&quot;image\\/catalog\\/user1.jpg&quot; alt=&quot;testimonial-user1&quot; title=&quot;testimonial-user1&quot; width=&quot;110&quot; height=&quot;110&quot;&gt;&lt;\\/div&gt;\\r\\n&lt;div class=&quot;title&quot;&gt;\\r\\n&lt;div class=&quot;name&quot;&gt;&lt;a href=&quot;#&quot;&gt;Kunle Ajadi&lt;\\/a&gt;&lt;\\/div&gt;\\r\\n&lt;span class=&quot;subheading&quot;&gt;(CEO Wecis Clothing)&lt;\\/span&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;div class=&quot;des&quot;&gt;\\r\\n&quot;&lt;strong data-start=&quot;90&quot; data-end=&quot;109&quot;&gt;Wecis Clothings&lt;\\/strong&gt; is a contemporary African fashion brand for men and women\\u2014where culture meets modern elegance. We craft bold, premium pieces that celebrate African identity and global style. With &lt;strong data-start=&quot;290&quot; data-end=&quot;312&quot;&gt;worldwide delivery&lt;\\/strong&gt;, Wecis lets you wear Africa with pride, wherever you are&quot;&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;&lt;\\/li&gt;\\r\\n&lt;!--li class=&quot;slider-item&quot;&gt;\\r\\n&lt;div class=&quot;testimonial-item&quot;&gt;\\r\\n&lt;div class=&quot;item cms_face&quot;&gt;\\r\\n&lt;div class=&quot;product_inner_cms&quot;&gt;\\r\\n&lt;div class=&quot;testimonial-image&quot;&gt;\\r\\n&lt;div class=&quot;quote_img&quot;&gt;&lt;\\/div&gt;&lt;img src=&quot;image\\/catalog\\/user2.jpg&quot; alt=&quot;testimonial-user2&quot; title=&quot;testimonial-user2&quot; width=&quot;110&quot; height=&quot;110&quot;&gt;&lt;\\/div&gt;\\r\\n&lt;div class=&quot;title&quot;&gt;\\r\\n&lt;div class=&quot;name&quot;&gt;&lt;a href=&quot;#&quot;&gt;jecob goeckno&lt;\\/a&gt;&lt;\\/div&gt;\\r\\n&lt;span class=&quot;subheading&quot;&gt;(Website Design)&lt;\\/span&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;div class=&quot;des&quot;&gt;\\r\\n&quot;It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using&quot;&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;&lt;\\/li&gt;\\r\\n&lt;li class=&quot;slider-item&quot;&gt;\\r\\n&lt;div class=&quot;testimonial-item&quot;&gt;\\r\\n&lt;div class=&quot;item cms_face&quot;&gt;\\r\\n&lt;div class=&quot;product_inner_cms&quot;&gt;\\r\\n&lt;div class=&quot;testimonial-image&quot;&gt;\\r\\n&lt;div class=&quot;quote_img&quot;&gt;&lt;\\/div&gt;&lt;img src=&quot;image\\/catalog\\/user3.jpg&quot; alt=&quot;testimonial-user3&quot; title=&quot;testimonial-user3&quot; width=&quot;110&quot; height=&quot;110&quot;&gt;&lt;\\/div&gt;\\r\\n&lt;div class=&quot;title&quot;&gt;\\r\\n&lt;div class=&quot;name&quot;&gt;&lt;a href=&quot;#&quot;&gt;luies charls&lt;\\/a&gt;&lt;\\/div&gt;\\r\\n&lt;span class=&quot;subheading&quot;&gt;(Web Development)&lt;\\/span&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;div class=&quot;des&quot;&gt;\\r\\n&quot;There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text making this the first true generator on the Internet&quot;&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;&lt;\\/li--&gt;\\r\\n&lt;\\/ul&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\"},\"2\":{\"title\":\"\",\"description\":\"&lt;div id=&quot;cztestimonialcmsblock&quot; class=&quot;testimonial&quot;&gt;\\r\\n&lt;div class=&quot;testimonial_container container&quot;&gt;\\r\\n&lt;div class=&quot;testimonial_wrapper&quot;&gt;\\r\\n&lt;div class=&quot;testimonial-area&quot;&gt;\\r\\n&lt;div class=&quot;customNavigation&quot;&gt;&lt;a class=&quot;btn prev cztestimonial_prev&quot;&gt;prev&lt;\\/a&gt; &lt;a class=&quot;btn next cztestimonial_next&quot;&gt;next&lt;\\/a&gt;&lt;\\/div&gt;\\r\\n&lt;ul id=&quot;testimonial-carousel&quot; class=&quot;owl-carousel&quot;&gt;\\r\\n&lt;li class=&quot;slider-item&quot;&gt;\\r\\n&lt;div class=&quot;testimonial-item&quot;&gt;\\r\\n&lt;div class=&quot;item cms_face&quot;&gt;\\r\\n&lt;div class=&quot;product_inner_cms&quot;&gt;\\r\\n&lt;div class=&quot;testimonial-image&quot;&gt;\\r\\n&lt;div class=&quot;quote_img&quot;&gt;&lt;\\/div&gt;&lt;img src=&quot;image\\/catalog\\/user1.jpg&quot; alt=&quot;testimonial-user1&quot; title=&quot;testimonial-user1&quot; width=&quot;110&quot; height=&quot;110&quot;&gt;&lt;\\/div&gt;\\r\\n&lt;div class=&quot;title&quot;&gt;\\r\\n&lt;div class=&quot;name&quot;&gt;&lt;a href=&quot;#&quot;&gt;Mark Jofferson&lt;\\/a&gt;&lt;\\/div&gt;\\r\\n&lt;span class=&quot;subheading&quot;&gt;(Company CEO)&lt;\\/span&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;div class=&quot;des&quot;&gt;\\r\\n&quot;Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged&quot;&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;&lt;\\/li&gt;\\r\\n&lt;li class=&quot;slider-item&quot;&gt;\\r\\n&lt;div class=&quot;testimonial-item&quot;&gt;\\r\\n&lt;div class=&quot;item cms_face&quot;&gt;\\r\\n&lt;div class=&quot;product_inner_cms&quot;&gt;\\r\\n&lt;div class=&quot;testimonial-image&quot;&gt;\\r\\n&lt;div class=&quot;quote_img&quot;&gt;&lt;\\/div&gt;&lt;img src=&quot;image\\/catalog\\/user2.jpg&quot; alt=&quot;testimonial-user2&quot; title=&quot;testimonial-user2&quot; width=&quot;110&quot; height=&quot;110&quot;&gt;&lt;\\/div&gt;\\r\\n&lt;div class=&quot;title&quot;&gt;\\r\\n&lt;div class=&quot;name&quot;&gt;&lt;a href=&quot;#&quot;&gt;jecob goeckno&lt;\\/a&gt;&lt;\\/div&gt;\\r\\n&lt;span class=&quot;subheading&quot;&gt;(Website Design)&lt;\\/span&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;div class=&quot;des&quot;&gt;\\r\\n&quot;It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using&quot;&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;&lt;\\/li&gt;\\r\\n&lt;li class=&quot;slider-item&quot;&gt;\\r\\n&lt;div class=&quot;testimonial-item&quot;&gt;\\r\\n&lt;div class=&quot;item cms_face&quot;&gt;\\r\\n&lt;div class=&quot;product_inner_cms&quot;&gt;\\r\\n&lt;div class=&quot;testimonial-image&quot;&gt;\\r\\n&lt;div class=&quot;quote_img&quot;&gt;&lt;\\/div&gt;&lt;img src=&quot;image\\/catalog\\/user3.jpg&quot; alt=&quot;testimonial-user3&quot; title=&quot;testimonial-user3&quot; width=&quot;110&quot; height=&quot;110&quot;&gt;&lt;\\/div&gt;\\r\\n&lt;div class=&quot;title&quot;&gt;\\r\\n&lt;div class=&quot;name&quot;&gt;&lt;a href=&quot;#&quot;&gt;luies charls&lt;\\/a&gt;&lt;\\/div&gt;\\r\\n&lt;span class=&quot;subheading&quot;&gt;(Web Development)&lt;\\/span&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;div class=&quot;des&quot;&gt;\\r\\n&quot;There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text making this the first true generator on the Internet&quot;&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;&lt;\\/li&gt;\\r\\n&lt;\\/ul&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\\r\\n&lt;\\/div&gt;\"}},\"status\":\"1\"}'),
(79, 'Product Tab - Home page', 'codezeeltabs', '{\"name\":\"Product Tab - Home page\",\"limit\":\"18\",\"width\":\"275\",\"height\":\"350\",\"status\":\"1\"}'),
(80, 'Special Products - Sidebar', 'special', '{\"name\":\"Special Products - Sidebar\",\"limit\":\"3\",\"width\":\"85\",\"height\":\"108\",\"status\":\"1\"}');

-- --------------------------------------------------------

--
-- Table structure for table `oc_newsletter`
--

CREATE TABLE `oc_newsletter` (
  `news_id` int NOT NULL,
  `news_email` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_newsletter`
--

INSERT INTO `oc_newsletter` (`news_id`, `news_email`) VALUES
(1, ''),
(2, 'emmanuelolowuabiola@gmail.com'),
(3, 'isholaoluwatomiwa434@gmail.com'),
(4, ') AND EXTRACTVALUE(1428,CONCAT(0x5c,0x7170707671,(SELECT (ELT(1428=1428,1))),0x716b6b7a71))-- WGJQ');

-- --------------------------------------------------------

--
-- Table structure for table `oc_option`
--

CREATE TABLE `oc_option` (
  `option_id` int NOT NULL,
  `type` varchar(32) NOT NULL,
  `sort_order` int NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_option`
--

INSERT INTO `oc_option` (`option_id`, `type`, `sort_order`) VALUES
(1, 'radio', 1),
(2, 'checkbox', 2),
(4, 'text', 3),
(5, 'select', 4),
(6, 'textarea', 5),
(7, 'file', 6),
(8, 'date', 7),
(9, 'time', 8),
(10, 'datetime', 9),
(11, 'select', 10),
(12, 'date', 11);

-- --------------------------------------------------------

--
-- Table structure for table `oc_option_description`
--

CREATE TABLE `oc_option_description` (
  `option_id` int NOT NULL,
  `language_id` int NOT NULL,
  `name` varchar(128) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_option_description`
--

INSERT INTO `oc_option_description` (`option_id`, `language_id`, `name`) VALUES
(1, 1, 'Radio'),
(2, 1, 'Checkbox'),
(4, 1, 'Text'),
(6, 1, 'Textarea'),
(8, 1, 'Date'),
(7, 1, 'File'),
(5, 1, 'Select'),
(9, 1, 'Time'),
(10, 1, 'Date &amp; Time'),
(12, 1, 'Delivery Date'),
(11, 1, 'Size'),
(1, 2, 'Radio'),
(2, 2, 'Checkbox'),
(4, 2, 'Text'),
(6, 2, 'Textarea'),
(8, 2, 'Date'),
(7, 2, 'File'),
(5, 2, 'Select'),
(9, 2, 'Time'),
(10, 2, 'Date &amp; Time'),
(12, 2, 'Delivery Date'),
(11, 2, 'Size');

-- --------------------------------------------------------

--
-- Table structure for table `oc_option_value`
--

CREATE TABLE `oc_option_value` (
  `option_value_id` int NOT NULL,
  `option_id` int NOT NULL,
  `image` varchar(255) NOT NULL,
  `sort_order` int NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_option_value`
--

INSERT INTO `oc_option_value` (`option_value_id`, `option_id`, `image`, `sort_order`) VALUES
(43, 1, '', 3),
(32, 1, '', 1),
(45, 2, '', 4),
(44, 2, '', 3),
(42, 5, '', 4),
(41, 5, '', 3),
(39, 5, '', 1),
(40, 5, '', 2),
(31, 1, '', 2),
(23, 2, '', 1),
(24, 2, '', 2),
(46, 11, '', 1),
(47, 11, '', 2),
(48, 11, '', 3);

-- --------------------------------------------------------

--
-- Table structure for table `oc_option_value_description`
--

CREATE TABLE `oc_option_value_description` (
  `option_value_id` int NOT NULL,
  `language_id` int NOT NULL,
  `option_id` int NOT NULL,
  `name` varchar(128) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_option_value_description`
--

INSERT INTO `oc_option_value_description` (`option_value_id`, `language_id`, `option_id`, `name`) VALUES
(43, 1, 1, 'Large'),
(32, 1, 1, 'Small'),
(45, 1, 2, 'Checkbox 4'),
(44, 1, 2, 'Checkbox 3'),
(31, 1, 1, 'Medium'),
(42, 1, 5, 'Yellow'),
(41, 1, 5, 'Green'),
(39, 1, 5, 'Red'),
(40, 1, 5, 'Blue'),
(23, 1, 2, 'Checkbox 1'),
(24, 1, 2, 'Checkbox 2'),
(48, 1, 11, 'Large'),
(47, 1, 11, 'Medium'),
(46, 1, 11, 'Small'),
(43, 2, 1, 'Large'),
(32, 2, 1, 'Small'),
(45, 2, 2, 'Checkbox 4'),
(44, 2, 2, 'Checkbox 3'),
(31, 2, 1, 'Medium'),
(42, 2, 5, 'Yellow'),
(41, 2, 5, 'Green'),
(39, 2, 5, 'Red'),
(40, 2, 5, 'Blue'),
(23, 2, 2, 'Checkbox 1'),
(24, 2, 2, 'Checkbox 2'),
(48, 2, 11, 'Large'),
(47, 2, 11, 'Medium'),
(46, 2, 11, 'Small');

-- --------------------------------------------------------

--
-- Table structure for table `oc_order`
--

CREATE TABLE `oc_order` (
  `order_id` int NOT NULL,
  `invoice_no` int NOT NULL DEFAULT '0',
  `invoice_prefix` varchar(26) NOT NULL,
  `store_id` int NOT NULL DEFAULT '0',
  `store_name` varchar(64) NOT NULL,
  `store_url` varchar(255) NOT NULL,
  `customer_id` int NOT NULL DEFAULT '0',
  `customer_group_id` int NOT NULL DEFAULT '0',
  `firstname` varchar(32) NOT NULL,
  `lastname` varchar(32) NOT NULL,
  `email` varchar(96) NOT NULL,
  `telephone` varchar(32) NOT NULL,
  `fax` varchar(32) NOT NULL,
  `custom_field` text NOT NULL,
  `payment_firstname` varchar(32) NOT NULL,
  `payment_lastname` varchar(32) NOT NULL,
  `payment_company` varchar(60) NOT NULL,
  `payment_address_1` varchar(128) NOT NULL,
  `payment_address_2` varchar(128) NOT NULL,
  `payment_city` varchar(128) NOT NULL,
  `payment_postcode` varchar(10) NOT NULL,
  `payment_country` varchar(128) NOT NULL,
  `payment_country_id` int NOT NULL,
  `payment_zone` varchar(128) NOT NULL,
  `payment_zone_id` int NOT NULL,
  `payment_address_format` text NOT NULL,
  `payment_custom_field` text NOT NULL,
  `payment_method` varchar(128) NOT NULL,
  `payment_code` varchar(128) NOT NULL,
  `shipping_firstname` varchar(32) NOT NULL,
  `shipping_lastname` varchar(32) NOT NULL,
  `shipping_company` varchar(40) NOT NULL,
  `shipping_address_1` varchar(128) NOT NULL,
  `shipping_address_2` varchar(128) NOT NULL,
  `shipping_city` varchar(128) NOT NULL,
  `shipping_postcode` varchar(10) NOT NULL,
  `shipping_country` varchar(128) NOT NULL,
  `shipping_country_id` int NOT NULL,
  `shipping_zone` varchar(128) NOT NULL,
  `shipping_zone_id` int NOT NULL,
  `shipping_address_format` text NOT NULL,
  `shipping_custom_field` text NOT NULL,
  `shipping_method` varchar(128) NOT NULL,
  `shipping_code` varchar(128) NOT NULL,
  `comment` text NOT NULL,
  `total` decimal(15,4) NOT NULL DEFAULT '0.0000',
  `order_status_id` int NOT NULL DEFAULT '0',
  `affiliate_id` int NOT NULL,
  `commission` decimal(15,4) NOT NULL,
  `marketing_id` int NOT NULL,
  `tracking` varchar(64) NOT NULL,
  `language_id` int NOT NULL,
  `currency_id` int NOT NULL,
  `currency_code` varchar(3) NOT NULL,
  `currency_value` decimal(15,8) NOT NULL DEFAULT '1.00000000',
  `ip` varchar(40) NOT NULL,
  `forwarded_ip` varchar(40) NOT NULL,
  `user_agent` varchar(255) NOT NULL,
  `accept_language` varchar(255) NOT NULL,
  `date_added` datetime NOT NULL,
  `date_modified` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_order`
--

INSERT INTO `oc_order` (`order_id`, `invoice_no`, `invoice_prefix`, `store_id`, `store_name`, `store_url`, `customer_id`, `customer_group_id`, `firstname`, `lastname`, `email`, `telephone`, `fax`, `custom_field`, `payment_firstname`, `payment_lastname`, `payment_company`, `payment_address_1`, `payment_address_2`, `payment_city`, `payment_postcode`, `payment_country`, `payment_country_id`, `payment_zone`, `payment_zone_id`, `payment_address_format`, `payment_custom_field`, `payment_method`, `payment_code`, `shipping_firstname`, `shipping_lastname`, `shipping_company`, `shipping_address_1`, `shipping_address_2`, `shipping_city`, `shipping_postcode`, `shipping_country`, `shipping_country_id`, `shipping_zone`, `shipping_zone_id`, `shipping_address_format`, `shipping_custom_field`, `shipping_method`, `shipping_code`, `comment`, `total`, `order_status_id`, `affiliate_id`, `commission`, `marketing_id`, `tracking`, `language_id`, `currency_id`, `currency_code`, `currency_value`, `ip`, `forwarded_ip`, `user_agent`, `accept_language`, `date_added`, `date_modified`) VALUES
(1, 0, 'INV-2018-00', 0, 'Your Store', 'https://localhost.com/opencart/OPC01/OPC010007/', 1, 1, 'admin', 'admin', 'admin@localhost.com', '1234567891', '', '', 'admin', 'admin', '', 'mumbai', '', 'mumbai', '123456', 'United Kingdom', 222, 'Angus', 3516, '', '[]', 'Cash On Delivery', 'cod', 'admin', 'admin', '', 'mumbai', '', 'mumbai', '123456', 'United Kingdom', 222, 'Angus', 3516, '', '[]', 'Flat Shipping Rate', 'flat.flat', '', 1089.5880, 1, 0, 0.0000, 0, '', 1, 2, 'USD', 1.00000000, '219.91.237.34', '', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.167 Safari/537.36', 'en-US,en;q=0.9', '2018-03-01 05:37:17', '2018-03-01 05:37:20'),
(2, 0, 'INV-2018-00', 0, 'Your Store', 'https://localhost.com/opencart/OPC01/OPC010008/', 2, 1, 'admin', 'admin', 'admin@gmail.com', '1234567891', '', '', 'admin', 'admin', '', 'mumbai', '', 'mumbai', '123456', 'United Kingdom', 222, 'Angus', 3516, '', '[]', 'Cash On Delivery', 'cod', 'admin', 'admin', '', 'mumbai', '', 'mumbai', '12345', 'Turkmenistan', 216, 'Balkan Welayaty', 3397, '', '[]', 'Flat Shipping Rate', 'flat.flat', '', 90.0000, 1, 0, 0.0000, 0, '', 1, 3, 'EUR', 0.78460002, '123.201.227.244', '', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.186 Safari/537.36', 'en-US,en;q=0.9', '2018-03-15 09:40:01', '2018-03-15 09:40:03'),
(3, 0, 'INV-2018-00', 0, 'Your Store', 'http://192.168.0.150/user2/opencart/OPC010016/', 3, 1, 'admin', 'admin', 'admin1@localhost.com', '01234567890', '', '', 'admin', 'admin', 'GHI', 'B-12 udhna', '', 'surat', '12345', 'United Kingdom', 222, 'Bristol', 3522, '', '[]', 'Cash On Delivery', 'cod', 'admin', 'admin', 'GHI', 'B-12 udhna', '', 'surat', '12345', 'United Kingdom', 222, 'Bristol', 3522, '', '[]', 'Flat Shipping Rate', 'flat.flat', '', 112.0000, 1, 0, 0.0000, 0, '', 1, 2, 'USD', 1.00000000, '192.168.0.152', '', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.56 Safari/537.36', 'en-US,en;q=0.9', '2018-05-29 16:28:17', '2018-05-29 16:28:27'),
(4, 0, 'INV-2019-00', 0, 'Lawsuit - Suit Store', 'https://demo.codezeel.com/opencart/OPC04/OPC040098/', 0, 1, 'admin', 'admin', 'demo@codezeel.com', '09874563210', '', '[]', 'admin', 'admin', 'abc', 'surat', 'mubai', 'surat', '12345', 'United States', 223, 'California', 3624, '{firstname} {lastname}\r\n{company}\r\n{address_1}\r\n{address_2}\r\n{city}, {zone} {postcode}\r\n{country}', '[]', 'Cash On Delivery', 'cod', 'admin', 'admin', 'abc', 'surat', 'mubai', 'surat', '12345', 'United States', 223, 'California', 3624, '{firstname} {lastname}\r\n{company}\r\n{address_1}\r\n{address_2}\r\n{city}, {zone} {postcode}\r\n{country}', '[]', 'Flat Shipping Rate', 'flat.flat', '', 84.9900, 1, 0, 0.0000, 0, '', 1, 2, 'USD', 1.00000000, '116.73.194.54', '', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.121 Safari/537.36', 'en-US,en;q=0.9', '2019-03-15 11:10:01', '2019-03-15 11:10:22'),
(5, 0, 'INV-2019-00', 0, 'Stanley - Tools Store', 'http://192.168.0.150/user5/opencart/OPC050122/', 3, 1, 'admin', 'admin', 'admin1@localhost.com', '01234567890', '', '', 'admin', 'admin', 'GHI', 'B-12 udhna', '', 'surat', '12345', 'United Kingdom', 222, 'Bristol', 3522, '', '[]', 'Cash On Delivery', 'cod', 'admin', 'admin', 'GHI', 'B-12 udhna', '', 'surat', '12345', 'United Kingdom', 222, 'Bristol', 3522, '', '[]', 'Flat Shipping Rate', 'flat.flat', '', 118.0000, 1, 0, 0.0000, 0, '', 1, 2, 'USD', 1.00000000, '192.168.0.155', '', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.157 Safari/537.36', 'en-US,en;q=0.9', '2019-05-22 16:38:30', '2019-05-22 16:38:33'),
(6, 0, 'INV-2019-00', 0, 'Bobcat - Pets Store', 'http://192.168.0.150/user2/opencart/OPC070152/', 1, 1, 'admin', 'admin', 'admin@localhost.com', '1234567891', '', '', 'admin', 'admin', '', 'mumbai', '', 'mumbai', '123456', 'United Kingdom', 222, 'Angus', 3516, '', '[]', 'Cash On Delivery', 'cod', 'admin', 'admin', '', 'mumbai', '', 'mumbai', '123456', 'United Kingdom', 222, 'Angus', 3516, '', '[]', 'Flat Shipping Rate', 'flat.flat', '', 413.2000, 1, 0, 0.0000, 0, '', 1, 2, 'USD', 1.00000000, '192.168.0.152', '', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36', 'en-US,en;q=0.9', '2019-10-03 12:36:43', '2019-10-03 12:36:49'),
(7, 0, 'INV-2021-00', 0, 'Lazy - Lingerie Store', 'http://192.168.0.150/user8/opencart/OPC090211/OPC2/', 3, 1, 'admin', 'admin', 'admin1@localhost.com', '01234567890', '', '', 'admin', 'admin', 'GHI', 'B-12 udhna', '', 'surat', '12345', 'United Kingdom', 222, 'Bristol', 3522, '', '[]', 'Cash On Delivery', 'cod', 'admin', 'admin', 'GHI', 'B-12 udhna', '', 'surat', '12345', 'United Kingdom', 222, 'Bristol', 3522, '', '[]', 'Flat Shipping Rate', 'flat.flat', '', 1313.9520, 1, 0, 0.0000, 0, '', 1, 2, 'USD', 1.00000000, '192.168.0.151', '', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36', 'en-US,en;q=0.9,ru;q=0.8,de;q=0.7', '2021-01-23 15:42:04', '2021-01-23 15:42:10'),
(8, 0, 'INV-2021-00', 0, 'Lazy - Lingerie Store', 'http://192.168.0.150/user7/opencart/OPC090211/OPC1/', 10, 1, 'admin123', 'codezeel22', 'admin123@localhost.com', '123456789', '', '', 'admin', 'codezeel', '', 'Mumbai', '', 'Mumbai', '12345', 'Germany', 81, 'Berlin', 1256, '{company}\r\n{firstname} {lastname}\r\n{address_1}\r\n{address_2}\r\n{postcode} {city}\r\n{country}', '[]', 'Cash On Delivery', 'cod', 'admin', 'codezeel', '', 'Mumbai', '', 'Mumbai', '12345', 'Germany', 81, 'Berlin', 1256, '{company}\r\n{firstname} {lastname}\r\n{address_1}\r\n{address_2}\r\n{postcode} {city}\r\n{country}', '[]', 'Flat Shipping Rate', 'flat.flat', '', 105.0000, 1, 0, 0.0000, 0, '', 1, 2, 'USD', 1.00000000, '192.168.0.151', '', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.104 Safari/537.36', 'en-US,en;q=0.9,ru;q=0.8,de;q=0.7', '2021-02-03 11:39:31', '2021-02-03 11:39:35'),
(9, 0, 'INV-2025-00', 0, 'Wecis Clothing ', 'https://www.oowilliamsdigital.com/dev/', 0, 1, 'Sola', 'Salami', 'solasalami@gmail.com', '6394718490', '', '[]', 'Sola', 'Salami', '', '309-522 Cornish Road', 'New Cairo', 'Saskatoon', 'S7T0Z4', 'Canada', 38, 'Alberta', 602, '', '[]', 'Cash On Delivery', 'cod', 'Sola', 'Salami', '', '309-522 Cornish Road', 'New Cairo', 'Saskatoon', 'S7T0Z4', 'Canada', 38, 'Alberta', 602, '', '[]', 'Flat Shipping Rate', 'flat.flat', 'ddddgggg', 210.0000, 0, 0, 0.0000, 0, '', 1, 2, 'USD', 1.00000000, '174.2.2.79', '', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36', 'en-US,en;q=0.9', '2025-04-13 14:32:06', '2025-04-13 14:32:06'),
(10, 0, 'INV-2025-00', 0, 'Wecis Clothing ', 'https://www.oowilliamsdigital.com/dev/', 0, 1, 'Sola', 'Salami', 'sola@yopmail.com', '+2348025046135', '', '[]', 'Sola', 'Salami', 'Lekki', 'Lekki', 'Lekki', 'Lagos', '23401', 'Nigeria', 156, 'Lagos', 2412, '', '[]', 'Cash On Delivery', 'cod', 'Sola', 'Salami', 'Lekki', 'Lekki', 'Lekki', 'Lagos', '23401', 'Nigeria', 156, 'Lagos', 2412, '', '[]', 'Flat Shipping Rate', 'flat.flat', 'Testing', 105.0000, 1, 0, 0.0000, 0, '', 1, 2, 'USD', 1.00000000, '174.2.2.79', '', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:137.0) Gecko/20100101 Firefox/137.0', 'en-GB,en;q=0.5', '2025-04-17 19:14:25', '2025-04-17 19:14:29'),
(11, 0, 'INV-2025-00', 0, 'Wecis Clothing ', 'https://www.oowilliamsdigital.com/dev/', 11, 1, 'Sola', 'Salami', 'sola@yopmail.com', '+2348025046135', '', '', 'Sola', 'Salami', 'TBG', 'Lekki', 'Lekki', 'Lagos', '23401', 'Nigeria', 156, 'Lagos', 2412, '', '[]', 'Cash On Delivery', 'cod', 'Sola', 'Salami', 'TBG', 'Lekki', 'Lekki', 'Lagos', '23401', 'Nigeria', 156, 'Lagos', 2412, '', '[]', 'Flat Shipping Rate', 'flat.flat', 'okay', 115.0000, 1, 0, 0.0000, 0, '', 1, 2, 'USD', 1.00000000, '174.2.2.79', '', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:137.0) Gecko/20100101 Firefox/137.0', 'en-GB,en;q=0.5', '2025-04-17 19:18:49', '2025-04-17 19:18:51'),
(12, 0, 'INV-2025-00', 0, 'Wecis Clothing ', 'https://www.oowilliamsdigital.com/dev/', 11, 1, 'Sola', 'Salami', 'sola@yopmail.com', '+2348025046135', '', '', 'Sola', 'Salami', 'TBG', 'Lekki', 'Lekki', 'Lagos', '23401', 'Nigeria', 156, 'Lagos', 2412, '', '[]', 'Paystack', 'paystack', '', '', '', '', '', '', '', '', 0, '', 0, '', '[]', '', '', 'Thanks', 128.0000, 7, 0, 0.0000, 0, '', 1, 4, 'NGN', 1.00000000, '174.2.2.79', '', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:137.0) Gecko/20100101 Firefox/137.0', 'en-GB,en;q=0.5', '2025-04-18 05:07:16', '2025-04-18 05:07:34'),
(13, 0, 'INV-2025-00', 0, 'Wecis Clothing ', 'https://www.oowilliamsdigital.com/dev/', 11, 1, 'Sola', 'Salami', 'sola@yopmail.com', '+2348025046135', '', '', 'Sola', 'Salami', 'TBG', 'Lekki', 'Lekki', 'Lagos', '23401', 'Nigeria', 156, 'Lagos', 2412, '', '[]', 'Paystack', 'paystack', '', '', '', '', '', '', '', '', 0, '', 0, '', '[]', '', '', 'Thanks', 128.0000, 7, 0, 0.0000, 0, '', 1, 4, 'NGN', 1.00000000, '174.2.2.79', '', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:137.0) Gecko/20100101 Firefox/137.0', 'en-GB,en;q=0.5', '2025-04-18 05:07:55', '2025-04-18 05:08:19'),
(14, 0, 'INV-2025-00', 0, 'Wecis Clothing ', 'https://www.oowilliamsdigital.com/dev/', 11, 1, 'Sola', 'Salami', 'sola@yopmail.com', '+2348025046135', '', '', 'Sola', 'Salami', 'TBG', 'Lekki', 'Lekki', 'Lagos', '23401', 'Nigeria', 156, 'Lagos', 2412, '', '[]', 'Paystack', 'paystack', '', '', '', '', '', '', '', '', 0, '', 0, '', '[]', '', '', 'Thanks', 128.0000, 7, 0, 0.0000, 0, '', 1, 4, 'NGN', 1.00000000, '174.2.2.79', '', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:137.0) Gecko/20100101 Firefox/137.0', 'en-GB,en;q=0.5', '2025-04-18 05:09:35', '2025-04-18 05:09:48'),
(15, 0, 'INV-2025-00', 0, 'Wecis Clothing ', 'https://www.oowilliamsdigital.com/dev/', 11, 1, 'Sola', 'Salami', 'sola@yopmail.com', '+2348025046135', '', '', 'Sola', 'Salami', 'TBG', 'Lekki', 'Lekki', 'Lagos', '23401', 'Nigeria', 156, 'Lagos', 2412, '', '[]', 'Paystack', 'paystack', '', '', '', '', '', '', '', '', 0, '', 0, '', '[]', '', '', 'Thanksddd', 128.0000, 7, 0, 0.0000, 0, '', 1, 4, 'NGN', 1.00000000, '174.2.2.79', '', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:137.0) Gecko/20100101 Firefox/137.0', 'en-GB,en;q=0.5', '2025-04-18 05:10:06', '2025-04-18 05:10:16'),
(16, 0, 'INV-2025-00', 0, 'Wecis Clothing ', 'https://www.oowilliamsdigital.com/dev/', 0, 1, 'wiliams', 'Williams', 'info@decilot.com', '08033423464', '', '[]', 'wiliams', 'Williams', 'decilot limited', 'Central Midrandf', '', 'Midrand', '1865', 'Nigeria', 156, 'Abuja Federal Capital Territory', 2389, '', '[]', 'Paystack', 'paystack', 'wiliams', 'Williams', 'decilot limited', 'Central Midrandf', '', 'Midrand', '1865', 'Nigeria', 156, 'Abuja Federal Capital Territory', 2389, '', '[]', 'Flat Shipping Rate', 'flat.flat', 'Agreed', 125.7750, 7, 0, 0.0000, 0, '', 1, 4, 'NGN', 1.00000000, '160.19.36.25', '', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.3.1 Safari/605.1.15', 'en-GB,en;q=0.9', '2025-04-19 20:57:39', '2025-04-19 20:58:08'),
(17, 0, 'INV-2025-00', 0, 'Wecis Clothing ', 'https://www.oowilliamsdigital.com/dev/', 0, 1, 'wiliams', 'Williams', 'info@decilot.com', '08033423464', '', '[]', 'wiliams', 'Williams', 'decilot limited', 'Central Midrandf', '', 'Midrand', '1865', 'Nigeria', 156, 'Abuja Federal Capital Territory', 2389, '', '[]', 'Paystack', 'paystack', 'wiliams', 'Williams', 'decilot limited', 'Central Midrandf', '', 'Midrand', '1865', 'Nigeria', 156, 'Abuja Federal Capital Territory', 2389, '', '[]', 'Flat Shipping Rate', 'flat.flat', 'Agreed', 125.7750, 7, 0, 0.0000, 0, '', 1, 4, 'NGN', 1.00000000, '160.19.36.25', '', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.3.1 Safari/605.1.15', 'en-GB,en;q=0.9', '2025-04-19 20:58:36', '2025-04-19 20:58:47'),
(18, 0, 'INV-2025-00', 0, 'Wecis Clothing ', 'https://www.oowilliamsdigital.com/dev/', 0, 1, 'Wiiliams', 'Willia', 'info@decilot.com', '040595000', '', '[]', 'Wiiliams', 'Willia', 'Decilot', 'Midrand Central', '', 'Midrand', '1685', 'Nigeria', 156, 'Abuja Federal Capital Territory', 2389, '', '[]', 'Paystack', 'paystack', 'Wiiliams', 'Willia', 'Decilot', 'Midrand Central', '', 'Midrand', '1685', 'Nigeria', 156, 'Abuja Federal Capital Territory', 2389, '', '[]', 'Flat Shipping Rate', 'flat.flat', 'Agreed', 96.7500, 7, 0, 0.0000, 0, '', 1, 2, 'USD', 1500.00000000, '160.19.36.25', '', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.3.1 Safari/605.1.15', 'en-GB,en;q=0.9', '2025-04-19 21:32:18', '2025-04-19 21:32:32'),
(19, 0, 'INV-2025-00', 0, 'Wecis Clothing ', 'https://www.oowilliamsdigital.com/dev/', 0, 1, 'Willaim', 'Willaims', 'info@decilot.com', '01234567', '', '[]', 'Willaim', 'Willaims', 'Decilot Limited', 'Grand Central', '', 'Midrand', '1685', 'Nigeria', 156, 'Abia', 2388, '', '[]', 'Paystack', 'paystack', 'Willaim', 'Willaims', 'Decilot Limited', 'Grand Central', '', 'Midrand', '1685', 'Nigeria', 156, 'Abia', 2388, '', '[]', 'Flat Shipping Rate', 'flat.flat', 'Agreed', 135.4500, 7, 0, 0.0000, 0, '', 1, 4, 'NGN', 1.00000000, '160.19.36.25', '', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.3.1 Safari/605.1.15', 'en-GB,en;q=0.9', '2025-04-19 21:36:28', '2025-04-19 21:36:47'),
(20, 0, 'INV-2025-00', 0, 'Wecis Clothing ', 'https://www.oowilliamsdigital.com/dev/', 0, 1, 'Williams', 'Williams', 'info@decilot.com', '0927738383', '', '[]', 'Williams', 'Williams', '', 'Grand Central', '', 'Midrand', '1685', 'Nigeria', 156, 'Adamawa', 2390, '', '[]', 'Paystack', 'paystack', 'Williams', 'Williams', '', 'Grand Central', '', 'Midrand', '1685', 'Nigeria', 156, 'Adamawa', 2390, '', '[]', 'Flat Shipping Rate', 'flat.flat', '', 130.0750, 7, 0, 0.0000, 0, '', 1, 4, 'NGN', 1.00000000, '160.19.36.25', '', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.3.1 Safari/605.1.15', 'en-GB,en;q=0.9', '2025-04-19 21:46:18', '2025-04-19 21:46:28'),
(21, 0, 'INV-2025-00', 0, 'Wecis Clothing ', 'https://www.oowilliamsdigital.com/dev/', 0, 1, 'Williams', 'Williams', 'info@decilot.com', '0927738383', '', '[]', 'Williams', 'Williams', '', 'Grand Central', '', 'Midrand', '1685', 'Nigeria', 156, 'Adamawa', 2390, '', '[]', 'Paystack', 'paystack', 'Williams', 'Williams', '', 'Grand Central', '', 'Midrand', '1685', 'Nigeria', 156, 'Adamawa', 2390, '', '[]', 'Flat Shipping Rate', 'flat.flat', '', 130.0750, 7, 0, 0.0000, 0, '', 1, 4, 'NGN', 1.00000000, '160.19.36.25', '', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.3.1 Safari/605.1.15', 'en-GB,en;q=0.9', '2025-04-19 21:46:56', '2025-04-19 21:47:04'),
(22, 0, 'INV-2025-00', 0, 'Wecis Clothing ', 'https://www.oowilliamsdigital.com/dev/', 0, 1, 'David', 'David', 'info@decilot.com', '094763454374', '', '[]', 'David', 'David', 'Decilot', 'Grand Central', '', 'Midrand', '1685', 'Nigeria', 156, 'Abuja Federal Capital Territory', 2389, '', '[]', 'Paystack', 'paystack', 'David', 'David', 'Decilot', 'Grand Central', '', 'Midrand', '1685', 'Nigeria', 156, 'Abuja Federal Capital Territory', 2389, '', '[]', 'Flat Shipping Rate', 'flat.flat', '', 96.7500, 7, 0, 0.0000, 0, '', 1, 4, 'NGN', 1.00000000, '160.19.36.25', '', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.3.1 Safari/605.1.15', 'en-GB,en;q=0.9', '2025-04-19 22:08:03', '2025-04-19 22:08:20'),
(23, 0, 'INV-2025-00', 0, 'Wecis Clothing ', 'https://www.oowilliamsdigital.com/dev/', 0, 1, 'Food', 'Williams', 'info@decilot.com', '0948574747', '', '[]', 'Food', 'Williams', 'Decilot', 'Grand Central', '', 'Midrand', '1685', 'Nigeria', 156, 'Abuja Federal Capital Territory', 2389, '', '[]', 'Paystack', 'paystack', 'Food', 'Williams', 'Decilot', 'Grand Central', '', 'Midrand', '1685', 'Nigeria', 156, 'Abuja Federal Capital Territory', 2389, '', '[]', 'Flat Shipping Rate', 'flat.flat', '', 125.7750, 0, 0, 0.0000, 0, '', 1, 4, 'NGN', 1.00000000, '160.19.36.25', '', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.3.1 Safari/605.1.15', 'en-GB,en;q=0.9', '2025-04-19 23:25:47', '2025-04-19 23:25:47'),
(24, 0, 'INV-2025-00', 0, 'Wecis Clothing ', 'https://www.oowilliamsdigital.com/dev/', 0, 1, 'Williams', 'Willy', 'info@gmail.com', '04948474773', '', '[]', 'Williams', 'Willy', 'Decilot', 'Grand Central', '', 'Midrand', '1685', 'Nigeria', 156, 'Ogun', 2415, '', '[]', 'Paystack', 'paystack', 'Williams', 'Willy', 'Decilot', 'Grand Central', '', 'Midrand', '1685', 'Nigeria', 156, 'Ogun', 2415, '', '[]', 'Flat Shipping Rate', 'flat.flat', '', 131.1500, 1, 0, 0.0000, 0, '', 1, 4, 'NGN', 1.00000000, '160.19.36.25', '', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.3.1 Safari/605.1.15', 'en-GB,en;q=0.9', '2025-04-19 23:33:32', '2025-04-19 23:33:49'),
(25, 0, 'INV-2025-00', 0, 'Wecis Clothing ', 'https://www.oowilliamsdigital.com/dev/', 0, 1, 'ddd', 'dd', 's@yopmail.com', '111111111111', '', '[]', 'ddd', 'dd', '', 'rrrr', 'rrrr', 'rrrr', '444444', 'Nigeria', 156, 'Delta', 2398, '', '[]', 'Paystack', 'paystack', 'ddd', 'dd', '', 'rrrr', 'rrrr', 'rrrr', '444444', 'Nigeria', 156, 'Delta', 2398, '', '[]', 'Flat Shipping Rate', 'flat.flat', '', 112.8750, 1, 0, 0.0000, 0, '', 1, 4, 'NGN', 1.00000000, '174.2.2.79', '', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36', 'en-US,en;q=0.9', '2025-04-20 03:36:09', '2025-04-20 03:36:22'),
(26, 0, 'INV-WECIS-2025-00', 0, 'Wecis Clothing ', 'https://www.wecisclothing.com/', 12, 1, 'Sola', 'S', 'solas@yopmail.com', '08025046135', '', '', 'Sola', 'S', 'TCB', 'NNNN', '', 'ddd', 'dfdd', 'Nigeria', 156, 'Abia', 2388, '', '[]', 'Paystack', 'paystack', 'Sola', 'S', 'TCB', 'NNNN', '', 'ddd', 'dfdd', 'Nigeria', 156, 'Abia', 2388, '', '[]', 'Flat Shipping Rate', 'flat.flat', 'eeeeeeee', 112.8750, 1, 0, 0.0000, 0, '', 1, 4, 'NGN', 1.00000000, '102.44.195.237', '', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'en-US,en;q=0.9', '2025-05-01 18:39:26', '2025-05-01 18:39:43'),
(27, 0, 'INV-WECIS-2025-00', 0, 'Wecis Clothing ', 'https://www.wecisclothing.com/', 12, 1, 'Sola', 'S', 'solas@yopmail.com', '08025046135', '', '', 'Sola', 'S', 'TCB', 'NNNN', '', 'ddd', 'dfdd', 'Nigeria', 156, 'Abia', 2388, '', '[]', 'Paystack', 'paystack', '', '', '', '', '', '', '', '', 0, '', 0, '', '[]', '', '', 'okay', 128.0000, 1, 0, 0.0000, 0, '', 1, 4, 'NGN', 1.00000000, '102.44.195.237', '', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'en-US,en;q=0.9', '2025-05-04 16:00:35', '2025-05-04 16:00:47'),
(28, 0, 'INV-WECIS-2025-00', 0, 'Wecis Clothing ', 'https://www.wecisclothing.com/', 12, 1, 'Sola', 'S', 'solas@yopmail.com', '08025046135', '', '[]', 'Sola', 'S', 'TCB', 'NNNN', '', 'ddd', 'dfdd', 'Nigeria', 156, 'Abia', 2388, '', '[]', 'Paystack', 'paystack', '', '', '', '', '', '', '', '', 0, '', 0, '', '[]', '', '', '', 128.0000, 2, 0, 0.0000, 0, '', 1, 4, 'NGN', 1.00000000, '102.44.195.237', '', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'en-US,en;q=0.9', '2025-05-04 18:34:26', '2025-05-04 18:37:48'),
(29, 0, 'INV-WECIS-2025-00', 0, 'Wecis Clothing ', 'https://www.wecisclothing.com/', 0, 1, 'Yewande', 'Ariyo', 'yewariyo@gmail.com', '7015013168', '', '[]', 'Yewande', 'Ariyo', '', '33,muri busari close,off adeniyi Jones ', '', 'Ikeja', '', 'Nigeria', 156, 'Lagos', 2412, '', '[]', 'Paystack', 'paystack', 'Yewande', 'Ariyo', '', '33,muri busari close,off adeniyi Jones ', '', 'Ikeja', '', 'Nigeria', 156, 'Lagos', 2412, '', '[]', 'Flat Shipping Rate', 'flat.flat', '', 112.8643, 1, 0, 0.0000, 0, '', 1, 4, 'NGN', 1.00000000, '102.88.114.174', '', 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_1_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.1.1 Mobile/15E148 Safari/604.1', 'en-GB,en;q=0.9', '2025-09-03 09:32:05', '2025-09-03 09:33:41'),
(30, 0, 'INV-WECIS-2025-00', 0, 'Wecis Clothing ', 'https://www.wecisclothing.com/', 0, 1, 'ddd', 'ddd', 's@y.com', '1111111111', '', '[]', 'ddd', 'ddd', 'ddd', 'ddd', '', 'dd', 'dddd', 'Nigeria', 156, 'Yobe', 2423, '', '[]', 'Paystack', 'paystack', '', '', '', '', '', '', '', '', 0, '', 0, '', '[]', '', '', '', 150000.0000, 7, 0, 0.0000, 0, '', 1, 4, 'NGN', 1.00000000, '41.238.159.150', '', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'en-US,en;q=0.9', '2025-10-05 15:59:01', '2025-10-05 15:59:33');

-- --------------------------------------------------------

--
-- Table structure for table `oc_order_history`
--

CREATE TABLE `oc_order_history` (
  `order_history_id` int NOT NULL,
  `order_id` int NOT NULL,
  `order_status_id` int NOT NULL,
  `notify` tinyint(1) NOT NULL DEFAULT '0',
  `comment` text NOT NULL,
  `date_added` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_order_history`
--

INSERT INTO `oc_order_history` (`order_history_id`, `order_id`, `order_status_id`, `notify`, `comment`, `date_added`) VALUES
(1, 1, 1, 0, '', '2018-03-01 05:37:20'),
(2, 2, 1, 0, '', '2018-03-15 09:40:03'),
(3, 3, 1, 0, '', '2018-05-29 16:28:21'),
(4, 3, 1, 0, '', '2018-05-29 16:28:26'),
(5, 3, 1, 0, '', '2018-05-29 16:28:27'),
(6, 4, 1, 0, '', '2019-03-15 11:10:22'),
(7, 5, 1, 0, '', '2019-05-22 16:38:33'),
(8, 6, 1, 0, '', '2019-10-03 12:36:46'),
(9, 6, 1, 0, '', '2019-10-03 12:36:49'),
(10, 7, 1, 0, '', '2021-01-23 15:42:10'),
(11, 8, 1, 0, '', '2021-02-03 11:39:35'),
(12, 10, 1, 0, '', '2025-04-17 19:14:29'),
(13, 11, 1, 0, '', '2025-04-17 19:18:52'),
(14, 12, 7, 0, '', '2025-04-18 05:07:34'),
(15, 13, 7, 0, '', '2025-04-18 05:08:19'),
(16, 14, 7, 0, '', '2025-04-18 05:09:48'),
(17, 15, 7, 0, '', '2025-04-18 05:10:16'),
(18, 16, 7, 0, '', '2025-04-19 20:58:08'),
(19, 17, 7, 0, '', '2025-04-19 20:58:47'),
(20, 18, 7, 0, '', '2025-04-19 21:32:32'),
(21, 19, 7, 0, '', '2025-04-19 21:36:47'),
(22, 20, 7, 0, '', '2025-04-19 21:46:28'),
(23, 21, 7, 0, '', '2025-04-19 21:47:04'),
(24, 22, 7, 0, '', '2025-04-19 22:08:20'),
(25, 24, 1, 0, '', '2025-04-19 23:33:49'),
(26, 25, 1, 0, '', '2025-04-20 03:36:22'),
(27, 26, 1, 0, '', '2025-05-01 18:39:43'),
(28, 27, 1, 0, '', '2025-05-04 16:00:47'),
(29, 28, 1, 0, '', '2025-05-04 18:34:57'),
(32, 29, 1, 0, '', '2025-09-03 09:33:41'),
(31, 28, 2, 0, '', '2025-05-04 18:37:48'),
(33, 30, 7, 0, '', '2025-10-05 15:59:33');

-- --------------------------------------------------------

--
-- Table structure for table `oc_order_option`
--

CREATE TABLE `oc_order_option` (
  `order_option_id` int NOT NULL,
  `order_id` int NOT NULL,
  `order_product_id` int NOT NULL,
  `product_option_id` int NOT NULL,
  `product_option_value_id` int NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL,
  `value` text NOT NULL,
  `type` varchar(32) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_order_option`
--

INSERT INTO `oc_order_option` (`order_option_id`, `order_id`, `order_product_id`, `product_option_id`, `product_option_value_id`, `name`, `value`, `type`) VALUES
(1, 1, 10, 226, 15, 'Select', 'Red', 'select'),
(2, 2, 11, 225, 0, 'Delivery Date', '2011-04-22', 'date'),
(3, 3, 12, 225, 0, 'Delivery Date', '2011-04-22', 'date'),
(4, 7, 21, 224, 13, 'Size', 'Medium', 'select'),
(5, 8, 22, 228, 17, 'Checkbox', 'Checkbox 1', 'checkbox'),
(6, 8, 22, 227, 0, 'Text', 'test', 'text'),
(7, 8, 22, 225, 0, 'Delivery Date', '2011-04-22', 'date'),
(8, 9, 23, 228, 17, 'Checkbox', 'Checkbox 1', 'checkbox'),
(9, 9, 23, 228, 18, 'Checkbox', 'Checkbox 2', 'checkbox'),
(10, 9, 23, 228, 19, 'Checkbox', 'Checkbox 3', 'checkbox'),
(11, 9, 23, 228, 20, 'Checkbox', 'Checkbox 4', 'checkbox'),
(12, 9, 23, 227, 0, 'Text', 'test', 'text'),
(13, 9, 23, 225, 0, 'Delivery Date', '2011-04-22', 'date'),
(14, 10, 24, 228, 17, 'Checkbox', 'Checkbox 1', 'checkbox'),
(15, 10, 24, 227, 0, 'Text', 'New', 'text'),
(16, 10, 24, 225, 0, 'Delivery Date', '2024-04-20', 'date'),
(17, 11, 25, 228, 18, 'Checkbox', 'Checkbox 2', 'checkbox'),
(18, 11, 25, 227, 0, 'Text', 'test', 'text'),
(19, 11, 25, 225, 0, 'Delivery Date', '2025-04-22', 'date'),
(20, 12, 26, 283, 0, 'Textarea', 'fff', 'textarea'),
(21, 12, 26, 281, 0, 'Time', '16:22', 'time'),
(22, 12, 26, 282, 0, 'Date &amp; Time', '2021-01-10 16:22', 'datetime'),
(23, 13, 27, 283, 0, 'Textarea', 'fff', 'textarea'),
(24, 13, 27, 281, 0, 'Time', '16:22', 'time'),
(25, 13, 27, 282, 0, 'Date &amp; Time', '2021-01-10 16:22', 'datetime'),
(26, 14, 28, 283, 0, 'Textarea', 'fff', 'textarea'),
(27, 14, 28, 281, 0, 'Time', '16:22', 'time'),
(28, 14, 28, 282, 0, 'Date &amp; Time', '2021-01-10 16:22', 'datetime'),
(29, 15, 29, 283, 0, 'Textarea', 'fff', 'textarea'),
(30, 15, 29, 281, 0, 'Time', '16:22', 'time'),
(31, 15, 29, 282, 0, 'Date &amp; Time', '2021-01-10 16:22', 'datetime'),
(32, 16, 30, 266, 0, 'Text', 'test', 'text'),
(33, 16, 30, 264, 39, 'Select', 'Blue', 'select'),
(34, 16, 30, 265, 43, 'Size', 'Medium', 'select'),
(35, 17, 31, 266, 0, 'Text', 'test', 'text'),
(36, 17, 31, 264, 39, 'Select', 'Blue', 'select'),
(37, 17, 31, 265, 43, 'Size', 'Medium', 'select'),
(38, 18, 32, 270, 0, 'Text', 'test', 'text'),
(39, 18, 32, 226, 15, 'Select', 'Red', 'select'),
(40, 18, 32, 271, 0, 'Textarea', 'ghj', 'textarea'),
(41, 19, 33, 266, 0, 'Text', 'test', 'text'),
(42, 19, 33, 264, 40, 'Select', 'Red', 'select'),
(43, 19, 33, 265, 44, 'Size', 'Small', 'select'),
(44, 20, 34, 266, 0, 'Text', 'test', 'text'),
(45, 20, 34, 264, 40, 'Select', 'Red', 'select'),
(46, 20, 34, 265, 43, 'Size', 'Medium', 'select'),
(47, 21, 35, 266, 0, 'Text', 'test', 'text'),
(48, 21, 35, 264, 40, 'Select', 'Red', 'select'),
(49, 21, 35, 265, 43, 'Size', 'Medium', 'select'),
(50, 22, 36, 270, 0, 'Text', 'test', 'text'),
(51, 22, 36, 226, 16, 'Select', 'Blue', 'select'),
(52, 22, 36, 271, 0, 'Textarea', 'klhhkjh', 'textarea'),
(53, 23, 37, 266, 0, 'Text', 'test', 'text'),
(54, 23, 37, 264, 39, 'Select', 'Blue', 'select'),
(55, 23, 37, 265, 43, 'Size', 'Medium', 'select'),
(56, 24, 38, 266, 0, 'Text', 'test', 'text'),
(57, 24, 38, 264, 39, 'Select', 'Blue', 'select'),
(58, 24, 38, 265, 44, 'Size', 'Small', 'select'),
(59, 25, 39, 228, 17, 'Checkbox', 'Checkbox 1', 'checkbox'),
(60, 25, 39, 227, 0, 'Text', 'test', 'text'),
(61, 25, 39, 225, 0, 'Delivery Date', '2011-04-22', 'date'),
(62, 26, 40, 228, 17, 'Checkbox', 'Checkbox 1', 'checkbox'),
(63, 26, 40, 227, 0, 'Text', 'test', 'text'),
(64, 26, 40, 225, 0, 'Delivery Date', '2025-04-22', 'date'),
(65, 27, 41, 283, 0, 'Textarea', 'okay', 'textarea'),
(66, 27, 41, 281, 0, 'Time', '16:22', 'time'),
(67, 27, 41, 282, 0, 'Date &amp; Time', '2021-01-10 16:22', 'datetime'),
(73, 28, 43, 282, 0, 'Date &amp; Time', '2021-01-10 16:22', 'datetime'),
(72, 28, 43, 281, 0, 'Time', '16:22', 'time'),
(71, 28, 43, 283, 0, 'Textarea', 'jsjsjsd', 'textarea'),
(74, 29, 44, 232, 26, 'Radio', 'Medium', 'radio'),
(75, 29, 44, 233, 0, 'Text', 'Size 8', 'text'),
(76, 29, 44, 234, 0, 'Date', '2025-09-03', 'date'),
(77, 30, 45, 283, 0, 'Textarea', 'jddjdj', 'textarea'),
(78, 30, 45, 281, 0, 'Time', '16:22', 'time'),
(79, 30, 45, 282, 0, 'Date &amp; Time', '2021-01-10 16:22', 'datetime');

-- --------------------------------------------------------

--
-- Table structure for table `oc_order_product`
--

CREATE TABLE `oc_order_product` (
  `order_product_id` int NOT NULL,
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `model` varchar(64) NOT NULL,
  `quantity` int NOT NULL,
  `price` decimal(15,4) NOT NULL DEFAULT '0.0000',
  `total` decimal(15,4) NOT NULL DEFAULT '0.0000',
  `tax` decimal(15,4) NOT NULL DEFAULT '0.0000',
  `reward` int NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_order_product`
--

INSERT INTO `oc_order_product` (`order_product_id`, `order_id`, `product_id`, `name`, `model`, `quantity`, `price`, `total`, `tax`, `reward`) VALUES
(1, 1, 45, 'Neque Porro Quisquam', 'Product 18', 1, 118.0000, 118.0000, 0.0000, 800),
(2, 1, 43, 'Aliquam Quaerat', 'Product 16', 1, 89.0000, 89.0000, 19.8000, 600),
(3, 1, 48, 'Voluptates Repudiandae', 'product 20', 1, 100.0000, 100.0000, 22.0000, 0),
(4, 1, 41, 'Nostrud Exercitation', 'Product 14', 1, 64.0000, 64.0000, 14.8000, 0),
(5, 1, 40, 'Praesentium Voluptatum', 'product 11', 1, 105.0000, 105.0000, 23.0000, 0),
(6, 1, 32, 'Reprehenderit Aliquam', 'Product 5', 1, 90.0000, 90.0000, 20.0000, 0),
(7, 1, 29, 'Laborum Eveniet', 'Product 2', 1, 79.9900, 79.9900, 17.9980, 0),
(8, 1, 28, 'Voluptas Assumenda', 'Product 1', 1, 100.0000, 100.0000, 22.0000, 400),
(9, 1, 31, 'Laudant Doloremque', 'Product 4', 1, 75.0000, 75.0000, 17.0000, 0),
(10, 1, 30, 'Exercitat Virginia', 'Product 3', 1, 85.0000, 85.0000, 19.0000, 200),
(11, 2, 47, 'Accusantium Doloremque', 'Product 21', 1, 85.0000, 85.0000, 0.0000, 300),
(12, 3, 47, 'Accusantium Doloremque', 'Product 21', 1, 85.0000, 85.0000, 19.0000, 300),
(13, 4, 29, 'Laborum Eveniet', 'Product 2', 1, 79.9900, 79.9900, 0.0000, 0),
(14, 5, 32, 'Reprehenderit Aliquam', 'Product 5', 1, 90.0000, 90.0000, 20.0000, 0),
(15, 6, 41, 'Nostrud Exercitation', 'Product 14', 1, 64.0000, 64.0000, 14.8000, 0),
(16, 6, 43, 'Aliquam Quaerat', 'Product 16', 3, 89.0000, 267.0000, 19.8000, 1800),
(17, 7, 29, 'Laborum Eveniet', 'Product 2', 4, 79.9900, 319.9600, 17.9980, 0),
(18, 7, 36, 'Necessitatibus', 'Product 9', 2, 98.0000, 196.0000, 21.6000, 0),
(19, 7, 40, 'Praesentium Voluptatum', 'product 11', 1, 105.0000, 105.0000, 23.0000, 0),
(20, 7, 43, 'Aliquam Quaerat', 'Product 16', 1, 89.0000, 89.0000, 19.8000, 600),
(21, 7, 35, 'Commodi Consequatur', 'Product 8', 3, 120.0000, 360.0000, 26.0000, 0),
(22, 8, 47, 'Accusantium Doloremque', 'Product 21', 1, 100.0000, 100.0000, 0.0000, 300),
(23, 9, 47, 'Accusantium Doloremque', 'Product 21', 1, 205.0000, 205.0000, 0.0000, 300),
(24, 10, 47, 'Accusantium Doloremque', 'Product 21', 1, 100.0000, 100.0000, 0.0000, 300),
(25, 11, 47, 'Accusantium Doloremque', 'Product 21', 1, 110.0000, 110.0000, 0.0000, 300),
(26, 12, 52, 'Denounce Praesentium', 'Product 25', 1, 128.0000, 128.0000, 0.0000, 0),
(27, 13, 52, 'Denounce Praesentium', 'Product 25', 1, 128.0000, 128.0000, 0.0000, 0),
(28, 14, 52, 'Denounce Praesentium', 'Product 25', 1, 128.0000, 128.0000, 0.0000, 0),
(29, 15, 52, 'Denounce Praesentium', 'Product 25', 1, 128.0000, 128.0000, 0.0000, 0),
(30, 16, 40, 'Praesentium Voluptatum', 'product 11', 1, 112.0000, 112.0000, 8.4000, 0),
(31, 17, 40, 'Praesentium Voluptatum', 'product 11', 1, 112.0000, 112.0000, 8.4000, 0),
(32, 18, 30, 'Exercitat Virginia Voluptates', 'Product 3', 1, 85.0000, 85.0000, 6.3750, 200),
(33, 19, 40, 'Praesentium Voluptatum', 'product 11', 1, 121.0000, 121.0000, 9.0750, 0),
(34, 20, 40, 'Praesentium Voluptatum', 'product 11', 1, 116.0000, 116.0000, 8.7000, 0),
(35, 21, 40, 'Praesentium Voluptatum', 'product 11', 1, 116.0000, 116.0000, 8.7000, 0),
(36, 22, 30, 'Exercitat Virginia Voluptates', 'Product 3', 1, 85.0000, 85.0000, 6.3750, 200),
(37, 23, 40, 'Praesentium Voluptatum', 'product 11', 1, 112.0000, 112.0000, 8.4000, 0),
(38, 24, 40, 'Praesentium Voluptatum', 'product 11', 1, 117.0000, 117.0000, 8.7750, 0),
(39, 25, 47, 'Accusantium Doloremque', 'Product 21', 1, 100.0000, 100.0000, 7.5000, 300),
(40, 26, 47, 'Accusantium Doloremque', 'Product 21', 1, 100.0000, 100.0000, 7.5000, 300),
(41, 27, 52, 'Denounce Praesentium', 'Product 25', 1, 128.0000, 128.0000, 0.0000, 0),
(43, 28, 52, 'Denounce Praesentium', 'Product 25', 1, 128.0000, 128.0000, 0.0000, 0),
(44, 29, 29, 'Laborum Porro Eveniet', 'Product 2', 1, 99.9900, 99.9900, 7.4993, 0),
(45, 30, 52, 'Denounce Praesentium', 'Product 25', 1, 150000.0000, 150000.0000, 0.0000, 0);

-- --------------------------------------------------------

--
-- Table structure for table `oc_order_recurring`
--

CREATE TABLE `oc_order_recurring` (
  `order_recurring_id` int NOT NULL,
  `order_id` int NOT NULL,
  `reference` varchar(255) NOT NULL,
  `product_id` int NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `product_quantity` int NOT NULL,
  `recurring_id` int NOT NULL,
  `recurring_name` varchar(255) NOT NULL,
  `recurring_description` varchar(255) NOT NULL,
  `recurring_frequency` varchar(25) NOT NULL,
  `recurring_cycle` smallint NOT NULL,
  `recurring_duration` smallint NOT NULL,
  `recurring_price` decimal(10,4) NOT NULL,
  `trial` tinyint(1) NOT NULL,
  `trial_frequency` varchar(25) NOT NULL,
  `trial_cycle` smallint NOT NULL,
  `trial_duration` smallint NOT NULL,
  `trial_price` decimal(10,4) NOT NULL,
  `status` tinyint NOT NULL,
  `date_added` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `oc_order_recurring_transaction`
--

CREATE TABLE `oc_order_recurring_transaction` (
  `order_recurring_transaction_id` int NOT NULL,
  `order_recurring_id` int NOT NULL,
  `reference` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `amount` decimal(10,4) NOT NULL,
  `date_added` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `oc_order_shipment`
--

CREATE TABLE `oc_order_shipment` (
  `order_shipment_id` int NOT NULL,
  `order_id` int NOT NULL,
  `date_added` datetime NOT NULL,
  `shipping_courier_id` varchar(255) NOT NULL DEFAULT '',
  `tracking_number` varchar(255) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `oc_order_status`
--

CREATE TABLE `oc_order_status` (
  `order_status_id` int NOT NULL,
  `language_id` int NOT NULL,
  `name` varchar(32) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_order_status`
--

INSERT INTO `oc_order_status` (`order_status_id`, `language_id`, `name`) VALUES
(2, 1, 'Processing'),
(3, 1, 'Shipped'),
(7, 1, 'Canceled'),
(5, 1, 'Complete'),
(8, 1, 'Denied'),
(9, 1, 'Canceled Reversal'),
(10, 2, 'Failed'),
(11, 1, 'Refunded'),
(12, 1, 'Reversed'),
(13, 1, 'Chargeback'),
(1, 1, 'Pending'),
(16, 1, 'Voided'),
(15, 1, 'Processed'),
(14, 1, 'Expired'),
(2, 2, 'Processing'),
(3, 2, 'Shipped'),
(7, 2, 'Canceled'),
(5, 2, 'Complete'),
(8, 2, 'Denied'),
(9, 2, 'Canceled Reversal'),
(10, 1, 'Failed'),
(11, 2, 'Refunded'),
(12, 2, 'Reversed'),
(13, 2, 'Chargeback'),
(1, 2, 'Pending'),
(16, 2, 'Voided'),
(15, 2, 'Processed'),
(14, 2, 'Expired');

-- --------------------------------------------------------

--
-- Table structure for table `oc_order_total`
--

CREATE TABLE `oc_order_total` (
  `order_total_id` int NOT NULL,
  `order_id` int NOT NULL,
  `code` varchar(32) NOT NULL,
  `title` varchar(255) NOT NULL,
  `value` decimal(15,4) NOT NULL DEFAULT '0.0000',
  `sort_order` int NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_order_total`
--

INSERT INTO `oc_order_total` (`order_total_id`, `order_id`, `code`, `title`, `value`, `sort_order`) VALUES
(1, 1, 'sub_total', 'Sub-Total', 905.9900, 1),
(2, 1, 'shipping', 'Flat Shipping Rate', 5.0000, 3),
(3, 1, 'tax', 'Eco Tax (-2.00)', 20.0000, 5),
(4, 1, 'tax', 'VAT (20%)', 158.5980, 5),
(5, 1, 'total', 'Total', 1089.5880, 9),
(6, 2, 'sub_total', 'Sub-Total', 85.0000, 1),
(7, 2, 'shipping', 'Flat Shipping Rate', 5.0000, 3),
(8, 2, 'total', 'Total', 90.0000, 9),
(9, 3, 'sub_total', 'Sub-Total', 85.0000, 1),
(10, 3, 'shipping', 'Flat Shipping Rate', 5.0000, 3),
(11, 3, 'tax', 'Eco Tax (-2.00)', 4.0000, 5),
(12, 3, 'tax', 'VAT (20%)', 18.0000, 5),
(13, 3, 'total', 'Total', 112.0000, 9),
(14, 4, 'sub_total', 'Sub-Total', 79.9900, 1),
(15, 4, 'shipping', 'Flat Shipping Rate', 5.0000, 3),
(16, 4, 'total', 'Total', 84.9900, 9),
(17, 5, 'sub_total', 'Sub-Total', 90.0000, 1),
(18, 5, 'shipping', 'Flat Shipping Rate', 5.0000, 3),
(19, 5, 'tax', 'Eco Tax (-2.00)', 4.0000, 5),
(20, 5, 'tax', 'VAT (20%)', 19.0000, 5),
(21, 5, 'total', 'Total', 118.0000, 9),
(22, 6, 'sub_total', 'Sub-Total', 331.0000, 1),
(23, 6, 'shipping', 'Flat Shipping Rate', 5.0000, 3),
(24, 6, 'tax', 'Eco Tax (-2.00)', 10.0000, 5),
(25, 6, 'tax', 'VAT (20%)', 67.2000, 5),
(26, 6, 'total', 'Total', 413.2000, 9),
(27, 7, 'sub_total', 'Sub-Total', 1069.9600, 1),
(28, 7, 'shipping', 'Flat Shipping Rate', 5.0000, 3),
(29, 7, 'tax', 'Eco Tax (-2.00)', 24.0000, 5),
(30, 7, 'tax', 'VAT (20%)', 214.9920, 5),
(31, 7, 'total', 'Total', 1313.9520, 9),
(32, 8, 'sub_total', 'Sub-Total', 100.0000, 1),
(33, 8, 'shipping', 'Flat Shipping Rate', 5.0000, 3),
(34, 8, 'total', 'Total', 105.0000, 9),
(35, 9, 'sub_total', 'Sub-Total', 205.0000, 0),
(36, 9, 'shipping', 'Flat Shipping Rate', 5.0000, 3),
(37, 9, 'total', 'Total', 210.0000, 9),
(38, 10, 'sub_total', 'Sub-Total', 100.0000, 0),
(39, 10, 'shipping', 'Flat Shipping Rate', 5.0000, 3),
(40, 10, 'total', 'Total', 105.0000, 9),
(41, 11, 'sub_total', 'Sub-Total', 110.0000, 0),
(42, 11, 'shipping', 'Flat Shipping Rate', 5.0000, 3),
(43, 11, 'total', 'Total', 115.0000, 9),
(44, 12, 'sub_total', 'Sub-Total', 128.0000, 0),
(45, 12, 'total', 'Total', 128.0000, 9),
(46, 13, 'sub_total', 'Sub-Total', 128.0000, 0),
(47, 13, 'total', 'Total', 128.0000, 9),
(48, 14, 'sub_total', 'Sub-Total', 128.0000, 0),
(49, 14, 'total', 'Total', 128.0000, 9),
(50, 15, 'sub_total', 'Sub-Total', 128.0000, 0),
(51, 15, 'total', 'Total', 128.0000, 9),
(52, 16, 'sub_total', 'Sub-Total', 112.0000, 0),
(53, 16, 'shipping', 'Flat Shipping Rate', 5.0000, 3),
(54, 16, 'tax', 'NGN VAT', 8.7750, 5),
(55, 16, 'total', 'Total', 125.7750, 9),
(56, 17, 'sub_total', 'Sub-Total', 112.0000, 0),
(57, 17, 'shipping', 'Flat Shipping Rate', 5.0000, 3),
(58, 17, 'tax', 'NGN VAT', 8.7750, 5),
(59, 17, 'total', 'Total', 125.7750, 9),
(60, 18, 'sub_total', 'Sub-Total', 85.0000, 0),
(61, 18, 'shipping', 'Flat Shipping Rate', 5.0000, 3),
(62, 18, 'tax', 'NGN VAT', 6.7500, 5),
(63, 18, 'total', 'Total', 96.7500, 9),
(64, 19, 'sub_total', 'Sub-Total', 121.0000, 0),
(65, 19, 'shipping', 'Flat Shipping Rate', 5.0000, 3),
(66, 19, 'tax', 'NGN VAT', 9.4500, 5),
(67, 19, 'total', 'Total', 135.4500, 9),
(68, 20, 'sub_total', 'Sub-Total', 116.0000, 0),
(69, 20, 'shipping', 'Flat Shipping Rate', 5.0000, 3),
(70, 20, 'tax', 'NGN VAT', 9.0750, 5),
(71, 20, 'total', 'Total', 130.0750, 9),
(72, 21, 'sub_total', 'Sub-Total', 116.0000, 0),
(73, 21, 'shipping', 'Flat Shipping Rate', 5.0000, 3),
(74, 21, 'tax', 'NGN VAT', 9.0750, 5),
(75, 21, 'total', 'Total', 130.0750, 9),
(76, 22, 'sub_total', 'Sub-Total', 85.0000, 0),
(77, 22, 'shipping', 'Flat Shipping Rate', 5.0000, 3),
(78, 22, 'tax', 'NGN VAT', 6.7500, 5),
(79, 22, 'total', 'Total', 96.7500, 9),
(80, 23, 'sub_total', 'Sub-Total', 112.0000, 0),
(81, 23, 'shipping', 'Flat Shipping Rate', 5.0000, 3),
(82, 23, 'tax', 'NGN VAT', 8.7750, 5),
(83, 23, 'total', 'Total', 125.7750, 9),
(84, 24, 'sub_total', 'Sub-Total', 117.0000, 0),
(85, 24, 'shipping', 'Flat Shipping Rate', 5.0000, 3),
(86, 24, 'tax', 'NGN VAT', 9.1500, 5),
(87, 24, 'total', 'Total', 131.1500, 9),
(88, 25, 'sub_total', 'Sub-Total', 100.0000, 0),
(89, 25, 'shipping', 'Flat Shipping Rate', 5.0000, 3),
(90, 25, 'tax', 'NGN VAT', 7.8750, 5),
(91, 25, 'total', 'Total', 112.8750, 9),
(92, 26, 'sub_total', 'Sub-Total', 100.0000, 0),
(93, 26, 'shipping', 'Flat Shipping Rate', 5.0000, 3),
(94, 26, 'tax', 'NGN VAT', 7.8750, 5),
(95, 26, 'total', 'Total', 112.8750, 9),
(96, 27, 'sub_total', 'Sub-Total', 128.0000, 0),
(97, 27, 'total', 'Total', 128.0000, 9),
(100, 28, 'sub_total', 'Sub-Total', 128.0000, 0),
(101, 28, 'total', 'Total', 128.0000, 9),
(102, 29, 'sub_total', 'Sub-Total', 99.9900, 0),
(103, 29, 'shipping', 'Flat Shipping Rate', 5.0000, 3),
(104, 29, 'tax', 'NGN VAT', 7.8743, 5),
(105, 29, 'total', 'Total', 112.8643, 9),
(106, 30, 'sub_total', 'Sub-Total', 150000.0000, 0),
(107, 30, 'total', 'Total', 150000.0000, 9);

-- --------------------------------------------------------

--
-- Table structure for table `oc_order_voucher`
--

CREATE TABLE `oc_order_voucher` (
  `order_voucher_id` int NOT NULL,
  `order_id` int NOT NULL,
  `voucher_id` int NOT NULL,
  `description` varchar(255) NOT NULL,
  `code` varchar(10) NOT NULL,
  `from_name` varchar(64) NOT NULL,
  `from_email` varchar(96) NOT NULL,
  `to_name` varchar(64) NOT NULL,
  `to_email` varchar(96) NOT NULL,
  `voucher_theme_id` int NOT NULL,
  `message` text NOT NULL,
  `amount` decimal(15,4) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `oc_product`
--

CREATE TABLE `oc_product` (
  `product_id` int NOT NULL,
  `model` varchar(64) NOT NULL,
  `sku` varchar(64) NOT NULL,
  `upc` varchar(12) NOT NULL,
  `ean` varchar(14) NOT NULL,
  `jan` varchar(13) NOT NULL,
  `isbn` varchar(17) NOT NULL,
  `mpn` varchar(64) NOT NULL,
  `location` varchar(128) NOT NULL,
  `quantity` int NOT NULL DEFAULT '0',
  `stock_status_id` int NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `manufacturer_id` int NOT NULL,
  `shipping` tinyint(1) NOT NULL DEFAULT '1',
  `price` decimal(15,4) NOT NULL DEFAULT '0.0000',
  `points` int NOT NULL DEFAULT '0',
  `tax_class_id` int NOT NULL,
  `date_available` date NOT NULL DEFAULT '0000-00-00',
  `weight` decimal(15,8) NOT NULL DEFAULT '0.00000000',
  `weight_class_id` int NOT NULL DEFAULT '0',
  `length` decimal(15,8) NOT NULL DEFAULT '0.00000000',
  `width` decimal(15,8) NOT NULL DEFAULT '0.00000000',
  `height` decimal(15,8) NOT NULL DEFAULT '0.00000000',
  `length_class_id` int NOT NULL DEFAULT '0',
  `subtract` tinyint(1) NOT NULL DEFAULT '1',
  `minimum` int NOT NULL DEFAULT '1',
  `sort_order` int NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `viewed` int NOT NULL DEFAULT '0',
  `date_added` datetime NOT NULL,
  `date_modified` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_product`
--

INSERT INTO `oc_product` (`product_id`, `model`, `sku`, `upc`, `ean`, `jan`, `isbn`, `mpn`, `location`, `quantity`, `stock_status_id`, `image`, `manufacturer_id`, `shipping`, `price`, `points`, `tax_class_id`, `date_available`, `weight`, `weight_class_id`, `length`, `width`, `height`, `length_class_id`, `subtract`, `minimum`, `sort_order`, `status`, `viewed`, `date_added`, `date_modified`) VALUES
(28, 'Product 1', '', '', '', '', '', '', '', 9999, 7, 'catalog/Wecis/Clothes/46.jpg', 5, 1, 150000.0000, 200, 9, '2009-02-03', 146.40000000, 2, 0.00000000, 0.00000000, 0.00000000, 1, 1, 1, 0, 1, 5089, '2009-02-03 16:06:50', '2025-11-07 17:47:14'),
(29, 'Product 2', '', '', '', '', '', '', '', 2, 6, 'catalog/New Women/WW 8.jpg', 6, 1, 200000.0000, 0, 9, '2009-02-03', 133.00000000, 2, 0.00000000, 0.00000000, 0.00000000, 3, 1, 1, 0, 1, 6120, '2009-02-03 16:42:17', '2026-03-16 20:22:56'),
(30, 'Product 3', '', '', '', '', '', '', '', 2, 6, 'catalog/Wecis/Clothes/WM 7.jpg', 9, 1, 150000.0000, 0, 9, '2009-02-03', 0.00000000, 1, 0.00000000, 0.00000000, 0.00000000, 1, 1, 1, 0, 1, 5389, '2009-02-03 16:59:00', '2026-03-16 20:25:38'),
(31, 'Product 4', '', '', '', '', '', '', '', 9999, 6, 'catalog/New Women/WW 7.jpg', 9, 1, 180000.0000, 0, 9, '2009-02-03', 0.00000000, 1, 0.00000000, 0.00000000, 0.00000000, 3, 1, 1, 0, 1, 5795, '2009-02-03 17:00:10', '2026-03-16 17:36:45'),
(32, 'Product 5', '', '', '', '', '', '', '', 9998, 6, 'catalog/Wecis/Clothes/WM 10.jpg', 5, 1, 150000.0000, 0, 9, '2009-02-03', 5.00000000, 1, 0.00000000, 0.00000000, 0.00000000, 1, 1, 1, 0, 1, 6244, '2009-02-03 17:07:26', '2026-03-16 20:32:20'),
(34, 'Product 7', '', '', '', '', '', '', '', 0, 6, 'catalog/New Women/W1.jpg', 7, 1, 150000.0000, 0, 9, '2009-02-03', 5.00000000, 1, 0.00000000, 0.00000000, 0.00000000, 2, 1, 1, 0, 1, 6013, '2009-02-03 18:07:54', '2026-04-30 14:43:43'),
(35, 'Product 8', '', '', '', '', '', '', '', 1, 5, 'catalog/Wecis/Clothes/48.jpg', 6, 0, 120000.0000, 0, 9, '2009-02-03', 5.00000000, 1, 0.00000000, 0.00000000, 0.00000000, 1, 1, 1, 0, 1, 6591, '2009-02-03 18:08:31', '2026-03-16 20:28:05'),
(36, 'Product 9', '', '', '', '', '', '', '', 5, 6, 'catalog/Wecis/Clothes/WM 11a.jpg', 8, 0, 200000.0000, 100, 9, '2009-02-03', 5.00000000, 1, 0.00000000, 0.00000000, 0.00000000, 2, 1, 1, 0, 1, 6937, '2009-02-03 18:09:19', '2026-03-16 20:35:25'),
(40, 'product 11', '', '', '', '', '', '', '', 10, 5, 'catalog/Wecis/Clothes/WM 8.jpg', 8, 1, 150000.0000, 0, 9, '2009-02-03', 10.00000000, 1, 0.00000000, 0.00000000, 0.00000000, 1, 1, 1, 0, 1, 6982, '2009-02-03 21:07:12', '2026-03-16 20:21:14'),
(41, 'Product 14', '', '', '', '', '', '', '', 2, 5, 'catalog/New Women/W4.jpg', 8, 1, 150000.0000, 0, 9, '2009-02-03', 5.00000000, 1, 0.00000000, 0.00000000, 0.00000000, 1, 1, 1, 0, 1, 6763, '2009-02-03 21:07:26', '2026-04-30 14:41:08'),
(42, 'Product 15', '', '', '', '', '', '', '', 10, 5, 'catalog/Wecis/Clothes/WM 3a.jpg', 8, 1, 150000.0000, 400, 9, '2009-02-04', 12.50000000, 1, 1.00000000, 2.00000000, 3.00000000, 1, 1, 2, 0, 1, 6949, '2009-02-03 21:07:37', '2026-03-16 20:14:02'),
(43, 'Product 22', '', '', '', '', '', '', '', 10, 5, 'catalog/Wecis/Clothes/WM 4.jpg', 9, 0, 120000.0000, 0, 9, '2009-02-03', 0.00000000, 1, 0.00000000, 0.00000000, 0.00000000, 2, 1, 1, 0, 1, 5587, '2009-02-03 21:07:49', '2026-03-16 20:11:03'),
(45, 'Product 18', '', '', '', '', '', '', '', 2, 5, 'catalog/New Women/W3.jpg', 5, 1, 150000.0000, 0, 9, '2009-02-03', 0.00000000, 1, 0.00000000, 0.00000000, 0.00000000, 2, 1, 1, 0, 1, 7172, '2009-02-03 21:08:17', '2026-04-30 14:30:13'),
(47, 'Product 21', '', '', '', '', '', '', '', 100, 5, 'catalog/Wecis/Clothes/WM 2.jpg', 0, 1, 150000.0000, 0, 9, '2025-05-10', 1.00000000, 1, 0.00000000, 0.00000000, 0.00000000, 1, 1, 1, 0, 1, 1958, '2009-02-03 21:08:40', '2026-03-16 20:01:55'),
(48, 'product 20', 'test 1', '', '', '', '', '', 'test 2', 2, 5, 'catalog/New Women/W5.jpg', 8, 1, 180000.0000, 0, 9, '2009-02-08', 1.00000000, 1, 0.00000000, 0.00000000, 0.00000000, 2, 1, 1, 0, 1, 3878, '2009-02-08 17:21:51', '2026-04-30 14:27:29'),
(49, 'Product 16', '', '', '', '', '', '', '', 9996, 6, 'catalog/Wecis/Clothes/WM 5.jpg', 9, 0, 120000.0000, 0, 9, '2021-03-08', 4.00000000, 1, 0.00000000, 0.00000000, 0.00000000, 1, 1, 1, 0, 1, 1858, '2021-03-08 15:20:42', '2026-03-16 19:52:26'),
(50, 'Product 23', '', '', '', '', '', '', '', 9994, 6, 'catalog/New Women/WW 1.jpg', 5, 1, 150000.0000, 0, 9, '2021-03-08', 0.00000000, 1, 0.00000000, 0.00000000, 0.00000000, 2, 1, 1, 0, 1, 2599, '2021-03-08 15:56:22', '2026-03-16 19:49:50'),
(51, 'Product 24', '', '', '', '', '', '', '', 9996, 6, 'catalog/New Women/WW 9.jpg', 7, 1, 150000.0000, 0, 9, '2021-01-08', 5.00000000, 1, 0.00000000, 0.00000000, 0.00000000, 1, 1, 1, 1, 1, 2678, '2021-03-08 16:18:43', '2026-03-16 19:44:34'),
(52, 'Product 25', '', '', '', '', '', '', '', 998, 6, 'catalog/Wecis/Clothes/WM 9b.jpg', 9, 0, 150000.0000, 0, 0, '2021-01-20', 0.00000000, 1, 0.00000000, 0.00000000, 0.00000000, 1, 1, 1, 0, 1, 2609, '2021-03-08 16:35:25', '2026-03-16 19:39:47'),
(53, 'Product 26', '', '', '', '', '', '', '', 10, 6, 'catalog/New Women/WW 3.jpg', 8, 1, 150000.0000, 0, 9, '2021-02-19', 0.00000000, 1, 0.00000000, 0.00000000, 0.00000000, 1, 1, 1, 0, 1, 2869, '2021-03-08 16:47:20', '2026-04-30 14:43:08'),
(54, 'Product 25', '', '', '', '', '', '', '', 10, 6, 'catalog/Wecis/Clothes/WM 6a.jpg', 9, 1, 120000.0000, 0, 9, '2026-03-16', 0.00000000, 1, 0.00000000, 0.00000000, 0.00000000, 2, 1, 1, 1, 1, 540, '2025-10-15 21:46:01', '2026-03-16 19:27:56');

-- --------------------------------------------------------

--
-- Table structure for table `oc_product_attribute`
--

CREATE TABLE `oc_product_attribute` (
  `product_id` int NOT NULL,
  `attribute_id` int NOT NULL,
  `language_id` int NOT NULL,
  `text` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_product_attribute`
--

INSERT INTO `oc_product_attribute` (`product_id`, `attribute_id`, `language_id`, `text`) VALUES
(43, 2, 1, '1'),
(42, 3, 2, '100mhz'),
(42, 3, 1, '100mhz'),
(43, 2, 2, '1'),
(43, 4, 1, '8gb'),
(43, 4, 2, '8gb');

-- --------------------------------------------------------

--
-- Table structure for table `oc_product_description`
--

CREATE TABLE `oc_product_description` (
  `product_id` int NOT NULL,
  `language_id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `tag` text NOT NULL,
  `meta_title` varchar(255) NOT NULL,
  `meta_description` varchar(255) NOT NULL,
  `meta_keyword` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_product_description`
--

INSERT INTO `oc_product_description` (`product_id`, `language_id`, `name`, `description`, `tag`, `meta_title`, `meta_description`, `meta_keyword`) VALUES
(28, 2, 'Voluptas Assumenda', '&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;ul&gt;\r\n&lt;/ul&gt;\r\n', 'fashion, electronics, megastore, furniture, clothes, accessories', 'Voluptas Assumenda', '', ''),
(28, 1, 'Voluptas Assumenda', '&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;ul&gt;\r\n&lt;/ul&gt;\r\n', 'fashion, electronics, megastore, furniture, clothes, accessories', 'Voluptas Assumenda', '', ''),
(32, 1, 'Men Tropical Outfit - Navy blue ', '&lt;p&gt;Navy blue laced with blu-black&amp;nbsp; design&amp;nbsp;&lt;/p&gt;\r\n', 'fashion, electronics, megastore, furniture, clothes, accessories', 'Men Tropical Outfit - Navy blue ', '', ''),
(32, 2, 'Reprehenderit Aliquam', '&lt;p&gt;\r\n	&lt;strong&gt;Revolutionary multi-touch interface.&lt;/strong&gt;&lt;br /&gt;\r\n	iPod touch features the same multi-touch screen technology as iPhone. Pinch to zoom in on a photo. Scroll through your songs and videos with a flick. Flip through your library by album artwork with Cover Flow.&lt;/p&gt;\r\n&lt;p&gt;\r\n	&lt;strong&gt;Gorgeous 3.5-inch widescreen display.&lt;/strong&gt;&lt;br /&gt;\r\n	Watch your movies, TV shows, and photos come alive with bright, vivid color on the 320-by-480-pixel display.&lt;/p&gt;\r\n&lt;p&gt;\r\n	&lt;strong&gt;Music downloads straight from iTunes.&lt;/strong&gt;&lt;br /&gt;\r\n	Shop the iTunes Wi-Fi Music Store from anywhere with Wi-Fi.1 Browse or search to find the music youre looking for, preview it, and buy it with just a tap.&lt;/p&gt;\r\n&lt;p&gt;\r\n	&lt;strong&gt;Surf the web with Wi-Fi.&lt;/strong&gt;&lt;br /&gt;\r\n	Browse the web using Safari and watch YouTube videos on the first iPod with Wi-Fi built in&lt;br /&gt;\r\n	&amp;nbsp;&lt;/p&gt;\r\n', 'fashion, electronics, megastore, furniture, clothes, accessories', 'Reprehenderit Aliquam', '', ''),
(41, 1, 'Brocade Adire', '&lt;div&gt;&amp;nbsp;Mixed with Paforated Lace and Embelished with gold stones and hand beads&amp;nbsp;&lt;/div&gt;\r\n', 'electronics, megastore, furniture, clothes', 'Brocade Adire', '', ''),
(41, 2, 'Nostrud Exercitation', '&lt;div&gt;\r\n	Just when you thought iMac had everything, now there´s even more. More powerful Intel Core 2 Duo processors. And more memory standard. Combine this with Mac OS X Leopard and iLife ´08, and it´s more all-in-one than ever. iMac packs amazing performance into a stunningly slim space.&lt;/div&gt;\r\n', 'electronics, megastore, furniture, clothes', 'Nostrud Exercitation', '', ''),
(36, 1, 'Safari Suit - Navy Blue ', '&lt;div&gt;\r\n	&lt;p&gt;&lt;br&gt;&lt;/p&gt;\r\n&lt;/div&gt;\r\n', 'electronics, megastore, furniture, clothes, accessories', 'Safari Suit ', '', ''),
(36, 2, 'Necessitatibus  Praesentium', '&lt;div&gt;\r\n	&lt;p&gt;\r\n		&lt;strong&gt;Video in your pocket.&lt;/strong&gt;&lt;/p&gt;\r\n	&lt;p&gt;\r\n		Its the small iPod with one very big idea: video. The worlds most popular music player now lets you enjoy movies, TV shows, and more on a two-inch display thats 65% brighter than before.&lt;/p&gt;\r\n	&lt;p&gt;\r\n		&lt;strong&gt;Cover Flow.&lt;/strong&gt;&lt;/p&gt;\r\n	&lt;p&gt;\r\n		Browse through your music collection by flipping through album art. Select an album to turn it over and see the track list.&lt;strong&gt;&amp;nbsp;&lt;/strong&gt;&lt;/p&gt;\r\n	&lt;p&gt;\r\n		&lt;strong&gt;Enhanced interface.&lt;/strong&gt;&lt;/p&gt;\r\n	&lt;p&gt;\r\n		Experience a whole new way to browse and view your music and video.&lt;/p&gt;\r\n	&lt;p&gt;\r\n		&lt;strong&gt;Sleek and colorful.&lt;/strong&gt;&lt;/p&gt;\r\n	&lt;p&gt;\r\n		With an anodized aluminum and polished stainless steel enclosure and a choice of five colors, iPod nano is dressed to impress.&lt;/p&gt;\r\n	&lt;p&gt;\r\n		&lt;strong&gt;iTunes.&lt;/strong&gt;&lt;/p&gt;\r\n	&lt;p&gt;\r\n		Available as a free download, iTunes makes it easy to browse and buy millions of songs, movies, TV shows, audiobooks, and games and download free podcasts all at the iTunes Store. And you can import your own music, manage your whole media library, and sync your iPod or iPhone with ease.&lt;/p&gt;\r\n&lt;/div&gt;\r\n', 'electronics, megastore, furniture, clothes, accessories', 'Necessitatibus  Praesentium', '', ''),
(34, 1, 'Occasion Praesentium', '&lt;div&gt;&lt;br&gt;\r\n&lt;/div&gt;\r\n', 'electronics, megastore, furniture, clothes, accessories', 'Occasion Praesentium', '', ''),
(34, 2, 'Occasion Praesentium', '&lt;div&gt;\r\n	&lt;strong&gt;Born to be worn.&lt;/strong&gt;\r\n	&lt;p&gt;\r\n		Clip on the worlds most wearable music player and take up to 240 songs with you anywhere. Choose from five colors including four new hues to make your musical fashion statement.&lt;/p&gt;\r\n	&lt;p&gt;\r\n		&lt;strong&gt;Random meets rhythm.&lt;/strong&gt;&lt;/p&gt;\r\n	&lt;p&gt;\r\n		With iTunes autofill, iPod shuffle can deliver a new musical experience every time you sync. For more randomness, you can shuffle songs during playback with the slide of a switch.&lt;/p&gt;\r\n	&lt;strong&gt;Everything is easy.&lt;/strong&gt;\r\n	&lt;p&gt;\r\n		Charge and sync with the included USB dock. Operate the iPod shuffle controls with one hand. Enjoy up to 12 hours straight of skip-free music playback.&lt;/p&gt;\r\n&lt;/div&gt;\r\n', 'electronics, megastore, furniture, clothes, accessories', 'Occasion Praesentium', '', ''),
(31, 1, 'Laudant Doloremque', '&lt;div class=&quot;cpt_product_description &quot;&gt;\r\n	&lt;div&gt;&lt;br&gt;&lt;/div&gt;\r\n&lt;/div&gt;\r\n&lt;!-- cpt_container_end --&gt;', 'megastore, furniture, clothes, accessories', 'Laudant Doloremque', '', ''),
(31, 2, 'Laudant Doloremque', '&lt;div class=&quot;cpt_product_description &quot;&gt;\r\n	&lt;div&gt;The D300 reacts with lightning speed, powering up in a mere 0.13 seconds and shooting with an imperceptible 45-millisecond shutter release lag time. The D300 is capable of shooting at a rapid six frames per second and can go as fast as eight frames per second when using the optional MB-D10 multi-power battery pack. In continuous bursts, the D300 can shoot up to 100 shots at full 12.3-megapixel resolution. (NORMAL-LARGE image setting, using a SanDisk Extreme IV 1GB CompactFlash card.)&lt;br&gt;\r\n		&lt;br&gt;\r\n		The D300 incorporates a range of innovative technologies and features that will significantly improve the accuracy, control, and performance photographers can get from their equipment. Its new Scene Recognition System advances the use of Nikon\'s acclaimed 1,005-segment sensor to recognize colors and light patterns that help the camera determine the subject and the type of scene being photographed before a picture is taken. This information is used to improve the accuracy of autofocus, autoexposure, and auto white balance functions in the D300. For example, the camera can track moving subjects better and by identifying them, it can also automatically select focus points faster and with greater accuracy. It can also analyze highlights and more accurately determine exposure, as well as infer light sources to deliver more accurate white balance detection.&lt;/div&gt;\r\n&lt;/div&gt;\r\n&lt;!-- cpt_container_end --&gt;', 'megastore, furniture, clothes, accessories', 'Laudant Doloremque', '', ''),
(45, 1, 'Adire Brocade  ', '&lt;div class=&quot;cpt_product_description &quot;&gt;\r\n	&lt;div&gt;\r\n		&lt;p&gt;Accent with buterfly shaped net at the neck and the sleeve area. Also embelished with matching stones&amp;nbsp;&lt;/p&gt;\r\n	&lt;/div&gt;\r\n&lt;/div&gt;\r\n&lt;!-- cpt_container_end --&gt;', 'fashion, electronics, megastore, furniture, clothes, accessories', 'Adire Brocade  ', '', ''),
(45, 2, 'Neque Porro Quisquam', '&lt;div class=&quot;cpt_product_description &quot;&gt;\r\n	&lt;div&gt;\r\n		&lt;p&gt;\r\n			&lt;b&gt;Latest Intel mobile architecture&lt;/b&gt;&lt;/p&gt;\r\n		&lt;p&gt;\r\n			Powered by the most advanced mobile processors from Intel, the new Core 2 Duo MacBook Pro is over 50% faster than the original Core Duo MacBook Pro and now supports up to 4GB of RAM.&lt;/p&gt;\r\n		&lt;p&gt;\r\n			&lt;b&gt;Leading-edge graphics&lt;/b&gt;&lt;/p&gt;\r\n		&lt;p&gt;\r\n			The NVIDIA GeForce 8600M GT delivers exceptional graphics processing power. For the ultimate creative canvas, you can even configure the 17-inch model with a 1920-by-1200 resolution display.&lt;/p&gt;\r\n		&lt;p&gt;\r\n			&lt;b&gt;Designed for life on the road&lt;/b&gt;&lt;/p&gt;\r\n		&lt;p&gt;\r\n			Innovations such as a magnetic power connection and an illuminated keyboard with ambient light sensor put the MacBook Pro in a class by itself.&lt;/p&gt;\r\n		&lt;p&gt;\r\n			&lt;b&gt;Connect. Create. Communicate.&lt;/b&gt;&lt;/p&gt;\r\n		&lt;p&gt;\r\n			Quickly set up a video conference with the built-in iSight camera. Control presentations and media from up to 30 feet away with the included Apple Remote. Connect to high-bandwidth peripherals with FireWire 800 and DVI.&lt;/p&gt;\r\n		&lt;p&gt;\r\n			&lt;b&gt;Next-generation wireless&lt;/b&gt;&lt;/p&gt;\r\n		&lt;p&gt;\r\n			Featuring 802.11n wireless technology, the MacBook Pro delivers up to five times the performance and up to twice the range of previous-generation technologies.&lt;/p&gt;\r\n	&lt;/div&gt;\r\n&lt;/div&gt;\r\n&lt;!-- cpt_container_end --&gt;', 'fashion, electronics, megastore, furniture, clothes, accessories', 'Neque Porro Quisquam', '', ''),
(30, 1, 'Men Native - Bugundary ', '&lt;p&gt;With hand weaven embroidery&amp;nbsp;&lt;/p&gt;', 'fashion, electronics, megastore, furniture, clothes, accessories', 'Exercitat Virginia Voluptates', '', ''),
(30, 2, 'Exercitat Virginia Voluptates', '&lt;p&gt;&lt;b&gt;The standard Lorem Ipsum passage, used since the 1500&lt;/b&gt;&lt;/p&gt;\r\n&lt;p&gt;Fashion has been creating well-designed collections since 2010. The brand offers feminine designs delivering stylish separates and statement dresses which has since evolved into a full ready-to-wear collection in which every item is a vital part of a woman\'s wardrobe. The result? Cool, easy, chic looks with youthful elegance.Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy.&lt;/p&gt;\r\n\r\n&lt;p&gt;c It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature,&lt;/p&gt;\r\n\r\n&lt;p&gt;&lt;b&gt;Contrary to popular belief, Lorem Ipsum is not simply random text. &lt;/b&gt;&lt;/p&gt;\r\n&lt;p&gt;Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet.&lt;/p&gt;', 'fashion, electronics, megastore, furniture, clothes, accessories', 'Exercitat Virginia Voluptates', '', ''),
(40, 1, 'Men Tropical Outfit -Dark gray', '&lt;p class=&quot;intro&quot;&gt;&lt;br&gt;&lt;/p&gt;\r\n', 'megastore, furniture, clothes, accessories', 'Men Tropical Outfit -Dark gray', '', ''),
(40, 2, 'Praesentium Voluptatum', '&lt;p class=&quot;intro&quot;&gt;\r\n	iPhone is a revolutionary new mobile phone that allows you to make a call by simply tapping a name or number in your address book, a favorites list, or a call log. It also automatically syncs all your contacts from a PC, Mac, or Internet service. And it lets you select and listen to voicemail messages in whatever order you want just like email.&lt;/p&gt;\r\n', 'megastore, furniture, clothes, accessories', 'Praesentium Voluptatum', '', ''),
(29, 1, 'Adire Mixed With Linen ', '&lt;p&gt;With big Agbada Embriodery&amp;nbsp;&lt;/p&gt;', 'megastore, furniture, clothes, accessories', 'Adire Mixed With Linen ', '', ''),
(29, 2, 'Laborum Porro Eveniet', '&lt;p&gt;\r\n	Redefine your workday with the Palm Treo Pro smartphone. Perfectly balanced, you can respond to business and personal email, stay on top of appointments and contacts, and use Wi-Fi or GPS when you’re out and about. Then watch a video on YouTube, catch up with news and sports on the web, or listen to a few songs. Balance your work and play the way you like it, with the Palm Treo Pro.&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;\r\n&lt;p&gt;\r\n	&lt;strong&gt;Features&lt;/strong&gt;&lt;/p&gt;\r\n&lt;ul&gt;\r\n	&lt;li&gt;\r\n		Windows Mobile® 6.1 Professional Edition&lt;/li&gt;\r\n	&lt;li&gt;\r\n		Qualcomm® MSM7201 400MHz Processor&lt;/li&gt;\r\n	&lt;li&gt;\r\n		320x320 transflective colour TFT touchscreen&lt;/li&gt;\r\n	&lt;li&gt;\r\n		HSDPA/UMTS/EDGE/GPRS/GSM radio&lt;/li&gt;\r\n	&lt;li&gt;\r\n		Tri-band UMTS — 850MHz, 1900MHz, 2100MHz&lt;/li&gt;\r\n	&lt;li&gt;\r\n		Quad-band GSM — 850/900/1800/1900&lt;/li&gt;\r\n	&lt;li&gt;\r\n		802.11b/g with WPA, WPA2, and 801.1x authentication&lt;/li&gt;\r\n	&lt;li&gt;\r\n		Built-in GP&lt;/li&gt;\r\n&lt;/ul&gt;\r\n\r\n&lt;p&gt;&lt;b&gt;&lt;br&gt;&lt;/b&gt;&lt;/p&gt;&lt;p&gt;&lt;b&gt;Contrary to popular belief, Lorem Ipsum is not simply random text. &lt;/b&gt;&lt;/p&gt;\r\n&lt;p&gt;Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet.&lt;/p&gt;', 'megastore, furniture, clothes, accessories', 'Laborum Porro Eveniet', '', ''),
(47, 2, 'Mens Native', '&lt;p&gt;Mens Native&lt;/p&gt;\r\n', 'fashion, electronics, megastore, furniture', 'Accusantium Doloremque', '', ''),
(47, 1, 'Men Navy Blue Outfit With A Sky blue Embroidery', '&lt;p&gt;Mens Native&lt;/p&gt;\r\n', 'fashion, electronics, megastore, furniture', 'Men Navy Blue Outfit With A Sky blue Embroidery', '', ''),
(35, 1, 'Men Native - Brown', '&lt;p&gt;&lt;br&gt;&lt;/p&gt;', 'fashion, electronics, megastore, furniture, clothes, accessories', 'Men Native - Brown', '', ''),
(35, 2, 'Commodi Consequatur', '&lt;p&gt;&lt;b&gt;The standard Lorem Ipsum passage, used since the 1500&lt;/b&gt;&lt;/p&gt;\r\n&lt;p&gt;Fashion has been creating well-designed collections since 2010. The brand offers feminine designs delivering stylish separates and statement dresses which has since evolved into a full ready-to-wear collection in which every item is a vital part of a woman\'s wardrobe. The result? Cool, easy, chic looks with youthful elegance.Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy.&lt;/p&gt;\r\n\r\n&lt;p&gt;c It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature,&lt;/p&gt;\r\n\r\n&lt;p&gt;&lt;b&gt;Contrary to popular belief, Lorem Ipsum is not simply random text. &lt;/b&gt;&lt;/p&gt;\r\n&lt;p&gt;Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet.&lt;/p&gt;', 'fashion, electronics, megastore, furniture, clothes, accessories', 'Commodi Consequatur', '', ''),
(48, 1, 'Adire Brocade Mixed With Aso-oke Jawu', '&lt;div class=&quot;cpt_product_description &quot;&gt;\r\n	&lt;div&gt;\r\n		&lt;p&gt;Accented with lemon Aso-oke multicoloured strip&lt;/p&gt;\r\n	&lt;/div&gt;\r\n&lt;/div&gt;\r\n&lt;!-- cpt_container_end --&gt;', 'megastore, furniture, clothes, accessories', 'Adire Brocade Mixed With Aso-oke Jawu', '', ''),
(48, 2, 'Voluptates Repudiandae', '&lt;div class=&quot;cpt_product_description &quot;&gt;\r\n	&lt;div&gt;\r\n		&lt;p&gt;\r\n			&lt;strong&gt;More room to move.&lt;/strong&gt;&lt;/p&gt;\r\n		&lt;p&gt;\r\n			With 80GB or 160GB of storage and up to 40 hours of battery life, the new iPod classic lets you enjoy up to 40,000 songs or up to 200 hours of video or any combination wherever you go.&lt;/p&gt;\r\n		&lt;p&gt;\r\n			&lt;strong&gt;Cover Flow.&lt;/strong&gt;&lt;/p&gt;\r\n		&lt;p&gt;\r\n			Browse through your music collection by flipping through album art. Select an album to turn it over and see the track list.&lt;/p&gt;\r\n		&lt;p&gt;\r\n			&lt;strong&gt;Enhanced interface.&lt;/strong&gt;&lt;/p&gt;\r\n		&lt;p&gt;\r\n			Experience a whole new way to browse and view your music and video.&lt;/p&gt;\r\n		&lt;p&gt;\r\n			&lt;strong&gt;Sleeker design.&lt;/strong&gt;&lt;/p&gt;\r\n		&lt;p&gt;\r\n			Beautiful, durable, and sleeker than ever, iPod classic now features an anodized aluminum and polished stainless steel enclosure with rounded edges.&lt;/p&gt;\r\n	&lt;/div&gt;\r\n&lt;/div&gt;\r\n&lt;!-- cpt_container_end --&gt;', 'megastore, furniture, clothes, accessories', 'Voluptates Repudiandae', '', ''),
(43, 1, 'Men Tropical Outfit -Sky blue with deep blue accent at the top ', '&lt;div&gt;\r\n	&lt;p&gt;&lt;br&gt;&lt;/p&gt;\r\n&lt;/div&gt;\r\n', 'fashion, electronics, megastore', 'Men Tropical Outfit -Sky blue with deep blue accent at the top ', '', ''),
(43, 2, 'Aliquam Porro Quaerat', '&lt;div&gt;\r\n	&lt;p&gt;\r\n		&lt;b&gt;Intel Core 2 Duo processor&lt;/b&gt;&lt;/p&gt;\r\n	&lt;p&gt;\r\n		Powered by an Intel Core 2 Duo processor at speeds up to 2.16GHz, the new MacBook is the fastest ever.&lt;/p&gt;\r\n	&lt;p&gt;\r\n		&lt;b&gt;1GB memory, larger hard drives&lt;/b&gt;&lt;/p&gt;\r\n	&lt;p&gt;\r\n		The new MacBook now comes with 1GB of memory standard and larger hard drives for the entire line perfect for running more of your favorite applications and storing growing media collections.&lt;/p&gt;\r\n	&lt;p&gt;\r\n		&lt;b&gt;Sleek, 1.08-inch-thin design&lt;/b&gt;&lt;/p&gt;\r\n	&lt;p&gt;\r\n		MacBook makes it easy to hit the road thanks to its tough polycarbonate case, built-in wireless technologies, and innovative MagSafe Power Adapter that releases automatically if someone accidentally trips on the cord.&lt;/p&gt;\r\n	&lt;p&gt;\r\n		&lt;b&gt;Built-in iSight camera&lt;/b&gt;&lt;/p&gt;\r\n	&lt;p&gt;\r\n		Right out of the box, you can have a video chat with friends or family,2 record a video at your desk, or take fun pictures with Photo Booth&lt;/p&gt;\r\n&lt;/div&gt;\r\n', 'fashion, electronics, megastore', 'Aliquam Porro Quaerat', '', ''),
(53, 1, 'Open Pleated Neck Adire Gown  ', '&lt;div&gt;\r\n	&lt;p&gt;Hand beaded at the neck and embelished with matching colour stones&amp;nbsp;&lt;/p&gt;\r\n&lt;/div&gt;\r\n', 'fashion, electronics, megastore', 'Open Pleated Neck Adire Gown  H', '', ''),
(54, 1, 'Men Tropical Outfit - Sage Green  ', '', 'fashion, electronics, megastore', 'Men Tropical Outfit - Sage Green  ', '', ''),
(54, 2, 'Mens Native 001', '&lt;p&gt;&lt;b&gt;Intel Core 2 Duo processor&lt;/b&gt;&lt;/p&gt;&lt;p&gt;Powered by an Intel Core 2 Duo processor at speeds up to 2.16GHz, the new MacBook is the fastest ever.&lt;/p&gt;&lt;p&gt;&lt;b&gt;1GB memory, larger hard drives&lt;/b&gt;&lt;/p&gt;&lt;p&gt;The new MacBook now comes with 1GB of memory standard and larger hard drives for the entire line perfect for running more of your favorite applications and storing growing media collections.&lt;/p&gt;&lt;p&gt;&lt;b&gt;Sleek, 1.08-inch-thin design&lt;/b&gt;&lt;/p&gt;&lt;p&gt;MacBook makes it easy to hit the road thanks to its tough polycarbonate case, built-in wireless technologies, and innovative MagSafe Power Adapter that releases automatically if someone accidentally trips on the cord.&lt;/p&gt;&lt;p&gt;&lt;b&gt;Built-in iSight camera&lt;/b&gt;&lt;/p&gt;&lt;p&gt;Right out of the box, you can have a video chat with friends or family,2 record a video at your desk, or take fun pictures with Photo Booth&lt;/p&gt;', 'fashion, electronics, megastore', 'Mens Native 001', '', ''),
(42, 1, 'Blue-Black Men Outfit ', '&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;ul&gt;\r\n&lt;/ul&gt;\r\n', 'fashion, electronics, megastore, furniture, clothes, accessories', 'Bue-Black Men Outfit ', '', ''),
(42, 2, 'Consectetur Hampden', '&lt;p&gt;&lt;font face=&quot;helvetica,geneva,arial&quot; size=&quot;2&quot;&gt;&lt;font face=&quot;Helvetica&quot; size=&quot;2&quot;&gt;Housed in a new aluminum design, the display has a very thin bezel that enhances visual accuracy. Each display features two FireWire 400 ports and two USB 2.0 ports, making attachment of desktop peripherals, such as iSight, iPod, digital and still cameras, hard drives, printers and scanners, even more accessible and convenient. Taking advantage of the much thinner and lighter footprint of an LCD, the new displays support the VESA (Video Electronics Standards Association) mounting interface standard. Customers with the optional Cinema Display VESA Mount Adapter kit gain the flexibility to mount their display in locations most appropriate for their work environment. &lt;br&gt;\r\n	&lt;br&gt;\r\n	&lt;/font&gt;&lt;font face=&quot;Helvetica&quot; size=&quot;2&quot;&gt;The Cinema HD features a single cable design with elegant breakout for the USB 2.0, FireWire 400 and a pure digital connection using the industry standard Digital Video Interface (DVI) interface. The DVI connection allows for a direct pure-digital connection.&lt;br&gt;\r\n	&lt;/font&gt;&lt;/font&gt;&lt;/p&gt;\r\n&lt;h3&gt;\r\n	Features:&lt;/h3&gt;\r\n&lt;p&gt;\r\n	Unrivaled display performance&lt;/p&gt;\r\n&lt;ul&gt;\r\n	&lt;li&gt;\r\n		30-inch (viewable) active-matrix liquid crystal display provides breathtaking image quality and vivid, richly saturated color.&lt;/li&gt;\r\n	&lt;li&gt;\r\n		Support for 2560-by-1600 pixel resolution for display of high definition still and video imagery.&lt;/li&gt;\r\n	&lt;li&gt;\r\n		Wide-format design for simultaneous display of two full pages of text and graphics.&lt;/li&gt;\r\n	&lt;li&gt;\r\n		Industry standard DVI connector for direct attachment to Mac- and Windows-based desktops and notebooks&lt;/li&gt;\r\n	&lt;li&gt;\r\n		Incredibly wide (170 degree) horizontal and vertical viewing angle for maximum visibility and color performance.&lt;/li&gt;\r\n	&lt;li&gt;\r\n		Lightning-fast pixel response for full-motion digital video playback.&lt;/li&gt;\r\n	&lt;li&gt;\r\n		Support for 16.7 million saturated colors, for use in all graphics-intensive applications.&lt;/li&gt;\r\n&lt;/ul&gt;\r\n&lt;p&gt;\r\n	Simple setup and operation&lt;/p&gt;\r\n&lt;ul&gt;\r\n	&lt;li&gt;\r\n		Single cable with elegant breakout for connection to DVI, USB and FireWire ports&lt;/li&gt;\r\n	&lt;li&gt;\r\n		Built-in two-port USB 2.0 hub for easy connection of desktop peripheral devices.&lt;/li&gt;\r\n	&lt;li&gt;\r\n		Two FireWire 400 ports to support iSight and other desktop peripherals&lt;/li&gt;\r\n&lt;/ul&gt;\r\n&lt;p&gt;\r\n	Sleek, elegant design&lt;/p&gt;\r\n&lt;ul&gt;\r\n	&lt;li&gt;\r\n		Huge virtual workspace, very small footprint.&lt;/li&gt;\r\n	&lt;li&gt;\r\n		Narrow Bezel design to minimize visual impact of using dual displays&lt;/li&gt;\r\n	&lt;li&gt;\r\n		Unique hinge design for effortless adjustment&lt;/li&gt;\r\n	&lt;li&gt;\r\n		Support for VESA mounting solutions (Apple Cinema Display VESA Mount Adapter sold separately)&lt;/li&gt;\r\n&lt;/ul&gt;\r\n&lt;h3&gt;\r\n	Technical specifications&lt;/h3&gt;\r\n&lt;p&gt;\r\n	&lt;b&gt;Screen size (diagonal viewable image size)&lt;/b&gt;&lt;/p&gt;\r\n&lt;ul&gt;\r\n	&lt;li&gt;\r\n		Apple Cinema HD Display: 30 inches (29.7-inch viewable)&lt;/li&gt;\r\n&lt;/ul&gt;\r\n&lt;p&gt;\r\n	&lt;b&gt;Screen type&lt;/b&gt;&lt;/p&gt;\r\n&lt;ul&gt;\r\n	&lt;li&gt;\r\n		Thin film transistor (TFT) active-matrix liquid crystal display (AMLCD)&lt;/li&gt;\r\n&lt;/ul&gt;\r\n&lt;p&gt;\r\n	&lt;b&gt;Resolutions&lt;/b&gt;&lt;/p&gt;\r\n&lt;ul&gt;\r\n	&lt;li&gt;\r\n		2560 x 1600 pixels (optimum resolution)&lt;/li&gt;\r\n	&lt;li&gt;\r\n		2048 x 1280&lt;/li&gt;\r\n	&lt;li&gt;\r\n		1920 x 1200&lt;/li&gt;\r\n	&lt;li&gt;\r\n		1280 x 800&lt;/li&gt;\r\n	&lt;li&gt;\r\n		1024 x 640&lt;/li&gt;\r\n&lt;/ul&gt;\r\n&lt;p&gt;\r\n	&lt;b&gt;Display colors (maximum)&lt;/b&gt;&lt;/p&gt;\r\n&lt;ul&gt;\r\n	&lt;li&gt;\r\n		16.7 million&lt;/li&gt;\r\n&lt;/ul&gt;\r\n&lt;p&gt;\r\n	&lt;b&gt;Viewing angle (typical)&lt;/b&gt;&lt;/p&gt;\r\n&lt;ul&gt;\r\n	&lt;li&gt;\r\n		170° horizontal; 170° vertical&lt;/li&gt;\r\n&lt;/ul&gt;\r\n&lt;p&gt;\r\n	&lt;b&gt;Brightness (typical)&lt;/b&gt;&lt;/p&gt;\r\n&lt;ul&gt;\r\n	&lt;li&gt;\r\n		30-inch Cinema HD Display: 400 cd/m2&lt;/li&gt;\r\n&lt;/ul&gt;\r\n&lt;p&gt;\r\n	&lt;b&gt;Contrast ratio (typical)&lt;/b&gt;&lt;/p&gt;\r\n&lt;ul&gt;\r\n	&lt;li&gt;\r\n		700:1&lt;/li&gt;\r\n&lt;/ul&gt;\r\n&lt;p&gt;\r\n	&lt;b&gt;Response time (typical)&lt;/b&gt;&lt;/p&gt;\r\n&lt;ul&gt;\r\n	&lt;li&gt;\r\n		16 ms&lt;/li&gt;\r\n&lt;/ul&gt;\r\n&lt;p&gt;\r\n	&lt;b&gt;Pixel pitch&lt;/b&gt;&lt;/p&gt;\r\n&lt;ul&gt;\r\n	&lt;li&gt;\r\n		30-inch Cinema HD Display: 0.250 mm&lt;/li&gt;\r\n&lt;/ul&gt;\r\n&lt;p&gt;\r\n	&lt;b&gt;Screen treatment&lt;/b&gt;&lt;/p&gt;\r\n&lt;ul&gt;\r\n	&lt;li&gt;\r\n		Antiglare hardcoat&lt;/li&gt;\r\n&lt;/ul&gt;\r\n&lt;p&gt;\r\n	&lt;b&gt;User controls (hardware and software)&lt;/b&gt;&lt;/p&gt;\r\n&lt;ul&gt;\r\n	&lt;li&gt;\r\n		Display Power,&lt;/li&gt;\r\n	&lt;li&gt;\r\n		System sleep, wake&lt;/li&gt;\r\n	&lt;li&gt;\r\n		Brightness&lt;/li&gt;\r\n	&lt;li&gt;\r\n		Monitor tilt&lt;/li&gt;\r\n&lt;/ul&gt;\r\n&lt;p&gt;\r\n	&lt;b&gt;Connectors and cables&lt;/b&gt;&lt;br&gt;\r\n	Cable&lt;/p&gt;\r\n&lt;ul&gt;\r\n	&lt;li&gt;\r\n		DVI (Digital Visual Interface)&lt;/li&gt;\r\n	&lt;li&gt;\r\n		FireWire 400&lt;/li&gt;\r\n	&lt;li&gt;\r\n		USB 2.0&lt;/li&gt;\r\n	&lt;li&gt;\r\n		DC power (24 V)&lt;/li&gt;\r\n&lt;/ul&gt;\r\n&lt;p&gt;\r\n	Connectors&lt;/p&gt;\r\n&lt;ul&gt;\r\n	&lt;li&gt;\r\n		Two-port, self-powered USB 2.0 hub&lt;/li&gt;\r\n	&lt;li&gt;\r\n		Two FireWire 400 ports&lt;/li&gt;\r\n	&lt;li&gt;\r\n		Kensington security port&lt;/li&gt;\r\n&lt;/ul&gt;\r\n&lt;p&gt;\r\n	&lt;b&gt;VESA mount adapter&lt;/b&gt;&lt;br&gt;\r\n	Requires optional Cinema Display VESA Mount Adapter (M9649G/A)&lt;/p&gt;\r\n&lt;ul&gt;\r\n	&lt;li&gt;\r\n		Compatible with VESA FDMI (MIS-D, 100, C) compliant mounting solutions&lt;/li&gt;\r\n&lt;/ul&gt;\r\n&lt;p&gt;\r\n	&lt;b&gt;Electrical requirements&lt;/b&gt;&lt;/p&gt;\r\n&lt;ul&gt;\r\n	&lt;li&gt;\r\n		Input voltage: 100-240 VAC 50-60Hz&lt;/li&gt;\r\n	&lt;li&gt;\r\n		Maximum power when operating: 150W&lt;/li&gt;\r\n	&lt;li&gt;\r\n		Energy saver mode: 3W or less&lt;/li&gt;\r\n&lt;/ul&gt;\r\n&lt;p&gt;\r\n	&lt;b&gt;Environmental requirements&lt;/b&gt;&lt;/p&gt;\r\n&lt;ul&gt;\r\n	&lt;li&gt;\r\n		Operating temperature: 50° to 95° F (10° to 35° C)&lt;/li&gt;\r\n	&lt;li&gt;\r\n		Storage temperature: -40° to 116° F (-40° to 47° C)&lt;/li&gt;\r\n	&lt;li&gt;\r\n		Operating humidity: 20% to 80% noncondensing&lt;/li&gt;\r\n	&lt;li&gt;\r\n		Maximum operating altitude: 10,000 feet&lt;/li&gt;\r\n&lt;/ul&gt;\r\n&lt;p&gt;\r\n	&lt;b&gt;Agency approvals&lt;/b&gt;&lt;/p&gt;\r\n&lt;ul&gt;\r\n	&lt;li&gt;\r\n		FCC Part 15 Class B&lt;/li&gt;\r\n	&lt;li&gt;\r\n		EN55022 Class B&lt;/li&gt;\r\n	&lt;li&gt;\r\n		EN55024&lt;/li&gt;\r\n	&lt;li&gt;\r\n		VCCI Class B&lt;/li&gt;\r\n	&lt;li&gt;\r\n		AS/NZS 3548 Class B&lt;/li&gt;\r\n	&lt;li&gt;\r\n		CNS 13438 Class B&lt;/li&gt;\r\n	&lt;li&gt;\r\n		ICES-003 Class B&lt;/li&gt;\r\n	&lt;li&gt;\r\n		ISO 13406 part 2&lt;/li&gt;\r\n	&lt;li&gt;\r\n		MPR II&lt;/li&gt;\r\n	&lt;li&gt;\r\n		IEC 60950&lt;/li&gt;\r\n	&lt;li&gt;\r\n		UL 60950&lt;/li&gt;\r\n	&lt;li&gt;\r\n		CSA 60950&lt;/li&gt;\r\n	&lt;li&gt;\r\n		EN60950&lt;/li&gt;\r\n	&lt;li&gt;\r\n		ENERGY STAR&lt;/li&gt;\r\n	&lt;li&gt;\r\n		TCO \'03&lt;/li&gt;\r\n&lt;/ul&gt;\r\n&lt;p&gt;\r\n	&lt;b&gt;Size and weight&lt;/b&gt;&lt;br&gt;\r\n	30-inch Apple Cinema HD Display&lt;/p&gt;\r\n&lt;ul&gt;\r\n	&lt;li&gt;\r\n		Height: 21.3 inches (54.3 cm)&lt;/li&gt;\r\n	&lt;li&gt;\r\n		Width: 27.2 inches (68.8 cm)&lt;/li&gt;\r\n	&lt;li&gt;\r\n		Depth: 8.46 inches (21.5 cm)&lt;/li&gt;\r\n	&lt;li&gt;\r\n		Weight: 27.5 pounds (12.5 kg)&lt;/li&gt;\r\n&lt;/ul&gt;\r\n&lt;p&gt;\r\n	&lt;b&gt;System Requirements&lt;/b&gt;&lt;/p&gt;\r\n&lt;ul&gt;\r\n	&lt;li&gt;\r\n		Mac Pro, all graphic options&lt;/li&gt;\r\n	&lt;li&gt;\r\n		MacBook Pro&lt;/li&gt;\r\n	&lt;li&gt;\r\n		Power Mac G5 (PCI-X) with ATI Radeon 9650 or better or NVIDIA GeForce 6800 GT DDL or better&lt;/li&gt;\r\n	&lt;li&gt;\r\n		Power Mac G5 (PCI Express), all graphics options&lt;/li&gt;\r\n	&lt;li&gt;\r\n		PowerBook G4 with dual-link DVI support&lt;/li&gt;\r\n	&lt;li&gt;\r\n		Windows PC and graphics card that supports DVI ports with dual-link digital bandwidth and VESA DDC standard for plug-and-play setup&lt;/li&gt;\r\n&lt;/ul&gt;\r\n', 'fashion, electronics, megastore, furniture, clothes, accessories', 'Consectetur Hampden', '', ''),
(49, 1, 'Men Tropical Outfit -', '&lt;div&gt;Off white tropical outfit with silver stips&lt;/div&gt;\r\n', 'electronics, megastore, furniture, clothes', 'Deserunt Mollitia Animi', '', ''),
(49, 2, 'Deserunt Mollitia Animi', '', 'electronics, megastore, furniture, clothes', 'Deserunt Mollitia Animi', '', ''),
(50, 1, 'Muti-Colour Linen Top With Black Linen Pant ', '&lt;div class=&quot;cpt_product_description &quot;&gt;\r\n	&lt;div&gt;\r\n		&lt;p&gt;Top is a&amp;nbsp; paforated checkers lace sleeve&amp;nbsp; with the grren side featuring an embroidery with poker dot.&amp;nbsp; The pant is also laced with a pink embroidery.&amp;nbsp;&lt;/p&gt;\r\n	&lt;/div&gt;\r\n&lt;/div&gt;\r\n&lt;!-- cpt_container_end --&gt;', 'fashion,  clothes, accessories', 'Muti-Colour Linen Top With Black Linen Pant ', '', ''),
(50, 2, 'Itaque Earum Rerum', '&lt;div class=&quot;cpt_product_description &quot;&gt;\r\n	&lt;div&gt;\r\n		&lt;p&gt;\r\n			&lt;b&gt;Latest Intel mobile architecture&lt;/b&gt;&lt;/p&gt;\r\n		&lt;p&gt;\r\n			Powered by the most advanced mobile processors from Intel, the new Core 2 Duo MacBook Pro is over 50% faster than the original Core Duo MacBook Pro and now supports up to 4GB of RAM.&lt;/p&gt;\r\n		&lt;p&gt;\r\n			&lt;b&gt;Leading-edge graphics&lt;/b&gt;&lt;/p&gt;\r\n		&lt;p&gt;\r\n			The NVIDIA GeForce 8600M GT delivers exceptional graphics processing power. For the ultimate creative canvas, you can even configure the 17-inch model with a 1920-by-1200 resolution display.&lt;/p&gt;\r\n		&lt;p&gt;\r\n			&lt;b&gt;Designed for life on the road&lt;/b&gt;&lt;/p&gt;\r\n		&lt;p&gt;\r\n			Innovations such as a magnetic power connection and an illuminated keyboard with ambient light sensor put the MacBook Pro in a class by itself.&lt;/p&gt;\r\n		&lt;p&gt;\r\n			&lt;b&gt;Connect. Create. Communicate.&lt;/b&gt;&lt;/p&gt;\r\n		&lt;p&gt;\r\n			Quickly set up a video conference with the built-in iSight camera. Control presentations and media from up to 30 feet away with the included Apple Remote. Connect to high-bandwidth peripherals with FireWire 800 and DVI.&lt;/p&gt;\r\n		&lt;p&gt;\r\n			&lt;b&gt;Next-generation wireless&lt;/b&gt;&lt;/p&gt;\r\n		&lt;p&gt;\r\n			Featuring 802.11n wireless technology, the MacBook Pro delivers up to five times the performance and up to twice the range of previous-generation technologies.&lt;/p&gt;\r\n	&lt;/div&gt;\r\n&lt;/div&gt;\r\n&lt;!-- cpt_container_end --&gt;', 'fashion, electronics, megastore, furniture, clothes, accessories', 'Itaque Earum Rerum', '', ''),
(51, 1, 'Denim Top And Pant With Star Embroidery ', '&lt;div&gt;&lt;br&gt;\r\n&lt;/div&gt;\r\n', 'electronics, megastore, furniture, clothes, accessories', 'Denim Top And Pant With Star Embroidery ', '', ''),
(51, 2, 'Repudiandae Molestiae', '&lt;div&gt;\r\n	&lt;strong&gt;Born to be worn.&lt;/strong&gt;\r\n	&lt;p&gt;\r\n		Clip on the worlds most wearable music player and take up to 240 songs with you anywhere. Choose from five colors including four new hues to make your musical fashion statement.&lt;/p&gt;\r\n	&lt;p&gt;\r\n		&lt;strong&gt;Random meets rhythm.&lt;/strong&gt;&lt;/p&gt;\r\n	&lt;p&gt;\r\n		With iTunes autofill, iPod shuffle can deliver a new musical experience every time you sync. For more randomness, you can shuffle songs during playback with the slide of a switch.&lt;/p&gt;\r\n	&lt;strong&gt;Everything is easy.&lt;/strong&gt;\r\n	&lt;p&gt;\r\n		Charge and sync with the included USB dock. Operate the iPod shuffle controls with one hand. Enjoy up to 12 hours straight of skip-free music playback.&lt;/p&gt;\r\n&lt;/div&gt;\r\n', 'electronics, megastore, furniture, clothes, accessories', 'Repudiandae Molestiae', '', ''),
(52, 1, 'Men Black Native With Gray Accent ', '&lt;div&gt;&lt;br&gt;&lt;/div&gt;\r\n', 'electronics, megastore, furniture, clothes, accessories', 'Men Black Native With Gray Accent ', '', ''),
(52, 2, 'Denounce Praesentium', '', 'electronics, megastore, furniture, clothes, accessories', 'Denounce Praesentium', '', ''),
(53, 2, 'Laborious Circumstances', '&lt;div&gt;\r\n	&lt;p&gt;\r\n		&lt;b&gt;Intel Core 2 Duo processor&lt;/b&gt;&lt;/p&gt;\r\n	&lt;p&gt;\r\n		Powered by an Intel Core 2 Duo processor at speeds up to 2.16GHz, the new MacBook is the fastest ever.&lt;/p&gt;\r\n	&lt;p&gt;\r\n		&lt;b&gt;1GB memory, larger hard drives&lt;/b&gt;&lt;/p&gt;\r\n	&lt;p&gt;\r\n		The new MacBook now comes with 1GB of memory standard and larger hard drives for the entire line perfect for running more of your favorite applications and storing growing media collections.&lt;/p&gt;\r\n	&lt;p&gt;\r\n		&lt;b&gt;Sleek, 1.08-inch-thin design&lt;/b&gt;&lt;/p&gt;\r\n	&lt;p&gt;\r\n		MacBook makes it easy to hit the road thanks to its tough polycarbonate case, built-in wireless technologies, and innovative MagSafe Power Adapter that releases automatically if someone accidentally trips on the cord.&lt;/p&gt;\r\n	&lt;p&gt;\r\n		&lt;b&gt;Built-in iSight camera&lt;/b&gt;&lt;/p&gt;\r\n	&lt;p&gt;\r\n		Right out of the box, you can have a video chat with friends or family,2 record a video at your desk, or take fun pictures with Photo Booth&lt;/p&gt;\r\n&lt;/div&gt;\r\n', 'fashion, electronics, megastore', 'Laborious Circumstances', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `oc_product_discount`
--

CREATE TABLE `oc_product_discount` (
  `product_discount_id` int NOT NULL,
  `product_id` int NOT NULL,
  `customer_group_id` int NOT NULL,
  `quantity` int NOT NULL DEFAULT '0',
  `priority` int NOT NULL DEFAULT '1',
  `price` decimal(15,4) NOT NULL DEFAULT '0.0000',
  `date_start` date NOT NULL DEFAULT '0000-00-00',
  `date_end` date NOT NULL DEFAULT '0000-00-00'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_product_discount`
--

INSERT INTO `oc_product_discount` (`product_discount_id`, `product_id`, `customer_group_id`, `quantity`, `priority`, `price`, `date_start`, `date_end`) VALUES
(482, 42, 1, 30, 1, 66.0000, '0000-00-00', '0000-00-00'),
(481, 42, 1, 20, 1, 77.0000, '0000-00-00', '0000-00-00'),
(480, 42, 1, 10, 1, 88.0000, '0000-00-00', '0000-00-00');

-- --------------------------------------------------------

--
-- Table structure for table `oc_product_filter`
--

CREATE TABLE `oc_product_filter` (
  `product_id` int NOT NULL,
  `filter_id` int NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_product_filter`
--

INSERT INTO `oc_product_filter` (`product_id`, `filter_id`) VALUES
(28, 3),
(28, 4),
(28, 5),
(28, 9),
(28, 10),
(29, 1),
(29, 2),
(29, 3),
(29, 4),
(29, 5),
(29, 7),
(29, 9),
(29, 10),
(29, 11),
(30, 1),
(30, 2),
(30, 3),
(30, 4),
(30, 5),
(30, 6),
(30, 7),
(30, 9),
(30, 10),
(30, 11),
(31, 2),
(31, 3),
(31, 4),
(31, 5),
(31, 7),
(31, 9),
(31, 10),
(32, 1),
(32, 2),
(32, 3),
(32, 6),
(32, 7),
(32, 9),
(34, 1),
(34, 3),
(34, 4),
(34, 5),
(34, 6),
(34, 7),
(34, 9),
(34, 10),
(34, 11),
(35, 1),
(35, 2),
(35, 3),
(35, 4),
(35, 9),
(35, 10),
(35, 11),
(36, 1),
(36, 2),
(36, 3),
(36, 4),
(36, 5),
(36, 6),
(36, 7),
(36, 9),
(36, 10),
(40, 1),
(40, 2),
(40, 5),
(40, 9),
(41, 2),
(41, 3),
(41, 4),
(41, 5),
(41, 6),
(41, 7),
(42, 1),
(42, 2),
(42, 4),
(42, 5),
(42, 6),
(42, 7),
(42, 9),
(42, 10),
(42, 11),
(43, 1),
(43, 5),
(43, 9),
(45, 1),
(45, 2),
(45, 3),
(45, 5),
(45, 6),
(45, 7),
(45, 9),
(45, 10),
(47, 1),
(47, 2),
(47, 4),
(47, 5),
(47, 6),
(48, 1),
(48, 2),
(48, 3),
(48, 5),
(48, 9),
(48, 10),
(49, 1),
(49, 2),
(49, 4),
(49, 5),
(49, 6),
(49, 7),
(49, 9),
(49, 10),
(50, 1),
(50, 2),
(50, 3),
(50, 4),
(50, 5),
(50, 6),
(50, 7),
(50, 9),
(50, 10),
(51, 1),
(51, 3),
(51, 4),
(51, 5),
(51, 6),
(51, 7),
(51, 9),
(51, 10),
(51, 11),
(52, 5),
(52, 6),
(52, 7),
(52, 9),
(52, 10),
(52, 11),
(53, 1),
(53, 2),
(53, 3),
(53, 4),
(53, 5),
(53, 6),
(53, 7),
(54, 1),
(54, 2),
(54, 5);

-- --------------------------------------------------------

--
-- Table structure for table `oc_product_image`
--

CREATE TABLE `oc_product_image` (
  `product_image_id` int NOT NULL,
  `product_id` int NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `sort_order` int NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_product_image`
--

INSERT INTO `oc_product_image` (`product_image_id`, `product_id`, `image`, `sort_order`) VALUES
(3479, 54, 'catalog/Wecis/Clothes/WM 6.jpg', 0),
(3478, 54, 'catalog/Wecis/Clothes/WM 6.jpg', 0),
(3522, 34, 'catalog/New Women/W2.jpg', 0),
(3501, 40, 'catalog/Wecis/Clothes/WM 8a.jpg', 0),
(3509, 36, 'catalog/Wecis/Clothes/WM 11.jpg', 0),
(3507, 32, 'catalog/Wecis/Clothes/WM 10a.jpg', 0),
(3503, 29, '', 0),
(3493, 47, 'catalog/Wecis/Clothes/45.jpg', 0),
(3492, 47, '', 0),
(3436, 28, 'catalog/Wecis/Clothes/47.jpg', 0),
(3519, 41, '', 0),
(3518, 41, '', 0),
(3497, 42, 'catalog/Wecis/Clothes/WM 3.jpg', 0),
(3505, 30, 'catalog/Wecis/Clothes/WM 7a.jpg', 0),
(3506, 35, 'catalog/Wecis/Clothes/49.jpg', 0),
(3500, 40, '', 0),
(3516, 48, 'catalog/New Women/W7.jpg', 0),
(3502, 29, '', 0),
(3508, 36, 'catalog/Wecis/Clothes/WM 11.jpg', 0),
(3449, 31, '', 0),
(3517, 45, '', 0),
(3496, 43, 'catalog/Wecis/Clothes/WM 4a.jpg', 0),
(3488, 49, 'catalog/Wecis/Clothes/WM 5a.jpg', 0),
(3486, 50, '', 0),
(3487, 50, '', 0),
(3485, 51, '', 0),
(3484, 52, 'catalog/Wecis/Clothes/WM 9.jpg', 0),
(3521, 53, 'catalog/New Women/WW1.jpg', 0),
(3520, 53, 'catalog/New Women/WW 2.jpg', 0);

-- --------------------------------------------------------

--
-- Table structure for table `oc_product_option`
--

CREATE TABLE `oc_product_option` (
  `product_option_id` int NOT NULL,
  `product_id` int NOT NULL,
  `option_id` int NOT NULL,
  `value` text NOT NULL,
  `required` tinyint(1) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_product_option`
--

INSERT INTO `oc_product_option` (`product_option_id`, `product_id`, `option_id`, `value`, `required`) VALUES
(265, 40, 11, '', 1),
(221, 42, 9, '22:25', 1),
(225, 47, 12, '2011-04-22', 0),
(231, 28, 10, '2021-01-22 18:22', 1),
(230, 28, 6, '', 1),
(229, 28, 5, '', 1),
(245, 36, 9, '09:21', 1),
(232, 29, 1, '', 1),
(237, 32, 10, '2021-01-20 18:27', 1),
(239, 34, 7, '', 1),
(238, 34, 6, '', 1),
(280, 51, 6, '', 1),
(243, 35, 8, '2021-01-24', 1),
(241, 36, 8, '2021-01-19', 1),
(249, 41, 7, '', 1),
(248, 41, 6, '', 1),
(253, 43, 9, '05:48', 1),
(257, 31, 7, '', 1),
(256, 31, 4, 'test', 1),
(262, 45, 9, '09:37', 1),
(263, 45, 8, '2021-01-25', 1),
(264, 40, 5, '', 1),
(220, 42, 10, '2011-02-20 22:25', 1),
(219, 42, 8, '2011-02-20', 1),
(226, 30, 5, '', 1),
(261, 45, 7, '', 1),
(247, 41, 4, 'test', 1),
(236, 32, 9, '18:27', 1),
(269, 48, 7, '', 1),
(254, 43, 10, '2021-01-23 05:48', 1),
(224, 35, 11, '', 1),
(222, 42, 7, '', 1),
(209, 42, 6, '', 1),
(266, 40, 4, 'test', 1),
(227, 47, 4, 'test', 0),
(275, 49, 7, '', 1),
(251, 43, 6, '', 1),
(272, 49, 8, '2021-02-10', 1),
(276, 50, 8, '2021-01-23', 1),
(278, 50, 6, '', 1),
(277, 50, 2, '', 1),
(282, 52, 10, '2021-01-10 16:22', 1),
(286, 53, 9, '16:34', 1),
(284, 53, 8, '2021-02-10', 1),
(242, 35, 9, '09:20', 1),
(217, 42, 5, '', 1),
(208, 42, 4, 'test', 1),
(281, 52, 9, '16:22', 1),
(240, 36, 4, 'test', 1),
(273, 49, 4, 'test', 1),
(287, 53, 7, '', 1),
(268, 48, 6, '', 1),
(258, 31, 6, '', 1),
(234, 29, 8, '2021-01-19', 1),
(260, 45, 6, '', 1),
(250, 41, 2, '', 1),
(285, 53, 6, '', 1),
(283, 52, 6, '', 1),
(279, 51, 4, 'test', 1),
(274, 49, 1, '', 1),
(223, 42, 2, '', 1),
(218, 42, 1, '', 1),
(259, 45, 4, 'test', 1),
(270, 30, 4, 'test', 1),
(255, 31, 5, '', 1),
(244, 35, 6, '', 1),
(252, 43, 8, '2021-01-23', 1),
(288, 54, 12, '2026-03-16', 1),
(267, 48, 4, 'test', 1),
(246, 36, 1, '', 1),
(235, 32, 8, '2021-01-20', 1),
(233, 29, 4, 'test', 1),
(271, 30, 6, '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `oc_product_option_value`
--

CREATE TABLE `oc_product_option_value` (
  `product_option_value_id` int NOT NULL,
  `product_option_id` int NOT NULL,
  `product_id` int NOT NULL,
  `option_id` int NOT NULL,
  `option_value_id` int NOT NULL,
  `quantity` int NOT NULL,
  `subtract` tinyint(1) NOT NULL,
  `price` decimal(15,4) NOT NULL,
  `price_prefix` varchar(1) NOT NULL,
  `points` int NOT NULL,
  `points_prefix` varchar(1) NOT NULL,
  `weight` decimal(15,8) NOT NULL,
  `weight_prefix` varchar(1) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_product_option_value`
--

INSERT INTO `oc_product_option_value` (`product_option_value_id`, `product_option_id`, `product_id`, `option_id`, `option_value_id`, `quantity`, `subtract`, `price`, `price_prefix`, `points`, `points_prefix`, `weight`, `weight_prefix`) VALUES
(42, 265, 40, 11, 48, 100, 1, 5.0000, '+', 3, '+', 5.00000000, '+'),
(2, 217, 42, 5, 42, 200, 1, 2.0000, '+', 0, '+', 2.00000000, '+'),
(1, 217, 42, 5, 41, 100, 0, 1.0000, '+', 0, '+', 1.00000000, '+'),
(14, 224, 35, 11, 48, 15, 1, 15.0000, '+', 0, '+', 0.00000000, '+'),
(13, 224, 35, 11, 47, 7, 1, 10.0000, '+', 0, '+', 0.00000000, '+'),
(16, 226, 30, 5, 40, 5, 1, 0.0000, '+', 0, '+', 0.00000000, '+'),
(15, 226, 30, 5, 39, 1, 1, 0.0000, '+', 0, '+', 0.00000000, '+'),
(12, 224, 35, 11, 46, 0, 1, 5.0000, '+', 0, '+', 0.00000000, '+'),
(3, 217, 42, 5, 40, 300, 0, 3.0000, '+', 0, '+', 3.00000000, '+'),
(4, 217, 42, 5, 39, 92, 1, 4.0000, '+', 0, '+', 4.00000000, '+'),
(11, 223, 42, 2, 45, 3998, 1, 40.0000, '+', 0, '+', 40.00000000, '+'),
(10, 223, 42, 2, 44, 2696, 1, 30.0000, '+', 0, '+', 30.00000000, '+'),
(6, 218, 42, 1, 31, 146, 1, 20.0000, '+', 2, '-', 20.00000000, '+'),
(9, 223, 42, 2, 24, 194, 1, 20.0000, '+', 0, '+', 20.00000000, '+'),
(8, 223, 42, 2, 23, 48, 1, 10.0000, '+', 0, '+', 10.00000000, '+'),
(24, 229, 28, 5, 42, 400, 0, 2.0000, '+', 0, '+', 1.00000000, '+'),
(22, 229, 28, 5, 41, 150, 0, 8.0000, '+', 0, '+', 3.00000000, '+'),
(21, 229, 28, 5, 40, 98, 1, 5.0000, '+', 0, '+', 4.00000000, '+'),
(23, 229, 28, 5, 39, 300, 1, 1.0000, '+', 0, '+', 2.00000000, '+'),
(25, 232, 29, 1, 43, 300, 1, 30.0000, '+', 1, '+', 30.00000000, '+'),
(26, 232, 29, 1, 31, 204, 1, 20.0000, '+', 2, '+', 20.00000000, '+'),
(27, 232, 29, 1, 32, 150, 1, 10.0000, '+', 3, '+', 10.00000000, '+'),
(29, 246, 36, 1, 31, 148, 1, 20.0000, '+', 2, '+', 20.00000000, '+'),
(28, 246, 36, 1, 32, 50, 1, 10.0000, '+', 1, '+', 10.00000000, '+'),
(30, 246, 36, 1, 32, 300, 1, 30.0000, '+', 3, '+', 30.00000000, '+'),
(34, 250, 41, 2, 45, 3000, 1, 40.0000, '+', 0, '+', 40.00000000, '+'),
(33, 250, 41, 2, 44, 2628, 1, 30.0000, '+', 0, '+', 30.00000000, '+'),
(32, 250, 41, 2, 24, 194, 1, 20.0000, '+', 0, '+', 20.00000000, '+'),
(31, 250, 41, 2, 23, 50, 1, 10.0000, '+', 0, '+', 10.00000000, '+'),
(38, 255, 31, 5, 42, 400, 1, 5.0000, '+', 0, '+', 5.00000000, '+'),
(36, 255, 31, 5, 41, 150, 1, 8.0000, '+', 0, '+', 8.00000000, '+'),
(35, 255, 31, 5, 40, 85, 0, 5.0000, '+', 0, '+', 5.00000000, '+'),
(37, 255, 31, 5, 39, 300, 1, 10.0000, '+', 0, '+', 10.00000000, '+'),
(43, 265, 40, 11, 47, 80, 1, 3.0000, '+', 1, '+', 3.00000000, '+'),
(44, 265, 40, 11, 46, 149, 1, 8.0000, '+', 2, '+', 8.00000000, '+'),
(7, 218, 42, 1, 43, 300, 1, 30.0000, '+', 3, '+', 30.00000000, '+'),
(41, 264, 40, 5, 41, 100, 0, 1.0000, '+', 0, '+', 1.00000000, '+'),
(5, 218, 42, 1, 32, 96, 1, 10.0000, '+', 1, '+', 10.00000000, '+'),
(39, 264, 40, 5, 40, 91, 1, 4.0000, '+', 0, '+', 4.00000000, '+'),
(40, 264, 40, 5, 39, 300, 1, 8.0000, '+', 0, '+', 8.00000000, '+'),
(47, 274, 49, 1, 43, 85, 1, 30.0000, '+', 1, '+', 30.00000000, '+'),
(46, 274, 49, 1, 31, 110, 1, 20.0000, '+', 1, '+', 20.00000000, '+'),
(45, 274, 49, 1, 32, 50, 1, 10.0000, '+', 1, '+', 10.00000000, '+'),
(51, 277, 50, 2, 45, 650, 1, 40.0000, '+', 0, '+', 40.00000000, '+'),
(50, 277, 50, 2, 44, 269, 1, 30.0000, '+', 0, '+', 30.00000000, '+'),
(49, 277, 50, 2, 24, 89, 1, 20.0000, '+', 0, '+', 20.00000000, '+'),
(48, 277, 50, 2, 23, 60, 1, 10.0000, '+', 0, '+', 10.00000000, '+');

-- --------------------------------------------------------

--
-- Table structure for table `oc_product_recurring`
--

CREATE TABLE `oc_product_recurring` (
  `product_id` int NOT NULL,
  `recurring_id` int NOT NULL,
  `customer_group_id` int NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `oc_product_related`
--

CREATE TABLE `oc_product_related` (
  `product_id` int NOT NULL,
  `related_id` int NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_product_related`
--

INSERT INTO `oc_product_related` (`product_id`, `related_id`) VALUES
(28, 28),
(28, 30),
(28, 42),
(28, 43),
(28, 45),
(28, 49),
(28, 52),
(29, 32),
(29, 34),
(29, 36),
(29, 42),
(29, 43),
(29, 45),
(29, 50),
(29, 52),
(29, 53),
(30, 28),
(30, 30),
(30, 31),
(30, 35),
(30, 40),
(30, 41),
(30, 42),
(30, 43),
(30, 45),
(30, 49),
(30, 50),
(31, 30),
(31, 34),
(31, 35),
(31, 42),
(31, 45),
(31, 50),
(31, 51),
(32, 29),
(32, 34),
(32, 35),
(32, 36),
(32, 42),
(32, 48),
(32, 49),
(32, 53),
(34, 29),
(34, 31),
(34, 32),
(34, 34),
(34, 35),
(34, 36),
(34, 48),
(35, 30),
(35, 31),
(35, 32),
(35, 34),
(35, 40),
(35, 42),
(35, 45),
(35, 48),
(35, 50),
(35, 52),
(36, 29),
(36, 32),
(36, 34),
(36, 36),
(36, 48),
(36, 52),
(40, 30),
(40, 35),
(40, 40),
(40, 41),
(40, 42),
(40, 45),
(40, 50),
(41, 30),
(41, 40),
(41, 42),
(41, 43),
(41, 49),
(42, 28),
(42, 29),
(42, 30),
(42, 31),
(42, 32),
(42, 35),
(42, 40),
(42, 41),
(42, 43),
(42, 48),
(42, 50),
(42, 51),
(42, 54),
(43, 28),
(43, 29),
(43, 30),
(43, 41),
(43, 42),
(43, 48),
(43, 49),
(43, 50),
(43, 51),
(43, 54),
(45, 28),
(45, 29),
(45, 30),
(45, 31),
(45, 35),
(45, 40),
(45, 48),
(45, 49),
(45, 51),
(45, 52),
(48, 32),
(48, 34),
(48, 35),
(48, 36),
(48, 42),
(48, 43),
(48, 45),
(48, 51),
(48, 53),
(49, 28),
(49, 30),
(49, 32),
(49, 41),
(49, 43),
(49, 45),
(49, 50),
(49, 51),
(49, 52),
(49, 53),
(50, 29),
(50, 30),
(50, 31),
(50, 35),
(50, 40),
(50, 42),
(50, 43),
(50, 49),
(50, 51),
(50, 52),
(50, 53),
(51, 31),
(51, 42),
(51, 43),
(51, 45),
(51, 48),
(51, 49),
(51, 50),
(51, 53),
(52, 28),
(52, 29),
(52, 35),
(52, 36),
(52, 45),
(52, 49),
(52, 50),
(52, 53),
(53, 29),
(53, 32),
(53, 48),
(53, 49),
(53, 50),
(53, 51),
(53, 52),
(54, 42),
(54, 43);

-- --------------------------------------------------------

--
-- Table structure for table `oc_product_reward`
--

CREATE TABLE `oc_product_reward` (
  `product_reward_id` int NOT NULL,
  `product_id` int NOT NULL DEFAULT '0',
  `customer_group_id` int NOT NULL DEFAULT '0',
  `points` int NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_product_reward`
--

INSERT INTO `oc_product_reward` (`product_reward_id`, `product_id`, `customer_group_id`, `points`) VALUES
(653, 42, 1, 100),
(649, 54, 1, 600),
(639, 28, 1, 400),
(652, 43, 1, 600),
(654, 30, 1, 200),
(656, 45, 1, 800),
(650, 50, 1, 500);

-- --------------------------------------------------------

--
-- Table structure for table `oc_product_special`
--

CREATE TABLE `oc_product_special` (
  `product_special_id` int NOT NULL,
  `product_id` int NOT NULL,
  `customer_group_id` int NOT NULL,
  `priority` int NOT NULL DEFAULT '1',
  `price` decimal(15,4) NOT NULL DEFAULT '0.0000',
  `date_start` date NOT NULL DEFAULT '0000-00-00',
  `date_end` date NOT NULL DEFAULT '0000-00-00'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `oc_product_to_category`
--

CREATE TABLE `oc_product_to_category` (
  `product_id` int NOT NULL,
  `category_id` int NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_product_to_category`
--

INSERT INTO `oc_product_to_category` (`product_id`, `category_id`) VALUES
(28, 17),
(28, 25),
(28, 26),
(28, 27),
(28, 28),
(28, 31),
(28, 32),
(28, 35),
(28, 37),
(28, 38),
(28, 39),
(28, 40),
(28, 43),
(28, 50),
(28, 51),
(28, 56),
(28, 60),
(29, 20),
(29, 24),
(29, 25),
(29, 27),
(29, 28),
(29, 30),
(29, 31),
(29, 35),
(29, 37),
(29, 38),
(29, 40),
(29, 43),
(29, 49),
(29, 50),
(29, 52),
(29, 54),
(29, 55),
(29, 56),
(29, 59),
(30, 17),
(30, 20),
(30, 24),
(30, 25),
(30, 26),
(30, 27),
(30, 28),
(30, 30),
(30, 31),
(30, 32),
(30, 37),
(30, 38),
(30, 39),
(30, 51),
(30, 52),
(30, 55),
(30, 59),
(31, 17),
(31, 20),
(31, 25),
(31, 26),
(31, 28),
(31, 30),
(31, 31),
(31, 32),
(31, 35),
(31, 39),
(31, 43),
(31, 49),
(31, 50),
(31, 51),
(31, 53),
(31, 54),
(31, 56),
(31, 59),
(32, 17),
(32, 20),
(32, 24),
(32, 27),
(32, 28),
(32, 30),
(32, 31),
(32, 32),
(32, 35),
(32, 37),
(32, 38),
(32, 39),
(32, 40),
(32, 43),
(32, 51),
(32, 52),
(32, 53),
(32, 54),
(32, 55),
(32, 60),
(34, 17),
(34, 20),
(34, 26),
(34, 27),
(34, 30),
(34, 31),
(34, 37),
(34, 38),
(34, 39),
(34, 43),
(34, 49),
(34, 50),
(34, 51),
(34, 52),
(34, 53),
(34, 54),
(34, 56),
(34, 60),
(35, 17),
(35, 20),
(35, 25),
(35, 26),
(35, 27),
(35, 28),
(35, 31),
(35, 32),
(35, 35),
(35, 37),
(35, 38),
(35, 40),
(35, 43),
(35, 49),
(35, 50),
(35, 51),
(35, 53),
(35, 54),
(35, 55),
(35, 59),
(36, 20),
(36, 24),
(36, 25),
(36, 26),
(36, 27),
(36, 28),
(36, 30),
(36, 31),
(36, 32),
(36, 35),
(36, 37),
(36, 38),
(36, 39),
(36, 40),
(36, 43),
(36, 49),
(36, 50),
(36, 51),
(36, 53),
(36, 55),
(36, 56),
(36, 59),
(40, 17),
(40, 20),
(40, 24),
(40, 25),
(40, 26),
(40, 27),
(40, 28),
(40, 30),
(40, 31),
(40, 32),
(40, 35),
(40, 37),
(40, 38),
(40, 39),
(40, 43),
(40, 49),
(40, 50),
(40, 51),
(40, 53),
(40, 54),
(40, 55),
(40, 56),
(40, 60),
(41, 17),
(41, 20),
(41, 24),
(41, 25),
(41, 26),
(41, 27),
(41, 28),
(41, 30),
(41, 31),
(41, 32),
(41, 35),
(41, 37),
(41, 38),
(41, 40),
(41, 43),
(41, 49),
(41, 50),
(41, 51),
(41, 53),
(41, 54),
(41, 56),
(41, 60),
(42, 17),
(42, 20),
(42, 24),
(42, 25),
(42, 26),
(42, 27),
(42, 28),
(42, 30),
(42, 31),
(42, 37),
(42, 38),
(42, 39),
(42, 40),
(42, 43),
(42, 49),
(42, 50),
(42, 51),
(42, 52),
(42, 53),
(42, 54),
(42, 56),
(43, 17),
(43, 20),
(43, 25),
(43, 26),
(43, 27),
(43, 30),
(43, 32),
(43, 37),
(43, 38),
(43, 39),
(43, 40),
(43, 43),
(43, 49),
(43, 52),
(43, 53),
(43, 54),
(43, 59),
(45, 25),
(45, 28),
(45, 32),
(45, 35),
(47, 17),
(47, 20),
(47, 26),
(47, 53),
(47, 59),
(48, 25),
(48, 28),
(48, 32),
(48, 35),
(49, 17),
(49, 24),
(49, 25),
(49, 51),
(49, 54),
(50, 17),
(50, 24),
(50, 31),
(50, 35),
(50, 37),
(50, 54),
(50, 59),
(50, 60),
(51, 20),
(51, 24),
(51, 26),
(51, 28),
(51, 30),
(51, 31),
(51, 38),
(51, 39),
(51, 52),
(52, 20),
(52, 38),
(52, 43),
(52, 53),
(52, 54),
(52, 56),
(53, 17),
(53, 24),
(53, 26),
(53, 27),
(53, 38),
(53, 40),
(53, 51),
(53, 54),
(54, 20);

-- --------------------------------------------------------

--
-- Table structure for table `oc_product_to_download`
--

CREATE TABLE `oc_product_to_download` (
  `product_id` int NOT NULL,
  `download_id` int NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `oc_product_to_layout`
--

CREATE TABLE `oc_product_to_layout` (
  `product_id` int NOT NULL,
  `store_id` int NOT NULL,
  `layout_id` int NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_product_to_layout`
--

INSERT INTO `oc_product_to_layout` (`product_id`, `store_id`, `layout_id`) VALUES
(42, 0, 0),
(30, 0, 0),
(47, 0, 0),
(28, 0, 0),
(41, 0, 0),
(35, 0, 0),
(40, 0, 0),
(48, 0, 0),
(29, 0, 0),
(36, 0, 0),
(32, 0, 0),
(31, 0, 0),
(45, 0, 0),
(34, 0, 0),
(43, 0, 0),
(49, 0, 0),
(50, 0, 0),
(51, 0, 0),
(52, 0, 0),
(53, 0, 0),
(54, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `oc_product_to_store`
--

CREATE TABLE `oc_product_to_store` (
  `product_id` int NOT NULL,
  `store_id` int NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_product_to_store`
--

INSERT INTO `oc_product_to_store` (`product_id`, `store_id`) VALUES
(28, 0),
(29, 0),
(30, 0),
(31, 0),
(32, 0),
(34, 0),
(35, 0),
(36, 0),
(40, 0),
(41, 0),
(42, 0),
(43, 0),
(45, 0),
(47, 0),
(48, 0),
(49, 0),
(50, 0),
(51, 0),
(52, 0),
(53, 0),
(54, 0);

-- --------------------------------------------------------

--
-- Table structure for table `oc_recurring`
--

CREATE TABLE `oc_recurring` (
  `recurring_id` int NOT NULL,
  `price` decimal(10,4) NOT NULL,
  `frequency` enum('day','week','semi_month','month','year') NOT NULL,
  `duration` int UNSIGNED NOT NULL,
  `cycle` int UNSIGNED NOT NULL,
  `trial_status` tinyint NOT NULL,
  `trial_price` decimal(10,4) NOT NULL,
  `trial_frequency` enum('day','week','semi_month','month','year') NOT NULL,
  `trial_duration` int UNSIGNED NOT NULL,
  `trial_cycle` int UNSIGNED NOT NULL,
  `status` tinyint NOT NULL,
  `sort_order` int NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `oc_recurring_description`
--

CREATE TABLE `oc_recurring_description` (
  `recurring_id` int NOT NULL,
  `language_id` int NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `oc_return`
--

CREATE TABLE `oc_return` (
  `return_id` int NOT NULL,
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `customer_id` int NOT NULL,
  `firstname` varchar(32) NOT NULL,
  `lastname` varchar(32) NOT NULL,
  `email` varchar(96) NOT NULL,
  `telephone` varchar(32) NOT NULL,
  `product` varchar(255) NOT NULL,
  `model` varchar(64) NOT NULL,
  `quantity` int NOT NULL,
  `opened` tinyint(1) NOT NULL,
  `return_reason_id` int NOT NULL,
  `return_action_id` int NOT NULL,
  `return_status_id` int NOT NULL,
  `comment` text,
  `date_ordered` date NOT NULL DEFAULT '0000-00-00',
  `date_added` datetime NOT NULL,
  `date_modified` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `oc_return_action`
--

CREATE TABLE `oc_return_action` (
  `return_action_id` int NOT NULL,
  `language_id` int NOT NULL DEFAULT '0',
  `name` varchar(64) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_return_action`
--

INSERT INTO `oc_return_action` (`return_action_id`, `language_id`, `name`) VALUES
(1, 1, 'Refunded'),
(2, 1, 'Credit Issued'),
(3, 1, 'Replacement Sent'),
(1, 2, 'Refunded'),
(2, 2, 'Credit Issued'),
(3, 2, 'Replacement Sent');

-- --------------------------------------------------------

--
-- Table structure for table `oc_return_history`
--

CREATE TABLE `oc_return_history` (
  `return_history_id` int NOT NULL,
  `return_id` int NOT NULL,
  `return_status_id` int NOT NULL,
  `notify` tinyint(1) NOT NULL,
  `comment` text NOT NULL,
  `date_added` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `oc_return_reason`
--

CREATE TABLE `oc_return_reason` (
  `return_reason_id` int NOT NULL,
  `language_id` int NOT NULL DEFAULT '0',
  `name` varchar(128) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_return_reason`
--

INSERT INTO `oc_return_reason` (`return_reason_id`, `language_id`, `name`) VALUES
(1, 1, 'Dead On Arrival'),
(2, 1, 'Received Wrong Item'),
(3, 1, 'Order Error'),
(4, 1, 'Faulty, please supply details'),
(5, 1, 'Other, please supply details'),
(1, 2, 'Dead On Arrival'),
(2, 2, 'Received Wrong Item'),
(3, 2, 'Order Error'),
(4, 2, 'Faulty, please supply details'),
(5, 2, 'Other, please supply details');

-- --------------------------------------------------------

--
-- Table structure for table `oc_return_status`
--

CREATE TABLE `oc_return_status` (
  `return_status_id` int NOT NULL,
  `language_id` int NOT NULL DEFAULT '0',
  `name` varchar(32) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_return_status`
--

INSERT INTO `oc_return_status` (`return_status_id`, `language_id`, `name`) VALUES
(1, 1, 'Pending'),
(3, 1, 'Complete'),
(2, 1, 'Awaiting Products'),
(1, 2, 'Pending'),
(3, 2, 'Complete'),
(2, 2, 'Awaiting Products');

-- --------------------------------------------------------

--
-- Table structure for table `oc_review`
--

CREATE TABLE `oc_review` (
  `review_id` int NOT NULL,
  `product_id` int NOT NULL,
  `customer_id` int NOT NULL,
  `author` varchar(64) NOT NULL,
  `text` text NOT NULL,
  `rating` int NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `date_added` datetime NOT NULL,
  `date_modified` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_review`
--

INSERT INTO `oc_review` (`review_id`, `product_id`, `customer_id`, `author`, `text`, `rating`, `status`, `date_added`, `date_modified`) VALUES
(1, 47, 0, 'Matthew Wade', 'Contrary to popular belief, Lorem Ipsum is not simply random text.', 5, 1, '2017-03-09 09:27:55', '2017-03-09 09:31:51'),
(2, 43, 0, 'Aliquam Quaerat', 'The brand offers feminine designs delivering stylish separates and statement dresses which has since evolved into\r\n a full ready-to-wear collection in which every item is a vital part of a woman\'s wardrobe.', 4, 1, '2017-03-09 09:28:15', '2017-03-09 09:33:32'),
(3, 31, 0, 'Laudant Doloremque', 'Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).', 5, 1, '2017-03-09 09:28:55', '2017-03-09 09:34:17'),
(4, 29, 0, 'Richard McClintock', 'Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur.', 3, 1, '2017-03-09 09:29:56', '2017-03-09 09:34:04'),
(5, 36, 0, 'Matthew Wade', 'The brand offers feminine designs delivering stylish separates and statement dresses which has since evolved into\r\n a full ready-to-wear collection.', 5, 1, '2017-03-09 09:30:18', '2017-03-09 09:33:46'),
(6, 34, 0, 'Aliquam Quaerat', 'Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).', 4, 1, '2017-03-09 09:30:32', '2017-03-09 09:33:16'),
(7, 32, 0, 'Matthew Wade', 'The brand offers feminine designs delivering stylish separates and statement dresses which has since evolved into\r\n a full ready-to-wear collection in which every item is a vital part of a woman\'s wardrobe.', 5, 1, '2017-03-09 09:30:49', '2017-03-09 09:33:06'),
(8, 48, 0, 'Richard McClintock', 'Contrary to popular belief, Lorem Ipsum is not simply random text.', 5, 1, '2017-03-09 09:31:15', '2017-03-09 09:32:44'),
(9, 34, 0, 'Matthew Wade', 'Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).', 3, 1, '2017-03-09 09:31:29', '2017-03-09 09:32:56');

-- --------------------------------------------------------

--
-- Table structure for table `oc_seo_url`
--

CREATE TABLE `oc_seo_url` (
  `seo_url_id` int NOT NULL,
  `store_id` int NOT NULL,
  `language_id` int NOT NULL,
  `query` varchar(255) NOT NULL,
  `keyword` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_seo_url`
--

INSERT INTO `oc_seo_url` (`seo_url_id`, `store_id`, `language_id`, `query`, `keyword`) VALUES
(1447, 0, 1, 'product_id=48', 'ipod-classic'),
(1349, 0, 1, 'category_id=20', 'desktops'),
(1315, 0, 1, 'category_id=26', 'pc'),
(1459, 0, 1, 'category_id=27', 'mac'),
(1465, 0, 1, 'manufacturer_id=8', 'apple'),
(1330, 0, 1, 'information_id=4', 'about_us'),
(1435, 0, 1, 'product_id=42', 'test'),
(789, 0, 1, 'category_id=34', 'mp3-players'),
(781, 0, 1, 'category_id=36', 'test2'),
(775, 0, 1, 'category_id=46', 'macs'),
(776, 0, 1, 'category_id=45', 'windows'),
(1455, 0, 1, 'category_id=25', 'component'),
(778, 0, 1, 'category_id=29', 'mouse'),
(1322, 0, 1, 'category_id=28', 'monitor'),
(1462, 0, 1, 'category_id=35', 'test1'),
(1464, 0, 1, 'category_id=30', 'printer'),
(1463, 0, 1, 'category_id=31', 'scanner'),
(1456, 0, 1, 'category_id=32', 'web-camera'),
(1461, 0, 1, 'category_id=17', 'software'),
(1326, 0, 1, 'category_id=24', 'smartphone'),
(1451, 0, 1, 'category_id=43', 'test11'),
(791, 0, 1, 'category_id=44', 'test12'),
(792, 0, 1, 'category_id=47', 'test15'),
(793, 0, 1, 'category_id=48', 'test16'),
(1341, 0, 1, 'category_id=49', 'test17'),
(1343, 0, 1, 'category_id=50', 'test18'),
(1340, 0, 1, 'category_id=51', 'test19'),
(1457, 0, 1, 'category_id=52', 'test20'),
(1458, 0, 1, 'category_id=53', 'test21'),
(1348, 0, 1, 'category_id=54', 'test22'),
(1346, 0, 1, 'category_id=55', 'test23'),
(1347, 0, 1, 'category_id=56', 'test24'),
(1453, 0, 1, 'category_id=38', 'test4'),
(1454, 0, 1, 'category_id=37', 'test5'),
(1320, 0, 1, 'category_id=39', 'test6'),
(1317, 0, 1, 'category_id=40', 'test7'),
(807, 0, 1, 'category_id=41', 'test8'),
(808, 0, 1, 'category_id=42', 'test9'),
(1440, 0, 1, 'product_id=30', 'canon-eos-5d'),
(1432, 0, 1, 'product_id=47', 'menShirt'),
(1400, 0, 1, 'product_id=28', 'htc-touch-hd'),
(1434, 0, 1, 'product_id=43', 'macbook'),
(813, 0, 1, 'product_id=44', 'macbook-air'),
(1448, 0, 1, 'product_id=45', 'macbook-pro'),
(1409, 0, 1, 'product_id=31', 'nikon-d300'),
(1438, 0, 1, 'product_id=29', 'palm-treo-pro'),
(1441, 0, 1, 'product_id=35', 'product-8'),
(1429, 0, 1, 'product_id=49', 'samsung-galaxy-tab-10-1'),
(820, 0, 1, 'product_id=33', 'samsung-syncmaster-941bw'),
(821, 0, 1, 'product_id=46', 'sony-vaio'),
(1449, 0, 1, 'product_id=41', 'imac'),
(1437, 0, 1, 'product_id=40', 'iphone'),
(1443, 0, 1, 'product_id=36', 'ipod-nano'),
(1450, 0, 1, 'product_id=34', 'ipod-shuffle'),
(1442, 0, 1, 'product_id=32', 'ipod-touch'),
(1466, 0, 1, 'manufacturer_id=9', 'canon'),
(829, 0, 1, 'manufacturer_id=5', 'htc'),
(830, 0, 1, 'manufacturer_id=7', 'hewlett-packard'),
(831, 0, 1, 'manufacturer_id=6', 'palm'),
(832, 0, 1, 'manufacturer_id=10', 'sony'),
(1331, 0, 1, 'information_id=6', 'delivery'),
(1333, 0, 1, 'information_id=3', 'privacy'),
(1339, 0, 1, 'information_id=5', 'terms'),
(1428, 0, 2, 'product_id=54', 'dasikinew'),
(1427, 0, 1, 'product_id=54', 'dasiki');

-- --------------------------------------------------------

--
-- Table structure for table `oc_session`
--

CREATE TABLE `oc_session` (
  `session_id` varchar(32) NOT NULL,
  `data` text NOT NULL,
  `expire` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_session`
--

INSERT INTO `oc_session` (`session_id`, `data`, `expire`) VALUES
('0021b5924131a292be8450c3c3', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 22:47:36'),
('00fbfcd16d88c1915f7c34b501', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:02:40'),
('0146e874ad4e02295f4cde5c6b', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 00:39:50'),
('0193a3c7d25b9a2f865448c9e9', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 01:15:31'),
('02148889adbc65a224dda19672', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 15:05:15'),
('0240c8b1d0e080c97371b0bdb0', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:00:47'),
('027694f245cb762e109d9de04c', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 13:56:25'),
('028e382f5ae1d3447232825f08', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 09:53:25'),
('02ed74df1ba16d7b62e7e333fc', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 18:27:02'),
('030936149cf78186d502d7d489', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 17:10:35'),
('03136ab8a89eb9e70ef5b4728c', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 19:08:30'),
('035ed267946874a14446333ceb', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:57:40'),
('035f24af3741811e7ebf69a913', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 13:15:43'),
('03bd612ff14559c212b8615fa6', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:59:55'),
('03f4e59d281ad07e59392937dd', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 19:57:29'),
('049cf71d1e1f2bbeba94f12af2', '{\"language\":\"en-gb\",\"currency\":\"NGN\",\"redirect\":\"https:\\/\\/www.wecisclothing.com\\/index.php?route=account\\/account\"}', '2026-11-03 10:42:41'),
('052d6bb7827a134aed304c38bc', '{\"language\":\"en-gb\",\"currency\":\"NGN\",\"captcha\":\"9e5c67\",\"redirect\":\"https:\\/\\/www.wecisclothing.com\\/index.php?route=information\\/blogger&amp;blogger_id=3\"}', '2026-11-03 10:42:57'),
('05a0c7afa4a3b32733287f202d', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 23:48:05'),
('05ca5bd716a875bb532c81c155', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 09:53:37'),
('05fd80081c1603a2c1fc114bf2', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:34:50'),
('063a7802cf56e3e74ecbde7c2c', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 10:05:09'),
('0646369e03f5843562e81c3f34', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 05:15:37'),
('064a8569c30f70dd23a49cae8c', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:02:13'),
('06ea29b400aca56a5fa57db4e1', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 03:00:30'),
('06f1fc79c016f395e3a5b5bf5f', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 17:10:30'),
('06fedd5a3d99f97d294fd6c452', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 11:13:18'),
('070a349643004c35e5718de748', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 04:29:13'),
('07278e38a6e7e50846dddecd78', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 02:19:29'),
('072d74286a53ef3556d5635af3', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 22:46:50'),
('07803a3497b87eaa7a4087fafd', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 08:57:57'),
('07986fad45a709faf41e42ff3a', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:59:45'),
('07dd7c2ace333efa4041659624', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:34:49'),
('07e059de4a4012396912a9b1c3', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 10:42:42'),
('0808b1b8e55b0ccec3f0f9e61f', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 04:29:01'),
('0865d6ecb87d334c1595ce96c8', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 05:36:46'),
('0872655a1e9b4f10d291230b81', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 07:01:48'),
('0883527942b6876bc088583820', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 10:49:24'),
('090af49677c1e04878f001b719', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 08:57:59'),
('094d7e2a0f8c35515135521094', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 18:43:50'),
('09adc34562c01e8781ad1b763e', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 04:19:57'),
('0a1884c6f95a23af5d34619434', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 04:29:18'),
('0a3bed252f9c7ffe5bffc937e9', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:57:52'),
('0a6f4604ed8291a4dcdcf09adf', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 13:33:44'),
('0a701972f88fa492bb202f3568', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:10:13'),
('0a9e7d0a4f2e79b063fd0cc693', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 22:49:09'),
('0ac309d811ec2f5fabd9418ba8', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 19:29:07'),
('0b27b96aee6817a5a830b54f2b', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 12:08:48'),
('0b547ebbde21715872248bc216', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 08:26:22'),
('0c10365109431e8d09fdb05081', '{\"language\":\"en-gb\",\"currency\":\"NGN\",\"captcha\":\"119186\"}', '2026-11-03 10:42:49'),
('0c21834ad054363e05a45ab9f3', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-02 18:07:20'),
('0c457fb3778e06ad0a1957ac60', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:25:27'),
('0c92059ab6d5751c3ceed00506', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 10:17:32'),
('0cbd5782f7b0100b652584845a', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-02 14:01:32'),
('0cdb8fe5e15f6ea0322be15995', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:59:24'),
('0ce1e5b2708cfae71a483a5bbb', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 15:30:49'),
('0cfb4c1503e9bd084363f10b3f', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 13:29:02'),
('0cfc7f171e0a176411d0bc975e', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 22:08:32'),
('0d08f52f1124a6a6f5016c80b8', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 22:09:03'),
('0d2f1765c163569df4b4ca4a2c', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 02:20:25'),
('0d51d738c352950ff998080601', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:10:10'),
('0de326f33ab0615ae7961845df', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 16:16:18'),
('0e53dce53da87a9459abb31f97', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-02 14:27:00'),
('0e5a4784d69581ee8d7432c7c7', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:31:08'),
('0eb9586866439a7774f324cf27', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 04:49:08'),
('0ed9d840b6bdb2c81734483296', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 05:15:41'),
('0ef4c5b35d72a03177cb9f9cd4', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 23:48:30'),
('0f0dd8661c8a5804f0a0e3bb25', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 08:26:09'),
('0f2d559f6c8166f2c5afd92ad2', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 14:19:32'),
('0f3a8c1e529b96dcaefa9ed67d', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 23:12:48'),
('0f9c1d1908e4fa82899fd2a74a', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 15:05:12'),
('0fb260259ed2dab9bb9e97232c', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 16:29:22'),
('0fb99bc2f94d32cf7b01aa21d6', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 12:02:35'),
('0fc99d46e91505fc892a339606', '{\"user_id\":\"1\",\"user_token\":\"mLulhKS4eCTyXXJhE7hVB7GQ4KzWbhQ3\"}', '2026-11-05 13:09:13'),
('103de699035832c2c6c912408c', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 19:08:35'),
('10c869c71137707b9646b6f5da', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 03:00:32'),
('10db47de3640fd167a189c78ce', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 05:15:40'),
('1114dab406952c4b552851daf2', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 04:29:14'),
('1157cffad8331b77c36ee4f91c', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 08:26:30'),
('11b0e4753f97f534e997dc66a5', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 12:52:55'),
('12279c02035275524148af4c72', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:35:58'),
('1268e31d463df170624c576be4', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 21:15:31'),
('126f97cdd4114773780d0f1489', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:00:06'),
('1293d5f129a43ca8837b2616c7', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-02 21:30:42'),
('129a953744e8284b8a20f2a0a3', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 18:45:34'),
('129ff02b02e2f8de3d5cce78c2', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 12:58:30'),
('12b51c516eba92140acffbd5ea', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 06:46:22'),
('12b6ee6fcd519a15043e21b3fc', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 12:52:58'),
('13100e66d6b0c99816cdb1e3d9', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 09:54:35'),
('13187f73ff5bc17419d663ae30', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 10:48:07'),
('13a17dc5149f74d4120e95d5c3', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:50:47'),
('13cc3661674089450147ac825f', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 13:55:59'),
('13e0b1e63625c1db5f266ae5d1', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 02:20:29'),
('13e3d53bd3e940fe102a804f05', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:03:17'),
('1402b58262e798628b78f63279', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 00:25:07'),
('14811c5885ded4ef60eb7ebf86', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 21:15:25'),
('15329df3ba09eeb09db4d96de2', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 10:24:10'),
('15b066dbcfaf319dfcd7865127', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 22:48:00'),
('15cdf4616364aa582aa7d4b22b', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 23:27:29'),
('161af62ffdde1c0fb6d205a1a6', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 10:02:30'),
('1638c20d083461910466427437', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 13:56:01'),
('1659e9280b59e3f16c8e0ac9c6', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 03:58:09'),
('165c06bf9ad89ffb64512baf45', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 01:17:07'),
('1675d4ebbc1278e93290a4f56c', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 12:00:54'),
('16770cde81391b16b3a32ea624', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 23:12:48'),
('16f75ee30a203415a66f28410e', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 03:58:06'),
('174889a0d1b94f1f52b198fd8d', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 06:59:14'),
('176f54932e1a2b2c848b1861a6', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 09:17:53'),
('17d14527bc336463ea0a560a73', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:31:04'),
('17db933b9f381cdf8e11225ccb', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 10:21:21'),
('17f608b8e08b8b579da7329289', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 02:20:29'),
('186a9c378249c407d2a715f3be', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 08:26:32'),
('18bf929945ac39d01c2805e81c', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 22:09:06'),
('1969d34e4faa90a878f9a794ba', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 10:42:10'),
('19baa32a9fdcc32eddb2640857', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 14:19:21'),
('19dc6729bdab5a30c32127d11a', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-02 19:12:27'),
('19e181ea04755ed2d5b8ce1493', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 10:41:53'),
('1a09da7483bc6b0754234de742', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 13:08:53'),
('1a2a7ddd24c2e2158445f40ef2', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 17:10:35'),
('1a4ba2b32354d1fba67e48ff90', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:24:04'),
('1a798a3256684d03d39f4a0b15', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:59:34'),
('1ab6708668d6f1fe551105c584', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 17:10:29'),
('1ae457faa1978934466b88dbb4', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 12:53:32'),
('1bfdbcc97ff9c53441f16b9664', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 05:36:21'),
('1c46d6a5e8974eab75233e6544', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 10:41:10'),
('1c5216c29c20bf5331de1438b0', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 15:21:19'),
('1c708468756cce66fa2238961c', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 15:45:29'),
('1c9357b8a48488a40b4a417dfa', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:30:58'),
('1ca4360b41f92330579de4f5eb', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 14:40:58'),
('1ca999dce007f086a2571f23d1', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 21:15:15'),
('1cc39f97f2b2b2940a2611c57e', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 05:52:19'),
('1d2edd3bbea6ddc8f40741ba6f', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 05:51:36'),
('1d6e6b3a937cbec68a4075ee30', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 18:45:17'),
('1d9596ae3c96c0d4feb3b837fd', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 13:55:59'),
('1d9a8106b8327aad318d8a58f0', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 06:43:00'),
('1ddb3257d5a9262b7d4d397b5c', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 19:22:40'),
('1e14150552abe4d7b3482a2355', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 19:45:04'),
('1e410f18afb72e0bc512e90044', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:25:31'),
('1e436d3486bac45ea97b46c611', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 01:33:45'),
('1eb815d9f8b5139437a0fef8f4', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 02:19:23'),
('1f11a42b2dc993e54bea2daa32', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 13:55:57'),
('1f1c1616b9f5b06ee2af3840ab', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 10:42:57'),
('1f2df510d45e8fd868df737334', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 17:10:32'),
('1f5b1a2d8df9186086ac9a2ef0', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 20:36:32'),
('1f9a222ef5b32ce68658d44409', '{\"language\":\"en-gb\",\"currency\":\"NGN\",\"captcha\":\"890898\",\"redirect\":\"https:\\/\\/www.wecisclothing.com\\/index.php?route=information\\/blogger&amp;blogger_id=4\"}', '2026-11-05 03:01:19'),
('1fa141a99dd1a461480b4c81fe', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 10:48:39'),
('200a8cf5294c60fe43a4ee5154', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 15:28:54'),
('2018d16d908da924a739851353', '{\"language\":\"en-gb\",\"currency\":\"NGN\",\"captcha\":\"10362f\",\"redirect\":\"https:\\/\\/www.wecisclothing.com\\/index.php?route=information\\/blogger&amp;blogger_id=1\"}', '2026-11-04 13:06:16'),
('20350b4f614dc8caf2e9c9ea18', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 18:16:17'),
('204f28682cc9494eef1e81b34c', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 12:38:33'),
('20fef2094b7fe16eb96db8c48e', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 15:45:28'),
('2167b55632e53be6053e099400', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 22:08:56'),
('216bcc4681e121b0322524a0af', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 11:58:45'),
('21a7f56fb545736e038c356de8', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 17:10:32'),
('21ed33446bb1e4f96245fe6fe3', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:59:17'),
('22275302f18ca911a7ce2caf91', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 13:29:03'),
('224fd6a6c6fde8773c9d903dbb', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-02 20:33:11'),
('22eb054ff4b9d3b461fd126270', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 19:08:38'),
('230214b062939a546131066c96', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 15:45:26'),
('23461f653413597d8f8f198130', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 04:27:20'),
('236ad6f94402a7db67c2edc3a9', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:58:52'),
('238692e232eda583b6851e4fa2', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:35:00'),
('240d7be58637dd62b8e82edc9d', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:30:57'),
('24b45909961d050fde792dd441', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 14:41:22'),
('24c0d8a8ffbee5ec9cdefea5c7', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 12:53:29'),
('24e6229d4de5ff21c22bdf0aed', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 04:29:13'),
('2688f6e260a3507582e16f0e45', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 17:10:24'),
('269532d3091ddfb29a25e4498f', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:01:46'),
('269a6a175527b37c5af9a0eeb3', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 21:15:22'),
('269faf42a3729df7cc5b1b205c', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 13:16:03'),
('26a6dee5d396f7dfdf8f14d089', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:57:33'),
('26f0e3ad9cad5344de1c57af99', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 18:14:50'),
('27283c4dbe82b3f510a3be9343', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 12:58:32'),
('27453e7b4e889b1911817d9a86', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:03:18'),
('27adbc7c32a9523afd1565589e', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 10:45:15'),
('27b7c009573efc7485081911f0', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 01:33:53'),
('28767ed4c66ce47c52eff41229', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 01:33:44'),
('288044e6319f5fa66e4f43e1be', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 13:23:55'),
('28821d38c3ad329c5946d55705', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 05:39:09'),
('29181da408919bae4e8971e16f', '{\"language\":\"en-gb\",\"currency\":\"NGN\",\"captcha\":\"357f91\",\"redirect\":\"https:\\/\\/www.wecisclothing.com\\/index.php?route=information\\/blogger&amp;blogger_id=3\"}', '2026-11-04 06:42:57'),
('2946017ccead958759bdd7a51e', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 04:29:21'),
('2950e8f02c69de2360aa443e5f', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 04:29:15'),
('2951d2e5b141257c2469791f20', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:38:49'),
('2957b6b605884011feb1372e2c', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 11:55:52'),
('29bc87321bf3282a25fab664d9', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:03:22'),
('29dd67d4ce2fa43d60d709fc37', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 16:29:35'),
('29ebacc72831c07c6d216332ff', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 13:45:45'),
('2a31abd9b3efc10f85096193df', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 04:49:08'),
('2a351fec08f8f355c2c7d53fba', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 05:36:17'),
('2a4e3ce113eb5684cb4617d8bb', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 04:19:48'),
('2a56f82df17d84f148be54cfa1', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:31:05'),
('2a73e6a4d1b8489aa1a8133bf7', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 23:47:58'),
('2abbcadcf3457977d737b38edb', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 05:37:29'),
('2adce21db720d29b4541e5b66a', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:01:22'),
('2ae742c5ad0d114147cea20673', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 17:10:22'),
('2b034546cb494ccf60de9eb978', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 12:00:15'),
('2b6b87e13b301f9df936929ed0', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 04:59:14'),
('2bed95b784d6d8b7569a73466a', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 22:08:49'),
('2c219ed5b371b963a3f3c7f1a3', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 23:12:54'),
('2c3a663ba363dc6574f6f1ea12', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:03:35'),
('2c8977b6c4e089a4b6d9401ad8', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 03:00:22'),
('2cb8ffeb986b9532cb791537b9', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 03:57:58'),
('2d978fb0e003871cfbb171745f', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 05:15:46'),
('2db5e32a5c8007a3f946f57c46', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 14:04:05'),
('2dbaa27f827ae7d21b3c3de165', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 01:33:59'),
('2e2514e205c0d60dbe9909f78a', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 19:22:34'),
('2e86fa4ca5f287b48a85593c54', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-02 19:12:31'),
('2ea15785920df63711d529efc6', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 08:26:25'),
('2edcd6136e7e748c8413494de2', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 18:23:39'),
('2ee8f4b1ceb821d1780125d543', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 00:25:20'),
('2f0356c2f69c72c1b4d75dd865', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 16:01:23'),
('2f126cbbe8e1135032da64be88', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 15:28:55'),
('2f2f70a2fa208f5451748143b0', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 09:56:06'),
('2f3f8922f21662b524976f8bc1', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 04:29:01'),
('2f49e12261a6850b9d867143f9', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 10:42:46'),
('2fd27a4bb0628dd4fe7475eb35', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:11:01'),
('2ffa43f29b14b0d5c5deb774f5', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 09:44:16'),
('3018c8c749847bdc6d39b4a2ff', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 13:18:18'),
('3047848a94908b4cd2b4224a5c', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 23:12:51'),
('305e5a82fea56fb823164959ea', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 16:57:53'),
('3120adeb2d8b4d74447a0fe497', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:28:40'),
('312531dc91e9e0fd1ea8fc8c80', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 13:08:54'),
('31360fdd36a602ea6435d41e0e', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 19:22:27'),
('3176ead0c1da11829e4fc36ac0', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:01:29'),
('31bbdeffd9bbfd7290bc2b94fa', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-02 15:23:09'),
('31c55f1e2d6c566e080e129776', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 03:00:37'),
('31c6f9f25a4000165965c7d9c0', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 10:00:43'),
('320dfcafa18bd1e08e1ddcc41e', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 13:56:12'),
('32128089b944ebf882583a0ab6', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:03:23'),
('32761bd346f4fb1dbcf7ba5367', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:50:49'),
('329ab83efd6ffe13adc2812105', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:03:26'),
('32bb3dc6ff6d5fa56c79a5db96', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:50:53'),
('32cdee83043f10bcce40bce3f0', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:31:05'),
('32ee2719f2206f3be9351fc9a8', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 16:01:25'),
('32fa440ee5acbeb37e8f705e8f', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 06:28:39'),
('33e5c0c8d13b82da67a6bf7597', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 12:58:44'),
('349fddc6a12abce5268ce38701', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 17:03:43'),
('34b8c2652de449449e5bca27eb', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 04:20:01'),
('34c9d088010844674f7b1f679b', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 13:08:56'),
('35039ceb8ce235cc7c9f30d18f', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:25:55'),
('354a2fa6c0073c90fa85324de1', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 16:57:58'),
('35601ca35fbf9f33d9018054d3', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 11:56:08'),
('35d876728d493c99294fbdbaa5', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 09:58:41'),
('35e378e99b4a1b63025538ecfb', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 12:53:02'),
('36837c57f8229c8bfe4e548dd4', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:58:35'),
('3689f6648fb5c6f48254756aa8', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:22:23'),
('3690d32c995e4c05fca0c92aa7', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 13:28:58'),
('369f7defa255a4f92b844eb4fb', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 04:49:27'),
('36acb4e033fc46fc42667bf7ef', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 13:29:04'),
('36d56e8b38ead0acbce46f2155', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-02 14:38:21'),
('372f25db5e8053d568e1564ee9', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:50:59'),
('3735669bf09269280fe6264ef5', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 13:28:59'),
('375cf30404c32e93776d135e90', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 15:28:56'),
('376ef73833a2c08f63b8cb73a2', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-02 20:52:56'),
('37ad54f88100fc11e72cc40667', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 23:48:32'),
('37f9f777f9a9ff465ac0c3cf16', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 10:42:51'),
('37fb517a3f2c860c3694fe997f', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 15:52:33'),
('380b0ed445964f627a9cefe58d', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 14:18:54'),
('380cfdbee8ef651a2732ff5eaa', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 05:15:41'),
('3813cb371296c7b0d27074ac6b', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 04:19:56'),
('383fd119d151edd1c0e5ca1929', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 04:19:43'),
('384ad37fd69d677d381e02a68e', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 09:54:07'),
('38d29fffca00cfbe3a648381c3', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 13:56:13'),
('38e51f2a4848b6914c6af1777f', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 22:09:10'),
('392f4a39f5fb44955ff284a0c6', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 14:19:31'),
('395994cb767330f6e304cfa865', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 21:15:32'),
('39664504075f6bb08452975004', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 17:10:33'),
('39c83cc27788e1a52b92add2f2', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 17:10:25'),
('3a848b004c30e11904d06fe62d', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 10:52:46'),
('3a88d4977ff73cc1f5fd012e7e', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:02:16'),
('3a93c25bd33f105f340f77c938', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 07:32:41'),
('3ad481fafb32b6105be304d973', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:59:27'),
('3b0f40f9c603b60081c3f551bc', '{\"language\":\"en-gb\",\"currency\":\"NGN\",\"compare\":[]}', '2026-11-03 12:17:37'),
('3b30dc77ec18021b3fca2fa058', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-02 19:12:30'),
('3b59ac05728ab10615517b0d94', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 07:01:49'),
('3bc4712659f847335578939cb0', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 19:29:08'),
('3bfd04172bbeec186e197b4036', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 19:22:21'),
('3c0947e92201c99254952f5bef', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 22:44:51'),
('3c23c1be557a7895b3c2fb8ef9', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 02:20:21'),
('3cf409ae78c84eb1c1f82f0285', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:00:13'),
('3d50dc230e1cdd511b0c0ba67d', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 03:58:01'),
('3d7ddec2ac80d097d92ac6e9a2', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:25:37'),
('3d82ecf5cd4f75b7ef629a4adb', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 17:10:26'),
('3e194b708e2a7d02eaed025fef', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 21:15:19'),
('3e35673e5cdc15a1338433fcc3', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 19:22:39'),
('3e4240cb366ca4c2a3b29eda6a', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 05:51:49'),
('3eb84bcb4168192f2bd55e4d48', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 18:25:53'),
('3ed53dbf3d850e4b4bc00724c7', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 13:55:57'),
('3ede0a9fddd0d30d816a4762ba', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 15:45:24'),
('3f670d324b75025028b8b71847', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 13:33:48'),
('3f71ebc8c764399741d6a3a659', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:58:01'),
('3f76f3ab57722f6ace46ca71d3', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:10:39'),
('3f7ea9d254f00ab129e6512f81', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 21:15:21'),
('3fb4721f057a470d1ac1fd865f', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:58:56'),
('40cbdd21fb1e494296a111d8b1', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 11:59:49'),
('4102813cfbc2c50b6471f55a78', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:03:27'),
('411126233e4624f9717fd089f0', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:25:29'),
('413bee83509c423a818ffc8fe4', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:35:15'),
('41938588e3183108ed6c489373', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 09:55:20'),
('41ba696275706251d35979b91b', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:03:18'),
('41ec7d0fda22a9cf7f4bc7749f', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 03:00:34'),
('420545f29bb0382bb90de9fd6d', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 22:47:22'),
('42243c480da15d1879aef13523', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 04:19:55'),
('428b0da9009d0a3a17821f7834', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 22:48:46'),
('42a2f19904a524ac326713fa6d', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 03:00:27'),
('42d709f5b27ea0556466e05fa1', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:35:00'),
('42f0943907914e5982db900d92', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:25:49'),
('42f247191da25205f134b83dd5', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 21:15:17'),
('432a3b41ebd8b100f3e0fbcf38', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 18:40:46'),
('432b01cc0dc19174313b23ddc6', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 01:33:48'),
('43373e06452e5c62829767c97a', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 13:28:09'),
('4353006242c79c7b84151e6fa3', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 17:03:56'),
('4373d4ee8607e3627bf806201c', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 04:20:03'),
('43887c9b4908b3d2e39fe4194c', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 12:48:23'),
('43a43128fe896768ff80717b46', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:40:10'),
('43a4cec929b1390d7997a725d2', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 14:41:34'),
('43ca877e9c3dbdb0c10e64d148', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 03:57:57'),
('440efb949e27d431c19a09d242', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 04:19:58'),
('444a686ac32339420db38d158d', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 19:29:13'),
('444e7330fcd12225972247a8c8', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 04:49:19'),
('44585af1c754f5f064e87934bb', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 06:10:07'),
('447f0a9d380327a17bdccb3300', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 03:53:38'),
('448bd8b8f14449887768a23a77', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 15:29:10'),
('44cb4467e389170ffe8ae9ec04', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 09:59:37'),
('44d719fa17800c52c6d5b3d116', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 04:19:55'),
('451082634bff315b3ed4491e45', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 04:49:09'),
('452c948b102cefa262b0dedf26', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 18:22:31'),
('453efa482d7366e48df153eda9', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 05:15:45'),
('4572499d1cb0224ea890c932ac', '{\"language\":\"en-gb\",\"currency\":\"NGN\",\"redirect\":\"https:\\/\\/www.wecisclothing.com\\/index.php?route=account\\/download\"}', '2026-11-03 10:52:45'),
('4588dfba6e1a25788dc79b3599', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:02:26'),
('45a5ac053d4c58e85abbcd27ac', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 13:56:17'),
('45b6400005b59b1bf306cbf9e7', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 13:13:10'),
('45fb9152ab855517d88fa1a3dc', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:50:47'),
('46719f36cc0627853ad7b418fd', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 14:13:38'),
('46b7e5bea705cd6d437d0d4cb7', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:30:54'),
('46e8af9e43439433a8df0597e2', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 14:08:57'),
('474e21d3119647151611ad7302', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 17:03:54'),
('47913714028dc4d5b109baa967', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 02:19:31'),
('47b9f2c47fe30c5cb5d819d93f', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:00:44'),
('4821738b31df8fba71bbdc83e2', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 15:45:27'),
('48a8baed3deefdc5e836591372', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 18:50:06'),
('4900f210fb42de6ae153ad21d8', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 10:43:15'),
('49023e533641f9a8367aa00566', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:00:16'),
('4944c954b8dfa17badccb2b81d', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 03:58:04'),
('4995d3735ad366a1675617e2f0', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 05:15:35'),
('49c93f15fcbd82803dc87681ed', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 11:59:18'),
('49e5f346dd5fee929eefc88a3c', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 14:05:32'),
('49e9690e22082f0f2bca3f4b7d', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:01:32'),
('4a02e5af597f50194b743eaa11', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 14:19:13'),
('4a0a77ecadedf59333c460c37c', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 16:54:28'),
('4a29abd7af3cac349c57fc2b5f', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 13:29:06'),
('4a402605380062c64399e8c6f7', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 04:49:20'),
('4a529d308513e165641790151b', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 18:45:26'),
('4a53a09c26238d39a805630781', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 02:19:50'),
('4a583a355172bb5003003a66a5', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 13:56:01'),
('4a7fe65f07deca0f4e5d4d87e5', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:59:38'),
('4ab444c5a6a946dd441d3c8cd9', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 19:29:00'),
('4ad6693c938ab91b899ab7eb53', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 13:56:16'),
('4b0ba915f88d27f89fd814203d', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 12:01:53'),
('4b6dfd68bce7af33a31d8d065f', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 12:09:23'),
('4bd1a9f2cd98846193cde6dc71', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 13:48:03'),
('4bf525f88f731c9a1214db00a4', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 10:42:46'),
('4bfc6a292954818dfc0b4e773c', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 23:12:52'),
('4c2b77c1c59c11f97861f1a759', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 16:29:37'),
('4c92b98db917404235807419e9', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 05:15:36'),
('4d0efe8a1372d949c00f171b04', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 14:36:43'),
('4d407eff32fdbfa36052d4718d', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 09:29:37'),
('4dddc6b158d449a9c1100de825', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 21:15:27'),
('4df6dcbf14b41c3ef85cce8f04', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:25:27'),
('4e0061b3e96fbf545aaf96ea56', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 18:40:56'),
('4ea1f9223f7d8f7f31d655de14', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 10:42:38'),
('4ef74ec82a2ba76594a77c22c0', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 10:42:44'),
('4f2e62308ac00f36f2d71b4eae', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 04:49:25'),
('4f30f8d7cccddce2d00a716cae', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 21:15:29'),
('4fae8ad3adf9c7b45eef47e065', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 12:17:53'),
('506ced5b983a35b14983a719bb', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 16:01:23'),
('5082c1cd7ff65ce27f827f2001', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 09:53:14'),
('5083614fa31b8029ab79112c1c', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 23:48:24'),
('50972f97b5a8bb430bd9559f56', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:59:03'),
('509c631ba4b8e60efccb2107ce', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 03:58:08'),
('50e62e5e4fe9c462a4e8fff73d', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 15:05:13'),
('51346095bdde49b362c8c4d474', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:34:49'),
('513d0d5f975fd361ae53686f6f', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:02:10'),
('514ac174670d3c316aaf52e7db', '{\"language\":\"en-gb\",\"currency\":\"NGN\",\"redirect\":\"https:\\/\\/www.wecisclothing.com\\/index.php?route=account\\/address\"}', '2026-11-05 19:22:28'),
('5168de00f02354cbdb7fb8b25c', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:25:36'),
('519f472b4bc81320b53155704b', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 10:42:37'),
('51b1f45468ddd975ea7c0e8800', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:10:10'),
('51e65ddb3cadc4c165a0dfd749', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 16:57:52'),
('5211cbbe89140698a8f52f3875', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:23:28'),
('5251e41272730a5378fb5c167e', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 17:29:14'),
('5289c17f28181e1d877b046543', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 14:19:08'),
('52afa9ab07c3cbb0edb5c1b2d5', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 01:33:58'),
('52d33621fb213f4646572a30b2', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 13:08:54'),
('52e73ebe137859f814b0c1f151', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 15:30:18'),
('530eb51fee5bd1040f555dcaf2', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 05:38:46'),
('536d636ddc5f26f85ecb6ac27e', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:50:50'),
('53906c9786268f425645fe592c', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 02:19:33'),
('541450eb3bf7ba6e17777f4c1e', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 12:29:20'),
('54733544195d9aa387d1291294', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 13:14:53'),
('5482ccd7051a0239cf04318a54', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 02:20:27'),
('54aaaee565634269825b262213', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 18:49:12'),
('54c0433e8364d27c39588191b4', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 23:24:39'),
('54cc0ca708639d60b9a26e00d6', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 08:25:48'),
('5547f207703eccb1e59d00e294', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 19:22:19'),
('55aad25c94192ff77f16b3b8cd', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 14:04:08'),
('55dcce9b9ba9dcf2a9f1c83d79', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:58:04'),
('55dd7812e5402360e5f92c81ed', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 02:20:25'),
('55e68296546c098b74db7e65fc', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 22:07:53'),
('55f166cbc9d2e6c054cfa3cd27', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 04:29:04'),
('561eb9c639e5d0225fea7c7237', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 14:40:57'),
('56466366fb5521aa8cff51e327', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 18:44:30'),
('564bf7e0577b0407d07bf1bb2b', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 10:42:40'),
('56752460ecd227b91da492df32', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 12:58:34'),
('56df767691a472a3a9298adcae', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:58:14'),
('581f55eefc15b42f3651b64a79', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 14:40:55'),
('582c5d0a44a47ffa8895d56d2c', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 23:25:58'),
('58724d41d787b0bc0649d9f2a8', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:03:19'),
('5899200db802e0c9a4dd38b694', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 03:00:23'),
('58bba3e211303db9d60d091b24', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 14:18:58'),
('58e9ad16f5af06985e7236d409', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 05:54:45'),
('58f60e56f01fad5511efda32a3', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 15:12:08'),
('591afa9564d407a61089572919', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 11:55:23'),
('5965f76f13354aef35898943b2', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:57:36'),
('598f45922f14f73beecdb0ce23', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-02 14:38:20'),
('59c5fef543df846821bb84972c', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 10:42:55'),
('59d54bb2a260aa0a2700d02936', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 03:00:28'),
('5a49c0b8aa1659cfad6f302234', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:35:57'),
('5a892f78dbcb6106cc15446ce5', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:01:53'),
('5aecccd15ee2bd113d1e830d76', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 13:56:20'),
('5b5d6e4504a96382509d521404', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 05:26:46'),
('5b9cdc9618cf805b6fbfe7849d', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 11:57:03'),
('5b9ec29ba3508740b81a843d58', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 19:22:22'),
('5ba8fe9f0b0b894b7e01c5c59a', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 00:25:04'),
('5baa6f0a35cf1a9087e7a48c04', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 23:47:47'),
('5baf8111bd4ba72b5cfd97e1cf', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 04:49:22'),
('5bd55b775b7902710e4ecc0f4c', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 13:27:09'),
('5c2bd3950258ff17d45ca2d596', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 08:26:28'),
('5c397c073737d8a8b669c1b3e6', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 01:33:42'),
('5cf4db667f45e8bc32fe36c281', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 13:25:19'),
('5d5cb2a0d95afb7391ee270cff', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 08:26:35'),
('5d5e27ca9e45623eb64124f574', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 03:58:05'),
('5dfb82ce7ed2d26b8a3ca42d2f', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 13:48:33'),
('5e1395c695bccea442fd2381d6', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:25:49'),
('5ef804b74db90155b0c3639268', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 18:21:57'),
('602fde9a35381f4ec21cde7a10', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 13:56:21'),
('60b5666bfd76542ab3e6bfa0d2', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 01:30:18'),
('60ea16bd9673b1e31ccdf11c2b', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 01:22:59'),
('60ec20bef9ccf96cb73fab4f69', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 07:32:39'),
('615724f6b53a9040b7c3716c91', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 13:29:05'),
('617b15e86e74a803e6e3dd6fb3', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 16:29:19'),
('61cbddcb787c4bdffb82103028', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 15:45:21'),
('61e09245cb8fbc3e62fb766bb5', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:10:08'),
('61eb9d456c24e63bca65569ff1', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 21:15:30'),
('6210039f6e4a56b9ec7d0b93b3', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 16:29:29'),
('622e6c4439cedd8b37e76741ee', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 13:29:50'),
('62bab920f6fe0f43c4df48f101', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 03:58:02'),
('62f323e5bf2135bc87c0dd78cb', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:01:39'),
('62f9c73df4ca4532365c81553d', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:22:23'),
('63587b98dd97de299013bd0884', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 12:51:39'),
('6386a2b38b8212a40e56fd4673', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 07:16:28'),
('6399b9a2791f7b05f4d30d7979', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 22:47:42'),
('639c055034954812c2d3471dbb', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 21:15:26'),
('63e0e204c9adec29e16ba09bd5', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 13:56:24'),
('63fd5c4f742b4945b2d330fdce', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 16:29:30'),
('6402ae2c8aac53cf26268f0ef2', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 10:01:37'),
('641992b40d86d4af5aaa785cc7', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:30:59'),
('6447a01f3abe159674c267996a', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 13:49:57'),
('648bb3ce5e02f87bf2498c85f4', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 12:53:06'),
('64ce99994271a8ee184531836c', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:50:56'),
('64d4eacd35775d74bf86ca2bb1', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:01:01'),
('653301ea836c13b66817143e94', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 13:22:12'),
('653dd9b8c4a632513278e114bd', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 21:15:15'),
('65595b41365f781f0516fc4cb4', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 11:09:40'),
('656889a73d656802330e8e665e', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:57:54'),
('65917c9c5fce7e864464b86c9b', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 09:46:47'),
('65920aa5b7ad2bca45a0583947', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:10:08'),
('65de2a2c6127732612774bc66c', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 14:19:40'),
('6605b6f86bf0e9c36775c76059', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 02:19:24'),
('663ef6264d00c8b0e7126e68aa', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 08:26:34'),
('666c77617dc4026d044b31f815', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 23:48:16'),
('6746b44a7ee78fc2b616666d2d', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 21:15:18'),
('67b627213ce7ce9a78fd1c531b', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 13:08:41');
INSERT INTO `oc_session` (`session_id`, `data`, `expire`) VALUES
('67c021ea0d512c7dbdfc289454', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:10:09'),
('6827a3a181bb92805ea9e0d309', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 04:29:16'),
('684213b63f27166db11e6c31e1', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 19:22:24'),
('68827fbd521115b9ba203dbc9a', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 18:15:08'),
('68b8764f6b8f829cfab0525dbb', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 13:26:45'),
('6900e628b19d2b54e5926bf6e7', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:59:13'),
('6920bab851823a5f2ce731e84b', '{\"language\":\"en-gb\",\"currency\":\"NGN\",\"redirect\":\"https:\\/\\/www.wecisclothing.com\\/index.php?route=account\\/transaction\"}', '2026-11-03 12:37:56'),
('693d5bb93870ccf100ba38acdc', '{\"language\":\"en-gb\",\"currency\":\"NGN\",\"captcha\":\"8641ca\",\"redirect\":\"https:\\/\\/www.wecisclothing.com\\/index.php?route=information\\/blogger&amp;blogger_id=3\"}', '2026-11-04 06:24:18'),
('698546e90f51c15d48f47598c7', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 16:29:32'),
('698e2c56ce22db9786627d5da8', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 18:44:50'),
('69961c320e88b8a15e3704d737', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 10:52:48'),
('69ecec33fc63e3d60453d32412', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 13:08:43'),
('69fc67ee373e5ba1d3959a4210', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 18:39:57'),
('6a2a13a08a96bc6d7134cb8c59', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 06:41:30'),
('6a88e23f5f5b633ce731eac72b', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 16:29:26'),
('6ae11809f218e4a3fb2477a848', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 16:58:20'),
('6aede515ce3e6a90070401defb', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 12:38:39'),
('6b500f8c4eedc7f5b7b7cb3b5c', '{\"language\":\"en-gb\",\"currency\":\"NGN\",\"redirect\":\"https:\\/\\/www.wecisclothing.com\\/index.php?route=account\\/newsletter\"}', '2026-11-03 11:58:21'),
('6b5774575a67f7de7af279ecf7', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 10:45:53'),
('6b95d2aaa7bf3bf06e5fef80a6', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 23:48:02'),
('6bcf0e3f2ca73e9bf20e7d8da5', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 11:19:16'),
('6bfcc8e48f70909d26dd6a5da8', '{\"language\":\"en-gb\",\"currency\":\"NGN\",\"compare\":[]}', '2026-11-02 19:00:09'),
('6d4ca33491bb76d851f2d7cb6c', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 12:08:59'),
('6db3f42be8f1ec9a903095a3a3', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 15:46:36'),
('6de4be847b8cb033df0df6e83b', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:00:37'),
('6deff6f4100c24ae1b61d9d563', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 12:38:22'),
('6e73a2c36fc0c4ecf01160c16f', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 07:32:40'),
('6e8edae7c17d6e54a7c4ce7c40', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 16:29:31'),
('6f0891fa069bc5c7b0cf29aca1', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:24:05'),
('6f37420b578fc1e09e270377ab', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 10:47:45'),
('6f6575b993d707b282c4c5916a', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 16:54:52'),
('6f7c296370b5ad53032c2823e2', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 20:05:06'),
('6f83a6183cc81c40a90fbb70ae', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 05:39:09'),
('6f965a656885b0a050a2a5bddd', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:31:16'),
('6fa2b5ed58a8db8e730ec4cc34', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 19:22:31'),
('6fd19229e05ac576dd6ee845e5', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 10:42:52'),
('6fd64bfe7f0af8b58c8f89876d', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 13:46:23'),
('6feab8ac542c07ce307c8df7a1', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 04:19:46'),
('6ff00e9d4b1f8e6b300fb3f3d1', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 14:19:46'),
('701c5a568e90f43a860683e2a5', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:03:33'),
('70fae792c380dc1b7179b3cf5f', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 05:52:21'),
('71062fb095231d5745df235a10', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 12:53:29'),
('7109084129da00320fd553b2de', '{\"language\":\"en-gb\",\"currency\":\"NGN\",\"captcha\":\"cd0bc1\",\"redirect\":\"https:\\/\\/www.wecisclothing.com\\/index.php?route=information\\/blogger&amp;blogger_id=3\"}', '2026-11-04 06:42:58'),
('7162c534da08b122879ec6a7af', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-02 19:12:27'),
('72a1744625342a92afc4b3f1de', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:35:16'),
('72a80cdf7728bcd8f16e47a9f7', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:25:30'),
('7326bbd4c7b7cd8dbf9ec64248', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-02 15:12:02'),
('736086a1721cce0afb10194153', '{\"language\":\"en-gb\",\"currency\":\"NGN\",\"captcha\":\"2c0858\",\"redirect\":\"https:\\/\\/www.wecisclothing.com\\/index.php?route=information\\/blogger&amp;blogger_id=1\"}', '2026-11-05 03:01:12'),
('7380c21c6a343c4bdfd6852882', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 05:36:44'),
('73c0dc2c26bb151b6c9064a938', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 05:51:43'),
('7424ec80969d9648a031432fe9', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-02 23:32:27'),
('746110333d3dc20cb2589af2cb', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 16:58:22'),
('74ade3f1585cc83faa3798b327', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 23:48:28'),
('74c2ff0e77819c034b53413774', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 05:37:08'),
('74c72a246c35fde5883b73b802', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:00:23'),
('7506650e7c1b10144e5fa7b1b8', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 23:48:20'),
('7507017746ab19f0024709476b', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 04:59:14'),
('7556124adac0d1609a6d4ebf13', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 23:49:04'),
('75c022340c7274195bea08747e', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 05:37:35'),
('75c3fd9d30452b86d33a74fd52', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 13:21:53'),
('75d90a366d3639b6e5cc2dc817', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 01:30:10'),
('75e8206aa68b455ebd9aa6d073', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:01:08'),
('762389be1545b14dcfbcadc3cc', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 13:16:59'),
('763fe63a4ad42516ea30464af1', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:30:56'),
('766af4ebfeaea6fd109a4f3307', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 10:42:53'),
('7678be41a4bf89917223fcd163', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 16:01:21'),
('76cf316999fb875b6e59dd27de', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 16:29:25'),
('7743cb890529a8c11526fd29e0', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 01:33:52'),
('77bfaf2ee999e4c6a6157cfbe9', '{\"language\":\"en-gb\",\"currency\":\"USD\"}', '2026-11-05 12:16:36'),
('78490a29d9d22544122d02cac4', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 17:22:23'),
('7866f8a32d6af2acff087505e1', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 14:19:24'),
('78780c09dd06c1d5988b3e6fd1', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 13:45:16'),
('78c1ca718d6d7fbcf4aeeef92f', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 15:05:14'),
('7915287102843f2b38edd9f8de', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 15:22:06'),
('79312591703aceaf945988b844', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 12:01:23'),
('79ce8e10a0e351150d317b30cb', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 04:29:03'),
('79e2fa0bf3f00ef48b3ac5aad5', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 01:30:17'),
('7a0861422f5286aa508eead388', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 19:08:30'),
('7a97c8ee7e38a2cbbbc295a6fc', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 02:20:17'),
('7ac1bd3d930f486650abfd40be', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 18:44:35'),
('7acccbc67baca2bcc21cec1b7d', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 22:08:59'),
('7b3c0113553fba53134f2ad8da', '{\"language\":\"en-gb\",\"currency\":\"NGN\",\"compare\":[]}', '2026-11-02 19:15:38'),
('7b9365a03dfd47973fd9997f16', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 00:25:12'),
('7c1dc93f4c89a821c87bc5c581', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 17:10:22'),
('7c426a8e3236a1e3fe19dea0f2', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 14:40:43'),
('7c48602dc5483268bfe80e07ba', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 00:25:18'),
('7c5bb38f80f8b39bcc54459314', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:51:01'),
('7c638f55ab894d593a6e50ff2d', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 05:36:44'),
('7d236d081850b31fcb0ff2f701', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 13:50:03'),
('7d3cb4eefd7a8dd51d6525611a', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 13:50:18'),
('7d4e66ba2769ae2d40cd4dc911', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 04:20:00'),
('7d5890ea0c9c6c15a3157eb393', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 22:41:34'),
('7d5c82d6c9daa148a3c50fe1ec', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 22:09:08'),
('7d7491394a0c9d001b50123116', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:30:50'),
('7e159a0ce0071383b04d8b2eb8', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 05:38:48'),
('7e25ff01ce703030ef5bd9ffc6', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 10:47:06'),
('7e5d33fc23f376097d9dab17b2', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 13:04:27'),
('7e6a5d464e82565703e1e794a7', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 14:40:55'),
('7ece9faee62d2f2f9bbdbf0c80', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 17:10:28'),
('7f36c892ba21a4c27c1be84203', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 22:40:42'),
('7f5550f70161c3a4d88435be0e', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:02:23'),
('7f95a7a9115b475b620e3edb52', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 09:54:58'),
('7faff85fa1568a5236214f24ca', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:34:57'),
('7fda51298813537236e6a5481b', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 01:22:00'),
('7ff0c5aea9dcd865cd6ddf9ec6', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 04:49:23'),
('802a2b0790f404fad180c78eb2', '{\"language\":\"en-gb\",\"currency\":\"NGN\",\"compare\":[]}', '2026-11-02 19:00:04'),
('803ac77ef05f84f6ac39e494a2', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 13:28:57'),
('803d1c17fd4b95b9f6c0c35dc8', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 08:26:17'),
('8040c15d46f8fcd743592107fe', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 17:10:27'),
('805d4afc5e4f062198358b5cc0', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:37:07'),
('806e16ddb6c53026f4ace5f10a', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 17:10:21'),
('8079dd0f6a6fd569ad80fb2804', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 18:44:59'),
('8092a3403287cabd518f9baf2d', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 14:41:29'),
('80a0eccbe78af5d602a2fbef2c', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 23:47:50'),
('811edd4f6a18cd9c4dab50236d', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 12:58:31'),
('8197b0ddab1deed7277824ee54', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 19:28:54'),
('81c742a6a9bf74d56b5681d731', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 16:29:21'),
('8212a5f67951537e802e1c105a', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:57:57'),
('8238d5e50eb80770b47650decb', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 22:09:08'),
('827cec38cf7e96716664192d9c', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 04:20:04'),
('834b9002d2c23e2e09b4495f7e', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:03:21'),
('83631f88da1692e0a4a3729717', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:59:20'),
('8398a5b92c668aa3cac9d4daad', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:50:57'),
('83ada4cd8305c8466abd0d8fe7', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 12:38:05'),
('83c6a771328bd7621257367a8e', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 10:00:19'),
('83ceb96a107acd30a5c8412e64', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 10:42:35'),
('83fbca08e4616f65085b540bca', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 14:40:56'),
('840eccdd6f5a85b52a74c9d77a', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 19:22:38'),
('844e0ce9a08bb1b6d43dff9e5b', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 06:42:58'),
('84ab35f036a8dab9ca08b6e310', '{\"language\":\"en-gb\",\"currency\":\"NGN\",\"captcha\":\"93349c\"}', '2026-11-02 16:46:16'),
('84e5551485fd18bd085fefa56f', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 01:33:56'),
('84f476f4315e8b6dd2f8def3ed', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 13:22:12'),
('854c94961e9985ec7bd8f52984', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 23:48:35'),
('85544fb51cf92eeeddb782d9c0', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-02 19:12:27'),
('85bf7103b3023bac42b9ee2640', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 05:38:05'),
('8629d0244ef53e36af82abaf67', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 12:53:30'),
('865b061bcb6f95b219ba794261', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 21:15:20'),
('867f68da44b6a8392674b21714', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 22:09:00'),
('8688105ca5fee5b65c2ec49fab', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 18:43:43'),
('86d1062346320787cf631d3ad3', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-02 15:01:45'),
('86e93704254f6549c94a7e6945', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-02 19:12:30'),
('86f70a3ee9ca95a0b40573721e', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:34:50'),
('87147581d03ccdf8803547bb5a', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:00:30'),
('871956462bbb011c37f046828f', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:32:35'),
('87d9952eab2e70bb31c0c3bb46', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 07:28:32'),
('882a75c2fcb2b24c41a35a6ef8', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 13:29:00'),
('88b2f294f89a1049a4d9a4cabc', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 19:22:36'),
('898902d85c06415cec593a5018', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:01:36'),
('89a5c51e31610e349206a0afb3', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 07:15:20'),
('89ba9f3a2e9b59b4a870e0bb05', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 14:19:21'),
('8a0299bcca362be96e64195df0', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 12:27:33'),
('8a9406b2e597390da009414e5c', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 13:56:18'),
('8aba5b9f2961de93b06c2388a8', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 18:45:08'),
('8b23e6e8797811d7f9e551a0b7', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 04:19:44'),
('8b29dc7470094577791c75e3c3', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 16:57:56'),
('8b9f24f14dc9ba84db32a7f881', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 11:55:35'),
('8ba3bc220571a28b394cbf8b67', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 14:19:31'),
('8bb4630e4f8ac0142e9d1e472b', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-02 19:12:30'),
('8bc52014bacd07ff94344b85a8', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 15:28:53'),
('8bdbdf814ec1b6171d74975cf1', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 07:37:17'),
('8c5311d7058c91e1211305a4ea', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:31:07'),
('8c58b2786b138afe55cd7cf743', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 21:15:23'),
('8c5f0a208da0e00701d1b39123', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 14:07:46'),
('8cbfc9ab85ecc14837a8d7021b', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 05:15:47'),
('8dcdc015c47be20e87e0117ef1', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 05:15:43'),
('8de423961fb0845c40ab87a547', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 05:51:31'),
('8dffbf408a2384821f971e0a2e', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 10:22:58'),
('8e50eee8d7252e847c8f3c0cd0', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 01:30:16'),
('8e672d52bd03e074d9b79cda81', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:03:32'),
('8e7a0ca3df50f36dea9da0f06e', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 22:08:09'),
('8ea85b634687542009f8e7e7e7', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 09:53:50'),
('8ebc0940498eea4fa22f71adfa', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:32:38'),
('8ecc0daf04c6c8a0ef3ab16788', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:57:43'),
('8edd4517171ca439ba83d7c748', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 13:03:24'),
('8f38eba2352fb4944aead72161', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 05:39:03'),
('8f6bab14f21f5922de0b9e91c0', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 04:49:26'),
('8fac0881630b9f34d50d12b309', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:50:48'),
('90268f14586b4bdf3caabb1aa8', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 00:25:06'),
('90673498e6b6d52f5c8974b721', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:59:41'),
('908e637d1cc35b1b57f0816773', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:25:52'),
('90a4d5f13ef31126680366c85a', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:25:38'),
('90bb10849bfabb5f8b07aefe70', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 13:08:40'),
('90c1053f6fee97160207aea28d', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 16:29:24'),
('911dabaea1097cfae5daa0e2f3', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:57:47'),
('913498b7f48a767c970c084913', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 22:09:01'),
('914ae9ab78fd178e7de710f53f', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 04:19:47'),
('91798431ec7d133001da98ebdc', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 00:25:05'),
('91b258a771527a09f3444d833e', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:02:37'),
('91db9d16a9bfe6c946a34be5a4', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 08:58:01'),
('91fdd0fd3cc34c87830cd058f4', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:58:42'),
('9204bbb777a29ea99e7c06d8e0', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:03:24'),
('920a6091db443245261b0fa8d6', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:58:28'),
('924ffcb92b7d4f2f242a526315', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 10:42:58'),
('9252ade26d877299304a30c319', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 04:19:57'),
('9255e0629a99c266aaac03be6f', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 14:41:26'),
('9257eba7ac35d400b62f7dc22a', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 03:00:20'),
('9277be7290e549007cf8cbea0c', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 11:56:47'),
('931bee96742dedd1bf63f72afc', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 15:24:12'),
('933594663b66e0059935d82e4b', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:00:02'),
('936ef174e0a0d666a6047461e2', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 03:57:56'),
('93b3c79c7ef6b2fc995862c4b8', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 10:42:41'),
('93dad8b84e265dc701ddd4ef14', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 14:19:45'),
('93f2e285343b1d3991456ee6ca', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 16:29:22'),
('953aef98353ee25e29c4c39551', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 12:49:09'),
('95dddd9ab661a261dbfbb57977', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:25:33'),
('95f4289ccbb171656b0df1b12f', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 11:56:25'),
('95f6bd13a34545ab9634a27bb9', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 07:01:51'),
('96920e6bfa7aea8853d7da5a6e', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:58:25'),
('96e6cd94a75e4d3425e24cab55', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:10:27'),
('9709306e9f1e679e36834fcb37', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 13:29:12'),
('9762b8291ee284d8bf83279f4c', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 15:45:22'),
('977ea57ec2438f5bcd48fc70c0', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 13:00:20'),
('9788b2fa14b4d5f80fa0e8a513', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 13:22:17'),
('978b1e1c76b685f5ddcfcef6ac', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 23:12:49'),
('979e68e634dd6a63f2b36b9379', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 15:22:44'),
('98f88fcd637f9ba0e4ba389c55', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:01:43'),
('992d1fb0f1241bfeac30c677bb', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 05:15:52'),
('993184cb16c3520ac0d2c363fb', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 09:55:53'),
('9945123707a164e9240310b9bf', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:01:59'),
('9a8be0945d0be40c546ecd036e', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 16:29:28'),
('9ad809f2319ef1420f007eee1a', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 01:33:51'),
('9b35d542a9af2c42423de5b87a', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:31:00'),
('9b95e02d9d708c9f00223b9b26', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 18:24:06'),
('9bb49f0b9832e3852aad076535', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 16:01:24'),
('9bb5d26d2d646c9e399c76f6ed', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 13:56:15'),
('9bbd4e1664519cb3347f80415c', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 12:07:11'),
('9bc6a2a63fab0e83256fdcefc6', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 02:19:47'),
('9c6bd220b5148a6adfa7562321', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 12:38:12'),
('9d01cf5f9619ba570e3e973546', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 13:18:45'),
('9d0d8a79031ddde8b2f61fcd4f', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 15:45:22'),
('9d8da75e95385f74b86ffe01c5', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 01:30:15'),
('9e365445ecf0de2bce43a9ad5d', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:58:49'),
('9e8a81465b9fc1e32d703d7c1d', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 18:15:48'),
('9e8d880acceced4a0bc802f236', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 16:29:19'),
('9ee1e25bac801dd237cef100db', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 16:29:33'),
('9f035355d4c1fdefad8a8cd064', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:03:20'),
('9f05830cce36d573c54f1c46cd', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:59:52'),
('9f64dfe72f906c523fd4e9eb14', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 22:48:35'),
('9fd2ae36ee2628a638e735051a', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 08:26:18'),
('9fe3bf19b867afa78e937043c8', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:32:26'),
('a02289ce5100d9d60d99bc5a83', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 14:38:52'),
('a03629cac87e2af23d3f34b851', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 19:29:08'),
('a04f2590fe454a7d9de8ea0087', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 15:29:10'),
('a09846bf324d45461b888b035d', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 14:34:01'),
('a0c601305dbef50daae95e6991', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 10:42:50'),
('a0da3e2a58c1b06917eabf1df1', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 03:58:12'),
('a0e3f3ef06666083a877b1d70e', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 13:46:42'),
('a1046840597e89be12f6e87f5f', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 04:32:11'),
('a14456c432e016dc94043e61da', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 04:29:13'),
('a152375ff051833e42892257db', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 09:27:09'),
('a16190417fd3cadaa326e88d0e', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 10:38:32'),
('a18bcb3b87182db87c0fd3db01', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 02:20:26'),
('a1b7672700c5415b70e313f412', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 23:47:54'),
('a1c701b65a12ac465c8e8ec724', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 13:22:13'),
('a1f0a745cfaecd25382d6d19b8', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 22:46:32'),
('a2352f7860b9210426b04890cf', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 01:33:55'),
('a242ebdac0510106d2148f4863', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 03:25:29'),
('a294d3a8a5bc26003ee8d79917', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:25:26'),
('a2a682215c9f00ae904ba07d10', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 08:26:24'),
('a2fa31770fddb1f1c8d7e52b3d', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:25:29'),
('a3387c115f32a6cb36175164a7', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 13:28:58'),
('a36bef32567e626ab90670de09', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 01:33:47'),
('a3b577bee22aa393da5ed582e2', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 12:28:10'),
('a3c1ec028f9de27a084661c241', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 16:54:30'),
('a3deddacd44c525a0607c77229', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 23:48:13'),
('a3e7d4e16d9ebcf4096be4c379', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:31:03'),
('a3fe2d3bcc9cb5e6f0af4335b1', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 03:58:07'),
('a420f9b9785655711665b0625c', '{\"language\":\"en-gb\",\"currency\":\"NGN\",\"redirect\":\"https:\\/\\/www.wecisclothing.com\\/index.php?route=account\\/password\"}', '2026-11-05 02:50:54'),
('a44f4de52d1164e17abc365d66', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 19:07:57'),
('a4c14039131e58e388c55cfe77', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 13:49:07'),
('a52a35f99125c3fb40adc1efa4', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 08:26:29'),
('a535c9d8ae85cb56d488c5d70a', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:03:28'),
('a5be878846c19aa607dfa11ea0', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 13:16:19'),
('a619c444eddd74c55e3818e606', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 13:27:39'),
('a6260c45f7a8f209c9e23eb408', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:00:51'),
('a6322205b25de53062acbdde53', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 08:57:58'),
('a641c0dff0c4be406fdfdf845b', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 13:08:44'),
('a65144af80853e21536c826e31', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 05:55:09'),
('a67f495a43e9f999898bbd2c28', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 11:25:29'),
('a681a83de9da6566ecbab05ab2', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:10:55'),
('a6d14d3660efd1d75ea0474422', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 10:42:59'),
('a730f4bb9bfc16a9457e9f778b', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 08:58:31'),
('a745b025661dd45acad76bffce', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 12:51:52'),
('a785b361017a69029eef28aaaf', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 09:45:18'),
('a8187eb87825720f65da195a93', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 23:48:09'),
('a81dda556c9df242f6c2a71b70', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:31:01'),
('a87aa034205cd945b29f5198b1', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 10:22:25'),
('a8a001d2281352be629467f5d9', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 04:49:29'),
('a8b81dcd342c5ba1cfd3158d24', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 05:15:38'),
('a902a1c29deff8c1a5a8e6495e', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:30:55'),
('a9294f76c5e50aea4ac1f83410', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 07:01:50'),
('a9cdc065997590c18906df0f02', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:58:18'),
('aa6d7971633ccad42d93ddafe9', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:00:27'),
('aa8c3f0abd861ef6b450a2308d', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 18:40:35'),
('aa8d4199904613cfeac3384056', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 14:41:05'),
('ab1b96ecb1c4bfd6f8238e84cc', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 09:53:11'),
('ab35a5417a3b21ea0a7773ea75', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 19:08:19'),
('ab762054e7026e521d9ac2f5de', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:59:10'),
('abee7ef217bb466cb10b42439b', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:10:08'),
('ac0746a9b97235f53ca5d999f0', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 12:02:23'),
('ac384974f1160abeeb63cf89a6', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 19:28:57'),
('ac42c80e1ca6432e473db4fd6f', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:50:44'),
('ac7e22d121ed096cf1d00c53d2', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 18:26:32'),
('ac99b65db8be287a924f4ef0b9', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 16:58:19'),
('ac9b2b7a55bfe8b07c5557196d', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 14:17:30'),
('acccdbd9911775a8b1f5968d7b', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 22:48:23'),
('ad1e931a2d7ae7b76d3d7a0533', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 21:15:24'),
('ad59d391a3c3972809be8ba5eb', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 15:45:23'),
('adebf23caf6d7f36c426c15925', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 12:53:13'),
('aded74308a40cd176ddfecba15', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 02:20:18'),
('ae111500f7abdb7cfe326c92cf', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 10:50:01'),
('ae7d956e6c3503de6900a84a68', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 23:12:47'),
('ae8d1577b524f3ecf618a73a0d', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-02 14:20:58'),
('aeaa9f182f38f20091f8836d06', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 23:12:52'),
('aeb558e7790345218ef27af782', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 04:59:13'),
('aebd3c1ec95088d1c1f33fabcb', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 19:08:07'),
('aeceadb17a9307beb348f1b4fb', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:03:25'),
('aed8abcb14a1666fe82ad3f77c', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 04:29:20'),
('af3eb232d42d9610ddf56b9352', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:02:20'),
('af4d2c20c62ca3ac44e4c00dfe', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 07:32:39'),
('b003dffe3fa0b24b3723af4945', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 16:01:20'),
('b0347d867a502e8d2bbf843dfa', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 01:33:42'),
('b10707239c673d161be0b33dc0', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 12:28:51'),
('b195fa0ec6ef21e4e9b131a760', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 02:20:31'),
('b1d123956b26c2d9508966e0fb', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 04:19:42'),
('b21d9112cfc91088e744665569', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 05:54:03'),
('b23f3b89b1d7e5dd04e777c2ab', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 22:45:25'),
('b258140f28ea8ccae9f729af57', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 04:19:45'),
('b26a6b7246d19f34364013dde4', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 05:15:51'),
('b2762d6412ad18f47a7677ef5d', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:35:25'),
('b2cbadcb8a30288a58a0ef5568', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 00:23:41'),
('b2f58f7d12e6e1598c980e1ef3', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 01:33:43'),
('b327b4982899915fc9bd64a2c4', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 18:23:11'),
('b340e46c801c9d1b07a1a3b348', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 13:29:01'),
('b34707b29485724ddc15259fc4', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 03:00:20'),
('b34e62b0007405a9a46fc820b3', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 15:40:33'),
('b3510721f13f66c623046cce05', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:01:05'),
('b357006d5af10ccbbc33f4af17', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:59:59'),
('b3bb4b719287d8a1954d02cd3a', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 15:30:18'),
('b40ca6286220e5b0c2cee2f803', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 03:57:59'),
('b41898c072ed6ddf0ac9f07602', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 13:47:27'),
('b4351fc53988eb89090611d543', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:50:51'),
('b44c50d22371d3e104e8a6d3f6', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 16:01:17'),
('b4f4d75e7ad4f8f76425e2dfc6', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 18:41:32'),
('b4f7371ce015f636cdfb700ff5', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:25:32'),
('b4f84fb17335e654e20f0ddc7f', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 13:28:40'),
('b55ed2cad50ef8dffa6723d5ea', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 14:05:42'),
('b59abc80a1cc580614b1cacd4d', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 14:50:46'),
('b614a0bfe2a8a6869cda3f1f86', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 03:58:10'),
('b659318256104d6b4ec7d1c4fc', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 14:08:15'),
('b6a166a660e9e3b3ebd2718e1d', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 13:56:22'),
('b6b688dac0cfcaca809c5bb065', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:00:58'),
('b6dac89e97d04b7ee394f8cd31', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 13:22:16'),
('b75687ae46feb39ebffbdcbefa', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:02:33'),
('b7633f1855686342f0fe38bdb8', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 22:08:43'),
('b7912572824ba8a7849dbc41e3', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:03:29'),
('b7c15309bea0aa1e87c9f8be96', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 22:55:11'),
('b82a37548cf2b8ab035a15e7a1', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 12:17:21'),
('b852042450d9aa7fcacede985b', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 22:46:17'),
('b87656963c8976562789a2a3b8', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 10:35:24'),
('b8826b44054034f860612ab348', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 22:08:09'),
('b8e13a8118fc7e49fabf54f382', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 16:57:55'),
('b8ed50c1f4ceecca11be876975', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 16:01:19'),
('b9117839c258e2f8fa80fac6ce', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 04:35:06'),
('b92182c6b79fcfe01aaea6f3e4', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:25:34'),
('b958cf04a3bc7e4c9e93b63215', '{\"language\":\"en-gb\",\"currency\":\"NGN\",\"redirect\":\"https:\\/\\/www.wecisclothing.com\\/index.php?route=account\\/wishlist\"}', '2026-11-03 10:42:54'),
('b9673e8c898d380f26ed96fe45', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 19:22:30'),
('b994b06b612f324dd56b530381', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:58:21'),
('b9f78138eb39731fd191595a37', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 10:47:32'),
('b9f7df3ed48729aa5dfef40fc3', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 13:22:14'),
('ba3602a23497f2bb24e080aba2', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 08:25:47'),
('ba4240cc44aa88b5b52fea55ce', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 14:19:01'),
('ba4d38b3beb1250fc5a356aff3', '{\"language\":\"en-gb\",\"currency\":\"NGN\",\"vouchers\":[]}', '2026-11-05 02:57:50'),
('ba543e545743feb16bec26d5ff', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:03:31'),
('baacdddc435b0b631d2bd1cf74', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:00:20'),
('bac5702f1c29d7f93f0e5fac69', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:30:50'),
('bb5c040bef4f6ad627d45c3d88', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:58:32'),
('bc66204515302cc6d2d1e5393d', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 10:02:58'),
('bc77f985c7a5d90d5ed28314b2', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 05:15:34'),
('bcf959f9d4abc43d555fa01675', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:10:09'),
('bcfa65a16df09da48f6188e7be', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 03:57:55'),
('bdb552724c8e69539aa536fb97', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:10:23'),
('be0e4a159d694f8a21c1945bcd', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 13:26:22'),
('bea310332dce3a866878cf7d1a', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 03:58:03'),
('beaec1b72949cdf31bfaa3c9eb', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 16:29:27'),
('beaf6eaa24fbb025867db696a5', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 15:46:36'),
('bec268e45a854e8ce923a799c2', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 11:03:43'),
('becda74d0c02021a64785e90ad', '{\"language\":\"en-gb\",\"currency\":\"NGN\",\"compare\":[]}', '2026-11-02 19:15:30'),
('bee26b62391c47aa5c61cd527f', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 21:12:57'),
('bee6d1d400299a248479deca36', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 03:00:20'),
('bf072c79e6f6c48337a86aaf84', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 22:43:03'),
('bf2f59342799c0a2ccdf8bd81e', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 13:26:08'),
('bf76ae1edc8d311cdaac3eae5f', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 05:37:54'),
('bfcc0bc1044b8ef90e1b980122', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 08:26:12'),
('bfe3361a21156e6c4b3caa601a', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:51:02'),
('bfeb6fea7c572fea339b1327e5', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 17:03:49'),
('c059b17e0c7e26b7b49ab90ce8', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 12:37:41'),
('c066cd76f8ef2a795bc9a60dd5', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 08:58:00'),
('c08eb66bfa94b3c917aebffb2d', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 13:39:43'),
('c0bb1bdd788db53574c0d21d47', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 16:29:33'),
('c0c0fd741f92f587102f2b11ee', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 00:23:40'),
('c0fb1dae0dd5252fea3de1dd51', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 08:26:27'),
('c17f0de18a455b6273af99e99f', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 22:45:41'),
('c2aebc406de014d7f54ee1aae5', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 16:54:29'),
('c2eec01ff9e50bd81ba69c5e6c', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:50:44'),
('c2ef79f1b1546a9f543711e900', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 06:28:53'),
('c33acf9055a61b8c1480a4a35e', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 11:31:46'),
('c33fc8b71b2eaad27c91cd59d9', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 10:52:46'),
('c36d6297f51eaeac00252fddf1', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 02:20:30'),
('c37d83ee617ab48834bdb5541e', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 03:00:35'),
('c4a7f6fc52bcaeb1864cbf6121', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:03:30'),
('c4bc29b2d9ff997f3bd3c5fbfb', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 10:05:37'),
('c4e01e41c1b9411bc8d4f5f24e', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 13:22:20'),
('c515f1d7fcf6939139c5cb4673', '[]', '2026-11-05 12:54:41'),
('c55c1bcbdf9e294c71a6477957', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 12:18:10'),
('c56f378a4af6950fa3d7e7f4f4', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 14:18:54'),
('c5b26b0ee833bcffdcf23993e8', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 23:48:34'),
('c5cf7c8df332aed5db5d7bd99f', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 10:01:51'),
('c62bf6ed06ec08b60ddcc6ed63', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 03:00:25'),
('c6670aa44d918c120f9bbd7e80', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 19:22:37'),
('c672a982dc8b323efdc11f73c4', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 19:07:59'),
('c83f4e1ce150ccf1df041c63c9', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 16:29:36'),
('c859ae4d6e1fdb7aba08298704', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 12:08:18'),
('c88b0fa0e47f0b2849597b44fb', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 10:44:57'),
('c941760a9ab6782ac3f03f1876', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 10:42:47'),
('c99cf0a7b8357c376e7d61aaad', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 05:15:47'),
('ca01c08a11929fb43adb578417', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 12:28:26'),
('ca44042d452121efa2b1298c7c', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:34:50'),
('ca814101b4c92743f368a4c64c', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 09:54:24'),
('ca9bae4442c315de5234b4fd5d', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 01:33:54'),
('cb13f1b3b2e5235187af95698d', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 12:02:53'),
('cb322c062b4582eab5cdca0f45', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 19:22:33'),
('cbe5518fe57d0901cb3747b1b6', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:32:37'),
('cc07b1aaee6be5bec7055073a7', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 03:00:24'),
('cc22d2488e946d9b966d61e286', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 13:49:26'),
('cc5699aedbee492f7788de6c80', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 16:57:53'),
('cc71cdb8045ae653badc30be8a', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 03:00:26'),
('cce906923507d1a96c64ee745f', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:01:56'),
('cdc27d96499add15ca71d7ce06', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 09:56:26'),
('cddfc618d9b96f84915f399aa1', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 13:56:19'),
('cde8dc8699c2344cfd7380eae7', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:10:23'),
('ce1fd6b61a29172a1e7e725d84', '{\"language\":\"en-gb\",\"currency\":\"NGN\",\"captcha\":\"6010db\"}', '2026-11-02 14:20:37'),
('ce4f76a69d08004fcb5938e4b4', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:30:52'),
('cefa50b60c91e2f2591214b8a4', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 06:51:00'),
('cefd979af842577708cfb75be4', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 08:26:19'),
('cf0d7652c35a018a9b0bc38538', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 21:15:28'),
('cf1d6be2fe47df2a696affd7ec', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 22:42:03'),
('cf90f2a738db63e6ad1aea6075', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 22:47:15'),
('cfc9f26d53691aa29e5e4bd072', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:25:39'),
('d03e3744f478091cfa4c6139d5', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 14:41:20'),
('d03f90dd10f198d35dec99daa0', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 12:53:10'),
('d0540bd7af5630df7624c90ec7', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 00:25:16'),
('d06269db052b04acd02f40e692', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:59:31'),
('d0a2a300ef2a4227d4f5d5781d', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:43:32'),
('d0bfffc39ae1e01440a1d15c2e', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 05:15:39'),
('d0dbb868f4974c862827c84241', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 12:53:17'),
('d0e4ba938ddada3a7186252be5', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 05:39:00'),
('d146c36b959ac03accd1db3ab5', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 17:29:14'),
('d158ea2527b06990d6b1197615', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 04:49:21'),
('d15e19e5576b7d726c4cc00e5c', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 05:36:28'),
('d181fcdba915295009dad1c74f', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:00:41'),
('d1bce36cf337f86d3672f04bc0', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 03:58:11'),
('d26daf7c18e8a06b396e85e635', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:37:09'),
('d32907a4f1ea95d85276722dae', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:36:18'),
('d39c6e2693215fc658cd20990f', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:30:51'),
('d3a2317bc07a9624c5c3901846', '{\"language\":\"en-gb\",\"currency\":\"NGN\",\"vouchers\":[]}', '2026-11-03 10:42:43'),
('d3e1e24ec20229aad424c300e3', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 15:28:53'),
('d412aa764d0a0558fb94669f93', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 16:54:40'),
('d46414316e5f6a77d6d3176900', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 13:08:41'),
('d494945be0707105f697d2f3db', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 23:25:58'),
('d4c2a308e176d0e2e57ff295aa', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 13:22:19'),
('d4fc2d8e4f9df087514274d145', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:01:49'),
('d54bf430f1e03bd358b5cf9985', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 19:29:11'),
('d5997af181f6e22db0719762c8', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 16:57:55'),
('d5a1e831c9f64220b96fc04290', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 18:12:17'),
('d5aa112a032a71579de303e6eb', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 03:58:13'),
('d5c02d2436ff6e3432c2677aeb', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 10:40:44'),
('d5cafa6aeaa79709c0e62b6dc1', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 12:29:08'),
('d5d1dd98b42a49841a2ffa3089', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 03:04:56'),
('d5e3258c8b61bde4098afee4e3', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 04:19:42'),
('d676f16b71b1863c76f0338e6b', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 03:00:31');
INSERT INTO `oc_session` (`session_id`, `data`, `expire`) VALUES
('d694f22f6297b95bb18f480431', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:00:54'),
('d6c76a61d772621644562fbb5b', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 04:20:02'),
('d72bd738d63cd2ba59a14efc3d', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 22:07:53'),
('d761d1ecdd443766fc282f0cf8', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 01:33:57'),
('d79b8ed92c2d41f9db588e90d3', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:30:50'),
('d815720d5d1ce6bb143ae0528f', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 08:26:21'),
('d853565ad11335bf74b6a13eff', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 11:57:20'),
('d8586c5698110839d3faea47eb', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:51:00'),
('d892a3224b3458c90c45df19fa', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 19:22:25'),
('d8ae89a8ff7e18b3416c9da3a6', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 10:44:19'),
('d8fbd3df0e4830e2deba6a04a7', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 23:47:43'),
('d95261e34fc59d88252e3a4f95', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 03:57:56'),
('d96369b85febf51212112f1daf', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 10:24:01'),
('d965139ccbc61de295e8d41cfe', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 19:08:33'),
('d982278d3e1e52a81018928a1b', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:00:34'),
('d9f6f68e77c2553e5f5c0f7d60', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 13:15:19'),
('d9f87c6c1dcb35e4d9bfb8c097', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-02 19:12:30'),
('da27a824638254353c0f420462', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:59:48'),
('da3a020cc43876fc88b8f76519', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 06:24:16'),
('da40a815cd9ecf40a39258ee9d', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 19:29:12'),
('dab53dd8c47ce16acecba29ef2', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 19:28:55'),
('dad9c14e28136959a34f282514', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 13:47:46'),
('dadb1d0297727374fa39b5bcd0', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 04:49:24'),
('dae82529c7f4a446c3ed3fb480', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 12:18:25'),
('daf2dbeb1b497d1d4666e63031', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 21:15:16'),
('db3550f494721d89a224ae6330', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 13:16:38'),
('dbf40a2075157990b641d0e515', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:10:10'),
('dc0d54b1cae59ae31c6cf6328a', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 07:01:48'),
('dc0fdea2afe0b2f99715a1d8fb', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 13:27:07'),
('dc9bb39aca6574b27d25beaa80', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 22:48:14'),
('dcad09b684a3982e3785f31d12', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 16:58:18'),
('dcec9fdae45ef2fd01e8897afd', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 09:29:32'),
('dd69a314c418d96742de25d823', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 17:10:23'),
('dd732001590b4b641418e5af08', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 12:37:48'),
('dd9311438a60f15765162421f0', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 15:54:45'),
('ddd22da6b142abfc3e900894d2', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 12:07:42'),
('de22a14f1795cae8d8d763f50c', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:02:43'),
('de4ac1a53f8ca2fc7af7b22638', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 08:26:31'),
('de55ef611317304ae09ac358b5', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:32:26'),
('de5a18d56128d92925c6d5c0c4', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:03:34'),
('de71bb5dfa4df72bf1fd69435a', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 20:47:45'),
('de8d7884fea29963b66a025c88', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 22:09:04'),
('de8de7b9117f137b3528911819', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 04:49:28'),
('def20f267d9de59e927920f7b2', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:09:30'),
('df04b1391c6c738e90e0bbf5fa', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 13:56:23'),
('df0b0dad79d64165a826bf914e', '{\"language\":\"en-gb\",\"currency\":\"NGN\",\"redirect\":\"https:\\/\\/www.wecisclothing.com\\/index.php?route=account\\/edit\"}', '2026-11-05 02:50:55'),
('df3bd954613826a45400c6381a', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 19:29:13'),
('df4b55139033e4a6a1de13c1b4', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-02 14:32:28'),
('df4cac3da68cbcf42a7300ee2a', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-02 15:23:06'),
('dfb3656c0aa50ea4040ec56fcd', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 19:29:09'),
('dfb82f97dc037078cc87d9206d', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 10:42:45'),
('dfd7bf53ea9ef836dc26b339f7', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 07:48:27'),
('e03001d7a2a349cc498caccb0a', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 15:28:53'),
('e03b6ce5978b6fc92cef60cfae', '{\"language\":\"en-gb\",\"currency\":\"NGN\",\"captcha\":\"913e40\",\"redirect\":\"https:\\/\\/www.wecisclothing.com\\/index.php?route=information\\/blogger&amp;blogger_id=3\"}', '2026-11-05 03:01:15'),
('e0840f11490711ac644ddab9a8', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 04:49:08'),
('e0a9708fd2001f78f106aeb6fd', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 11:57:52'),
('e0d1388fb5f936082bbaec0fc6', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 01:33:42'),
('e0db5759aef695e5e35b26e3d6', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 05:15:34'),
('e0fa943449d097a63a963b485f', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 14:05:28'),
('e1233887b1b69b9c6a89e181de', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 18:25:23'),
('e139a579bd51c659e97b73bba8', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 10:46:48'),
('e17529a4c74e6917cb48c52d3c', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 19:45:06'),
('e251cbf1f32ee2b886fbcf69d7', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 18:43:55'),
('e25a2cf9495e52c5bf3ca09f00', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:10:08'),
('e28c824d385b1b60e5ac328af9', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 01:30:10'),
('e336e8b7aeb490202c8f020d5a', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:50:58'),
('e34c622085a44239465f981758', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 13:48:50'),
('e354c56a00a0741dbd075330c0', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 00:25:03'),
('e3e5d96082a399c3f40d350d74', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:02:03'),
('e4ade201acaae0d24241283672', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 19:29:10'),
('e4cb9ce3c8d8865248d5ff19ca', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 10:40:11'),
('e4ed60afb7a939b62677d7877a', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 17:03:59'),
('e4eece53bcc561b7fa1ce6cbd5', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 15:29:08'),
('e55a18369666a642f59bc46254', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 13:55:57'),
('e618b7e470082bd9565edc6102', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 23:12:47'),
('e61f782fac5b737933019ea98c', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 17:03:47'),
('e64c6cd65a87676dc9c3fa3fa5', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:59:06'),
('e6ccb0e0e3afb005d41b75ddef', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 05:38:54'),
('e77a2500ab4b832d4e812799ab', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 10:32:26'),
('e77d9a584690dc5fac759f5b56', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 22:43:22'),
('e79a337b94bfba8b0ee363bb46', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 14:40:42'),
('e7c353667d8ca2fb31cf8eb88f', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 04:29:02'),
('e814a6605d0b41ab97adae6382', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:58:08'),
('e82f1d19fae730005938cfa807', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 18:49:52'),
('e86121c34b49776e6dcf725cfb', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:58:39'),
('e8908bbcc60776e538be6e80cd', '{\"language\":\"en-gb\",\"currency\":\"NGN\",\"captcha\":\"2362f5\"}', '2026-11-05 02:58:11'),
('e9a28e1dae2668a1590741f481', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-02 20:38:49'),
('e9f32a75f8c059a2c9c719d350', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:02:06'),
('ea0d3abc30e0658464ff490ef5', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 17:03:52'),
('ea56900b171942df8889c06143', '{\"language\":\"en-gb\",\"currency\":\"NGN\",\"captcha\":\"5c2b15\",\"redirect\":\"https:\\/\\/www.wecisclothing.com\\/index.php?route=information\\/blogger&amp;blogger_id=3\"}', '2026-11-02 22:58:53'),
('ead95206ea765e5003ae3125f5', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 18:12:46'),
('eb5a7dbacbf9253ef2e250f8ec', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 04:49:18'),
('eb819ada0ee2a569abbdbaceba', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 19:29:15'),
('eb849e79e871bd38f0708c2cb1', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:50:45'),
('eb8bd8b69a178a05fd0307b67c', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 09:54:43'),
('ebb8afd34e3944c5cd4a7f27de', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 08:57:57'),
('ebff558a51b7b5b85e23c53b60', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 14:18:53'),
('ec604643feeb8fc52cd2bdc286', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 03:00:33'),
('ecc4b7b2f9b4a42e75cff1989b', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 12:27:59'),
('ed16e3f139f1421118ad4ef5c3', '{\"language\":\"en-gb\",\"currency\":\"NGN\",\"captcha\":\"89a5b6\",\"redirect\":\"https:\\/\\/www.wecisclothing.com\\/index.php?route=information\\/blogger&amp;blogger_id=3\"}', '2026-11-04 06:24:16'),
('ed9b20eb3631fdca7c99e00850', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 05:15:49'),
('edd950ba771dbf1e7d250ce3c5', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 19:08:18'),
('ee0328b980ca4207ad18be70b7', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 14:18:22'),
('ee21e031ed8ee4eebbde1e5f9f', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:58:59'),
('ee307cf6fd449dc4822ffc4c9f', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 03:00:21'),
('ee719f1219eee14c30c8c6fa7d', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 01:33:46'),
('ef0c116aa0353fdd32c325fa70', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 12:52:33'),
('ef145cf5269de391f3da69a22c', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:12:58'),
('ef69a358d597b2ae50c3ca7579', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 05:32:32'),
('ef88449906a9d22454e03d89de', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 15:29:08'),
('efa9396e004b351a8d0dba500d', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 19:08:21'),
('f00535680ecbef5218ddcce3c0', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 02:20:15'),
('f0bb80d1279b8b5630d5ffe2f0', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 07:32:39'),
('f0d007856540b49ef230dd0a85', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:50:52'),
('f1ac0e082cef3a5c0017b67cf5', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 02:58:46'),
('f1d783e1c13259ad76f2d73c83', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 18:42:24'),
('f1e3ca885fd465b779b833f595', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 23:27:29'),
('f1ff41ea6053cf6ded73c9eba7', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 18:44:13'),
('f24a45fbeb8f563bbd0d118ae5', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:00:09'),
('f27bdd2ffba6d8e2529f3fd586', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 10:42:35'),
('f2a254eb7034e443c88c2b2223', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 21:15:15'),
('f2c04bcf6e9d229cec48391786', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 17:10:37'),
('f2d081fbee58dca9b60c76ebdb', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 16:29:20'),
('f330270e32f28807756ae01c30', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 16:54:29'),
('f37951e248bbee92d72e548e6e', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 01:30:10'),
('f39d47eeeebe8cd8574e0bd171', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:25:46'),
('f3d36963b020d25df7c9406b62', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 15:45:25'),
('f3f37678ef4a5979a1a81f5a0f', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 16:58:07'),
('f47c619e39d0ddc60ff116254c', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 11:21:28'),
('f4a7b162da9adfa441a3fa2be8', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 05:15:44'),
('f4bd7baebbd4afd0eafc824b9d', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 16:31:19'),
('f4c8961bc116f242289f1dce48', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 04:29:19'),
('f507c7f61f584fb85b4567af73', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 22:08:55'),
('f534dd9250a26d743081662c3f', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 08:26:33'),
('f574395860c16f58dfc845f52f', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 03:00:29'),
('f5c7f8d40b0888c34af4b7f304', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 01:33:49'),
('f6ee5a14de08abb2967f1c682e', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:35:30'),
('f7146313d5a58209e95db65083', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:11:25'),
('f7a283f7ef071042c69473b16f', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 00:25:14'),
('f7b7e1719178372e05a38dee38', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:31:02'),
('f7da6326e59a48a0ba13b3b5fb', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 14:05:39'),
('f8515ddb8f534da040ecc4ed0a', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:34:50'),
('f8702d3c4120d472e5c2728ef7', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 04:49:18'),
('f871b5c15ec013f29f4f4f9839', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 01:33:51'),
('f8f4706195c9e0a54f4c6f7a8c', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 23:47:40'),
('f8f629e0b758b9d177c092e8db', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 23:48:22'),
('f975ff8ba13100950161bba7a2', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 10:52:47'),
('f97867c1ca0a1a224de2c7e572', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 10:42:48'),
('fa5b6860eefc70179f255eee84', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 05:38:51'),
('fa7239d49c59f0003ee2130ed1', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 16:17:06'),
('faa8365cb939495c2d6fa2872c', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 16:01:20'),
('faf2649bab582a34d9bdfa0d26', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 04:19:59'),
('faf8461de0e7abc8f84d878061', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 11:13:17'),
('fb58cc5d6e9b7431a489cec4fd', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 22:29:08'),
('fb5b671a12b0ce601907116262', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 15:24:13'),
('fb7a04a91b938850670eead0dc', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 23:48:26'),
('fbb63084803b8630d66f92f3e1', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 22:52:42'),
('fbef4a9d22f25efd5ebab3c122', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 14:19:41'),
('fc2c48c2d1a2bfa6fd79c8279e', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 16:58:08'),
('fc318cca2add642eedcf397ddb', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 04:29:17'),
('fc47fb59cf48cd34aced86b981', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 13:13:30'),
('fc4a9680e2f99b566923d1d396', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 13:08:55'),
('fcc7923268cdfffe9629c82440', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 15:05:12'),
('fd19767be713f0eb017a97009b', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 06:04:07'),
('fd1d5cd11f5cf587b6489f8d62', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 15:29:09'),
('fd39bab18e6fe82d28394ec084', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 12:52:52'),
('fd5d25a61a08ccdf158a1e8924', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 19:08:03'),
('fd6d1e173db72257ec28661835', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:01:26'),
('fd6deacf01cc8cf158f2791014', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 10:12:38'),
('fd70e94bdc86b73f1530128f55', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 05:15:50'),
('fd72c3095e9b166ca75ce3b3a6', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 05:38:57'),
('fdd811f68b3db913248bd07dfb', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 22:08:31'),
('fdf18ae4d12bb05a4d2fc84a49', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 18:24:36'),
('fdf71951ae537d50d809f58ed4', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 03:58:00'),
('fe2c43af8678c0320c4ee7cf47', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-05 03:02:30'),
('fe80d4aa6c68999b7ccc30b740', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 03:00:36'),
('fe891c8052fc6cfb634d56e988', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 02:20:14'),
('fea62bc81f098ea44faa1abcdc', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 22:08:57'),
('fec0ab5225d4aa5b1516927caa', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 12:58:36'),
('ff53f3ea0b131eb4c5bf08dbda', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 16:25:50'),
('ff633b31dbf9f245944754a787', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-03 19:28:59'),
('ffeb0aa29d062eedfc61e2e733', '{\"language\":\"en-gb\",\"currency\":\"NGN\"}', '2026-11-04 13:48:17');

-- --------------------------------------------------------

--
-- Table structure for table `oc_setting`
--

CREATE TABLE `oc_setting` (
  `setting_id` int NOT NULL,
  `store_id` int NOT NULL DEFAULT '0',
  `code` varchar(128) NOT NULL,
  `key` varchar(128) NOT NULL,
  `value` text NOT NULL,
  `serialized` tinyint(1) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_setting`
--

INSERT INTO `oc_setting` (`setting_id`, `store_id`, `code`, `key`, `value`, `serialized`) VALUES
(4, 0, 'voucher', 'total_voucher_sort_order', '8', 0),
(5, 0, 'voucher', 'total_voucher_status', '1', 0),
(6170, 0, 'captcha_basic', 'captcha_basic_status', '1', 0),
(11714, 0, 'payment_paystack', 'payment_paystack_status', '1', 0),
(11713, 0, 'payment_paystack', 'payment_paystack_geo_zone_id', '0', 0),
(11712, 0, 'payment_paystack', 'payment_paystack_sort_order', '1', 0),
(11711, 0, 'payment_paystack', 'payment_paystack_total', '', 0),
(10672, 0, 'payment_cod', 'payment_cod_sort_order', '2', 0),
(10671, 0, 'payment_cod', 'payment_cod_status', '1', 0),
(10670, 0, 'payment_cod', 'payment_cod_geo_zone_id', '0', 0),
(103, 0, 'shipping_flat', 'shipping_flat_sort_order', '1', 0),
(104, 0, 'shipping_flat', 'shipping_flat_status', '1', 0),
(105, 0, 'shipping_flat', 'shipping_flat_geo_zone_id', '0', 0),
(106, 0, 'shipping_flat', 'shipping_flat_tax_class_id', '9', 0),
(107, 0, 'shipping_flat', 'shipping_flat_cost', '5.00', 0),
(108, 0, 'total_shipping', 'total_shipping_sort_order', '3', 0),
(109, 0, 'total_sub_total', 'sub_total_sort_order', '1', 0),
(110, 0, 'total_sub_total', 'total_sub_total_status', '1', 0),
(111, 0, 'total_tax', 'total_tax_status', '1', 0),
(112, 0, 'total_total', 'total_total_sort_order', '9', 0),
(113, 0, 'total_total', 'total_total_status', '1', 0),
(114, 0, 'total_tax', 'total_tax_sort_order', '5', 0),
(115, 0, 'total_credit', 'total_credit_sort_order', '7', 0),
(116, 0, 'total_credit', 'total_credit_status', '1', 0),
(117, 0, 'total_reward', 'total_reward_sort_order', '2', 0),
(118, 0, 'total_reward', 'total_reward_status', '1', 0),
(119, 0, 'total_shipping', 'total_shipping_status', '1', 0),
(120, 0, 'total_shipping', 'total_shipping_estimator', '1', 0),
(121, 0, 'total_coupon', 'total_coupon_sort_order', '4', 0),
(122, 0, 'total_coupon', 'total_coupon_status', '1', 0),
(5262, 0, 'module_category', 'module_category_status', '1', 0),
(6197, 0, 'module_account', 'module_account_status', '1', 0),
(149, 0, 'dashboard_activity', 'dashboard_activity_status', '1', 0),
(150, 0, 'dashboard_activity', 'dashboard_activity_sort_order', '7', 0),
(151, 0, 'dashboard_sale', 'dashboard_sale_status', '1', 0),
(152, 0, 'dashboard_sale', 'dashboard_sale_width', '3', 0),
(153, 0, 'dashboard_chart', 'dashboard_chart_status', '1', 0),
(154, 0, 'dashboard_chart', 'dashboard_chart_width', '6', 0),
(155, 0, 'dashboard_customer', 'dashboard_customer_status', '1', 0),
(156, 0, 'dashboard_customer', 'dashboard_customer_width', '3', 0),
(157, 0, 'dashboard_map', 'dashboard_map_status', '1', 0),
(158, 0, 'dashboard_map', 'dashboard_map_width', '6', 0),
(159, 0, 'dashboard_online', 'dashboard_online_status', '1', 0),
(160, 0, 'dashboard_online', 'dashboard_online_width', '3', 0),
(161, 0, 'dashboard_order', 'dashboard_order_sort_order', '1', 0),
(162, 0, 'dashboard_order', 'dashboard_order_status', '1', 0),
(163, 0, 'dashboard_order', 'dashboard_order_width', '3', 0),
(164, 0, 'dashboard_sale', 'dashboard_sale_sort_order', '2', 0),
(165, 0, 'dashboard_customer', 'dashboard_customer_sort_order', '3', 0),
(166, 0, 'dashboard_online', 'dashboard_online_sort_order', '4', 0),
(167, 0, 'dashboard_map', 'dashboard_map_sort_order', '5', 0),
(168, 0, 'dashboard_chart', 'dashboard_chart_sort_order', '6', 0),
(169, 0, 'dashboard_recent', 'dashboard_recent_status', '1', 0),
(170, 0, 'dashboard_recent', 'dashboard_recent_sort_order', '8', 0),
(171, 0, 'dashboard_activity', 'dashboard_activity_width', '4', 0),
(172, 0, 'dashboard_recent', 'dashboard_recent_width', '8', 0),
(173, 0, 'report_customer_activity', 'report_customer_activity_status', '1', 0),
(174, 0, 'report_customer_activity', 'report_customer_activity_sort_order', '1', 0),
(175, 0, 'report_customer_order', 'report_customer_order_status', '1', 0),
(176, 0, 'report_customer_order', 'report_customer_order_sort_order', '2', 0),
(177, 0, 'report_customer_reward', 'report_customer_reward_status', '1', 0),
(178, 0, 'report_customer_reward', 'report_customer_reward_sort_order', '3', 0),
(179, 0, 'report_customer_search', 'report_customer_search_sort_order', '3', 0),
(180, 0, 'report_customer_search', 'report_customer_search_status', '1', 0),
(181, 0, 'report_customer_transaction', 'report_customer_transaction_status', '1', 0),
(182, 0, 'report_customer_transaction', 'report_customer_transaction_status_sort_order', '4', 0),
(183, 0, 'report_sale_tax', 'report_sale_tax_status', '1', 0),
(184, 0, 'report_sale_tax', 'report_sale_tax_sort_order', '5', 0),
(185, 0, 'report_sale_shipping', 'report_sale_shipping_status', '1', 0),
(186, 0, 'report_sale_shipping', 'report_sale_shipping_sort_order', '6', 0),
(187, 0, 'report_sale_return', 'report_sale_return_status', '1', 0),
(188, 0, 'report_sale_return', 'report_sale_return_sort_order', '7', 0),
(189, 0, 'report_sale_order', 'report_sale_order_status', '1', 0),
(190, 0, 'report_sale_order', 'report_sale_order_sort_order', '8', 0),
(191, 0, 'report_sale_coupon', 'report_sale_coupon_status', '1', 0),
(192, 0, 'report_sale_coupon', 'report_sale_coupon_sort_order', '9', 0),
(193, 0, 'report_product_viewed', 'report_product_viewed_status', '1', 0),
(194, 0, 'report_product_viewed', 'report_product_viewed_sort_order', '10', 0),
(195, 0, 'report_product_purchased', 'report_product_purchased_status', '1', 0),
(196, 0, 'report_product_purchased', 'report_product_purchased_sort_order', '11', 0),
(197, 0, 'report_marketing', 'report_marketing_status', '1', 0),
(198, 0, 'report_marketing', 'report_marketing_sort_order', '12', 0),
(11616, 0, 'developer', 'developer_sass', '1', 0),
(11615, 0, 'developer', 'developer_theme', '1', 0),
(232, 0, 'module_filter', 'module_filter_status', '1', 0),
(10477, 0, 'module_information', 'module_information_status', '1', 0),
(234, 0, 'module_newsletters', 'module_newsletters_status', '1', 0),
(10669, 0, 'payment_cod', 'payment_cod_order_status_id', '1', 0),
(10668, 0, 'payment_cod', 'payment_cod_total', '100', 0),
(6927, 0, 'theme_default', 'theme_default_image_wishlist_height', '108', 0),
(11710, 0, 'payment_paystack', 'payment_paystack_debug', '1', 0),
(6926, 0, 'theme_default', 'theme_default_image_wishlist_width', '85', 0),
(11694, 0, 'config', 'config_compression', '0', 0),
(11695, 0, 'config', 'config_secure', '0', 0),
(11696, 0, 'config', 'config_password', '1', 0),
(11697, 0, 'config', 'config_shared', '0', 0),
(11698, 0, 'config', 'config_encryption', 'hfcYscPzSZTulem8mfaOg4RqyqO1xiMKeqOIcc6URYqozt74HTBwzyhTc4jBK3yozjHHH3Nfz9sHxMXzrddB4osRKpyIF3zGLfvyD6rYEJSsTFeOFGV0NlEUV5aXCkqLL87e0HVglZSrLDg6o4lB3l8ZzGrhMIaB81UJ4Dhyfazy0sOhlhaDLVBqw6C5IxSkAJOLgxNEiO7d5Su20Y2FaLvu2Cn7ht3U1kgxkiBwpsBQ7wTFTNCPvjoTyPDBsOwdGOxySvb4pPZbdutpu6nmTv32T4kYgi4xiPHgbV9ElE9ebFqNAW2CXL9uMq6uOTT9RL21g2CCNM7wS5RfJOwRSwdM8XBOHOF8JDTGQoijCLh7OFZLwxoDscDbakWBHYJWl6iBLEovhVxfdshdVpLojMGDNnG15Nk4U1jDa12evMmMWnkj9b069DdeKNMo9EdrZn8VByB9HAyUD8i4XLaVFWpxP0lRHf6OUButB0XuMDx9InGARxARLdzfuh1aYskuZMdNsdhCgN6BZ7w9Gy0vbUEbJkxKGIkZVWaOfWsbGrPqb0n3DqPw5LBxb8E98tfzYkDYKn2tdDJaFeumVmO8mQ1gzZKR6JmxC9mv9mMErMop0uYahDsRrim2QIlnjpU3EIVh5kJpB8ip1LMQ16G0uUuMKdwyahsXdtUPecKOCeeFyWOmsB20YZ20UnWl2taruCyNeh0Sx9zRZrIGbf3cK10glIMMcxiGdOlNt3EAcu8rzF1r55aWsprSAh2MdTdWveHavjH011zJA9P3nmPQZNQr0rPrefRZPn2ErjidYL9XYla5wqM5JdCi8DboJdw2yA2OGAyEJOYG7BPt6R9xWc19AjmfGIKng9tmZ4UhkbGt0ELzgnxUVKAeBZZUBZocaxkmfxKvk8ytuAGGWbcpKWRqjfSDWFNcKRBphWojqA4HWIKmrVkn5KjSILqJovu4pPwzarX71Iz53DrYyruS64VPU1l230wNQZNzeGz1v8rt5wlqDV63beHRe2YXYpWi', 0),
(11670, 0, 'config', 'config_stock_checkout', '0', 0),
(11671, 0, 'config', 'config_affiliate_group_id', '1', 0),
(11672, 0, 'config', 'config_affiliate_approval', '0', 0),
(11673, 0, 'config', 'config_affiliate_auto', '0', 0),
(11674, 0, 'config', 'config_affiliate_commission', '5', 0),
(11675, 0, 'config', 'config_affiliate_id', '4', 0),
(11676, 0, 'config', 'config_return_id', '0', 0),
(11677, 0, 'config', 'config_return_status_id', '2', 0),
(11678, 0, 'config', 'config_captcha', 'basic', 0),
(11679, 0, 'config', 'config_captcha_page', '[\"contact\"]', 1),
(11680, 0, 'config', 'config_logo', 'catalog/Wecis/wecis-logo_100by100 crop resize.png', 0),
(11681, 0, 'config', 'config_icon', 'catalog/Wecis/wecis-logo_100by100.png', 0),
(11682, 0, 'config', 'config_mail_engine', 'mail', 0),
(11683, 0, 'config', 'config_mail_parameter', '', 0),
(11684, 0, 'config', 'config_mail_smtp_hostname', '', 0),
(11685, 0, 'config', 'config_mail_smtp_username', '', 0),
(11686, 0, 'config', 'config_mail_smtp_password', '', 0),
(11687, 0, 'config', 'config_mail_smtp_port', '25', 0),
(11688, 0, 'config', 'config_mail_smtp_timeout', '5', 0),
(11689, 0, 'config', 'config_mail_alert', '[\"account\",\"order\",\"review\"]', 1),
(11690, 0, 'config', 'config_mail_alert_email', '', 0),
(11691, 0, 'config', 'config_maintenance', '0', 0),
(11692, 0, 'config', 'config_seo_url', '0', 0),
(11693, 0, 'config', 'config_robots', 'abot\r\ndbot\r\nebot\r\nhbot\r\nkbot\r\nlbot\r\nmbot\r\nnbot\r\nobot\r\npbot\r\nrbot\r\nsbot\r\ntbot\r\nvbot\r\nybot\r\nzbot\r\nbot.\r\nbot/\r\n_bot\r\n.bot\r\n/bot\r\n-bot\r\n:bot\r\n(bot\r\ncrawl\r\nslurp\r\nspider\r\nseek\r\naccoona\r\nacoon\r\nadressendeutschland\r\nah-ha.com\r\nahoy\r\naltavista\r\nananzi\r\nanthill\r\nappie\r\narachnophilia\r\narale\r\naraneo\r\naranha\r\narchitext\r\naretha\r\narks\r\nasterias\r\natlocal\r\natn\r\natomz\r\naugurfind\r\nbackrub\r\nbannana_bot\r\nbaypup\r\nbdfetch\r\nbig brother\r\nbiglotron\r\nbjaaland\r\nblackwidow\r\nblaiz\r\nblog\r\nblo.\r\nbloodhound\r\nboitho\r\nbooch\r\nbradley\r\nbutterfly\r\ncalif\r\ncassandra\r\nccubee\r\ncfetch\r\ncharlotte\r\nchurl\r\ncienciaficcion\r\ncmc\r\ncollective\r\ncomagent\r\ncombine\r\ncomputingsite\r\ncsci\r\ncurl\r\ncusco\r\ndaumoa\r\ndeepindex\r\ndelorie\r\ndepspid\r\ndeweb\r\ndie blinde kuh\r\ndigger\r\nditto\r\ndmoz\r\ndocomo\r\ndownload express\r\ndtaagent\r\ndwcp\r\nebiness\r\nebingbong\r\ne-collector\r\nejupiter\r\nemacs-w3 search engine\r\nesther\r\nevliya celebi\r\nezresult\r\nfalcon\r\nfelix ide\r\nferret\r\nfetchrover\r\nfido\r\nfindlinks\r\nfireball\r\nfish search\r\nfouineur\r\nfunnelweb\r\ngazz\r\ngcreep\r\ngenieknows\r\ngetterroboplus\r\ngeturl\r\nglx\r\ngoforit\r\ngolem\r\ngrabber\r\ngrapnel\r\ngralon\r\ngriffon\r\ngromit\r\ngrub\r\ngulliver\r\nhamahakki\r\nharvest\r\nhavindex\r\nhelix\r\nheritrix\r\nhku www octopus\r\nhomerweb\r\nhtdig\r\nhtml index\r\nhtml_analyzer\r\nhtmlgobble\r\nhubater\r\nhyper-decontextualizer\r\nia_archiver\r\nibm_planetwide\r\nichiro\r\niconsurf\r\niltrovatore\r\nimage.kapsi.net\r\nimagelock\r\nincywincy\r\nindexer\r\ninfobee\r\ninformant\r\ningrid\r\ninktomisearch.com\r\ninspector web\r\nintelliagent\r\ninternet shinchakubin\r\nip3000\r\niron33\r\nisraeli-search\r\nivia\r\njack\r\njakarta\r\njavabee\r\njetbot\r\njumpstation\r\nkatipo\r\nkdd-explorer\r\nkilroy\r\nknowledge\r\nkototoi\r\nkretrieve\r\nlabelgrabber\r\nlachesis\r\nlarbin\r\nlegs\r\nlibwww\r\nlinkalarm\r\nlink validator\r\nlinkscan\r\nlockon\r\nlwp\r\nlycos\r\nmagpie\r\nmantraagent\r\nmapoftheinternet\r\nmarvin/\r\nmattie\r\nmediafox\r\nmediapartners\r\nmercator\r\nmerzscope\r\nmicrosoft url control\r\nminirank\r\nmiva\r\nmj12\r\nmnogosearch\r\nmoget\r\nmonster\r\nmoose\r\nmotor\r\nmultitext\r\nmuncher\r\nmuscatferret\r\nmwd.search\r\nmyweb\r\nnajdi\r\nnameprotect\r\nnationaldirectory\r\nnazilla\r\nncsa beta\r\nnec-meshexplorer\r\nnederland.zoek\r\nnetcarta webmap engine\r\nnetmechanic\r\nnetresearchserver\r\nnetscoop\r\nnewscan-online\r\nnhse\r\nnokia6682/\r\nnomad\r\nnoyona\r\nnutch\r\nnzexplorer\r\nobjectssearch\r\noccam\r\nomni\r\nopen text\r\nopenfind\r\nopenintelligencedata\r\norb search\r\nosis-project\r\npack rat\r\npageboy\r\npagebull\r\npage_verifier\r\npanscient\r\nparasite\r\npartnersite\r\npatric\r\npear.\r\npegasus\r\nperegrinator\r\npgp key agent\r\nphantom\r\nphpdig\r\npicosearch\r\npiltdownman\r\npimptrain\r\npinpoint\r\npioneer\r\npiranha\r\nplumtreewebaccessor\r\npogodak\r\npoirot\r\npompos\r\npoppelsdorf\r\npoppi\r\npopular iconoclast\r\npsycheclone\r\npublisher\r\npython\r\nrambler\r\nraven search\r\nroach\r\nroad runner\r\nroadhouse\r\nrobbie\r\nrobofox\r\nrobozilla\r\nrules\r\nsalty\r\nsbider\r\nscooter\r\nscoutjet\r\nscrubby\r\nsearch.\r\nsearchprocess\r\nsemanticdiscovery\r\nsenrigan\r\nsg-scout\r\nshai\'hulud\r\nshark\r\nshopwiki\r\nsidewinder\r\nsift\r\nsilk\r\nsimmany\r\nsite searcher\r\nsite valet\r\nsitetech-rover\r\nskymob.com\r\nsleek\r\nsmartwit\r\nsna-\r\nsnappy\r\nsnooper\r\nsohu\r\nspeedfind\r\nsphere\r\nsphider\r\nspinner\r\nspyder\r\nsteeler/\r\nsuke\r\nsuntek\r\nsupersnooper\r\nsurfnomore\r\nsven\r\nsygol\r\nszukacz\r\ntach black widow\r\ntarantula\r\ntempleton\r\n/teoma\r\nt-h-u-n-d-e-r-s-t-o-n-e\r\ntheophrastus\r\ntitan\r\ntitin\r\ntkwww\r\ntoutatis\r\nt-rex\r\ntutorgig\r\ntwiceler\r\ntwisted\r\nucsd\r\nudmsearch\r\nurl check\r\nupdated\r\nvagabondo\r\nvalkyrie\r\nverticrawl\r\nvictoria\r\nvision-search\r\nvolcano\r\nvoyager/\r\nvoyager-hc\r\nw3c_validator\r\nw3m2\r\nw3mir\r\nwalker\r\nwallpaper\r\nwanderer\r\nwauuu\r\nwavefire\r\nweb core\r\nweb hopper\r\nweb wombat\r\nwebbandit\r\nwebcatcher\r\nwebcopy\r\nwebfoot\r\nweblayers\r\nweblinker\r\nweblog monitor\r\nwebmirror\r\nwebmonkey\r\nwebquest\r\nwebreaper\r\nwebsitepulse\r\nwebsnarf\r\nwebstolperer\r\nwebvac\r\nwebwalk\r\nwebwatch\r\nwebwombat\r\nwebzinger\r\nwhizbang\r\nwhowhere\r\nwild ferret\r\nworldlight\r\nwwwc\r\nwwwster\r\nxenu\r\nxget\r\nxift\r\nxirq\r\nyandex\r\nyanga\r\nyeti\r\nyodao\r\nzao\r\nzippp\r\nzyborg', 0),
(6925, 0, 'theme_default', 'theme_default_image_compare_height', '108', 0),
(6924, 0, 'theme_default', 'theme_default_image_compare_width', '85', 0),
(6923, 0, 'theme_default', 'theme_default_image_related_height', '326', 0),
(6922, 0, 'theme_default', 'theme_default_image_related_width', '256', 0),
(6921, 0, 'theme_default', 'theme_default_image_additional_height', '719', 0),
(6920, 0, 'theme_default', 'theme_default_image_additional_width', '565', 0),
(6919, 0, 'theme_default', 'theme_default_image_product_height', '316', 0),
(11709, 0, 'payment_paystack', 'payment_paystack_live_public', 'pk_live_d579fad424206247d2f79dfc9d1db0ff1847e36e', 0),
(6918, 0, 'theme_default', 'theme_default_image_product_width', '248', 0),
(6917, 0, 'theme_default', 'theme_default_image_popup_height', '1000', 0),
(6916, 0, 'theme_default', 'theme_default_image_popup_width', '785', 0),
(6915, 0, 'theme_default', 'theme_default_image_thumb_height', '719', 0),
(11669, 0, 'config', 'config_stock_warning', '0', 0),
(11668, 0, 'config', 'config_stock_display', '0', 0),
(11667, 0, 'config', 'config_api_id', '18', 0),
(11666, 0, 'config', 'config_fraud_status_id', '7', 0),
(11665, 0, 'config', 'config_complete_status', '[\"5\",\"3\"]', 1),
(6914, 0, 'theme_default', 'theme_default_image_thumb_width', '565', 0),
(6913, 0, 'theme_default', 'theme_default_image_category_height', '200', 0),
(11664, 0, 'config', 'config_processing_status', '[\"5\",\"1\",\"2\",\"12\",\"3\"]', 1),
(11663, 0, 'config', 'config_order_status_id', '1', 0),
(11662, 0, 'config', 'config_checkout_id', '5', 0),
(11661, 0, 'config', 'config_checkout_guest', '1', 0),
(11660, 0, 'config', 'config_cart_weight', '1', 0),
(11659, 0, 'config', 'config_invoice_prefix', 'INV-WECIS-2025-00', 0),
(11658, 0, 'config', 'config_account_id', '3', 0),
(11657, 0, 'config', 'config_login_attempts', '5', 0),
(11656, 0, 'config', 'config_customer_price', '0', 0),
(6912, 0, 'theme_default', 'theme_default_image_category_width', '1085', 0),
(6911, 0, 'theme_default', 'theme_default_product_description_length', '175', 0),
(6910, 0, 'theme_default', 'theme_default_product_limit', '12', 0),
(6909, 0, 'theme_default', 'theme_default_status', '1', 0),
(6908, 0, 'theme_default', 'theme_default_directory', 'Styleway_Apparel', 0),
(11655, 0, 'config', 'config_customer_group_display', '[\"1\"]', 1),
(11654, 0, 'config', 'config_customer_group_id', '1', 0),
(11653, 0, 'config', 'config_customer_search', '0', 0),
(11652, 0, 'config', 'config_customer_activity', '0', 0),
(11651, 0, 'config', 'config_customer_online', '0', 0),
(11650, 0, 'config', 'config_tax_customer', 'shipping', 0),
(11649, 0, 'config', 'config_tax_default', 'shipping', 0),
(11648, 0, 'config', 'config_tax', '1', 0),
(11647, 0, 'config', 'config_voucher_max', '1000', 0),
(11646, 0, 'config', 'config_voucher_min', '1', 0),
(11645, 0, 'config', 'config_review_guest', '1', 0),
(11644, 0, 'config', 'config_review_status', '1', 0),
(11643, 0, 'config', 'config_limit_admin', '20', 0),
(11642, 0, 'config', 'config_product_count', '0', 0),
(11641, 0, 'config', 'config_weight_class_id', '1', 0),
(11640, 0, 'config', 'config_length_class_id', '1', 0),
(11639, 0, 'config', 'config_currency_auto', '1', 0),
(11638, 0, 'config', 'config_currency_engine', '', 0),
(11637, 0, 'config', 'config_currency', 'NGN', 0),
(11636, 0, 'config', 'config_admin_language', 'en-gb', 0),
(11635, 0, 'config', 'config_language', 'en-gb', 0),
(11634, 0, 'config', 'config_timezone', 'Africa/Lagos', 0),
(11633, 0, 'config', 'config_zone_id', '2412', 0),
(6928, 0, 'theme_default', 'theme_default_image_cart_width', '85', 0),
(6929, 0, 'theme_default', 'theme_default_image_cart_height', '108', 0),
(6930, 0, 'theme_default', 'theme_default_image_location_width', '244', 0),
(6931, 0, 'theme_default', 'theme_default_image_location_height', '49', 0),
(11632, 0, 'config', 'config_country_id', '156', 0),
(11631, 0, 'config', 'config_comment', 'Contemporary African Men and Women\'s wear brand with Delivery worldwide!', 0),
(11630, 0, 'config', 'config_open', '9:00 AM to 10:00 PM (Monday to Friday)', 0),
(11629, 0, 'config', 'config_image', 'catalog/Wecis/wecis-logo.png', 0),
(11628, 0, 'config', 'config_fax', ' +234 803 364 0090', 0),
(11627, 0, 'config', 'config_telephone', ' +234 803 364 0090', 0),
(11626, 0, 'config', 'config_email', 'info@wecisclothing.com', 0),
(11625, 0, 'config', 'config_geocode', 'Nigeria', 0),
(11624, 0, 'config', 'config_address', 'NO 3 Adeniyi Jone Avenue, Ikeja and 49 Adeola Odeku Street, Victoria Island, Lagos, Nigeria', 0),
(11623, 0, 'config', 'config_owner', 'Wecis Clothings', 0),
(11622, 0, 'config', 'config_name', 'Wecis Clothing ', 0),
(11621, 0, 'config', 'config_layout_id', '4', 0),
(11620, 0, 'config', 'config_theme', 'default', 0),
(11619, 0, 'config', 'config_meta_keyword', 'Fashion, Apparel, T-shirt, Jeans, Jewelry, Beauty, Cosmetic, Clothes, Accessories, Kids Wear, Toys, Flowers, Gift, Bag, Shoes, Watch, Minimal\r\n', 0),
(11617, 0, 'config', 'config_meta_title', 'Wecis Clothing - Fashion Store', 0),
(11618, 0, 'config', 'config_meta_description', 'Wecis Clothing - , Apparel, T-shirt, Jeans, Jewelry, Beauty, Cosmetic, Clothes, Accessories, Kids Wear, Toys, Flowers, Gift, Bag, Shoes, Watch,  Minimal and multi purpose stores. \r\n', 0),
(11708, 0, 'payment_paystack', 'payment_paystack_live_secret', 'sk_live_60033537c10c7e0901415e11b366fe1e9aa24dd7', 0),
(11707, 0, 'payment_paystack', 'payment_paystack_live', '1', 0),
(11706, 0, 'payment_paystack', 'payment_paystack_test_public', 'pk_test_2b20383601c35b0cb2311b4650c8be59c537aa04', 0),
(11705, 0, 'payment_paystack', 'payment_paystack_test_secret', 'sk_test_5c2c9453a99d23b4183093b40f948f9f2dee9af5', 0),
(11699, 0, 'config', 'config_file_max_size', '300000', 0),
(11700, 0, 'config', 'config_file_ext_allowed', 'zip\r\ntxt\r\npng\r\njpe\r\njpeg\r\njpg\r\ngif\r\nbmp\r\nico\r\ntiff\r\ntif\r\nsvg\r\nsvgz\r\nzip\r\nrar\r\nmsi\r\ncab\r\nmp3\r\nqt\r\nmov\r\npdf\r\npsd\r\nai\r\neps\r\nps\r\ndoc', 0),
(11701, 0, 'config', 'config_file_mime_allowed', 'text/plain\r\nimage/png\r\nimage/jpeg\r\nimage/gif\r\nimage/bmp\r\nimage/tiff\r\nimage/svg+xml\r\napplication/zip\r\n&quot;application/zip&quot;\r\napplication/x-zip\r\n&quot;application/x-zip&quot;\r\napplication/x-zip-compressed\r\n&quot;application/x-zip-compressed&quot;\r\napplication/rar\r\n&quot;application/rar&quot;\r\napplication/x-rar\r\n&quot;application/x-rar&quot;\r\napplication/x-rar-compressed\r\n&quot;application/x-rar-compressed&quot;\r\napplication/octet-stream\r\n&quot;application/octet-stream&quot;\r\naudio/mpeg\r\nvideo/quicktime\r\napplication/pdf', 0),
(11702, 0, 'config', 'config_error_display', '1', 0),
(11703, 0, 'config', 'config_error_log', '1', 0),
(11704, 0, 'config', 'config_error_filename', 'error.log', 0),
(11715, 0, 'payment_paystack', 'payment_paystack_order_status_id', '1', 0),
(11716, 0, 'payment_paystack', 'payment_paystack_pending_status_id', '2', 0),
(11717, 0, 'payment_paystack', 'payment_paystack_canceled_status_id', '7', 0),
(11718, 0, 'payment_paystack', 'payment_paystack_failed_status_id', '10', 0);

-- --------------------------------------------------------

--
-- Table structure for table `oc_shipping_courier`
--

CREATE TABLE `oc_shipping_courier` (
  `shipping_courier_id` int NOT NULL,
  `shipping_courier_code` varchar(255) NOT NULL DEFAULT '',
  `shipping_courier_name` varchar(255) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_shipping_courier`
--

INSERT INTO `oc_shipping_courier` (`shipping_courier_id`, `shipping_courier_code`, `shipping_courier_name`) VALUES
(1, 'dhl', 'DHL'),
(2, 'fedex', 'Fedex'),
(3, 'ups', 'UPS'),
(4, 'royal-mail', 'Royal Mail'),
(5, 'usps', 'United States Postal Service'),
(6, 'auspost', 'Australia Post'),
(7, 'citylink', 'Citylink');

-- --------------------------------------------------------

--
-- Table structure for table `oc_statistics`
--

CREATE TABLE `oc_statistics` (
  `statistics_id` int NOT NULL,
  `code` varchar(64) NOT NULL,
  `value` decimal(15,4) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_statistics`
--

INSERT INTO `oc_statistics` (`statistics_id`, `code`, `value`) VALUES
(1, 'order_sale', -146314.9557),
(2, 'order_processing', 0.0000),
(3, 'order_complete', 0.0000),
(4, 'order_other', 0.0000),
(5, 'returns', 0.0000),
(6, 'product', 0.0000),
(7, 'review', 0.0000);

-- --------------------------------------------------------

--
-- Table structure for table `oc_stock_status`
--

CREATE TABLE `oc_stock_status` (
  `stock_status_id` int NOT NULL,
  `language_id` int NOT NULL,
  `name` varchar(32) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_stock_status`
--

INSERT INTO `oc_stock_status` (`stock_status_id`, `language_id`, `name`) VALUES
(7, 2, 'In Stock'),
(8, 2, 'Pre-Order'),
(5, 1, 'Out Of Stock'),
(6, 2, '2-3 Days'),
(7, 1, 'In Stock'),
(8, 1, 'Pre-Order'),
(5, 2, 'Out Of Stock'),
(6, 1, '2-3 Days');

-- --------------------------------------------------------

--
-- Table structure for table `oc_store`
--

CREATE TABLE `oc_store` (
  `store_id` int NOT NULL,
  `name` varchar(64) NOT NULL,
  `url` varchar(255) NOT NULL,
  `ssl` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `oc_tax_class`
--

CREATE TABLE `oc_tax_class` (
  `tax_class_id` int NOT NULL,
  `title` varchar(32) NOT NULL,
  `description` varchar(255) NOT NULL,
  `date_added` datetime NOT NULL,
  `date_modified` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_tax_class`
--

INSERT INTO `oc_tax_class` (`tax_class_id`, `title`, `description`, `date_added`, `date_modified`) VALUES
(9, 'Taxable Goods', 'Taxed goods', '2009-01-06 23:21:53', '2025-04-18 05:03:13');

-- --------------------------------------------------------

--
-- Table structure for table `oc_tax_rate`
--

CREATE TABLE `oc_tax_rate` (
  `tax_rate_id` int NOT NULL,
  `geo_zone_id` int NOT NULL DEFAULT '0',
  `name` varchar(32) NOT NULL,
  `rate` decimal(15,4) NOT NULL DEFAULT '0.0000',
  `type` char(1) NOT NULL,
  `date_added` datetime NOT NULL,
  `date_modified` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_tax_rate`
--

INSERT INTO `oc_tax_rate` (`tax_rate_id`, `geo_zone_id`, `name`, `rate`, `type`, `date_added`, `date_modified`) VALUES
(88, 5, 'NGN VAT', 7.5000, 'P', '2025-04-18 05:02:18', '2025-04-18 05:02:18');

-- --------------------------------------------------------

--
-- Table structure for table `oc_tax_rate_to_customer_group`
--

CREATE TABLE `oc_tax_rate_to_customer_group` (
  `tax_rate_id` int NOT NULL,
  `customer_group_id` int NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_tax_rate_to_customer_group`
--

INSERT INTO `oc_tax_rate_to_customer_group` (`tax_rate_id`, `customer_group_id`) VALUES
(88, 1);

-- --------------------------------------------------------

--
-- Table structure for table `oc_tax_rule`
--

CREATE TABLE `oc_tax_rule` (
  `tax_rule_id` int NOT NULL,
  `tax_class_id` int NOT NULL,
  `tax_rate_id` int NOT NULL,
  `based` varchar(10) NOT NULL,
  `priority` int NOT NULL DEFAULT '1'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_tax_rule`
--

INSERT INTO `oc_tax_rule` (`tax_rule_id`, `tax_class_id`, `tax_rate_id`, `based`, `priority`) VALUES
(129, 9, 88, 'shipping', 1);

-- --------------------------------------------------------

--
-- Table structure for table `oc_theme`
--

CREATE TABLE `oc_theme` (
  `theme_id` int NOT NULL,
  `store_id` int NOT NULL,
  `theme` varchar(64) NOT NULL,
  `route` varchar(64) NOT NULL,
  `code` mediumtext NOT NULL,
  `date_added` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `oc_translation`
--

CREATE TABLE `oc_translation` (
  `translation_id` int NOT NULL,
  `store_id` int NOT NULL,
  `language_id` int NOT NULL,
  `route` varchar(64) NOT NULL,
  `key` varchar(64) NOT NULL,
  `value` text NOT NULL,
  `date_added` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `oc_upload`
--

CREATE TABLE `oc_upload` (
  `upload_id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `date_added` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_upload`
--

INSERT INTO `oc_upload` (`upload_id`, `name`, `filename`, `code`, `date_added`) VALUES
(1, 'Header-Icon.png', 'Header-Icon.png.IdxRomfWiuov0buAFZPRl94G06DxMHru', 'ead905e7e280af09037f52d57ef8e5010ac3b6d5', '2021-03-08 15:39:45');

-- --------------------------------------------------------

--
-- Table structure for table `oc_user`
--

CREATE TABLE `oc_user` (
  `user_id` int NOT NULL,
  `user_group_id` int NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(40) NOT NULL,
  `salt` varchar(9) NOT NULL,
  `firstname` varchar(32) NOT NULL,
  `lastname` varchar(32) NOT NULL,
  `email` varchar(96) NOT NULL,
  `image` varchar(255) NOT NULL,
  `code` varchar(40) NOT NULL,
  `ip` varchar(40) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `date_added` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_user`
--

INSERT INTO `oc_user` (`user_id`, `user_group_id`, `username`, `password`, `salt`, `firstname`, `lastname`, `email`, `image`, `code`, `ip`, `status`, `date_added`) VALUES
(1, 1, 'admin', '8470e7ff924bacb139976865d830177b608c85f5', 'U6vlL1gJS', 'Kunle', 'Ajadi', 'info@wecisclothing.com', 'catalog/Wecis/kunle-ajadi.jpg', '', '102.89.23.214', 1, '2025-04-04 23:13:54');

-- --------------------------------------------------------

--
-- Table structure for table `oc_user_group`
--

CREATE TABLE `oc_user_group` (
  `user_group_id` int NOT NULL,
  `name` varchar(64) NOT NULL,
  `permission` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_user_group`
--

INSERT INTO `oc_user_group` (`user_group_id`, `name`, `permission`) VALUES
(1, 'Administrator', '{\"access\":{\"0\":\"catalog\\/attribute\",\"1\":\"catalog\\/attribute_group\",\"2\":\"catalog\\/category\",\"3\":\"catalog\\/download\",\"4\":\"catalog\\/filter\",\"5\":\"catalog\\/information\",\"6\":\"catalog\\/manufacturer\",\"7\":\"catalog\\/option\",\"8\":\"catalog\\/product\",\"9\":\"catalog\\/recurring\",\"10\":\"catalog\\/review\",\"11\":\"common\\/column_left\",\"12\":\"common\\/developer\",\"13\":\"common\\/filemanager\",\"14\":\"common\\/profile\",\"15\":\"common\\/security\",\"16\":\"customer\\/custom_field\",\"17\":\"customer\\/customer\",\"18\":\"customer\\/customer_approval\",\"19\":\"customer\\/customer_group\",\"20\":\"design\\/banner\",\"21\":\"design\\/layout\",\"22\":\"design\\/theme\",\"23\":\"design\\/translation\",\"24\":\"design\\/seo_url\",\"25\":\"event\\/statistics\",\"26\":\"event\\/theme\",\"27\":\"extension\\/analytics\\/google\",\"28\":\"extension\\/captcha\\/basic\",\"29\":\"extension\\/captcha\\/google\",\"30\":\"extension\\/dashboard\\/activity\",\"31\":\"extension\\/dashboard\\/chart\",\"32\":\"extension\\/dashboard\\/customer\",\"33\":\"extension\\/dashboard\\/map\",\"34\":\"extension\\/dashboard\\/online\",\"35\":\"extension\\/dashboard\\/order\",\"36\":\"extension\\/dashboard\\/recent\",\"37\":\"extension\\/dashboard\\/sale\",\"38\":\"extension\\/extension\\/analytics\",\"39\":\"extension\\/extension\\/captcha\",\"40\":\"extension\\/extension\\/dashboard\",\"41\":\"extension\\/extension\\/feed\",\"42\":\"extension\\/extension\\/fraud\",\"43\":\"extension\\/extension\\/menu\",\"44\":\"extension\\/extension\\/module\",\"45\":\"extension\\/extension\\/payment\",\"46\":\"extension\\/extension\\/report\",\"47\":\"extension\\/extension\\/shipping\",\"48\":\"extension\\/extension\\/theme\",\"49\":\"extension\\/extension\\/total\",\"50\":\"extension\\/feed\\/google_base\",\"51\":\"extension\\/feed\\/google_sitemap\",\"52\":\"extension\\/feed\\/openbaypro\",\"53\":\"extension\\/fraud\\/fraudlabspro\",\"54\":\"extension\\/fraud\\/ip\",\"55\":\"extension\\/fraud\\/maxmind\",\"56\":\"extension\\/marketing\\/remarketing\",\"57\":\"extension\\/module\\/account\",\"58\":\"extension\\/module\\/amazon_login\",\"59\":\"extension\\/module\\/amazon_pay\",\"60\":\"extension\\/module\\/banner\",\"61\":\"extension\\/module\\/bestseller\",\"62\":\"extension\\/module\\/carousel\",\"63\":\"extension\\/module\\/category\",\"64\":\"extension\\/module\\/divido_calculator\",\"65\":\"extension\\/module\\/ebay_listing\",\"66\":\"extension\\/module\\/featured\",\"67\":\"extension\\/module\\/filter\",\"68\":\"extension\\/module\\/google_hangouts\",\"69\":\"extension\\/module\\/html\",\"70\":\"extension\\/module\\/information\",\"71\":\"extension\\/module\\/klarna_checkout_module\",\"72\":\"extension\\/module\\/latest\",\"73\":\"extension\\/module\\/laybuy_layout\",\"74\":\"extension\\/module\\/pilibaba_button\",\"75\":\"extension\\/module\\/pp_button\",\"76\":\"extension\\/module\\/pp_login\",\"77\":\"extension\\/module\\/sagepay_direct_cards\",\"78\":\"extension\\/module\\/sagepay_server_cards\",\"79\":\"extension\\/module\\/slideshow\",\"80\":\"extension\\/module\\/special\",\"81\":\"extension\\/module\\/store\",\"82\":\"extension\\/openbay\\/amazon\",\"83\":\"extension\\/openbay\\/amazon_listing\",\"84\":\"extension\\/openbay\\/amazon_product\",\"85\":\"extension\\/openbay\\/amazonus\",\"86\":\"extension\\/openbay\\/amazonus_listing\",\"87\":\"extension\\/openbay\\/amazonus_product\",\"88\":\"extension\\/openbay\\/ebay\",\"89\":\"extension\\/openbay\\/ebay_profile\",\"90\":\"extension\\/openbay\\/ebay_template\",\"91\":\"extension\\/openbay\\/etsy\",\"92\":\"extension\\/openbay\\/etsy_product\",\"93\":\"extension\\/openbay\\/etsy_shipping\",\"94\":\"extension\\/openbay\\/etsy_shop\",\"95\":\"extension\\/openbay\\/fba\",\"96\":\"extension\\/payment\\/amazon_login_pay\",\"97\":\"extension\\/payment\\/authorizenet_aim\",\"98\":\"extension\\/payment\\/authorizenet_sim\",\"99\":\"extension\\/payment\\/bank_transfer\",\"100\":\"extension\\/payment\\/bluepay_hosted\",\"101\":\"extension\\/payment\\/bluepay_redirect\",\"102\":\"extension\\/payment\\/cardconnect\",\"103\":\"extension\\/payment\\/cardinity\",\"104\":\"extension\\/payment\\/cheque\",\"105\":\"extension\\/payment\\/cod\",\"106\":\"extension\\/payment\\/divido\",\"107\":\"extension\\/payment\\/eway\",\"108\":\"extension\\/payment\\/firstdata\",\"109\":\"extension\\/payment\\/firstdata_remote\",\"111\":\"extension\\/payment\\/g2apay\",\"112\":\"extension\\/payment\\/globalpay\",\"113\":\"extension\\/payment\\/globalpay_remote\",\"114\":\"extension\\/payment\\/klarna_account\",\"115\":\"extension\\/payment\\/klarna_checkout\",\"116\":\"extension\\/payment\\/klarna_invoice\",\"117\":\"extension\\/payment\\/laybuy\",\"118\":\"extension\\/payment\\/liqpay\",\"119\":\"extension\\/payment\\/nochex\",\"120\":\"extension\\/payment\\/paymate\",\"122\":\"extension\\/payment\\/payza\",\"123\":\"extension\\/payment\\/perpetual_payments\",\"124\":\"extension\\/payment\\/pilibaba\",\"125\":\"extension\\/payment\\/pp_express\",\"126\":\"extension\\/payment\\/pp_payflow\",\"127\":\"extension\\/payment\\/pp_payflow_iframe\",\"128\":\"extension\\/payment\\/pp_pro\",\"129\":\"extension\\/payment\\/pp_pro_iframe\",\"130\":\"extension\\/payment\\/pp_standard\",\"131\":\"extension\\/payment\\/realex\",\"132\":\"extension\\/payment\\/realex_remote\",\"133\":\"extension\\/payment\\/sagepay_direct\",\"134\":\"extension\\/payment\\/sagepay_server\",\"135\":\"extension\\/payment\\/sagepay_us\",\"136\":\"extension\\/payment\\/securetrading_pp\",\"137\":\"extension\\/payment\\/securetrading_ws\",\"138\":\"extension\\/payment\\/skrill\",\"139\":\"extension\\/payment\\/twocheckout\",\"140\":\"extension\\/payment\\/web_payment_software\",\"141\":\"extension\\/payment\\/worldpay\",\"142\":\"extension\\/module\\/pp_braintree_button\",\"143\":\"extension\\/payment\\/pp_braintree\",\"144\":\"extension\\/report\\/customer_activity\",\"145\":\"extension\\/report\\/customer_order\",\"146\":\"extension\\/report\\/customer_reward\",\"147\":\"extension\\/report\\/customer_search\",\"148\":\"extension\\/report\\/customer_transaction\",\"149\":\"extension\\/report\\/marketing\",\"150\":\"extension\\/report\\/product_purchased\",\"151\":\"extension\\/report\\/product_viewed\",\"152\":\"extension\\/report\\/sale_coupon\",\"153\":\"extension\\/report\\/sale_order\",\"154\":\"extension\\/report\\/sale_return\",\"155\":\"extension\\/report\\/sale_shipping\",\"156\":\"extension\\/report\\/sale_tax\",\"157\":\"extension\\/shipping\\/auspost\",\"158\":\"extension\\/shipping\\/citylink\",\"159\":\"extension\\/shipping\\/ec_ship\",\"160\":\"extension\\/shipping\\/fedex\",\"161\":\"extension\\/shipping\\/flat\",\"162\":\"extension\\/shipping\\/free\",\"163\":\"extension\\/shipping\\/item\",\"164\":\"extension\\/shipping\\/parcelforce_48\",\"165\":\"extension\\/shipping\\/pickup\",\"166\":\"extension\\/shipping\\/royal_mail\",\"167\":\"extension\\/shipping\\/ups\",\"168\":\"extension\\/shipping\\/usps\",\"169\":\"extension\\/shipping\\/weight\",\"170\":\"extension\\/theme\\/default\",\"171\":\"extension\\/total\\/coupon\",\"172\":\"extension\\/total\\/credit\",\"173\":\"extension\\/total\\/handling\",\"174\":\"extension\\/total\\/klarna_fee\",\"175\":\"extension\\/total\\/low_order_fee\",\"176\":\"extension\\/total\\/reward\",\"177\":\"extension\\/total\\/shipping\",\"178\":\"extension\\/total\\/sub_total\",\"179\":\"extension\\/total\\/tax\",\"180\":\"extension\\/total\\/total\",\"181\":\"extension\\/total\\/voucher\",\"182\":\"localisation\\/country\",\"183\":\"localisation\\/currency\",\"184\":\"localisation\\/geo_zone\",\"185\":\"localisation\\/language\",\"186\":\"localisation\\/length_class\",\"187\":\"localisation\\/location\",\"188\":\"localisation\\/order_status\",\"189\":\"localisation\\/return_action\",\"190\":\"localisation\\/return_reason\",\"191\":\"localisation\\/return_status\",\"192\":\"localisation\\/stock_status\",\"193\":\"localisation\\/tax_class\",\"194\":\"localisation\\/tax_rate\",\"195\":\"localisation\\/weight_class\",\"196\":\"localisation\\/zone\",\"197\":\"mail\\/affiliate\",\"198\":\"mail\\/customer\",\"199\":\"mail\\/forgotten\",\"200\":\"mail\\/return\",\"201\":\"mail\\/reward\",\"202\":\"mail\\/transaction\",\"203\":\"marketing\\/contact\",\"204\":\"marketing\\/coupon\",\"205\":\"marketing\\/marketing\",\"206\":\"marketplace\\/api\",\"207\":\"marketplace\\/event\",\"208\":\"marketplace\\/extension\",\"209\":\"marketplace\\/install\",\"210\":\"marketplace\\/installer\",\"211\":\"marketplace\\/marketplace\",\"212\":\"marketplace\\/modification\",\"213\":\"marketplace\\/openbay\",\"214\":\"report\\/online\",\"215\":\"report\\/report\",\"216\":\"report\\/statistics\",\"217\":\"sale\\/order\",\"218\":\"sale\\/recurring\",\"219\":\"sale\\/return\",\"220\":\"sale\\/voucher\",\"221\":\"sale\\/voucher_theme\",\"222\":\"setting\\/setting\",\"223\":\"setting\\/store\",\"224\":\"startup\\/error\",\"225\":\"startup\\/event\",\"226\":\"startup\\/login\",\"227\":\"startup\\/permission\",\"228\":\"startup\\/router\",\"229\":\"startup\\/sass\",\"230\":\"startup\\/startup\",\"231\":\"tool\\/backup\",\"232\":\"tool\\/log\",\"233\":\"tool\\/upload\",\"234\":\"user\\/api\",\"235\":\"user\\/user\",\"236\":\"user\\/user_permission\",\"237\":\"extension\\/module\\/html\",\"238\":\"extension\\/module\\/filter\",\"239\":\"extension\\/module\\/special\",\"240\":\"extension\\/module\\/information\",\"241\":\"extension\\/module\\/newsletters\",\"242\":\"extension\\/module\\/codezeeltabs\",\"243\":\"extension\\/module\\/blogger\",\"244\":\"extension\\/module\\/category_tab\",\"245\":\"extension\\/module\\/divido_calculator\",\"246\":\"extension\\/module\\/category_tab\",\"247\":\"extension\\/module\\/category_tab\",\"248\":\"extension\\/module\\/category_tab\",\"249\":\"extension\\/module\\/latest\",\"250\":\"extension\\/module\\/category_tab\",\"251\":\"extension\\/module\\/bestseller\",\"252\":\"extension\\/analytics\\/google\",\"253\":\"analytics\\/google\",\"254\":\"extension\\/module\\/codezeeltabs\",\"255\":\"extension\\/module\\/category_tab\",\"256\":\"extension\\/captcha\\/basic\",\"257\":\"captcha\\/basic\",\"258\":\"extension\\/module\\/codezeeltabs\",\"259\":\"extension\\/module\\/latest\",\"260\":\"extension\\/payment\\/paystack\"},\"modify\":{\"0\":\"catalog\\/attribute\",\"1\":\"catalog\\/attribute_group\",\"2\":\"catalog\\/category\",\"3\":\"catalog\\/download\",\"4\":\"catalog\\/filter\",\"5\":\"catalog\\/information\",\"6\":\"catalog\\/manufacturer\",\"7\":\"catalog\\/option\",\"8\":\"catalog\\/product\",\"9\":\"catalog\\/recurring\",\"10\":\"catalog\\/review\",\"11\":\"common\\/column_left\",\"12\":\"common\\/developer\",\"13\":\"common\\/filemanager\",\"14\":\"common\\/profile\",\"15\":\"common\\/security\",\"16\":\"customer\\/custom_field\",\"17\":\"customer\\/customer\",\"18\":\"customer\\/customer_approval\",\"19\":\"customer\\/customer_group\",\"20\":\"design\\/banner\",\"21\":\"design\\/layout\",\"22\":\"design\\/theme\",\"23\":\"design\\/translation\",\"24\":\"design\\/seo_url\",\"25\":\"event\\/statistics\",\"26\":\"event\\/theme\",\"27\":\"extension\\/analytics\\/google\",\"28\":\"extension\\/captcha\\/basic\",\"29\":\"extension\\/captcha\\/google\",\"30\":\"extension\\/dashboard\\/activity\",\"31\":\"extension\\/dashboard\\/chart\",\"32\":\"extension\\/dashboard\\/customer\",\"33\":\"extension\\/dashboard\\/map\",\"34\":\"extension\\/dashboard\\/online\",\"35\":\"extension\\/dashboard\\/order\",\"36\":\"extension\\/dashboard\\/recent\",\"37\":\"extension\\/dashboard\\/sale\",\"38\":\"extension\\/extension\\/analytics\",\"39\":\"extension\\/extension\\/captcha\",\"40\":\"extension\\/extension\\/dashboard\",\"41\":\"extension\\/extension\\/feed\",\"42\":\"extension\\/extension\\/fraud\",\"43\":\"extension\\/extension\\/menu\",\"44\":\"extension\\/extension\\/module\",\"45\":\"extension\\/extension\\/payment\",\"46\":\"extension\\/extension\\/report\",\"47\":\"extension\\/extension\\/shipping\",\"48\":\"extension\\/extension\\/theme\",\"49\":\"extension\\/extension\\/total\",\"50\":\"extension\\/feed\\/google_base\",\"51\":\"extension\\/feed\\/google_sitemap\",\"52\":\"extension\\/feed\\/openbaypro\",\"53\":\"extension\\/fraud\\/fraudlabspro\",\"54\":\"extension\\/fraud\\/ip\",\"55\":\"extension\\/fraud\\/maxmind\",\"56\":\"extension\\/marketing\\/remarketing\",\"57\":\"extension\\/module\\/account\",\"58\":\"extension\\/module\\/amazon_login\",\"59\":\"extension\\/module\\/amazon_pay\",\"60\":\"extension\\/module\\/banner\",\"61\":\"extension\\/module\\/bestseller\",\"62\":\"extension\\/module\\/carousel\",\"63\":\"extension\\/module\\/category\",\"64\":\"extension\\/module\\/divido_calculator\",\"65\":\"extension\\/module\\/ebay_listing\",\"66\":\"extension\\/module\\/featured\",\"67\":\"extension\\/module\\/filter\",\"68\":\"extension\\/module\\/google_hangouts\",\"69\":\"extension\\/module\\/html\",\"70\":\"extension\\/module\\/information\",\"71\":\"extension\\/module\\/klarna_checkout_module\",\"72\":\"extension\\/module\\/latest\",\"73\":\"extension\\/module\\/laybuy_layout\",\"74\":\"extension\\/module\\/pilibaba_button\",\"75\":\"extension\\/module\\/pp_button\",\"76\":\"extension\\/module\\/pp_login\",\"77\":\"extension\\/module\\/sagepay_direct_cards\",\"78\":\"extension\\/module\\/sagepay_server_cards\",\"79\":\"extension\\/module\\/slideshow\",\"80\":\"extension\\/module\\/special\",\"81\":\"extension\\/module\\/store\",\"82\":\"extension\\/openbay\\/amazon\",\"83\":\"extension\\/openbay\\/amazon_listing\",\"84\":\"extension\\/openbay\\/amazon_product\",\"85\":\"extension\\/openbay\\/amazonus\",\"86\":\"extension\\/openbay\\/amazonus_listing\",\"87\":\"extension\\/openbay\\/amazonus_product\",\"88\":\"extension\\/openbay\\/ebay\",\"89\":\"extension\\/openbay\\/ebay_profile\",\"90\":\"extension\\/openbay\\/ebay_template\",\"91\":\"extension\\/openbay\\/etsy\",\"92\":\"extension\\/openbay\\/etsy_product\",\"93\":\"extension\\/openbay\\/etsy_shipping\",\"94\":\"extension\\/openbay\\/etsy_shop\",\"95\":\"extension\\/openbay\\/fba\",\"96\":\"extension\\/payment\\/amazon_login_pay\",\"97\":\"extension\\/payment\\/authorizenet_aim\",\"98\":\"extension\\/payment\\/authorizenet_sim\",\"99\":\"extension\\/payment\\/bank_transfer\",\"100\":\"extension\\/payment\\/bluepay_hosted\",\"101\":\"extension\\/payment\\/bluepay_redirect\",\"102\":\"extension\\/payment\\/cardconnect\",\"103\":\"extension\\/payment\\/cardinity\",\"104\":\"extension\\/payment\\/cheque\",\"105\":\"extension\\/payment\\/cod\",\"106\":\"extension\\/payment\\/divido\",\"107\":\"extension\\/payment\\/eway\",\"108\":\"extension\\/payment\\/firstdata\",\"109\":\"extension\\/payment\\/firstdata_remote\",\"111\":\"extension\\/payment\\/g2apay\",\"112\":\"extension\\/payment\\/globalpay\",\"113\":\"extension\\/payment\\/globalpay_remote\",\"114\":\"extension\\/payment\\/klarna_account\",\"115\":\"extension\\/payment\\/klarna_checkout\",\"116\":\"extension\\/payment\\/klarna_invoice\",\"117\":\"extension\\/payment\\/laybuy\",\"118\":\"extension\\/payment\\/liqpay\",\"119\":\"extension\\/payment\\/nochex\",\"120\":\"extension\\/payment\\/paymate\",\"122\":\"extension\\/payment\\/payza\",\"123\":\"extension\\/payment\\/perpetual_payments\",\"124\":\"extension\\/payment\\/pilibaba\",\"125\":\"extension\\/payment\\/pp_express\",\"126\":\"extension\\/payment\\/pp_payflow\",\"127\":\"extension\\/payment\\/pp_payflow_iframe\",\"128\":\"extension\\/payment\\/pp_pro\",\"129\":\"extension\\/payment\\/pp_pro_iframe\",\"130\":\"extension\\/payment\\/pp_standard\",\"131\":\"extension\\/payment\\/realex\",\"132\":\"extension\\/payment\\/realex_remote\",\"133\":\"extension\\/payment\\/sagepay_direct\",\"134\":\"extension\\/payment\\/sagepay_server\",\"135\":\"extension\\/payment\\/sagepay_us\",\"136\":\"extension\\/payment\\/securetrading_pp\",\"137\":\"extension\\/payment\\/securetrading_ws\",\"138\":\"extension\\/payment\\/skrill\",\"139\":\"extension\\/payment\\/twocheckout\",\"140\":\"extension\\/payment\\/web_payment_software\",\"141\":\"extension\\/payment\\/worldpay\",\"142\":\"extension\\/module\\/pp_braintree_button\",\"143\":\"extension\\/payment\\/pp_braintree\",\"144\":\"extension\\/report\\/customer_activity\",\"145\":\"extension\\/report\\/customer_order\",\"146\":\"extension\\/report\\/customer_reward\",\"147\":\"extension\\/report\\/customer_search\",\"148\":\"extension\\/report\\/customer_transaction\",\"149\":\"extension\\/report\\/marketing\",\"150\":\"extension\\/report\\/product_purchased\",\"151\":\"extension\\/report\\/product_viewed\",\"152\":\"extension\\/report\\/sale_coupon\",\"153\":\"extension\\/report\\/sale_order\",\"154\":\"extension\\/report\\/sale_return\",\"155\":\"extension\\/report\\/sale_shipping\",\"156\":\"extension\\/report\\/sale_tax\",\"157\":\"extension\\/shipping\\/auspost\",\"158\":\"extension\\/shipping\\/citylink\",\"159\":\"extension\\/shipping\\/ec_ship\",\"160\":\"extension\\/shipping\\/fedex\",\"161\":\"extension\\/shipping\\/flat\",\"162\":\"extension\\/shipping\\/free\",\"163\":\"extension\\/shipping\\/item\",\"164\":\"extension\\/shipping\\/parcelforce_48\",\"165\":\"extension\\/shipping\\/pickup\",\"166\":\"extension\\/shipping\\/royal_mail\",\"167\":\"extension\\/shipping\\/ups\",\"168\":\"extension\\/shipping\\/usps\",\"169\":\"extension\\/shipping\\/weight\",\"170\":\"extension\\/theme\\/default\",\"171\":\"extension\\/total\\/coupon\",\"172\":\"extension\\/total\\/credit\",\"173\":\"extension\\/total\\/handling\",\"174\":\"extension\\/total\\/klarna_fee\",\"175\":\"extension\\/total\\/low_order_fee\",\"176\":\"extension\\/total\\/reward\",\"177\":\"extension\\/total\\/shipping\",\"178\":\"extension\\/total\\/sub_total\",\"179\":\"extension\\/total\\/tax\",\"180\":\"extension\\/total\\/total\",\"181\":\"extension\\/total\\/voucher\",\"182\":\"localisation\\/country\",\"183\":\"localisation\\/currency\",\"184\":\"localisation\\/geo_zone\",\"185\":\"localisation\\/language\",\"186\":\"localisation\\/length_class\",\"187\":\"localisation\\/location\",\"188\":\"localisation\\/order_status\",\"189\":\"localisation\\/return_action\",\"190\":\"localisation\\/return_reason\",\"191\":\"localisation\\/return_status\",\"192\":\"localisation\\/stock_status\",\"193\":\"localisation\\/tax_class\",\"194\":\"localisation\\/tax_rate\",\"195\":\"localisation\\/weight_class\",\"196\":\"localisation\\/zone\",\"197\":\"mail\\/affiliate\",\"198\":\"mail\\/customer\",\"199\":\"mail\\/forgotten\",\"200\":\"mail\\/return\",\"201\":\"mail\\/reward\",\"202\":\"mail\\/transaction\",\"203\":\"marketing\\/contact\",\"204\":\"marketing\\/coupon\",\"205\":\"marketing\\/marketing\",\"206\":\"marketplace\\/event\",\"207\":\"marketplace\\/api\",\"208\":\"marketplace\\/extension\",\"209\":\"marketplace\\/install\",\"210\":\"marketplace\\/installer\",\"211\":\"marketplace\\/marketplace\",\"212\":\"marketplace\\/modification\",\"213\":\"marketplace\\/openbay\",\"214\":\"report\\/online\",\"215\":\"report\\/report\",\"216\":\"report\\/statistics\",\"217\":\"sale\\/order\",\"218\":\"sale\\/recurring\",\"219\":\"sale\\/return\",\"220\":\"sale\\/voucher\",\"221\":\"sale\\/voucher_theme\",\"222\":\"setting\\/setting\",\"223\":\"setting\\/store\",\"224\":\"startup\\/error\",\"225\":\"startup\\/event\",\"226\":\"startup\\/login\",\"227\":\"startup\\/permission\",\"228\":\"startup\\/router\",\"229\":\"startup\\/sass\",\"230\":\"startup\\/startup\",\"231\":\"tool\\/backup\",\"232\":\"tool\\/log\",\"233\":\"tool\\/upload\",\"234\":\"user\\/api\",\"235\":\"user\\/user\",\"236\":\"user\\/user_permission\",\"237\":\"extension\\/module\\/html\",\"238\":\"extension\\/module\\/filter\",\"239\":\"extension\\/module\\/special\",\"240\":\"extension\\/module\\/information\",\"241\":\"extension\\/module\\/newsletters\",\"242\":\"extension\\/module\\/codezeeltabs\",\"243\":\"extension\\/module\\/blogger\",\"244\":\"extension\\/module\\/category_tab\",\"245\":\"extension\\/module\\/divido_calculator\",\"246\":\"extension\\/module\\/category_tab\",\"247\":\"extension\\/module\\/category_tab\",\"248\":\"extension\\/module\\/category_tab\",\"249\":\"extension\\/module\\/latest\",\"250\":\"extension\\/module\\/category_tab\",\"251\":\"extension\\/module\\/bestseller\",\"252\":\"extension\\/analytics\\/google\",\"253\":\"analytics\\/google\",\"254\":\"extension\\/module\\/codezeeltabs\",\"255\":\"extension\\/module\\/category_tab\",\"256\":\"extension\\/captcha\\/basic\",\"257\":\"captcha\\/basic\",\"258\":\"extension\\/module\\/codezeeltabs\",\"259\":\"extension\\/module\\/latest\",\"260\":\"extension\\/payment\\/paystack\"}}'),
(10, 'Demonstration', '');

-- --------------------------------------------------------

--
-- Table structure for table `oc_voucher`
--

CREATE TABLE `oc_voucher` (
  `voucher_id` int NOT NULL,
  `order_id` int NOT NULL,
  `code` varchar(10) NOT NULL,
  `from_name` varchar(64) NOT NULL,
  `from_email` varchar(96) NOT NULL,
  `to_name` varchar(64) NOT NULL,
  `to_email` varchar(96) NOT NULL,
  `voucher_theme_id` int NOT NULL,
  `message` text NOT NULL,
  `amount` decimal(15,4) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `date_added` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `oc_voucher_history`
--

CREATE TABLE `oc_voucher_history` (
  `voucher_history_id` int NOT NULL,
  `voucher_id` int NOT NULL,
  `order_id` int NOT NULL,
  `amount` decimal(15,4) NOT NULL,
  `date_added` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `oc_voucher_theme`
--

CREATE TABLE `oc_voucher_theme` (
  `voucher_theme_id` int NOT NULL,
  `image` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_voucher_theme`
--

INSERT INTO `oc_voucher_theme` (`voucher_theme_id`, `image`) VALUES
(8, 'catalog/demo/canon_eos_5d_2.jpg'),
(7, 'catalog/demo/gift-voucher-birthday.jpg'),
(6, 'catalog/demo/apple_logo.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `oc_voucher_theme_description`
--

CREATE TABLE `oc_voucher_theme_description` (
  `voucher_theme_id` int NOT NULL,
  `language_id` int NOT NULL,
  `name` varchar(32) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_voucher_theme_description`
--

INSERT INTO `oc_voucher_theme_description` (`voucher_theme_id`, `language_id`, `name`) VALUES
(6, 1, 'Christmas'),
(7, 1, 'Birthday'),
(8, 1, 'General'),
(6, 2, 'Christmas'),
(7, 2, 'Birthday'),
(8, 2, 'General');

-- --------------------------------------------------------

--
-- Table structure for table `oc_weight_class`
--

CREATE TABLE `oc_weight_class` (
  `weight_class_id` int NOT NULL,
  `value` decimal(15,8) NOT NULL DEFAULT '0.00000000'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_weight_class`
--

INSERT INTO `oc_weight_class` (`weight_class_id`, `value`) VALUES
(1, 1.00000000),
(2, 1000.00000000),
(5, 2.20460000),
(6, 35.27400000);

-- --------------------------------------------------------

--
-- Table structure for table `oc_weight_class_description`
--

CREATE TABLE `oc_weight_class_description` (
  `weight_class_id` int NOT NULL,
  `language_id` int NOT NULL,
  `title` varchar(32) NOT NULL,
  `unit` varchar(4) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_weight_class_description`
--

INSERT INTO `oc_weight_class_description` (`weight_class_id`, `language_id`, `title`, `unit`) VALUES
(1, 1, 'Kilogram', 'kg'),
(2, 1, 'Gram', 'g'),
(5, 1, 'Pound ', 'lb'),
(6, 1, 'Ounce', 'oz'),
(1, 2, 'Kilogram', 'kg'),
(2, 2, 'Gram', 'g'),
(5, 2, 'Pound ', 'lb'),
(6, 2, 'Ounce', 'oz');

-- --------------------------------------------------------

--
-- Table structure for table `oc_zone`
--

CREATE TABLE `oc_zone` (
  `zone_id` int NOT NULL,
  `country_id` int NOT NULL,
  `name` varchar(128) NOT NULL,
  `code` varchar(32) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_zone`
--

INSERT INTO `oc_zone` (`zone_id`, `country_id`, `name`, `code`, `status`) VALUES
(1, 1, 'Badakhshan', 'BDS', 1),
(2, 1, 'Badghis', 'BDG', 1),
(3, 1, 'Baghlan', 'BGL', 1),
(4, 1, 'Balkh', 'BAL', 1),
(5, 1, 'Bamian', 'BAM', 1),
(6, 1, 'Farah', 'FRA', 1),
(7, 1, 'Faryab', 'FYB', 1),
(8, 1, 'Ghazni', 'GHA', 1),
(9, 1, 'Ghowr', 'GHO', 1),
(10, 1, 'Helmand', 'HEL', 1),
(11, 1, 'Herat', 'HER', 1),
(12, 1, 'Jowzjan', 'JOW', 1),
(13, 1, 'Kabul', 'KAB', 1),
(14, 1, 'Kandahar', 'KAN', 1),
(15, 1, 'Kapisa', 'KAP', 1),
(16, 1, 'Khost', 'KHO', 1),
(17, 1, 'Konar', 'KNR', 1),
(18, 1, 'Kondoz', 'KDZ', 1),
(19, 1, 'Laghman', 'LAG', 1),
(20, 1, 'Lowgar', 'LOW', 1),
(21, 1, 'Nangrahar', 'NAN', 1),
(22, 1, 'Nimruz', 'NIM', 1),
(23, 1, 'Nurestan', 'NUR', 1),
(24, 1, 'Oruzgan', 'ORU', 1),
(25, 1, 'Paktia', 'PIA', 1),
(26, 1, 'Paktika', 'PKA', 1),
(27, 1, 'Parwan', 'PAR', 1),
(28, 1, 'Samangan', 'SAM', 1),
(29, 1, 'Sar-e Pol', 'SAR', 1),
(30, 1, 'Takhar', 'TAK', 1),
(31, 1, 'Wardak', 'WAR', 1),
(32, 1, 'Zabol', 'ZAB', 1),
(33, 2, 'Berat', 'BR', 1),
(34, 2, 'Bulqize', 'BU', 1),
(35, 2, 'Delvine', 'DL', 1),
(36, 2, 'Devoll', 'DV', 1),
(37, 2, 'Diber', 'DI', 1),
(38, 2, 'Durres', 'DR', 1),
(39, 2, 'Elbasan', 'EL', 1),
(40, 2, 'Kolonje', 'ER', 1),
(41, 2, 'Fier', 'FR', 1),
(42, 2, 'Gjirokaster', 'GJ', 1),
(43, 2, 'Gramsh', 'GR', 1),
(44, 2, 'Has', 'HA', 1),
(45, 2, 'Kavaje', 'KA', 1),
(46, 2, 'Kurbin', 'KB', 1),
(47, 2, 'Kucove', 'KC', 1),
(48, 2, 'Korce', 'KO', 1),
(49, 2, 'Kruje', 'KR', 1),
(50, 2, 'Kukes', 'KU', 1),
(51, 2, 'Librazhd', 'LB', 1),
(52, 2, 'Lezhe', 'LE', 1),
(53, 2, 'Lushnje', 'LU', 1),
(54, 2, 'Malesi e Madhe', 'MM', 1),
(55, 2, 'Mallakaster', 'MK', 1),
(56, 2, 'Mat', 'MT', 1),
(57, 2, 'Mirdite', 'MR', 1),
(58, 2, 'Peqin', 'PQ', 1),
(59, 2, 'Permet', 'PR', 1),
(60, 2, 'Pogradec', 'PG', 1),
(61, 2, 'Puke', 'PU', 1),
(62, 2, 'Shkoder', 'SH', 1),
(63, 2, 'Skrapar', 'SK', 1),
(64, 2, 'Sarande', 'SR', 1),
(65, 2, 'Tepelene', 'TE', 1),
(66, 2, 'Tropoje', 'TP', 1),
(67, 2, 'Tirane', 'TR', 1),
(68, 2, 'Vlore', 'VL', 1),
(69, 3, 'Adrar', 'ADR', 1),
(70, 3, 'Ain Defla', 'ADE', 1),
(71, 3, 'Ain Temouchent', 'ATE', 1),
(72, 3, 'Alger', 'ALG', 1),
(73, 3, 'Annaba', 'ANN', 1),
(74, 3, 'Batna', 'BAT', 1),
(75, 3, 'Bechar', 'BEC', 1),
(76, 3, 'Bejaia', 'BEJ', 1),
(77, 3, 'Biskra', 'BIS', 1),
(78, 3, 'Blida', 'BLI', 1),
(79, 3, 'Bordj Bou Arreridj', 'BBA', 1),
(80, 3, 'Bouira', 'BOA', 1),
(81, 3, 'Boumerdes', 'BMD', 1),
(82, 3, 'Chlef', 'CHL', 1),
(83, 3, 'Constantine', 'CON', 1),
(84, 3, 'Djelfa', 'DJE', 1),
(85, 3, 'El Bayadh', 'EBA', 1),
(86, 3, 'El Oued', 'EOU', 1),
(87, 3, 'El Tarf', 'ETA', 1),
(88, 3, 'Ghardaia', 'GHA', 1),
(89, 3, 'Guelma', 'GUE', 1),
(90, 3, 'Illizi', 'ILL', 1),
(91, 3, 'Jijel', 'JIJ', 1),
(92, 3, 'Khenchela', 'KHE', 1),
(93, 3, 'Laghouat', 'LAG', 1),
(94, 3, 'Muaskar', 'MUA', 1),
(95, 3, 'Medea', 'MED', 1),
(96, 3, 'Mila', 'MIL', 1),
(97, 3, 'Mostaganem', 'MOS', 1),
(98, 3, 'M\'Sila', 'MSI', 1),
(99, 3, 'Naama', 'NAA', 1),
(100, 3, 'Oran', 'ORA', 1),
(101, 3, 'Ouargla', 'OUA', 1),
(102, 3, 'Oum el-Bouaghi', 'OEB', 1),
(103, 3, 'Relizane', 'REL', 1),
(104, 3, 'Saida', 'SAI', 1),
(105, 3, 'Setif', 'SET', 1),
(106, 3, 'Sidi Bel Abbes', 'SBA', 1),
(107, 3, 'Skikda', 'SKI', 1),
(108, 3, 'Souk Ahras', 'SAH', 1),
(109, 3, 'Tamanghasset', 'TAM', 1),
(110, 3, 'Tebessa', 'TEB', 1),
(111, 3, 'Tiaret', 'TIA', 1),
(112, 3, 'Tindouf', 'TIN', 1),
(113, 3, 'Tipaza', 'TIP', 1),
(114, 3, 'Tissemsilt', 'TIS', 1),
(115, 3, 'Tizi Ouzou', 'TOU', 1),
(116, 3, 'Tlemcen', 'TLE', 1),
(117, 4, 'Eastern', 'E', 1),
(118, 4, 'Manu\'a', 'M', 1),
(119, 4, 'Rose Island', 'R', 1),
(120, 4, 'Swains Island', 'S', 1),
(121, 4, 'Western', 'W', 1),
(122, 5, 'Andorra la Vella', 'ALV', 1),
(123, 5, 'Canillo', 'CAN', 1),
(124, 5, 'Encamp', 'ENC', 1),
(125, 5, 'Escaldes-Engordany', 'ESE', 1),
(126, 5, 'La Massana', 'LMA', 1),
(127, 5, 'Ordino', 'ORD', 1),
(128, 5, 'Sant Julia de Loria', 'SJL', 1),
(129, 6, 'Bengo', 'BGO', 1),
(130, 6, 'Benguela', 'BGU', 1),
(131, 6, 'Bie', 'BIE', 1),
(132, 6, 'Cabinda', 'CAB', 1),
(133, 6, 'Cuando-Cubango', 'CCU', 1),
(134, 6, 'Cuanza Norte', 'CNO', 1),
(135, 6, 'Cuanza Sul', 'CUS', 1),
(136, 6, 'Cunene', 'CNN', 1),
(137, 6, 'Huambo', 'HUA', 1),
(138, 6, 'Huila', 'HUI', 1),
(139, 6, 'Luanda', 'LUA', 1),
(140, 6, 'Lunda Norte', 'LNO', 1),
(141, 6, 'Lunda Sul', 'LSU', 1),
(142, 6, 'Malange', 'MAL', 1),
(143, 6, 'Moxico', 'MOX', 1),
(144, 6, 'Namibe', 'NAM', 1),
(145, 6, 'Uige', 'UIG', 1),
(146, 6, 'Zaire', 'ZAI', 1),
(147, 9, 'Saint George', 'ASG', 1),
(148, 9, 'Saint John', 'ASJ', 1),
(149, 9, 'Saint Mary', 'ASM', 1),
(150, 9, 'Saint Paul', 'ASL', 1),
(151, 9, 'Saint Peter', 'ASR', 1),
(152, 9, 'Saint Philip', 'ASH', 1),
(153, 9, 'Barbuda', 'BAR', 1),
(154, 9, 'Redonda', 'RED', 1),
(155, 10, 'Antartida e Islas del Atlantico', 'AN', 1),
(156, 10, 'Buenos Aires', 'BA', 1),
(157, 10, 'Catamarca', 'CA', 1),
(158, 10, 'Chaco', 'CH', 1),
(159, 10, 'Chubut', 'CU', 1),
(160, 10, 'Cordoba', 'CO', 1),
(161, 10, 'Corrientes', 'CR', 1),
(162, 10, 'Distrito Federal', 'DF', 1),
(163, 10, 'Entre Rios', 'ER', 1),
(164, 10, 'Formosa', 'FO', 1),
(165, 10, 'Jujuy', 'JU', 1),
(166, 10, 'La Pampa', 'LP', 1),
(167, 10, 'La Rioja', 'LR', 1),
(168, 10, 'Mendoza', 'ME', 1),
(169, 10, 'Misiones', 'MI', 1),
(170, 10, 'Neuquen', 'NE', 1),
(171, 10, 'Rio Negro', 'RN', 1),
(172, 10, 'Salta', 'SA', 1),
(173, 10, 'San Juan', 'SJ', 1),
(174, 10, 'San Luis', 'SL', 1),
(175, 10, 'Santa Cruz', 'SC', 1),
(176, 10, 'Santa Fe', 'SF', 1),
(177, 10, 'Santiago del Estero', 'SD', 1),
(178, 10, 'Tierra del Fuego', 'TF', 1),
(179, 10, 'Tucuman', 'TU', 1),
(180, 11, 'Aragatsotn', 'AGT', 1),
(181, 11, 'Ararat', 'ARR', 1),
(182, 11, 'Armavir', 'ARM', 1),
(183, 11, 'Geghark\'unik\'', 'GEG', 1),
(184, 11, 'Kotayk\'', 'KOT', 1),
(185, 11, 'Lorri', 'LOR', 1),
(186, 11, 'Shirak', 'SHI', 1),
(187, 11, 'Syunik\'', 'SYU', 1),
(188, 11, 'Tavush', 'TAV', 1),
(189, 11, 'Vayots\' Dzor', 'VAY', 1),
(190, 11, 'Yerevan', 'YER', 1),
(191, 13, 'Australian Capital Territory', 'ACT', 1),
(192, 13, 'New South Wales', 'NSW', 1),
(193, 13, 'Northern Territory', 'NT', 1),
(194, 13, 'Queensland', 'QLD', 1),
(195, 13, 'South Australia', 'SA', 1),
(196, 13, 'Tasmania', 'TAS', 1),
(197, 13, 'Victoria', 'VIC', 1),
(198, 13, 'Western Australia', 'WA', 1),
(199, 14, 'Burgenland', 'BUR', 1),
(200, 14, 'Kärnten', 'KAR', 1),
(201, 14, 'Niederösterreich', 'NOS', 1),
(202, 14, 'Oberösterreich', 'OOS', 1),
(203, 14, 'Salzburg', 'SAL', 1),
(204, 14, 'Steiermark', 'STE', 1),
(205, 14, 'Tirol', 'TIR', 1),
(206, 14, 'Vorarlberg', 'VOR', 1),
(207, 14, 'Wien', 'WIE', 1),
(208, 15, 'Ali Bayramli', 'AB', 1),
(209, 15, 'Abseron', 'ABS', 1),
(210, 15, 'AgcabAdi', 'AGC', 1),
(211, 15, 'Agdam', 'AGM', 1),
(212, 15, 'Agdas', 'AGS', 1),
(213, 15, 'Agstafa', 'AGA', 1),
(214, 15, 'Agsu', 'AGU', 1),
(215, 15, 'Astara', 'AST', 1),
(216, 15, 'Baki', 'BA', 1),
(217, 15, 'BabAk', 'BAB', 1),
(218, 15, 'BalakAn', 'BAL', 1),
(219, 15, 'BArdA', 'BAR', 1),
(220, 15, 'Beylaqan', 'BEY', 1),
(221, 15, 'Bilasuvar', 'BIL', 1),
(222, 15, 'Cabrayil', 'CAB', 1),
(223, 15, 'Calilabab', 'CAL', 1),
(224, 15, 'Culfa', 'CUL', 1),
(225, 15, 'Daskasan', 'DAS', 1),
(226, 15, 'Davaci', 'DAV', 1),
(227, 15, 'Fuzuli', 'FUZ', 1),
(228, 15, 'Ganca', 'GA', 1),
(229, 15, 'Gadabay', 'GAD', 1),
(230, 15, 'Goranboy', 'GOR', 1),
(231, 15, 'Goycay', 'GOY', 1),
(232, 15, 'Haciqabul', 'HAC', 1),
(233, 15, 'Imisli', 'IMI', 1),
(234, 15, 'Ismayilli', 'ISM', 1),
(235, 15, 'Kalbacar', 'KAL', 1),
(236, 15, 'Kurdamir', 'KUR', 1),
(237, 15, 'Lankaran', 'LA', 1),
(238, 15, 'Lacin', 'LAC', 1),
(239, 15, 'Lankaran', 'LAN', 1),
(240, 15, 'Lerik', 'LER', 1),
(241, 15, 'Masalli', 'MAS', 1),
(242, 15, 'Mingacevir', 'MI', 1),
(243, 15, 'Naftalan', 'NA', 1),
(244, 15, 'Neftcala', 'NEF', 1),
(245, 15, 'Oguz', 'OGU', 1),
(246, 15, 'Ordubad', 'ORD', 1),
(247, 15, 'Qabala', 'QAB', 1),
(248, 15, 'Qax', 'QAX', 1),
(249, 15, 'Qazax', 'QAZ', 1),
(250, 15, 'Qobustan', 'QOB', 1),
(251, 15, 'Quba', 'QBA', 1),
(252, 15, 'Qubadli', 'QBI', 1),
(253, 15, 'Qusar', 'QUS', 1),
(254, 15, 'Saki', 'SA', 1),
(255, 15, 'Saatli', 'SAT', 1),
(256, 15, 'Sabirabad', 'SAB', 1),
(257, 15, 'Sadarak', 'SAD', 1),
(258, 15, 'Sahbuz', 'SAH', 1),
(259, 15, 'Saki', 'SAK', 1),
(260, 15, 'Salyan', 'SAL', 1),
(261, 15, 'Sumqayit', 'SM', 1),
(262, 15, 'Samaxi', 'SMI', 1),
(263, 15, 'Samkir', 'SKR', 1),
(264, 15, 'Samux', 'SMX', 1),
(265, 15, 'Sarur', 'SAR', 1),
(266, 15, 'Siyazan', 'SIY', 1),
(267, 15, 'Susa', 'SS', 1),
(268, 15, 'Susa', 'SUS', 1),
(269, 15, 'Tartar', 'TAR', 1),
(270, 15, 'Tovuz', 'TOV', 1),
(271, 15, 'Ucar', 'UCA', 1),
(272, 15, 'Xankandi', 'XA', 1),
(273, 15, 'Xacmaz', 'XAC', 1),
(274, 15, 'Xanlar', 'XAN', 1),
(275, 15, 'Xizi', 'XIZ', 1),
(276, 15, 'Xocali', 'XCI', 1),
(277, 15, 'Xocavand', 'XVD', 1),
(278, 15, 'Yardimli', 'YAR', 1),
(279, 15, 'Yevlax', 'YEV', 1),
(280, 15, 'Zangilan', 'ZAN', 1),
(281, 15, 'Zaqatala', 'ZAQ', 1),
(282, 15, 'Zardab', 'ZAR', 1),
(283, 15, 'Naxcivan', 'NX', 1),
(284, 16, 'Acklins', 'ACK', 1),
(285, 16, 'Berry Islands', 'BER', 1),
(286, 16, 'Bimini', 'BIM', 1),
(287, 16, 'Black Point', 'BLK', 1),
(288, 16, 'Cat Island', 'CAT', 1),
(289, 16, 'Central Abaco', 'CAB', 1),
(290, 16, 'Central Andros', 'CAN', 1),
(291, 16, 'Central Eleuthera', 'CEL', 1),
(292, 16, 'City of Freeport', 'FRE', 1),
(293, 16, 'Crooked Island', 'CRO', 1),
(294, 16, 'East Grand Bahama', 'EGB', 1),
(295, 16, 'Exuma', 'EXU', 1),
(296, 16, 'Grand Cay', 'GRD', 1),
(297, 16, 'Harbour Island', 'HAR', 1),
(298, 16, 'Hope Town', 'HOP', 1),
(299, 16, 'Inagua', 'INA', 1),
(300, 16, 'Long Island', 'LNG', 1),
(301, 16, 'Mangrove Cay', 'MAN', 1),
(302, 16, 'Mayaguana', 'MAY', 1),
(303, 16, 'Moore\'s Island', 'MOO', 1),
(304, 16, 'North Abaco', 'NAB', 1),
(305, 16, 'North Andros', 'NAN', 1),
(306, 16, 'North Eleuthera', 'NEL', 1),
(307, 16, 'Ragged Island', 'RAG', 1),
(308, 16, 'Rum Cay', 'RUM', 1),
(309, 16, 'San Salvador', 'SAL', 1),
(310, 16, 'South Abaco', 'SAB', 1),
(311, 16, 'South Andros', 'SAN', 1),
(312, 16, 'South Eleuthera', 'SEL', 1),
(313, 16, 'Spanish Wells', 'SWE', 1),
(314, 16, 'West Grand Bahama', 'WGB', 1),
(315, 17, 'Capital', 'CAP', 1),
(316, 17, 'Central', 'CEN', 1),
(317, 17, 'Muharraq', 'MUH', 1),
(318, 17, 'Northern', 'NOR', 1),
(319, 17, 'Southern', 'SOU', 1),
(320, 18, 'Barisal', 'BAR', 1),
(321, 18, 'Chittagong', 'CHI', 1),
(322, 18, 'Dhaka', 'DHA', 1),
(323, 18, 'Khulna', 'KHU', 1),
(324, 18, 'Rajshahi', 'RAJ', 1),
(325, 18, 'Sylhet', 'SYL', 1),
(326, 19, 'Christ Church', 'CC', 1),
(327, 19, 'Saint Andrew', 'AND', 1),
(328, 19, 'Saint George', 'GEO', 1),
(329, 19, 'Saint James', 'JAM', 1),
(330, 19, 'Saint John', 'JOH', 1),
(331, 19, 'Saint Joseph', 'JOS', 1),
(332, 19, 'Saint Lucy', 'LUC', 1),
(333, 19, 'Saint Michael', 'MIC', 1),
(334, 19, 'Saint Peter', 'PET', 1),
(335, 19, 'Saint Philip', 'PHI', 1),
(336, 19, 'Saint Thomas', 'THO', 1),
(337, 20, 'Brestskaya (Brest)', 'BR', 1),
(338, 20, 'Homyel\'skaya (Homyel\')', 'HO', 1),
(339, 20, 'Horad Minsk', 'HM', 1),
(340, 20, 'Hrodzyenskaya (Hrodna)', 'HR', 1),
(341, 20, 'Mahilyowskaya (Mahilyow)', 'MA', 1),
(342, 20, 'Minskaya', 'MI', 1),
(343, 20, 'Vitsyebskaya (Vitsyebsk)', 'VI', 1),
(344, 21, 'Antwerpen', 'VAN', 1),
(345, 21, 'Brabant Wallon', 'WBR', 1),
(346, 21, 'Hainaut', 'WHT', 1),
(347, 21, 'Liège', 'WLG', 1),
(348, 21, 'Limburg', 'VLI', 1),
(349, 21, 'Luxembourg', 'WLX', 1),
(350, 21, 'Namur', 'WNA', 1),
(351, 21, 'Oost-Vlaanderen', 'VOV', 1),
(352, 21, 'Vlaams Brabant', 'VBR', 1),
(353, 21, 'West-Vlaanderen', 'VWV', 1),
(354, 22, 'Belize', 'BZ', 1),
(355, 22, 'Cayo', 'CY', 1),
(356, 22, 'Corozal', 'CR', 1),
(357, 22, 'Orange Walk', 'OW', 1),
(358, 22, 'Stann Creek', 'SC', 1),
(359, 22, 'Toledo', 'TO', 1),
(360, 23, 'Alibori', 'AL', 1),
(361, 23, 'Atakora', 'AK', 1),
(362, 23, 'Atlantique', 'AQ', 1),
(363, 23, 'Borgou', 'BO', 1),
(364, 23, 'Collines', 'CO', 1),
(365, 23, 'Donga', 'DO', 1),
(366, 23, 'Kouffo', 'KO', 1),
(367, 23, 'Littoral', 'LI', 1),
(368, 23, 'Mono', 'MO', 1),
(369, 23, 'Oueme', 'OU', 1),
(370, 23, 'Plateau', 'PL', 1),
(371, 23, 'Zou', 'ZO', 1),
(372, 24, 'Devonshire', 'DS', 1),
(373, 24, 'Hamilton City', 'HC', 1),
(374, 24, 'Hamilton', 'HA', 1),
(375, 24, 'Paget', 'PG', 1),
(376, 24, 'Pembroke', 'PB', 1),
(377, 24, 'Saint George City', 'GC', 1),
(378, 24, 'Saint George\'s', 'SG', 1),
(379, 24, 'Sandys', 'SA', 1),
(380, 24, 'Smith\'s', 'SM', 1),
(381, 24, 'Southampton', 'SH', 1),
(382, 24, 'Warwick', 'WA', 1),
(383, 25, 'Bumthang', 'BUM', 1),
(384, 25, 'Chukha', 'CHU', 1),
(385, 25, 'Dagana', 'DAG', 1),
(386, 25, 'Gasa', 'GAS', 1),
(387, 25, 'Haa', 'HAA', 1),
(388, 25, 'Lhuntse', 'LHU', 1),
(389, 25, 'Mongar', 'MON', 1),
(390, 25, 'Paro', 'PAR', 1),
(391, 25, 'Pemagatshel', 'PEM', 1),
(392, 25, 'Punakha', 'PUN', 1),
(393, 25, 'Samdrup Jongkhar', 'SJO', 1),
(394, 25, 'Samtse', 'SAT', 1),
(395, 25, 'Sarpang', 'SAR', 1),
(396, 25, 'Thimphu', 'THI', 1),
(397, 25, 'Trashigang', 'TRG', 1),
(398, 25, 'Trashiyangste', 'TRY', 1),
(399, 25, 'Trongsa', 'TRO', 1),
(400, 25, 'Tsirang', 'TSI', 1),
(401, 25, 'Wangdue Phodrang', 'WPH', 1),
(402, 25, 'Zhemgang', 'ZHE', 1),
(403, 26, 'Beni', 'BEN', 1),
(404, 26, 'Chuquisaca', 'CHU', 1),
(405, 26, 'Cochabamba', 'COC', 1),
(406, 26, 'La Paz', 'LPZ', 1),
(407, 26, 'Oruro', 'ORU', 1),
(408, 26, 'Pando', 'PAN', 1),
(409, 26, 'Potosi', 'POT', 1),
(410, 26, 'Santa Cruz', 'SCZ', 1),
(411, 26, 'Tarija', 'TAR', 1),
(412, 27, 'Brcko district', 'BRO', 1),
(413, 27, 'Unsko-Sanski Kanton', 'FUS', 1),
(414, 27, 'Posavski Kanton', 'FPO', 1),
(415, 27, 'Tuzlanski Kanton', 'FTU', 1),
(416, 27, 'Zenicko-Dobojski Kanton', 'FZE', 1),
(417, 27, 'Bosanskopodrinjski Kanton', 'FBP', 1),
(418, 27, 'Srednjebosanski Kanton', 'FSB', 1),
(419, 27, 'Hercegovacko-neretvanski Kanton', 'FHN', 1),
(420, 27, 'Zapadnohercegovacka Zupanija', 'FZH', 1),
(421, 27, 'Kanton Sarajevo', 'FSA', 1),
(422, 27, 'Zapadnobosanska', 'FZA', 1),
(423, 27, 'Banja Luka', 'SBL', 1),
(424, 27, 'Doboj', 'SDO', 1),
(425, 27, 'Bijeljina', 'SBI', 1),
(426, 27, 'Vlasenica', 'SVL', 1),
(427, 27, 'Sarajevo-Romanija or Sokolac', 'SSR', 1),
(428, 27, 'Foca', 'SFO', 1),
(429, 27, 'Trebinje', 'STR', 1),
(430, 28, 'Central', 'CE', 1),
(431, 28, 'Ghanzi', 'GH', 1),
(432, 28, 'Kgalagadi', 'KD', 1),
(433, 28, 'Kgatleng', 'KT', 1),
(434, 28, 'Kweneng', 'KW', 1),
(435, 28, 'Ngamiland', 'NG', 1),
(436, 28, 'North East', 'NE', 1),
(437, 28, 'North West', 'NW', 1),
(438, 28, 'South East', 'SE', 1),
(439, 28, 'Southern', 'SO', 1),
(440, 30, 'Acre', 'AC', 1),
(441, 30, 'Alagoas', 'AL', 1),
(442, 30, 'Amapá', 'AP', 1),
(443, 30, 'Amazonas', 'AM', 1),
(444, 30, 'Bahia', 'BA', 1),
(445, 30, 'Ceará', 'CE', 1),
(446, 30, 'Distrito Federal', 'DF', 1),
(447, 30, 'Espírito Santo', 'ES', 1),
(448, 30, 'Goiás', 'GO', 1),
(449, 30, 'Maranhão', 'MA', 1),
(450, 30, 'Mato Grosso', 'MT', 1),
(451, 30, 'Mato Grosso do Sul', 'MS', 1),
(452, 30, 'Minas Gerais', 'MG', 1),
(453, 30, 'Pará', 'PA', 1),
(454, 30, 'Paraíba', 'PB', 1),
(455, 30, 'Paraná', 'PR', 1),
(456, 30, 'Pernambuco', 'PE', 1),
(457, 30, 'Piauí', 'PI', 1),
(458, 30, 'Rio de Janeiro', 'RJ', 1),
(459, 30, 'Rio Grande do Norte', 'RN', 1),
(460, 30, 'Rio Grande do Sul', 'RS', 1),
(461, 30, 'Rondônia', 'RO', 1),
(462, 30, 'Roraima', 'RR', 1),
(463, 30, 'Santa Catarina', 'SC', 1),
(464, 30, 'São Paulo', 'SP', 1),
(465, 30, 'Sergipe', 'SE', 1),
(466, 30, 'Tocantins', 'TO', 1),
(467, 31, 'Peros Banhos', 'PB', 1),
(468, 31, 'Salomon Islands', 'SI', 1),
(469, 31, 'Nelsons Island', 'NI', 1),
(470, 31, 'Three Brothers', 'TB', 1),
(471, 31, 'Eagle Islands', 'EA', 1),
(472, 31, 'Danger Island', 'DI', 1),
(473, 31, 'Egmont Islands', 'EG', 1),
(474, 31, 'Diego Garcia', 'DG', 1),
(475, 32, 'Belait', 'BEL', 1),
(476, 32, 'Brunei and Muara', 'BRM', 1),
(477, 32, 'Temburong', 'TEM', 1),
(478, 32, 'Tutong', 'TUT', 1),
(479, 33, 'Blagoevgrad', '', 1),
(480, 33, 'Burgas', '', 1),
(481, 33, 'Dobrich', '', 1),
(482, 33, 'Gabrovo', '', 1),
(483, 33, 'Haskovo', '', 1),
(484, 33, 'Kardjali', '', 1),
(485, 33, 'Kyustendil', '', 1),
(486, 33, 'Lovech', '', 1),
(487, 33, 'Montana', '', 1),
(488, 33, 'Pazardjik', '', 1),
(489, 33, 'Pernik', '', 1),
(490, 33, 'Pleven', '', 1),
(491, 33, 'Plovdiv', '', 1),
(492, 33, 'Razgrad', '', 1),
(493, 33, 'Shumen', '', 1),
(494, 33, 'Silistra', '', 1),
(495, 33, 'Sliven', '', 1),
(496, 33, 'Smolyan', '', 1),
(497, 33, 'Sofia', '', 1),
(498, 33, 'Sofia - town', '', 1),
(499, 33, 'Stara Zagora', '', 1),
(500, 33, 'Targovishte', '', 1),
(501, 33, 'Varna', '', 1),
(502, 33, 'Veliko Tarnovo', '', 1),
(503, 33, 'Vidin', '', 1),
(504, 33, 'Vratza', '', 1),
(505, 33, 'Yambol', '', 1),
(506, 34, 'Bale', 'BAL', 1),
(507, 34, 'Bam', 'BAM', 1),
(508, 34, 'Banwa', 'BAN', 1),
(509, 34, 'Bazega', 'BAZ', 1),
(510, 34, 'Bougouriba', 'BOR', 1),
(511, 34, 'Boulgou', 'BLG', 1),
(512, 34, 'Boulkiemde', 'BOK', 1),
(513, 34, 'Comoe', 'COM', 1),
(514, 34, 'Ganzourgou', 'GAN', 1),
(515, 34, 'Gnagna', 'GNA', 1),
(516, 34, 'Gourma', 'GOU', 1),
(517, 34, 'Houet', 'HOU', 1),
(518, 34, 'Ioba', 'IOA', 1),
(519, 34, 'Kadiogo', 'KAD', 1),
(520, 34, 'Kenedougou', 'KEN', 1),
(521, 34, 'Komondjari', 'KOD', 1),
(522, 34, 'Kompienga', 'KOP', 1),
(523, 34, 'Kossi', 'KOS', 1),
(524, 34, 'Koulpelogo', 'KOL', 1),
(525, 34, 'Kouritenga', 'KOT', 1),
(526, 34, 'Kourweogo', 'KOW', 1),
(527, 34, 'Leraba', 'LER', 1),
(528, 34, 'Loroum', 'LOR', 1),
(529, 34, 'Mouhoun', 'MOU', 1),
(530, 34, 'Nahouri', 'NAH', 1),
(531, 34, 'Namentenga', 'NAM', 1),
(532, 34, 'Nayala', 'NAY', 1),
(533, 34, 'Noumbiel', 'NOU', 1),
(534, 34, 'Oubritenga', 'OUB', 1),
(535, 34, 'Oudalan', 'OUD', 1),
(536, 34, 'Passore', 'PAS', 1),
(537, 34, 'Poni', 'PON', 1),
(538, 34, 'Sanguie', 'SAG', 1),
(539, 34, 'Sanmatenga', 'SAM', 1),
(540, 34, 'Seno', 'SEN', 1),
(541, 34, 'Sissili', 'SIS', 1),
(542, 34, 'Soum', 'SOM', 1),
(543, 34, 'Sourou', 'SOR', 1),
(544, 34, 'Tapoa', 'TAP', 1),
(545, 34, 'Tuy', 'TUY', 1),
(546, 34, 'Yagha', 'YAG', 1),
(547, 34, 'Yatenga', 'YAT', 1),
(548, 34, 'Ziro', 'ZIR', 1),
(549, 34, 'Zondoma', 'ZOD', 1),
(550, 34, 'Zoundweogo', 'ZOW', 1),
(551, 35, 'Bubanza', 'BB', 1),
(552, 35, 'Bujumbura', 'BJ', 1),
(553, 35, 'Bururi', 'BR', 1),
(554, 35, 'Cankuzo', 'CA', 1),
(555, 35, 'Cibitoke', 'CI', 1),
(556, 35, 'Gitega', 'GI', 1),
(557, 35, 'Karuzi', 'KR', 1),
(558, 35, 'Kayanza', 'KY', 1),
(559, 35, 'Kirundo', 'KI', 1),
(560, 35, 'Makamba', 'MA', 1),
(561, 35, 'Muramvya', 'MU', 1),
(562, 35, 'Muyinga', 'MY', 1),
(563, 35, 'Mwaro', 'MW', 1),
(564, 35, 'Ngozi', 'NG', 1),
(565, 35, 'Rutana', 'RT', 1),
(566, 35, 'Ruyigi', 'RY', 1),
(567, 36, 'Phnom Penh', 'PP', 1),
(568, 36, 'Preah Seihanu (Kompong Som or Sihanoukville)', 'PS', 1),
(569, 36, 'Pailin', 'PA', 1),
(570, 36, 'Keb', 'KB', 1),
(571, 36, 'Banteay Meanchey', 'BM', 1),
(572, 36, 'Battambang', 'BA', 1),
(573, 36, 'Kampong Cham', 'KM', 1),
(574, 36, 'Kampong Chhnang', 'KN', 1),
(575, 36, 'Kampong Speu', 'KU', 1),
(576, 36, 'Kampong Som', 'KO', 1),
(577, 36, 'Kampong Thom', 'KT', 1),
(578, 36, 'Kampot', 'KP', 1),
(579, 36, 'Kandal', 'KL', 1),
(580, 36, 'Kaoh Kong', 'KK', 1),
(581, 36, 'Kratie', 'KR', 1),
(582, 36, 'Mondul Kiri', 'MK', 1),
(583, 36, 'Oddar Meancheay', 'OM', 1),
(584, 36, 'Pursat', 'PU', 1),
(585, 36, 'Preah Vihear', 'PR', 1),
(586, 36, 'Prey Veng', 'PG', 1),
(587, 36, 'Ratanak Kiri', 'RK', 1),
(588, 36, 'Siemreap', 'SI', 1),
(589, 36, 'Stung Treng', 'ST', 1),
(590, 36, 'Svay Rieng', 'SR', 1),
(591, 36, 'Takeo', 'TK', 1),
(592, 37, 'Adamawa (Adamaoua)', 'ADA', 1),
(593, 37, 'Centre', 'CEN', 1),
(594, 37, 'East (Est)', 'EST', 1),
(595, 37, 'Extreme North (Extreme-Nord)', 'EXN', 1),
(596, 37, 'Littoral', 'LIT', 1),
(597, 37, 'North (Nord)', 'NOR', 1),
(598, 37, 'Northwest (Nord-Ouest)', 'NOT', 1),
(599, 37, 'West (Ouest)', 'OUE', 1),
(600, 37, 'South (Sud)', 'SUD', 1),
(601, 37, 'Southwest (Sud-Ouest).', 'SOU', 1),
(602, 38, 'Alberta', 'AB', 1),
(603, 38, 'British Columbia', 'BC', 1),
(604, 38, 'Manitoba', 'MB', 1),
(605, 38, 'New Brunswick', 'NB', 1),
(606, 38, 'Newfoundland and Labrador', 'NL', 1),
(607, 38, 'Northwest Territories', 'NT', 1),
(608, 38, 'Nova Scotia', 'NS', 1),
(609, 38, 'Nunavut', 'NU', 1),
(610, 38, 'Ontario', 'ON', 1),
(611, 38, 'Prince Edward Island', 'PE', 1),
(612, 38, 'Qu&eacute;bec', 'QC', 1),
(613, 38, 'Saskatchewan', 'SK', 1),
(614, 38, 'Yukon Territory', 'YT', 1),
(615, 39, 'Boa Vista', 'BV', 1),
(616, 39, 'Brava', 'BR', 1),
(617, 39, 'Calheta de Sao Miguel', 'CS', 1),
(618, 39, 'Maio', 'MA', 1),
(619, 39, 'Mosteiros', 'MO', 1),
(620, 39, 'Paul', 'PA', 1),
(621, 39, 'Porto Novo', 'PN', 1),
(622, 39, 'Praia', 'PR', 1),
(623, 39, 'Ribeira Grande', 'RG', 1),
(624, 39, 'Sal', 'SL', 1),
(625, 39, 'Santa Catarina', 'CA', 1),
(626, 39, 'Santa Cruz', 'CR', 1),
(627, 39, 'Sao Domingos', 'SD', 1),
(628, 39, 'Sao Filipe', 'SF', 1),
(629, 39, 'Sao Nicolau', 'SN', 1),
(630, 39, 'Sao Vicente', 'SV', 1),
(631, 39, 'Tarrafal', 'TA', 1),
(632, 40, 'Creek', 'CR', 1),
(633, 40, 'Eastern', 'EA', 1),
(634, 40, 'Midland', 'ML', 1),
(635, 40, 'South Town', 'ST', 1),
(636, 40, 'Spot Bay', 'SP', 1),
(637, 40, 'Stake Bay', 'SK', 1),
(638, 40, 'West End', 'WD', 1),
(639, 40, 'Western', 'WN', 1),
(640, 41, 'Bamingui-Bangoran', 'BBA', 1),
(641, 41, 'Basse-Kotto', 'BKO', 1),
(642, 41, 'Haute-Kotto', 'HKO', 1),
(643, 41, 'Haut-Mbomou', 'HMB', 1),
(644, 41, 'Kemo', 'KEM', 1),
(645, 41, 'Lobaye', 'LOB', 1),
(646, 41, 'Mambere-KadeÔ', 'MKD', 1),
(647, 41, 'Mbomou', 'MBO', 1),
(648, 41, 'Nana-Mambere', 'NMM', 1),
(649, 41, 'Ombella-M\'Poko', 'OMP', 1),
(650, 41, 'Ouaka', 'OUK', 1),
(651, 41, 'Ouham', 'OUH', 1),
(652, 41, 'Ouham-Pende', 'OPE', 1),
(653, 41, 'Vakaga', 'VAK', 1),
(654, 41, 'Nana-Grebizi', 'NGR', 1),
(655, 41, 'Sangha-Mbaere', 'SMB', 1),
(656, 41, 'Bangui', 'BAN', 1),
(657, 42, 'Batha', 'BA', 1),
(658, 42, 'Biltine', 'BI', 1),
(659, 42, 'Borkou-Ennedi-Tibesti', 'BE', 1),
(660, 42, 'Chari-Baguirmi', 'CB', 1),
(661, 42, 'Guera', 'GU', 1),
(662, 42, 'Kanem', 'KA', 1),
(663, 42, 'Lac', 'LA', 1),
(664, 42, 'Logone Occidental', 'LC', 1),
(665, 42, 'Logone Oriental', 'LR', 1),
(666, 42, 'Mayo-Kebbi', 'MK', 1),
(667, 42, 'Moyen-Chari', 'MC', 1),
(668, 42, 'Ouaddai', 'OU', 1),
(669, 42, 'Salamat', 'SA', 1),
(670, 42, 'Tandjile', 'TA', 1),
(671, 43, 'Aisen del General Carlos Ibanez', 'AI', 1),
(672, 43, 'Antofagasta', 'AN', 1),
(673, 43, 'Araucania', 'AR', 1),
(674, 43, 'Atacama', 'AT', 1),
(675, 43, 'Bio-Bio', 'BI', 1),
(676, 43, 'Coquimbo', 'CO', 1),
(677, 43, 'Libertador General Bernardo O\'Higgins', 'LI', 1),
(678, 43, 'Los Lagos', 'LL', 1),
(679, 43, 'Magallanes y de la Antartica Chilena', 'MA', 1),
(680, 43, 'Maule', 'ML', 1),
(681, 43, 'Region Metropolitana', 'RM', 1),
(682, 43, 'Tarapaca', 'TA', 1),
(683, 43, 'Valparaiso', 'VS', 1),
(684, 44, 'Anhui', 'AN', 1),
(685, 44, 'Beijing', 'BE', 1),
(686, 44, 'Chongqing', 'CH', 1),
(687, 44, 'Fujian', 'FU', 1),
(688, 44, 'Gansu', 'GA', 1),
(689, 44, 'Guangdong', 'GU', 1),
(690, 44, 'Guangxi', 'GX', 1),
(691, 44, 'Guizhou', 'GZ', 1),
(692, 44, 'Hainan', 'HA', 1),
(693, 44, 'Hebei', 'HB', 1),
(694, 44, 'Heilongjiang', 'HL', 1),
(695, 44, 'Henan', 'HE', 1),
(696, 44, 'Hong Kong', 'HK', 1),
(697, 44, 'Hubei', 'HU', 1),
(698, 44, 'Hunan', 'HN', 1),
(699, 44, 'Inner Mongolia', 'IM', 1),
(700, 44, 'Jiangsu', 'JI', 1),
(701, 44, 'Jiangxi', 'JX', 1),
(702, 44, 'Jilin', 'JL', 1),
(703, 44, 'Liaoning', 'LI', 1),
(704, 44, 'Macau', 'MA', 1),
(705, 44, 'Ningxia', 'NI', 1),
(706, 44, 'Shaanxi', 'SH', 1),
(707, 44, 'Shandong', 'SA', 1),
(708, 44, 'Shanghai', 'SG', 1),
(709, 44, 'Shanxi', 'SX', 1),
(710, 44, 'Sichuan', 'SI', 1),
(711, 44, 'Tianjin', 'TI', 1),
(712, 44, 'Xinjiang', 'XI', 1),
(713, 44, 'Yunnan', 'YU', 1),
(714, 44, 'Zhejiang', 'ZH', 1),
(715, 46, 'Direction Island', 'D', 1),
(716, 46, 'Home Island', 'H', 1),
(717, 46, 'Horsburgh Island', 'O', 1),
(718, 46, 'South Island', 'S', 1),
(719, 46, 'West Island', 'W', 1),
(720, 47, 'Amazonas', 'AMZ', 1),
(721, 47, 'Antioquia', 'ANT', 1),
(722, 47, 'Arauca', 'ARA', 1),
(723, 47, 'Atlantico', 'ATL', 1),
(724, 47, 'Bogota D.C.', 'BDC', 1),
(725, 47, 'Bolivar', 'BOL', 1),
(726, 47, 'Boyaca', 'BOY', 1),
(727, 47, 'Caldas', 'CAL', 1),
(728, 47, 'Caqueta', 'CAQ', 1),
(729, 47, 'Casanare', 'CAS', 1),
(730, 47, 'Cauca', 'CAU', 1),
(731, 47, 'Cesar', 'CES', 1),
(732, 47, 'Choco', 'CHO', 1),
(733, 47, 'Cordoba', 'COR', 1),
(734, 47, 'Cundinamarca', 'CAM', 1),
(735, 47, 'Guainia', 'GNA', 1),
(736, 47, 'Guajira', 'GJR', 1),
(737, 47, 'Guaviare', 'GVR', 1),
(738, 47, 'Huila', 'HUI', 1),
(739, 47, 'Magdalena', 'MAG', 1),
(740, 47, 'Meta', 'MET', 1),
(741, 47, 'Narino', 'NAR', 1),
(742, 47, 'Norte de Santander', 'NDS', 1),
(743, 47, 'Putumayo', 'PUT', 1),
(744, 47, 'Quindio', 'QUI', 1),
(745, 47, 'Risaralda', 'RIS', 1),
(746, 47, 'San Andres y Providencia', 'SAP', 1),
(747, 47, 'Santander', 'SAN', 1),
(748, 47, 'Sucre', 'SUC', 1),
(749, 47, 'Tolima', 'TOL', 1),
(750, 47, 'Valle del Cauca', 'VDC', 1),
(751, 47, 'Vaupes', 'VAU', 1),
(752, 47, 'Vichada', 'VIC', 1),
(753, 48, 'Grande Comore', 'G', 1),
(754, 48, 'Anjouan', 'A', 1),
(755, 48, 'Moheli', 'M', 1),
(756, 49, 'Bouenza', 'BO', 1),
(757, 49, 'Brazzaville', 'BR', 1),
(758, 49, 'Cuvette', 'CU', 1),
(759, 49, 'Cuvette-Ouest', 'CO', 1),
(760, 49, 'Kouilou', 'KO', 1),
(761, 49, 'Lekoumou', 'LE', 1),
(762, 49, 'Likouala', 'LI', 1),
(763, 49, 'Niari', 'NI', 1),
(764, 49, 'Plateaux', 'PL', 1),
(765, 49, 'Pool', 'PO', 1),
(766, 49, 'Sangha', 'SA', 1),
(767, 50, 'Pukapuka', 'PU', 1),
(768, 50, 'Rakahanga', 'RK', 1),
(769, 50, 'Manihiki', 'MK', 1),
(770, 50, 'Penrhyn', 'PE', 1),
(771, 50, 'Nassau Island', 'NI', 1),
(772, 50, 'Surwarrow', 'SU', 1),
(773, 50, 'Palmerston', 'PA', 1),
(774, 50, 'Aitutaki', 'AI', 1),
(775, 50, 'Manuae', 'MA', 1),
(776, 50, 'Takutea', 'TA', 1),
(777, 50, 'Mitiaro', 'MT', 1),
(778, 50, 'Atiu', 'AT', 1),
(779, 50, 'Mauke', 'MU', 1),
(780, 50, 'Rarotonga', 'RR', 1),
(781, 50, 'Mangaia', 'MG', 1),
(782, 51, 'Alajuela', 'AL', 1),
(783, 51, 'Cartago', 'CA', 1),
(784, 51, 'Guanacaste', 'GU', 1),
(785, 51, 'Heredia', 'HE', 1),
(786, 51, 'Limon', 'LI', 1),
(787, 51, 'Puntarenas', 'PU', 1),
(788, 51, 'San Jose', 'SJ', 1),
(789, 52, 'Abengourou', 'ABE', 1),
(790, 52, 'Abidjan', 'ABI', 1),
(791, 52, 'Aboisso', 'ABO', 1),
(792, 52, 'Adiake', 'ADI', 1),
(793, 52, 'Adzope', 'ADZ', 1),
(794, 52, 'Agboville', 'AGB', 1),
(795, 52, 'Agnibilekrou', 'AGN', 1),
(796, 52, 'Alepe', 'ALE', 1),
(797, 52, 'Bocanda', 'BOC', 1),
(798, 52, 'Bangolo', 'BAN', 1),
(799, 52, 'Beoumi', 'BEO', 1),
(800, 52, 'Biankouma', 'BIA', 1),
(801, 52, 'Bondoukou', 'BDK', 1),
(802, 52, 'Bongouanou', 'BGN', 1),
(803, 52, 'Bouafle', 'BFL', 1),
(804, 52, 'Bouake', 'BKE', 1),
(805, 52, 'Bouna', 'BNA', 1),
(806, 52, 'Boundiali', 'BDL', 1),
(807, 52, 'Dabakala', 'DKL', 1),
(808, 52, 'Dabou', 'DBU', 1),
(809, 52, 'Daloa', 'DAL', 1),
(810, 52, 'Danane', 'DAN', 1),
(811, 52, 'Daoukro', 'DAO', 1),
(812, 52, 'Dimbokro', 'DIM', 1),
(813, 52, 'Divo', 'DIV', 1),
(814, 52, 'Duekoue', 'DUE', 1),
(815, 52, 'Ferkessedougou', 'FER', 1),
(816, 52, 'Gagnoa', 'GAG', 1),
(817, 52, 'Grand-Bassam', 'GBA', 1),
(818, 52, 'Grand-Lahou', 'GLA', 1),
(819, 52, 'Guiglo', 'GUI', 1),
(820, 52, 'Issia', 'ISS', 1),
(821, 52, 'Jacqueville', 'JAC', 1),
(822, 52, 'Katiola', 'KAT', 1),
(823, 52, 'Korhogo', 'KOR', 1),
(824, 52, 'Lakota', 'LAK', 1),
(825, 52, 'Man', 'MAN', 1),
(826, 52, 'Mankono', 'MKN', 1),
(827, 52, 'Mbahiakro', 'MBA', 1),
(828, 52, 'Odienne', 'ODI', 1),
(829, 52, 'Oume', 'OUM', 1),
(830, 52, 'Sakassou', 'SAK', 1),
(831, 52, 'San-Pedro', 'SPE', 1),
(832, 52, 'Sassandra', 'SAS', 1),
(833, 52, 'Seguela', 'SEG', 1),
(834, 52, 'Sinfra', 'SIN', 1),
(835, 52, 'Soubre', 'SOU', 1),
(836, 52, 'Tabou', 'TAB', 1),
(837, 52, 'Tanda', 'TAN', 1),
(838, 52, 'Tiebissou', 'TIE', 1),
(839, 52, 'Tingrela', 'TIN', 1),
(840, 52, 'Tiassale', 'TIA', 1),
(841, 52, 'Touba', 'TBA', 1),
(842, 52, 'Toulepleu', 'TLP', 1),
(843, 52, 'Toumodi', 'TMD', 1),
(844, 52, 'Vavoua', 'VAV', 1),
(845, 52, 'Yamoussoukro', 'YAM', 1),
(846, 52, 'Zuenoula', 'ZUE', 1),
(847, 53, 'Bjelovarsko-bilogorska', 'BB', 1),
(848, 53, 'Grad Zagreb', 'GZ', 1),
(849, 53, 'Dubrovačko-neretvanska', 'DN', 1),
(850, 53, 'Istarska', 'IS', 1),
(851, 53, 'Karlovačka', 'KA', 1),
(852, 53, 'Koprivničko-križevačka', 'KK', 1),
(853, 53, 'Krapinsko-zagorska', 'KZ', 1),
(854, 53, 'Ličko-senjska', 'LS', 1),
(855, 53, 'Međimurska', 'ME', 1),
(856, 53, 'Osječko-baranjska', 'OB', 1),
(857, 53, 'Požeško-slavonska', 'PS', 1),
(858, 53, 'Primorsko-goranska', 'PG', 1),
(859, 53, 'Šibensko-kninska', 'SK', 1),
(860, 53, 'Sisačko-moslavačka', 'SM', 1),
(861, 53, 'Brodsko-posavska', 'BP', 1),
(862, 53, 'Splitsko-dalmatinska', 'SD', 1),
(863, 53, 'Varaždinska', 'VA', 1),
(864, 53, 'Virovitičko-podravska', 'VP', 1),
(865, 53, 'Vukovarsko-srijemska', 'VS', 1),
(866, 53, 'Zadarska', 'ZA', 1),
(867, 53, 'Zagrebačka', 'ZG', 1),
(868, 54, 'Camaguey', 'CA', 1),
(869, 54, 'Ciego de Avila', 'CD', 1),
(870, 54, 'Cienfuegos', 'CI', 1),
(871, 54, 'Ciudad de La Habana', 'CH', 1),
(872, 54, 'Granma', 'GR', 1),
(873, 54, 'Guantanamo', 'GU', 1),
(874, 54, 'Holguin', 'HO', 1),
(875, 54, 'Isla de la Juventud', 'IJ', 1),
(876, 54, 'La Habana', 'LH', 1),
(877, 54, 'Las Tunas', 'LT', 1),
(878, 54, 'Matanzas', 'MA', 1),
(879, 54, 'Pinar del Rio', 'PR', 1),
(880, 54, 'Sancti Spiritus', 'SS', 1),
(881, 54, 'Santiago de Cuba', 'SC', 1),
(882, 54, 'Villa Clara', 'VC', 1),
(883, 55, 'Famagusta', 'F', 1),
(884, 55, 'Kyrenia', 'K', 1),
(885, 55, 'Larnaca', 'A', 1),
(886, 55, 'Limassol', 'I', 1),
(887, 55, 'Nicosia', 'N', 1),
(888, 55, 'Paphos', 'P', 1),
(889, 56, 'Ústecký', 'U', 1),
(890, 56, 'Jihočeský', 'C', 1),
(891, 56, 'Jihomoravský', 'B', 1),
(892, 56, 'Karlovarský', 'K', 1),
(893, 56, 'Královehradecký', 'H', 1),
(894, 56, 'Liberecký', 'L', 1),
(895, 56, 'Moravskoslezský', 'T', 1),
(896, 56, 'Olomoucký', 'M', 1),
(897, 56, 'Pardubický', 'E', 1),
(898, 56, 'Plzeňský', 'P', 1),
(899, 56, 'Praha', 'A', 1),
(900, 56, 'Středočeský', 'S', 1),
(901, 56, 'Vysočina', 'J', 1),
(902, 56, 'Zlínský', 'Z', 1),
(903, 57, 'Arhus', 'AR', 1),
(904, 57, 'Bornholm', 'BH', 1),
(905, 57, 'Copenhagen', 'CO', 1),
(906, 57, 'Faroe Islands', 'FO', 1),
(907, 57, 'Frederiksborg', 'FR', 1),
(908, 57, 'Fyn', 'FY', 1),
(909, 57, 'Kobenhavn', 'KO', 1),
(910, 57, 'Nordjylland', 'NO', 1),
(911, 57, 'Ribe', 'RI', 1),
(912, 57, 'Ringkobing', 'RK', 1),
(913, 57, 'Roskilde', 'RO', 1),
(914, 57, 'Sonderjylland', 'SO', 1),
(915, 57, 'Storstrom', 'ST', 1),
(916, 57, 'Vejle', 'VK', 1),
(917, 57, 'Vestj&aelig;lland', 'VJ', 1),
(918, 57, 'Viborg', 'VB', 1),
(919, 58, '\'Ali Sabih', 'S', 1),
(920, 58, 'Dikhil', 'K', 1),
(921, 58, 'Djibouti', 'J', 1),
(922, 58, 'Obock', 'O', 1),
(923, 58, 'Tadjoura', 'T', 1),
(924, 59, 'Saint Andrew Parish', 'AND', 1),
(925, 59, 'Saint David Parish', 'DAV', 1),
(926, 59, 'Saint George Parish', 'GEO', 1),
(927, 59, 'Saint John Parish', 'JOH', 1),
(928, 59, 'Saint Joseph Parish', 'JOS', 1),
(929, 59, 'Saint Luke Parish', 'LUK', 1),
(930, 59, 'Saint Mark Parish', 'MAR', 1),
(931, 59, 'Saint Patrick Parish', 'PAT', 1),
(932, 59, 'Saint Paul Parish', 'PAU', 1),
(933, 59, 'Saint Peter Parish', 'PET', 1),
(934, 60, 'Distrito Nacional', 'DN', 1),
(935, 60, 'Azua', 'AZ', 1),
(936, 60, 'Baoruco', 'BC', 1),
(937, 60, 'Barahona', 'BH', 1),
(938, 60, 'Dajabon', 'DJ', 1),
(939, 60, 'Duarte', 'DU', 1),
(940, 60, 'Elias Pina', 'EL', 1),
(941, 60, 'El Seybo', 'SY', 1),
(942, 60, 'Espaillat', 'ET', 1),
(943, 60, 'Hato Mayor', 'HM', 1),
(944, 60, 'Independencia', 'IN', 1),
(945, 60, 'La Altagracia', 'AL', 1),
(946, 60, 'La Romana', 'RO', 1),
(947, 60, 'La Vega', 'VE', 1),
(948, 60, 'Maria Trinidad Sanchez', 'MT', 1),
(949, 60, 'Monsenor Nouel', 'MN', 1),
(950, 60, 'Monte Cristi', 'MC', 1),
(951, 60, 'Monte Plata', 'MP', 1),
(952, 60, 'Pedernales', 'PD', 1),
(953, 60, 'Peravia (Bani)', 'PR', 1),
(954, 60, 'Puerto Plata', 'PP', 1),
(955, 60, 'Salcedo', 'SL', 1),
(956, 60, 'Samana', 'SM', 1),
(957, 60, 'Sanchez Ramirez', 'SH', 1),
(958, 60, 'San Cristobal', 'SC', 1),
(959, 60, 'San Jose de Ocoa', 'JO', 1),
(960, 60, 'San Juan', 'SJ', 1),
(961, 60, 'San Pedro de Macoris', 'PM', 1),
(962, 60, 'Santiago', 'SA', 1),
(963, 60, 'Santiago Rodriguez', 'ST', 1),
(964, 60, 'Santo Domingo', 'SD', 1),
(965, 60, 'Valverde', 'VA', 1),
(966, 61, 'Aileu', 'AL', 1),
(967, 61, 'Ainaro', 'AN', 1),
(968, 61, 'Baucau', 'BA', 1),
(969, 61, 'Bobonaro', 'BO', 1),
(970, 61, 'Cova Lima', 'CO', 1),
(971, 61, 'Dili', 'DI', 1),
(972, 61, 'Ermera', 'ER', 1),
(973, 61, 'Lautem', 'LA', 1),
(974, 61, 'Liquica', 'LI', 1),
(975, 61, 'Manatuto', 'MT', 1),
(976, 61, 'Manufahi', 'MF', 1),
(977, 61, 'Oecussi', 'OE', 1),
(978, 61, 'Viqueque', 'VI', 1),
(979, 62, 'Azuay', 'AZU', 1),
(980, 62, 'Bolivar', 'BOL', 1),
(981, 62, 'Ca&ntilde;ar', 'CAN', 1),
(982, 62, 'Carchi', 'CAR', 1),
(983, 62, 'Chimborazo', 'CHI', 1),
(984, 62, 'Cotopaxi', 'COT', 1),
(985, 62, 'El Oro', 'EOR', 1),
(986, 62, 'Esmeraldas', 'ESM', 1),
(987, 62, 'Gal&aacute;pagos', 'GPS', 1),
(988, 62, 'Guayas', 'GUA', 1),
(989, 62, 'Imbabura', 'IMB', 1),
(990, 62, 'Loja', 'LOJ', 1),
(991, 62, 'Los Rios', 'LRO', 1),
(992, 62, 'Manab&iacute;', 'MAN', 1),
(993, 62, 'Morona Santiago', 'MSA', 1),
(994, 62, 'Napo', 'NAP', 1),
(995, 62, 'Orellana', 'ORE', 1),
(996, 62, 'Pastaza', 'PAS', 1),
(997, 62, 'Pichincha', 'PIC', 1),
(998, 62, 'Sucumb&iacute;os', 'SUC', 1),
(999, 62, 'Tungurahua', 'TUN', 1),
(1000, 62, 'Zamora Chinchipe', 'ZCH', 1),
(1001, 63, 'Ad Daqahliyah', 'DHY', 1),
(1002, 63, 'Al Bahr al Ahmar', 'BAM', 1),
(1003, 63, 'Al Buhayrah', 'BHY', 1),
(1004, 63, 'Al Fayyum', 'FYM', 1),
(1005, 63, 'Al Gharbiyah', 'GBY', 1),
(1006, 63, 'Al Iskandariyah', 'IDR', 1),
(1007, 63, 'Al Isma\'iliyah', 'IML', 1),
(1008, 63, 'Al Jizah', 'JZH', 1),
(1009, 63, 'Al Minufiyah', 'MFY', 1),
(1010, 63, 'Al Minya', 'MNY', 1),
(1011, 63, 'Al Qahirah', 'QHR', 1),
(1012, 63, 'Al Qalyubiyah', 'QLY', 1),
(1013, 63, 'Al Wadi al Jadid', 'WJD', 1),
(1014, 63, 'Ash Sharqiyah', 'SHQ', 1),
(1015, 63, 'As Suways', 'SWY', 1),
(1016, 63, 'Aswan', 'ASW', 1),
(1017, 63, 'Asyut', 'ASY', 1),
(1018, 63, 'Bani Suwayf', 'BSW', 1),
(1019, 63, 'Bur Sa\'id', 'BSD', 1),
(1020, 63, 'Dumyat', 'DMY', 1),
(1021, 63, 'Janub Sina\'', 'JNS', 1),
(1022, 63, 'Kafr ash Shaykh', 'KSH', 1),
(1023, 63, 'Matruh', 'MAT', 1),
(1024, 63, 'Qina', 'QIN', 1),
(1025, 63, 'Shamal Sina\'', 'SHS', 1),
(1026, 63, 'Suhaj', 'SUH', 1),
(1027, 64, 'Ahuachapan', 'AH', 1),
(1028, 64, 'Cabanas', 'CA', 1),
(1029, 64, 'Chalatenango', 'CH', 1),
(1030, 64, 'Cuscatlan', 'CU', 1),
(1031, 64, 'La Libertad', 'LB', 1),
(1032, 64, 'La Paz', 'PZ', 1),
(1033, 64, 'La Union', 'UN', 1),
(1034, 64, 'Morazan', 'MO', 1),
(1035, 64, 'San Miguel', 'SM', 1),
(1036, 64, 'San Salvador', 'SS', 1),
(1037, 64, 'San Vicente', 'SV', 1),
(1038, 64, 'Santa Ana', 'SA', 1),
(1039, 64, 'Sonsonate', 'SO', 1),
(1040, 64, 'Usulutan', 'US', 1),
(1041, 65, 'Provincia Annobon', 'AN', 1),
(1042, 65, 'Provincia Bioko Norte', 'BN', 1),
(1043, 65, 'Provincia Bioko Sur', 'BS', 1),
(1044, 65, 'Provincia Centro Sur', 'CS', 1),
(1045, 65, 'Provincia Kie-Ntem', 'KN', 1),
(1046, 65, 'Provincia Litoral', 'LI', 1),
(1047, 65, 'Provincia Wele-Nzas', 'WN', 1),
(1048, 66, 'Central (Maekel)', 'MA', 1),
(1049, 66, 'Anseba (Keren)', 'KE', 1),
(1050, 66, 'Southern Red Sea (Debub-Keih-Bahri)', 'DK', 1),
(1051, 66, 'Northern Red Sea (Semien-Keih-Bahri)', 'SK', 1),
(1052, 66, 'Southern (Debub)', 'DE', 1),
(1053, 66, 'Gash-Barka (Barentu)', 'BR', 1),
(1054, 67, 'Harjumaa (Tallinn)', 'HA', 1),
(1055, 67, 'Hiiumaa (Kardla)', 'HI', 1),
(1056, 67, 'Ida-Virumaa (Johvi)', 'IV', 1),
(1057, 67, 'Jarvamaa (Paide)', 'JA', 1),
(1058, 67, 'Jogevamaa (Jogeva)', 'JO', 1),
(1059, 67, 'Laane-Virumaa (Rakvere)', 'LV', 1),
(1060, 67, 'Laanemaa (Haapsalu)', 'LA', 1),
(1061, 67, 'Parnumaa (Parnu)', 'PA', 1),
(1062, 67, 'Polvamaa (Polva)', 'PO', 1),
(1063, 67, 'Raplamaa (Rapla)', 'RA', 1),
(1064, 67, 'Saaremaa (Kuessaare)', 'SA', 1),
(1065, 67, 'Tartumaa (Tartu)', 'TA', 1),
(1066, 67, 'Valgamaa (Valga)', 'VA', 1),
(1067, 67, 'Viljandimaa (Viljandi)', 'VI', 1),
(1068, 67, 'Vorumaa (Voru)', 'VO', 1),
(1069, 68, 'Afar', 'AF', 1),
(1070, 68, 'Amhara', 'AH', 1),
(1071, 68, 'Benishangul-Gumaz', 'BG', 1),
(1072, 68, 'Gambela', 'GB', 1),
(1073, 68, 'Hariai', 'HR', 1),
(1074, 68, 'Oromia', 'OR', 1),
(1075, 68, 'Somali', 'SM', 1),
(1076, 68, 'Southern Nations - Nationalities and Peoples Region', 'SN', 1),
(1077, 68, 'Tigray', 'TG', 1),
(1078, 68, 'Addis Ababa', 'AA', 1),
(1079, 68, 'Dire Dawa', 'DD', 1),
(1080, 71, 'Central Division', 'C', 1),
(1081, 71, 'Northern Division', 'N', 1),
(1082, 71, 'Eastern Division', 'E', 1),
(1083, 71, 'Western Division', 'W', 1),
(1084, 71, 'Rotuma', 'R', 1),
(1085, 72, 'Ahvenanmaan lääni', 'AL', 1),
(1086, 72, 'Etelä-Suomen lääni', 'ES', 1),
(1087, 72, 'Itä-Suomen lääni', 'IS', 1),
(1088, 72, 'Länsi-Suomen lääni', 'LS', 1),
(1089, 72, 'Lapin lääni', 'LA', 1),
(1090, 72, 'Oulun lääni', 'OU', 1),
(1114, 74, 'Ain', '01', 1),
(1115, 74, 'Aisne', '02', 1),
(1116, 74, 'Allier', '03', 1),
(1117, 74, 'Alpes de Haute Provence', '04', 1),
(1118, 74, 'Hautes-Alpes', '05', 1),
(1119, 74, 'Alpes Maritimes', '06', 1),
(1120, 74, 'Ard&egrave;che', '07', 1),
(1121, 74, 'Ardennes', '08', 1),
(1122, 74, 'Ari&egrave;ge', '09', 1),
(1123, 74, 'Aube', '10', 1),
(1124, 74, 'Aude', '11', 1),
(1125, 74, 'Aveyron', '12', 1),
(1126, 74, 'Bouches du Rh&ocirc;ne', '13', 1),
(1127, 74, 'Calvados', '14', 1),
(1128, 74, 'Cantal', '15', 1),
(1129, 74, 'Charente', '16', 1),
(1130, 74, 'Charente Maritime', '17', 1),
(1131, 74, 'Cher', '18', 1),
(1132, 74, 'Corr&egrave;ze', '19', 1),
(1133, 74, 'Corse du Sud', '2A', 1),
(1134, 74, 'Haute Corse', '2B', 1),
(1135, 74, 'C&ocirc;te d&#039;or', '21', 1),
(1136, 74, 'C&ocirc;tes d&#039;Armor', '22', 1),
(1137, 74, 'Creuse', '23', 1),
(1138, 74, 'Dordogne', '24', 1),
(1139, 74, 'Doubs', '25', 1),
(1140, 74, 'Dr&ocirc;me', '26', 1),
(1141, 74, 'Eure', '27', 1),
(1142, 74, 'Eure et Loir', '28', 1),
(1143, 74, 'Finist&egrave;re', '29', 1),
(1144, 74, 'Gard', '30', 1),
(1145, 74, 'Haute Garonne', '31', 1),
(1146, 74, 'Gers', '32', 1),
(1147, 74, 'Gironde', '33', 1),
(1148, 74, 'H&eacute;rault', '34', 1),
(1149, 74, 'Ille et Vilaine', '35', 1),
(1150, 74, 'Indre', '36', 1),
(1151, 74, 'Indre et Loire', '37', 1),
(1152, 74, 'Is&eacute;re', '38', 1),
(1153, 74, 'Jura', '39', 1),
(1154, 74, 'Landes', '40', 1),
(1155, 74, 'Loir et Cher', '41', 1),
(1156, 74, 'Loire', '42', 1),
(1157, 74, 'Haute Loire', '43', 1),
(1158, 74, 'Loire Atlantique', '44', 1),
(1159, 74, 'Loiret', '45', 1),
(1160, 74, 'Lot', '46', 1),
(1161, 74, 'Lot et Garonne', '47', 1),
(1162, 74, 'Loz&egrave;re', '48', 1),
(1163, 74, 'Maine et Loire', '49', 1),
(1164, 74, 'Manche', '50', 1),
(1165, 74, 'Marne', '51', 1),
(1166, 74, 'Haute Marne', '52', 1),
(1167, 74, 'Mayenne', '53', 1),
(1168, 74, 'Meurthe et Moselle', '54', 1),
(1169, 74, 'Meuse', '55', 1),
(1170, 74, 'Morbihan', '56', 1),
(1171, 74, 'Moselle', '57', 1),
(1172, 74, 'Ni&egrave;vre', '58', 1),
(1173, 74, 'Nord', '59', 1),
(1174, 74, 'Oise', '60', 1),
(1175, 74, 'Orne', '61', 1),
(1176, 74, 'Pas de Calais', '62', 1),
(1177, 74, 'Puy de D&ocirc;me', '63', 1),
(1178, 74, 'Pyr&eacute;n&eacute;es Atlantiques', '64', 1),
(1179, 74, 'Hautes Pyr&eacute;n&eacute;es', '65', 1),
(1180, 74, 'Pyr&eacute;n&eacute;es Orientales', '66', 1),
(1181, 74, 'Bas Rhin', '67', 1),
(1182, 74, 'Haut Rhin', '68', 1),
(1183, 74, 'Rh&ocirc;ne', '69', 1),
(1184, 74, 'Haute Sa&ocirc;ne', '70', 1),
(1185, 74, 'Sa&ocirc;ne et Loire', '71', 1),
(1186, 74, 'Sarthe', '72', 1),
(1187, 74, 'Savoie', '73', 1),
(1188, 74, 'Haute Savoie', '74', 1),
(1189, 74, 'Paris', '75', 1),
(1190, 74, 'Seine Maritime', '76', 1),
(1191, 74, 'Seine et Marne', '77', 1),
(1192, 74, 'Yvelines', '78', 1),
(1193, 74, 'Deux S&egrave;vres', '79', 1),
(1194, 74, 'Somme', '80', 1),
(1195, 74, 'Tarn', '81', 1),
(1196, 74, 'Tarn et Garonne', '82', 1),
(1197, 74, 'Var', '83', 1),
(1198, 74, 'Vaucluse', '84', 1),
(1199, 74, 'Vend&eacute;e', '85', 1),
(1200, 74, 'Vienne', '86', 1),
(1201, 74, 'Haute Vienne', '87', 1),
(1202, 74, 'Vosges', '88', 1),
(1203, 74, 'Yonne', '89', 1),
(1204, 74, 'Territoire de Belfort', '90', 1),
(1205, 74, 'Essonne', '91', 1),
(1206, 74, 'Hauts de Seine', '92', 1),
(1207, 74, 'Seine St-Denis', '93', 1),
(1208, 74, 'Val de Marne', '94', 1),
(1209, 74, 'Val d\'Oise', '95', 1),
(1210, 76, 'Archipel des Marquises', 'M', 1),
(1211, 76, 'Archipel des Tuamotu', 'T', 1),
(1212, 76, 'Archipel des Tubuai', 'I', 1),
(1213, 76, 'Iles du Vent', 'V', 1),
(1214, 76, 'Iles Sous-le-Vent', 'S', 1),
(1215, 77, 'Iles Crozet', 'C', 1),
(1216, 77, 'Iles Kerguelen', 'K', 1),
(1217, 77, 'Ile Amsterdam', 'A', 1),
(1218, 77, 'Ile Saint-Paul', 'P', 1),
(1219, 77, 'Adelie Land', 'D', 1),
(1220, 78, 'Estuaire', 'ES', 1),
(1221, 78, 'Haut-Ogooue', 'HO', 1),
(1222, 78, 'Moyen-Ogooue', 'MO', 1),
(1223, 78, 'Ngounie', 'NG', 1),
(1224, 78, 'Nyanga', 'NY', 1),
(1225, 78, 'Ogooue-Ivindo', 'OI', 1),
(1226, 78, 'Ogooue-Lolo', 'OL', 1),
(1227, 78, 'Ogooue-Maritime', 'OM', 1),
(1228, 78, 'Woleu-Ntem', 'WN', 1),
(1229, 79, 'Banjul', 'BJ', 1),
(1230, 79, 'Basse', 'BS', 1),
(1231, 79, 'Brikama', 'BR', 1),
(1232, 79, 'Janjangbure', 'JA', 1),
(1233, 79, 'Kanifeng', 'KA', 1),
(1234, 79, 'Kerewan', 'KE', 1),
(1235, 79, 'Kuntaur', 'KU', 1),
(1236, 79, 'Mansakonko', 'MA', 1),
(1237, 79, 'Lower River', 'LR', 1),
(1238, 79, 'Central River', 'CR', 1),
(1239, 79, 'North Bank', 'NB', 1),
(1240, 79, 'Upper River', 'UR', 1),
(1241, 79, 'Western', 'WE', 1),
(1242, 80, 'Abkhazia', 'AB', 1),
(1243, 80, 'Ajaria', 'AJ', 1),
(1244, 80, 'Tbilisi', 'TB', 1),
(1245, 80, 'Guria', 'GU', 1),
(1246, 80, 'Imereti', 'IM', 1),
(1247, 80, 'Kakheti', 'KA', 1),
(1248, 80, 'Kvemo Kartli', 'KK', 1),
(1249, 80, 'Mtskheta-Mtianeti', 'MM', 1),
(1250, 80, 'Racha Lechkhumi and Kvemo Svanet', 'RL', 1),
(1251, 80, 'Samegrelo-Zemo Svaneti', 'SZ', 1),
(1252, 80, 'Samtskhe-Javakheti', 'SJ', 1),
(1253, 80, 'Shida Kartli', 'SK', 1),
(1254, 81, 'Baden-Württemberg', 'BAW', 1),
(1255, 81, 'Bayern', 'BAY', 1),
(1256, 81, 'Berlin', 'BER', 1),
(1257, 81, 'Brandenburg', 'BRG', 1),
(1258, 81, 'Bremen', 'BRE', 1),
(1259, 81, 'Hamburg', 'HAM', 1),
(1260, 81, 'Hessen', 'HES', 1),
(1261, 81, 'Mecklenburg-Vorpommern', 'MEC', 1),
(1262, 81, 'Niedersachsen', 'NDS', 1),
(1263, 81, 'Nordrhein-Westfalen', 'NRW', 1),
(1264, 81, 'Rheinland-Pfalz', 'RHE', 1),
(1265, 81, 'Saarland', 'SAR', 1),
(1266, 81, 'Sachsen', 'SAS', 1),
(1267, 81, 'Sachsen-Anhalt', 'SAC', 1),
(1268, 81, 'Schleswig-Holstein', 'SCN', 1),
(1269, 81, 'Thüringen', 'THE', 1),
(1270, 82, 'Ashanti Region', 'AS', 1),
(1271, 82, 'Brong-Ahafo Region', 'BA', 1),
(1272, 82, 'Central Region', 'CE', 1),
(1273, 82, 'Eastern Region', 'EA', 1),
(1274, 82, 'Greater Accra Region', 'GA', 1),
(1275, 82, 'Northern Region', 'NO', 1),
(1276, 82, 'Upper East Region', 'UE', 1),
(1277, 82, 'Upper West Region', 'UW', 1),
(1278, 82, 'Volta Region', 'VO', 1),
(1279, 82, 'Western Region', 'WE', 1),
(1280, 84, 'Attica', 'AT', 1),
(1281, 84, 'Central Greece', 'CN', 1),
(1282, 84, 'Central Macedonia', 'CM', 1),
(1283, 84, 'Crete', 'CR', 1),
(1284, 84, 'East Macedonia and Thrace', 'EM', 1),
(1285, 84, 'Epirus', 'EP', 1),
(1286, 84, 'Ionian Islands', 'II', 1),
(1287, 84, 'North Aegean', 'NA', 1),
(1288, 84, 'Peloponnesos', 'PP', 1),
(1289, 84, 'South Aegean', 'SA', 1),
(1290, 84, 'Thessaly', 'TH', 1),
(1291, 84, 'West Greece', 'WG', 1),
(1292, 84, 'West Macedonia', 'WM', 1),
(1293, 85, 'Avannaa', 'A', 1),
(1294, 85, 'Tunu', 'T', 1),
(1295, 85, 'Kitaa', 'K', 1),
(1296, 86, 'Saint Andrew', 'A', 1),
(1297, 86, 'Saint David', 'D', 1),
(1298, 86, 'Saint George', 'G', 1),
(1299, 86, 'Saint John', 'J', 1),
(1300, 86, 'Saint Mark', 'M', 1),
(1301, 86, 'Saint Patrick', 'P', 1),
(1302, 86, 'Carriacou', 'C', 1),
(1303, 86, 'Petit Martinique', 'Q', 1),
(1304, 89, 'Alta Verapaz', 'AV', 1),
(1305, 89, 'Baja Verapaz', 'BV', 1),
(1306, 89, 'Chimaltenango', 'CM', 1),
(1307, 89, 'Chiquimula', 'CQ', 1),
(1308, 89, 'El Peten', 'PE', 1),
(1309, 89, 'El Progreso', 'PR', 1),
(1310, 89, 'El Quiche', 'QC', 1),
(1311, 89, 'Escuintla', 'ES', 1),
(1312, 89, 'Guatemala', 'GU', 1),
(1313, 89, 'Huehuetenango', 'HU', 1),
(1314, 89, 'Izabal', 'IZ', 1),
(1315, 89, 'Jalapa', 'JA', 1),
(1316, 89, 'Jutiapa', 'JU', 1),
(1317, 89, 'Quetzaltenango', 'QZ', 1),
(1318, 89, 'Retalhuleu', 'RE', 1),
(1319, 89, 'Sacatepequez', 'ST', 1),
(1320, 89, 'San Marcos', 'SM', 1),
(1321, 89, 'Santa Rosa', 'SR', 1),
(1322, 89, 'Solola', 'SO', 1),
(1323, 89, 'Suchitepequez', 'SU', 1),
(1324, 89, 'Totonicapan', 'TO', 1),
(1325, 89, 'Zacapa', 'ZA', 1),
(1326, 90, 'Conakry', 'CNK', 1),
(1327, 90, 'Beyla', 'BYL', 1),
(1328, 90, 'Boffa', 'BFA', 1),
(1329, 90, 'Boke', 'BOK', 1),
(1330, 90, 'Coyah', 'COY', 1),
(1331, 90, 'Dabola', 'DBL', 1),
(1332, 90, 'Dalaba', 'DLB', 1),
(1333, 90, 'Dinguiraye', 'DGR', 1),
(1334, 90, 'Dubreka', 'DBR', 1),
(1335, 90, 'Faranah', 'FRN', 1),
(1336, 90, 'Forecariah', 'FRC', 1),
(1337, 90, 'Fria', 'FRI', 1),
(1338, 90, 'Gaoual', 'GAO', 1),
(1339, 90, 'Gueckedou', 'GCD', 1),
(1340, 90, 'Kankan', 'KNK', 1),
(1341, 90, 'Kerouane', 'KRN', 1),
(1342, 90, 'Kindia', 'KND', 1),
(1343, 90, 'Kissidougou', 'KSD', 1),
(1344, 90, 'Koubia', 'KBA', 1),
(1345, 90, 'Koundara', 'KDA', 1),
(1346, 90, 'Kouroussa', 'KRA', 1),
(1347, 90, 'Labe', 'LAB', 1),
(1348, 90, 'Lelouma', 'LLM', 1),
(1349, 90, 'Lola', 'LOL', 1),
(1350, 90, 'Macenta', 'MCT', 1),
(1351, 90, 'Mali', 'MAL', 1),
(1352, 90, 'Mamou', 'MAM', 1),
(1353, 90, 'Mandiana', 'MAN', 1),
(1354, 90, 'Nzerekore', 'NZR', 1),
(1355, 90, 'Pita', 'PIT', 1),
(1356, 90, 'Siguiri', 'SIG', 1),
(1357, 90, 'Telimele', 'TLM', 1),
(1358, 90, 'Tougue', 'TOG', 1),
(1359, 90, 'Yomou', 'YOM', 1),
(1360, 91, 'Bafata Region', 'BF', 1),
(1361, 91, 'Biombo Region', 'BB', 1),
(1362, 91, 'Bissau Region', 'BS', 1),
(1363, 91, 'Bolama Region', 'BL', 1),
(1364, 91, 'Cacheu Region', 'CA', 1),
(1365, 91, 'Gabu Region', 'GA', 1),
(1366, 91, 'Oio Region', 'OI', 1),
(1367, 91, 'Quinara Region', 'QU', 1),
(1368, 91, 'Tombali Region', 'TO', 1),
(1369, 92, 'Barima-Waini', 'BW', 1),
(1370, 92, 'Cuyuni-Mazaruni', 'CM', 1),
(1371, 92, 'Demerara-Mahaica', 'DM', 1),
(1372, 92, 'East Berbice-Corentyne', 'EC', 1),
(1373, 92, 'Essequibo Islands-West Demerara', 'EW', 1),
(1374, 92, 'Mahaica-Berbice', 'MB', 1),
(1375, 92, 'Pomeroon-Supenaam', 'PM', 1),
(1376, 92, 'Potaro-Siparuni', 'PI', 1),
(1377, 92, 'Upper Demerara-Berbice', 'UD', 1),
(1378, 92, 'Upper Takutu-Upper Essequibo', 'UT', 1),
(1379, 93, 'Artibonite', 'AR', 1),
(1380, 93, 'Centre', 'CE', 1),
(1381, 93, 'Grand\'Anse', 'GA', 1),
(1382, 93, 'Nord', 'ND', 1),
(1383, 93, 'Nord-Est', 'NE', 1),
(1384, 93, 'Nord-Ouest', 'NO', 1),
(1385, 93, 'Ouest', 'OU', 1),
(1386, 93, 'Sud', 'SD', 1),
(1387, 93, 'Sud-Est', 'SE', 1),
(1388, 94, 'Flat Island', 'F', 1),
(1389, 94, 'McDonald Island', 'M', 1),
(1390, 94, 'Shag Island', 'S', 1),
(1391, 94, 'Heard Island', 'H', 1),
(1392, 95, 'Atlantida', 'AT', 1),
(1393, 95, 'Choluteca', 'CH', 1),
(1394, 95, 'Colon', 'CL', 1),
(1395, 95, 'Comayagua', 'CM', 1),
(1396, 95, 'Copan', 'CP', 1),
(1397, 95, 'Cortes', 'CR', 1),
(1398, 95, 'El Paraiso', 'PA', 1),
(1399, 95, 'Francisco Morazan', 'FM', 1),
(1400, 95, 'Gracias a Dios', 'GD', 1),
(1401, 95, 'Intibuca', 'IN', 1),
(1402, 95, 'Islas de la Bahia (Bay Islands)', 'IB', 1),
(1403, 95, 'La Paz', 'PZ', 1),
(1404, 95, 'Lempira', 'LE', 1),
(1405, 95, 'Ocotepeque', 'OC', 1),
(1406, 95, 'Olancho', 'OL', 1),
(1407, 95, 'Santa Barbara', 'SB', 1),
(1408, 95, 'Valle', 'VA', 1),
(1409, 95, 'Yoro', 'YO', 1),
(1410, 96, 'Central and Western Hong Kong Island', 'HCW', 1),
(1411, 96, 'Eastern Hong Kong Island', 'HEA', 1),
(1412, 96, 'Southern Hong Kong Island', 'HSO', 1),
(1413, 96, 'Wan Chai Hong Kong Island', 'HWC', 1),
(1414, 96, 'Kowloon City Kowloon', 'KKC', 1),
(1415, 96, 'Kwun Tong Kowloon', 'KKT', 1),
(1416, 96, 'Sham Shui Po Kowloon', 'KSS', 1),
(1417, 96, 'Wong Tai Sin Kowloon', 'KWT', 1),
(1418, 96, 'Yau Tsim Mong Kowloon', 'KYT', 1),
(1419, 96, 'Islands New Territories', 'NIS', 1),
(1420, 96, 'Kwai Tsing New Territories', 'NKT', 1),
(1421, 96, 'North New Territories', 'NNO', 1),
(1422, 96, 'Sai Kung New Territories', 'NSK', 1),
(1423, 96, 'Sha Tin New Territories', 'NST', 1),
(1424, 96, 'Tai Po New Territories', 'NTP', 1),
(1425, 96, 'Tsuen Wan New Territories', 'NTW', 1),
(1426, 96, 'Tuen Mun New Territories', 'NTM', 1),
(1427, 96, 'Yuen Long New Territories', 'NYL', 1),
(1467, 98, 'Austurland', 'AL', 1),
(1468, 98, 'Hofuoborgarsvaeoi', 'HF', 1),
(1469, 98, 'Norourland eystra', 'NE', 1),
(1470, 98, 'Norourland vestra', 'NV', 1),
(1471, 98, 'Suourland', 'SL', 1),
(1472, 98, 'Suournes', 'SN', 1),
(1473, 98, 'Vestfiroir', 'VF', 1),
(1474, 98, 'Vesturland', 'VL', 1),
(1475, 99, 'Andaman and Nicobar Islands', 'AN', 1),
(1476, 99, 'Andhra Pradesh', 'AP', 1),
(1477, 99, 'Arunachal Pradesh', 'AR', 1),
(1478, 99, 'Assam', 'AS', 1),
(1479, 99, 'Bihar', 'BI', 1),
(1480, 99, 'Chandigarh', 'CH', 1),
(1481, 99, 'Dadra and Nagar Haveli', 'DA', 1),
(1482, 99, 'Daman and Diu', 'DM', 1),
(1483, 99, 'Delhi', 'DE', 1),
(1484, 99, 'Goa', 'GO', 1),
(1485, 99, 'Gujarat', 'GU', 1),
(1486, 99, 'Haryana', 'HA', 1),
(1487, 99, 'Himachal Pradesh', 'HP', 1),
(1488, 99, 'Jammu and Kashmir', 'JA', 1),
(1489, 99, 'Karnataka', 'KA', 1),
(1490, 99, 'Kerala', 'KE', 1),
(1491, 99, 'Lakshadweep Islands', 'LI', 1),
(1492, 99, 'Madhya Pradesh', 'MP', 1),
(1493, 99, 'Maharashtra', 'MA', 1),
(1494, 99, 'Manipur', 'MN', 1),
(1495, 99, 'Meghalaya', 'ME', 1),
(1496, 99, 'Mizoram', 'MI', 1),
(1497, 99, 'Nagaland', 'NA', 1),
(1498, 99, 'Orissa', 'OR', 1),
(1499, 99, 'Puducherry', 'PO', 1),
(1500, 99, 'Punjab', 'PU', 1),
(1501, 99, 'Rajasthan', 'RA', 1),
(1502, 99, 'Sikkim', 'SI', 1),
(1503, 99, 'Tamil Nadu', 'TN', 1),
(1504, 99, 'Tripura', 'TR', 1),
(1505, 99, 'Uttar Pradesh', 'UP', 1),
(1506, 99, 'West Bengal', 'WB', 1),
(1507, 100, 'Aceh', 'AC', 1),
(1508, 100, 'Bali', 'BA', 1),
(1509, 100, 'Banten', 'BT', 1),
(1510, 100, 'Bengkulu', 'BE', 1),
(1511, 100, 'Kalimantan Utara', 'BD', 1),
(1512, 100, 'Gorontalo', 'GO', 1),
(1513, 100, 'Jakarta', 'JK', 1),
(1514, 100, 'Jambi', 'JA', 1),
(1515, 100, 'Jawa Barat', 'JB', 1),
(1516, 100, 'Jawa Tengah', 'JT', 1),
(1517, 100, 'Jawa Timur', 'JI', 1),
(1518, 100, 'Kalimantan Barat', 'KB', 1),
(1519, 100, 'Kalimantan Selatan', 'KS', 1),
(1520, 100, 'Kalimantan Tengah', 'KT', 1),
(1521, 100, 'Kalimantan Timur', 'KI', 1),
(1522, 100, 'Kepulauan Bangka Belitung', 'BB', 1),
(1523, 100, 'Lampung', 'LA', 1),
(1524, 100, 'Maluku', 'MA', 1),
(1525, 100, 'Maluku Utara', 'MU', 1),
(1526, 100, 'Nusa Tenggara Barat', 'NB', 1),
(1527, 100, 'Nusa Tenggara Timur', 'NT', 1),
(1528, 100, 'Papua', 'PA', 1),
(1529, 100, 'Riau', 'RI', 1),
(1530, 100, 'Sulawesi Selatan', 'SN', 1),
(1531, 100, 'Sulawesi Tengah', 'ST', 1),
(1532, 100, 'Sulawesi Tenggara', 'SG', 1),
(1533, 100, 'Sulawesi Utara', 'SA', 1),
(1534, 100, 'Sumatera Barat', 'SB', 1),
(1535, 100, 'Sumatera Selatan', 'SS', 1),
(1536, 100, 'Sumatera Utara', 'SU', 1),
(1537, 100, 'Yogyakarta', 'YO', 1),
(1538, 101, 'Tehran', 'TEH', 1),
(1539, 101, 'Qom', 'QOM', 1),
(1540, 101, 'Markazi', 'MKZ', 1),
(1541, 101, 'Qazvin', 'QAZ', 1),
(1542, 101, 'Gilan', 'GIL', 1),
(1543, 101, 'Ardabil', 'ARD', 1),
(1544, 101, 'Zanjan', 'ZAN', 1),
(1545, 101, 'East Azarbaijan', 'EAZ', 1),
(1546, 101, 'West Azarbaijan', 'WEZ', 1),
(1547, 101, 'Kurdistan', 'KRD', 1),
(1548, 101, 'Hamadan', 'HMD', 1),
(1549, 101, 'Kermanshah', 'KRM', 1),
(1550, 101, 'Ilam', 'ILM', 1),
(1551, 101, 'Lorestan', 'LRS', 1),
(1552, 101, 'Khuzestan', 'KZT', 1),
(1553, 101, 'Chahar Mahaal and Bakhtiari', 'CMB', 1),
(1554, 101, 'Kohkiluyeh and Buyer Ahmad', 'KBA', 1),
(1555, 101, 'Bushehr', 'BSH', 1),
(1556, 101, 'Fars', 'FAR', 1),
(1557, 101, 'Hormozgan', 'HRM', 1),
(1558, 101, 'Sistan and Baluchistan', 'SBL', 1),
(1559, 101, 'Kerman', 'KRB', 1),
(1560, 101, 'Yazd', 'YZD', 1),
(1561, 101, 'Esfahan', 'EFH', 1),
(1562, 101, 'Semnan', 'SMN', 1),
(1563, 101, 'Mazandaran', 'MZD', 1),
(1564, 101, 'Golestan', 'GLS', 1),
(1565, 101, 'North Khorasan', 'NKH', 1),
(1566, 101, 'Razavi Khorasan', 'RKH', 1),
(1567, 101, 'South Khorasan', 'SKH', 1),
(1568, 102, 'Baghdad', 'BD', 1),
(1569, 102, 'Salah ad Din', 'SD', 1),
(1570, 102, 'Diyala', 'DY', 1),
(1571, 102, 'Wasit', 'WS', 1),
(1572, 102, 'Maysan', 'MY', 1),
(1573, 102, 'Al Basrah', 'BA', 1),
(1574, 102, 'Dhi Qar', 'DQ', 1),
(1575, 102, 'Al Muthanna', 'MU', 1),
(1576, 102, 'Al Qadisyah', 'QA', 1),
(1577, 102, 'Babil', 'BB', 1),
(1578, 102, 'Al Karbala', 'KB', 1),
(1579, 102, 'An Najaf', 'NJ', 1),
(1580, 102, 'Al Anbar', 'AB', 1),
(1581, 102, 'Ninawa', 'NN', 1),
(1582, 102, 'Dahuk', 'DH', 1),
(1583, 102, 'Arbil', 'AL', 1),
(1584, 102, 'At Ta\'mim', 'TM', 1),
(1585, 102, 'As Sulaymaniyah', 'SL', 1),
(1586, 103, 'Carlow', 'CA', 1),
(1587, 103, 'Cavan', 'CV', 1),
(1588, 103, 'Clare', 'CL', 1),
(1589, 103, 'Cork', 'CO', 1),
(1590, 103, 'Donegal', 'DO', 1),
(1591, 103, 'Dublin', 'DU', 1),
(1592, 103, 'Galway', 'GA', 1),
(1593, 103, 'Kerry', 'KE', 1),
(1594, 103, 'Kildare', 'KI', 1),
(1595, 103, 'Kilkenny', 'KL', 1),
(1596, 103, 'Laois', 'LA', 1),
(1597, 103, 'Leitrim', 'LE', 1);
INSERT INTO `oc_zone` (`zone_id`, `country_id`, `name`, `code`, `status`) VALUES
(1598, 103, 'Limerick', 'LI', 1),
(1599, 103, 'Longford', 'LO', 1),
(1600, 103, 'Louth', 'LU', 1),
(1601, 103, 'Mayo', 'MA', 1),
(1602, 103, 'Meath', 'ME', 1),
(1603, 103, 'Monaghan', 'MO', 1),
(1604, 103, 'Offaly', 'OF', 1),
(1605, 103, 'Roscommon', 'RO', 1),
(1606, 103, 'Sligo', 'SL', 1),
(1607, 103, 'Tipperary', 'TI', 1),
(1608, 103, 'Waterford', 'WA', 1),
(1609, 103, 'Westmeath', 'WE', 1),
(1610, 103, 'Wexford', 'WX', 1),
(1611, 103, 'Wicklow', 'WI', 1),
(1612, 104, 'Be\'er Sheva', 'BS', 1),
(1613, 104, 'Bika\'at Hayarden', 'BH', 1),
(1614, 104, 'Eilat and Arava', 'EA', 1),
(1615, 104, 'Galil', 'GA', 1),
(1616, 104, 'Haifa', 'HA', 1),
(1617, 104, 'Jehuda Mountains', 'JM', 1),
(1618, 104, 'Jerusalem', 'JE', 1),
(1619, 104, 'Negev', 'NE', 1),
(1620, 104, 'Semaria', 'SE', 1),
(1621, 104, 'Sharon', 'SH', 1),
(1622, 104, 'Tel Aviv (Gosh Dan)', 'TA', 1),
(3860, 105, 'Caltanissetta', 'CL', 1),
(3842, 105, 'Agrigento', 'AG', 1),
(3843, 105, 'Alessandria', 'AL', 1),
(3844, 105, 'Ancona', 'AN', 1),
(3845, 105, 'Aosta', 'AO', 1),
(3846, 105, 'Arezzo', 'AR', 1),
(3847, 105, 'Ascoli Piceno', 'AP', 1),
(3848, 105, 'Asti', 'AT', 1),
(3849, 105, 'Avellino', 'AV', 1),
(3850, 105, 'Bari', 'BA', 1),
(3851, 105, 'Belluno', 'BL', 1),
(3852, 105, 'Benevento', 'BN', 1),
(3853, 105, 'Bergamo', 'BG', 1),
(3854, 105, 'Biella', 'BI', 1),
(3855, 105, 'Bologna', 'BO', 1),
(3856, 105, 'Bolzano', 'BZ', 1),
(3857, 105, 'Brescia', 'BS', 1),
(3858, 105, 'Brindisi', 'BR', 1),
(3859, 105, 'Cagliari', 'CA', 1),
(1643, 106, 'Clarendon Parish', 'CLA', 1),
(1644, 106, 'Hanover Parish', 'HAN', 1),
(1645, 106, 'Kingston Parish', 'KIN', 1),
(1646, 106, 'Manchester Parish', 'MAN', 1),
(1647, 106, 'Portland Parish', 'POR', 1),
(1648, 106, 'Saint Andrew Parish', 'AND', 1),
(1649, 106, 'Saint Ann Parish', 'ANN', 1),
(1650, 106, 'Saint Catherine Parish', 'CAT', 1),
(1651, 106, 'Saint Elizabeth Parish', 'ELI', 1),
(1652, 106, 'Saint James Parish', 'JAM', 1),
(1653, 106, 'Saint Mary Parish', 'MAR', 1),
(1654, 106, 'Saint Thomas Parish', 'THO', 1),
(1655, 106, 'Trelawny Parish', 'TRL', 1),
(1656, 106, 'Westmoreland Parish', 'WML', 1),
(1657, 107, 'Aichi', 'AI', 1),
(1658, 107, 'Akita', 'AK', 1),
(1659, 107, 'Aomori', 'AO', 1),
(1660, 107, 'Chiba', 'CH', 1),
(1661, 107, 'Ehime', 'EH', 1),
(1662, 107, 'Fukui', 'FK', 1),
(1663, 107, 'Fukuoka', 'FU', 1),
(1664, 107, 'Fukushima', 'FS', 1),
(1665, 107, 'Gifu', 'GI', 1),
(1666, 107, 'Gumma', 'GU', 1),
(1667, 107, 'Hiroshima', 'HI', 1),
(1668, 107, 'Hokkaido', 'HO', 1),
(1669, 107, 'Hyogo', 'HY', 1),
(1670, 107, 'Ibaraki', 'IB', 1),
(1671, 107, 'Ishikawa', 'IS', 1),
(1672, 107, 'Iwate', 'IW', 1),
(1673, 107, 'Kagawa', 'KA', 1),
(1674, 107, 'Kagoshima', 'KG', 1),
(1675, 107, 'Kanagawa', 'KN', 1),
(1676, 107, 'Kochi', 'KO', 1),
(1677, 107, 'Kumamoto', 'KU', 1),
(1678, 107, 'Kyoto', 'KY', 1),
(1679, 107, 'Mie', 'MI', 1),
(1680, 107, 'Miyagi', 'MY', 1),
(1681, 107, 'Miyazaki', 'MZ', 1),
(1682, 107, 'Nagano', 'NA', 1),
(1683, 107, 'Nagasaki', 'NG', 1),
(1684, 107, 'Nara', 'NR', 1),
(1685, 107, 'Niigata', 'NI', 1),
(1686, 107, 'Oita', 'OI', 1),
(1687, 107, 'Okayama', 'OK', 1),
(1688, 107, 'Okinawa', 'ON', 1),
(1689, 107, 'Osaka', 'OS', 1),
(1690, 107, 'Saga', 'SA', 1),
(1691, 107, 'Saitama', 'SI', 1),
(1692, 107, 'Shiga', 'SH', 1),
(1693, 107, 'Shimane', 'SM', 1),
(1694, 107, 'Shizuoka', 'SZ', 1),
(1695, 107, 'Tochigi', 'TO', 1),
(1696, 107, 'Tokushima', 'TS', 1),
(1697, 107, 'Tokyo', 'TK', 1),
(1698, 107, 'Tottori', 'TT', 1),
(1699, 107, 'Toyama', 'TY', 1),
(1700, 107, 'Wakayama', 'WA', 1),
(1701, 107, 'Yamagata', 'YA', 1),
(1702, 107, 'Yamaguchi', 'YM', 1),
(1703, 107, 'Yamanashi', 'YN', 1),
(1704, 108, '\'Amman', 'AM', 1),
(1705, 108, 'Ajlun', 'AJ', 1),
(1706, 108, 'Al \'Aqabah', 'AA', 1),
(1707, 108, 'Al Balqa\'', 'AB', 1),
(1708, 108, 'Al Karak', 'AK', 1),
(1709, 108, 'Al Mafraq', 'AL', 1),
(1710, 108, 'At Tafilah', 'AT', 1),
(1711, 108, 'Az Zarqa\'', 'AZ', 1),
(1712, 108, 'Irbid', 'IR', 1),
(1713, 108, 'Jarash', 'JA', 1),
(1714, 108, 'Ma\'an', 'MA', 1),
(1715, 108, 'Madaba', 'MD', 1),
(1716, 109, 'Almaty', 'AL', 1),
(1717, 109, 'Almaty City', 'AC', 1),
(1718, 109, 'Aqmola', 'AM', 1),
(1719, 109, 'Aqtobe', 'AQ', 1),
(1720, 109, 'Astana City', 'AS', 1),
(1721, 109, 'Atyrau', 'AT', 1),
(1722, 109, 'Batys Qazaqstan', 'BA', 1),
(1723, 109, 'Bayqongyr City', 'BY', 1),
(1724, 109, 'Mangghystau', 'MA', 1),
(1725, 109, 'Ongtustik Qazaqstan', 'ON', 1),
(1726, 109, 'Pavlodar', 'PA', 1),
(1727, 109, 'Qaraghandy', 'QA', 1),
(1728, 109, 'Qostanay', 'QO', 1),
(1729, 109, 'Qyzylorda', 'QY', 1),
(1730, 109, 'Shyghys Qazaqstan', 'SH', 1),
(1731, 109, 'Soltustik Qazaqstan', 'SO', 1),
(1732, 109, 'Zhambyl', 'ZH', 1),
(1733, 110, 'Central', 'CE', 1),
(1734, 110, 'Coast', 'CO', 1),
(1735, 110, 'Eastern', 'EA', 1),
(1736, 110, 'Nairobi Area', 'NA', 1),
(1737, 110, 'North Eastern', 'NE', 1),
(1738, 110, 'Nyanza', 'NY', 1),
(1739, 110, 'Rift Valley', 'RV', 1),
(1740, 110, 'Western', 'WE', 1),
(1741, 111, 'Abaiang', 'AG', 1),
(1742, 111, 'Abemama', 'AM', 1),
(1743, 111, 'Aranuka', 'AK', 1),
(1744, 111, 'Arorae', 'AO', 1),
(1745, 111, 'Banaba', 'BA', 1),
(1746, 111, 'Beru', 'BE', 1),
(1747, 111, 'Butaritari', 'bT', 1),
(1748, 111, 'Kanton', 'KA', 1),
(1749, 111, 'Kiritimati', 'KR', 1),
(1750, 111, 'Kuria', 'KU', 1),
(1751, 111, 'Maiana', 'MI', 1),
(1752, 111, 'Makin', 'MN', 1),
(1753, 111, 'Marakei', 'ME', 1),
(1754, 111, 'Nikunau', 'NI', 1),
(1755, 111, 'Nonouti', 'NO', 1),
(1756, 111, 'Onotoa', 'ON', 1),
(1757, 111, 'Tabiteuea', 'TT', 1),
(1758, 111, 'Tabuaeran', 'TR', 1),
(1759, 111, 'Tamana', 'TM', 1),
(1760, 111, 'Tarawa', 'TW', 1),
(1761, 111, 'Teraina', 'TE', 1),
(1762, 112, 'Chagang-do', 'CHA', 1),
(1763, 112, 'Hamgyong-bukto', 'HAB', 1),
(1764, 112, 'Hamgyong-namdo', 'HAN', 1),
(1765, 112, 'Hwanghae-bukto', 'HWB', 1),
(1766, 112, 'Hwanghae-namdo', 'HWN', 1),
(1767, 112, 'Kangwon-do', 'KAN', 1),
(1768, 112, 'P\'yongan-bukto', 'PYB', 1),
(1769, 112, 'P\'yongan-namdo', 'PYN', 1),
(1770, 112, 'Ryanggang-do (Yanggang-do)', 'YAN', 1),
(1771, 112, 'Rason Directly Governed City', 'NAJ', 1),
(1772, 112, 'P\'yongyang Special City', 'PYO', 1),
(1773, 113, 'Ch\'ungch\'ong-bukto', 'CO', 1),
(1774, 113, 'Ch\'ungch\'ong-namdo', 'CH', 1),
(1775, 113, 'Cheju-do', 'CD', 1),
(1776, 113, 'Cholla-bukto', 'CB', 1),
(1777, 113, 'Cholla-namdo', 'CN', 1),
(1778, 113, 'Inch\'on-gwangyoksi', 'IG', 1),
(1779, 113, 'Kangwon-do', 'KA', 1),
(1780, 113, 'Kwangju-gwangyoksi', 'KG', 1),
(1781, 113, 'Kyonggi-do', 'KD', 1),
(1782, 113, 'Kyongsang-bukto', 'KB', 1),
(1783, 113, 'Kyongsang-namdo', 'KN', 1),
(1784, 113, 'Pusan-gwangyoksi', 'PG', 1),
(1785, 113, 'Soul-t\'ukpyolsi', 'SO', 1),
(1786, 113, 'Taegu-gwangyoksi', 'TA', 1),
(1787, 113, 'Taejon-gwangyoksi', 'TG', 1),
(1788, 114, 'Al \'Asimah', 'AL', 1),
(1789, 114, 'Al Ahmadi', 'AA', 1),
(1790, 114, 'Al Farwaniyah', 'AF', 1),
(1791, 114, 'Al Jahra\'', 'AJ', 1),
(1792, 114, 'Hawalli', 'HA', 1),
(1793, 115, 'Bishkek', 'GB', 1),
(1794, 115, 'Batken', 'B', 1),
(1795, 115, 'Chu', 'C', 1),
(1796, 115, 'Jalal-Abad', 'J', 1),
(1797, 115, 'Naryn', 'N', 1),
(1798, 115, 'Osh', 'O', 1),
(1799, 115, 'Talas', 'T', 1),
(1800, 115, 'Ysyk-Kol', 'Y', 1),
(1801, 116, 'Vientiane', 'VT', 1),
(1802, 116, 'Attapu', 'AT', 1),
(1803, 116, 'Bokeo', 'BK', 1),
(1804, 116, 'Bolikhamxai', 'BL', 1),
(1805, 116, 'Champasak', 'CH', 1),
(1806, 116, 'Houaphan', 'HO', 1),
(1807, 116, 'Khammouan', 'KH', 1),
(1808, 116, 'Louang Namtha', 'LM', 1),
(1809, 116, 'Louangphabang', 'LP', 1),
(1810, 116, 'Oudomxai', 'OU', 1),
(1811, 116, 'Phongsali', 'PH', 1),
(1812, 116, 'Salavan', 'SL', 1),
(1813, 116, 'Savannakhet', 'SV', 1),
(1814, 116, 'Vientiane', 'VI', 1),
(1815, 116, 'Xaignabouli', 'XA', 1),
(1816, 116, 'Xekong', 'XE', 1),
(1817, 116, 'Xiangkhoang', 'XI', 1),
(1818, 116, 'Xaisomboun', 'XN', 1),
(1852, 119, 'Berea', 'BE', 1),
(1853, 119, 'Butha-Buthe', 'BB', 1),
(1854, 119, 'Leribe', 'LE', 1),
(1855, 119, 'Mafeteng', 'MF', 1),
(1856, 119, 'Maseru', 'MS', 1),
(1857, 119, 'Mohale\'s Hoek', 'MH', 1),
(1858, 119, 'Mokhotlong', 'MK', 1),
(1859, 119, 'Qacha\'s Nek', 'QN', 1),
(1860, 119, 'Quthing', 'QT', 1),
(1861, 119, 'Thaba-Tseka', 'TT', 1),
(1862, 120, 'Bomi', 'BI', 1),
(1863, 120, 'Bong', 'BG', 1),
(1864, 120, 'Grand Bassa', 'GB', 1),
(1865, 120, 'Grand Cape Mount', 'CM', 1),
(1866, 120, 'Grand Gedeh', 'GG', 1),
(1867, 120, 'Grand Kru', 'GK', 1),
(1868, 120, 'Lofa', 'LO', 1),
(1869, 120, 'Margibi', 'MG', 1),
(1870, 120, 'Maryland', 'ML', 1),
(1871, 120, 'Montserrado', 'MS', 1),
(1872, 120, 'Nimba', 'NB', 1),
(1873, 120, 'River Cess', 'RC', 1),
(1874, 120, 'Sinoe', 'SN', 1),
(1875, 121, 'Ajdabiya', 'AJ', 1),
(1876, 121, 'Al \'Aziziyah', 'AZ', 1),
(1877, 121, 'Al Fatih', 'FA', 1),
(1878, 121, 'Al Jabal al Akhdar', 'JA', 1),
(1879, 121, 'Al Jufrah', 'JU', 1),
(1880, 121, 'Al Khums', 'KH', 1),
(1881, 121, 'Al Kufrah', 'KU', 1),
(1882, 121, 'An Nuqat al Khams', 'NK', 1),
(1883, 121, 'Ash Shati\'', 'AS', 1),
(1884, 121, 'Awbari', 'AW', 1),
(1885, 121, 'Az Zawiyah', 'ZA', 1),
(1886, 121, 'Banghazi', 'BA', 1),
(1887, 121, 'Darnah', 'DA', 1),
(1888, 121, 'Ghadamis', 'GD', 1),
(1889, 121, 'Gharyan', 'GY', 1),
(1890, 121, 'Misratah', 'MI', 1),
(1891, 121, 'Murzuq', 'MZ', 1),
(1892, 121, 'Sabha', 'SB', 1),
(1893, 121, 'Sawfajjin', 'SW', 1),
(1894, 121, 'Surt', 'SU', 1),
(1895, 121, 'Tarabulus (Tripoli)', 'TL', 1),
(1896, 121, 'Tarhunah', 'TH', 1),
(1897, 121, 'Tubruq', 'TU', 1),
(1898, 121, 'Yafran', 'YA', 1),
(1899, 121, 'Zlitan', 'ZL', 1),
(1900, 122, 'Vaduz', 'V', 1),
(1901, 122, 'Schaan', 'A', 1),
(1902, 122, 'Balzers', 'B', 1),
(1903, 122, 'Triesen', 'N', 1),
(1904, 122, 'Eschen', 'E', 1),
(1905, 122, 'Mauren', 'M', 1),
(1906, 122, 'Triesenberg', 'T', 1),
(1907, 122, 'Ruggell', 'R', 1),
(1908, 122, 'Gamprin', 'G', 1),
(1909, 122, 'Schellenberg', 'L', 1),
(1910, 122, 'Planken', 'P', 1),
(1911, 123, 'Alytus', 'AL', 1),
(1912, 123, 'Kaunas', 'KA', 1),
(1913, 123, 'Klaipeda', 'KL', 1),
(1914, 123, 'Marijampole', 'MA', 1),
(1915, 123, 'Panevezys', 'PA', 1),
(1916, 123, 'Siauliai', 'SI', 1),
(1917, 123, 'Taurage', 'TA', 1),
(1918, 123, 'Telsiai', 'TE', 1),
(1919, 123, 'Utena', 'UT', 1),
(1920, 123, 'Vilnius', 'VI', 1),
(1921, 124, 'Diekirch', 'DD', 1),
(1922, 124, 'Clervaux', 'DC', 1),
(1923, 124, 'Redange', 'DR', 1),
(1924, 124, 'Vianden', 'DV', 1),
(1925, 124, 'Wiltz', 'DW', 1),
(1926, 124, 'Grevenmacher', 'GG', 1),
(1927, 124, 'Echternach', 'GE', 1),
(1928, 124, 'Remich', 'GR', 1),
(1929, 124, 'Luxembourg', 'LL', 1),
(1930, 124, 'Capellen', 'LC', 1),
(1931, 124, 'Esch-sur-Alzette', 'LE', 1),
(1932, 124, 'Mersch', 'LM', 1),
(1933, 125, 'Our Lady Fatima Parish', 'OLF', 1),
(1934, 125, 'St. Anthony Parish', 'ANT', 1),
(1935, 125, 'St. Lazarus Parish', 'LAZ', 1),
(1936, 125, 'Cathedral Parish', 'CAT', 1),
(1937, 125, 'St. Lawrence Parish', 'LAW', 1),
(1938, 127, 'Antananarivo', 'AN', 1),
(1939, 127, 'Antsiranana', 'AS', 1),
(1940, 127, 'Fianarantsoa', 'FN', 1),
(1941, 127, 'Mahajanga', 'MJ', 1),
(1942, 127, 'Toamasina', 'TM', 1),
(1943, 127, 'Toliara', 'TL', 1),
(1944, 128, 'Balaka', 'BLK', 1),
(1945, 128, 'Blantyre', 'BLT', 1),
(1946, 128, 'Chikwawa', 'CKW', 1),
(1947, 128, 'Chiradzulu', 'CRD', 1),
(1948, 128, 'Chitipa', 'CTP', 1),
(1949, 128, 'Dedza', 'DDZ', 1),
(1950, 128, 'Dowa', 'DWA', 1),
(1951, 128, 'Karonga', 'KRG', 1),
(1952, 128, 'Kasungu', 'KSG', 1),
(1953, 128, 'Likoma', 'LKM', 1),
(1954, 128, 'Lilongwe', 'LLG', 1),
(1955, 128, 'Machinga', 'MCG', 1),
(1956, 128, 'Mangochi', 'MGC', 1),
(1957, 128, 'Mchinji', 'MCH', 1),
(1958, 128, 'Mulanje', 'MLJ', 1),
(1959, 128, 'Mwanza', 'MWZ', 1),
(1960, 128, 'Mzimba', 'MZM', 1),
(1961, 128, 'Ntcheu', 'NTU', 1),
(1962, 128, 'Nkhata Bay', 'NKB', 1),
(1963, 128, 'Nkhotakota', 'NKH', 1),
(1964, 128, 'Nsanje', 'NSJ', 1),
(1965, 128, 'Ntchisi', 'NTI', 1),
(1966, 128, 'Phalombe', 'PHL', 1),
(1967, 128, 'Rumphi', 'RMP', 1),
(1968, 128, 'Salima', 'SLM', 1),
(1969, 128, 'Thyolo', 'THY', 1),
(1970, 128, 'Zomba', 'ZBA', 1),
(1971, 129, 'Johor', 'MY-01', 1),
(1972, 129, 'Kedah', 'MY-02', 1),
(1973, 129, 'Kelantan', 'MY-03', 1),
(1974, 129, 'Labuan', 'MY-15', 1),
(1975, 129, 'Melaka', 'MY-04', 1),
(1976, 129, 'Negeri Sembilan', 'MY-05', 1),
(1977, 129, 'Pahang', 'MY-06', 1),
(1978, 129, 'Perak', 'MY-08', 1),
(1979, 129, 'Perlis', 'MY-09', 1),
(1980, 129, 'Pulau Pinang', 'MY-07', 1),
(1981, 129, 'Sabah', 'MY-12', 1),
(1982, 129, 'Sarawak', 'MY-13', 1),
(1983, 129, 'Selangor', 'MY-10', 1),
(1984, 129, 'Terengganu', 'MY-11', 1),
(1985, 129, 'Kuala Lumpur', 'MY-14', 1),
(4035, 129, 'Putrajaya', 'MY-16', 1),
(1986, 130, 'Thiladhunmathi Uthuru', 'THU', 1),
(1987, 130, 'Thiladhunmathi Dhekunu', 'THD', 1),
(1988, 130, 'Miladhunmadulu Uthuru', 'MLU', 1),
(1989, 130, 'Miladhunmadulu Dhekunu', 'MLD', 1),
(1990, 130, 'Maalhosmadulu Uthuru', 'MAU', 1),
(1991, 130, 'Maalhosmadulu Dhekunu', 'MAD', 1),
(1992, 130, 'Faadhippolhu', 'FAA', 1),
(1993, 130, 'Male Atoll', 'MAA', 1),
(1994, 130, 'Ari Atoll Uthuru', 'AAU', 1),
(1995, 130, 'Ari Atoll Dheknu', 'AAD', 1),
(1996, 130, 'Felidhe Atoll', 'FEA', 1),
(1997, 130, 'Mulaku Atoll', 'MUA', 1),
(1998, 130, 'Nilandhe Atoll Uthuru', 'NAU', 1),
(1999, 130, 'Nilandhe Atoll Dhekunu', 'NAD', 1),
(2000, 130, 'Kolhumadulu', 'KLH', 1),
(2001, 130, 'Hadhdhunmathi', 'HDH', 1),
(2002, 130, 'Huvadhu Atoll Uthuru', 'HAU', 1),
(2003, 130, 'Huvadhu Atoll Dhekunu', 'HAD', 1),
(2004, 130, 'Fua Mulaku', 'FMU', 1),
(2005, 130, 'Addu', 'ADD', 1),
(2006, 131, 'Gao', 'GA', 1),
(2007, 131, 'Kayes', 'KY', 1),
(2008, 131, 'Kidal', 'KD', 1),
(2009, 131, 'Koulikoro', 'KL', 1),
(2010, 131, 'Mopti', 'MP', 1),
(2011, 131, 'Segou', 'SG', 1),
(2012, 131, 'Sikasso', 'SK', 1),
(2013, 131, 'Tombouctou', 'TB', 1),
(2014, 131, 'Bamako Capital District', 'CD', 1),
(2015, 132, 'Attard', 'ATT', 1),
(2016, 132, 'Balzan', 'BAL', 1),
(2017, 132, 'Birgu', 'BGU', 1),
(2018, 132, 'Birkirkara', 'BKK', 1),
(2019, 132, 'Birzebbuga', 'BRZ', 1),
(2020, 132, 'Bormla', 'BOR', 1),
(2021, 132, 'Dingli', 'DIN', 1),
(2022, 132, 'Fgura', 'FGU', 1),
(2023, 132, 'Floriana', 'FLO', 1),
(2024, 132, 'Gudja', 'GDJ', 1),
(2025, 132, 'Gzira', 'GZR', 1),
(2026, 132, 'Gargur', 'GRG', 1),
(2027, 132, 'Gaxaq', 'GXQ', 1),
(2028, 132, 'Hamrun', 'HMR', 1),
(2029, 132, 'Iklin', 'IKL', 1),
(2030, 132, 'Isla', 'ISL', 1),
(2031, 132, 'Kalkara', 'KLK', 1),
(2032, 132, 'Kirkop', 'KRK', 1),
(2033, 132, 'Lija', 'LIJ', 1),
(2034, 132, 'Luqa', 'LUQ', 1),
(2035, 132, 'Marsa', 'MRS', 1),
(2036, 132, 'Marsaskala', 'MKL', 1),
(2037, 132, 'Marsaxlokk', 'MXL', 1),
(2038, 132, 'Mdina', 'MDN', 1),
(2039, 132, 'Melliea', 'MEL', 1),
(2040, 132, 'Mgarr', 'MGR', 1),
(2041, 132, 'Mosta', 'MST', 1),
(2042, 132, 'Mqabba', 'MQA', 1),
(2043, 132, 'Msida', 'MSI', 1),
(2044, 132, 'Mtarfa', 'MTF', 1),
(2045, 132, 'Naxxar', 'NAX', 1),
(2046, 132, 'Paola', 'PAO', 1),
(2047, 132, 'Pembroke', 'PEM', 1),
(2048, 132, 'Pieta', 'PIE', 1),
(2049, 132, 'Qormi', 'QOR', 1),
(2050, 132, 'Qrendi', 'QRE', 1),
(2051, 132, 'Rabat', 'RAB', 1),
(2052, 132, 'Safi', 'SAF', 1),
(2053, 132, 'San Giljan', 'SGI', 1),
(2054, 132, 'Santa Lucija', 'SLU', 1),
(2055, 132, 'San Pawl il-Bahar', 'SPB', 1),
(2056, 132, 'San Gwann', 'SGW', 1),
(2057, 132, 'Santa Venera', 'SVE', 1),
(2058, 132, 'Siggiewi', 'SIG', 1),
(2059, 132, 'Sliema', 'SLM', 1),
(2060, 132, 'Swieqi', 'SWQ', 1),
(2061, 132, 'Ta Xbiex', 'TXB', 1),
(2062, 132, 'Tarxien', 'TRX', 1),
(2063, 132, 'Valletta', 'VLT', 1),
(2064, 132, 'Xgajra', 'XGJ', 1),
(2065, 132, 'Zabbar', 'ZBR', 1),
(2066, 132, 'Zebbug', 'ZBG', 1),
(2067, 132, 'Zejtun', 'ZJT', 1),
(2068, 132, 'Zurrieq', 'ZRQ', 1),
(2069, 132, 'Fontana', 'FNT', 1),
(2070, 132, 'Ghajnsielem', 'GHJ', 1),
(2071, 132, 'Gharb', 'GHR', 1),
(2072, 132, 'Ghasri', 'GHS', 1),
(2073, 132, 'Kercem', 'KRC', 1),
(2074, 132, 'Munxar', 'MUN', 1),
(2075, 132, 'Nadur', 'NAD', 1),
(2076, 132, 'Qala', 'QAL', 1),
(2077, 132, 'Victoria', 'VIC', 1),
(2078, 132, 'San Lawrenz', 'SLA', 1),
(2079, 132, 'Sannat', 'SNT', 1),
(2080, 132, 'Xagra', 'ZAG', 1),
(2081, 132, 'Xewkija', 'XEW', 1),
(2082, 132, 'Zebbug', 'ZEB', 1),
(2083, 133, 'Ailinginae', 'ALG', 1),
(2084, 133, 'Ailinglaplap', 'ALL', 1),
(2085, 133, 'Ailuk', 'ALK', 1),
(2086, 133, 'Arno', 'ARN', 1),
(2087, 133, 'Aur', 'AUR', 1),
(2088, 133, 'Bikar', 'BKR', 1),
(2089, 133, 'Bikini', 'BKN', 1),
(2090, 133, 'Bokak', 'BKK', 1),
(2091, 133, 'Ebon', 'EBN', 1),
(2092, 133, 'Enewetak', 'ENT', 1),
(2093, 133, 'Erikub', 'EKB', 1),
(2094, 133, 'Jabat', 'JBT', 1),
(2095, 133, 'Jaluit', 'JLT', 1),
(2096, 133, 'Jemo', 'JEM', 1),
(2097, 133, 'Kili', 'KIL', 1),
(2098, 133, 'Kwajalein', 'KWJ', 1),
(2099, 133, 'Lae', 'LAE', 1),
(2100, 133, 'Lib', 'LIB', 1),
(2101, 133, 'Likiep', 'LKP', 1),
(2102, 133, 'Majuro', 'MJR', 1),
(2103, 133, 'Maloelap', 'MLP', 1),
(2104, 133, 'Mejit', 'MJT', 1),
(2105, 133, 'Mili', 'MIL', 1),
(2106, 133, 'Namorik', 'NMK', 1),
(2107, 133, 'Namu', 'NAM', 1),
(2108, 133, 'Rongelap', 'RGL', 1),
(2109, 133, 'Rongrik', 'RGK', 1),
(2110, 133, 'Toke', 'TOK', 1),
(2111, 133, 'Ujae', 'UJA', 1),
(2112, 133, 'Ujelang', 'UJL', 1),
(2113, 133, 'Utirik', 'UTK', 1),
(2114, 133, 'Wotho', 'WTH', 1),
(2115, 133, 'Wotje', 'WTJ', 1),
(2116, 135, 'Adrar', 'AD', 1),
(2117, 135, 'Assaba', 'AS', 1),
(2118, 135, 'Brakna', 'BR', 1),
(2119, 135, 'Dakhlet Nouadhibou', 'DN', 1),
(2120, 135, 'Gorgol', 'GO', 1),
(2121, 135, 'Guidimaka', 'GM', 1),
(2122, 135, 'Hodh Ech Chargui', 'HC', 1),
(2123, 135, 'Hodh El Gharbi', 'HG', 1),
(2124, 135, 'Inchiri', 'IN', 1),
(2125, 135, 'Tagant', 'TA', 1),
(2126, 135, 'Tiris Zemmour', 'TZ', 1),
(2127, 135, 'Trarza', 'TR', 1),
(2128, 135, 'Nouakchott', 'NO', 1),
(2129, 136, 'Beau Bassin-Rose Hill', 'BR', 1),
(2130, 136, 'Curepipe', 'CU', 1),
(2131, 136, 'Port Louis', 'PU', 1),
(2132, 136, 'Quatre Bornes', 'QB', 1),
(2133, 136, 'Vacoas-Phoenix', 'VP', 1),
(2134, 136, 'Agalega Islands', 'AG', 1),
(2135, 136, 'Cargados Carajos Shoals (Saint Brandon Islands)', 'CC', 1),
(2136, 136, 'Rodrigues', 'RO', 1),
(2137, 136, 'Black River', 'BL', 1),
(2138, 136, 'Flacq', 'FL', 1),
(2139, 136, 'Grand Port', 'GP', 1),
(2140, 136, 'Moka', 'MO', 1),
(2141, 136, 'Pamplemousses', 'PA', 1),
(2142, 136, 'Plaines Wilhems', 'PW', 1),
(2143, 136, 'Port Louis', 'PL', 1),
(2144, 136, 'Riviere du Rempart', 'RR', 1),
(2145, 136, 'Savanne', 'SA', 1),
(2146, 138, 'Baja California Norte', 'BN', 1),
(2147, 138, 'Baja California Sur', 'BS', 1),
(2148, 138, 'Campeche', 'CA', 1),
(2149, 138, 'Chiapas', 'CI', 1),
(2150, 138, 'Chihuahua', 'CH', 1),
(2151, 138, 'Coahuila de Zaragoza', 'CZ', 1),
(2152, 138, 'Colima', 'CL', 1),
(2153, 138, 'Distrito Federal', 'DF', 1),
(2154, 138, 'Durango', 'DU', 1),
(2155, 138, 'Guanajuato', 'GA', 1),
(2156, 138, 'Guerrero', 'GE', 1),
(2157, 138, 'Hidalgo', 'HI', 1),
(2158, 138, 'Jalisco', 'JA', 1),
(2159, 138, 'Mexico', 'ME', 1),
(2160, 138, 'Michoacan de Ocampo', 'MI', 1),
(2161, 138, 'Morelos', 'MO', 1),
(2162, 138, 'Nayarit', 'NA', 1),
(2163, 138, 'Nuevo Leon', 'NL', 1),
(2164, 138, 'Oaxaca', 'OA', 1),
(2165, 138, 'Puebla', 'PU', 1),
(2166, 138, 'Queretaro de Arteaga', 'QA', 1),
(2167, 138, 'Quintana Roo', 'QR', 1),
(2168, 138, 'San Luis Potosi', 'SA', 1),
(2169, 138, 'Sinaloa', 'SI', 1),
(2170, 138, 'Sonora', 'SO', 1),
(2171, 138, 'Tabasco', 'TB', 1),
(2172, 138, 'Tamaulipas', 'TM', 1),
(2173, 138, 'Tlaxcala', 'TL', 1),
(2174, 138, 'Veracruz-Llave', 'VE', 1),
(2175, 138, 'Yucatan', 'YU', 1),
(2176, 138, 'Zacatecas', 'ZA', 1),
(2177, 139, 'Chuuk', 'C', 1),
(2178, 139, 'Kosrae', 'K', 1),
(2179, 139, 'Pohnpei', 'P', 1),
(2180, 139, 'Yap', 'Y', 1),
(2181, 140, 'Gagauzia', 'GA', 1),
(2182, 140, 'Chisinau', 'CU', 1),
(2183, 140, 'Balti', 'BA', 1),
(2184, 140, 'Cahul', 'CA', 1),
(2185, 140, 'Edinet', 'ED', 1),
(2186, 140, 'Lapusna', 'LA', 1),
(2187, 140, 'Orhei', 'OR', 1),
(2188, 140, 'Soroca', 'SO', 1),
(2189, 140, 'Tighina', 'TI', 1),
(2190, 140, 'Ungheni', 'UN', 1),
(2191, 140, 'St‚nga Nistrului', 'SN', 1),
(2192, 141, 'Fontvieille', 'FV', 1),
(2193, 141, 'La Condamine', 'LC', 1),
(2194, 141, 'Monaco-Ville', 'MV', 1),
(2195, 141, 'Monte-Carlo', 'MC', 1),
(2196, 142, 'Ulanbaatar', '1', 1),
(2197, 142, 'Orhon', '035', 1),
(2198, 142, 'Darhan uul', '037', 1),
(2199, 142, 'Hentiy', '039', 1),
(2200, 142, 'Hovsgol', '041', 1),
(2201, 142, 'Hovd', '043', 1),
(2202, 142, 'Uvs', '046', 1),
(2203, 142, 'Tov', '047', 1),
(2204, 142, 'Selenge', '049', 1),
(2205, 142, 'Suhbaatar', '051', 1),
(2206, 142, 'Omnogovi', '053', 1),
(2207, 142, 'Ovorhangay', '055', 1),
(2208, 142, 'Dzavhan', '057', 1),
(2209, 142, 'DundgovL', '059', 1),
(2210, 142, 'Dornod', '061', 1),
(2211, 142, 'Dornogov', '063', 1),
(2212, 142, 'Govi-Sumber', '064', 1),
(2213, 142, 'Govi-Altay', '065', 1),
(2214, 142, 'Bulgan', '067', 1),
(2215, 142, 'Bayanhongor', '069', 1),
(2216, 142, 'Bayan-Olgiy', '071', 1),
(2217, 142, 'Arhangay', '073', 1),
(2218, 143, 'Saint Anthony', 'A', 1),
(2219, 143, 'Saint Georges', 'G', 1),
(2220, 143, 'Saint Peter', 'P', 1),
(2221, 144, 'Agadir', 'AGD', 1),
(2222, 144, 'Al Hoceima', 'HOC', 1),
(2223, 144, 'Azilal', 'AZI', 1),
(2224, 144, 'Beni Mellal', 'BME', 1),
(2225, 144, 'Ben Slimane', 'BSL', 1),
(2226, 144, 'Boulemane', 'BLM', 1),
(2227, 144, 'Casablanca', 'CBL', 1),
(2228, 144, 'Chaouen', 'CHA', 1),
(2229, 144, 'El Jadida', 'EJA', 1),
(2230, 144, 'El Kelaa des Sraghna', 'EKS', 1),
(2231, 144, 'Er Rachidia', 'ERA', 1),
(2232, 144, 'Essaouira', 'ESS', 1),
(2233, 144, 'Fes', 'FES', 1),
(2234, 144, 'Figuig', 'FIG', 1),
(2235, 144, 'Guelmim', 'GLM', 1),
(2236, 144, 'Ifrane', 'IFR', 1),
(2237, 144, 'Kenitra', 'KEN', 1),
(2238, 144, 'Khemisset', 'KHM', 1),
(2239, 144, 'Khenifra', 'KHN', 1),
(2240, 144, 'Khouribga', 'KHO', 1),
(2241, 144, 'Laayoune', 'LYN', 1),
(2242, 144, 'Larache', 'LAR', 1),
(2243, 144, 'Marrakech', 'MRK', 1),
(2244, 144, 'Meknes', 'MKN', 1),
(2245, 144, 'Nador', 'NAD', 1),
(2246, 144, 'Ouarzazate', 'ORZ', 1),
(2247, 144, 'Oujda', 'OUJ', 1),
(2248, 144, 'Rabat-Sale', 'RSA', 1),
(2249, 144, 'Safi', 'SAF', 1),
(2250, 144, 'Settat', 'SET', 1),
(2251, 144, 'Sidi Kacem', 'SKA', 1),
(2252, 144, 'Tangier', 'TGR', 1),
(2253, 144, 'Tan-Tan', 'TAN', 1),
(2254, 144, 'Taounate', 'TAO', 1),
(2255, 144, 'Taroudannt', 'TRD', 1),
(2256, 144, 'Tata', 'TAT', 1),
(2257, 144, 'Taza', 'TAZ', 1),
(2258, 144, 'Tetouan', 'TET', 1),
(2259, 144, 'Tiznit', 'TIZ', 1),
(2260, 144, 'Ad Dakhla', 'ADK', 1),
(2261, 144, 'Boujdour', 'BJD', 1),
(2262, 144, 'Es Smara', 'ESM', 1),
(2263, 145, 'Cabo Delgado', 'CD', 1),
(2264, 145, 'Gaza', 'GZ', 1),
(2265, 145, 'Inhambane', 'IN', 1),
(2266, 145, 'Manica', 'MN', 1),
(2267, 145, 'Maputo (city)', 'MC', 1),
(2268, 145, 'Maputo', 'MP', 1),
(2269, 145, 'Nampula', 'NA', 1),
(2270, 145, 'Niassa', 'NI', 1),
(2271, 145, 'Sofala', 'SO', 1),
(2272, 145, 'Tete', 'TE', 1),
(2273, 145, 'Zambezia', 'ZA', 1),
(2274, 146, 'Ayeyarwady', 'AY', 1),
(2275, 146, 'Bago', 'BG', 1),
(2276, 146, 'Magway', 'MG', 1),
(2277, 146, 'Mandalay', 'MD', 1),
(2278, 146, 'Sagaing', 'SG', 1),
(2279, 146, 'Tanintharyi', 'TN', 1),
(2280, 146, 'Yangon', 'YG', 1),
(2281, 146, 'Chin State', 'CH', 1),
(2282, 146, 'Kachin State', 'KC', 1),
(2283, 146, 'Kayah State', 'KH', 1),
(2284, 146, 'Kayin State', 'KN', 1),
(2285, 146, 'Mon State', 'MN', 1),
(2286, 146, 'Rakhine State', 'RK', 1),
(2287, 146, 'Shan State', 'SH', 1),
(2288, 147, 'Caprivi', 'CA', 1),
(2289, 147, 'Erongo', 'ER', 1),
(2290, 147, 'Hardap', 'HA', 1),
(2291, 147, 'Karas', 'KR', 1),
(2292, 147, 'Kavango', 'KV', 1),
(2293, 147, 'Khomas', 'KH', 1),
(2294, 147, 'Kunene', 'KU', 1),
(2295, 147, 'Ohangwena', 'OW', 1),
(2296, 147, 'Omaheke', 'OK', 1),
(2297, 147, 'Omusati', 'OT', 1),
(2298, 147, 'Oshana', 'ON', 1),
(2299, 147, 'Oshikoto', 'OO', 1),
(2300, 147, 'Otjozondjupa', 'OJ', 1),
(2301, 148, 'Aiwo', 'AO', 1),
(2302, 148, 'Anabar', 'AA', 1),
(2303, 148, 'Anetan', 'AT', 1),
(2304, 148, 'Anibare', 'AI', 1),
(2305, 148, 'Baiti', 'BA', 1),
(2306, 148, 'Boe', 'BO', 1),
(2307, 148, 'Buada', 'BU', 1),
(2308, 148, 'Denigomodu', 'DE', 1),
(2309, 148, 'Ewa', 'EW', 1),
(2310, 148, 'Ijuw', 'IJ', 1),
(2311, 148, 'Meneng', 'ME', 1),
(2312, 148, 'Nibok', 'NI', 1),
(2313, 148, 'Uaboe', 'UA', 1),
(2314, 148, 'Yaren', 'YA', 1),
(2315, 149, 'Bagmati', 'BA', 1),
(2316, 149, 'Bheri', 'BH', 1),
(2317, 149, 'Dhawalagiri', 'DH', 1),
(2318, 149, 'Gandaki', 'GA', 1),
(2319, 149, 'Janakpur', 'JA', 1),
(2320, 149, 'Karnali', 'KA', 1),
(2321, 149, 'Kosi', 'KO', 1),
(2322, 149, 'Lumbini', 'LU', 1),
(2323, 149, 'Mahakali', 'MA', 1),
(2324, 149, 'Mechi', 'ME', 1),
(2325, 149, 'Narayani', 'NA', 1),
(2326, 149, 'Rapti', 'RA', 1),
(2327, 149, 'Sagarmatha', 'SA', 1),
(2328, 149, 'Seti', 'SE', 1),
(2329, 150, 'Drenthe', 'DR', 1),
(2330, 150, 'Flevoland', 'FL', 1),
(2331, 150, 'Friesland', 'FR', 1),
(2332, 150, 'Gelderland', 'GE', 1),
(2333, 150, 'Groningen', 'GR', 1),
(2334, 150, 'Limburg', 'LI', 1),
(2335, 150, 'Noord-Brabant', 'NB', 1),
(2336, 150, 'Noord-Holland', 'NH', 1),
(2337, 150, 'Overijssel', 'OV', 1),
(2338, 150, 'Utrecht', 'UT', 1),
(2339, 150, 'Zeeland', 'ZE', 1),
(2340, 150, 'Zuid-Holland', 'ZH', 1),
(2341, 152, 'Iles Loyaute', 'L', 1),
(2342, 152, 'Nord', 'N', 1),
(2343, 152, 'Sud', 'S', 1),
(2344, 153, 'Auckland', 'AUK', 1),
(2345, 153, 'Bay of Plenty', 'BOP', 1),
(2346, 153, 'Canterbury', 'CAN', 1),
(2347, 153, 'Coromandel', 'COR', 1),
(2348, 153, 'Gisborne', 'GIS', 1),
(2349, 153, 'Fiordland', 'FIO', 1),
(2350, 153, 'Hawke\'s Bay', 'HKB', 1),
(2351, 153, 'Marlborough', 'MBH', 1),
(2352, 153, 'Manawatu-Wanganui', 'MWT', 1),
(2353, 153, 'Mt Cook-Mackenzie', 'MCM', 1),
(2354, 153, 'Nelson', 'NSN', 1),
(2355, 153, 'Northland', 'NTL', 1),
(2356, 153, 'Otago', 'OTA', 1),
(2357, 153, 'Southland', 'STL', 1),
(2358, 153, 'Taranaki', 'TKI', 1),
(2359, 153, 'Wellington', 'WGN', 1),
(2360, 153, 'Waikato', 'WKO', 1),
(2361, 153, 'Wairarapa', 'WAI', 1),
(2362, 153, 'West Coast', 'WTC', 1),
(2363, 154, 'Atlantico Norte', 'AN', 1),
(2364, 154, 'Atlantico Sur', 'AS', 1),
(2365, 154, 'Boaco', 'BO', 1),
(2366, 154, 'Carazo', 'CA', 1),
(2367, 154, 'Chinandega', 'CI', 1),
(2368, 154, 'Chontales', 'CO', 1),
(2369, 154, 'Esteli', 'ES', 1),
(2370, 154, 'Granada', 'GR', 1),
(2371, 154, 'Jinotega', 'JI', 1),
(2372, 154, 'Leon', 'LE', 1),
(2373, 154, 'Madriz', 'MD', 1),
(2374, 154, 'Managua', 'MN', 1),
(2375, 154, 'Masaya', 'MS', 1),
(2376, 154, 'Matagalpa', 'MT', 1),
(2377, 154, 'Nuevo Segovia', 'NS', 1),
(2378, 154, 'Rio San Juan', 'RS', 1),
(2379, 154, 'Rivas', 'RI', 1),
(2380, 155, 'Agadez', 'AG', 1),
(2381, 155, 'Diffa', 'DF', 1),
(2382, 155, 'Dosso', 'DS', 1),
(2383, 155, 'Maradi', 'MA', 1),
(2384, 155, 'Niamey', 'NM', 1),
(2385, 155, 'Tahoua', 'TH', 1),
(2386, 155, 'Tillaberi', 'TL', 1),
(2387, 155, 'Zinder', 'ZD', 1),
(2388, 156, 'Abia', 'AB', 1),
(2389, 156, 'Abuja Federal Capital Territory', 'CT', 1),
(2390, 156, 'Adamawa', 'AD', 1),
(2391, 156, 'Akwa Ibom', 'AK', 1),
(2392, 156, 'Anambra', 'AN', 1),
(2393, 156, 'Bauchi', 'BC', 1),
(2394, 156, 'Bayelsa', 'BY', 1),
(2395, 156, 'Benue', 'BN', 1),
(2396, 156, 'Borno', 'BO', 1),
(2397, 156, 'Cross River', 'CR', 1),
(2398, 156, 'Delta', 'DE', 1),
(2399, 156, 'Ebonyi', 'EB', 1),
(2400, 156, 'Edo', 'ED', 1),
(2401, 156, 'Ekiti', 'EK', 1),
(2402, 156, 'Enugu', 'EN', 1),
(2403, 156, 'Gombe', 'GO', 1),
(2404, 156, 'Imo', 'IM', 1),
(2405, 156, 'Jigawa', 'JI', 1),
(2406, 156, 'Kaduna', 'KD', 1),
(2407, 156, 'Kano', 'KN', 1),
(2408, 156, 'Katsina', 'KT', 1),
(2409, 156, 'Kebbi', 'KE', 1),
(2410, 156, 'Kogi', 'KO', 1),
(2411, 156, 'Kwara', 'KW', 1),
(2412, 156, 'Lagos', 'LA', 1),
(2413, 156, 'Nassarawa', 'NA', 1),
(2414, 156, 'Niger', 'NI', 1),
(2415, 156, 'Ogun', 'OG', 1),
(2416, 156, 'Ondo', 'ONG', 1),
(2417, 156, 'Osun', 'OS', 1),
(2418, 156, 'Oyo', 'OY', 1),
(2419, 156, 'Plateau', 'PL', 1),
(2420, 156, 'Rivers', 'RI', 1),
(2421, 156, 'Sokoto', 'SO', 1),
(2422, 156, 'Taraba', 'TA', 1),
(2423, 156, 'Yobe', 'YO', 1),
(2424, 156, 'Zamfara', 'ZA', 1),
(2425, 159, 'Northern Islands', 'N', 1),
(2426, 159, 'Rota', 'R', 1),
(2427, 159, 'Saipan', 'S', 1),
(2428, 159, 'Tinian', 'T', 1),
(2429, 160, 'Akershus', 'AK', 1),
(2430, 160, 'Aust-Agder', 'AA', 1),
(2431, 160, 'Buskerud', 'BU', 1),
(2432, 160, 'Finnmark', 'FM', 1),
(2433, 160, 'Hedmark', 'HM', 1),
(2434, 160, 'Hordaland', 'HL', 1),
(2435, 160, 'More og Romdal', 'MR', 1),
(2436, 160, 'Nord-Trondelag', 'NT', 1),
(2437, 160, 'Nordland', 'NL', 1),
(2438, 160, 'Ostfold', 'OF', 1),
(2439, 160, 'Oppland', 'OP', 1),
(2440, 160, 'Oslo', 'OL', 1),
(2441, 160, 'Rogaland', 'RL', 1),
(2442, 160, 'Sor-Trondelag', 'ST', 1),
(2443, 160, 'Sogn og Fjordane', 'SJ', 1),
(2444, 160, 'Svalbard', 'SV', 1),
(2445, 160, 'Telemark', 'TM', 1),
(2446, 160, 'Troms', 'TR', 1),
(2447, 160, 'Vest-Agder', 'VA', 1),
(2448, 160, 'Vestfold', 'VF', 1),
(2449, 161, 'Ad Dakhiliyah', 'DA', 1),
(2450, 161, 'Al Batinah', 'BA', 1),
(2451, 161, 'Al Wusta', 'WU', 1),
(2452, 161, 'Ash Sharqiyah', 'SH', 1),
(2453, 161, 'Az Zahirah', 'ZA', 1),
(2454, 161, 'Masqat', 'MA', 1),
(2455, 161, 'Musandam', 'MU', 1),
(2456, 161, 'Zufar', 'ZU', 1),
(2457, 162, 'Balochistan', 'B', 1),
(2458, 162, 'Federally Administered Tribal Areas', 'T', 1),
(2459, 162, 'Islamabad Capital Territory', 'I', 1),
(2460, 162, 'North-West Frontier', 'N', 1),
(2461, 162, 'Punjab', 'P', 1),
(2462, 162, 'Sindh', 'S', 1),
(2463, 163, 'Aimeliik', 'AM', 1),
(2464, 163, 'Airai', 'AR', 1),
(2465, 163, 'Angaur', 'AN', 1),
(2466, 163, 'Hatohobei', 'HA', 1),
(2467, 163, 'Kayangel', 'KA', 1),
(2468, 163, 'Koror', 'KO', 1),
(2469, 163, 'Melekeok', 'ME', 1),
(2470, 163, 'Ngaraard', 'NA', 1),
(2471, 163, 'Ngarchelong', 'NG', 1),
(2472, 163, 'Ngardmau', 'ND', 1),
(2473, 163, 'Ngatpang', 'NT', 1),
(2474, 163, 'Ngchesar', 'NC', 1),
(2475, 163, 'Ngeremlengui', 'NR', 1),
(2476, 163, 'Ngiwal', 'NW', 1),
(2477, 163, 'Peleliu', 'PE', 1),
(2478, 163, 'Sonsorol', 'SO', 1),
(2479, 164, 'Bocas del Toro', 'BT', 1),
(2480, 164, 'Chiriqui', 'CH', 1),
(2481, 164, 'Cocle', 'CC', 1),
(2482, 164, 'Colon', 'CL', 1),
(2483, 164, 'Darien', 'DA', 1),
(2484, 164, 'Herrera', 'HE', 1),
(2485, 164, 'Los Santos', 'LS', 1),
(2486, 164, 'Panama', 'PA', 1),
(2487, 164, 'San Blas', 'SB', 1),
(2488, 164, 'Veraguas', 'VG', 1),
(2489, 165, 'Bougainville', 'BV', 1),
(2490, 165, 'Central', 'CE', 1),
(2491, 165, 'Chimbu', 'CH', 1),
(2492, 165, 'Eastern Highlands', 'EH', 1),
(2493, 165, 'East New Britain', 'EB', 1),
(2494, 165, 'East Sepik', 'ES', 1),
(2495, 165, 'Enga', 'EN', 1),
(2496, 165, 'Gulf', 'GU', 1),
(2497, 165, 'Madang', 'MD', 1),
(2498, 165, 'Manus', 'MN', 1),
(2499, 165, 'Milne Bay', 'MB', 1),
(2500, 165, 'Morobe', 'MR', 1),
(2501, 165, 'National Capital', 'NC', 1),
(2502, 165, 'New Ireland', 'NI', 1),
(2503, 165, 'Northern', 'NO', 1),
(2504, 165, 'Sandaun', 'SA', 1),
(2505, 165, 'Southern Highlands', 'SH', 1),
(2506, 165, 'Western', 'WE', 1),
(2507, 165, 'Western Highlands', 'WH', 1),
(2508, 165, 'West New Britain', 'WB', 1),
(2509, 166, 'Alto Paraguay', 'AG', 1),
(2510, 166, 'Alto Parana', 'AN', 1),
(2511, 166, 'Amambay', 'AM', 1),
(2512, 166, 'Asuncion', 'AS', 1),
(2513, 166, 'Boqueron', 'BO', 1),
(2514, 166, 'Caaguazu', 'CG', 1),
(2515, 166, 'Caazapa', 'CZ', 1),
(2516, 166, 'Canindeyu', 'CN', 1),
(2517, 166, 'Central', 'CE', 1),
(2518, 166, 'Concepcion', 'CC', 1),
(2519, 166, 'Cordillera', 'CD', 1),
(2520, 166, 'Guaira', 'GU', 1),
(2521, 166, 'Itapua', 'IT', 1),
(2522, 166, 'Misiones', 'MI', 1),
(2523, 166, 'Neembucu', 'NE', 1),
(2524, 166, 'Paraguari', 'PA', 1),
(2525, 166, 'Presidente Hayes', 'PH', 1),
(2526, 166, 'San Pedro', 'SP', 1),
(2527, 167, 'Amazonas', 'AM', 1),
(2528, 167, 'Ancash', 'AN', 1),
(2529, 167, 'Apurimac', 'AP', 1),
(2530, 167, 'Arequipa', 'AR', 1),
(2531, 167, 'Ayacucho', 'AY', 1),
(2532, 167, 'Cajamarca', 'CJ', 1),
(2533, 167, 'Callao', 'CL', 1),
(2534, 167, 'Cusco', 'CU', 1),
(2535, 167, 'Huancavelica', 'HV', 1),
(2536, 167, 'Huanuco', 'HO', 1),
(2537, 167, 'Ica', 'IC', 1),
(2538, 167, 'Junin', 'JU', 1),
(2539, 167, 'La Libertad', 'LD', 1),
(2540, 167, 'Lambayeque', 'LY', 1),
(2541, 167, 'Lima', 'LI', 1),
(2542, 167, 'Loreto', 'LO', 1),
(2543, 167, 'Madre de Dios', 'MD', 1),
(2544, 167, 'Moquegua', 'MO', 1),
(2545, 167, 'Pasco', 'PA', 1),
(2546, 167, 'Piura', 'PI', 1),
(2547, 167, 'Puno', 'PU', 1),
(2548, 167, 'San Martin', 'SM', 1),
(2549, 167, 'Tacna', 'TA', 1),
(2550, 167, 'Tumbes', 'TU', 1),
(2551, 167, 'Ucayali', 'UC', 1),
(2552, 168, 'Abra', 'ABR', 1),
(2553, 168, 'Agusan del Norte', 'ANO', 1),
(2554, 168, 'Agusan del Sur', 'ASU', 1),
(2555, 168, 'Aklan', 'AKL', 1),
(2556, 168, 'Albay', 'ALB', 1),
(2557, 168, 'Antique', 'ANT', 1),
(2558, 168, 'Apayao', 'APY', 1),
(2559, 168, 'Aurora', 'AUR', 1),
(2560, 168, 'Basilan', 'BAS', 1),
(2561, 168, 'Bataan', 'BTA', 1),
(2562, 168, 'Batanes', 'BTE', 1),
(2563, 168, 'Batangas', 'BTG', 1),
(2564, 168, 'Biliran', 'BLR', 1),
(2565, 168, 'Benguet', 'BEN', 1),
(2566, 168, 'Bohol', 'BOL', 1),
(2567, 168, 'Bukidnon', 'BUK', 1),
(2568, 168, 'Bulacan', 'BUL', 1),
(2569, 168, 'Cagayan', 'CAG', 1),
(2570, 168, 'Camarines Norte', 'CNO', 1),
(2571, 168, 'Camarines Sur', 'CSU', 1),
(2572, 168, 'Camiguin', 'CAM', 1),
(2573, 168, 'Capiz', 'CAP', 1),
(2574, 168, 'Catanduanes', 'CAT', 1),
(2575, 168, 'Cavite', 'CAV', 1),
(2576, 168, 'Cebu', 'CEB', 1),
(2577, 168, 'Compostela', 'CMP', 1),
(2578, 168, 'Davao del Norte', 'DNO', 1),
(2579, 168, 'Davao del Sur', 'DSU', 1),
(2580, 168, 'Davao Oriental', 'DOR', 1),
(2581, 168, 'Eastern Samar', 'ESA', 1),
(2582, 168, 'Guimaras', 'GUI', 1),
(2583, 168, 'Ifugao', 'IFU', 1),
(2584, 168, 'Ilocos Norte', 'INO', 1),
(2585, 168, 'Ilocos Sur', 'ISU', 1),
(2586, 168, 'Iloilo', 'ILO', 1),
(2587, 168, 'Isabela', 'ISA', 1),
(2588, 168, 'Kalinga', 'KAL', 1),
(2589, 168, 'Laguna', 'LAG', 1),
(2590, 168, 'Lanao del Norte', 'LNO', 1),
(2591, 168, 'Lanao del Sur', 'LSU', 1),
(2592, 168, 'La Union', 'UNI', 1),
(2593, 168, 'Leyte', 'LEY', 1),
(2594, 168, 'Maguindanao', 'MAG', 1),
(2595, 168, 'Marinduque', 'MRN', 1),
(2596, 168, 'Masbate', 'MSB', 1),
(2597, 168, 'Mindoro Occidental', 'MIC', 1),
(2598, 168, 'Mindoro Oriental', 'MIR', 1),
(2599, 168, 'Misamis Occidental', 'MSC', 1),
(2600, 168, 'Misamis Oriental', 'MOR', 1),
(2601, 168, 'Mountain', 'MOP', 1),
(2602, 168, 'Negros Occidental', 'NOC', 1),
(2603, 168, 'Negros Oriental', 'NOR', 1),
(2604, 168, 'North Cotabato', 'NCT', 1),
(2605, 168, 'Northern Samar', 'NSM', 1),
(2606, 168, 'Nueva Ecija', 'NEC', 1),
(2607, 168, 'Nueva Vizcaya', 'NVZ', 1),
(2608, 168, 'Palawan', 'PLW', 1),
(2609, 168, 'Pampanga', 'PMP', 1),
(2610, 168, 'Pangasinan', 'PNG', 1),
(2611, 168, 'Quezon', 'QZN', 1),
(2612, 168, 'Quirino', 'QRN', 1),
(2613, 168, 'Rizal', 'RIZ', 1),
(2614, 168, 'Romblon', 'ROM', 1),
(2615, 168, 'Samar', 'SMR', 1),
(2616, 168, 'Sarangani', 'SRG', 1),
(2617, 168, 'Siquijor', 'SQJ', 1),
(2618, 168, 'Sorsogon', 'SRS', 1),
(2619, 168, 'South Cotabato', 'SCO', 1),
(2620, 168, 'Southern Leyte', 'SLE', 1),
(2621, 168, 'Sultan Kudarat', 'SKU', 1),
(2622, 168, 'Sulu', 'SLU', 1),
(2623, 168, 'Surigao del Norte', 'SNO', 1),
(2624, 168, 'Surigao del Sur', 'SSU', 1),
(2625, 168, 'Tarlac', 'TAR', 1),
(2626, 168, 'Tawi-Tawi', 'TAW', 1),
(2627, 168, 'Zambales', 'ZBL', 1),
(2628, 168, 'Zamboanga del Norte', 'ZNO', 1),
(2629, 168, 'Zamboanga del Sur', 'ZSU', 1),
(2630, 168, 'Zamboanga Sibugay', 'ZSI', 1),
(2631, 170, 'Dolnoslaskie', 'DO', 1),
(2632, 170, 'Kujawsko-Pomorskie', 'KP', 1),
(2633, 170, 'Lodzkie', 'LO', 1),
(2634, 170, 'Lubelskie', 'LL', 1),
(2635, 170, 'Lubuskie', 'LU', 1),
(2636, 170, 'Malopolskie', 'ML', 1),
(2637, 170, 'Mazowieckie', 'MZ', 1),
(2638, 170, 'Opolskie', 'OP', 1),
(2639, 170, 'Podkarpackie', 'PP', 1),
(2640, 170, 'Podlaskie', 'PL', 1),
(2641, 170, 'Pomorskie', 'PM', 1),
(2642, 170, 'Slaskie', 'SL', 1),
(2643, 170, 'Swietokrzyskie', 'SW', 1),
(2644, 170, 'Warminsko-Mazurskie', 'WM', 1),
(2645, 170, 'Wielkopolskie', 'WP', 1),
(2646, 170, 'Zachodniopomorskie', 'ZA', 1),
(2647, 198, 'Saint Pierre', 'P', 1),
(2648, 198, 'Miquelon', 'M', 1),
(2649, 171, 'A&ccedil;ores', 'AC', 1),
(2650, 171, 'Aveiro', 'AV', 1),
(2651, 171, 'Beja', 'BE', 1),
(2652, 171, 'Braga', 'BR', 1),
(2653, 171, 'Bragan&ccedil;a', 'BA', 1),
(2654, 171, 'Castelo Branco', 'CB', 1),
(2655, 171, 'Coimbra', 'CO', 1),
(2656, 171, '&Eacute;vora', 'EV', 1),
(2657, 171, 'Faro', 'FA', 1),
(2658, 171, 'Guarda', 'GU', 1),
(2659, 171, 'Leiria', 'LE', 1),
(2660, 171, 'Lisboa', 'LI', 1),
(2661, 171, 'Madeira', 'ME', 1),
(2662, 171, 'Portalegre', 'PO', 1),
(2663, 171, 'Porto', 'PR', 1),
(2664, 171, 'Santar&eacute;m', 'SA', 1),
(2665, 171, 'Set&uacute;bal', 'SE', 1),
(2666, 171, 'Viana do Castelo', 'VC', 1),
(2667, 171, 'Vila Real', 'VR', 1),
(2668, 171, 'Viseu', 'VI', 1),
(2669, 173, 'Ad Dawhah', 'DW', 1),
(2670, 173, 'Al Ghuwayriyah', 'GW', 1),
(2671, 173, 'Al Jumayliyah', 'JM', 1),
(2672, 173, 'Al Khawr', 'KR', 1),
(2673, 173, 'Al Wakrah', 'WK', 1),
(2674, 173, 'Ar Rayyan', 'RN', 1),
(2675, 173, 'Jarayan al Batinah', 'JB', 1),
(2676, 173, 'Madinat ash Shamal', 'MS', 1),
(2677, 173, 'Umm Sa\'id', 'UD', 1),
(2678, 173, 'Umm Salal', 'UL', 1),
(2679, 175, 'Alba', 'AB', 1),
(2680, 175, 'Arad', 'AR', 1),
(2681, 175, 'Arges', 'AG', 1),
(2682, 175, 'Bacau', 'BC', 1),
(2683, 175, 'Bihor', 'BH', 1),
(2684, 175, 'Bistrita-Nasaud', 'BN', 1),
(2685, 175, 'Botosani', 'BT', 1),
(2686, 175, 'Brasov', 'BV', 1),
(2687, 175, 'Braila', 'BR', 1),
(2688, 175, 'Bucuresti', 'B', 1),
(2689, 175, 'Buzau', 'BZ', 1),
(2690, 175, 'Caras-Severin', 'CS', 1),
(2691, 175, 'Calarasi', 'CL', 1),
(2692, 175, 'Cluj', 'CJ', 1),
(2693, 175, 'Constanta', 'CT', 1),
(2694, 175, 'Covasna', 'CV', 1),
(2695, 175, 'Dimbovita', 'DB', 1),
(2696, 175, 'Dolj', 'DJ', 1),
(2697, 175, 'Galati', 'GL', 1),
(2698, 175, 'Giurgiu', 'GR', 1),
(2699, 175, 'Gorj', 'GJ', 1),
(2700, 175, 'Harghita', 'HR', 1),
(2701, 175, 'Hunedoara', 'HD', 1),
(2702, 175, 'Ialomita', 'IL', 1),
(2703, 175, 'Iasi', 'IS', 1),
(2704, 175, 'Ilfov', 'IF', 1),
(2705, 175, 'Maramures', 'MM', 1),
(2706, 175, 'Mehedinti', 'MH', 1),
(2707, 175, 'Mures', 'MS', 1),
(2708, 175, 'Neamt', 'NT', 1),
(2709, 175, 'Olt', 'OT', 1),
(2710, 175, 'Prahova', 'PH', 1),
(2711, 175, 'Satu-Mare', 'SM', 1),
(2712, 175, 'Salaj', 'SJ', 1),
(2713, 175, 'Sibiu', 'SB', 1),
(2714, 175, 'Suceava', 'SV', 1),
(2715, 175, 'Teleorman', 'TR', 1),
(2716, 175, 'Timis', 'TM', 1),
(2717, 175, 'Tulcea', 'TL', 1),
(2718, 175, 'Vaslui', 'VS', 1),
(2719, 175, 'Valcea', 'VL', 1),
(2720, 175, 'Vrancea', 'VN', 1),
(2721, 176, 'Abakan', 'AB', 1),
(2722, 176, 'Aginskoye', 'AG', 1),
(2723, 176, 'Anadyr', 'AN', 1),
(2724, 176, 'Arkahangelsk', 'AR', 1),
(2725, 176, 'Astrakhan', 'AS', 1),
(2726, 176, 'Barnaul', 'BA', 1),
(2727, 176, 'Belgorod', 'BE', 1),
(2728, 176, 'Birobidzhan', 'BI', 1),
(2729, 176, 'Blagoveshchensk', 'BL', 1),
(2730, 176, 'Bryansk', 'BR', 1),
(2731, 176, 'Cheboksary', 'CH', 1),
(2732, 176, 'Chelyabinsk', 'CL', 1),
(2733, 176, 'Cherkessk', 'CR', 1),
(2734, 176, 'Chita', 'CI', 1),
(2735, 176, 'Dudinka', 'DU', 1),
(2736, 176, 'Elista', 'EL', 1),
(2738, 176, 'Gorno-Altaysk', 'GA', 1),
(2739, 176, 'Groznyy', 'GR', 1),
(2740, 176, 'Irkutsk', 'IR', 1),
(2741, 176, 'Ivanovo', 'IV', 1),
(2742, 176, 'Izhevsk', 'IZ', 1),
(2743, 176, 'Kalinigrad', 'KA', 1),
(2744, 176, 'Kaluga', 'KL', 1),
(2745, 176, 'Kasnodar', 'KS', 1),
(2746, 176, 'Kazan', 'KZ', 1),
(2747, 176, 'Kemerovo', 'KE', 1),
(2748, 176, 'Khabarovsk', 'KH', 1),
(2749, 176, 'Khanty-Mansiysk', 'KM', 1),
(2750, 176, 'Kostroma', 'KO', 1),
(2751, 176, 'Krasnodar', 'KR', 1),
(2752, 176, 'Krasnoyarsk', 'KN', 1),
(2753, 176, 'Kudymkar', 'KU', 1),
(2754, 176, 'Kurgan', 'KG', 1),
(2755, 176, 'Kursk', 'KK', 1),
(2756, 176, 'Kyzyl', 'KY', 1),
(2757, 176, 'Lipetsk', 'LI', 1),
(2758, 176, 'Magadan', 'MA', 1),
(2759, 176, 'Makhachkala', 'MK', 1),
(2760, 176, 'Maykop', 'MY', 1),
(2761, 176, 'Moscow', 'MO', 1),
(2762, 176, 'Murmansk', 'MU', 1),
(2763, 176, 'Nalchik', 'NA', 1),
(2764, 176, 'Naryan Mar', 'NR', 1),
(2765, 176, 'Nazran', 'NZ', 1),
(2766, 176, 'Nizhniy Novgorod', 'NI', 1),
(2767, 176, 'Novgorod', 'NO', 1),
(2768, 176, 'Novosibirsk', 'NV', 1),
(2769, 176, 'Omsk', 'OM', 1),
(2770, 176, 'Orel', 'OR', 1),
(2771, 176, 'Orenburg', 'OE', 1),
(2772, 176, 'Palana', 'PA', 1),
(2773, 176, 'Penza', 'PE', 1),
(2774, 176, 'Perm', 'PR', 1),
(2775, 176, 'Petropavlovsk-Kamchatskiy', 'PK', 1),
(2776, 176, 'Petrozavodsk', 'PT', 1),
(2777, 176, 'Pskov', 'PS', 1),
(2778, 176, 'Rostov-na-Donu', 'RO', 1),
(2779, 176, 'Ryazan', 'RY', 1),
(2780, 176, 'Salekhard', 'SL', 1),
(2781, 176, 'Samara', 'SA', 1),
(2782, 176, 'Saransk', 'SR', 1),
(2783, 176, 'Saratov', 'SV', 1),
(2784, 176, 'Smolensk', 'SM', 1),
(2785, 176, 'St. Petersburg', 'SP', 1),
(2786, 176, 'Stavropol', 'ST', 1),
(2787, 176, 'Syktyvkar', 'SY', 1),
(2788, 176, 'Tambov', 'TA', 1),
(2789, 176, 'Tomsk', 'TO', 1),
(2790, 176, 'Tula', 'TU', 1),
(2791, 176, 'Tura', 'TR', 1),
(2792, 176, 'Tver', 'TV', 1),
(2793, 176, 'Tyumen', 'TY', 1),
(2794, 176, 'Ufa', 'UF', 1),
(2795, 176, 'Ul\'yanovsk', 'UL', 1),
(2796, 176, 'Ulan-Ude', 'UU', 1),
(2797, 176, 'Ust\'-Ordynskiy', 'US', 1),
(2798, 176, 'Vladikavkaz', 'VL', 1),
(2799, 176, 'Vladimir', 'VA', 1),
(2800, 176, 'Vladivostok', 'VV', 1),
(2801, 176, 'Volgograd', 'VG', 1),
(2802, 176, 'Vologda', 'VD', 1),
(2803, 176, 'Voronezh', 'VO', 1),
(2804, 176, 'Vyatka', 'VY', 1),
(2805, 176, 'Yakutsk', 'YA', 1),
(2806, 176, 'Yaroslavl', 'YR', 1),
(2807, 176, 'Yekaterinburg', 'YE', 1),
(2808, 176, 'Yoshkar-Ola', 'YO', 1),
(2809, 177, 'Butare', 'BU', 1),
(2810, 177, 'Byumba', 'BY', 1),
(2811, 177, 'Cyangugu', 'CY', 1),
(2812, 177, 'Gikongoro', 'GK', 1),
(2813, 177, 'Gisenyi', 'GS', 1),
(2814, 177, 'Gitarama', 'GT', 1),
(2815, 177, 'Kibungo', 'KG', 1),
(2816, 177, 'Kibuye', 'KY', 1),
(2817, 177, 'Kigali Rurale', 'KR', 1),
(2818, 177, 'Kigali-ville', 'KV', 1),
(2819, 177, 'Ruhengeri', 'RU', 1),
(2820, 177, 'Umutara', 'UM', 1),
(2821, 178, 'Christ Church Nichola Town', 'CCN', 1),
(2822, 178, 'Saint Anne Sandy Point', 'SAS', 1),
(2823, 178, 'Saint George Basseterre', 'SGB', 1),
(2824, 178, 'Saint George Gingerland', 'SGG', 1),
(2825, 178, 'Saint James Windward', 'SJW', 1),
(2826, 178, 'Saint John Capesterre', 'SJC', 1),
(2827, 178, 'Saint John Figtree', 'SJF', 1),
(2828, 178, 'Saint Mary Cayon', 'SMC', 1),
(2829, 178, 'Saint Paul Capesterre', 'CAP', 1),
(2830, 178, 'Saint Paul Charlestown', 'CHA', 1),
(2831, 178, 'Saint Peter Basseterre', 'SPB', 1),
(2832, 178, 'Saint Thomas Lowland', 'STL', 1),
(2833, 178, 'Saint Thomas Middle Island', 'STM', 1),
(2834, 178, 'Trinity Palmetto Point', 'TPP', 1),
(2835, 179, 'Anse-la-Raye', 'AR', 1),
(2836, 179, 'Castries', 'CA', 1),
(2837, 179, 'Choiseul', 'CH', 1),
(2838, 179, 'Dauphin', 'DA', 1),
(2839, 179, 'Dennery', 'DE', 1),
(2840, 179, 'Gros-Islet', 'GI', 1),
(2841, 179, 'Laborie', 'LA', 1),
(2842, 179, 'Micoud', 'MI', 1),
(2843, 179, 'Praslin', 'PR', 1),
(2844, 179, 'Soufriere', 'SO', 1),
(2845, 179, 'Vieux-Fort', 'VF', 1),
(2846, 180, 'Charlotte', 'C', 1),
(2847, 180, 'Grenadines', 'R', 1),
(2848, 180, 'Saint Andrew', 'A', 1),
(2849, 180, 'Saint David', 'D', 1),
(2850, 180, 'Saint George', 'G', 1),
(2851, 180, 'Saint Patrick', 'P', 1),
(2852, 181, 'A\'ana', 'AN', 1),
(2853, 181, 'Aiga-i-le-Tai', 'AI', 1),
(2854, 181, 'Atua', 'AT', 1),
(2855, 181, 'Fa\'asaleleaga', 'FA', 1),
(2856, 181, 'Gaga\'emauga', 'GE', 1),
(2857, 181, 'Gagaifomauga', 'GF', 1),
(2858, 181, 'Palauli', 'PA', 1),
(2859, 181, 'Satupa\'itea', 'SA', 1),
(2860, 181, 'Tuamasaga', 'TU', 1),
(2861, 181, 'Va\'a-o-Fonoti', 'VF', 1),
(2862, 181, 'Vaisigano', 'VS', 1),
(2863, 182, 'Acquaviva', 'AC', 1),
(2864, 182, 'Borgo Maggiore', 'BM', 1),
(2865, 182, 'Chiesanuova', 'CH', 1),
(2866, 182, 'Domagnano', 'DO', 1),
(2867, 182, 'Faetano', 'FA', 1),
(2868, 182, 'Fiorentino', 'FI', 1),
(2869, 182, 'Montegiardino', 'MO', 1),
(2870, 182, 'Citta di San Marino', 'SM', 1),
(2871, 182, 'Serravalle', 'SE', 1),
(2872, 183, 'Sao Tome', 'S', 1),
(2873, 183, 'Principe', 'P', 1),
(2874, 184, 'Al Bahah', 'BH', 1),
(2875, 184, 'Al Hudud ash Shamaliyah', 'HS', 1),
(2876, 184, 'Al Jawf', 'JF', 1),
(2877, 184, 'Al Madinah', 'MD', 1),
(2878, 184, 'Al Qasim', 'QS', 1),
(2879, 184, 'Ar Riyad', 'RD', 1),
(2880, 184, 'Ash Sharqiyah (Eastern)', 'AQ', 1),
(2881, 184, '\'Asir', 'AS', 1),
(2882, 184, 'Ha\'il', 'HL', 1),
(2883, 184, 'Jizan', 'JZ', 1),
(2884, 184, 'Makkah', 'ML', 1),
(2885, 184, 'Najran', 'NR', 1),
(2886, 184, 'Tabuk', 'TB', 1),
(2887, 185, 'Dakar', 'DA', 1),
(2888, 185, 'Diourbel', 'DI', 1),
(2889, 185, 'Fatick', 'FA', 1),
(2890, 185, 'Kaolack', 'KA', 1),
(2891, 185, 'Kolda', 'KO', 1),
(2892, 185, 'Louga', 'LO', 1),
(2893, 185, 'Matam', 'MA', 1),
(2894, 185, 'Saint-Louis', 'SL', 1),
(2895, 185, 'Tambacounda', 'TA', 1),
(2896, 185, 'Thies', 'TH', 1),
(2897, 185, 'Ziguinchor', 'ZI', 1),
(2898, 186, 'Anse aux Pins', 'AP', 1),
(2899, 186, 'Anse Boileau', 'AB', 1),
(2900, 186, 'Anse Etoile', 'AE', 1),
(2901, 186, 'Anse Louis', 'AL', 1),
(2902, 186, 'Anse Royale', 'AR', 1),
(2903, 186, 'Baie Lazare', 'BL', 1),
(2904, 186, 'Baie Sainte Anne', 'BS', 1),
(2905, 186, 'Beau Vallon', 'BV', 1),
(2906, 186, 'Bel Air', 'BA', 1),
(2907, 186, 'Bel Ombre', 'BO', 1),
(2908, 186, 'Cascade', 'CA', 1),
(2909, 186, 'Glacis', 'GL', 1),
(2910, 186, 'Grand\' Anse (on Mahe)', 'GM', 1),
(2911, 186, 'Grand\' Anse (on Praslin)', 'GP', 1),
(2912, 186, 'La Digue', 'DG', 1),
(2913, 186, 'La Riviere Anglaise', 'RA', 1),
(2914, 186, 'Mont Buxton', 'MB', 1),
(2915, 186, 'Mont Fleuri', 'MF', 1),
(2916, 186, 'Plaisance', 'PL', 1),
(2917, 186, 'Pointe La Rue', 'PR', 1),
(2918, 186, 'Port Glaud', 'PG', 1),
(2919, 186, 'Saint Louis', 'SL', 1),
(2920, 186, 'Takamaka', 'TA', 1),
(2921, 187, 'Eastern', 'E', 1),
(2922, 187, 'Northern', 'N', 1),
(2923, 187, 'Southern', 'S', 1),
(2924, 187, 'Western', 'W', 1),
(2925, 189, 'Banskobystrický', 'BA', 1),
(2926, 189, 'Bratislavský', 'BR', 1),
(2927, 189, 'Košický', 'KO', 1),
(2928, 189, 'Nitriansky', 'NI', 1),
(2929, 189, 'Prešovský', 'PR', 1),
(2930, 189, 'Trenčiansky', 'TC', 1),
(2931, 189, 'Trnavský', 'TV', 1),
(2932, 189, 'Žilinský', 'ZI', 1),
(2933, 191, 'Central', 'CE', 1),
(2934, 191, 'Choiseul', 'CH', 1),
(2935, 191, 'Guadalcanal', 'GC', 1),
(2936, 191, 'Honiara', 'HO', 1),
(2937, 191, 'Isabel', 'IS', 1),
(2938, 191, 'Makira', 'MK', 1),
(2939, 191, 'Malaita', 'ML', 1),
(2940, 191, 'Rennell and Bellona', 'RB', 1),
(2941, 191, 'Temotu', 'TM', 1),
(2942, 191, 'Western', 'WE', 1),
(2943, 192, 'Awdal', 'AW', 1),
(2944, 192, 'Bakool', 'BK', 1),
(2945, 192, 'Banaadir', 'BN', 1),
(2946, 192, 'Bari', 'BR', 1),
(2947, 192, 'Bay', 'BY', 1),
(2948, 192, 'Galguduud', 'GA', 1),
(2949, 192, 'Gedo', 'GE', 1),
(2950, 192, 'Hiiraan', 'HI', 1),
(2951, 192, 'Jubbada Dhexe', 'JD', 1),
(2952, 192, 'Jubbada Hoose', 'JH', 1),
(2953, 192, 'Mudug', 'MU', 1),
(2954, 192, 'Nugaal', 'NU', 1),
(2955, 192, 'Sanaag', 'SA', 1),
(2956, 192, 'Shabeellaha Dhexe', 'SD', 1),
(2957, 192, 'Shabeellaha Hoose', 'SH', 1),
(2958, 192, 'Sool', 'SL', 1),
(2959, 192, 'Togdheer', 'TO', 1),
(2960, 192, 'Woqooyi Galbeed', 'WG', 1),
(2961, 193, 'Eastern Cape', 'EC', 1),
(2962, 193, 'Free State', 'FS', 1),
(2963, 193, 'Gauteng', 'GT', 1),
(2964, 193, 'KwaZulu-Natal', 'KN', 1),
(2965, 193, 'Limpopo', 'LP', 1),
(2966, 193, 'Mpumalanga', 'MP', 1),
(2967, 193, 'North West', 'NW', 1),
(2968, 193, 'Northern Cape', 'NC', 1),
(2969, 193, 'Western Cape', 'WC', 1),
(2970, 195, 'La Coru&ntilde;a', 'CA', 1),
(2971, 195, '&Aacute;lava', 'AL', 1),
(2972, 195, 'Albacete', 'AB', 1),
(2973, 195, 'Alicante', 'AC', 1),
(2974, 195, 'Almeria', 'AM', 1),
(2975, 195, 'Asturias', 'AS', 1),
(2976, 195, '&Aacute;vila', 'AV', 1),
(2977, 195, 'Badajoz', 'BJ', 1),
(2978, 195, 'Baleares', 'IB', 1),
(2979, 195, 'Barcelona', 'BA', 1),
(2980, 195, 'Burgos', 'BU', 1),
(2981, 195, 'C&aacute;ceres', 'CC', 1),
(2982, 195, 'C&aacute;diz', 'CZ', 1),
(2983, 195, 'Cantabria', 'CT', 1),
(2984, 195, 'Castell&oacute;n', 'CL', 1),
(2985, 195, 'Ceuta', 'CE', 1),
(2986, 195, 'Ciudad Real', 'CR', 1),
(2987, 195, 'C&oacute;rdoba', 'CD', 1),
(2988, 195, 'Cuenca', 'CU', 1),
(2989, 195, 'Girona', 'GI', 1),
(2990, 195, 'Granada', 'GD', 1),
(2991, 195, 'Guadalajara', 'GJ', 1),
(2992, 195, 'Guip&uacute;zcoa', 'GP', 1),
(2993, 195, 'Huelva', 'HL', 1),
(2994, 195, 'Huesca', 'HS', 1),
(2995, 195, 'Ja&eacute;n', 'JN', 1),
(2996, 195, 'La Rioja', 'RJ', 1),
(2997, 195, 'Las Palmas', 'PM', 1),
(2998, 195, 'Leon', 'LE', 1),
(2999, 195, 'Lleida', 'LL', 1),
(3000, 195, 'Lugo', 'LG', 1),
(3001, 195, 'Madrid', 'MD', 1),
(3002, 195, 'Malaga', 'MA', 1),
(3003, 195, 'Melilla', 'ML', 1),
(3004, 195, 'Murcia', 'MU', 1),
(3005, 195, 'Navarra', 'NV', 1),
(3006, 195, 'Ourense', 'OU', 1),
(3007, 195, 'Palencia', 'PL', 1),
(3008, 195, 'Pontevedra', 'PO', 1),
(3009, 195, 'Salamanca', 'SL', 1),
(3010, 195, 'Santa Cruz de Tenerife', 'SC', 1),
(3011, 195, 'Segovia', 'SG', 1),
(3012, 195, 'Sevilla', 'SV', 1),
(3013, 195, 'Soria', 'SO', 1),
(3014, 195, 'Tarragona', 'TA', 1),
(3015, 195, 'Teruel', 'TE', 1),
(3016, 195, 'Toledo', 'TO', 1),
(3017, 195, 'Valencia', 'VC', 1),
(3018, 195, 'Valladolid', 'VD', 1),
(3019, 195, 'Vizcaya', 'VZ', 1),
(3020, 195, 'Zamora', 'ZM', 1),
(3021, 195, 'Zaragoza', 'ZR', 1),
(3022, 196, 'Central', 'CE', 1),
(3023, 196, 'Eastern', 'EA', 1),
(3024, 196, 'North Central', 'NC', 1),
(3025, 196, 'Northern', 'NO', 1),
(3026, 196, 'North Western', 'NW', 1),
(3027, 196, 'Sabaragamuwa', 'SA', 1),
(3028, 196, 'Southern', 'SO', 1),
(3029, 196, 'Uva', 'UV', 1),
(3030, 196, 'Western', 'WE', 1),
(3032, 197, 'Saint Helena', 'S', 1),
(3034, 199, 'A\'ali an Nil', 'ANL', 1),
(3035, 199, 'Al Bahr al Ahmar', 'BAM', 1),
(3036, 199, 'Al Buhayrat', 'BRT', 1),
(3037, 199, 'Al Jazirah', 'JZR', 1),
(3038, 199, 'Al Khartum', 'KRT', 1),
(3039, 199, 'Al Qadarif', 'QDR', 1),
(3040, 199, 'Al Wahdah', 'WDH', 1),
(3041, 199, 'An Nil al Abyad', 'ANB', 1),
(3042, 199, 'An Nil al Azraq', 'ANZ', 1),
(3043, 199, 'Ash Shamaliyah', 'ASH', 1),
(3044, 199, 'Bahr al Jabal', 'BJA', 1),
(3045, 199, 'Gharb al Istiwa\'iyah', 'GIS', 1),
(3046, 199, 'Gharb Bahr al Ghazal', 'GBG', 1),
(3047, 199, 'Gharb Darfur', 'GDA', 1),
(3048, 199, 'Gharb Kurdufan', 'GKU', 1),
(3049, 199, 'Janub Darfur', 'JDA', 1),
(3050, 199, 'Janub Kurdufan', 'JKU', 1),
(3051, 199, 'Junqali', 'JQL', 1),
(3052, 199, 'Kassala', 'KSL', 1),
(3053, 199, 'Nahr an Nil', 'NNL', 1),
(3054, 199, 'Shamal Bahr al Ghazal', 'SBG', 1),
(3055, 199, 'Shamal Darfur', 'SDA', 1),
(3056, 199, 'Shamal Kurdufan', 'SKU', 1),
(3057, 199, 'Sharq al Istiwa\'iyah', 'SIS', 1),
(3058, 199, 'Sinnar', 'SNR', 1),
(3059, 199, 'Warab', 'WRB', 1),
(3060, 200, 'Brokopondo', 'BR', 1),
(3061, 200, 'Commewijne', 'CM', 1),
(3062, 200, 'Coronie', 'CR', 1),
(3063, 200, 'Marowijne', 'MA', 1),
(3064, 200, 'Nickerie', 'NI', 1),
(3065, 200, 'Para', 'PA', 1),
(3066, 200, 'Paramaribo', 'PM', 1),
(3067, 200, 'Saramacca', 'SA', 1),
(3068, 200, 'Sipaliwini', 'SI', 1),
(3069, 200, 'Wanica', 'WA', 1),
(3070, 202, 'Hhohho', 'H', 1),
(3071, 202, 'Lubombo', 'L', 1),
(3072, 202, 'Manzini', 'M', 1),
(3073, 202, 'Shishelweni', 'S', 1),
(3074, 203, 'Blekinge', 'K', 1),
(3075, 203, 'Dalarna', 'W', 1),
(3076, 203, 'Gävleborg', 'X', 1),
(3077, 203, 'Gotland', 'I', 1),
(3078, 203, 'Halland', 'N', 1),
(3079, 203, 'Jämtland', 'Z', 1),
(3080, 203, 'Jönköping', 'F', 1),
(3081, 203, 'Kalmar', 'H', 1),
(3082, 203, 'Kronoberg', 'G', 1),
(3083, 203, 'Norrbotten', 'BD', 1),
(3084, 203, 'Örebro', 'T', 1),
(3085, 203, 'Östergötland', 'E', 1),
(3086, 203, 'Sk&aring;ne', 'M', 1),
(3087, 203, 'Södermanland', 'D', 1),
(3088, 203, 'Stockholm', 'AB', 1),
(3089, 203, 'Uppsala', 'C', 1),
(3090, 203, 'Värmland', 'S', 1),
(3091, 203, 'Västerbotten', 'AC', 1),
(3092, 203, 'Västernorrland', 'Y', 1),
(3093, 203, 'Västmanland', 'U', 1),
(3094, 203, 'Västra Götaland', 'O', 1),
(3095, 204, 'Aargau', 'AG', 1),
(3096, 204, 'Appenzell Ausserrhoden', 'AR', 1),
(3097, 204, 'Appenzell Innerrhoden', 'AI', 1),
(3098, 204, 'Basel-Stadt', 'BS', 1),
(3099, 204, 'Basel-Landschaft', 'BL', 1),
(3100, 204, 'Bern', 'BE', 1),
(3101, 204, 'Fribourg', 'FR', 1),
(3102, 204, 'Gen&egrave;ve', 'GE', 1),
(3103, 204, 'Glarus', 'GL', 1),
(3104, 204, 'Graubünden', 'GR', 1),
(3105, 204, 'Jura', 'JU', 1),
(3106, 204, 'Luzern', 'LU', 1),
(3107, 204, 'Neuch&acirc;tel', 'NE', 1),
(3108, 204, 'Nidwald', 'NW', 1),
(3109, 204, 'Obwald', 'OW', 1),
(3110, 204, 'St. Gallen', 'SG', 1),
(3111, 204, 'Schaffhausen', 'SH', 1),
(3112, 204, 'Schwyz', 'SZ', 1),
(3113, 204, 'Solothurn', 'SO', 1),
(3114, 204, 'Thurgau', 'TG', 1),
(3115, 204, 'Ticino', 'TI', 1),
(3116, 204, 'Uri', 'UR', 1),
(3117, 204, 'Valais', 'VS', 1),
(3118, 204, 'Vaud', 'VD', 1),
(3119, 204, 'Zug', 'ZG', 1),
(3120, 204, 'Zürich', 'ZH', 1),
(3121, 205, 'Al Hasakah', 'HA', 1),
(3122, 205, 'Al Ladhiqiyah', 'LA', 1),
(3123, 205, 'Al Qunaytirah', 'QU', 1),
(3124, 205, 'Ar Raqqah', 'RQ', 1),
(3125, 205, 'As Suwayda', 'SU', 1),
(3126, 205, 'Dara', 'DA', 1),
(3127, 205, 'Dayr az Zawr', 'DZ', 1),
(3128, 205, 'Dimashq', 'DI', 1),
(3129, 205, 'Halab', 'HL', 1),
(3130, 205, 'Hamah', 'HM', 1),
(3131, 205, 'Hims', 'HI', 1),
(3132, 205, 'Idlib', 'ID', 1),
(3133, 205, 'Rif Dimashq', 'RD', 1),
(3134, 205, 'Tartus', 'TA', 1),
(3135, 206, 'Chang-hua', 'CH', 1),
(3136, 206, 'Chia-i', 'CI', 1);
INSERT INTO `oc_zone` (`zone_id`, `country_id`, `name`, `code`, `status`) VALUES
(3137, 206, 'Hsin-chu', 'HS', 1),
(3138, 206, 'Hua-lien', 'HL', 1),
(3139, 206, 'I-lan', 'IL', 1),
(3140, 206, 'Kao-hsiung county', 'KH', 1),
(3141, 206, 'Kin-men', 'KM', 1),
(3142, 206, 'Lien-chiang', 'LC', 1),
(3143, 206, 'Miao-li', 'ML', 1),
(3144, 206, 'Nan-t\'ou', 'NT', 1),
(3145, 206, 'P\'eng-hu', 'PH', 1),
(3146, 206, 'P\'ing-tung', 'PT', 1),
(3147, 206, 'T\'ai-chung', 'TG', 1),
(3148, 206, 'T\'ai-nan', 'TA', 1),
(3149, 206, 'T\'ai-pei county', 'TP', 1),
(3150, 206, 'T\'ai-tung', 'TT', 1),
(3151, 206, 'T\'ao-yuan', 'TY', 1),
(3152, 206, 'Yun-lin', 'YL', 1),
(3153, 206, 'Chia-i city', 'CC', 1),
(3154, 206, 'Chi-lung', 'CL', 1),
(3155, 206, 'Hsin-chu', 'HC', 1),
(3156, 206, 'T\'ai-chung', 'TH', 1),
(3157, 206, 'T\'ai-nan', 'TN', 1),
(3158, 206, 'Kao-hsiung city', 'KC', 1),
(3159, 206, 'T\'ai-pei city', 'TC', 1),
(3160, 207, 'Gorno-Badakhstan', 'GB', 1),
(3161, 207, 'Khatlon', 'KT', 1),
(3162, 207, 'Sughd', 'SU', 1),
(3163, 208, 'Arusha', 'AR', 1),
(3164, 208, 'Dar es Salaam', 'DS', 1),
(3165, 208, 'Dodoma', 'DO', 1),
(3166, 208, 'Iringa', 'IR', 1),
(3167, 208, 'Kagera', 'KA', 1),
(3168, 208, 'Kigoma', 'KI', 1),
(3169, 208, 'Kilimanjaro', 'KJ', 1),
(3170, 208, 'Lindi', 'LN', 1),
(3171, 208, 'Manyara', 'MY', 1),
(3172, 208, 'Mara', 'MR', 1),
(3173, 208, 'Mbeya', 'MB', 1),
(3174, 208, 'Morogoro', 'MO', 1),
(3175, 208, 'Mtwara', 'MT', 1),
(3176, 208, 'Mwanza', 'MW', 1),
(3177, 208, 'Pemba North', 'PN', 1),
(3178, 208, 'Pemba South', 'PS', 1),
(3179, 208, 'Pwani', 'PW', 1),
(3180, 208, 'Rukwa', 'RK', 1),
(3181, 208, 'Ruvuma', 'RV', 1),
(3182, 208, 'Shinyanga', 'SH', 1),
(3183, 208, 'Singida', 'SI', 1),
(3184, 208, 'Tabora', 'TB', 1),
(3185, 208, 'Tanga', 'TN', 1),
(3186, 208, 'Zanzibar Central/South', 'ZC', 1),
(3187, 208, 'Zanzibar North', 'ZN', 1),
(3188, 208, 'Zanzibar Urban/West', 'ZU', 1),
(3189, 209, 'Amnat Charoen', 'Amnat Charoen', 1),
(3190, 209, 'Ang Thong', 'Ang Thong', 1),
(3191, 209, 'Ayutthaya', 'Ayutthaya', 1),
(3192, 209, 'Bangkok', 'Bangkok', 1),
(3193, 209, 'Buriram', 'Buriram', 1),
(3194, 209, 'Chachoengsao', 'Chachoengsao', 1),
(3195, 209, 'Chai Nat', 'Chai Nat', 1),
(3196, 209, 'Chaiyaphum', 'Chaiyaphum', 1),
(3197, 209, 'Chanthaburi', 'Chanthaburi', 1),
(3198, 209, 'Chiang Mai', 'Chiang Mai', 1),
(3199, 209, 'Chiang Rai', 'Chiang Rai', 1),
(3200, 209, 'Chon Buri', 'Chon Buri', 1),
(3201, 209, 'Chumphon', 'Chumphon', 1),
(3202, 209, 'Kalasin', 'Kalasin', 1),
(3203, 209, 'Kamphaeng Phet', 'Kamphaeng Phet', 1),
(3204, 209, 'Kanchanaburi', 'Kanchanaburi', 1),
(3205, 209, 'Khon Kaen', 'Khon Kaen', 1),
(3206, 209, 'Krabi', 'Krabi', 1),
(3207, 209, 'Lampang', 'Lampang', 1),
(3208, 209, 'Lamphun', 'Lamphun', 1),
(3209, 209, 'Loei', 'Loei', 1),
(3210, 209, 'Lop Buri', 'Lop Buri', 1),
(3211, 209, 'Mae Hong Son', 'Mae Hong Son', 1),
(3212, 209, 'Maha Sarakham', 'Maha Sarakham', 1),
(3213, 209, 'Mukdahan', 'Mukdahan', 1),
(3214, 209, 'Nakhon Nayok', 'Nakhon Nayok', 1),
(3215, 209, 'Nakhon Pathom', 'Nakhon Pathom', 1),
(3216, 209, 'Nakhon Phanom', 'Nakhon Phanom', 1),
(3217, 209, 'Nakhon Ratchasima', 'Nakhon Ratchasima', 1),
(3218, 209, 'Nakhon Sawan', 'Nakhon Sawan', 1),
(3219, 209, 'Nakhon Si Thammarat', 'Nakhon Si Thammarat', 1),
(3220, 209, 'Nan', 'Nan', 1),
(3221, 209, 'Narathiwat', 'Narathiwat', 1),
(3222, 209, 'Nong Bua Lamphu', 'Nong Bua Lamphu', 1),
(3223, 209, 'Nong Khai', 'Nong Khai', 1),
(3224, 209, 'Nonthaburi', 'Nonthaburi', 1),
(3225, 209, 'Pathum Thani', 'Pathum Thani', 1),
(3226, 209, 'Pattani', 'Pattani', 1),
(3227, 209, 'Phangnga', 'Phangnga', 1),
(3228, 209, 'Phatthalung', 'Phatthalung', 1),
(3229, 209, 'Phayao', 'Phayao', 1),
(3230, 209, 'Phetchabun', 'Phetchabun', 1),
(3231, 209, 'Phetchaburi', 'Phetchaburi', 1),
(3232, 209, 'Phichit', 'Phichit', 1),
(3233, 209, 'Phitsanulok', 'Phitsanulok', 1),
(3234, 209, 'Phrae', 'Phrae', 1),
(3235, 209, 'Phuket', 'Phuket', 1),
(3236, 209, 'Prachin Buri', 'Prachin Buri', 1),
(3237, 209, 'Prachuap Khiri Khan', 'Prachuap Khiri Khan', 1),
(3238, 209, 'Ranong', 'Ranong', 1),
(3239, 209, 'Ratchaburi', 'Ratchaburi', 1),
(3240, 209, 'Rayong', 'Rayong', 1),
(3241, 209, 'Roi Et', 'Roi Et', 1),
(3242, 209, 'Sa Kaeo', 'Sa Kaeo', 1),
(3243, 209, 'Sakon Nakhon', 'Sakon Nakhon', 1),
(3244, 209, 'Samut Prakan', 'Samut Prakan', 1),
(3245, 209, 'Samut Sakhon', 'Samut Sakhon', 1),
(3246, 209, 'Samut Songkhram', 'Samut Songkhram', 1),
(3247, 209, 'Sara Buri', 'Sara Buri', 1),
(3248, 209, 'Satun', 'Satun', 1),
(3249, 209, 'Sing Buri', 'Sing Buri', 1),
(3250, 209, 'Sisaket', 'Sisaket', 1),
(3251, 209, 'Songkhla', 'Songkhla', 1),
(3252, 209, 'Sukhothai', 'Sukhothai', 1),
(3253, 209, 'Suphan Buri', 'Suphan Buri', 1),
(3254, 209, 'Surat Thani', 'Surat Thani', 1),
(3255, 209, 'Surin', 'Surin', 1),
(3256, 209, 'Tak', 'Tak', 1),
(3257, 209, 'Trang', 'Trang', 1),
(3258, 209, 'Trat', 'Trat', 1),
(3259, 209, 'Ubon Ratchathani', 'Ubon Ratchathani', 1),
(3260, 209, 'Udon Thani', 'Udon Thani', 1),
(3261, 209, 'Uthai Thani', 'Uthai Thani', 1),
(3262, 209, 'Uttaradit', 'Uttaradit', 1),
(3263, 209, 'Yala', 'Yala', 1),
(3264, 209, 'Yasothon', 'Yasothon', 1),
(3265, 210, 'Kara', 'K', 1),
(3266, 210, 'Plateaux', 'P', 1),
(3267, 210, 'Savanes', 'S', 1),
(3268, 210, 'Centrale', 'C', 1),
(3269, 210, 'Maritime', 'M', 1),
(3270, 211, 'Atafu', 'A', 1),
(3271, 211, 'Fakaofo', 'F', 1),
(3272, 211, 'Nukunonu', 'N', 1),
(3273, 212, 'Ha\'apai', 'H', 1),
(3274, 212, 'Tongatapu', 'T', 1),
(3275, 212, 'Vava\'u', 'V', 1),
(3276, 213, 'Couva/Tabaquite/Talparo', 'CT', 1),
(3277, 213, 'Diego Martin', 'DM', 1),
(3278, 213, 'Mayaro/Rio Claro', 'MR', 1),
(3279, 213, 'Penal/Debe', 'PD', 1),
(3280, 213, 'Princes Town', 'PT', 1),
(3281, 213, 'Sangre Grande', 'SG', 1),
(3282, 213, 'San Juan/Laventille', 'SL', 1),
(3283, 213, 'Siparia', 'SI', 1),
(3284, 213, 'Tunapuna/Piarco', 'TP', 1),
(3285, 213, 'Port of Spain', 'PS', 1),
(3286, 213, 'San Fernando', 'SF', 1),
(3287, 213, 'Arima', 'AR', 1),
(3288, 213, 'Point Fortin', 'PF', 1),
(3289, 213, 'Chaguanas', 'CH', 1),
(3290, 213, 'Tobago', 'TO', 1),
(3291, 214, 'Ariana', 'AR', 1),
(3292, 214, 'Beja', 'BJ', 1),
(3293, 214, 'Ben Arous', 'BA', 1),
(3294, 214, 'Bizerte', 'BI', 1),
(3295, 214, 'Gabes', 'GB', 1),
(3296, 214, 'Gafsa', 'GF', 1),
(3297, 214, 'Jendouba', 'JE', 1),
(3298, 214, 'Kairouan', 'KR', 1),
(3299, 214, 'Kasserine', 'KS', 1),
(3300, 214, 'Kebili', 'KB', 1),
(3301, 214, 'Kef', 'KF', 1),
(3302, 214, 'Mahdia', 'MH', 1),
(3303, 214, 'Manouba', 'MN', 1),
(3304, 214, 'Medenine', 'ME', 1),
(3305, 214, 'Monastir', 'MO', 1),
(3306, 214, 'Nabeul', 'NA', 1),
(3307, 214, 'Sfax', 'SF', 1),
(3308, 214, 'Sidi', 'SD', 1),
(3309, 214, 'Siliana', 'SL', 1),
(3310, 214, 'Sousse', 'SO', 1),
(3311, 214, 'Tataouine', 'TA', 1),
(3312, 214, 'Tozeur', 'TO', 1),
(3313, 214, 'Tunis', 'TU', 1),
(3314, 214, 'Zaghouan', 'ZA', 1),
(3315, 215, 'Adana', 'ADA', 1),
(3316, 215, 'Adıyaman', 'ADI', 1),
(3317, 215, 'Afyonkarahisar', 'AFY', 1),
(3318, 215, 'Ağrı', 'AGR', 1),
(3319, 215, 'Aksaray', 'AKS', 1),
(3320, 215, 'Amasya', 'AMA', 1),
(3321, 215, 'Ankara', 'ANK', 1),
(3322, 215, 'Antalya', 'ANT', 1),
(3323, 215, 'Ardahan', 'ARD', 1),
(3324, 215, 'Artvin', 'ART', 1),
(3325, 215, 'Aydın', 'AYI', 1),
(3326, 215, 'Balıkesir', 'BAL', 1),
(3327, 215, 'Bartın', 'BAR', 1),
(3328, 215, 'Batman', 'BAT', 1),
(3329, 215, 'Bayburt', 'BAY', 1),
(3330, 215, 'Bilecik', 'BIL', 1),
(3331, 215, 'Bingöl', 'BIN', 1),
(3332, 215, 'Bitlis', 'BIT', 1),
(3333, 215, 'Bolu', 'BOL', 1),
(3334, 215, 'Burdur', 'BRD', 1),
(3335, 215, 'Bursa', 'BRS', 1),
(3336, 215, 'Çanakkale', 'CKL', 1),
(3337, 215, 'Çankırı', 'CKR', 1),
(3338, 215, 'Çorum', 'COR', 1),
(3339, 215, 'Denizli', 'DEN', 1),
(3340, 215, 'Diyarbakır', 'DIY', 1),
(3341, 215, 'Düzce', 'DUZ', 1),
(3342, 215, 'Edirne', 'EDI', 1),
(3343, 215, 'Elazığ', 'ELA', 1),
(3344, 215, 'Erzincan', 'EZC', 1),
(3345, 215, 'Erzurum', 'EZR', 1),
(3346, 215, 'Eskişehir', 'ESK', 1),
(3347, 215, 'Gaziantep', 'GAZ', 1),
(3348, 215, 'Giresun', 'GIR', 1),
(3349, 215, 'Gümüşhane', 'GMS', 1),
(3350, 215, 'Hakkari', 'HKR', 1),
(3351, 215, 'Hatay', 'HTY', 1),
(3352, 215, 'Iğdır', 'IGD', 1),
(3353, 215, 'Isparta', 'ISP', 1),
(3354, 215, 'İstanbul', 'IST', 1),
(3355, 215, 'İzmir', 'IZM', 1),
(3356, 215, 'Kahramanmaraş', 'KAH', 1),
(3357, 215, 'Karabük', 'KRB', 1),
(3358, 215, 'Karaman', 'KRM', 1),
(3359, 215, 'Kars', 'KRS', 1),
(3360, 215, 'Kastamonu', 'KAS', 1),
(3361, 215, 'Kayseri', 'KAY', 1),
(3362, 215, 'Kilis', 'KLS', 1),
(3363, 215, 'Kırıkkale', 'KRK', 1),
(3364, 215, 'Kırklareli', 'KLR', 1),
(3365, 215, 'Kırşehir', 'KRH', 1),
(3366, 215, 'Kocaeli', 'KOC', 1),
(3367, 215, 'Konya', 'KON', 1),
(3368, 215, 'Kütahya', 'KUT', 1),
(3369, 215, 'Malatya', 'MAL', 1),
(3370, 215, 'Manisa', 'MAN', 1),
(3371, 215, 'Mardin', 'MAR', 1),
(3372, 215, 'Mersin', 'MER', 1),
(3373, 215, 'Muğla', 'MUG', 1),
(3374, 215, 'Muş', 'MUS', 1),
(3375, 215, 'Nevşehir', 'NEV', 1),
(3376, 215, 'Niğde', 'NIG', 1),
(3377, 215, 'Ordu', 'ORD', 1),
(3378, 215, 'Osmaniye', 'OSM', 1),
(3379, 215, 'Rize', 'RIZ', 1),
(3380, 215, 'Sakarya', 'SAK', 1),
(3381, 215, 'Samsun', 'SAM', 1),
(3382, 215, 'Şanlıurfa', 'SAN', 1),
(3383, 215, 'Siirt', 'SII', 1),
(3384, 215, 'Sinop', 'SIN', 1),
(3385, 215, 'Şırnak', 'SIR', 1),
(3386, 215, 'Sivas', 'SIV', 1),
(3387, 215, 'Tekirdağ', 'TEL', 1),
(3388, 215, 'Tokat', 'TOK', 1),
(3389, 215, 'Trabzon', 'TRA', 1),
(3390, 215, 'Tunceli', 'TUN', 1),
(3391, 215, 'Uşak', 'USK', 1),
(3392, 215, 'Van', 'VAN', 1),
(3393, 215, 'Yalova', 'YAL', 1),
(3394, 215, 'Yozgat', 'YOZ', 1),
(3395, 215, 'Zonguldak', 'ZON', 1),
(3396, 216, 'Ahal Welayaty', 'A', 1),
(3397, 216, 'Balkan Welayaty', 'B', 1),
(3398, 216, 'Dashhowuz Welayaty', 'D', 1),
(3399, 216, 'Lebap Welayaty', 'L', 1),
(3400, 216, 'Mary Welayaty', 'M', 1),
(3401, 217, 'Ambergris Cays', 'AC', 1),
(3402, 217, 'Dellis Cay', 'DC', 1),
(3403, 217, 'French Cay', 'FC', 1),
(3404, 217, 'Little Water Cay', 'LW', 1),
(3405, 217, 'Parrot Cay', 'RC', 1),
(3406, 217, 'Pine Cay', 'PN', 1),
(3407, 217, 'Salt Cay', 'SL', 1),
(3408, 217, 'Grand Turk', 'GT', 1),
(3409, 217, 'South Caicos', 'SC', 1),
(3410, 217, 'East Caicos', 'EC', 1),
(3411, 217, 'Middle Caicos', 'MC', 1),
(3412, 217, 'North Caicos', 'NC', 1),
(3413, 217, 'Providenciales', 'PR', 1),
(3414, 217, 'West Caicos', 'WC', 1),
(3415, 218, 'Nanumanga', 'NMG', 1),
(3416, 218, 'Niulakita', 'NLK', 1),
(3417, 218, 'Niutao', 'NTO', 1),
(3418, 218, 'Funafuti', 'FUN', 1),
(3419, 218, 'Nanumea', 'NME', 1),
(3420, 218, 'Nui', 'NUI', 1),
(3421, 218, 'Nukufetau', 'NFT', 1),
(3422, 218, 'Nukulaelae', 'NLL', 1),
(3423, 218, 'Vaitupu', 'VAI', 1),
(3424, 219, 'Kalangala', 'KAL', 1),
(3425, 219, 'Kampala', 'KMP', 1),
(3426, 219, 'Kayunga', 'KAY', 1),
(3427, 219, 'Kiboga', 'KIB', 1),
(3428, 219, 'Luwero', 'LUW', 1),
(3429, 219, 'Masaka', 'MAS', 1),
(3430, 219, 'Mpigi', 'MPI', 1),
(3431, 219, 'Mubende', 'MUB', 1),
(3432, 219, 'Mukono', 'MUK', 1),
(3433, 219, 'Nakasongola', 'NKS', 1),
(3434, 219, 'Rakai', 'RAK', 1),
(3435, 219, 'Sembabule', 'SEM', 1),
(3436, 219, 'Wakiso', 'WAK', 1),
(3437, 219, 'Bugiri', 'BUG', 1),
(3438, 219, 'Busia', 'BUS', 1),
(3439, 219, 'Iganga', 'IGA', 1),
(3440, 219, 'Jinja', 'JIN', 1),
(3441, 219, 'Kaberamaido', 'KAB', 1),
(3442, 219, 'Kamuli', 'KML', 1),
(3443, 219, 'Kapchorwa', 'KPC', 1),
(3444, 219, 'Katakwi', 'KTK', 1),
(3445, 219, 'Kumi', 'KUM', 1),
(3446, 219, 'Mayuge', 'MAY', 1),
(3447, 219, 'Mbale', 'MBA', 1),
(3448, 219, 'Pallisa', 'PAL', 1),
(3449, 219, 'Sironko', 'SIR', 1),
(3450, 219, 'Soroti', 'SOR', 1),
(3451, 219, 'Tororo', 'TOR', 1),
(3452, 219, 'Adjumani', 'ADJ', 1),
(3453, 219, 'Apac', 'APC', 1),
(3454, 219, 'Arua', 'ARU', 1),
(3455, 219, 'Gulu', 'GUL', 1),
(3456, 219, 'Kitgum', 'KIT', 1),
(3457, 219, 'Kotido', 'KOT', 1),
(3458, 219, 'Lira', 'LIR', 1),
(3459, 219, 'Moroto', 'MRT', 1),
(3460, 219, 'Moyo', 'MOY', 1),
(3461, 219, 'Nakapiripirit', 'NAK', 1),
(3462, 219, 'Nebbi', 'NEB', 1),
(3463, 219, 'Pader', 'PAD', 1),
(3464, 219, 'Yumbe', 'YUM', 1),
(3465, 219, 'Bundibugyo', 'BUN', 1),
(3466, 219, 'Bushenyi', 'BSH', 1),
(3467, 219, 'Hoima', 'HOI', 1),
(3468, 219, 'Kabale', 'KBL', 1),
(3469, 219, 'Kabarole', 'KAR', 1),
(3470, 219, 'Kamwenge', 'KAM', 1),
(3471, 219, 'Kanungu', 'KAN', 1),
(3472, 219, 'Kasese', 'KAS', 1),
(3473, 219, 'Kibaale', 'KBA', 1),
(3474, 219, 'Kisoro', 'KIS', 1),
(3475, 219, 'Kyenjojo', 'KYE', 1),
(3476, 219, 'Masindi', 'MSN', 1),
(3477, 219, 'Mbarara', 'MBR', 1),
(3478, 219, 'Ntungamo', 'NTU', 1),
(3479, 219, 'Rukungiri', 'RUK', 1),
(3480, 220, 'Cherkas\'ka Oblast\'', '71', 1),
(3481, 220, 'Chernihivs\'ka Oblast\'', '74', 1),
(3482, 220, 'Chernivets\'ka Oblast\'', '77', 1),
(3483, 220, 'Crimea', '43', 1),
(3484, 220, 'Dnipropetrovs\'ka Oblast\'', '12', 1),
(3485, 220, 'Donets\'ka Oblast\'', '14', 1),
(3486, 220, 'Ivano-Frankivs\'ka Oblast\'', '26', 1),
(3487, 220, 'Khersons\'ka Oblast\'', '65', 1),
(3488, 220, 'Khmel\'nyts\'ka Oblast\'', '68', 1),
(3489, 220, 'Kirovohrads\'ka Oblast\'', '35', 1),
(3490, 220, 'Kyiv', '30', 1),
(3491, 220, 'Kyivs\'ka Oblast\'', '32', 1),
(3492, 220, 'Luhans\'ka Oblast\'', '09', 1),
(3493, 220, 'L\'vivs\'ka Oblast\'', '46', 1),
(3494, 220, 'Mykolayivs\'ka Oblast\'', '48', 1),
(3495, 220, 'Odes\'ka Oblast\'', '51', 1),
(3496, 220, 'Poltavs\'ka Oblast\'', '53', 1),
(3497, 220, 'Rivnens\'ka Oblast\'', '56', 1),
(3498, 220, 'Sevastopol\'', '40', 1),
(3499, 220, 'Sums\'ka Oblast\'', '59', 1),
(3500, 220, 'Ternopil\'s\'ka Oblast\'', '61', 1),
(3501, 220, 'Vinnyts\'ka Oblast\'', '05', 1),
(3502, 220, 'Volyns\'ka Oblast\'', '07', 1),
(3503, 220, 'Zakarpats\'ka Oblast\'', '21', 1),
(3504, 220, 'Zaporiz\'ka Oblast\'', '23', 1),
(3505, 220, 'Zhytomyrs\'ka oblast\'', '18', 1),
(3506, 221, 'Abu Dhabi', 'ADH', 1),
(3507, 221, '\'Ajman', 'AJ', 1),
(3508, 221, 'Al Fujayrah', 'FU', 1),
(3509, 221, 'Ash Shariqah', 'SH', 1),
(3510, 221, 'Dubai', 'DU', 1),
(3511, 221, 'R\'as al Khaymah', 'RK', 1),
(3512, 221, 'Umm al Qaywayn', 'UQ', 1),
(3513, 222, 'Aberdeen', 'ABN', 1),
(3514, 222, 'Aberdeenshire', 'ABNS', 1),
(3515, 222, 'Anglesey', 'ANG', 1),
(3516, 222, 'Angus', 'AGS', 1),
(3517, 222, 'Argyll and Bute', 'ARY', 1),
(3518, 222, 'Bedfordshire', 'BEDS', 1),
(3519, 222, 'Berkshire', 'BERKS', 1),
(3520, 222, 'Blaenau Gwent', 'BLA', 1),
(3521, 222, 'Bridgend', 'BRI', 1),
(3522, 222, 'Bristol', 'BSTL', 1),
(3523, 222, 'Buckinghamshire', 'BUCKS', 1),
(3524, 222, 'Caerphilly', 'CAE', 1),
(3525, 222, 'Cambridgeshire', 'CAMBS', 1),
(3526, 222, 'Cardiff', 'CDF', 1),
(3527, 222, 'Carmarthenshire', 'CARM', 1),
(3528, 222, 'Ceredigion', 'CDGN', 1),
(3529, 222, 'Cheshire', 'CHES', 1),
(3530, 222, 'Clackmannanshire', 'CLACK', 1),
(3531, 222, 'Conwy', 'CON', 1),
(3532, 222, 'Cornwall', 'CORN', 1),
(3533, 222, 'Denbighshire', 'DNBG', 1),
(3534, 222, 'Derbyshire', 'DERBY', 1),
(3535, 222, 'Devon', 'DVN', 1),
(3536, 222, 'Dorset', 'DOR', 1),
(3537, 222, 'Dumfries and Galloway', 'DGL', 1),
(3538, 222, 'Dundee', 'DUND', 1),
(3539, 222, 'Durham', 'DHM', 1),
(3540, 222, 'East Ayrshire', 'ARYE', 1),
(3541, 222, 'East Dunbartonshire', 'DUNBE', 1),
(3542, 222, 'East Lothian', 'LOTE', 1),
(3543, 222, 'East Renfrewshire', 'RENE', 1),
(3544, 222, 'East Riding of Yorkshire', 'ERYS', 1),
(3545, 222, 'East Sussex', 'SXE', 1),
(3546, 222, 'Edinburgh', 'EDIN', 1),
(3547, 222, 'Essex', 'ESX', 1),
(3548, 222, 'Falkirk', 'FALK', 1),
(3549, 222, 'Fife', 'FFE', 1),
(3550, 222, 'Flintshire', 'FLINT', 1),
(3551, 222, 'Glasgow', 'GLAS', 1),
(3552, 222, 'Gloucestershire', 'GLOS', 1),
(3553, 222, 'Greater London', 'LDN', 1),
(3554, 222, 'Greater Manchester', 'MCH', 1),
(3555, 222, 'Gwynedd', 'GDD', 1),
(3556, 222, 'Hampshire', 'HANTS', 1),
(3557, 222, 'Herefordshire', 'HWR', 1),
(3558, 222, 'Hertfordshire', 'HERTS', 1),
(3559, 222, 'Highlands', 'HLD', 1),
(3560, 222, 'Inverclyde', 'IVER', 1),
(3561, 222, 'Isle of Wight', 'IOW', 1),
(3562, 222, 'Kent', 'KNT', 1),
(3563, 222, 'Lancashire', 'LANCS', 1),
(3564, 222, 'Leicestershire', 'LEICS', 1),
(3565, 222, 'Lincolnshire', 'LINCS', 1),
(3566, 222, 'Merseyside', 'MSY', 1),
(3567, 222, 'Merthyr Tydfil', 'MERT', 1),
(3568, 222, 'Midlothian', 'MLOT', 1),
(3569, 222, 'Monmouthshire', 'MMOUTH', 1),
(3570, 222, 'Moray', 'MORAY', 1),
(3571, 222, 'Neath Port Talbot', 'NPRTAL', 1),
(3572, 222, 'Newport', 'NEWPT', 1),
(3573, 222, 'Norfolk', 'NOR', 1),
(3574, 222, 'North Ayrshire', 'ARYN', 1),
(3575, 222, 'North Lanarkshire', 'LANN', 1),
(3576, 222, 'North Yorkshire', 'YSN', 1),
(3577, 222, 'Northamptonshire', 'NHM', 1),
(3578, 222, 'Northumberland', 'NLD', 1),
(3579, 222, 'Nottinghamshire', 'NOT', 1),
(3580, 222, 'Orkney Islands', 'ORK', 1),
(3581, 222, 'Oxfordshire', 'OFE', 1),
(3582, 222, 'Pembrokeshire', 'PEM', 1),
(3583, 222, 'Perth and Kinross', 'PERTH', 1),
(3584, 222, 'Powys', 'PWS', 1),
(3585, 222, 'Renfrewshire', 'REN', 1),
(3586, 222, 'Rhondda Cynon Taff', 'RHON', 1),
(3587, 222, 'Rutland', 'RUT', 1),
(3588, 222, 'Scottish Borders', 'BOR', 1),
(3589, 222, 'Shetland Islands', 'SHET', 1),
(3590, 222, 'Shropshire', 'SPE', 1),
(3591, 222, 'Somerset', 'SOM', 1),
(3592, 222, 'South Ayrshire', 'ARYS', 1),
(3593, 222, 'South Lanarkshire', 'LANS', 1),
(3594, 222, 'South Yorkshire', 'YSS', 1),
(3595, 222, 'Staffordshire', 'SFD', 1),
(3596, 222, 'Stirling', 'STIR', 1),
(3597, 222, 'Suffolk', 'SFK', 1),
(3598, 222, 'Surrey', 'SRY', 1),
(3599, 222, 'Swansea', 'SWAN', 1),
(3600, 222, 'Torfaen', 'TORF', 1),
(3601, 222, 'Tyne and Wear', 'TWR', 1),
(3602, 222, 'Vale of Glamorgan', 'VGLAM', 1),
(3603, 222, 'Warwickshire', 'WARKS', 1),
(3604, 222, 'West Dunbartonshire', 'WDUN', 1),
(3605, 222, 'West Lothian', 'WLOT', 1),
(3606, 222, 'West Midlands', 'WMD', 1),
(3607, 222, 'West Sussex', 'SXW', 1),
(3608, 222, 'West Yorkshire', 'YSW', 1),
(3609, 222, 'Western Isles', 'WIL', 1),
(3610, 222, 'Wiltshire', 'WLT', 1),
(3611, 222, 'Worcestershire', 'WORCS', 1),
(3612, 222, 'Wrexham', 'WRX', 1),
(3613, 223, 'Alabama', 'AL', 1),
(3614, 223, 'Alaska', 'AK', 1),
(3615, 223, 'American Samoa', 'AS', 1),
(3616, 223, 'Arizona', 'AZ', 1),
(3617, 223, 'Arkansas', 'AR', 1),
(3618, 223, 'Armed Forces Africa', 'AF', 1),
(3619, 223, 'Armed Forces Americas', 'AA', 1),
(3620, 223, 'Armed Forces Canada', 'AC', 1),
(3621, 223, 'Armed Forces Europe', 'AE', 1),
(3622, 223, 'Armed Forces Middle East', 'AM', 1),
(3623, 223, 'Armed Forces Pacific', 'AP', 1),
(3624, 223, 'California', 'CA', 1),
(3625, 223, 'Colorado', 'CO', 1),
(3626, 223, 'Connecticut', 'CT', 1),
(3627, 223, 'Delaware', 'DE', 1),
(3628, 223, 'District of Columbia', 'DC', 1),
(3629, 223, 'Federated States Of Micronesia', 'FM', 1),
(3630, 223, 'Florida', 'FL', 1),
(3631, 223, 'Georgia', 'GA', 1),
(3632, 223, 'Guam', 'GU', 1),
(3633, 223, 'Hawaii', 'HI', 1),
(3634, 223, 'Idaho', 'ID', 1),
(3635, 223, 'Illinois', 'IL', 1),
(3636, 223, 'Indiana', 'IN', 1),
(3637, 223, 'Iowa', 'IA', 1),
(3638, 223, 'Kansas', 'KS', 1),
(3639, 223, 'Kentucky', 'KY', 1),
(3640, 223, 'Louisiana', 'LA', 1),
(3641, 223, 'Maine', 'ME', 1),
(3642, 223, 'Marshall Islands', 'MH', 1),
(3643, 223, 'Maryland', 'MD', 1),
(3644, 223, 'Massachusetts', 'MA', 1),
(3645, 223, 'Michigan', 'MI', 1),
(3646, 223, 'Minnesota', 'MN', 1),
(3647, 223, 'Mississippi', 'MS', 1),
(3648, 223, 'Missouri', 'MO', 1),
(3649, 223, 'Montana', 'MT', 1),
(3650, 223, 'Nebraska', 'NE', 1),
(3651, 223, 'Nevada', 'NV', 1),
(3652, 223, 'New Hampshire', 'NH', 1),
(3653, 223, 'New Jersey', 'NJ', 1),
(3654, 223, 'New Mexico', 'NM', 1),
(3655, 223, 'New York', 'NY', 1),
(3656, 223, 'North Carolina', 'NC', 1),
(3657, 223, 'North Dakota', 'ND', 1),
(3658, 223, 'Northern Mariana Islands', 'MP', 1),
(3659, 223, 'Ohio', 'OH', 1),
(3660, 223, 'Oklahoma', 'OK', 1),
(3661, 223, 'Oregon', 'OR', 1),
(3662, 223, 'Palau', 'PW', 1),
(3663, 223, 'Pennsylvania', 'PA', 1),
(3664, 223, 'Puerto Rico', 'PR', 1),
(3665, 223, 'Rhode Island', 'RI', 1),
(3666, 223, 'South Carolina', 'SC', 1),
(3667, 223, 'South Dakota', 'SD', 1),
(3668, 223, 'Tennessee', 'TN', 1),
(3669, 223, 'Texas', 'TX', 1),
(3670, 223, 'Utah', 'UT', 1),
(3671, 223, 'Vermont', 'VT', 1),
(3672, 223, 'Virgin Islands', 'VI', 1),
(3673, 223, 'Virginia', 'VA', 1),
(3674, 223, 'Washington', 'WA', 1),
(3675, 223, 'West Virginia', 'WV', 1),
(3676, 223, 'Wisconsin', 'WI', 1),
(3677, 223, 'Wyoming', 'WY', 1),
(3678, 224, 'Baker Island', 'BI', 1),
(3679, 224, 'Howland Island', 'HI', 1),
(3680, 224, 'Jarvis Island', 'JI', 1),
(3681, 224, 'Johnston Atoll', 'JA', 1),
(3682, 224, 'Kingman Reef', 'KR', 1),
(3683, 224, 'Midway Atoll', 'MA', 1),
(3684, 224, 'Navassa Island', 'NI', 1),
(3685, 224, 'Palmyra Atoll', 'PA', 1),
(3686, 224, 'Wake Island', 'WI', 1),
(3687, 225, 'Artigas', 'AR', 1),
(3688, 225, 'Canelones', 'CA', 1),
(3689, 225, 'Cerro Largo', 'CL', 1),
(3690, 225, 'Colonia', 'CO', 1),
(3691, 225, 'Durazno', 'DU', 1),
(3692, 225, 'Flores', 'FS', 1),
(3693, 225, 'Florida', 'FA', 1),
(3694, 225, 'Lavalleja', 'LA', 1),
(3695, 225, 'Maldonado', 'MA', 1),
(3696, 225, 'Montevideo', 'MO', 1),
(3697, 225, 'Paysandu', 'PA', 1),
(3698, 225, 'Rio Negro', 'RN', 1),
(3699, 225, 'Rivera', 'RV', 1),
(3700, 225, 'Rocha', 'RO', 1),
(3701, 225, 'Salto', 'SL', 1),
(3702, 225, 'San Jose', 'SJ', 1),
(3703, 225, 'Soriano', 'SO', 1),
(3704, 225, 'Tacuarembo', 'TA', 1),
(3705, 225, 'Treinta y Tres', 'TT', 1),
(3706, 226, 'Andijon', 'AN', 1),
(3707, 226, 'Buxoro', 'BU', 1),
(3708, 226, 'Farg\'ona', 'FA', 1),
(3709, 226, 'Jizzax', 'JI', 1),
(3710, 226, 'Namangan', 'NG', 1),
(3711, 226, 'Navoiy', 'NW', 1),
(3712, 226, 'Qashqadaryo', 'QA', 1),
(3713, 226, 'Qoraqalpog\'iston Republikasi', 'QR', 1),
(3714, 226, 'Samarqand', 'SA', 1),
(3715, 226, 'Sirdaryo', 'SI', 1),
(3716, 226, 'Surxondaryo', 'SU', 1),
(3717, 226, 'Toshkent City', 'TK', 1),
(3718, 226, 'Toshkent Region', 'TO', 1),
(3719, 226, 'Xorazm', 'XO', 1),
(3720, 227, 'Malampa', 'MA', 1),
(3721, 227, 'Penama', 'PE', 1),
(3722, 227, 'Sanma', 'SA', 1),
(3723, 227, 'Shefa', 'SH', 1),
(3724, 227, 'Tafea', 'TA', 1),
(3725, 227, 'Torba', 'TO', 1),
(3726, 229, 'Amazonas', 'AM', 1),
(3727, 229, 'Anzoategui', 'AN', 1),
(3728, 229, 'Apure', 'AP', 1),
(3729, 229, 'Aragua', 'AR', 1),
(3730, 229, 'Barinas', 'BA', 1),
(3731, 229, 'Bolivar', 'BO', 1),
(3732, 229, 'Carabobo', 'CA', 1),
(3733, 229, 'Cojedes', 'CO', 1),
(3734, 229, 'Delta Amacuro', 'DA', 1),
(3735, 229, 'Dependencias Federales', 'DF', 1),
(3736, 229, 'Distrito Federal', 'DI', 1),
(3737, 229, 'Falcon', 'FA', 1),
(3738, 229, 'Guarico', 'GU', 1),
(3739, 229, 'Lara', 'LA', 1),
(3740, 229, 'Merida', 'ME', 1),
(3741, 229, 'Miranda', 'MI', 1),
(3742, 229, 'Monagas', 'MO', 1),
(3743, 229, 'Nueva Esparta', 'NE', 1),
(3744, 229, 'Portuguesa', 'PO', 1),
(3745, 229, 'Sucre', 'SU', 1),
(3746, 229, 'Tachira', 'TA', 1),
(3747, 229, 'Trujillo', 'TR', 1),
(3748, 229, 'Vargas', 'VA', 1),
(3749, 229, 'Yaracuy', 'YA', 1),
(3750, 229, 'Zulia', 'ZU', 1),
(3751, 230, 'An Giang', 'AG', 1),
(3752, 230, 'Bac Giang', 'BG', 1),
(3753, 230, 'Bac Kan', 'BK', 1),
(3754, 230, 'Bac Lieu', 'BL', 1),
(3755, 230, 'Bac Ninh', 'BC', 1),
(3756, 230, 'Ba Ria-Vung Tau', 'BR', 1),
(3757, 230, 'Ben Tre', 'BN', 1),
(3758, 230, 'Binh Dinh', 'BH', 1),
(3759, 230, 'Binh Duong', 'BU', 1),
(3760, 230, 'Binh Phuoc', 'BP', 1),
(3761, 230, 'Binh Thuan', 'BT', 1),
(3762, 230, 'Ca Mau', 'CM', 1),
(3763, 230, 'Can Tho', 'CT', 1),
(3764, 230, 'Cao Bang', 'CB', 1),
(3765, 230, 'Dak Lak', 'DL', 1),
(3766, 230, 'Dak Nong', 'DG', 1),
(3767, 230, 'Da Nang', 'DN', 1),
(3768, 230, 'Dien Bien', 'DB', 1),
(3769, 230, 'Dong Nai', 'DI', 1),
(3770, 230, 'Dong Thap', 'DT', 1),
(3771, 230, 'Gia Lai', 'GL', 1),
(3772, 230, 'Ha Giang', 'HG', 1),
(3773, 230, 'Hai Duong', 'HD', 1),
(3774, 230, 'Hai Phong', 'HP', 1),
(3775, 230, 'Ha Nam', 'HM', 1),
(3776, 230, 'Ha Noi', 'HI', 1),
(3777, 230, 'Ha Tay', 'HT', 1),
(3778, 230, 'Ha Tinh', 'HH', 1),
(3779, 230, 'Hoa Binh', 'HB', 1),
(3780, 230, 'Ho Chi Minh City', 'HC', 1),
(3781, 230, 'Hau Giang', 'HU', 1),
(3782, 230, 'Hung Yen', 'HY', 1),
(3783, 232, 'Saint Croix', 'C', 1),
(3784, 232, 'Saint John', 'J', 1),
(3785, 232, 'Saint Thomas', 'T', 1),
(3786, 233, 'Alo', 'A', 1),
(3787, 233, 'Sigave', 'S', 1),
(3788, 233, 'Wallis', 'W', 1),
(3789, 235, 'Abyan', 'AB', 1),
(3790, 235, 'Adan', 'AD', 1),
(3791, 235, 'Amran', 'AM', 1),
(3792, 235, 'Al Bayda', 'BA', 1),
(3793, 235, 'Ad Dali', 'DA', 1),
(3794, 235, 'Dhamar', 'DH', 1),
(3795, 235, 'Hadramawt', 'HD', 1),
(3796, 235, 'Hajjah', 'HJ', 1),
(3797, 235, 'Al Hudaydah', 'HU', 1),
(3798, 235, 'Ibb', 'IB', 1),
(3799, 235, 'Al Jawf', 'JA', 1),
(3800, 235, 'Lahij', 'LA', 1),
(3801, 235, 'Ma\'rib', 'MA', 1),
(3802, 235, 'Al Mahrah', 'MR', 1),
(3803, 235, 'Al Mahwit', 'MW', 1),
(3804, 235, 'Sa\'dah', 'SD', 1),
(3805, 235, 'San\'a', 'SN', 1),
(3806, 235, 'Shabwah', 'SH', 1),
(3807, 235, 'Ta\'izz', 'TA', 1),
(3812, 237, 'Bas-Congo', 'BC', 1),
(3813, 237, 'Bandundu', 'BN', 1),
(3814, 237, 'Equateur', 'EQ', 1),
(3815, 237, 'Katanga', 'KA', 1),
(3816, 237, 'Kasai-Oriental', 'KE', 1),
(3817, 237, 'Kinshasa', 'KN', 1),
(3818, 237, 'Kasai-Occidental', 'KW', 1),
(3819, 237, 'Maniema', 'MA', 1),
(3820, 237, 'Nord-Kivu', 'NK', 1),
(3821, 237, 'Orientale', 'OR', 1),
(3822, 237, 'Sud-Kivu', 'SK', 1),
(3823, 238, 'Central', 'CE', 1),
(3824, 238, 'Copperbelt', 'CB', 1),
(3825, 238, 'Eastern', 'EA', 1),
(3826, 238, 'Luapula', 'LP', 1),
(3827, 238, 'Lusaka', 'LK', 1),
(3828, 238, 'Northern', 'NO', 1),
(3829, 238, 'North-Western', 'NW', 1),
(3830, 238, 'Southern', 'SO', 1),
(3831, 238, 'Western', 'WE', 1),
(3832, 239, 'Bulawayo', 'BU', 1),
(3833, 239, 'Harare', 'HA', 1),
(3834, 239, 'Manicaland', 'ML', 1),
(3835, 239, 'Mashonaland Central', 'MC', 1),
(3836, 239, 'Mashonaland East', 'ME', 1),
(3837, 239, 'Mashonaland West', 'MW', 1),
(3838, 239, 'Masvingo', 'MV', 1),
(3839, 239, 'Matabeleland North', 'MN', 1),
(3840, 239, 'Matabeleland South', 'MS', 1),
(3841, 239, 'Midlands', 'MD', 1),
(3861, 105, 'Campobasso', 'CB', 1),
(3863, 105, 'Caserta', 'CE', 1),
(3864, 105, 'Catania', 'CT', 1),
(3865, 105, 'Catanzaro', 'CZ', 1),
(3866, 105, 'Chieti', 'CH', 1),
(3867, 105, 'Como', 'CO', 1),
(3868, 105, 'Cosenza', 'CS', 1),
(3869, 105, 'Cremona', 'CR', 1),
(3870, 105, 'Crotone', 'KR', 1),
(3871, 105, 'Cuneo', 'CN', 1),
(3872, 105, 'Enna', 'EN', 1),
(3873, 105, 'Ferrara', 'FE', 1),
(3874, 105, 'Firenze', 'FI', 1),
(3875, 105, 'Foggia', 'FG', 1),
(3876, 105, 'Forli-Cesena', 'FC', 1),
(3877, 105, 'Frosinone', 'FR', 1),
(3878, 105, 'Genova', 'GE', 1),
(3879, 105, 'Gorizia', 'GO', 1),
(3880, 105, 'Grosseto', 'GR', 1),
(3881, 105, 'Imperia', 'IM', 1),
(3882, 105, 'Isernia', 'IS', 1),
(3883, 105, 'L&#39;Aquila', 'AQ', 1),
(3884, 105, 'La Spezia', 'SP', 1),
(3885, 105, 'Latina', 'LT', 1),
(3886, 105, 'Lecce', 'LE', 1),
(3887, 105, 'Lecco', 'LC', 1),
(3888, 105, 'Livorno', 'LI', 1),
(3889, 105, 'Lodi', 'LO', 1),
(3890, 105, 'Lucca', 'LU', 1),
(3891, 105, 'Macerata', 'MC', 1),
(3892, 105, 'Mantova', 'MN', 1),
(3893, 105, 'Massa-Carrara', 'MS', 1),
(3894, 105, 'Matera', 'MT', 1),
(3896, 105, 'Messina', 'ME', 1),
(3897, 105, 'Milano', 'MI', 1),
(3898, 105, 'Modena', 'MO', 1),
(3899, 105, 'Napoli', 'NA', 1),
(3900, 105, 'Novara', 'NO', 1),
(3901, 105, 'Nuoro', 'NU', 1),
(3904, 105, 'Oristano', 'OR', 1),
(3905, 105, 'Padova', 'PD', 1),
(3906, 105, 'Palermo', 'PA', 1),
(3907, 105, 'Parma', 'PR', 1),
(3908, 105, 'Pavia', 'PV', 1),
(3909, 105, 'Perugia', 'PG', 1),
(3910, 105, 'Pesaro e Urbino', 'PU', 1),
(3911, 105, 'Pescara', 'PE', 1),
(3912, 105, 'Piacenza', 'PC', 1),
(3913, 105, 'Pisa', 'PI', 1),
(3914, 105, 'Pistoia', 'PT', 1),
(3915, 105, 'Pordenone', 'PN', 1),
(3916, 105, 'Potenza', 'PZ', 1),
(3917, 105, 'Prato', 'PO', 1),
(3918, 105, 'Ragusa', 'RG', 1),
(3919, 105, 'Ravenna', 'RA', 1),
(3920, 105, 'Reggio Calabria', 'RC', 1),
(3921, 105, 'Reggio Emilia', 'RE', 1),
(3922, 105, 'Rieti', 'RI', 1),
(3923, 105, 'Rimini', 'RN', 1),
(3924, 105, 'Roma', 'RM', 1),
(3925, 105, 'Rovigo', 'RO', 1),
(3926, 105, 'Salerno', 'SA', 1),
(3927, 105, 'Sassari', 'SS', 1),
(3928, 105, 'Savona', 'SV', 1),
(3929, 105, 'Siena', 'SI', 1),
(3930, 105, 'Siracusa', 'SR', 1),
(3931, 105, 'Sondrio', 'SO', 1),
(3932, 105, 'Taranto', 'TA', 1),
(3933, 105, 'Teramo', 'TE', 1),
(3934, 105, 'Terni', 'TR', 1),
(3935, 105, 'Torino', 'TO', 1),
(3936, 105, 'Trapani', 'TP', 1),
(3937, 105, 'Trento', 'TN', 1),
(3938, 105, 'Treviso', 'TV', 1),
(3939, 105, 'Trieste', 'TS', 1),
(3940, 105, 'Udine', 'UD', 1),
(3941, 105, 'Varese', 'VA', 1),
(3942, 105, 'Venezia', 'VE', 1),
(3943, 105, 'Verbano-Cusio-Ossola', 'VB', 1),
(3944, 105, 'Vercelli', 'VC', 1),
(3945, 105, 'Verona', 'VR', 1),
(3946, 105, 'Vibo Valentia', 'VV', 1),
(3947, 105, 'Vicenza', 'VI', 1),
(3948, 105, 'Viterbo', 'VT', 1),
(3949, 222, 'County Antrim', 'ANT', 1),
(3950, 222, 'County Armagh', 'ARM', 1),
(3951, 222, 'County Down', 'DOW', 1),
(3952, 222, 'County Fermanagh', 'FER', 1),
(3953, 222, 'County Londonderry', 'LDY', 1),
(3954, 222, 'County Tyrone', 'TYR', 1),
(3955, 222, 'Cumbria', 'CMA', 1),
(3956, 190, 'Pomurska', '1', 1),
(3957, 190, 'Podravska', '2', 1),
(3958, 190, 'Koroška', '3', 1),
(3959, 190, 'Savinjska', '4', 1),
(3960, 190, 'Zasavska', '5', 1),
(3961, 190, 'Spodnjeposavska', '6', 1),
(3962, 190, 'Jugovzhodna Slovenija', '7', 1),
(3963, 190, 'Osrednjeslovenska', '8', 1),
(3964, 190, 'Gorenjska', '9', 1),
(3965, 190, 'Notranjsko-kraška', '10', 1),
(3966, 190, 'Goriška', '11', 1),
(3967, 190, 'Obalno-kraška', '12', 1),
(3968, 33, 'Ruse', '', 1),
(3969, 101, 'Alborz', 'ALB', 1),
(3970, 21, 'Brussels-Capital Region', 'BRU', 1),
(3971, 138, 'Aguascalientes', 'AG', 1),
(3973, 242, 'Andrijevica', '01', 1),
(3974, 242, 'Bar', '02', 1),
(3975, 242, 'Berane', '03', 1),
(3976, 242, 'Bijelo Polje', '04', 1),
(3977, 242, 'Budva', '05', 1),
(3978, 242, 'Cetinje', '06', 1),
(3979, 242, 'Danilovgrad', '07', 1),
(3980, 242, 'Herceg-Novi', '08', 1),
(3981, 242, 'Kolašin', '09', 1),
(3982, 242, 'Kotor', '10', 1),
(3983, 242, 'Mojkovac', '11', 1),
(3984, 242, 'Nikšić', '12', 1),
(3985, 242, 'Plav', '13', 1),
(3986, 242, 'Pljevlja', '14', 1),
(3987, 242, 'Plužine', '15', 1),
(3988, 242, 'Podgorica', '16', 1),
(3989, 242, 'Rožaje', '17', 1),
(3990, 242, 'Šavnik', '18', 1),
(3991, 242, 'Tivat', '19', 1),
(3992, 242, 'Ulcinj', '20', 1),
(3993, 242, 'Žabljak', '21', 1),
(3994, 243, 'Belgrade', '00', 1),
(3995, 243, 'North Bačka', '01', 1),
(3996, 243, 'Central Banat', '02', 1),
(3997, 243, 'North Banat', '03', 1),
(3998, 243, 'South Banat', '04', 1),
(3999, 243, 'West Bačka', '05', 1),
(4000, 243, 'South Bačka', '06', 1),
(4001, 243, 'Srem', '07', 1),
(4002, 243, 'Mačva', '08', 1),
(4003, 243, 'Kolubara', '09', 1),
(4004, 243, 'Podunavlje', '10', 1),
(4005, 243, 'Braničevo', '11', 1),
(4006, 243, 'Šumadija', '12', 1),
(4007, 243, 'Pomoravlje', '13', 1),
(4008, 243, 'Bor', '14', 1),
(4009, 243, 'Zaječar', '15', 1),
(4010, 243, 'Zlatibor', '16', 1),
(4011, 243, 'Moravica', '17', 1),
(4012, 243, 'Raška', '18', 1),
(4013, 243, 'Rasina', '19', 1),
(4014, 243, 'Nišava', '20', 1),
(4015, 243, 'Toplica', '21', 1),
(4016, 243, 'Pirot', '22', 1),
(4017, 243, 'Jablanica', '23', 1),
(4018, 243, 'Pčinja', '24', 1),
(4020, 245, 'Bonaire', 'BO', 1),
(4021, 245, 'Saba', 'SA', 1),
(4022, 245, 'Sint Eustatius', 'SE', 1),
(4023, 248, 'Central Equatoria', 'EC', 1),
(4024, 248, 'Eastern Equatoria', 'EE', 1),
(4025, 248, 'Jonglei', 'JG', 1),
(4026, 248, 'Lakes', 'LK', 1),
(4027, 248, 'Northern Bahr el-Ghazal', 'BN', 1),
(4028, 248, 'Unity', 'UY', 1),
(4029, 248, 'Upper Nile', 'NU', 1),
(4030, 248, 'Warrap', 'WR', 1),
(4031, 248, 'Western Bahr el-Ghazal', 'BW', 1),
(4032, 248, 'Western Equatoria', 'EW', 1),
(4036, 117, 'Ainaži, Salacgrīvas novads', '0661405', 1),
(4037, 117, 'Aizkraukle, Aizkraukles novads', '0320201', 1),
(4038, 117, 'Aizkraukles novads', '0320200', 1),
(4039, 117, 'Aizpute, Aizputes novads', '0640605', 1),
(4040, 117, 'Aizputes novads', '0640600', 1),
(4041, 117, 'Aknīste, Aknīstes novads', '0560805', 1),
(4042, 117, 'Aknīstes novads', '0560800', 1),
(4043, 117, 'Aloja, Alojas novads', '0661007', 1),
(4044, 117, 'Alojas novads', '0661000', 1),
(4045, 117, 'Alsungas novads', '0624200', 1),
(4046, 117, 'Alūksne, Alūksnes novads', '0360201', 1),
(4047, 117, 'Alūksnes novads', '0360200', 1),
(4048, 117, 'Amatas novads', '0424701', 1),
(4049, 117, 'Ape, Apes novads', '0360805', 1),
(4050, 117, 'Apes novads', '0360800', 1),
(4051, 117, 'Auce, Auces novads', '0460805', 1),
(4052, 117, 'Auces novads', '0460800', 1),
(4053, 117, 'Ādažu novads', '0804400', 1),
(4054, 117, 'Babītes novads', '0804900', 1),
(4055, 117, 'Baldone, Baldones novads', '0800605', 1),
(4056, 117, 'Baldones novads', '0800600', 1),
(4057, 117, 'Baloži, Ķekavas novads', '0800807', 1),
(4058, 117, 'Baltinavas novads', '0384400', 1),
(4059, 117, 'Balvi, Balvu novads', '0380201', 1),
(4060, 117, 'Balvu novads', '0380200', 1),
(4061, 117, 'Bauska, Bauskas novads', '0400201', 1),
(4062, 117, 'Bauskas novads', '0400200', 1),
(4063, 117, 'Beverīnas novads', '0964700', 1),
(4064, 117, 'Brocēni, Brocēnu novads', '0840605', 1),
(4065, 117, 'Brocēnu novads', '0840601', 1),
(4066, 117, 'Burtnieku novads', '0967101', 1),
(4067, 117, 'Carnikavas novads', '0805200', 1),
(4068, 117, 'Cesvaine, Cesvaines novads', '0700807', 1),
(4069, 117, 'Cesvaines novads', '0700800', 1),
(4070, 117, 'Cēsis, Cēsu novads', '0420201', 1),
(4071, 117, 'Cēsu novads', '0420200', 1),
(4072, 117, 'Ciblas novads', '0684901', 1),
(4073, 117, 'Dagda, Dagdas novads', '0601009', 1),
(4074, 117, 'Dagdas novads', '0601000', 1),
(4075, 117, 'Daugavpils', '0050000', 1),
(4076, 117, 'Daugavpils novads', '0440200', 1),
(4077, 117, 'Dobele, Dobeles novads', '0460201', 1),
(4078, 117, 'Dobeles novads', '0460200', 1),
(4079, 117, 'Dundagas novads', '0885100', 1),
(4080, 117, 'Durbe, Durbes novads', '0640807', 1),
(4081, 117, 'Durbes novads', '0640801', 1),
(4082, 117, 'Engures novads', '0905100', 1),
(4083, 117, 'Ērgļu novads', '0705500', 1),
(4084, 117, 'Garkalnes novads', '0806000', 1),
(4085, 117, 'Grobiņa, Grobiņas novads', '0641009', 1),
(4086, 117, 'Grobiņas novads', '0641000', 1),
(4087, 117, 'Gulbene, Gulbenes novads', '0500201', 1),
(4088, 117, 'Gulbenes novads', '0500200', 1),
(4089, 117, 'Iecavas novads', '0406400', 1),
(4090, 117, 'Ikšķile, Ikšķiles novads', '0740605', 1),
(4091, 117, 'Ikšķiles novads', '0740600', 1),
(4092, 117, 'Ilūkste, Ilūkstes novads', '0440807', 1),
(4093, 117, 'Ilūkstes novads', '0440801', 1),
(4094, 117, 'Inčukalna novads', '0801800', 1),
(4095, 117, 'Jaunjelgava, Jaunjelgavas novads', '0321007', 1),
(4096, 117, 'Jaunjelgavas novads', '0321000', 1),
(4097, 117, 'Jaunpiebalgas novads', '0425700', 1),
(4098, 117, 'Jaunpils novads', '0905700', 1),
(4099, 117, 'Jelgava', '0090000', 1),
(4100, 117, 'Jelgavas novads', '0540200', 1),
(4101, 117, 'Jēkabpils', '0110000', 1),
(4102, 117, 'Jēkabpils novads', '0560200', 1),
(4103, 117, 'Jūrmala', '0130000', 1),
(4104, 117, 'Kalnciems, Jelgavas novads', '0540211', 1),
(4105, 117, 'Kandava, Kandavas novads', '0901211', 1),
(4106, 117, 'Kandavas novads', '0901201', 1),
(4107, 117, 'Kārsava, Kārsavas novads', '0681009', 1),
(4108, 117, 'Kārsavas novads', '0681000', 1),
(4109, 117, 'Kocēnu novads ,bij. Valmieras)', '0960200', 1),
(4110, 117, 'Kokneses novads', '0326100', 1),
(4111, 117, 'Krāslava, Krāslavas novads', '0600201', 1),
(4112, 117, 'Krāslavas novads', '0600202', 1),
(4113, 117, 'Krimuldas novads', '0806900', 1),
(4114, 117, 'Krustpils novads', '0566900', 1),
(4115, 117, 'Kuldīga, Kuldīgas novads', '0620201', 1),
(4116, 117, 'Kuldīgas novads', '0620200', 1),
(4117, 117, 'Ķeguma novads', '0741001', 1),
(4118, 117, 'Ķegums, Ķeguma novads', '0741009', 1),
(4119, 117, 'Ķekavas novads', '0800800', 1),
(4120, 117, 'Lielvārde, Lielvārdes novads', '0741413', 1),
(4121, 117, 'Lielvārdes novads', '0741401', 1),
(4122, 117, 'Liepāja', '0170000', 1),
(4123, 117, 'Limbaži, Limbažu novads', '0660201', 1),
(4124, 117, 'Limbažu novads', '0660200', 1),
(4125, 117, 'Līgatne, Līgatnes novads', '0421211', 1),
(4126, 117, 'Līgatnes novads', '0421200', 1),
(4127, 117, 'Līvāni, Līvānu novads', '0761211', 1),
(4128, 117, 'Līvānu novads', '0761201', 1),
(4129, 117, 'Lubāna, Lubānas novads', '0701413', 1),
(4130, 117, 'Lubānas novads', '0701400', 1),
(4131, 117, 'Ludza, Ludzas novads', '0680201', 1),
(4132, 117, 'Ludzas novads', '0680200', 1),
(4133, 117, 'Madona, Madonas novads', '0700201', 1),
(4134, 117, 'Madonas novads', '0700200', 1),
(4135, 117, 'Mazsalaca, Mazsalacas novads', '0961011', 1),
(4136, 117, 'Mazsalacas novads', '0961000', 1),
(4137, 117, 'Mālpils novads', '0807400', 1),
(4138, 117, 'Mārupes novads', '0807600', 1),
(4139, 117, 'Mērsraga novads', '0887600', 1),
(4140, 117, 'Naukšēnu novads', '0967300', 1),
(4141, 117, 'Neretas novads', '0327100', 1),
(4142, 117, 'Nīcas novads', '0647900', 1),
(4143, 117, 'Ogre, Ogres novads', '0740201', 1),
(4144, 117, 'Ogres novads', '0740202', 1),
(4145, 117, 'Olaine, Olaines novads', '0801009', 1),
(4146, 117, 'Olaines novads', '0801000', 1),
(4147, 117, 'Ozolnieku novads', '0546701', 1),
(4148, 117, 'Pārgaujas novads', '0427500', 1),
(4149, 117, 'Pāvilosta, Pāvilostas novads', '0641413', 1),
(4150, 117, 'Pāvilostas novads', '0641401', 1),
(4151, 117, 'Piltene, Ventspils novads', '0980213', 1),
(4152, 117, 'Pļaviņas, Pļaviņu novads', '0321413', 1),
(4153, 117, 'Pļaviņu novads', '0321400', 1),
(4154, 117, 'Preiļi, Preiļu novads', '0760201', 1),
(4155, 117, 'Preiļu novads', '0760202', 1),
(4156, 117, 'Priekule, Priekules novads', '0641615', 1),
(4157, 117, 'Priekules novads', '0641600', 1),
(4158, 117, 'Priekuļu novads', '0427300', 1),
(4159, 117, 'Raunas novads', '0427700', 1),
(4160, 117, 'Rēzekne', '0210000', 1),
(4161, 117, 'Rēzeknes novads', '0780200', 1),
(4162, 117, 'Riebiņu novads', '0766300', 1),
(4163, 117, 'Rīga', '0010000', 1),
(4164, 117, 'Rojas novads', '0888300', 1),
(4165, 117, 'Ropažu novads', '0808400', 1),
(4166, 117, 'Rucavas novads', '0648500', 1),
(4167, 117, 'Rugāju novads', '0387500', 1),
(4168, 117, 'Rundāles novads', '0407700', 1),
(4169, 117, 'Rūjiena, Rūjienas novads', '0961615', 1),
(4170, 117, 'Rūjienas novads', '0961600', 1),
(4171, 117, 'Sabile, Talsu novads', '0880213', 1),
(4172, 117, 'Salacgrīva, Salacgrīvas novads', '0661415', 1),
(4173, 117, 'Salacgrīvas novads', '0661400', 1),
(4174, 117, 'Salas novads', '0568700', 1),
(4175, 117, 'Salaspils novads', '0801200', 1),
(4176, 117, 'Salaspils, Salaspils novads', '0801211', 1),
(4177, 117, 'Saldus novads', '0840200', 1),
(4178, 117, 'Saldus, Saldus novads', '0840201', 1),
(4179, 117, 'Saulkrasti, Saulkrastu novads', '0801413', 1),
(4180, 117, 'Saulkrastu novads', '0801400', 1),
(4181, 117, 'Seda, Strenču novads', '0941813', 1),
(4182, 117, 'Sējas novads', '0809200', 1),
(4183, 117, 'Sigulda, Siguldas novads', '0801615', 1),
(4184, 117, 'Siguldas novads', '0801601', 1),
(4185, 117, 'Skrīveru novads', '0328200', 1),
(4186, 117, 'Skrunda, Skrundas novads', '0621209', 1),
(4187, 117, 'Skrundas novads', '0621200', 1),
(4188, 117, 'Smiltene, Smiltenes novads', '0941615', 1),
(4189, 117, 'Smiltenes novads', '0941600', 1),
(4190, 117, 'Staicele, Alojas novads', '0661017', 1),
(4191, 117, 'Stende, Talsu novads', '0880215', 1),
(4192, 117, 'Stopiņu novads', '0809600', 1),
(4193, 117, 'Strenči, Strenču novads', '0941817', 1),
(4194, 117, 'Strenču novads', '0941800', 1),
(4195, 117, 'Subate, Ilūkstes novads', '0440815', 1),
(4196, 117, 'Talsi, Talsu novads', '0880201', 1),
(4197, 117, 'Talsu novads', '0880200', 1),
(4198, 117, 'Tērvetes novads', '0468900', 1),
(4199, 117, 'Tukuma novads', '0900200', 1),
(4200, 117, 'Tukums, Tukuma novads', '0900201', 1),
(4201, 117, 'Vaiņodes novads', '0649300', 1),
(4202, 117, 'Valdemārpils, Talsu novads', '0880217', 1),
(4203, 117, 'Valka, Valkas novads', '0940201', 1),
(4204, 117, 'Valkas novads', '0940200', 1),
(4205, 117, 'Valmiera', '0250000', 1),
(4206, 117, 'Vangaži, Inčukalna novads', '0801817', 1),
(4207, 117, 'Varakļāni, Varakļānu novads', '0701817', 1),
(4208, 117, 'Varakļānu novads', '0701800', 1),
(4209, 117, 'Vārkavas novads', '0769101', 1),
(4210, 117, 'Vecpiebalgas novads', '0429300', 1),
(4211, 117, 'Vecumnieku novads', '0409500', 1),
(4212, 117, 'Ventspils', '0270000', 1),
(4213, 117, 'Ventspils novads', '0980200', 1),
(4214, 117, 'Viesīte, Viesītes novads', '0561815', 1),
(4215, 117, 'Viesītes novads', '0561800', 1),
(4216, 117, 'Viļaka, Viļakas novads', '0381615', 1),
(4217, 117, 'Viļakas novads', '0381600', 1),
(4218, 117, 'Viļāni, Viļānu novads', '0781817', 1),
(4219, 117, 'Viļānu novads', '0781800', 1),
(4220, 117, 'Zilupe, Zilupes novads', '0681817', 1),
(4221, 117, 'Zilupes novads', '0681801', 1),
(4222, 43, 'Arica y Parinacota', 'AP', 1),
(4223, 43, 'Los Rios', 'LR', 1),
(4224, 220, 'Kharkivs\'ka Oblast\'', '63', 1),
(4225, 118, 'Beirut', 'LB-BR', 1),
(4226, 118, 'Bekaa', 'LB-BE', 1),
(4227, 118, 'Mount Lebanon', 'LB-ML', 1),
(4228, 118, 'Nabatieh', 'LB-NB', 1),
(4229, 118, 'North', 'LB-NR', 1),
(4230, 118, 'South', 'LB-ST', 1),
(4231, 99, 'Telangana', 'TS', 1),
(4232, 44, 'Qinghai', 'QH', 1),
(4233, 100, 'Papua Barat', 'PB', 1),
(4234, 100, 'Sulawesi Barat', 'SR', 1),
(4235, 100, 'Kepulauan Riau', 'KR', 1),
(4236, 105, 'Barletta-Andria-Trani', 'BT', 1),
(4237, 105, 'Fermo', 'FM', 1),
(4238, 105, 'Monza Brianza', 'MB', 1);

-- --------------------------------------------------------

--
-- Table structure for table `oc_zone_to_geo_zone`
--

CREATE TABLE `oc_zone_to_geo_zone` (
  `zone_to_geo_zone_id` int NOT NULL,
  `country_id` int NOT NULL,
  `zone_id` int NOT NULL DEFAULT '0',
  `geo_zone_id` int NOT NULL,
  `date_added` datetime NOT NULL,
  `date_modified` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `oc_zone_to_geo_zone`
--

INSERT INTO `oc_zone_to_geo_zone` (`zone_to_geo_zone_id`, `country_id`, `zone_id`, `geo_zone_id`, `date_added`, `date_modified`) VALUES
(110, 156, 0, 5, '2025-04-18 05:00:30', '0000-00-00 00:00:00');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `oc_address`
--
ALTER TABLE `oc_address`
  ADD PRIMARY KEY (`address_id`),
  ADD KEY `customer_id` (`customer_id`);

--
-- Indexes for table `oc_api`
--
ALTER TABLE `oc_api`
  ADD PRIMARY KEY (`api_id`);

--
-- Indexes for table `oc_api_ip`
--
ALTER TABLE `oc_api_ip`
  ADD PRIMARY KEY (`api_ip_id`);

--
-- Indexes for table `oc_api_session`
--
ALTER TABLE `oc_api_session`
  ADD PRIMARY KEY (`api_session_id`);

--
-- Indexes for table `oc_attribute`
--
ALTER TABLE `oc_attribute`
  ADD PRIMARY KEY (`attribute_id`);

--
-- Indexes for table `oc_attribute_description`
--
ALTER TABLE `oc_attribute_description`
  ADD PRIMARY KEY (`attribute_id`,`language_id`);

--
-- Indexes for table `oc_attribute_group`
--
ALTER TABLE `oc_attribute_group`
  ADD PRIMARY KEY (`attribute_group_id`);

--
-- Indexes for table `oc_attribute_group_description`
--
ALTER TABLE `oc_attribute_group_description`
  ADD PRIMARY KEY (`attribute_group_id`,`language_id`);

--
-- Indexes for table `oc_banner`
--
ALTER TABLE `oc_banner`
  ADD PRIMARY KEY (`banner_id`);

--
-- Indexes for table `oc_banner_image`
--
ALTER TABLE `oc_banner_image`
  ADD PRIMARY KEY (`banner_image_id`);

--
-- Indexes for table `oc_blogger`
--
ALTER TABLE `oc_blogger`
  ADD PRIMARY KEY (`blogger_id`);

--
-- Indexes for table `oc_blogger_comment`
--
ALTER TABLE `oc_blogger_comment`
  ADD PRIMARY KEY (`blogger_comment_id`,`blogger_id`);

--
-- Indexes for table `oc_blogger_comment_description`
--
ALTER TABLE `oc_blogger_comment_description`
  ADD PRIMARY KEY (`blogger_comment_id`,`language_id`);

--
-- Indexes for table `oc_blogger_description`
--
ALTER TABLE `oc_blogger_description`
  ADD PRIMARY KEY (`blogger_id`,`language_id`);

--
-- Indexes for table `oc_cart`
--
ALTER TABLE `oc_cart`
  ADD PRIMARY KEY (`cart_id`),
  ADD KEY `cart_id` (`api_id`,`customer_id`,`session_id`,`product_id`,`recurring_id`);

--
-- Indexes for table `oc_category`
--
ALTER TABLE `oc_category`
  ADD PRIMARY KEY (`category_id`),
  ADD KEY `parent_id` (`parent_id`);

--
-- Indexes for table `oc_category_description`
--
ALTER TABLE `oc_category_description`
  ADD PRIMARY KEY (`category_id`,`language_id`),
  ADD KEY `name` (`name`);

--
-- Indexes for table `oc_category_filter`
--
ALTER TABLE `oc_category_filter`
  ADD PRIMARY KEY (`category_id`,`filter_id`);

--
-- Indexes for table `oc_category_path`
--
ALTER TABLE `oc_category_path`
  ADD PRIMARY KEY (`category_id`,`path_id`);

--
-- Indexes for table `oc_category_to_layout`
--
ALTER TABLE `oc_category_to_layout`
  ADD PRIMARY KEY (`category_id`,`store_id`);

--
-- Indexes for table `oc_category_to_store`
--
ALTER TABLE `oc_category_to_store`
  ADD PRIMARY KEY (`category_id`,`store_id`);

--
-- Indexes for table `oc_country`
--
ALTER TABLE `oc_country`
  ADD PRIMARY KEY (`country_id`);

--
-- Indexes for table `oc_coupon`
--
ALTER TABLE `oc_coupon`
  ADD PRIMARY KEY (`coupon_id`);

--
-- Indexes for table `oc_coupon_category`
--
ALTER TABLE `oc_coupon_category`
  ADD PRIMARY KEY (`coupon_id`,`category_id`);

--
-- Indexes for table `oc_coupon_history`
--
ALTER TABLE `oc_coupon_history`
  ADD PRIMARY KEY (`coupon_history_id`);

--
-- Indexes for table `oc_coupon_product`
--
ALTER TABLE `oc_coupon_product`
  ADD PRIMARY KEY (`coupon_product_id`);

--
-- Indexes for table `oc_currency`
--
ALTER TABLE `oc_currency`
  ADD PRIMARY KEY (`currency_id`);

--
-- Indexes for table `oc_customer`
--
ALTER TABLE `oc_customer`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indexes for table `oc_customer_activity`
--
ALTER TABLE `oc_customer_activity`
  ADD PRIMARY KEY (`customer_activity_id`);

--
-- Indexes for table `oc_customer_affiliate`
--
ALTER TABLE `oc_customer_affiliate`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indexes for table `oc_customer_approval`
--
ALTER TABLE `oc_customer_approval`
  ADD PRIMARY KEY (`customer_approval_id`);

--
-- Indexes for table `oc_customer_group`
--
ALTER TABLE `oc_customer_group`
  ADD PRIMARY KEY (`customer_group_id`);

--
-- Indexes for table `oc_customer_group_description`
--
ALTER TABLE `oc_customer_group_description`
  ADD PRIMARY KEY (`customer_group_id`,`language_id`);

--
-- Indexes for table `oc_customer_history`
--
ALTER TABLE `oc_customer_history`
  ADD PRIMARY KEY (`customer_history_id`);

--
-- Indexes for table `oc_customer_ip`
--
ALTER TABLE `oc_customer_ip`
  ADD PRIMARY KEY (`customer_ip_id`),
  ADD KEY `ip` (`ip`);

--
-- Indexes for table `oc_customer_login`
--
ALTER TABLE `oc_customer_login`
  ADD PRIMARY KEY (`customer_login_id`),
  ADD KEY `email` (`email`),
  ADD KEY `ip` (`ip`);

--
-- Indexes for table `oc_customer_online`
--
ALTER TABLE `oc_customer_online`
  ADD PRIMARY KEY (`ip`);

--
-- Indexes for table `oc_customer_reward`
--
ALTER TABLE `oc_customer_reward`
  ADD PRIMARY KEY (`customer_reward_id`);

--
-- Indexes for table `oc_customer_search`
--
ALTER TABLE `oc_customer_search`
  ADD PRIMARY KEY (`customer_search_id`);

--
-- Indexes for table `oc_customer_transaction`
--
ALTER TABLE `oc_customer_transaction`
  ADD PRIMARY KEY (`customer_transaction_id`);

--
-- Indexes for table `oc_customer_wishlist`
--
ALTER TABLE `oc_customer_wishlist`
  ADD PRIMARY KEY (`customer_id`,`product_id`);

--
-- Indexes for table `oc_custom_field`
--
ALTER TABLE `oc_custom_field`
  ADD PRIMARY KEY (`custom_field_id`);

--
-- Indexes for table `oc_custom_field_customer_group`
--
ALTER TABLE `oc_custom_field_customer_group`
  ADD PRIMARY KEY (`custom_field_id`,`customer_group_id`);

--
-- Indexes for table `oc_custom_field_description`
--
ALTER TABLE `oc_custom_field_description`
  ADD PRIMARY KEY (`custom_field_id`,`language_id`);

--
-- Indexes for table `oc_custom_field_value`
--
ALTER TABLE `oc_custom_field_value`
  ADD PRIMARY KEY (`custom_field_value_id`);

--
-- Indexes for table `oc_custom_field_value_description`
--
ALTER TABLE `oc_custom_field_value_description`
  ADD PRIMARY KEY (`custom_field_value_id`,`language_id`);

--
-- Indexes for table `oc_download`
--
ALTER TABLE `oc_download`
  ADD PRIMARY KEY (`download_id`);

--
-- Indexes for table `oc_download_description`
--
ALTER TABLE `oc_download_description`
  ADD PRIMARY KEY (`download_id`,`language_id`);

--
-- Indexes for table `oc_event`
--
ALTER TABLE `oc_event`
  ADD PRIMARY KEY (`event_id`);

--
-- Indexes for table `oc_extension`
--
ALTER TABLE `oc_extension`
  ADD PRIMARY KEY (`extension_id`);

--
-- Indexes for table `oc_extension_install`
--
ALTER TABLE `oc_extension_install`
  ADD PRIMARY KEY (`extension_install_id`);

--
-- Indexes for table `oc_extension_path`
--
ALTER TABLE `oc_extension_path`
  ADD PRIMARY KEY (`extension_path_id`);

--
-- Indexes for table `oc_filter`
--
ALTER TABLE `oc_filter`
  ADD PRIMARY KEY (`filter_id`);

--
-- Indexes for table `oc_filter_description`
--
ALTER TABLE `oc_filter_description`
  ADD PRIMARY KEY (`filter_id`,`language_id`);

--
-- Indexes for table `oc_filter_group`
--
ALTER TABLE `oc_filter_group`
  ADD PRIMARY KEY (`filter_group_id`);

--
-- Indexes for table `oc_filter_group_description`
--
ALTER TABLE `oc_filter_group_description`
  ADD PRIMARY KEY (`filter_group_id`,`language_id`);

--
-- Indexes for table `oc_geo_zone`
--
ALTER TABLE `oc_geo_zone`
  ADD PRIMARY KEY (`geo_zone_id`);

--
-- Indexes for table `oc_information`
--
ALTER TABLE `oc_information`
  ADD PRIMARY KEY (`information_id`);

--
-- Indexes for table `oc_information_description`
--
ALTER TABLE `oc_information_description`
  ADD PRIMARY KEY (`information_id`,`language_id`);

--
-- Indexes for table `oc_information_to_layout`
--
ALTER TABLE `oc_information_to_layout`
  ADD PRIMARY KEY (`information_id`,`store_id`);

--
-- Indexes for table `oc_information_to_store`
--
ALTER TABLE `oc_information_to_store`
  ADD PRIMARY KEY (`information_id`,`store_id`);

--
-- Indexes for table `oc_language`
--
ALTER TABLE `oc_language`
  ADD PRIMARY KEY (`language_id`),
  ADD KEY `name` (`name`);

--
-- Indexes for table `oc_layout`
--
ALTER TABLE `oc_layout`
  ADD PRIMARY KEY (`layout_id`);

--
-- Indexes for table `oc_layout_module`
--
ALTER TABLE `oc_layout_module`
  ADD PRIMARY KEY (`layout_module_id`);

--
-- Indexes for table `oc_layout_route`
--
ALTER TABLE `oc_layout_route`
  ADD PRIMARY KEY (`layout_route_id`);

--
-- Indexes for table `oc_length_class`
--
ALTER TABLE `oc_length_class`
  ADD PRIMARY KEY (`length_class_id`);

--
-- Indexes for table `oc_length_class_description`
--
ALTER TABLE `oc_length_class_description`
  ADD PRIMARY KEY (`length_class_id`,`language_id`);

--
-- Indexes for table `oc_location`
--
ALTER TABLE `oc_location`
  ADD PRIMARY KEY (`location_id`),
  ADD KEY `name` (`name`);

--
-- Indexes for table `oc_manufacturer`
--
ALTER TABLE `oc_manufacturer`
  ADD PRIMARY KEY (`manufacturer_id`);

--
-- Indexes for table `oc_manufacturer_to_store`
--
ALTER TABLE `oc_manufacturer_to_store`
  ADD PRIMARY KEY (`manufacturer_id`,`store_id`);

--
-- Indexes for table `oc_marketing`
--
ALTER TABLE `oc_marketing`
  ADD PRIMARY KEY (`marketing_id`);

--
-- Indexes for table `oc_modification`
--
ALTER TABLE `oc_modification`
  ADD PRIMARY KEY (`modification_id`);

--
-- Indexes for table `oc_module`
--
ALTER TABLE `oc_module`
  ADD PRIMARY KEY (`module_id`);

--
-- Indexes for table `oc_newsletter`
--
ALTER TABLE `oc_newsletter`
  ADD PRIMARY KEY (`news_id`);

--
-- Indexes for table `oc_option`
--
ALTER TABLE `oc_option`
  ADD PRIMARY KEY (`option_id`);

--
-- Indexes for table `oc_option_description`
--
ALTER TABLE `oc_option_description`
  ADD PRIMARY KEY (`option_id`,`language_id`);

--
-- Indexes for table `oc_option_value`
--
ALTER TABLE `oc_option_value`
  ADD PRIMARY KEY (`option_value_id`);

--
-- Indexes for table `oc_option_value_description`
--
ALTER TABLE `oc_option_value_description`
  ADD PRIMARY KEY (`option_value_id`,`language_id`);

--
-- Indexes for table `oc_order`
--
ALTER TABLE `oc_order`
  ADD PRIMARY KEY (`order_id`);

--
-- Indexes for table `oc_order_history`
--
ALTER TABLE `oc_order_history`
  ADD PRIMARY KEY (`order_history_id`);

--
-- Indexes for table `oc_order_option`
--
ALTER TABLE `oc_order_option`
  ADD PRIMARY KEY (`order_option_id`);

--
-- Indexes for table `oc_order_product`
--
ALTER TABLE `oc_order_product`
  ADD PRIMARY KEY (`order_product_id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `oc_order_recurring`
--
ALTER TABLE `oc_order_recurring`
  ADD PRIMARY KEY (`order_recurring_id`);

--
-- Indexes for table `oc_order_recurring_transaction`
--
ALTER TABLE `oc_order_recurring_transaction`
  ADD PRIMARY KEY (`order_recurring_transaction_id`);

--
-- Indexes for table `oc_order_shipment`
--
ALTER TABLE `oc_order_shipment`
  ADD PRIMARY KEY (`order_shipment_id`);

--
-- Indexes for table `oc_order_status`
--
ALTER TABLE `oc_order_status`
  ADD PRIMARY KEY (`order_status_id`,`language_id`);

--
-- Indexes for table `oc_order_total`
--
ALTER TABLE `oc_order_total`
  ADD PRIMARY KEY (`order_total_id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `oc_order_voucher`
--
ALTER TABLE `oc_order_voucher`
  ADD PRIMARY KEY (`order_voucher_id`);

--
-- Indexes for table `oc_product`
--
ALTER TABLE `oc_product`
  ADD PRIMARY KEY (`product_id`);

--
-- Indexes for table `oc_product_attribute`
--
ALTER TABLE `oc_product_attribute`
  ADD PRIMARY KEY (`product_id`,`attribute_id`,`language_id`);

--
-- Indexes for table `oc_product_description`
--
ALTER TABLE `oc_product_description`
  ADD PRIMARY KEY (`product_id`,`language_id`),
  ADD KEY `name` (`name`);

--
-- Indexes for table `oc_product_discount`
--
ALTER TABLE `oc_product_discount`
  ADD PRIMARY KEY (`product_discount_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `oc_product_filter`
--
ALTER TABLE `oc_product_filter`
  ADD PRIMARY KEY (`product_id`,`filter_id`);

--
-- Indexes for table `oc_product_image`
--
ALTER TABLE `oc_product_image`
  ADD PRIMARY KEY (`product_image_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `oc_product_option`
--
ALTER TABLE `oc_product_option`
  ADD PRIMARY KEY (`product_option_id`);

--
-- Indexes for table `oc_product_option_value`
--
ALTER TABLE `oc_product_option_value`
  ADD PRIMARY KEY (`product_option_value_id`);

--
-- Indexes for table `oc_product_recurring`
--
ALTER TABLE `oc_product_recurring`
  ADD PRIMARY KEY (`product_id`,`recurring_id`,`customer_group_id`);

--
-- Indexes for table `oc_product_related`
--
ALTER TABLE `oc_product_related`
  ADD PRIMARY KEY (`product_id`,`related_id`);

--
-- Indexes for table `oc_product_reward`
--
ALTER TABLE `oc_product_reward`
  ADD PRIMARY KEY (`product_reward_id`);

--
-- Indexes for table `oc_product_special`
--
ALTER TABLE `oc_product_special`
  ADD PRIMARY KEY (`product_special_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `oc_product_to_category`
--
ALTER TABLE `oc_product_to_category`
  ADD PRIMARY KEY (`product_id`,`category_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `oc_product_to_download`
--
ALTER TABLE `oc_product_to_download`
  ADD PRIMARY KEY (`product_id`,`download_id`);

--
-- Indexes for table `oc_product_to_layout`
--
ALTER TABLE `oc_product_to_layout`
  ADD PRIMARY KEY (`product_id`,`store_id`);

--
-- Indexes for table `oc_product_to_store`
--
ALTER TABLE `oc_product_to_store`
  ADD PRIMARY KEY (`product_id`,`store_id`);

--
-- Indexes for table `oc_recurring`
--
ALTER TABLE `oc_recurring`
  ADD PRIMARY KEY (`recurring_id`);

--
-- Indexes for table `oc_recurring_description`
--
ALTER TABLE `oc_recurring_description`
  ADD PRIMARY KEY (`recurring_id`,`language_id`);

--
-- Indexes for table `oc_return`
--
ALTER TABLE `oc_return`
  ADD PRIMARY KEY (`return_id`);

--
-- Indexes for table `oc_return_action`
--
ALTER TABLE `oc_return_action`
  ADD PRIMARY KEY (`return_action_id`,`language_id`);

--
-- Indexes for table `oc_return_history`
--
ALTER TABLE `oc_return_history`
  ADD PRIMARY KEY (`return_history_id`);

--
-- Indexes for table `oc_return_reason`
--
ALTER TABLE `oc_return_reason`
  ADD PRIMARY KEY (`return_reason_id`,`language_id`);

--
-- Indexes for table `oc_return_status`
--
ALTER TABLE `oc_return_status`
  ADD PRIMARY KEY (`return_status_id`,`language_id`);

--
-- Indexes for table `oc_review`
--
ALTER TABLE `oc_review`
  ADD PRIMARY KEY (`review_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `oc_seo_url`
--
ALTER TABLE `oc_seo_url`
  ADD PRIMARY KEY (`seo_url_id`),
  ADD KEY `query` (`query`),
  ADD KEY `keyword` (`keyword`);

--
-- Indexes for table `oc_session`
--
ALTER TABLE `oc_session`
  ADD PRIMARY KEY (`session_id`);

--
-- Indexes for table `oc_setting`
--
ALTER TABLE `oc_setting`
  ADD PRIMARY KEY (`setting_id`);

--
-- Indexes for table `oc_shipping_courier`
--
ALTER TABLE `oc_shipping_courier`
  ADD PRIMARY KEY (`shipping_courier_id`);

--
-- Indexes for table `oc_statistics`
--
ALTER TABLE `oc_statistics`
  ADD PRIMARY KEY (`statistics_id`);

--
-- Indexes for table `oc_stock_status`
--
ALTER TABLE `oc_stock_status`
  ADD PRIMARY KEY (`stock_status_id`,`language_id`);

--
-- Indexes for table `oc_store`
--
ALTER TABLE `oc_store`
  ADD PRIMARY KEY (`store_id`);

--
-- Indexes for table `oc_tax_class`
--
ALTER TABLE `oc_tax_class`
  ADD PRIMARY KEY (`tax_class_id`);

--
-- Indexes for table `oc_tax_rate`
--
ALTER TABLE `oc_tax_rate`
  ADD PRIMARY KEY (`tax_rate_id`);

--
-- Indexes for table `oc_tax_rate_to_customer_group`
--
ALTER TABLE `oc_tax_rate_to_customer_group`
  ADD PRIMARY KEY (`tax_rate_id`,`customer_group_id`);

--
-- Indexes for table `oc_tax_rule`
--
ALTER TABLE `oc_tax_rule`
  ADD PRIMARY KEY (`tax_rule_id`);

--
-- Indexes for table `oc_theme`
--
ALTER TABLE `oc_theme`
  ADD PRIMARY KEY (`theme_id`);

--
-- Indexes for table `oc_translation`
--
ALTER TABLE `oc_translation`
  ADD PRIMARY KEY (`translation_id`);

--
-- Indexes for table `oc_upload`
--
ALTER TABLE `oc_upload`
  ADD PRIMARY KEY (`upload_id`);

--
-- Indexes for table `oc_user`
--
ALTER TABLE `oc_user`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `oc_user_group`
--
ALTER TABLE `oc_user_group`
  ADD PRIMARY KEY (`user_group_id`);

--
-- Indexes for table `oc_voucher`
--
ALTER TABLE `oc_voucher`
  ADD PRIMARY KEY (`voucher_id`);

--
-- Indexes for table `oc_voucher_history`
--
ALTER TABLE `oc_voucher_history`
  ADD PRIMARY KEY (`voucher_history_id`);

--
-- Indexes for table `oc_voucher_theme`
--
ALTER TABLE `oc_voucher_theme`
  ADD PRIMARY KEY (`voucher_theme_id`);

--
-- Indexes for table `oc_voucher_theme_description`
--
ALTER TABLE `oc_voucher_theme_description`
  ADD PRIMARY KEY (`voucher_theme_id`,`language_id`);

--
-- Indexes for table `oc_weight_class`
--
ALTER TABLE `oc_weight_class`
  ADD PRIMARY KEY (`weight_class_id`);

--
-- Indexes for table `oc_weight_class_description`
--
ALTER TABLE `oc_weight_class_description`
  ADD PRIMARY KEY (`weight_class_id`,`language_id`);

--
-- Indexes for table `oc_zone`
--
ALTER TABLE `oc_zone`
  ADD PRIMARY KEY (`zone_id`);

--
-- Indexes for table `oc_zone_to_geo_zone`
--
ALTER TABLE `oc_zone_to_geo_zone`
  ADD PRIMARY KEY (`zone_to_geo_zone_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `oc_address`
--
ALTER TABLE `oc_address`
  MODIFY `address_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `oc_api`
--
ALTER TABLE `oc_api`
  MODIFY `api_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `oc_api_ip`
--
ALTER TABLE `oc_api_ip`
  MODIFY `api_ip_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `oc_api_session`
--
ALTER TABLE `oc_api_session`
  MODIFY `api_session_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `oc_attribute`
--
ALTER TABLE `oc_attribute`
  MODIFY `attribute_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `oc_attribute_group`
--
ALTER TABLE `oc_attribute_group`
  MODIFY `attribute_group_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `oc_banner`
--
ALTER TABLE `oc_banner`
  MODIFY `banner_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `oc_banner_image`
--
ALTER TABLE `oc_banner_image`
  MODIFY `banner_image_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=312;

--
-- AUTO_INCREMENT for table `oc_blogger`
--
ALTER TABLE `oc_blogger`
  MODIFY `blogger_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `oc_blogger_comment`
--
ALTER TABLE `oc_blogger_comment`
  MODIFY `blogger_comment_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `oc_cart`
--
ALTER TABLE `oc_cart`
  MODIFY `cart_id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=93;

--
-- AUTO_INCREMENT for table `oc_category`
--
ALTER TABLE `oc_category`
  MODIFY `category_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;

--
-- AUTO_INCREMENT for table `oc_country`
--
ALTER TABLE `oc_country`
  MODIFY `country_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=258;

--
-- AUTO_INCREMENT for table `oc_coupon`
--
ALTER TABLE `oc_coupon`
  MODIFY `coupon_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `oc_coupon_history`
--
ALTER TABLE `oc_coupon_history`
  MODIFY `coupon_history_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_coupon_product`
--
ALTER TABLE `oc_coupon_product`
  MODIFY `coupon_product_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_currency`
--
ALTER TABLE `oc_currency`
  MODIFY `currency_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `oc_customer`
--
ALTER TABLE `oc_customer`
  MODIFY `customer_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `oc_customer_activity`
--
ALTER TABLE `oc_customer_activity`
  MODIFY `customer_activity_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_customer_approval`
--
ALTER TABLE `oc_customer_approval`
  MODIFY `customer_approval_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_customer_group`
--
ALTER TABLE `oc_customer_group`
  MODIFY `customer_group_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `oc_customer_history`
--
ALTER TABLE `oc_customer_history`
  MODIFY `customer_history_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_customer_ip`
--
ALTER TABLE `oc_customer_ip`
  MODIFY `customer_ip_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `oc_customer_login`
--
ALTER TABLE `oc_customer_login`
  MODIFY `customer_login_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `oc_customer_reward`
--
ALTER TABLE `oc_customer_reward`
  MODIFY `customer_reward_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_customer_search`
--
ALTER TABLE `oc_customer_search`
  MODIFY `customer_search_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_customer_transaction`
--
ALTER TABLE `oc_customer_transaction`
  MODIFY `customer_transaction_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_custom_field`
--
ALTER TABLE `oc_custom_field`
  MODIFY `custom_field_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_custom_field_value`
--
ALTER TABLE `oc_custom_field_value`
  MODIFY `custom_field_value_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_download`
--
ALTER TABLE `oc_download`
  MODIFY `download_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_event`
--
ALTER TABLE `oc_event`
  MODIFY `event_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `oc_extension`
--
ALTER TABLE `oc_extension`
  MODIFY `extension_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT for table `oc_extension_install`
--
ALTER TABLE `oc_extension_install`
  MODIFY `extension_install_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_extension_path`
--
ALTER TABLE `oc_extension_path`
  MODIFY `extension_path_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_filter`
--
ALTER TABLE `oc_filter`
  MODIFY `filter_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `oc_filter_group`
--
ALTER TABLE `oc_filter_group`
  MODIFY `filter_group_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `oc_geo_zone`
--
ALTER TABLE `oc_geo_zone`
  MODIFY `geo_zone_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `oc_information`
--
ALTER TABLE `oc_information`
  MODIFY `information_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `oc_language`
--
ALTER TABLE `oc_language`
  MODIFY `language_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `oc_layout`
--
ALTER TABLE `oc_layout`
  MODIFY `layout_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `oc_layout_module`
--
ALTER TABLE `oc_layout_module`
  MODIFY `layout_module_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4278;

--
-- AUTO_INCREMENT for table `oc_layout_route`
--
ALTER TABLE `oc_layout_route`
  MODIFY `layout_route_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=525;

--
-- AUTO_INCREMENT for table `oc_length_class`
--
ALTER TABLE `oc_length_class`
  MODIFY `length_class_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `oc_location`
--
ALTER TABLE `oc_location`
  MODIFY `location_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_manufacturer`
--
ALTER TABLE `oc_manufacturer`
  MODIFY `manufacturer_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `oc_marketing`
--
ALTER TABLE `oc_marketing`
  MODIFY `marketing_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_modification`
--
ALTER TABLE `oc_modification`
  MODIFY `modification_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_module`
--
ALTER TABLE `oc_module`
  MODIFY `module_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=82;

--
-- AUTO_INCREMENT for table `oc_newsletter`
--
ALTER TABLE `oc_newsletter`
  MODIFY `news_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `oc_option`
--
ALTER TABLE `oc_option`
  MODIFY `option_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `oc_option_value`
--
ALTER TABLE `oc_option_value`
  MODIFY `option_value_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `oc_order`
--
ALTER TABLE `oc_order`
  MODIFY `order_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `oc_order_history`
--
ALTER TABLE `oc_order_history`
  MODIFY `order_history_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `oc_order_option`
--
ALTER TABLE `oc_order_option`
  MODIFY `order_option_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=80;

--
-- AUTO_INCREMENT for table `oc_order_product`
--
ALTER TABLE `oc_order_product`
  MODIFY `order_product_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `oc_order_recurring`
--
ALTER TABLE `oc_order_recurring`
  MODIFY `order_recurring_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_order_recurring_transaction`
--
ALTER TABLE `oc_order_recurring_transaction`
  MODIFY `order_recurring_transaction_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_order_shipment`
--
ALTER TABLE `oc_order_shipment`
  MODIFY `order_shipment_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_order_status`
--
ALTER TABLE `oc_order_status`
  MODIFY `order_status_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `oc_order_total`
--
ALTER TABLE `oc_order_total`
  MODIFY `order_total_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=108;

--
-- AUTO_INCREMENT for table `oc_order_voucher`
--
ALTER TABLE `oc_order_voucher`
  MODIFY `order_voucher_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_product`
--
ALTER TABLE `oc_product`
  MODIFY `product_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- AUTO_INCREMENT for table `oc_product_discount`
--
ALTER TABLE `oc_product_discount`
  MODIFY `product_discount_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=483;

--
-- AUTO_INCREMENT for table `oc_product_image`
--
ALTER TABLE `oc_product_image`
  MODIFY `product_image_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3523;

--
-- AUTO_INCREMENT for table `oc_product_option`
--
ALTER TABLE `oc_product_option`
  MODIFY `product_option_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=289;

--
-- AUTO_INCREMENT for table `oc_product_option_value`
--
ALTER TABLE `oc_product_option_value`
  MODIFY `product_option_value_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `oc_product_reward`
--
ALTER TABLE `oc_product_reward`
  MODIFY `product_reward_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=657;

--
-- AUTO_INCREMENT for table `oc_product_special`
--
ALTER TABLE `oc_product_special`
  MODIFY `product_special_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=529;

--
-- AUTO_INCREMENT for table `oc_recurring`
--
ALTER TABLE `oc_recurring`
  MODIFY `recurring_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_return`
--
ALTER TABLE `oc_return`
  MODIFY `return_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_return_action`
--
ALTER TABLE `oc_return_action`
  MODIFY `return_action_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `oc_return_history`
--
ALTER TABLE `oc_return_history`
  MODIFY `return_history_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_return_reason`
--
ALTER TABLE `oc_return_reason`
  MODIFY `return_reason_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `oc_return_status`
--
ALTER TABLE `oc_return_status`
  MODIFY `return_status_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `oc_review`
--
ALTER TABLE `oc_review`
  MODIFY `review_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `oc_seo_url`
--
ALTER TABLE `oc_seo_url`
  MODIFY `seo_url_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1467;

--
-- AUTO_INCREMENT for table `oc_setting`
--
ALTER TABLE `oc_setting`
  MODIFY `setting_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11719;

--
-- AUTO_INCREMENT for table `oc_statistics`
--
ALTER TABLE `oc_statistics`
  MODIFY `statistics_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `oc_stock_status`
--
ALTER TABLE `oc_stock_status`
  MODIFY `stock_status_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `oc_store`
--
ALTER TABLE `oc_store`
  MODIFY `store_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_tax_class`
--
ALTER TABLE `oc_tax_class`
  MODIFY `tax_class_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `oc_tax_rate`
--
ALTER TABLE `oc_tax_rate`
  MODIFY `tax_rate_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=89;

--
-- AUTO_INCREMENT for table `oc_tax_rule`
--
ALTER TABLE `oc_tax_rule`
  MODIFY `tax_rule_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=130;

--
-- AUTO_INCREMENT for table `oc_theme`
--
ALTER TABLE `oc_theme`
  MODIFY `theme_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_translation`
--
ALTER TABLE `oc_translation`
  MODIFY `translation_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_upload`
--
ALTER TABLE `oc_upload`
  MODIFY `upload_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `oc_user`
--
ALTER TABLE `oc_user`
  MODIFY `user_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `oc_user_group`
--
ALTER TABLE `oc_user_group`
  MODIFY `user_group_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `oc_voucher`
--
ALTER TABLE `oc_voucher`
  MODIFY `voucher_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_voucher_history`
--
ALTER TABLE `oc_voucher_history`
  MODIFY `voucher_history_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oc_voucher_theme`
--
ALTER TABLE `oc_voucher_theme`
  MODIFY `voucher_theme_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `oc_weight_class`
--
ALTER TABLE `oc_weight_class`
  MODIFY `weight_class_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `oc_zone`
--
ALTER TABLE `oc_zone`
  MODIFY `zone_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4239;

--
-- AUTO_INCREMENT for table `oc_zone_to_geo_zone`
--
ALTER TABLE `oc_zone_to_geo_zone`
  MODIFY `zone_to_geo_zone_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=111;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
