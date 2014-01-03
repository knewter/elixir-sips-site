!function(e,t,s,i){"use strict";Foundation.libs.reveal={name:"reveal",version:"4.2.2",locked:!1,settings:{animation:"fadeAndPop",animationSpeed:250,closeOnBackgroundClick:!0,closeOnEsc:!0,dismissModalClass:"close-reveal-modal",bgClass:"reveal-modal-bg",open:function(){},opened:function(){},close:function(){},closed:function(){},bg:e(".reveal-modal-bg"),css:{open:{opacity:0,visibility:"visible",display:"block"},close:{opacity:1,visibility:"hidden",display:"none"}}},init:function(t,s,i){return Foundation.inherit(this,"data_options delay"),"object"==typeof s?e.extend(!0,this.settings,s):"undefined"!=typeof i&&e.extend(!0,this.settings,i),"string"!=typeof s?(this.events(),this.settings.init):this[s].call(this,i)},events:function(){var t=this;return e(this.scope).off(".fndtn.reveal").on("click.fndtn.reveal","[data-reveal-id]",function(s){if(s.preventDefault(),!t.locked){var i=e(this),n=i.data("reveal-ajax");if(t.locked=!0,"undefined"==typeof n)t.open.call(t,i);else{var o=n===!0?i.attr("href"):n;t.open.call(t,i,{url:o})}}}).on("click.fndtn.reveal",this.close_targets(),function(s){if(s.preventDefault(),!t.locked){var i=e.extend({},t.settings,t.data_options(e(".reveal-modal.open")));if(e(s.target)[0]===e("."+i.bgClass)[0]&&!i.closeOnBackgroundClick)return;t.locked=!0,t.close.call(t,e(this).closest(".reveal-modal"))}}).on("open.fndtn.reveal",".reveal-modal",this.settings.open).on("opened.fndtn.reveal",".reveal-modal",this.settings.opened).on("opened.fndtn.reveal",".reveal-modal",this.open_video).on("close.fndtn.reveal",".reveal-modal",this.settings.close).on("closed.fndtn.reveal",".reveal-modal",this.settings.closed).on("closed.fndtn.reveal",".reveal-modal",this.close_video),e("body").bind("keyup.reveal",function(s){var i=e(".reveal-modal.open"),n=e.extend({},t.settings,t.data_options(i));27===s.which&&n.closeOnEsc&&i.foundation("reveal","close")}),!0},open:function(t,s){if(t)if("undefined"!=typeof t.selector)var i=e("#"+t.data("reveal-id"));else{var i=e(this.scope);s=t}else var i=e(this.scope);if(!i.hasClass("open")){var n=e(".reveal-modal.open");if("undefined"==typeof i.data("css-top")&&i.data("css-top",parseInt(i.css("top"),10)).data("offset",this.cache_offset(i)),i.trigger("open"),n.length<1&&this.toggle_bg(i),"undefined"!=typeof s&&s.url){var o=this,a="undefined"!=typeof s.success?s.success:null;e.extend(s,{success:function(t,s,l){e.isFunction(a)&&a(t,s,l),i.html(t),e(i).foundation("section","reflow"),o.hide(n,o.settings.css.close),o.show(i,o.settings.css.open)}}),e.ajax(s)}else this.hide(n,this.settings.css.close),this.show(i,this.settings.css.open)}},close:function(t){var t=t&&t.length?t:e(this.scope),s=e(".reveal-modal.open");s.length>0&&(this.locked=!0,t.trigger("close"),this.toggle_bg(t),this.hide(s,this.settings.css.close))},close_targets:function(){var e="."+this.settings.dismissModalClass;return this.settings.closeOnBackgroundClick?e+", ."+this.settings.bgClass:e},toggle_bg:function(){0===e(".reveal-modal-bg").length&&(this.settings.bg=e("<div />",{"class":this.settings.bgClass}).appendTo("body")),this.settings.bg.filter(":visible").length>0?this.hide(this.settings.bg):this.show(this.settings.bg)},show:function(s,i){if(i){if(/pop/i.test(this.settings.animation)){i.top=e(t).scrollTop()-s.data("offset")+"px";var n={top:e(t).scrollTop()+s.data("css-top")+"px",opacity:1};return this.delay(function(){return s.css(i).animate(n,this.settings.animationSpeed,"linear",function(){this.locked=!1,s.trigger("opened")}.bind(this)).addClass("open")}.bind(this),this.settings.animationSpeed/2)}if(/fade/i.test(this.settings.animation)){var n={opacity:1};return this.delay(function(){return s.css(i).animate(n,this.settings.animationSpeed,"linear",function(){this.locked=!1,s.trigger("opened")}.bind(this)).addClass("open")}.bind(this),this.settings.animationSpeed/2)}return s.css(i).show().css({opacity:1}).addClass("open").trigger("opened")}return/fade/i.test(this.settings.animation)?s.fadeIn(this.settings.animationSpeed/2):s.show()},hide:function(s,i){if(i){if(/pop/i.test(this.settings.animation)){var n={top:-e(t).scrollTop()-s.data("offset")+"px",opacity:0};return this.delay(function(){return s.animate(n,this.settings.animationSpeed,"linear",function(){this.locked=!1,s.css(i).trigger("closed")}.bind(this)).removeClass("open")}.bind(this),this.settings.animationSpeed/2)}if(/fade/i.test(this.settings.animation)){var n={opacity:0};return this.delay(function(){return s.animate(n,this.settings.animationSpeed,"linear",function(){this.locked=!1,s.css(i).trigger("closed")}.bind(this)).removeClass("open")}.bind(this),this.settings.animationSpeed/2)}return s.hide().css(i).removeClass("open").trigger("closed")}return/fade/i.test(this.settings.animation)?s.fadeOut(this.settings.animationSpeed/2):s.hide()},close_video:function(){var t=e(this).find(".flex-video"),s=t.find("iframe");s.length>0&&(s.attr("data-src",s[0].src),s.attr("src","about:blank"),t.hide())},open_video:function(){var t=e(this).find(".flex-video"),s=t.find("iframe");if(s.length>0){var n=s.attr("data-src");if("string"==typeof n)s[0].src=s.attr("data-src");else{var o=s[0].src;s[0].src=i,s[0].src=o}t.show()}},cache_offset:function(e){var t=e.show().height()+parseInt(e.css("top"),10);return e.hide(),t},off:function(){e(this.scope).off(".fndtn.reveal")},reflow:function(){}}}(Foundation.zj,this,this.document);