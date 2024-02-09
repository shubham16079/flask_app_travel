-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3308
-- Generation Time: Feb 09, 2024 at 05:28 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `travel_new`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `image` varchar(100) NOT NULL,
  `slug` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `image`, `slug`) VALUES
(1, 'Adventure', 'adventure.jpeg', 'adventure'),
(2, 'Art', 'art.jpeg', 'art'),
(3, 'Heritage', 'heritage.jpeg', 'heritage'),
(4, 'Shopping', 'shopping.jpeg', 'shopping'),
(5, 'Spiritual', 'spritual.jpeg', 'spiritual'),
(6, 'Luxury', 'luxury.jpeg', 'luxury'),
(7, 'Craft', 'craft.jpeg', 'craft'),
(8, 'Museums', 'museums.jpeg', 'museums'),
(9, 'Unesco', 'unesco.jpeg', 'unesco'),
(10, 'Yoga', 'yoga.jpeg', 'yoga'),
(11, 'Food', 'food.jpeg', 'food'),
(12, 'Nature', 'nature.jpeg', 'nature');

-- --------------------------------------------------------

--
-- Table structure for table `destinations`
--

CREATE TABLE `destinations` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `location` int(11) DEFAULT NULL,
  `slug` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `slider_image` varchar(100) DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `category` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `destinations`
--

INSERT INTO `destinations` (`id`, `name`, `description`, `location`, `slug`, `image`, `slider_image`, `status`, `category`, `created_at`) VALUES
(1, 'Delhi The captivating capital', 'With old monuments and busy neighbourhoods subtly merging with a vibrant and contemporary cosmopolitan world, Delhi, the capital of India, is a fascinating tourist destination. Poised along the banks of River Yamuna, Delhi, which is almost 1,000 years old, offers a mesmeric mosaic of experiences, both heritage and contemporary. While the former honour the elegant ageing of centuries-old Delhi, the latter reiterate that the capital is the heart of Indian democracy, and can keep pace with the most advanced of the metropolitans of the world.', 33, 'delhi', 'lalkila.jpg', 'delhi_slider.jpg', 'active', 3, '2024-02-09 09:34:24'),
(2, 'Agra City of the Taj Mahal', 'The city of the Taj Mahal, one of the seven wonders of the world, Agra in Uttar Pradesh is India\'s most popular tourist destination. Steeped in history, this ancient city is dotted with monuments, architectural wonders and beautifully landscaped gardens, which are remnants of the Mughal reign\'s majestic legacy.  The city also enjoys a vibrant culinary scene while preserving its exquisite arts and crafts.', 26, 'agra', 'taj.jpg', 'agra.avif', 'active', 3, '2024-02-09 09:37:28'),
(3, 'Jaipur City of Palaces', 'The city of palaces and forts, interspersed with historical monuments and gardens that testify the grandeur of the Rajput kings, Jaipur is the gateway to the royal heritage of India. Also called Pink City, the capital of Rajasthan, remains suspended in time, with its heritage preserved in the overwhelming Hawa Mahal that gazes down at the bustling streets of Johari Bazaar.', 21, 'jaipur', 'hawamahal.png', 'jaipur.jpg', 'active', 3, '2024-02-09 09:40:45'),
(4, 'Mumbai The City of Dreams', 'Mumbai, the capital of Maharashtra, attracts dreamers with sky-high ambitions from every corner of the country. It is a unique place where the past is mixed with the future and history meets modernity, a city that lies at the cross section of business and entertainment and beats to a pulsating rhythm of its own. Located by the Arabian Sea, Mumbai is an amalgamation of heritage and culture and glitz and glamour. So from historic art deco buildings, which are recognised by the UNESCO, to plush new-age homes of the super rich, Mumbai has it all! ', 14, 'mumbai', 'mum.jpg', 'mumbai.jpg', 'active', 6, '2024-02-09 09:43:09'),
(5, 'Varanasi City of Lights', 'One of the oldest living inhabitations of the world, the sacred city of Varanasi or Benaras, nestled on the banks of the holy Ganges river, has been attracting pilgrims for centuries. Celebrated author Mark Twain, who visited India in the last decade of the 19th century, described the city as “older than history, older than tradition, older even than legend.”', 26, 'varanasi', 'kashi_vishwanath.avif', 'kashi_slider.jpg', 'active', 5, '2024-02-09 09:45:03'),
(6, 'Chennai Cornucopia of cultures', 'Ancient temples, vibrant arts, natural wonders and a bustling culinary scene make  Chennai, the capital of Tamil Nadu, one of the most popular tourist destinations in the southern fringes of the country. Located on the Coromandel Coast, this busy metropolis was formerly called Madras. From the resplendent classical dance form of bharatnatyam to the rich flavours of its iconic cuisine and from the lustrous silk sarees traded here to the gorgeous temples and churches, Chennai is the gatekeeper of South Indian art, culture and traditions. The city is also the perfect base from which trips to other locales in Tamil Nadu can take off. ', 23, 'chennai', 'chennai_image.webp', 'chennai.jpg', 'active', 5, '2024-02-09 09:51:53'),
(7, 'Goa Land of sun, sand and spices', 'The pocket-sized paradise of Goa is a traveller\'s dream. Sun, sea, sand, spices, spirituality and seafood, along with a balmy weather, call to the soul of trekkers, backpackers, nature lovers and those who simply want to languish in its slow-paced and relaxed vibes. Located by the glistening waters of the Arabian Sea on India’s western coast, the state of Goa is renowned for its breathtaking beaches, rich culture and pristine natural beauty. Formerly a Portuguese colony, Goa offers travellers a chance to experience a unique blend of sandy shores, forests, monuments and delectable cuisine, attracting tourists across age groups.', 6, 'goa', 'goa.jpg', 'goa.webp', 'active', 1, '2024-02-09 09:54:59'),
(8, 'Rishikesh Yoga capital of the world', 'Nestled in the Himalayan foothills, Rishikesh is one of the most sacred cities in northern India. Located in the state of Uttarakhand, Rishikesh is the hub of sages, yoga practitioners and pilgrims, who throng the ghats (stepped banks of a river) and temples. In recent times, it has also become a centre point of adventure sports, offering activities like white water rafting, bungee jumping, canoeing and others. Ever since the Beatles arrived at Maharishi Mahesh Yogi’s ashram here in the 1960s, looking for peace and inspiration for their music, Rishikesh has been a favourite destination for soul-seeking. Often called the yoga capital of the world, the tranquil forested slopes on the city’s outskirts are dotted with ashrams (places of spirituality and meditation), yoga institutes and luxurious spa resorts. The city sees a flurry of activity during February-March, as it plays host to dignitaries and yoga enthusiasts who come to take part in the International Yoga Week, organised by the State Tourism Department. Rishikesh is also noted for Ayurveda, and is home to several institutes offering education in the same. It is also known for its yoga schools, some of which are highly esteemed.', 27, 'rishikesh', 'adventure.jpeg', 'rishikesh.webp', 'active', 1, '2024-02-09 10:20:13'),
(9, 'Shimla Queen of the hills', 'Enveloped in mist, nestled within dense forests and silhouetted against snowy peaks of the mighty Himalayas, Shimla is a paradise in the hills. From its British-era lodges that take you back to the old-world to the bustling 12-km-long Ridge, the heartbeat of the city, Shimla, in Himachal Pradesh, is among the most popular hill stations in India. Ringed by seven lofty hills, Shimla is an ideal summer holiday destination and equally popular in winter, when a blanket of snow covers it. An ideal getaway to experience thrilling and adrenaline-pumping sports like skiing, trekking, paragliding and ice skating,', 9, 'shimla', 'yoga.jpeg', 'shimla.jpg', 'active', 1, '2024-02-09 10:25:19'),
(10, 'Bhuj Beauty in Aridness', 'Enchanting and eclectic, the expansive city of Bhuj, the capital of the Kutch region, ensconced in the state of Gujarat, is like a continuous cultural fiesta. A launchpad to admire the mesmerising beauty of the Great Rann of Kutch, Bhuj also invites visitors for its rich textile heritage. At the epicentre is the renowned Rann Utsav, which is a cultural extravaganza suspended in time.', 7, 'bhuj', 'bhuj.webp', 'bhuj_slider.jpg', 'active', 4, '2024-02-09 10:48:30');

-- --------------------------------------------------------

--
-- Table structure for table `experiences`
--

CREATE TABLE `experiences` (
  `id` int(11) NOT NULL,
  `destination` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `landmark` text NOT NULL,
  `slug` varchar(255) NOT NULL,
  `category` int(11) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `slider_image` varchar(100) DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `experiences`
--

INSERT INTO `experiences` (`id`, `destination`, `name`, `description`, `landmark`, `slug`, `category`, `image`, `slider_image`, `status`) VALUES
(68, 5, 'Ganga Ghats', 'A visit to Varanasi cannot be complete without a visit to the ghats running along River Ganges. The ghats have been a source of inspiration for artists, film-makers, photographers, writers and musicians for centuries. There are about 88 ghats in the city and most of them are used as bathing sites while a few, like Manikarnika Ghat, are exclusively designated for cremation purposes. As a dip in Ganga is considered holy in the Hindu religion, most of the ghats are dedicated to religious rituals, the most popular being Dashashwamedh. At one end of the line of ghats, is Assi, which is famous for morning yoga sessions. The evening arti (a religious ritual with lamps) at the ghats, primarily at Dashashwamedh, is a sight to behold. One of the more visually spectacular ghats is the Lalita Ghat. ', 'Nearby Godoliya', 'ganga-varanasi', 5, 'ganga.webp', 'kashi_slider.jpg', 'active'),
(69, 5, 'Banaras Hindu University', 'The Banaras Hindu University (BHU) is one of the oldest varsities in India. It was founded by renowned social reformer and freedom fighter Pandit Madan Mohan Malaviya, in 1916, with the assistance of British socialist Dr Annie Besant. The sprawling 1,300-acre main university campus located on the outskirts of Varanasi was built on land donated by the ruler of Kashi. The university counts many freedom fighters, as well as a great number of scholars, artistes and scientists among its alumni. With well-maintained roads, a large temple, an airstrip and several buildings of architectural significance, the university, with a dense green cover, resembles a sub-city. Its wide streets are lined with trees on either side and make for great walking avenues. With accommodation available for over 30,000 students within the main campus, BHU is one of the largest residential universities in Asia. One should visit this campus for its unique buildings and a museum called Bharat Kala Bhavan, which lies within the premises. The museum houses miniature paintings, palm-leaf manuscripts, sculptures and history displays. These highly valuable archives are more than a lakh in number. One can also interact with the locals and students while visiting the campus.', 'Banaras Hindu University', 'banarashinduuniversity', 3, 'banarasuni.jpeg', 'banarasuni.jpeg', 'active'),
(70, 5, 'Kaimoor Wildlife Sanctuary', 'The Kaimoor Wildlife Sanctuary is a serene forested area located around 100 km from Varanasi. Spread over an area of 1,342 sq km, the sanctuary is dotted with several waterfalls, of which the finest are, Karkat and Telhar falls. The sanctuary is most famous for its blackbuck population and is home to several other animals like tiger, leopard, wild boar, sloth bear, sambar deer, chital, four-horned antelope and nilgai. Apart from these, crocodiles, pythons and other different species of snakes are also found. The place is a paradise for birdwatchers who can spot more than 70 species of resident birds during the year, along with many migratory birds. Some of the common bird species that one can find here are the brahmini duck, pintail, red-crested poacher, coot, common teal, mallard and tufted duck. Visitors can go up to watchtowers or to the waterholes to get good views.', '100 KM from varanasi', 'kaimoor', 12, 'kaimoor.jpeg', 'kaimoor.jpeg', 'active'),
(71, 4, 'Elephanta Caves', 'One of the best things about Mumbai is the sea and the access it provides for quick day-time trips to nearby beaches and islands. Less than an hour\'s boat ride from the Gateway of India, in Colaba, lies the Elephanta Island colloquially known as Gharapuri or the Fortress City. The scenic island stretches across 10 to 15 sq km of land and has a dense foliage of mango, tamarind and palm trees. Perfect for a weekend excursion, this island provides good trekking as well as picnic opportunities. The island gets its name from a giant stone sculpture of an elephant that was discovered by the 16th century Portuguese explorers who came to this area. The island owes its global popularity to the fact that it is home to a network of ancient rock-cut caves known as the Elephanta caves that boast artistic wall carvings and sculptures, dedicated to Hindu and Buddhist gods. These caves were incorporated in the UNESCO list of World Heritage sites in the early 1980s. The walls of the caves, which are located on top of a hillock, are lined with rock art that experts say, dates as far back as the mid- 5th and 6th century. There are two main hills on the island – Gun Hill and Stupa Hill. The former gets its name from the two British-era canons perched on it and the latter because of the remains of a Buddhist stupa that was excavated here. The most intricately detailed and architecturally majestic cave, among the Elephanta network is situated on Gun Hill. The panels on these caves depict the lives and beliefs of the esoteric Pashupati sect of the Shaiva system. A 7-m-high sculpture called Sadashiva lies at the entrance of the cave. ', 'Mumbai', 'elephanta', 3, 'elephanta.jpg', 'elephanta.jpg', 'active'),
(72, 8, 'River rafting in rishikesh', 'Nestled in the Himalayan foothills, Rishikesh is one of the most sacred cities in northern India. Located in the state of Uttarakhand, Rishikesh is the hub of sages, yoga practitioners and pilgrims, who throng the ghats (stepped banks of a river) and temples. In recent times, it has also become a centre point of adventure sports, offering activities like white water rafting, bungee jumping, canoeing and others. Ever since the Beatles arrived at Maharishi Mahesh Yogi’s ashram here in the 1960s, looking for peace and inspiration for their music, Rishikesh has been a favourite destination for soul-seeking. Often called the yoga capital of the world, the tranquil forested slopes on the city’s outskirts are dotted with ashrams (places of spirituality and meditation), yoga institutes and luxurious spa resorts. The city sees a flurry of activity during February-March, as it plays host to dignitaries and yoga enthusiasts who come to take part in the International Yoga Week, organised by the State Tourism Department. Rishikesh is also noted for Ayurveda, and is home to several institutes offering education in the same. It is also known for its yoga schools, some of which are highly esteemed.', 'laxman jhula', 'river-rafting-rishikesh', 1, 'ganga.webp', 'raft.webp', 'active'),
(73, 9, 'Skiing in manali', 'In winter, skiing can be enjoyed in the stunning Solang Valley, which is located approximately 12 km from Manali. It is also called Solang Nala and hosts a ski festival every year that attracts thousands of tourists. Before skiing, one is given expert guidance and assistance sessions. One can also ski at Rohtang, Gulaba, Dhundi and Marhi.', 'Solang Valley', 'skiingmanali', 1, 'skiing.jpg', 'skiing.jpg', 'active'),
(74, 9, 'Paragliding', 'A hotbed for paragliding, the slopes and peaks around Manali are dotted with paragliders in summer months. From beginners to professionals, there are options for everyone. ', 'Solang Valley', 'paragliding-manali', 1, 'paragliding.webp', 'paragliding.webp', 'active'),
(75, 9, 'Shopping in old manali', 'Mall Road in old Manali offers several options for shopping. From handcrafted wooden trinkets to woollen shawls and Buddhist prayers wheels, Manali is a shopping paradise. The Tibetan Market is a great place to buy shawls, silver jewellery, rugs and bamboo trinkets. ', 'manali', 'shopping-manali', 4, 'shopping.jpeg', 'shopping.jpeg', 'active'),
(76, 4, 'Golf in mumbai', 'Whether you are travelling for work or leisure, if you are a golfing enthusiast, the need to tee off is always felt. India flaunts some of the most scenic golf courses in the world and these are located in far-flung locations that you wouldn’t normally associate with the sport. The hill stations in the north and south of India are represented by Pahalgam, Shimla, and Kodaikanal Golf Courses. Another course down south is the prestigious Coimbatore Golf Course. There is also the Jamshedpur Golf Course that is more than half a decade old. Most of these are 18-hole golf courses that are equipped with sand pits and other obstacles, offering much enjoyment to golfers. You will also notice that their locations are a mix of commercial centres as well as spots that are usually sought-after by pleasure-seekers. ', 'mumbai', 'golf-in-mumbai', 6, 'golf.jpg', 'golf.jpg', 'active'),
(77, 3, 'Art', 'The land where classical melodies merge seamlessly with a mesmerising mosaic of exquisite paintings, ancient weaves and other handicrafts, divine dance forms, fascinating festivals and scintillating sculptures, India is a vibrant potpourri of arts and crafts. With each of its states and union territories bursting with ethnic flavours that multiply at every turn, the country sparkles with vitality and vivacity. ', 'Agra', 'art-jaipur', 2, 'art.jpg', 'art.jpg', 'active'),
(78, 3, 'Craft', 'Home is where the art is, meet the people from all over India usings crafts to add color, style, elegance to interiors and explore the crafts that built India.', 'Jaipur', 'craft-jaipur', 7, 'craft.jpeg', 'craft.jpeg', 'active'),
(79, 7, 'Museum of Goa', 'The Museum of Goa, is a privately owned contemporary art gallery in Pilerne Industrial Estate, near Calangute, Goa, India. Founded in 2015, it is 1,500 square meters in size. It has no permanent collection. It was founded by Goan artist Subodh Kerkar', 'Goa', 'goa-musium', 8, 'museum.jpg', 'museum.jpg', 'active'),
(80, 2, 'Agra Fort', 'Built by Mughal emperor Akbar in 1565 AD, Agra Fort is a majestic sandstone built as an ode to the magnificence of the Mughal empire. Encompassing within its 2.5-km-long enclosure walls a stunning imperial city, the fortress is shaped like a crescent, its eastern wall flanked by River Yamuna. It is said that the construction of the fort was originally begun by emperor Akbar, but completed by his grandson Shah Jahan, who added most of the marble monuments here. There were originally four gates for entrance, two of which were walled up and only one is open today – the Amar Singh gate. The first thing that captures one\'s attention as they enter is Jehangir (Jahangir) Mahal, a palace said to have been built by Akbar as the women’s quarters and named after his son, Jehangir (Jahangir). Simple and elegant, it is home to a large stone bowl upon which are carved Persian verses. Local lore holds that this bowl once contained rose water. Adjacent to Jehangir (Jahangir) Mahal lies the palace built for Jodha Bai, said to be Akbar’s favourite queen. ', 'agra', 'agra-fort', 9, 'agrafort.jpeg', 'agrafort.jpeg', 'active'),
(81, 8, 'Yoga in Rishikesh', 'Over 5,000 years old, the practice of yoga, renowned all over the world, has been benefitting mankind for generations and also finds mention in the Indian epic, Rig Veda. A synchronised art of movement, breathing and meditation, yoga helps expand awareness, improve balance, increase intellect, lowers anxiety and helps manage weight and overall good mental, physical and emotional health. The word \'yoga\' means to unite and symbolises the union of body and consciousness. India, the home of this practice, hosts a variety of wellness resorts, ashram retreats and yoga meditation centres that provide a peaceful and tranquil environment to indulge in yoga meditation and also offer classes to those who wish to learn it. ', 'Rishikesh', 'yoga-rishikesh', 10, 'yoga.webp', 'yoga.webp', 'active'),
(82, 6, 'South Indian Food', 'From idlis (steamed rice cakes) to dosa (crepe-like pancakes), sambar (spicy lentil stew) to rasam (world’s oldest consommé), food of South India is a culture that has developed on the principle of Ayurveda. One of many firsts, steaming as a culinary technique evolved here, and that is how the steamed idlis and pithas (rice cakes) were conceived. In addition, it was here that deep frying technique was mastered and the first fried chicken dish made. The adoption of the Jewish food culture and that of Mappila community also took place here for the first time in the country. Udupi cuisine also developed in this region, which boasts 60 per cent of the Indian vegetarian menu, organic coffee and the best of spices, especially pepper, clove and cardamom. In fact, much of the food that is served here today can be dated back to before 2 century BC. Many believe that the technique of preparation has hardly changed. The Sadya, a ceremonial formal feast, is one such example, which consists of about 28 dishes, including boiled red rice, pickles, sweets, savouries and side dishes. It is served on a plantain leaf and traditionally, the tapering end of the leaf faces the guest.', 'Chennai', 'south-indian-chennai', 11, 'south.jpeg', 'south.jpeg', 'active'),
(83, 2, 'Taj Mahal', 'The Taj Mahal is an ivory-white marble mausoleum on the right bank of the river Yamuna in Agra, Uttar Pradesh, India. It was commissioned in 1631 by the fifth Mughal emperor, Shah Jahan to house the tomb of his beloved wife, Mumtaz Mahal; it also houses the tomb of Shah Jahan himself', 'Agra', 'tajmahal', 3, 'taj.jpg', 'taj.jpg', 'active'),
(84, 7, 'Jet Ski in goa', 'A personal watercraft, also called water scooter, jet ski or sea-doo, is a primarily recreational watercraft that is designed to hold only a small number of occupants, who sit or stand on top of the craft, not within the craft as in a boat. PWCs have two style categories.', 'Goa', 'jet-ski-goa', 1, 'jet.jpg', 'jet.jpg', 'active'),
(85, 7, 'Parasailing in Goa', 'Parasailing, also known as parascending, paraskiing or parakiting, is a recreational kiting activity where a person is towed behind a vehicle while attached to a specially designed canopy wing that resembles a parachute, known as a parasail wing. The manned kite\'s moving anchor may be a car, truck, or boat.', 'Goa', 'parasailing-goa', 1, 'psailing.jpg', 'psailing.jpg', 'active'),
(86, 8, 'Bungee Jumping Rishikesh', 'Grab this exciting opportunity to enjoy bungee jumping from the highest point in India. Rishikesh is one of the biggest tourist hubs in India, it is famous for its beautiful surroundings and stunning landscapes. It also has various activities and sports that you can choose from. This bungee jumping experience is one of its kind, as it allows you to jump from a height of 83 meters amidst the lush greenery of Rishikesh. Book tickets for this activity and spend a fun-filled day with your loved ones', 'Rishikesh', 'bungee-jumping-rishikesh', 1, 'bungee.jpg', 'bungee.jpg', 'active'),
(87, 6, 'Bharat Natyam', 'Dance is an eloquent form of expression. From classical and traditional to folk and tribal, there are various dance forms in India. The most popularly recognised classical dance forms are eight, which find themselves steeped in a rich mythological and religious history and have been mentioned in the ancient Hindu text of Natya Shastra. These are Bharat Natyam (Tamil Nadu), Sattriya (Assam), Manipuri (Manipur), Kathak (northern and western India), Odissi (Odisha), Kuchipudi (Andhra Pradesh and Telangana), Kathakali (Kerala), Mohiniyattam (Kerala).', 'Chennai', 'dance-form-chennai', 2, 'dance.jpeg', 'dance.jpeg', 'active'),
(88, 6, 'Mohiniyattam', 'Dance is an eloquent form of expression. From classical and traditional to folk and tribal, there are various dance forms in India. The most popularly recognised classical dance forms are eight, which find themselves steeped in a rich mythological and religious history and have been mentioned in the ancient Hindu text of Natya Shastra. These are Bharat Natyam (Tamil Nadu), Sattriya (Assam), Manipuri (Manipur), Kathak (northern and western India), Odissi (Odisha), Kuchipudi (Andhra Pradesh and Telangana), Kathakali (Kerala), Mohiniyattam (Kerala).', 'kerla', 'mohiniyattam', 2, 'dance.jpeg', 'dance.jpeg', 'active'),
(89, 6, 'Kathak', 'Said to have introduced by the bards travelling around the regions of north India, Kathak involves the recounting of religious tales and legends in a rhythmic fashion. From tapping of feet and hand gestures to eye movements and facial expressions, Kathak leaves one reeling with wonder at the finesse and skill of the dancers clad in a long embroidered skirt, complemented with a choli (blouse) and chunni (a long scarf).', 'kerla', 'kathak', 2, 'dance.jpeg', 'dance.jpeg', 'active'),
(90, 6, 'Kuchipudi', 'Largely featuring scenes and stories from the life of Lord Krishna, Kuchipudi, from Andhra Pradesh and Telangana, is essentially a temple dance. While a female dancer wears a pleated sari that opens like a hand fan, a male dancer is clad in a dhoti. The dancers are adorned with traditional jewellery and dance to the rhythmic beats of cymbals, flute, veena, tambura etc.', 'Andhra', 'kuchipudi', 2, 'dance.jpeg', 'dance.jpeg', 'active'),
(91, 6, 'TIRUPATI Abode of the Glorious God', 'Among the most popular global pilgrimage places, Tirupati, in Andhra Pradesh, is a stopover for those seeking spirituality and sanctity. Situated at the foot of Tirumala Hills, this lively pilgrim place attracts devotees all year round. Tirupati Balaji or the Lord Venkatesha Temple is the main attraction here. Said to be one of the richest temples in the country, it sees an estimated footfall of 60,000 every day. Devotees donate their hair and various riches in the temple in order to please the god.', 'TIRUPATI Abode of the Glorious God', 'tirupati-temple', 5, 'tirupati.jpeg', 'tirupati.jpeg', 'active'),
(92, 1, 'Connaught Place', 'The heartbeat of Delhi, Connaught Place is a heritage neighbourhood that has been modeled after the Georgian style of architecture. Lined with a host of eateries, high-end stores, parlours, theatres and book stores, the market is the hub of most activities in Delhi. Spread in two concentric circles, Connaught Place holds a vintage character that is vividly contrasted by various cosmopolitan shops and cafes that are crowned with blaring neon signs. On any good day, you can see a number of students and office workers spilling out on the streets and enjoying the pleasant weather while relishing a plate of chaat from a vendor.', 'Rajeev chowk', 'connaught-place-delhi', 3, 'cq5dam.web.1800.600.jpeg', 'cq5dam.web.1800.600.jpeg', 'active'),
(93, 1, 'Akshardham', 'Holding the Guinness World Records as the world\'s largest comprehensive Hindu temple, the Akshardham temple complex is a stunning piece of architecture. Sprawled over a vast area, the complex looks like a splendid heavenly city when viewed from above. The temple itself has been constructed in pink sandstone and marble and is laid amidst neatly manicured lawns, pristine waterfronts and open courtyards. It has been designed in the traditional Hindu style of architecture and follows vaastu shastra and pancharatra shastra. As you stroll along the breathtaking complex, you will spot intricate carvings of animals, flowers, dancers, musicians and deities that adorn the walls. It is said that the stone used in the construction of the temple was brought from Rajasthan and weighed about 6,000 tonne. The Italian Carrara marble used in the structure adds to the beauty of the grand temple.', 'delhi', 'akshardham', 3, 'akshardham.jpeg', 'akshardham.jpeg', 'active'),
(94, 1, 'Chandni Chowk', 'Preserving the antiquity of Old Delhi, Chandni Chowk is a bustling neighbourhood that is one of the oldest in the national capital. A vibrant bazaar that is buzzing with activity, Chandni Chowk is a labyrinth of narrow alleyways that are crammed with small shops, either selling delicious servings of snacks, sweets and savouries or offering budgeted deals on a host of products, including clothes. This medieval shopping site is stocked with almost everything under the sun, and you can get a fine selection of perfumes, jewellery, electronics, candles, lifestyle goods and idols of gods and goddesses. Moreover, it also plays host to one of the largest wholesale markets in Delhi, in which visitors can get huge discounts on several items.', 'Chandni Chowk', 'chandni-chowk', 4, 'chandani-chowk.jpeg', 'chandani-chowk.jpeg', 'active'),
(95, 7, 'Anjuna Flea Market', 'Anjuna Flea Market is one of the popular and great places of shopping in Goa. Hosted every Wednesday at Anjuna Beach, this flea market is a paradise place for real shopaholics. You will find hundreds of stores selling jewelries, clothes, wooden crafts, footwear, handicrafts, hammocks, bed sheets, trinkets, and wall hangings. This market experiences great footfalls of Indians as well as foreigners. Show your bargaining skills at this shopping place and pick some great items as souvenirs. You can even book some good and budget hotels near the Anjuna Flea Market providing an easy access to it.', 'goa', 'Anjuna-Flea-Market', 4, 'anjuna.jpg', 'anjuna.jpg', 'active'),
(96, 7, 'Mackie’s Night Bazaar', 'A perfect place for every enthusiastic shopper, Mackie’s Night Bazaar is organized every Saturday from afternoon till midnight on Baga Beach. It features over hundred shopping outlets selling souvenirs, handicrafts, clothes, jewelry and antiques, etc. There are many eateries as well as party places where you can have lots of fun while having great shopping experiences.', 'goa', 'mackies-night-bazaar', 4, 'night.jpg', 'night.jpg', 'active'),
(97, 2, 'Sadar Bazaar agra', 'Sadar Bazaar is one of the most famous markets for shopping in Agra which is situated near the Agra Cantt railway station. Everything ranging from handicrafts, sweets, garments to leather bags can be found here. Cafes such as Café Coffee Day too are situated near the market in addition to some delicious vegetarian as well as non-vegetarian food joints.', 'Agra', 'sadar-agra', 4, 'sadar.jpg', 'sadar.jpg', 'active');

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `destination_id` int(11) DEFAULT NULL,
  `rating` int(11) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `states`
--

CREATE TABLE `states` (
  `id` int(11) NOT NULL,
  `state` varchar(100) NOT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `state_code` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `states`
--

INSERT INTO `states` (`id`, `state`, `status`, `state_code`) VALUES
(1, 'Andhra Pradesh', 'active', 'AP'),
(2, 'Arunachal Pradesh', 'active', 'AR'),
(3, 'Assam', 'active', 'AS'),
(4, 'Bihar', 'active', 'BR'),
(5, 'Chhattisgarh', 'active', 'CG'),
(6, 'Goa', 'active', 'GA'),
(7, 'Gujarat', 'active', 'GJ'),
(8, 'Haryana', 'active', 'HR'),
(9, 'Himachal Pradesh', 'active', 'HP'),
(10, 'Jharkhand', 'active', 'JH'),
(11, 'Karnataka', 'active', 'KA'),
(12, 'Kerala', 'active', 'KL'),
(13, 'Madhya Pradesh', 'active', 'MP'),
(14, 'Maharashtra', 'active', 'MH'),
(15, 'Manipur', 'active', 'MN'),
(16, 'Meghalaya', 'active', 'ML'),
(17, 'Mizoram', 'active', 'MZ'),
(18, 'Nagaland', 'active', 'NL'),
(19, 'Odisha', 'active', 'OR'),
(20, 'Punjab', 'active', 'PB'),
(21, 'Rajasthan', 'active', 'RJ'),
(22, 'Sikkim', 'active', 'SK'),
(23, 'Tamil Nadu', 'active', 'TN'),
(24, 'Telangana', 'active', 'TS'),
(25, 'Tripura', 'active', 'TR'),
(26, 'Uttar Pradesh', 'active', 'UP'),
(27, 'Uttarakhand', 'active', 'UK'),
(28, 'West Bengal', 'active', 'WB'),
(29, 'Andaman and Nicobar Islands', 'active', 'AN'),
(30, 'Chandigarh', 'active', 'CH'),
(31, 'Dadra and Nagar Haveli and Daman and Diu', 'active', 'DN'),
(32, 'Lakshadweep', 'active', 'LD'),
(33, 'Delhi', 'active', 'DL'),
(34, 'Puducherry', 'active', 'PY');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `destinations`
--
ALTER TABLE `destinations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_destinations_category` (`category`),
  ADD KEY `fk_location_states` (`location`);

--
-- Indexes for table `experiences`
--
ALTER TABLE `experiences`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_experiences_destination` (`destination`) USING BTREE,
  ADD KEY `fk_experiences_category_id` (`category`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `destination_id` (`destination_id`);

--
-- Indexes for table `states`
--
ALTER TABLE `states`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_states_id` (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `destinations`
--
ALTER TABLE `destinations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `experiences`
--
ALTER TABLE `experiences`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=98;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `states`
--
ALTER TABLE `states`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `destinations`
--
ALTER TABLE `destinations`
  ADD CONSTRAINT `fk_destinations_category` FOREIGN KEY (`category`) REFERENCES `categories` (`id`),
  ADD CONSTRAINT `fk_location_states` FOREIGN KEY (`location`) REFERENCES `states` (`id`);

--
-- Constraints for table `experiences`
--
ALTER TABLE `experiences`
  ADD CONSTRAINT `fk_experiences_category` FOREIGN KEY (`destination`) REFERENCES `destinations` (`id`),
  ADD CONSTRAINT `fk_experiences_category_id` FOREIGN KEY (`category`) REFERENCES `categories` (`id`);

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`destination_id`) REFERENCES `destinations` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
