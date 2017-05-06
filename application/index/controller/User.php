<?php
namespace app\index\controller;
use think\Config;
use think\Db;
use think\Request;
use think\Cache;

class User extends Base {

	public function __construct() {
		parent::__construct();
	}

    public function get_user() {
        /*
        $user = Session::get('signed_user');
        $openid = $user['userid'];
        */
        $openid = '1111111111';
        return $user = Db::table('user')->where('openid', $openid)->find(); 
    }

    public function test() {
       return $this->fetch('index/editAddress');
    }


    //个人信息 主页面 center.html
	public function center() {

        $user = $this->get_user();
        $this->assign('user',$user);
        return $this->fetch('index/center');
	}

    //查看某一产品新息
    public function goods($gid = null) {
        $user = $this->get_user();
        $this->assign('user',$user);
        $product = Db::table('goods')->where('gid', $gid)->find();
        $product['gimg'] = explode(',',substr($product['gimg'], 2,-2));
        $product['gpri'] = json_decode($product['gpri'],true);
        $product['sale_mode'] = json_decode($product['sale_mode'],true);

        $this->assign('product',$product);
      
        return $this->fetch('index/product');
    }

     //查看某一大师作品新息
    public function works($works_id = null) {
        $user = $this->get_user();
        $this->assign('user',$user);
        $product = Db::table('works')->where('works_id', $works_id)->find();
        $this->assign('product',$product);
        return $this->fetch('index/product');
    }


    //全部订单
	public function shopping_all() {
		
        $user = $this->get_user();

        $order = Db::table('order')->alias('o')
                                   ->join('address a','o.address_id = a.add_id')
                                   ->where('o.user_id',$user['user_id'])
                                   //->where('order_status', '0')
                                   ->order('order_time desc')
                                   ->select();
        
        foreach ($order as $key => $value) {
           $order[$key]['total_num'] = 0;
           $order[$key]['shopping_goods'] = json_decode($value['shopping_goods'],true);

           foreach ($order[$key]['shopping_goods']['goods'] as $key1 => $value1) {
                $order[$key]['shopping_goods']['goods'][$key1]['info'] = Db::table('goods')->field('gname,gimg')->where('gid', $value1['gid'])->find();
                var_dump($value1['gid']);
                exit;
                $order[$key]['shopping_goods']['goods'][$key1]['info']['pic'] = substr(explode(',',$order[$key]['shopping_goods']['goods'][$key1]['info']['gimg'])[0],2,-1);
                $order[$key]['shopping_goods']['goods'][$key1]['pri'] = implode($value1['gpri']);
                $order[$key]['total_num']  += $value1['num'];
           }

           foreach ($order[$key]['shopping_goods']['works'] as $key2 => $value2) {
                 $order[$key]['shopping_goods']['works'][$key2]['info'] = Db::table('works')->field('works_name,works_pic')->where('works_id', $value2['works_id'])->find();
                 $order[$key]['shopping_goods']['works'][$key2]['info']['pic'] = substr(explode(',',$order[$key]['shopping_goods']['works'][$key2]['info']['works_pic'])[0],2,-1);
                 $order[$key]['shopping_goods']['works'][$key2]['pri'] = implode($value2['works_prize']);
                 $order[$key]['total_num']  += $value2['num'];
           }
        	         
        }
      var_dump($order);
      exit;
        $this->assign('order',$order);
        $this->assign('user',$user);
        return $this->fetch('index/shoppingAll');
	}
  
  public function jsontest() {
     $shopping_goods = ["20170424\\83eb42d75dc5ee82d738dd1b1a6a5f4b.png","20170424\\56ea20ee9672bc4fe4f44eb98b5845e7.png"];

     return json_decode($shopping_goods);


  }



    //等待付款页面
	public function wait_pay() {

	      $user = $this->get_user();

        $order = Db::table('order')->alias('o')
                                   ->join('address a','o.address_id = a.add_id')
                                   ->where('o.user_id',$user['user_id'])
                                   ->where('order_status', '0')
                                   ->order('order_time desc')
                                   ->select();
        
        foreach ($order as $key => $value) {
           $order[$key]['total_num'] = 0;
           $order[$key]['shopping_goods'] = json_decode($value['shopping_goods'],true);

           foreach ($order[$key]['shopping_goods']['goods'] as $key1 => $value1) {
                $order[$key]['shopping_goods']['goods'][$key1]['info'] = Db::table('goods')->field('gname,gimg')->where('gid', $value1['gid'])->find();
                $order[$key]['shopping_goods']['goods'][$key1]['info']['pic'] = substr(explode(',',$order[$key]['shopping_goods']['goods'][$key1]['info']['gimg'])[0],2,-1);
                $order[$key]['shopping_goods']['goods'][$key1]['pri'] = implode($value1['gpri']);
                $order[$key]['total_num']  += $value1['num'];
           }

           foreach ($order[$key]['shopping_goods']['works'] as $key2 => $value2) {
                 $order[$key]['shopping_goods']['works'][$key2]['info'] = Db::table('works')->field('works_name,works_pic')->where('works_id', $value2['works_id'])->find();
                 $order[$key]['shopping_goods']['works'][$key2]['info']['pic'] = substr(explode(',',$order[$key]['shopping_goods']['works'][$key2]['info']['works_pic'])[0],2,-1);
                 $order[$key]['shopping_goods']['works'][$key2]['pri'] = implode($value2['works_prize']);
                 $order[$key]['total_num']  += $value2['num'];
           }
                   
        }


        $this->assign('order',$order);
        $this->assign('user',$user);
        return $this->fetch('index/waitPay');
	}

	public function wait_send() {
		    $user = $this->get_user();

        $order = Db::table('order')->alias('o')
                                   ->join('address a','o.address_id = a.add_id')
                                   ->where('o.user_id',$user['user_id'])
                                   ->where('order_status', '1')
                                   ->order('order_time desc')
                                   ->select();
        
        foreach ($order as $key => $value) {
           $order[$key]['total_num'] = 0;
           $order[$key]['shopping_goods'] = json_decode($value['shopping_goods'],true);

           foreach ($order[$key]['shopping_goods']['goods'] as $key1 => $value1) {
                $order[$key]['shopping_goods']['goods'][$key1]['info'] = Db::table('goods')->field('gname,gimg')->where('gid', $value1['gid'])->find();
                $order[$key]['shopping_goods']['goods'][$key1]['info']['pic'] = substr(explode(',',$order[$key]['shopping_goods']['goods'][$key1]['info']['gimg'])[0],2,-1);
                $order[$key]['shopping_goods']['goods'][$key1]['pri'] = implode($value1['gpri']);
                $order[$key]['total_num']  += $value1['num'];
           }

           foreach ($order[$key]['shopping_goods']['works'] as $key2 => $value2) {
                 $order[$key]['shopping_goods']['works'][$key2]['info'] = Db::table('works')->field('works_name,works_pic')->where('works_id', $value2['works_id'])->find();
                 $order[$key]['shopping_goods']['works'][$key2]['info']['pic'] = substr(explode(',',$order[$key]['shopping_goods']['works'][$key2]['info']['works_pic'])[0],2,-1);
                 $order[$key]['shopping_goods']['works'][$key2]['pri'] = implode($value2['works_prize']);
                 $order[$key]['total_num']  += $value2['num'];
           }
                   
        }


        $this->assign('order',$order);
        $this->assign('user',$user);
        return $this->fetch('index/waitSend');

	}

	public function wait_comfirm() {
		
        $user = $this->get_user();

        $order = Db::table('order')->alias('o')
                                   ->join('address a','o.address_id = a.add_id')
                                   ->where('o.user_id',$user['user_id'])
                                   ->where('order_status', '2')
                                   ->order('order_time desc')
                                   ->select();
        
        foreach ($order as $key => $value) {
           $order[$key]['total_num'] = 0;
           $order[$key]['shopping_goods'] = json_decode($value['shopping_goods'],true);

           foreach ($order[$key]['shopping_goods']['goods'] as $key1 => $value1) {
                $order[$key]['shopping_goods']['goods'][$key1]['info'] = Db::table('goods')->field('gname,gimg')->where('gid', $value1['gid'])->find();
                $order[$key]['shopping_goods']['goods'][$key1]['info']['pic'] = substr(explode(',',$order[$key]['shopping_goods']['goods'][$key1]['info']['gimg'])[0],2,-1);
                $order[$key]['shopping_goods']['goods'][$key1]['pri'] = implode($value1['gpri']);
                $order[$key]['total_num']  += $value1['num'];
           }

           foreach ($order[$key]['shopping_goods']['works'] as $key2 => $value2) {
                 $order[$key]['shopping_goods']['works'][$key2]['info'] = Db::table('works')->field('works_name,works_pic')->where('works_id', $value2['works_id'])->find();
                 $order[$key]['shopping_goods']['works'][$key2]['info']['pic'] = substr(explode(',',$order[$key]['shopping_goods']['works'][$key2]['info']['works_pic'])[0],2,-1);
                 $order[$key]['shopping_goods']['works'][$key2]['pri'] = implode($value2['works_prize']);
                 $order[$key]['total_num']  += $value2['num'];
           }
                   
        }


        $this->assign('order',$order);
        $this->assign('user',$user);
        return $this->fetch('index/waitComfirm');

	}

	public function address() {
	    $user = $this->get_user();

        $address = Db::table('address')->where('user_id', $user['user_id'])->select();
        //$default = Db::table('address')->where('user_id', $user['user_id'])->where('add_default = 1')->find();
        $this->assign('user',$user);
        $this->assign('address',$address);
        return $this->fetch('index/address');

	}

    //增加地址信息
    public function add_address() {
        $user = $this->get_user();
        $request = Request::instance();
        if($request->isPost()) {
            $data['add_province'] = "";
            $data['add_city'] = "";
            $data['add_area'] = "";
            
            $data['add_detail'] = $request->post('detail','');
            $data['add_name'] = $request->post('name','');
            $data['add_telephone'] = $request->post('tel','');
            $data['user_id'] = $user['user_id'];
            $data['add_default'] = '0';
            $add = explode('/', $request->post('area',''));

            if(isset($add[0])) { 
              $data['add_province'] = $add[0];
            } 
            if(isset($add[1])) {
              $data['add_city'] = $add[1];
            }
            if(isset($add[2])) {
              $data['add_area'] = $add[2];
            }

            if(trim($data['add_name']) == null) {
              $this->showNotice("缺少收货人姓名");
            } else if(trim($data['add_telephone']) == null) {
              $this->showNotice("缺少收货人电话");
            } else if($data['add_detail'] == null || $data['add_area'] == null || $data['add_city'] == null||$data['add_province'] == null) {
              $this->showNotice("缺少收货人地址信息");
            } else {
              Db::table('address')->insert($data);
              //添加成功 跳转页面
              $this->redirect('User/address');
            } 
        }

        return $this->fetch('index/addAddress');
    }
    

    //修改地址信息
	public function edit_address($add_id = null) {

        $user = $this->get_user();
        $address = Db::table('address')->where('add_id',$add_id)->find();
        $address['area'] = "".$address['add_province']."/".$address['add_city']."/".$address['add_area'];

        $request = Request::instance();
        if ($request->isPost()) { 
           $data['add_province'] = "";
           $data['add_city'] = "";
           $data['add_area'] = "";
           
           $data['add_id'] = $request->post('add_id', '');
           $data['add_detail'] = $request->post('detail', '');
           $data['add_name'] = $request->post('name', '');
           $data['add_telephone'] =$request->post('tel', '');
           $add = explode('/', $request->post('area',''));

            if(isset($add[0])) { 
              $data['add_province'] = $add[0];
            } 
            if(isset($add[1])) {
              $data['add_city'] = $add[1];
            }
            if(isset($add[2])) {
              $data['add_area'] = $add[2];
            }


           if(trim($data['add_name']) == null) {
              $this->showNotice("缺少收货人姓名");
            } else if(trim($data['add_telephone']) == null) {
              $this->showNotice("缺少收货人电话");
            } else if($data['add_detail'] == null || $data['add_area'] == null || $data['add_city'] == null||$data['add_province'] == null) {
              $this->showNotice("缺少收货人地址信息");
            } else {
                Db::table('address')->where('add_id',$data['add_id'])->update($data);
               //修改成功 跳回地址信息页面
               $this->redirect('User/address');
            } 
           	
        }
        $this->assign('address',$address);
		return $this->fetch('index/editAddress');
	}

	//删除地址信息
	public function del_address($add_id = null) {
		$user = $this->get_user();
        $address = Db::table('address')->where('add_id',$add_id)->find();
        $this->assign('address',$address);
		if($add_id) {
			Db::table('address')->where('add_id',$add_id)->delete();
			//删除成功 跳回地址信息页面
			$this->redirect('User/address');
		}

	}

    //设置 默认收货地址
    public function def_add() {

    } 

    public function showNotice($str, $smartMode = "javascript:history.back(-1)") {
    $str = str_replace("\n", "", $str);
    echo '<DOCTYPE HTML>';
    echo '<html>';
    echo '<head>';
    echo '<meta charset="UTF-8" />';
    echo '<title>提示信息</title>';
    echo '</head>';
    echo '<body>';
    echo '<script language="javascript">';
    echo "alert('".addslashes($str)."');";
    echo 'window.location.href="'.$smartMode.'";';
    echo '</script>';
    echo '</body>';
    echo '</html>';
    exit;
    }




	
}