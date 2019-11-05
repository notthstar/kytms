<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>物流运输管理</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="robots" content="all,follow">
    <!-- Bootstrap CSS-->
    <link rel="stylesheet" href="vendor/bootstrap/css/bootstrap.min.css">
    <!-- Font Awesome CSS-->
    <link rel="stylesheet" href="vendor/font-awesome/css/font-awesome.min.css">
    <!-- Fontastic Custom icon font-->
    <link rel="stylesheet" href="css/fontastic.css">
    <!-- Google fonts - Poppins -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Poppins:300,400,700">
    <!-- theme stylesheet-->
    <link rel="stylesheet" href="css/style.default.css" id="theme-stylesheet">
    <!-- Custom stylesheet - for your changes-->
    <link rel="stylesheet" href="css/custom.css">
    <!-- Favicon-->
    <link rel="shortcut icon" href="img/wuliu.png">
    <!-- Tweaks for older IEs--><!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script><![endif]-->
  </head>
  <body>
    <div class="page">
      <!-- Main Navbar-->
      <header class="header">
        <nav class="navbar" style="position: fixed;width: 100%;">
          <!-- Search Box-->
          <div class="search-box">
            <button class="dismiss"><i class="icon-close"></i></button>
            <form id="searchForm" action="#" role="search">
              <input type="search" placeholder="What are you looking for..." class="form-control">
            </form>
          </div>
          <div class="container-fluid">
            <div class="navbar-holder d-flex align-items-center justify-content-between">
              <!-- Navbar Header-->
              <div class="navbar-header">
                <!-- Navbar Brand --><a href="index.html" class="navbar-brand d-none d-sm-inline-block">
                  <div class="brand-text d-none d-lg-inline-block"><strong style="margin-left: -10px;" title="物流运输管理">Logistics And Transportation Management</strong></div>
                  <div class="brand-text d-none d-sm-inline-block d-lg-none"><strong>BD</strong></div></a>
                <!--<a id="toggle-btn" href="#" class="menu-btn active"><span></span><span></span><span></span></a>-->
              </div>
              <!-- Navbar Menu -->
              <!--<ul class="nav-menu list-unstyled d-flex flex-md-row align-items-md-center">
               
                <li class="nav-item d-flex align-items-center"><a id="search" href="#"><i class="icon-search"></i></a></li>
              
                <li class="nav-item dropdown"> <a id="notifications" rel="nofollow" data-target="#" href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="nav-link"><i class="fa fa-bell-o"></i><span class="badge bg-red badge-corner">0</span></a>
                  <ul aria-labelledby="notifications" class="dropdown-menu">
                    <li><a rel="nofollow" href="#" class="dropdown-item"> 
                        <div class="notification">
                          <div class="notification-content"><i class="fa fa-envelope bg-green"></i>您有0条消息</div>
                          <div class="notification-time"><small>信箱空空如也</small></div>
                        </div></a></li>-->
                    <!--<li><a rel="nofollow" href="#" class="dropdown-item"> 
                        <div class="notification">
                          <div class="notification-content"><i class="fa fa-twitter bg-blue"></i>You have 2 followers</div>
                          <div class="notification-time"><small>4 minutes ago</small></div>
                        </div></a></li>
                    <li><a rel="nofollow" href="#" class="dropdown-item"> 
                        <div class="notification">
                          <div class="notification-content"><i class="fa fa-upload bg-orange"></i>Server Rebooted</div>
                          <div class="notification-time"><small>4 minutes ago</small></div>
                        </div></a></li>
                    <li><a rel="nofollow" href="#" class="dropdown-item"> 
                        <div class="notification">
                          <div class="notification-content"><i class="fa fa-twitter bg-blue"></i>You have 2 followers</div>
                          <div class="notification-time"><small>10 minutes ago</small></div>
                        </div></a></li>
                    <li><a rel="nofollow" href="#" class="dropdown-item all-notifications text-center"> <strong>view all notifications                                            </strong></a></li>-->
                  <!--</ul>
                </li>-->
                
                <!-- Languages dropdown    -->
                 <!--<li class="nav-item dropdown">
                	<a id="languages" rel="nofollow" data-target="#" href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="nav-link language dropdown-toggle">
                		<span class="fa fa-user-o"></span>
                		<span class="d-none d-sm-inline-block">管理员</span>
                	</a>
                  <ul aria-labelledby="languages" class="dropdown-menu">
                    <li><a rel="nofollow" href="#" class="dropdown-item"> <i class="img-fluid rounded-circle fa fa-key"></i>修改密码</a></li>
                    <li><a rel="nofollow" href="login.html" class="dropdown-item"> <i class="img-fluid rounded-circle fa fa-share"></i>退出登录</a></li>
                  </ul>
                </li>
                  </ul>
                </li>-->
                <!-- Logout    -->
                <!--<li class="nav-item"><a href="login.html" class="nav-link logout"> <span class="d-none d-sm-inline">Logout</span><i class="fa fa-sign-out"></i></a></li>-->
              </ul>
            </div>
          </div>
        </nav>
      </header>
      <div class="page-content d-flex align-items-stretch"> 
        <!-- Side Navbar -->
        <nav class="side-navbar" style="position: fixed;left: 0px;height: 100%;margin-top: 56px;">
          <!-- Sidebar Header-->
          <!--<div class="sidebar-header d-flex align-items-center">
            <div class="avatar"><img src="../img/nerd bot.png" width="50px" height="50px" title="欢迎你,管理员"></div>
            <div class="title">
              <h1 class="h4">管理员</h1>
              <p>欢迎你</p>
            </div>
          </div>-->
          <!-- Sidebar Navidation Menus-->
          <ul class="list-unstyled">
          	<!--下拉列表1-->
                    <li><a href="#retailmanagement" aria-expanded="false" data-toggle="collapse" id="retailadministration"> <i class="fa fa-podcast"></i>订单管理 </a>
                    	<ul class="collapse list-unstyled" id="retailmanagement">
                    		<li class="active"><a href="storage.ftl"><i class="fa fa-toggle-off"></i>计划单</a></li>
                    		<li><a href="retailmanagement/returned.html"><i class="fa fa-toggle-off"></i>订单管理</a></li>
                    		<li><a href="retailmanagement/returned.html"><i class="fa fa-toggle-off"></i>分段订单</a></li>
                    		<li><a href="retailmanagement/returned.html"><i class="fa fa-toggle-off"></i>订单签收</a></li>
                    		<li><a href="retailmanagement/returned.html"><i class="fa fa-toggle-off"></i>订单回单管理</a></li>
                    	</ul>
                    </li>
                    <!--下拉列表2-->
                    <li><a href="#purchasingmanagement" aria-expanded="false" data-toggle="collapse"> <i class="fa fa-bookmark-o"></i>库存查询</a>
                    	<ul class="collapse list-unstyled" id="purchasingmanagement">
                    		<li><a href="purchasingmanagement/purchaseorder.html"><i class="fa fa-toggle-off"></i>在库操作</a></li>
                    		<li><a href="purchasingmanagement/procurementandstorage.html"><i class="fa fa-toggle-off"></i>出入库记录</a></li>
                    	</ul>
                    </li>
                    <!--下拉列表3-->
                    <li><a href="#salesmanagement" aria-expanded="false" data-toggle="collapse"> <i class="fa fa-plus-square-o"></i>运营管理</a>
                    	<ul class="collapse list-unstyled" id="salesmanagement">
                    		<li><a href="../salesmanagement/sell.html"><i class="fa fa-toggle-off"></i>运单</a></li>
                    		<li><a href="../salesmanagement/Salesofoutbound.html"><i class="fa fa-toggle-off"></i>派车单</a></li>
                    		<li><a href="../salesmanagement/Salesreturn.html"><i class="fa fa-toggle-off"></i>运单跟踪</a></li>
                    		<li><a href="../salesmanagement/Salesreturn.html"><i class="fa fa-toggle-off"></i>车辆到站</a></li>
                    		<li><a href="../salesmanagement/Salesreturn.html"><i class="fa fa-toggle-off"></i>到货车辆记录</a></li>
                    		<li><a href="../salesmanagement/Salesreturn.html"><i class="fa fa-toggle-off"></i>货物到站</a></li>
                    	</ul>
                    </li>
                    
          </ul><!--<span class="heading">Extras</span>
          <ul class="list-unstyled">
            <li> <a href="#"> <i class="icon-flask"></i>Demo </a></li>
            <li> <a href="#"> <i class="icon-screen"></i>Demo </a></li>
            <li> <a href="#"> <i class="icon-mail"></i>Demo </a></li>
            <li> <a href="#"> <i class="icon-picture"></i>Demo </a></li>
          </ul>-->
        </nav>
        <div class="content-inner" style="margin-left: 252px;width: 100%;margin-top: 70px;">
          <!-- Breadcrumb-->
          <div class="breadcrumb-holder container-fluid" style="width: 100%;">
            <ul class="breadcrumb">
              <li class="breadcrumb-item active"><h3 style="margin-top: 6px;">计划单</h3></li>
            </ul>
          </div>
          <!--表单-->
          <section class="forms" style="padding: 0px;"> 
            <div class="container-fluid" style="padding: 0px;">
                <!-- Basic Form-->
                  <div class="card">
                    <div class="card-header d-flex " style="width: 100%;">
                    	<!--下拉列表-->
                    	<form action="" method="post">
                    		
											<div class="btn-group">
   											<select class="btn form-control" style="border: 1px #B8C1CA solid;border-radius: 4px;width: 220px;">
    							  			<option><a href="#">功能</a></option>
   											</select>&nbsp;
   											<input type="text" class="form-control" placeholder="请输入要查询的关键字" style="width: 200px;border-radius: 4px;"/>&nbsp;
   											<button class="btn btn-success" type="submit" style="border-radius: 4px;">查询</button>&nbsp;
   											<button class="btn btn-block" type="submit" style="border-radius: 4px;">高级查询</button>
											</div>
											
											<div class="btn-group">
												<button class="btn btn-success" type="submit" >新增</button>
												<button class="btn btn-info" type="submit" >编辑</button>
												<button class="btn btn-danger" type="submit" >删除</button>
											</div>
											</div>
                    </div>
                   </form>
                      <div style="background-color: white;margin-top: -30px;overflow: scroll;height: 400px;" class="row pre-scrollable">
                      	<table class="table table-hover text-center table-bordered"
                      		style="min-width: 3000px;">
                      		<tr>
                      			<th><input type="checkbox" title="全选" id="chElt" onclick="checkOrCancelAll()"></th>
                      			<th>详情</th>
                      			<th>组织机构</th>
                      			<th>状态</th>
                      			<th>提货区域</th>
                      			<th>发货单位</th>
                      			<th>发货地址</th>
                      			<th>重量</th>
                      			<th>件数</th>
                      			<th>体积</th>
                      			<th>发货人</th>
                      			<th>发货电话</th>
                      			<th>计划单号</th>
                      			<th>客户类型</th>
                      			<th>提货单号</th>
                      			<th>预录单日期</th>
                      			<th>收货单位</th>
                      			<th>收货人</th>
                      			<th>收货电话</th>
                      			<th>收货地址</th>
                      			<th>备注</th>
                      			<th>创建人</th>
                      			<th>创建时间</th>
                      			<th>修改人</th>
                      			<th>修改时间</th>
                      		</tr>
                      		<#list plan as p>
                      		    <tr>
                                    <td><input type="checkbox" name="cElt"></td>
                                    <td>
                                        <a href="#">
                                            <i class="fa fa-list" title="查看"></i>
                                        </a>
                                    </td>
                                    <td>${p.organizatilName}</td>
                                    <td>${p.status}</td>
                                    <td>${p.zoneName}</td>
                                    <td>${p.fhName}</td>
                                    <td>${p.fhAddress}</td>
                                    <td>${p.weight}</td>
                                    <td>${p.number}</td>
                                    <td>${p.volume}</td>
                                    <td>${p.fhPerson}</td>
                                    <td>${p.fhIphone}</td>
                                    <td>${p.code}</td>
                                    <td>${p.costomerTpye}</td>
                                    <td>${p.relatebill1}</td>
                                    <td>${p.dateAccepted}</td>
                                    <td>${p.shName}</td>
                                    <td>${p.shPerson}</td>
                                    <td>${p.shIphone}</td>
                                    <td>${p.shAddress}</td>
                                    <td>${p.description}</td>
                                    <td>${p.createName}</td>
                                    <td>${p.createTime}</td>
                                    <td>${p.modifyName}</td>
                                    <td>${p.modifyTime}</td>
                                </tr>
                      		</#list>
                      	</table>
                      	
                      </div>
                      <!---->
                  </div>
                </div>
              </div>
            </div>
          </section> 
        </div>
      </div>
    </div>
    
    			<!--模态框-->
          <div class="modal fade" id="insert" tabindex="-1" role="dialog" aria-hidden="false" aria-labelledby="mymodalriLabel" data-backdrop="static" data-keyboard="true">
							<div class="modal-dialog modal-lg">
								<div class="modal-content" style="width: 878px;">
									<div class="modal-header">
										<span class="modal-title" id="mymodalriLabel">
											<i class="fa fa-cog fa-spin fa-3x fa-fw" style="font-size: 23px;"></i>
											添加零售出库信息
										</span>
										<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="fa fa-times" style="color: red;"></i>
										</button>
									</div>
									<div class="modal-body">
										<form class="form-horizontal">
											<table class="form-group">
												<tr>
													<td>会员卡号：</td>
													<td width="120px">
														<select class="form-control">
															<option>1</option>
															<option>2</option>
														</select>
													</td>
													<td>单据日期：</td>
													<td width="170px"><input type="date" class="form-control" pattern="yyyy-MM-dd"></td>
													<td>单据编号：</td>
													<td width="120px">
														<input type="text" class="form-control">
													</td>
													<td>付款方式：</td>
													<td width="120px">
														<select class="form-control">
															<option>现金</option>
															<option>微信</option>
														</select>
													</td>
												</tr>
											</table>
													<div style="display: flex;justify-content: space-between;">
														<a href="#">
															<button class="btn btn-success btn-sm" title="添加行">
                      					<i class="fa fa-plus-square"></i>
                      					添加
                      				</button>
                      			</a>
                      			<a href="#">
                      				<button class="btn btn-danger btn-sm" title="删除行">
                      					<i class="fa fa-trash-o"></i>
                      					删除
                      				</button>
                      			</a>
                      			<a href="#">
                      				<button class="btn btn-success btn-sm" title="新增仓库">
                      					<i class="fa fa-cart-arrow-down"></i>
                      					添加仓库
                      				</button>
                      			</a>
                      			<a href="#">
                      				<button class="btn btn-success btn-sm" title="新增商品">
                      					<i class="fa fa-cart-plus"></i>
                      					添加商品
                      				</button>
                      			</a>
                      			<a href="#">
                      				<button class="btn btn-warning btn-sm" title="撤销">
                      					<i class="fa fa-mail-reply"></i>
                      					撤销
                      				</button>
                      			</a>
                      				<button class="btn btn-success btn-sm" title="新增会员" data-toggle='modal' data-target="#rigerth" type="button">
                      					<i class="fa fa-user-o"></i>
                      					添加会员
                      				</button>
													</div>
										<div style="margin-top: 20px;">
                      	<table class="table table-hover text-center">
                      		<tr class="text-bold">
                      			<td><input type="checkbox" title="全选" id="thElt" onclick="checkOrCancelMo()"></td>
                      			<td>仓库名称</td>
                      			<td>品名(型号)</td>
                      			<td>库存</td>
                      			<td>单位</td>
                      			<td>数量</td>
                      			<td>单价</td>
                      			<td>金额</td>
                      			<td>备注</td>
                      		</tr>
                      		<tr>
                      			<td><input type="checkbox" name="tElt"></td>
                      			<td>数据</td>
                      			<td>数据</td>
                      			<td>数据</td>
                      			<td>数据</td>
                      			<td>数据</td>
                      			<td>数据</td>
                      			<td>数据</td>
                      			<td>数据</td>
                      		</tr>
                      	</table>
                      </div>
                      <div>
                      	<table>
                      		<tr >
                      			<td>实收金额:</td>
                      			<td width="156px">
                      				<input type="text" value="128" readonly="readonly" class="form-control" style="color: green;">
                      			</td>
                      			<td>收款金额:</td>
                      			<td width="156px">
                      				<input type="text"class="form-control" style="color: red;">
                      			</td>
                      			<td>找零:</td>
                      			<td width="155px">
                      				<input type="text"class="form-control">
                      			</td>
                      			<td>收款账户:</td>
                      			<td width="155px">
                      				<select class="form-control">
                      					<option>wg127</option>
                      					<option>vg454</option>
                      				</select>
                      			</td>
                      		</tr>
                      	</table>
                      	<div style="margin-top: 10px;">
                      		<textarea class="form-control" rows="2" placeholder="备注信息"></textarea>
                      	</div>
                      </div>
                      <div class="modal-footer">
                      	<button class="btn btn-success col-md-12">保存</button>&nbsp;
                      </div>
                  </form>
							</div>
						</div>
					</div>
			</div>
			
			
			<!--新增会员模态框-->
			<div class="modal fade" role="dialog" tabindex="-1" aria-hidden="false" aria-labelledby="mymodalrigerth" data-backdrop="static" data-keyboard="true" id="rigerth">
			<div class="modal-dialog modal-lg">
				<div class="modal-content" style="width: 878px;">
					<div class="modal-header">
						<span class="modal-title" id="mymodalriLabel">
											<i class="fa fa-cog fa-spin fa-3x fa-fw" style="font-size: 23px;"></i>
											添加会员
										</span>
										<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="fa fa-times" style="color: red;"></i>
										</button>
					</div>
					<div class="modal-body">
						<form class="form-horizontal">
							<table>
								<tr>
									<td style="width: 500px;">
										<input type="text" class="form-control" placeholder="用户名">
									</td>
									<td style="width: 500px;">
										<input type="text" class="form-control" placeholder="联系人">
									</td>
								</tr>
								<tr>
									<td style="width: 500px;">
										<input type="text" class="form-control" placeholder="手机号码">
									</td>
									<td style="width: 500px;">
										<input type="text" class="form-control" placeholder="邮箱">
									</td>
								</tr>
								<tr>
									<td style="width: 500px;">
										<input type="text" class="form-control" placeholder="联系电话">
									</td>
									<td style="width: 500px;">
										<input type="text" class="form-control" placeholder="传真">
									</td>
								</tr>
								<tr>
									<td style="width: 500px;">
										<input type="text" class="form-control" placeholder="期初应收">
									</td>
									<td style="width: 500px;">
										<input type="text" class="form-control" placeholder="期初应付">
									</td>
								</tr>
								<tr>
									<td style="width: 500px;">
										<input type="text" class="form-control" placeholder="累计应收" readonly="readonly">
									</td>
									<td style="width: 500px;">
										<input type="text" class="form-control" placeholder="累计应付" readonly="readonly">
									</td>
								</tr>
								<tr>
									<td style="width: 500px;">
										<input type="text" class="form-control" placeholder="纳税人识别号">
									</td>
									<td style="width: 500px;">
										<input type="text" class="form-control" placeholder="税率(%)">
									</td>
								</tr>
								<tr>
									<td style="width: 500px;">
										<input type="text" class="form-control" placeholder="开户行">
									</td>
									<td style="width: 500px;">
										<input type="text" class="form-control" placeholder="账号">
									</td>
								</tr>
								<tr>
									<td style="width: 1000px;" colspan="2">
										<input type="text" class="form-control" placeholder="地址">
									</td>
								</tr>
								<tr>
									<td style="width: 1000px;" colspan="2">
										<textarea class="form-control" rows="2" placeholder="备注"></textarea>
									</td> 
								</tr>
							</table>
							<div class="modal-footer">
									<button class="btn btn-success col-md-12" type="submit">保存</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
			
			
    
    <!-- JavaScript files-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/popper.js/umd/popper.min.js"> </script>
    <script src="vendor/bootstrap/js/bootstrap.min.js"></script>
    <script src="vendor/jquery.cookie/jquery.cookie.js"> </script>
    <script src="vendor/chart.js/Chart.min.js"></script>
    <script src="vendor/jquery-validation/jquery.validate.min.js"></script>
    <script src="js/charts-custom.js"></script>
    <!-- Main File-->
    <script src="js/front.js"></script>
    <!--全选框-->
    <script type="text/javascript">
    	function checkOrCancelAll(){
				var chElt=document.getElementById("chElt");
				var checkedElt=chElt.checked;
				var allCheck=document.getElementsByName("cElt");
				if(checkedElt){
					for(var i=0;i<allCheck.length;i++){
					allCheck[i].checked=true;
					}
				}else{
					for(var i=0;i<allCheck.length;i++){
					allCheck[i].checked=false;
					}
				}
			}
    	
    	function checkOrCancelMo(){
				var chElt = document.getElementById("thElt");
				var checkedElt = chElt.checked;
				var allCheck = document.getElementsByName("tElt");
				if(checkedElt){
					for(var i=0;i<allCheck.length;i++){
					allCheck[i].checked=true;
					}
				}else{
					for(var i=0;i<allCheck.length;i++){
					allCheck[i].checked=false;
					}
				}
			}
    	
    	window.onload = function(){
    		document.getElementById("retailadministration").click();
    	}
    </script>
  </body>
</html>