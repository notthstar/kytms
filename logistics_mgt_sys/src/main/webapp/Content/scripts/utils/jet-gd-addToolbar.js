/**
 辽宁捷畅物流有限公司 -信息技术中心
 臧英明

 @author
 @create 2017-07-24
 */
window.onload = function () {
    map.plugin(["AMap.ToolBar"], function () {
        map.addControl(new AMap.ToolBar());
    });
    if (location.href.indexOf('&guide=1') !== -1) {
        map.setStatus({scrollWheel: false})
    }
}