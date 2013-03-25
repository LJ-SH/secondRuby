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
$("#q_level1").live('change', function() {
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
}); 
/*$("#category_sel_category_type").live('change', function() {
  $(this).parents('form').submit();
}); 
$(document).ready(function(){
  if ($('#category_category_type').val() == "")
    $('#new_category_details').hide();
}); */

$("#category_category_type").live('change', function() {
  $.ajax({
    url: "/admin/categories/category_select",
    type: "get",
    data: {"category_type" : $(this).val()},
    dataType: "script",
    success: function(data){
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
/*$('#category_category_type').live('change', function(){
  if ($('#category_category_type').val() == "")
    $('#new_category_details').hide();
  else if ($('#category_category_type').val() == "CATEGORY_LEVEL1") {
    $('#new_category_details').show();
    //$('#category_level1_input').remove();
    
    //$('#category_level1_input > label').after('<input id="category_level1" maxlength="255" name="category[level1]" type="text" />');
    //$('#category_level2_input').attr('style', 'display: none');
    //$('#category_level3_input').attr('style', 'display: none');
    //$('#category_level4_input').attr('style', 'display: none');
    //$('#category_level2').val('00');    
    //$('#category_level3').val('00');
    //$('#category_level4').val('00');
  } else if ($('#category_category_type').val() == "CATEGORY_LEVEL2") {
    $('#new_category_details>ol>li:gt(2)').remove();
    level1_sel_li = '<li class="select input optional" id="category_level1_input"></li>';
    level1_sel_li.append('<label class=" label" for="category_level1">一级分类(2位数字)</label>');



  } 
  else
    $('#new_category_details').show();
}); */
