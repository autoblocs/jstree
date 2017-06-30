var jstreeFun = function(){

    var jstreeOutput = new Shiny.OutputBinding();

    $.extend(jstreeOutput, {

        find: function(scope) {
            return $(scope).find('.shiny-jstree');
        },
        onValueError: function(el, err) {
            Shiny.unbindAll(el);
            this.renderError(el, err);
        },
        renderValue: function(el, data) {

            Shiny.unbindAll(el);

            var plugins = [];
            if ($(el).data('st-checkbox') === 'TRUE'){
              plugins.push('checkbox');
            }
            if ($(el).data('st-search') === 'TRUE'){
              plugins.push('search');
            }

            if(typeof($(el).jstree('is_loaded')) === 'object'){
                $(el).jstree({ 'core' : {
                    'data': [data] ,
                    'check_callback' : true
                },
                'plugins' : plugins });
            }else{
                $(el).jstree(true).settings.core.data = data;
                $(el).jstree(true).refresh();
            }

            Shiny.initializeInputs(el);
            Shiny.bindAll(el);
        }
    });

    Shiny.outputBindings.register(jstreeOutput, 'jstree.jstreeOutputBinding');

    var jstreeInput = new Shiny.InputBinding();

    $.extend(jstreeInput, {
        find: function(scope) {
          return $(scope).find(".shiny-jstree");
        },
        getType: function(){
          return "jstree";
        },
        getValue: function(el, keys) {
          /**
           * Prune an object recursively to only include the specified keys.
           * 'li_attr' is a special key that will actually map to 'li_attrs.class' and
           * will be called 'class' in the output.
           **/
          var prune = function(arr, keys){
            var arrToObj = function(ar){
              var obj = {};
              $.each(ar, function(i, el){
                obj['' + i] = el;
              });
              return obj;
            };

            var toReturn = [];
            // Ensure 'children' property is retained.
            keys.push('children');

            $.each(arr, function(i, obj){
              if (obj.children && obj.children.length > 0){
                obj.children = arrToObj(prune(obj.children, keys));
              }
              var clean = {};
              $.each(obj, function(key, val){
                if (keys.indexOf(key) >= 0){
                  if (key === 'li_attr'){ // We don't really want, just the class attr
                    if (!val.class){
                      // Skip without adding element.
                      return;
                    }
                    val = val.class;
                    key = 'class';
                  }

                  if (typeof val === 'string'){
                    // TODO: We don't really want to trim but have to b/c of Shiny's pretty-printing.
                    clean[key] = val.trim();
                  } else {
                    clean[key] = val;
                  }
                }
              });
              toReturn.push(clean);
            });
            return arrToObj(toReturn);
          };

          var tree = $.jstree.reference(el);
          if (tree){ // May not be loaded yet.
            var js = tree.get_json();
            var pruned =  prune(js, ['state', 'text', 'li_attr']);
            return pruned;
          }

        },
        setValue: function(el, value) {},
        subscribe: function(el, callback) {
          $(el).on("open_node.jstree", function(e) {
            callback();
          });

          $(el).on("close_node.jstree", function(e) {
            callback();
          });

          $(el).on("changed.jstree", function(e) {
            callback();
          });

          $(el).on("ready.jstree", function(e){
            callback();
          });
        },
        unsubscribe: function(el) {
          $(el).off(".jstree");
        }
    });

    Shiny.inputBindings.register(jstreeInput, 'jstree.jstreeInputBinding');

    var exports = {};

    exports.initSearch = function(treeId, searchId){
        $(function(){
          var to = false;
          $('#' + searchId).keyup(function () {
            if(to) { clearTimeout(to); }
            to = setTimeout(function () {
              var v = $('#' + searchId).val();
              $.jstree.reference('#' + treeId).search(v);
            }, 250);
          });
        });
      };

    return exports;
}();
