<?php

return [
	'view_replace_str'  =>  [
	    '__PUBLIC__'=>'http://'.$_SERVER['HTTP_HOST'].dirname($_SERVER['SCRIPT_NAME']).'/static',
	    '__ROOT__' => '/',
	    '__UPLOADS__'=>'http://'.$_SERVER['HTTP_HOST'].dirname($_SERVER['SCRIPT_NAME']).'/uploads',
	]
];