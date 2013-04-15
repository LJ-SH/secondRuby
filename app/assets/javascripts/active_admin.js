//= require active_admin/base
//=require jquery.ui.all
//=require jquery-ui-timepicker-addon
$(document).ready(function() {
  jQuery('input.hasDatetimePicker').datetimepicker({
    dateFormat: "dd/mm/yy",
    beforeShow: function () {
      setTimeout(
        function () {
          $('#ui-datepicker-div').css("z-index", "3000");
        }, 100
      );
    }
  });
});


/*$("#q_level1").live('change', function() {
  $.ajax({
    url: "categories/level2_collection",
    type: "GET",
    data: "level1=" + $(this).val(),
    dataType: "json",
    success: function(data){
      var level2 = $("#q_level2");
      level2.empty();
      level2.append("<option value=''>任何</option>");
      $.each(data, function(index, value) {
        // append an option
        var opt = $('<option/>');
        // value is an array: [:id, :name]
        opt.attr('value', value[0]);
        // set text
        opt.text(value[1]);
        // append to select
        opt.appendTo(level2);
      });      
    }
  })
}); 
$("#q_level2").live('change', function() {
  $.ajax({
    url: "categories/level3_collection",
    type: "GET",
    data: "level1=" + $("#q_level1").val()+"&level2=" + $(this).val(),
    dataType: "json",
    success: function(data){
      var level3 = $("#q_level3");
      level3.empty();
      level3.append("<option value=''>任何</option>");
      $.each(data, function(index, value) {
        // append an option
        var opt = $('<option/>');
        // value is an array: [:id, :name]
        opt.attr('value', value[0]);
        // set text
        opt.text(value[1]);
        // append to select
        opt.appendTo(level3);
      });      
    }
  })
}); */

$("#category_category_type").live('change', function() {
  $.ajax({
    url: "/admin/categories/category_select",
    type: "get",
    data: {"category_type" : $(this).val()},
    //dataType: "script",
    dataType: "html",
    success: function(data){
      $("#active_admin_content").empty();
      $("#active_admin_content").append(data);
    }
  })
});
$("#category_level1").live('change', function() {
  $.ajax({
    url: "/admin/categories/level2_collection",
    type: "GET",
    data: "level1=" + $(this).val(),
    dataType: "json",
    success: function(data){
      var level2 = $("#category_level2");
      level2.empty();
      level2.append("<option value=''></option>");       
      $.each(data, function(index, value) {
        // append an option
        var opt = $('<option/>');
        // value is an array: [:id, :name]
        opt.attr('value', value[0]);
        // set text
        opt.text(value[1]);
        // append to select
        opt.appendTo(level2);
      });      
    }
  })
}); 
$("#category_level2").live('change', function() {
  $.ajax({
    url: "/admin/categories/level3_collection",
    type: "GET",
    data: "level1=" + $("#category_level1").val()+"&level2=" + $(this).val(),
    dataType: "json",
    success: function(data){
      var level3 = $("#category_level3");
      level3.empty();
      level3.append("<option value=''></option>");      
      $.each(data, function(index, value) {
        // append an option
        var opt = $('<option/>');
        // value is an array: [:id, :name]
        opt.attr('value', value[0]);
        // set text
        opt.text(value[1]);
        // append to select
        opt.appendTo(level3);
      });      
    }
  })
});

//$("#q_level0").live('change', function() {
$("#q_level0_eq").live('change', function() {  
  $.ajax({
    url: "/admin/component_categories/level1_collection",
    type: "GET",
    data: "level0=" + $(this).val(),
    dataType: "json",
    success: function(data){
      var level1 = $("#q_level1_eq");
      level1.empty();
      level1.append("<option value=''>任何</option>");
      $.each(data, function(index, value) {
        // append an option
        var opt = $('<option/>');
        // value is an array: [:id, :name]
        opt.attr('value', value[0]);
        // set text
        opt.text(value[1]);
        // append to select
        opt.appendTo(level1);
      });      
      var level2 = $("#q_level2_eq");
      level2.empty();
      level2.append("<option value=''>任何</option>");
    }
  })
});
//$("#q_level1").live('change', function() {
$("#q_level1_eq").live('change', function() {  
  $.ajax({
    url: "/admin/component_categories/level2_collection",
    type: "GET",
    data: "level1=" + $(this).val(),
    dataType: "json",
    success: function(data){
      var level2 = $("#q_level2_eq");
      level2.empty();
      level2.append("<option value=''>任何</option>");
      $.each(data, function(index, value) {
        // append an option
        var opt = $('<option/>');
        // value is an array: [:id, :name]
        opt.attr('value', value[0]);
        // set text
        opt.text(value[1]);
        // append to select
        opt.appendTo(level2);
      });      
    }
  })
});
$("#q_search").live('submit', function() {
  var subtree = $("#q_subtree_eq");
  if (subtree.length>0) {
    var ancestry_val="";
    var level0 = $("#q_level0_eq");
    var level1 = $("#q_level1_eq");
    var level2 = $("#q_level2_eq");
    if (level2.val() == "") {
      if (level1.val() == "") {
        if (level0.val() != "") {
          ancestry_val = level0.val();
        }
      } else {
        ancestry_val = level1.val();
      }
    } else {
      ancestry_val = level2.val();
    }
    subtree.val(ancestry_val);
    level0.attr("disabled", true);
    level1.attr("disabled", true);
    level2.attr("disabled", true);
  }
});

$("#component_category_ancestry_depth").live('change', function() {
  $.ajax({
    url: "/admin/component_categories/category_select",
    type: "get",
    data: {"category_type" : $(this).val()},
    //dataType: "script",
    dataType: "html",
    success: function(data){
      $("#active_admin_content").empty();
      $("#active_admin_content").append(data);
    }
  })
});
$("#component_category_level0").live('change', function() {
  $.ajax({
    url: "/admin/component_categories/level1_collection",
    type: "GET",
    data: "level0=" + $(this).val(),
    dataType: "json",
    success: function(data){
      var level1 = $("#component_category_level1");
      level1.empty();
      level1.append("<option value=''></option>");       
      $.each(data, function(index, value) {
        // append an option
        var opt = $('<option/>');
        // value is an array: [:id, :name]
        opt.attr('value', value[0]);
        // set text
        opt.text(value[1]);
        // append to select
        opt.appendTo(level1);
      });    
      var level2 = $("#component_category_level2");
      level2.empty();
      level2.append("<option value=''>请选择分类类型</option>");        
    }
  })
}); 
$("#component_category_level1").live('change', function() {
  $.ajax({
    url: "/admin/component_categories/level2_collection",
    type: "GET",
    data: "level1=" + $(this).val(),
    dataType: "json",
    success: function(data){
      var level2 = $("#component_category_level2");
      level2.empty();
      level2.append("<option value=''></option>");       
      $.each(data, function(index, value) {
        // append an option
        var opt = $('<option/>');
        // value is an array: [:id, :name]
        opt.attr('value', value[0]);
        // set text
        opt.text(value[1]);
        // append to category_select
        opt.appendTo(level2);
      });      
    }
  })
});
$("#new_component_category").live('submit', function() {
    var form = $(this);
    var depth = form.find("#component_category_ancestry_depth").val();
    var ancestry_input = form.find("#component_category_ancestry");
    var ancestry_value;
    var errMsg = "请选择正确的值";

    if (depth == 0) {
      //ancestor is nil 
      ancestry_input.parent('li').remove();
      return;
    }

    if (depth == 1) {
      var level0_element = $("#component_category_level0");
      if (!fn_integer_id_validate(level0_element.val())) {  
        if($("#new_category_level0_err_tip").length == 0) {
          var errTip = $('<p class="inline-errors" id="new_category_level0_err_tip"></p>').html(errMsg);
          level0_element.after(errTip);          
        }
        //event.preventDefault();
        return false;
      } else {
        ancestry_input.val(level0_element.val());
        return true;
      }
    }

    if (depth == 2) {
      var level0_element = $("#component_category_level0");
      var level1_element = $("#component_category_level1");
      if (!fn_integer_id_validate(level0_element.val())) {
        if($("#new_category_level0_err_tip").length == 0) {
          var errTip = $('<p class="inline-errors" id="new_category_level0_err_tip"></p>').html(errMsg);
          level0_element.after(errTip);          
        } 
        return false;
      }
      if (!fn_integer_id_validate(level1_element.val())) {
        if($("#new_category_level1_err_tip").length == 0) {
          var errTip = $('<p class="inline-errors" id="new_category_level1_err_tip"></p>').html(errMsg);
          level1_element.after(errTip);          
        } 
        return false;
      }  
      //value have been verified already
      ancestry_input.val(level0_element.val()+"/"+level1_element.val());
      return;
    }

    if (depth == 3) {
      var level0_element = $("#component_category_level0");
      var level1_element = $("#component_category_level1");
      var level2_element = $("#component_category_level2");
      if (!fn_integer_id_validate(level0_element.val())) {
        if($("#new_category_level0_err_tip").length == 0) {
          var errTip = $('<p class="inline-errors" id="new_category_level0_err_tip"></p>').html(errMsg);
          level0_element.after(errTip);          
        } 
        return false;
      }
      if (!fn_integer_id_validate(level1_element.val())) {
        if($("#new_category_level1_err_tip").length == 0) {
          var errTip = $('<p class="inline-errors" id="new_category_level1_err_tip"></p>').html(errMsg);
          level1_element.after(errTip);          
        } 
        return false;
      }
      if (!fn_integer_id_validate(level2_element.val())) {
        if($("#new_category_level2_err_tip").length == 0) {
          var errTip = $('<p class="inline-errors" id="new_category_level2_err_tip"></p>').html(errMsg);
          level2_element.after(errTip);          
        } 
        return false;
      }        
      //value have been verified already
      ancestry_input.val(level0_element.val()+"/"+level1_element.val()+"/"+level2_element.val());
      return;
    }
});

function fn_integer_id_validate(value) {
  var regExp = new RegExp(/^\d{1,3}$/);
  return regExp.test(value);
}