-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: 2017-05-04 04:02:03
-- 服务器版本： 5.6.28
-- PHP Version: 5.6.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `wxshop`
--

-- --------------------------------------------------------

--
-- 表的结构 `address`
--

CREATE TABLE `address` (
  `add_id` mediumint(8) NOT NULL COMMENT '主键',
  `user_id` int(8) NOT NULL COMMENT '所属用户ID',
  `add_default` tinyint(1) NOT NULL COMMENT '是否默认地址：0不是，1是',
  `add_detail` varchar(100) NOT NULL COMMENT '详细地址',
  `add_name` varchar(40) NOT NULL COMMENT '收件人名字',
  `add_telephone` varchar(13) NOT NULL COMMENT '收件人电话'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='地址信息表';

--
-- 转存表中的数据 `address`
--

INSERT INTO `address` (`add_id`, `user_id`, `add_default`, `add_detail`, `add_name`, `add_telephone`) VALUES
(1, 1, 0, '福建省 福州市 闽侯县 上街镇 福州大学35#505', '王婷婷', '13675003883'),
(2, 1, 0, '福建省 福州市 新东方学校', '王倩琼', '13879039333');

-- --------------------------------------------------------

--
-- 表的结构 `admin`
--

CREATE TABLE `admin` (
  `uid` mediumint(8) NOT NULL COMMENT '用户id',
  `username` varchar(20) NOT NULL COMMENT '用户名',
  `password` varchar(40) NOT NULL COMMENT '用户密码',
  `nickname` varchar(200) DEFAULT NULL COMMENT '用户昵称',
  `avatar` varchar(200) DEFAULT NULL COMMENT '头像',
  `email` varchar(20) DEFAULT NULL COMMENT '电子邮箱',
  `telephone` varchar(13) DEFAULT NULL COMMENT '用户电话',
  `user_key` varchar(8) NOT NULL COMMENT 'userKey',
  `level` int(1) NOT NULL DEFAULT '6' COMMENT '用户级别',
  `last_login` varchar(10) DEFAULT NULL COMMENT '最后登录时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='管理员信息表';

--
-- 转存表中的数据 `admin`
--

INSERT INTO `admin` (`uid`, `username`, `password`, `nickname`, `avatar`, `email`, `telephone`, `user_key`, `level`, `last_login`) VALUES
(1, 'admin', '3cbb1ac132d4489f874f27cd35efd745', '超级管理员', NULL, 'iweibin@sina.cn', '15659751525', 'abcsdsss', 6, NULL);

-- --------------------------------------------------------

--
-- 表的结构 `goods`
--

CREATE TABLE `goods` (
  `gid` int(10) UNSIGNED NOT NULL COMMENT '商品编号',
  `gname` varchar(300) NOT NULL COMMENT '商品名称',
  `gtype_id` int(10) UNSIGNED NOT NULL COMMENT '商品类型的编号',
  `gimg` varchar(200) NOT NULL COMMENT '商品主图片',
  `gdec_s` varchar(100) NOT NULL COMMENT '商品主页描述（短）',
  `gdec_l` text COMMENT '商品主页描述（长）',
  `gpri` varchar(100) NOT NULL COMMENT '商品价格',
  `gnum` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '商品数量',
  `gchoice` int(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT '是否精选（总精选2，次精选1，否0）',
  `gpreferential` int(1) DEFAULT '0' COMMENT '是否特惠',
  `gclass_id` int(10) DEFAULT '0' COMMENT '商品购买时分类模块的编号',
  `gsales` int(8) DEFAULT '0' COMMENT '产品销量',
  `sale_mode` varchar(20) NOT NULL COMMENT '销售方式',
  `gtime` int(12) NOT NULL COMMENT '商品上架时间',
  `gstatic` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否上架'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品信息表';

--
-- 转存表中的数据 `goods`
--

INSERT INTO `goods` (`gid`, `gname`, `gtype_id`, `gimg`, `gdec_s`, `gdec_l`, `gpri`, `gnum`, `gchoice`, `gpreferential`, `gclass_id`, `gsales`, `sale_mode`, `gtime`, `gstatic`) VALUES
(6, '多福多寿', 2, '["20170424\\\\83eb42d75dc5ee82d738dd1b1a6a5f4b.png","20170424\\\\56ea20ee9672bc4fe4f44eb98b5845e7.png"]', '是个发给对方', '<p>填写商品描当时发动述</p>', '{"\\u89c4\\u683c\\u4e00":"50.0","\\u89c4\\u683c\\u4e8c":"99"}', 0, 0, 0, 0, 0, '现货/3个工作日内发货', 0, 1),
(7, '商品名称', 3, '["20170424\\\\49265bfaf608352f13d20a0679f7c6ec.png","20170424\\\\40e430e9359e5780a5c84e695845e598.png"]', '商品优惠信息', '<p>填写商品描述</p>', '{"1\\u5305":"20","2\\u5305":"39"}', 0, 1, 1, 0, 0, '预定/2017年5月10日发货', 0, 1),
(8, '商品名称4', 6, '["20170424\\\\fc4efed7b7eb452787380994eaf895ca.png"]', '优惠信息', '<p>填写商品描述</p>', '{"1\\u5305\\u88c5":"50.5","2\\u5305\\u88c5":"111"}', 0, 1, 1, 0, 0, '现货/3个工作日内发货', 1493047938, 1);

-- --------------------------------------------------------

--
-- 表的结构 `goods_class`
--

CREATE TABLE `goods_class` (
  `gtype_id` int(10) NOT NULL COMMENT '商品类型的编号',
  `gtype_name` varchar(40) NOT NULL COMMENT '商品类型名称'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品类型表';

--
-- 转存表中的数据 `goods_class`
--

INSERT INTO `goods_class` (`gtype_id`, `gtype_name`) VALUES
(1, '文具'),
(2, '日用品'),
(3, '文创商品'),
(4, '大师作品'),
(5, '台湾作品'),
(6, '大陆作品');

-- --------------------------------------------------------

--
-- 表的结构 `master`
--

CREATE TABLE `master` (
  `master_id` int(4) UNSIGNED NOT NULL COMMENT '大师id',
  `master_name` varchar(200) NOT NULL COMMENT '大师名字',
  `master_skill` varchar(200) NOT NULL COMMENT '技艺名称',
  `master_summary` mediumtext NOT NULL COMMENT '简介',
  `master_picture` varchar(100) NOT NULL COMMENT '头像',
  `master_hit` int(5) NOT NULL DEFAULT '0' COMMENT '浏览次数'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='大师信息表';

--
-- 转存表中的数据 `master`
--

INSERT INTO `master` (`master_id`, `master_name`, `master_skill`, `master_summary`, `master_picture`, `master_hit`) VALUES
(2, '大师名称', '技艺名称', '大师简介 很长很长', '20170503\\3ab7c89a4d8041cae0ae6b563b8fc8bb.jpg', 0),
(3, '大师名称2', '技艺名称', '大师简介很长很长', '20170501\\bb25e8c52f46416f51f75c6bc9165bfd.jpg', 0);

-- --------------------------------------------------------

--
-- 表的结构 `order`
--

CREATE TABLE `order` (
  `order_id` mediumint(8) NOT NULL COMMENT '主键ID',
  `order_num` varchar(50) NOT NULL COMMENT '订单编号',
  `user_id` int(8) NOT NULL COMMENT '所属用户ID',
  `shopping_goods` mediumtext NOT NULL COMMENT '商品详情（json数据）',
  `order_time` varchar(20) NOT NULL COMMENT '下单时间',
  `order_pri` double NOT NULL COMMENT '订单总额',
  `address_id` mediumint(8) NOT NULL COMMENT '订单地址id',
  `express_name` varchar(100) DEFAULT NULL COMMENT '快递名称',
  `express_num` varchar(100) DEFAULT NULL COMMENT '运单编号',
  `order_status` varchar(1) NOT NULL COMMENT '订单状态：0待付款，1待发货，2待收货，3退换货'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单表';

--
-- 转存表中的数据 `order`
--

INSERT INTO `order` (`order_id`, `order_num`, `user_id`, `shopping_goods`, `order_time`, `order_pri`, `address_id`, `express_name`, `express_num`, `order_status`) VALUES
(1, '111', 1, '{"goods":[{"gid":"6","gpri":{"\\u89c4\\u683c1":"55.5"},"num":"1"},{"gid":"7","gpri":{"\\u89c4\\u683c1":"55.5"},"num":"2"}],"works":[{"works_id":"2","works_prize":{"\\u89c4\\u683c1":"55.5"},"num":"1"},{"works_id":"2","works_prize":{"\\u89c4\\u683c1":"55.5"},"num":"1"}]}', '1234567890', 330, 1, '韵达', '111111111', '1'),
(2, '2', 1, '{"goods":[{"gid":"7","gpri":{"\\u89c4\\u683c1":"55.5"},"num":"1"},{"gid":"8","gpri":{"\\u89c4\\u683c1":"55.5"},"num":"2"}],"works":[{"works_id":"2","works_prize":{"\\u89c4\\u683c1":"55.5"},"num":"1"},{"works_id":"2","works_prize":{"\\u89c4\\u683c1":"55.5"},"num":"1"}]}', '342342342', 520, 2, '韵达', '9876543210', '2');

-- --------------------------------------------------------

--
-- 表的结构 `user`
--

CREATE TABLE `user` (
  `user_id` mediumint(8) NOT NULL COMMENT '用户id',
  `openid` varchar(40) NOT NULL COMMENT 'openid',
  `nickname` varchar(200) DEFAULT NULL COMMENT '用户昵称',
  `sex` int(1) DEFAULT NULL COMMENT '性别',
  `avatar` varchar(200) NOT NULL COMMENT '头像',
  `province` varchar(50) DEFAULT NULL COMMENT '省份',
  `city` varchar(50) DEFAULT NULL COMMENT '城市',
  `country` varchar(50) DEFAULT NULL COMMENT '国家',
  `telephone` varchar(13) DEFAULT NULL COMMENT '用户电话',
  `address_id` mediumint(8) DEFAULT NULL COMMENT '默认收货地址',
  `last_login` varchar(10) DEFAULT NULL COMMENT '最后登录时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户信息表';

--
-- 转存表中的数据 `user`
--

INSERT INTO `user` (`user_id`, `openid`, `nickname`, `sex`, `avatar`, `province`, `city`, `country`, `telephone`, `address_id`, `last_login`) VALUES
(1, '1111111111', 'lianghangnvpiao', 0, '', '福建', '福州', '中国', '13675003883', 1, '1111111111');

-- --------------------------------------------------------

--
-- 表的结构 `works`
--

CREATE TABLE `works` (
  `works_id` int(8) NOT NULL COMMENT '作品 id',
  `master_id` int(4) NOT NULL COMMENT '所属大师 id',
  `works_name` varchar(200) NOT NULL COMMENT '作品名称',
  `works_pic` mediumtext NOT NULL COMMENT '作品主图',
  `works_summary` mediumtext COMMENT '作品简介',
  `works_dec` mediumtext COMMENT '作品详情',
  `works_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '作品状态：0下架 1缺货 2在售',
  `works_prize` varchar(200) NOT NULL COMMENT '作品规格和价格',
  `works_sales` int(8) NOT NULL DEFAULT '0' COMMENT '销量',
  `sale_mode` varchar(100) NOT NULL COMMENT '销售方式',
  `works_num` int(4) NOT NULL COMMENT '作品数量',
  `time` varchar(20) NOT NULL COMMENT '发布时间戳'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='大师作品信息表';

--
-- 转存表中的数据 `works`
--

INSERT INTO `works` (`works_id`, `master_id`, `works_name`, `works_pic`, `works_summary`, `works_dec`, `works_status`, `works_prize`, `works_sales`, `sale_mode`, `works_num`, `time`) VALUES
(2, 3, '作品名称22222333', '["20170501\\\\111.jpg","20170501\\\\b1271da78fd61b778caf732585626626.jpg"]', '作品简介', '<p>作品描述</p>', 1, '{"\\u89c4\\u683c":"55555"}', 0, '{"mode":2,"name":"2017\\u5e7405\\u670811\\u65e5\\u53d1\\u8d27"}', 0, '1493637099');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `address`
--
ALTER TABLE `address`
  ADD PRIMARY KEY (`add_id`);

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`uid`);

--
-- Indexes for table `goods`
--
ALTER TABLE `goods`
  ADD PRIMARY KEY (`gid`);

--
-- Indexes for table `goods_class`
--
ALTER TABLE `goods_class`
  ADD PRIMARY KEY (`gtype_id`);

--
-- Indexes for table `master`
--
ALTER TABLE `master`
  ADD PRIMARY KEY (`master_id`);

--
-- Indexes for table `order`
--
ALTER TABLE `order`
  ADD PRIMARY KEY (`order_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `works`
--
ALTER TABLE `works`
  ADD PRIMARY KEY (`works_id`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `address`
--
ALTER TABLE `address`
  MODIFY `add_id` mediumint(8) NOT NULL AUTO_INCREMENT COMMENT '主键', AUTO_INCREMENT=3;
--
-- 使用表AUTO_INCREMENT `admin`
--
ALTER TABLE `admin`
  MODIFY `uid` mediumint(8) NOT NULL AUTO_INCREMENT COMMENT '用户id', AUTO_INCREMENT=2;
--
-- 使用表AUTO_INCREMENT `goods`
--
ALTER TABLE `goods`
  MODIFY `gid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '商品编号', AUTO_INCREMENT=9;
--
-- 使用表AUTO_INCREMENT `goods_class`
--
ALTER TABLE `goods_class`
  MODIFY `gtype_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '商品类型的编号', AUTO_INCREMENT=7;
--
-- 使用表AUTO_INCREMENT `master`
--
ALTER TABLE `master`
  MODIFY `master_id` int(4) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '大师id', AUTO_INCREMENT=4;
--
-- 使用表AUTO_INCREMENT `order`
--
ALTER TABLE `order`
  MODIFY `order_id` mediumint(8) NOT NULL AUTO_INCREMENT COMMENT '主键ID', AUTO_INCREMENT=3;
--
-- 使用表AUTO_INCREMENT `user`
--
ALTER TABLE `user`
  MODIFY `user_id` mediumint(8) NOT NULL AUTO_INCREMENT COMMENT '用户id', AUTO_INCREMENT=2;
--
-- 使用表AUTO_INCREMENT `works`
--
ALTER TABLE `works`
  MODIFY `works_id` int(8) NOT NULL AUTO_INCREMENT COMMENT '作品 id', AUTO_INCREMENT=3;