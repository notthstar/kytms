(function ($) {
    $.selectSuggest = function (target, data, itemSelectFunction) {
        var defaulOption = {
            suggestMaxHeight: '200px',
            itemColor: '#000000',
            itemBackgroundColor: 'RGB(199,237,204)',
            itemOverColor: '#ffffff',
            itemOverBackgroundColor: '#C9302C',
            itemPadding: 3,
            fontSize: 12,
            alwaysShowALL: true
        };
        var maxFontNumber = 0;
        var currentItem;
        var suggestContainerId = target + "-suggest";
        var suggestContainerWidth = $('#' + target).innerWidth();
        var suggestContainerLeft = $('#' + target).offset().left;
        var suggestContainerTop = $('#' + target).offset().top + $('#' + target).outerHeight();
        var showClickTextFunction = function () {
            $('#' + target).val(this.innerText);
            currentItem = null;
            $('#' + suggestContainerId).hide();
        }
        var suggestContainer;
        if ($('#' + suggestContainerId)[0]) {
            suggestContainer = $('#' + suggestContainerId);
            suggestContainer.empty();
        } else {
            suggestContainer = $('<div></div>');
        }
        suggestContainer.attr('id', suggestContainerId);
        suggestContainer.attr('tabindex', '0');
        suggestContainer.hide();
        var _initItems = function (items) {
            suggestContainer.empty();
            for (var i = 0; i < items.length; i++) {
                if (items[i].text.length > maxFontNumber) {
                    maxFontNumber = items[i].text.length;
                }
                var suggestItem = $('<div></div>');
                suggestItem.attr('id', items[i].id);
                suggestItem.append(items[i].text);
                suggestItem.css({
                    'padding': defaulOption.itemPadding + 'px',
                    'white-space': 'nowrap',
                    'cursor': 'pointer',
                    'background-color': defaulOption.itemBackgroundColor,
                    'color': defaulOption.itemColor
                });
                suggestItem.bind("mouseover", function () {
                    $(this).css({
                        'background-color': defaulOption.itemOverBackgroundColor,
                        'color': defaulOption.itemOverColor
                    });
                    currentItem = $(this);
                });
                suggestItem.bind("mouseout", function () {
                    $(this).css({
                        'background-color': defaulOption.itemBackgroundColor,
                        'color': defaulOption.itemColor
                    });
                    currentItem = null;
                });
                suggestItem.bind("click", showClickTextFunction);
                suggestItem.bind("click", itemSelectFunction);
                suggestItem.appendTo(suggestContainer);
                suggestContainer.appendTo(document.body);
            }
        }
        var inputChange = function () {
            var inputValue = $('#' + target).val();
            inputValue = inputValue.replace(/[\-\[\]{}()*+?.,\\\^$|#\s]/g, "\\$&");
            var matcher = new RegExp(inputValue, "i");
            return $.grep(data, function (value) {
                return matcher.test(value.text);
            });
        }
        $('#' + target).bind("keyup", function () {
            _initItems(inputChange());
        });
        $('#' + target).bind("blur", function () {
            if (!$('#' + suggestContainerId).is(":focus")) {
                $('#' + suggestContainerId).hide();
                if (currentItem) {
                    currentItem.trigger("click");
                }
                currentItem = null;
                return;
            }
        });
        $('#' + target).bind("click", function () {
            if (defaulOption.alwaysShowALL) {
                _initItems(data);
            } else {
                _initItems(inputChange());
            }
            $('#' + suggestContainerId).removeAttr("style");
            var tempWidth = defaulOption.fontSize * maxFontNumber + 2 * defaulOption.itemPadding + 30;
            var containerWidth = Math.max(tempWidth, suggestContainerWidth);
            $('#' + suggestContainerId).css({
                'border': '1px solid #ccc',
                'max-height': '200px',
                'top': suggestContainerTop,
                'left': suggestContainerLeft,
                'width': containerWidth,
                'position': 'absolute',
                'font-size': defaulOption.fontSize + 'px',
                'font-family': 'Arial',
                'z-index': 99999,
                'background-color': '#FFFFFF',
                'overflow-y': 'auto',
                'overflow-x': 'hidden',
                'white-space': 'nowrap'
            });
            $('#' + suggestContainerId).show();
        });
        _initItems(data);
        $('#' + suggestContainerId).bind("blur", function () {
            $('#' + suggestContainerId).hide();
        });
    }
})(jQuery);