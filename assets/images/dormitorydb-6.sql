-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 22, 2024 at 03:22 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dormitorydb`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `addAnnouncement` (IN `new_title` VARCHAR(255), IN `new_description` TEXT, IN `new_date` VARCHAR(255), IN `new_time` VARCHAR(255))   BEGIN
    INSERT INTO announcements (
        title,
        description,
        date,
        time
    ) VALUES (
        new_title,
        new_description,
        new_date,
        new_time
    );
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `addRoom` (IN `new_room_no` VARCHAR(255), IN `new_occupy_num` INT, IN `new_floor` VARCHAR(255), IN `new_img` TEXT, IN `new_status` VARCHAR(255))   BEGIN
    INSERT INTO room_details (
        room_no,
        occupy_num,
        floor,
        status,
        display_img
    ) VALUES (
        new_room_no,
        new_occupy_num,
        new_floor,
        new_status,
        new_img
    );
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `addTenants` (IN `new_user_id` INT, IN `new_user_type` INT, IN `new_date` VARCHAR(255), IN `new_room_id` INT, IN `new_eqiupments` TEXT, IN `new_additional_fee` DOUBLE, IN `new_monthly` DOUBLE)   BEGIN
    INSERT INTO tenants (
        user_id,
        room_id,
        date,
        tenant_type,
        equipments,
        additional_fee,
      	monthlyrate
    ) VALUES (
        new_user_id,
        new_room_id,
        new_date,
        new_user_type,
        new_eqiupments,
        new_additional_fee,
        new_monthly
    );
    
    UPDATE users
    SET status = 'Tenant'
    WHERE id = new_user_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `editAnnouncement` (IN `new_title` VARCHAR(255), IN `new_description` TEXT, IN `new_date` VARCHAR(255), IN `new_time` VARCHAR(255), IN `new_id` INT)   BEGIN
    UPDATE announcements
    SET
        title = new_title,
        description = new_description,
        date = new_date,
        time = new_time
    WHERE
        id = new_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `editRoom` (IN `new_room_no` VARCHAR(255), IN `new_occupy_num` INT, IN `new_floor` INT, IN `new_status` VARCHAR(255), IN `new_img` TEXT, IN `new_room_id` INT)   BEGIN
    UPDATE room_details
    SET
        room_no = new_room_no,
        occupy_num = new_occupy_num,
        floor = new_floor,
        status = new_status,
        display_img = new_img
    WHERE room_id = new_room_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_room_details` (`room_id_val` INT)   BEGIN
    DECLARE room_count INT;
    DECLARE occupy_num INT;

    -- Get the count of tenants per room_id
    SET room_count = (SELECT COUNT(*) FROM tenants WHERE room_id = room_id_val);

    -- Get the occupy_num for the room
    SET occupy_num = (SELECT occupy_num FROM room_details WHERE room_id = room_id_val);

    IF room_count = occupy_num THEN
        -- Update room status to Occupied
        UPDATE room_details SET status = 'Occupied' WHERE room_id = room_id_val;
    ELSEIF room_count > 0 THEN
        -- Update room status to Lacking
        UPDATE room_details SET status = 'Lacking' WHERE room_id = room_id_val;
    ELSE
        -- Update room status to Available
        UPDATE room_details SET status = 'Available' WHERE room_id = room_id_val;
    END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `announcements`
--

CREATE TABLE `announcements` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `date` varchar(255) NOT NULL,
  `time` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `announcements`
--

INSERT INTO `announcements` (`id`, `title`, `description`, `date`, `time`) VALUES
(12, 'Movie Night in the Dorm Lounge!', 'Hey Dorm Dwellers! 🍿🎬 Get ready for a cozy night filled with cinematic delights! Join us for a Community Movie Night in the Dorm Lounge this Friday at 7:00 PM. We\'ll be screening a popular film, complete with free popcorn and comfy bean bags. It\'s the perfect opportunity to unwind, mingle with your fellow residents, and enjoy some great entertainment. Don\'t miss out on the fun – mark your calendars and bring your friends along! See you there!', '2024-03-23', '23:57'),
(13, 'Dormitory Study Jam Session!', 'Attention Scholars! 📚✨ Are you looking for a focused study environment? Join us for a Dormitory Study Jam Session in the common area this Saturday from 2:00 PM to 6:00 PM. Bring your books, laptops, and study materials, and let\'s boost our productivity together. We\'ll provide snacks, drinks, and a quiet atmosphere conducive to effective studying. It\'s time to conquer those exams – see you at the Study Jam!', '2024-04-09', '03:33'),
(14, 'Dorm Decorating Contest – Let\'s Get Creative!', 'Calling all interior design enthusiasts! 🎨✨ It\'s time for the Dorm Decorating Contest. Show off your creativity and make your living space uniquely yours! The contest starts on Monday, and judging will take place on Friday. There will be fantastic prizes for the most innovative and stylish dorm rooms. Let\'s see who can transform their space into the ultimate expression of personal style. Get ready to unleash your decorating prowess!', '2024-04-22', '07:01'),
(15, ' Dormitory Potluck Dinner Extravaganza!', 'Foodies unite! 🍲🥗 Join us for a Dormitory Potluck Dinner Extravaganza on Wednesday at 6:30 PM in the communal kitchen. Bring your favorite dish to share with your fellow residents and indulge in a diverse spread of delicious homemade treats. Whether you\'re a master chef or a novice in the kitchen, this is your chance to showcase your culinary skills. Let\'s savor the flavors of friendship and good food together. See you at the Potluck!', '2024-03-27', '06:48');

-- --------------------------------------------------------

--
-- Table structure for table `complain`
--

CREATE TABLE `complain` (
  `id` int(11) NOT NULL,
  `complain` text NOT NULL,
  `tenants_id` int(11) NOT NULL,
  `date` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `complain`
--

INSERT INTO `complain` (`id`, `complain`, `tenants_id`, `date`) VALUES
(3, 'asdd', 4, '2024-04-21'),
(4, 'asdd', 4, '2024-04-21'),
(5, 'ahaahahaha', 4, '2024-04-21'),
(6, 'jajajajja', 4, '2024-04-21'),
(7, 'ahahaha', 20, '2024-04-21'),
(8, 'wewew', 20, '2024-04-21'),
(9, 'wewew', 20, '2024-04-21'),
(10, 'asdada', 20, '2024-04-21');

-- --------------------------------------------------------

--
-- Table structure for table `ip_details`
--

CREATE TABLE `ip_details` (
  `id` int(11) NOT NULL,
  `ip` varchar(255) NOT NULL,
  `login_time` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `payment_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `amount` double NOT NULL,
  `month_of` varchar(55) NOT NULL,
  `date` varchar(11) NOT NULL,
  `receipt_img` text NOT NULL,
  `status` varchar(255) NOT NULL,
  `reason` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`payment_id`, `user_id`, `amount`, `month_of`, `date`, `receipt_img`, `status`, `reason`) VALUES
(100018, 20, 3000, 'April 01, 2024 - May 01, 2024', '2024-04-21', '94869d6f4e3ae217_7718868.jpg', 'Verified', ''),
(100019, 19, 5000, 'May 20, 2024 - June 20, 2024', '2024-04-21', 'ff7ff43ed4b4ab69_537392644dc30eb6fe9769ed2170e119.jpg', 'Rejected', 'wala lang'),
(100020, 21, 0, 'January 16, 2024 - February 16, 2024', '2024-04-21', 'c36cad589f7164e8_albert-stoynov-2e_ouWKCiw8-unsplash.jpg', 'Pending', '');

-- --------------------------------------------------------

--
-- Table structure for table `room_details`
--

CREATE TABLE `room_details` (
  `room_id` int(11) NOT NULL,
  `room_no` varchar(255) NOT NULL,
  `occupy_num` varchar(100) NOT NULL,
  `floor` varchar(20) NOT NULL,
  `status` varchar(100) NOT NULL,
  `display_img` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `room_details`
--

INSERT INTO `room_details` (`room_id`, `room_no`, `occupy_num`, `floor`, `status`, `display_img`) VALUES
(4, 'Room 101', '4', '1', 'Occupied', '3af8a32ef060a879_room1.jpg'),
(5, 'Room 201', '4', '2', 'Lacking', '6e06dfb0f1d42c5e_new.jpg'),
(6, 'Room 301', '4', '3', 'Available', '3af8a32ef060a879_room1.jpg'),
(7, 'Room 102', '4', '1', 'Available', '3af8a32ef060a879_room1.jpg'),
(8, 'Room 103', '4', '1', 'Available', '13b52a4392f63e56_room1.jpg'),
(9, 'Room 104', '1', '1', 'Occupied', '3af8a32ef060a879_room1.jpg'),
(10, 'Room 105', '4', '1', 'Lacking', '3af8a32ef060a879_room1.jpg'),
(11, 'Room 202', '4', '2', 'Available', 'f2b39b7b818ef938_new.jpg'),
(12, 'Room 203', '2', '2', 'Available', 'd7a59ebc3b2a153c_new.jpg'),
(13, 'Room 204', '4', '2', 'Available', '69f82df2cdb33158_new.jpg'),
(14, 'Room 205', '4', '2', 'Available', '8bf899bdac75342f_new.jpg'),
(15, 'Room 302', '4', '3', 'Available', '3af8a32ef060a879_room1.jpg'),
(16, 'Room 303', '4', '3', 'Lacking', '3af8a32ef060a879_room1.jpg'),
(17, 'Room 304', '4', '3', 'Available', '3af8a32ef060a879_room1.jpg'),
(18, 'Room 106', '4', '1', 'Lacking', 'b2c829409f06a943_0afd1ffd374e3934_patrick-perkins-Hh0Hz9crRjc-unsplash.jpg'),
(19, 'Room 107', '4', '1', 'Available', '6e034b544f172520_room1.jpg'),
(20, 'Room 108', '4', '1', 'Available', '656298f5c9173b91_room1.jpg'),
(21, 'Room 109', '4', '1', 'Available', '2c569ff4614afa1e_room1.jpg'),
(22, 'Room 110', '4', '1', 'Available', 'e953a75d59fb290b_room1.jpg'),
(23, 'Room 111', '4', '1', 'Available', '091deb3669d5753f_room1.jpg'),
(24, 'Room 112', '4', '1', 'Available', '2f3c61998ad1e21c_room1.jpg'),
(25, 'Room 206', '4', '2', 'Available', '909d0f8121e7a963_new.jpg'),
(26, 'Room 207', '4', '2', 'Available', '093ca2792c8b6af5_new.jpg'),
(27, 'Room 208', '4', '2', 'Available', '304e77c40241bec3_new.jpg'),
(28, 'Room 209', '4', '2', 'Available', '8cb8388c59f09750_new.jpg'),
(29, 'Room 210', '4', '2', 'Available', '7cc55abdb596c6af_new.jpg'),
(30, 'Room 211', '4', '2', 'Available', '4152aa4689f9b578_new.jpg'),
(31, 'Room 212', '4', '2', 'Available', 'd52f16a0d28ac182_new.jpg'),
(32, 'Room 213', '4', '2', 'Available', 'cca6227e71220806_new.jpg'),
(33, 'Room 214', '4', '2', 'Available', '17cb92347e98ad66_new.jpg'),
(34, 'Room 305', '4', '3', 'Available', 'ca7f37643903742e_room1.jpg'),
(35, 'Room 306', '4', '3', 'Available', 'b01e5a86ee352fb7_room1.jpg'),
(36, 'Room 307', '4', '3', 'Available', 'a1eac591b0f09150_room1.jpg'),
(37, 'Room 308', '4', '3', 'Available', 'a15f683e0d738010_room1.jpg'),
(38, 'Room 309', '4', '3', 'Available', 'aa117cbffd468812_room1.jpg'),
(39, 'Room 310', '4', '3', 'Available', 'bf014113674d134d_room1.jpg'),
(40, 'Room 311', '4', '3', 'Available', '5dab9f208b362627_room1.jpg'),
(41, 'Room 312', '4', '3', 'Available', '7cd8b723318f3aee_room1.jpg'),
(42, 'Room 113', '4', '1', 'Available', 'ee851c5f6186bc1d_room1.jpg'),
(43, 'Room 313', '4', '3', 'Available', '75d8cc14e7ada2af_room1.jpg'),
(44, 'Room 314', '4', '3', 'Available', '079684f1f94c5195_room1.jpg'),
(45, 'dwad', '2', '1', 'Available', '4a258e34cb1aa5f1_aboodi-vesakaran-Pu9jwdVNiVI-unsplash.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `room_img`
--

CREATE TABLE `room_img` (
  `img_id` int(11) NOT NULL,
  `img_name` text NOT NULL,
  `room_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `survey`
--

CREATE TABLE `survey` (
  `id` int(11) NOT NULL,
  `question1` varchar(255) NOT NULL,
  `question2` varchar(255) NOT NULL,
  `question3` varchar(255) NOT NULL,
  `question4` varchar(255) NOT NULL,
  `question5` varchar(255) NOT NULL,
  `tenants_id` int(11) NOT NULL,
  `date` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tenants`
--

CREATE TABLE `tenants` (
  `tenants_id` int(100) NOT NULL,
  `user_id` int(11) NOT NULL,
  `room_id` int(11) NOT NULL,
  `Date` varchar(11) NOT NULL,
  `tenant_type` int(11) NOT NULL,
  `additional_fee` double NOT NULL,
  `equipments` text NOT NULL,
  `monthlyrate` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tenants`
--

INSERT INTO `tenants` (`tenants_id`, `user_id`, `room_id`, `Date`, `tenant_type`, `additional_fee`, `equipments`, `monthlyrate`) VALUES
(232, 11, 18, '2024-04-01', 2, 2000, 'Rice cooker', 8000),
(234, 12, 18, '2024-04-02', 2, 1000, 'Heater', 1000),
(236, 13, 10, '2024-04-04', 2, 100, 'Rice cooker', 0),
(238, 14, 18, '2024-04-06', 2, 100, 'Heater', 0),
(240, 16, 10, '2024-04-09', 2, 200, 'Rice cooker, Heater', 0),
(242, 15, 16, '2024-04-12', 2, 200, 'Rice cooker, Heater', 0),
(244, 17, 9, '2024-04-15', 1, 200, 'Rice cooker, Heater', 0),
(246, 18, 4, '2024-04-04', 1, 300, 'Aircon', 0),
(249, 19, 4, '', 1, 700, '', 700),
(263, 20, 4, '', 1, 200, 'asdad', 300),
(264, 21, 4, '', 2, 100, 'Rice coocker', 100),
(265, 22, 5, '2024-04-22', 1, 100, 'Rice coocker', 100);

--
-- Triggers `tenants`
--
DELIMITER $$
CREATE TRIGGER `update_room_status_after_delete` AFTER DELETE ON `tenants` FOR EACH ROW BEGIN
    CALL update_room_details(OLD.room_id);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_room_status_insert` AFTER INSERT ON `tenants` FOR EACH ROW BEGIN
    DECLARE room_id_val INT;
    DECLARE done INT DEFAULT FALSE;
    DECLARE cur CURSOR FOR SELECT DISTINCT room_id FROM tenants;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO room_id_val;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Get the count of tenants per room_id
        SET @room_count := (SELECT COUNT(*) FROM tenants WHERE room_id = room_id_val);
    
        -- Get the occupy_num for the room
        SET @occupy_num := (SELECT occupy_num FROM room_details WHERE room_id = room_id_val);
    
        IF @room_count = @occupy_num THEN
            -- Update room status to Occupied
            UPDATE room_details SET status = 'Occupied' WHERE room_id = room_id_val;
        ELSEIF @room_count > 0 THEN
            -- Update room status to Lacking
            UPDATE room_details SET status = 'Lacking' WHERE room_id = room_id_val;
        ELSE
            -- Update room status to Available
            UPDATE room_details SET status = 'Available' WHERE room_id = room_id_val;
        END IF;
    END LOOP;

    CLOSE cur;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_room_status_update` AFTER UPDATE ON `tenants` FOR EACH ROW BEGIN
    DECLARE room_id_val INT;
    DECLARE done INT DEFAULT FALSE;
    DECLARE cur CURSOR FOR SELECT DISTINCT room_id FROM tenants;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO room_id_val;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Get the count of tenants per room_id
        SET @room_count := (SELECT COUNT(*) FROM tenants WHERE room_id = room_id_val);
    
        -- Get the occupy_num for the room
        SET @occupy_num := (SELECT occupy_num FROM room_details WHERE room_id = room_id_val);
    
        IF @room_count = @occupy_num THEN
            -- Update room status to Occupied
            UPDATE room_details SET status = 'Occupied' WHERE room_id = room_id_val;
        ELSEIF @room_count > 0 THEN
            -- Update room status to Lacking
            UPDATE room_details SET status = 'Lacking' WHERE room_id = room_id_val;
        ELSE
            -- Update room status to Available
            UPDATE room_details SET status = 'Available' WHERE room_id = room_id_val;
        END IF;
    END LOOP;

    CLOSE cur;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tenant_type`
--

CREATE TABLE `tenant_type` (
  `tenant_type_id` int(11) NOT NULL,
  `description` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tenant_type`
--

INSERT INTO `tenant_type` (`tenant_type_id`, `description`) VALUES
(1, 'Teacher'),
(2, 'Student');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `contact` varchar(25) NOT NULL,
  `gender` varchar(10) NOT NULL,
  `uid` text NOT NULL,
  `pwd` text NOT NULL,
  `status` varchar(255) NOT NULL,
  `display_img` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `contact`, `gender`, `uid`, `pwd`, `status`, `display_img`) VALUES
(4, 'John ford S. Sajor', '09705443110', 'Male', 'admin', '$2y$10$5RROmhkXS0RHQnExZFOnueXN4/DDrXtkta2tNhCDBTuwtHwk.zJE6', 'admin', '4_profile.jpg'),
(11, 'Mary Joy C. Perudez', '+639631921501', 'Female', 'maryjoy', '$2y$10$qEBIsBAmnY.1X6xxV72c1OVUJKGmWGtty091TsZfmh.1B17ifXkmm', 'Tenant', '0b590c0421a31257_face23.jpg'),
(12, 'Mary Jane C. Balbuena', '+639306094979', 'Female', 'maryjane', '$2y$10$jMc3D2AWDet9yFk1N7zaCuIo7M3l..Iz8q/rg6yaS0FjkzOpZNhd2', 'Tenant', 'ee692cfb3dd21221_face6.jpg'),
(13, 'Jonalyn T. Platil', '+639631921501', 'Female', 'jonalyn', '$2y$10$tD/bkQl3fyYA8OjbBNnqNubzJNdWYLA1sjVNp239vV/sdSskE5XcS', 'Tenant', '5034daa0794f13d8_face11.jpg'),
(14, 'Nena Mae C. De Leon', '+639294212982', 'Female', 'nenamae', '$2y$10$IStEV0.P8.DV/mlKiGmUw.zX4TLD67DaQ.Bg0hD0g62.ANNCpf11i', 'Tenant', 'a31956b5c6d0b4a8_face26.jpg'),
(15, 'Rogen Magdasal', '+639631921501', 'Male', 'rogen', '$2y$10$1HCx1YMIY8LGFktg1L9hwunPByBsC/43jb6BHKAzB62zEDh1ewCV2', 'Tenant', '37259544cdf5e0b5_face16.jpg'),
(16, 'Gelma A. Alabat', '+639102553609', 'Female', 'gelmz', '$2y$10$kgVu/S2T5o/7nE0NcDHAyeiFEKWieuvNVYXSbuKk/XoAOmJX52RHe', 'Tenant', '15d3a2a549aa1529_face2.jpg'),
(17, 'Ailee Consuegra', '+639621921502', 'Female', 'april', '$2y$10$iihx5LmDanolbnhzwNNGIOUC2G7Ph5PDHcKqkuwMUzsH6BBMQSS7G', 'Tenant', '595a9714d3116517_face10.jpg'),
(18, 'ronald', '09', 'Male', 'ungarts', '$2y$10$ZoS0TGA5UEKGr3DQ/9Qf1.wcPbfBS8M3wlQ./US3lhbzirMPybpgm', 'Tenant', 'e2c83e9e80b61c4b_Wooden-Handle-Hoe-Agricultural-Weeding-Reclamation-Hoe-Rake-Farming-Tools.webp'),
(19, 'Jumamil, Nyko ', '94212121', 'Male', 'titi1', '$2y$10$kzvz8PFtuYpf9lKwyPB83OQl/92WobOowwCjVOeolqsNLAEnHtvg.', 'Tenant', 'b123ca1993c88788_IMG_20221106_115933.jpg'),
(20, 'Jezmahboi', '090906760223', 'Male', 'jez', '$2y$10$wai99jajK4Ze6dN31BJ.yu3Sp8AdiJjWTgeXTzrCnL7lrf4mu7QJy', 'Tenant', 'f42f3162a1ffdcd2_435062458_2110322669339841_8708798166515378548_n.jpg'),
(21, 'John Dave', '09465707514', 'Male', 's', '$2y$10$Amv/aQ/70TKSFbIhBvb/wOFSgKSo5qAMWFR6GnLio0UvFqKXJT2Me', 'Tenant', '7fe7380b0cd55d24_albert-stoynov-nYIJfyLpJB0-unsplash.jpg'),
(22, 'dawdwad', '32142', 'Male', 'a', '$2y$10$WhJU.dMv6kUNR8tGg.Z8Euuro/QKYktv1/L8cM0NrVfo2rR14/dTu', 'Tenant', 'b217f2b020b6a89f_aboodi-vesakaran-Pu9jwdVNiVI-unsplash.jpg');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `announcements`
--
ALTER TABLE `announcements`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `complain`
--
ALTER TABLE `complain`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ip_details`
--
ALTER TABLE `ip_details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`payment_id`);

--
-- Indexes for table `room_details`
--
ALTER TABLE `room_details`
  ADD PRIMARY KEY (`room_id`);

--
-- Indexes for table `room_img`
--
ALTER TABLE `room_img`
  ADD PRIMARY KEY (`img_id`);

--
-- Indexes for table `survey`
--
ALTER TABLE `survey`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tenants`
--
ALTER TABLE `tenants`
  ADD PRIMARY KEY (`tenants_id`);

--
-- Indexes for table `tenant_type`
--
ALTER TABLE `tenant_type`
  ADD PRIMARY KEY (`tenant_type_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `announcements`
--
ALTER TABLE `announcements`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `complain`
--
ALTER TABLE `complain`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `ip_details`
--
ALTER TABLE `ip_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=100021;

--
-- AUTO_INCREMENT for table `room_details`
--
ALTER TABLE `room_details`
  MODIFY `room_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `room_img`
--
ALTER TABLE `room_img`
  MODIFY `img_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `survey`
--
ALTER TABLE `survey`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tenants`
--
ALTER TABLE `tenants`
  MODIFY `tenants_id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=266;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
