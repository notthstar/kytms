<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>华夏ERP/零售退货</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="robots" content="all,follow">
    <!-- Bootstrap CSS-->
    <link rel="stylesheet" href="../vendor/bootstrap/css/bootstrap.min.css">
    <!-- Font Awesome CSS-->
    <link rel="stylesheet" href="../vendor/font-awesome/css/font-awesome.min.css">
    <!-- Fontastic Custom icon font-->
    <link rel="stylesheet" href="../css/fontastic.css">
    <!-- Google fonts - Poppins -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Poppins:300,400,700">
    <!-- theme stylesheet-->
    <link rel="stylesheet" href="../css/style.default.css" id="theme-stylesheet">
    <!-- Custom stylesheet - for your changes-->
    <link rel="stylesheet" href="../css/custom.css">
    <!-- Favicon-->
    <link rel="shortcut icon" href="../img/flag-china.png">
    <!-- Tweaks for older IEs--><!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script><![endif]-->
  </head>
  <body>
    <div class="page">
      <!-- Main Navbar-->
      <header class="header">
        <nav class="navbar">
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
                  <div class="brand-text d-none d-lg-inline-block"><strong>华夏ERP</strong></div>
                  <div class="brand-text d-none d-sm-inline-block d-lg-none"><strong>BD</strong></div></a>
                <!-- Toggle Button--><a id="toggle-btn" href="#" class="menu-btn active"><span></span><span></span><span></span></a>
              </div>
              <!-- Navbar Menu -->
              <ul class="nav-menu list-unstyled d-flex flex-md-row align-items-md-center">
                <!-- Search-->
                <li class="nav-item d-flex align-items-center"><a id="search" href="#"><i class="icon-search"></i></a></li>
                <!-- Notifications-->
                <li class="nav-item dropdown"> <a id="notifications" rel="nofollow" data-target="#" href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="nav-link"><i class="fa fa-bell-o"></i><span class="badge bg-red badge-corner">0</span></a>
                  <ul aria-labelledby="notifications" class="dropdown-menu">
                    <li><a rel="nofollow" href="#" class="dropdown-item"> 
                        <div class="notification">
                          <div class="notification-content"><i class="fa fa-envelope bg-green"></i>您有0条消息</div>
                          <div class="notification-time"><small>信箱空空如也</small></div>
                        </div></a></li>
                  </ul>
                </li>
                
                <!-- Languages dropdown    -->
                 <li class="nav-item dropdown">
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
                </li>
                <!-- Logout    -->
                <!--<li class="nav-item"><a href="login.html" class="nav-link logout"> <span class="d-none d-sm-inline">Logout</span><i class="fa fa-sign-out"></i></a></li>-->
              </ul>
            </div>
          </div>
        </nav>
      </header>
      <div class="page-content d-flex align-items-stretch"> 
        <!-- Side Navbar -->
        <nav class="side-navbar">
          <!-- Sidebar Header-->
          <div class="sidebar-header d-flex align-items-center">
            <div class="avatar"><img src="../img/nerd bot.png" width="50px" height="50px" title="欢迎你,管理员"></div>
            <div class="title">
              <h1 class="h4">管理员</h1>
              <p>欢迎你</p>
            </div>
          </div>
          <!-- Sidebar Navidation Menus--><span class="heading">Main</span>
          <ul class="list-unstyled">
          	<!--下拉列表1-->
                    <li><a href="#retailmanagement" aria-expanded="false" data-toggle="collapse" id="retailadministration"> <i class="fa fa-podcast"></i>零售管理 </a>
                    	<ul class="collapse list-unstyled" id="retailmanagement">
                    		<li><a href="storage.ftl"><i class="fa fa-toggle-off"></i>零售出库</a></li>
                    		<li class="active"><a href="returned.ftl"><i class="fa fa-toggle-off"></i>零售退货</a></li>
                    	</ul>
                    </li>
                    <!--下拉列表2-->
                    <li><a href="#purchasingmanagement" aria-expanded="false" data-toggle="collapse"> <i class="fa fa-bookmark-o"></i>采购管理</a>
                    	<ul class="collapse list-unstyled" id="purchasingmanagement">
                    		<li><a href="../purchasingmanagement/purchaseorder.html"><i class="fa fa-toggle-off"></i>采购订单</a></li>
                    		<li><a href="../purchasingmanagement/procurementandstorage.html"><i class="fa fa-toggle-off"></i>采购入库</a></li>
                    		<li><a href="../purchasingmanagement/Purchasereturn.html"><i class="fa fa-toggle-off"></i>采购退货</a></li>
                    	</ul>
                    </li>
                    <!--下拉列表3-->
                    <li><a href="#salesmanagement" aria-expanded="false" data-toggle="collapse"> <i class="fa fa-plus-square-o"></i>销售管理</a>
                    	<ul class="collapse list-unstyled" id="salesmanagement">
                    		<li><a href="../salesmanagement/sell.html"><i class="fa fa-toggle-off"></i>销售订单</a></li>
                    		<li><a href="../salesmanagement/Salesofoutbound.html"><i class="fa fa-toggle-off"></i>销售出库</a></li>
                    		<li><a href="../salesmanagement/Salesreturn.html"><i class="fa fa-toggle-off"></i>销售退货</a></li>
                    	</ul>
                    </li>
                    <!--下拉列表4-->
                    <li><a href="#storemanagement" aria-expanded="false" data-toggle="collapse"> <i class="fa fa-plus-square"></i>仓库管理</a>
                    	<ul class="collapse list-unstyled" id="storemanagement">
                    		<li><a href="../storemanagement/Otherwarehouse.html"><i class="fa fa-toggle-off"></i>其他入库</a></li>
                    		<li><a href="../storemanagement/Otheroutbound.html"><i class="fa fa-toggle-off"></i>其他出库</a></li>
                    		<li><a href="../storemanagement/allocatingoutbound.html"><i class="fa fa-toggle-off"></i>调拨出库</a></li>
                    		<li><a href="../storemanagement/Assemblythesingle.html"><i class="fa fa-toggle-off"></i>组装单</a></li>
                    		<li><a href="../storemanagement/Removethesingle.html"><i class="fa fa-toggle-off"></i>拆卸单</a></li>
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
        <div class="content-inner">
          <!-- Page Header-->
          <header class="page-header">
            <div class="container-fluid">
              <h2 class="no-margin-bottom">零售管理</h2>
            </div>
          </header>
          <!-- Breadcrumb-->
          <div class="breadcrumb-holder container-fluid">
            <ul class="breadcrumb">
              <li class="breadcrumb-item"><a href="index.html">首页</a></li>
              <li class="breadcrumb-item active">零售退货</li>
            </ul>
          </div>
          
          
          
          
          <!--表单-->
          <section class="forms"> 
            <div class="container-fluid">
              <div class="row">
                <!-- Basic Form-->
                <div class="col-lg-12">
                  <div class="card">
                    <div class="card-close">
                      
                    </div>
                    <div class="card-header d-flex align-items-center">
                    	<strong>
                    			<i class="fa fa-window-maximize" aria-hidden="true"></i>
                      		零售退货列表</strong>
                    </div>
                    <div class="card-body">
                    	<form class="form-horizontal">
                      <table>
                      	<tr>
                      		<div class="form-group">
                      			<td>单据编号：</td>
                      			<td width="150px"><input type="text" class="form-control"></td>
                      		</div>
                      		<div class="form-group">
                      			<td>商品信息：</td>
                      			<td width="150px"><input type="text" class="form-control" placeholder="名称/型号"></td>
                      		</div>
                      		<div class="form-group">
                      			<td>单据日期：</td>
                      			<td width="170px"><input type="date" class="form-control" pattern="yyyy-MM-dd"></td>
                      		</div>
                      		
                      		<div class="form-group">
                      			<td>-</td>
                      			<td width="170px"><input type="date" class="form-control" pattern="yyyy-MM-dd"></td>
                      		</div>
                      		<div class="form-group">
                      			<td>
                      			<a href="#">
                      			<button class="btn btn-success" style="width: 122px;">
                      				<i class="fa fa-search"></i>
                      				查询
                      			</button>
                      			</a>
                      		</td>
                      		</div>
                      		<div class="form-group">
                      			<td>
                      			<a href="#">
                      			<button type="reset" class="btn btn-success"  style="width: 122px;">
                      				<i class="fa fa-share-square"></i>
                      				重置
                      			</button>
                      			</a>
                      		</td>
                      		</div>
                      	</tr>
                      </table>
                     </form>
                      <div style="margin-top: 20px;">
                      	<table class="table table-hover text-center">
                      		<tr class="text-bold">
                      			<td><input type="checkbox" title="全选" id="chElt" onclick="checkOrCancelAll()"></td>
                      			<td>操作</td>
                      			<td>会员卡号</td>
                      			<td>单据编号</td>
                      			<td>商品信息</td>
                      			<td>单据日期</td>
                      			<td>操作员</td>
                      			<td>金额合计</td>
                      			<td>收款</td>
                      		</tr>
                      		<tr>
                      			<td><input type="checkbox" name="cElt"></td>
                      			<td style="display: flex; justify-content: space-between;">
                      				<a href="#">
                      					<i class="fa fa-list" title="查看"></i>
                      				</a>
                      				<a href="#" style="color: green;">
                      					<i class="fa fa-pencil-square-o" title="编辑"></i>
                      				</a>
                      				<a href="#" style="color: red;">
                      					<i class="fa fa-trash-o" title="删除"></i>
                      				</a>
                      			</td>
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
                      <div style="display: flex;justify-content: flex-end;">
                      	<button class="btn btn-success" title="添加" data-toggle="modal" data-target="#insert">
                      		<i class="fa fa-plus"></i>
                      		添加
                      	</button>&nbsp;
                      	<button class="btn btn-danger" title="删除">
                      		<i class="fa fa-times"></i>
                      		删除
                      	</button>
                      </div>
                      <div style="display: flex;justify-content: center;">
                         	<ul class="pagination">
    												<li class="page-item">
      												<a href="#" class="page-link">
        												<span aria-hidden="true">&laquo;</span>
      												</a>
    												</li>
    												<li class="page-item">
    													<a href="#" class="page-link">1</a>
    												</li>
    												<li class="page-item">
    													<a href="#" class="page-link">2</a>
    												</li>
    												<li class="page-item">
    													<a href="#" class="page-link">3</a>
    												</li>
    												<li class="page-item">
    													<a href="#" class="page-link">4</a>
    												</li>
    												<li class="page-item">
    													<a href="#" class="page-link">5</a>
    												</li>
    												<li class="page-item">
      												<a href="#" class="page-link">
        												<span aria-hidden="true">&raquo;</span>
      												</a>
    												</li>
  												</ul>
                      </div>
                    </div>
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
											添加零售退货信息
										</span>
										<button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="fa fa-times" style="color: red;"></i>
										</button>
									</div>
									<div class="modal-body">
										<form class="form-horizontal">
											<table class="form-group">
												<tr>
														<td>会员卡号：</td>
														<td width="206px">
														<select class="form-control">
															<option>1</option>
															<option>2</option>
														</select>
													</td>
														<td>单据日期：</td>
														<td width="206px"><input type="date" class="form-control" pattern="yyyy-MM-dd"></td>
														<td>单据编号：</td>
														<td width="206px">
														<input type="text" class="form-control"></td>
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
                      			<td>实付金额:</td>
                      			<td width="156px">
                      				<input type="text" value="128" readonly="readonly" class="form-control" style="color: green;">
                      			</td>
                      			<td>付款金额:</td>
                      			<td width="156px">
                      				<input type="text"class="form-control" style="color: red;">
                      			</td>
                      			<td>找零:</td>
                      			<td width="155px">
                      				<input type="text"class="form-control">
                      			</td>
                      			<td>付款账户:</td>
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
			
    
    <!-- JavaScript files-->
    <script src="../vendor/jquery/jquery.min.js"></script>
    <script src="../vendor/popper.js/umd/popper.min.js"> </script>
    <script src="../vendor/bootstrap/js/bootstrap.min.js"></script>
    <script src="../vendor/jquery.cookie/jquery.cookie.js"> </script>
    <script src="../vendor/chart.js/Chart.min.js"></script>
    <script src="../vendor/jquery-validation/jquery.validate.min.js"></script>
    <script src="../js/charts-custom.js"></script>
    <!-- Main File-->
    <script src="../js/front.js"></script>
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