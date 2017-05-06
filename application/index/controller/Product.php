<?php
namespace app\index\controller;
use think\Config;
use think\Db;
use think\Request;
use think\Cache;

class Product extends Base {
  public $pageSize = 10;

	public function __construct() {
		parent::__construct();
	}
  public function test() {
   
    return $this->fetch("index/teacherWork");
  }
  
  //搜索功能
  public function search() {

    $request = Request::instance();
    if($request -> isGet()) {
      $pro = $request->get('product','');
        //大师作品
        $works = Db::table('master')->alias('m')
                                      ->join('works w','w.master_id = m.master_id')
                                      ->field('w.works_name, w.works_pic, w.works_summary, w.works_price,w.works_sales')
                                      ->where('master_name|works_name','like','%'.$pro.'%')
                                      ->where('works_status = 1')
                                      ->order('time desc')
                                      ->select(); 
        foreach ($works as $key => $value) {
            $works[$key]['works_price'] = current(json_decode($value['works_price'],true));
            $works[$key]['works_pic'] = current(json_decode($value['works_pic'],true));
        }                      


   
        //普通产品
        $goods = Db::table('goods')->alias('g')
                                     ->join('goods_class c','g.gtype_id = c.gtype_id')
                                     ->field('g.gname, g.gimg, g.gdec_s, g.gpri, g.gsales')
                                     ->where('gname|gtype_name','like','%'.$pro.'%')
                                     ->where('gstatic = 1')
                                     ->order('gtime desc')
                                     ->select();
        foreach ($goods as $key => $value) {
            $goods[$key]['gpri'] = current(json_decode($value['gpri'],true));
            $goods[$key]['gimg'] = current(json_decode($value['gimg'],true));
        }     
       
    $this->assign('pro',$pro);
    $this->assign('works',$works);
    $this->assign('goods',$goods);   
    }  
     return $this->fetch("index/teacherWork");
  }





	
}