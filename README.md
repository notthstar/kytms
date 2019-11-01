# KYTMS
    路宁物流管理系统

## 技术框架
    SpringBoot、Spring MVC、mybatis-plus  
    数据库：mysql、redis  
    日志框架：log4j

## 项目结构
    src/main/java
    com.t28.forest
        ->operate : 运营管理
        ->order : 订单管理
        ->core : 核心公共包
        ->stock : 库存管理
        ->config : 配置类
        ->interceptor : 拦截器（用户登录验证）
    src/main/resources
        ->mapper : mybatis : Mapper映射的XML文件
            ->operate
            ->order
            ->stock
        ->static : 静态资源文件（图片/jquery/bootstrap）
        ->templates : 页面模板（Freemarker/Thymeleaf）
    src/test/java
    com.t28.forest
        ->operate : 运营管理测试包
        ->order : 订单管理测试包
        ->stock : 库存管理测试包
        ->MainTest : 公共测试类
        
