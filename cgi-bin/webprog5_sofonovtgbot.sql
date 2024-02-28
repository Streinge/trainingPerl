-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Хост: localhost:3306
-- Время создания: Июл 19 2023 г., 08:34
-- Версия сервера: 10.6.7-MariaDB-1:10.6.7+maria~bullseye
-- Версия PHP: 8.1.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `webprog5_sofonovtgbot`
--

-- --------------------------------------------------------

--
-- Структура таблицы `webprog5_sofonov_group_list`
--

CREATE TABLE `webprog5_sofonov_group_list` (
  `id` int(11) NOT NULL,
  `group_name` char(30) NOT NULL COMMENT 'Название, как в Telegram',
  `chat_number` int(11) NOT NULL COMMENT 'Это значение равно chat_id Telegram'
) ENGINE=InnoDB DEFAULT CHARSET=cp1251 COMMENT='Список групп обучения';

--
-- Дамп данных таблицы `webprog5_sofonov_group_list`
--

INSERT INTO `webprog5_sofonov_group_list` (`id`, `group_name`, `chat_number`) VALUES
(1, 'Legends', -877035195),
(2, 'Best', -877082195),
(3, 'Happy', -763927384);

-- --------------------------------------------------------

--
-- Структура таблицы `webprog5_sofonov_order_homeworks`
--

CREATE TABLE `webprog5_sofonov_order_homeworks` (
  `id` int(10) NOT NULL,
  `student_id` int(10) NOT NULL,
  `homework` tinyint(4) NOT NULL COMMENT 'номер домашнего задания берется из хештега',
  `point` tinyint(4) NOT NULL COMMENT 'поставленный балл за выполнение домашнего задания',
  `on_time` tinyint(4) NOT NULL COMMENT 'вовремя (1) или нет (0) выполнено домашнее задание',
  `group_list_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=cp1251 COMMENT='Cписок выполненных домашних заданий';

--
-- Дамп данных таблицы `webprog5_sofonov_order_homeworks`
--

INSERT INTO `webprog5_sofonov_order_homeworks` (`id`, `student_id`, `homework`, `point`, `on_time`, `group_list_id`) VALUES
(1, 7, 11, 5, 1, 1),
(2, 4, 11, 3, 0, 1),
(3, 7, 2, 4, 0, 1),
(4, 3, 11, 5, 1, 2),
(5, 3, 2, 3, 0, 2),
(6, 1, 11, 4, 0, 2),
(8, 7, 3, 4, 0, 1),
(10, 4, 2, 5, 1, 1),
(12, 1, 2, 3, 0, 2),
(14, 4, 3, 4, 0, 1),
(16, 7, 4, 2, 0, 1),
(18, 3, 3, 5, 1, 2),
(20, 1, 3, 3, 0, 2),
(22, 4, 4, 5, 1, 1),
(24, 1, 4, 2, 0, 2),
(26, 3, 4, 3, 0, 2),
(30, 3, 5, 5, 1, 2),
(31, 4, 5, 3, 0, 1),
(32, 1, 5, 4, 0, 2),
(33, 1, 6, 4, 0, 2),
(34, 7, 6, 5, 1, 1),
(37, 8, 11, 4, 0, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `webprog5_sofonov_student`
--

CREATE TABLE `webprog5_sofonov_student` (
  `id` int(10) NOT NULL,
  `user_name` char(20) NOT NULL,
  `group_list_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=cp1251 COMMENT='Список username, взятых из Telegram, студентов, выполнивших домашние задания';

--
-- Дамп данных таблицы `webprog5_sofonov_student`
--

INSERT INTO `webprog5_sofonov_student` (`id`, `user_name`, `group_list_id`) VALUES
(1, 'Ruslan', 2),
(3, 'Ivan', 2),
(4, 'Petr', 1),
(7, 'Oleg', 1),
(8, 'Ignat', 3);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `webprog5_sofonov_group_list`
--
ALTER TABLE `webprog5_sofonov_group_list`
  ADD PRIMARY KEY (`id`),
  ADD KEY `group_name` (`group_name`);

--
-- Индексы таблицы `webprog5_sofonov_order_homeworks`
--
ALTER TABLE `webprog5_sofonov_order_homeworks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_id` (`student_id`);

--
-- Индексы таблицы `webprog5_sofonov_student`
--
ALTER TABLE `webprog5_sofonov_student`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_name` (`user_name`) USING BTREE COMMENT 'уникальный потому что это username Telegram';

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `webprog5_sofonov_group_list`
--
ALTER TABLE `webprog5_sofonov_group_list`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT для таблицы `webprog5_sofonov_order_homeworks`
--
ALTER TABLE `webprog5_sofonov_order_homeworks`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT для таблицы `webprog5_sofonov_student`
--
ALTER TABLE `webprog5_sofonov_student`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
