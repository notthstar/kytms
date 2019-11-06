// function getMapData() {
//     AMap.plugin(['AMap.Autocomplete', 'AMap.PlaceSearch'], function () {
//         var autoOptions = {
//             input: "address"//使用联想输入的input的id
//         };
//         autocomplete = new AMap.Autocomplete(autoOptions);
//         var placeSearch = new AMap.PlaceSearch({
//         });
//         AMap.event.addListener(autocomplete, "select", function (e) {
//             //TODO 针对选中的poi实现自己的功能
//             placeSearch.search(e.poi.name)
//         });
//     });
// }
// function getMapDataFroId(id) {
//     AMap.plugin(['AMap.Autocomplete', 'AMap.PlaceSearch'], function () {
//         var autoOptions = {
//             input: id//使用联想输入的input的id
//         };
//         autocomplete = new AMap.Autocomplete(autoOptions);
//         var placeSearch = new AMap.PlaceSearch({
//         });
//         AMap.event.addListener(autocomplete, "select", function (e) {
//             //TODO 针对选中的poi实现自己的功能
//             placeSearch.search(e.poi.name)
//         });
//     });
// }
//
// if (typeof map !== 'undefined') {
//     map.on('complete', function () {
//         if (location.href.indexOf('guide=1') !== -1) {
//             map.setStatus({
//                 scrollWheel: false
//             });
//             if (location.href.indexOf('litebar=0') === -1) {
//                 map.plugin(["AMap.ToolBar"], function () {
//                     var options = {
//                         liteStyle: true
//                     }
//                     if (location.href.indexOf('litebar=1') !== -1) {
//                         options.position = 'LT';
//                         options.offset = new AMap.Pixel(10, 40);
//                     } else if (location.href.indexOf('litebar=2') !== -1) {
//                         options.position = 'RT';
//                         options.offset = new AMap.Pixel(20, 40);
//                     } else if (location.href.indexOf('litebar=3') !== -1) {
//                         options.position = 'LB';
//                     } else if (location.href.indexOf('litebar=4') !== -1) {
//                         options.position = 'RB';
//                     }
//                     map.addControl(new AMap.ToolBar(options));
//                 });
//             }
//         }
//     });
// }

function getMapDataFroId(id,ltlId) {
    AMap.plugin(['AMap.Autocomplete', 'AMap.PlaceSearch','AMap.Geocoder'], function () {
        var autoOptions = {
            input: id//使用联想输入的input的id
        };
        autocomplete = new AMap.Autocomplete(autoOptions);
        var placeSearch = new AMap.PlaceSearch({
            extensions:'all'
        });
        var geocoder = new AMap.Geocoder({ //地理逆编码
        })
        AMap.event.addListener(autocomplete, "select", function (e) {
            var poi = e.poi
            if(poi.location != null && poi.location != undefined){

                var location = poi.location
                if(location.lng != null && location.lng != undefined){ //精度
                    $("#"+ltlId).val(location.lng+","+location.lat);
                }

            }
            placeSearch.search(e.poi.name)
        });
        $('#'+id).bind('keyup', function(event) {
            if (event.keyCode == "13") {
                geocoder.getLocation( $("#"+id).val(), function(status, result) {
                    if (status === 'complete' && result.info === 'OK') {
                        if(result.geocodes.length > 0){
                            $("#"+ltlId).val(result.geocodes[0].location.lng+","+result.geocodes[0].location.lat);
                        }
                    }
                })
            }
        });
    });
}
function getMapDataFroIdAddress(id,ltlId,address) {
    AMap.plugin(['AMap.Autocomplete', 'AMap.PlaceSearch','AMap.Geocoder'], function () {
        var autoOptions = {
            input: id//使用联想输入的input的id
        };
        autocomplete = new AMap.Autocomplete(autoOptions);
        var placeSearch = new AMap.PlaceSearch({
            extensions:'all'
        });
        var geocoder = new AMap.Geocoder({ //地理逆编码
        })




        AMap.event.addListener(autocomplete, "select", function (e) {
            var poi = e.poi
            if(poi.location != null && poi.location != undefined){
                var location = poi.location
                if(location.lng != null && location.lng != undefined){ //精度
                    $("#"+ltlId).val(location.lng+","+location.lat);
                    $("#"+address).val(poi.district+poi.address);
                }
            }
            placeSearch.search(e.poi.name)
        });
        $('#'+id).bind('keyup', function(event) {
            if (event.keyCode == "13") {
                geocoder.getLocation( $("#"+id).val(), function(status, result) {
                    if (status === 'complete' && result.info === 'OK') {
                      if(result.geocodes.length > 0){
                          $("#"+ltlId).val(result.geocodes[0].location.lng+","+result.geocodes[0].location.lat);
                          $("#"+address).val($("#"+id).val());
                      }
                    }
                })
            }
        });
    });


}