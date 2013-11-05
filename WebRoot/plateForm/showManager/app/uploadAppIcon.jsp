<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	
	<link type="text/css" rel="stylesheet" href="<%=path %>/css/content.css" />
  <link rel="stylesheet" type="text/css" href="<%=path %>/js/imgareaselect/css/imgareaselect-default.css" />
  <script type="text/javascript" src="<%=path%>/js/easyui/jquery-1.7.1.min.js"></script>
  <script type="text/javascript" src="<%=path %>/js/imgareaselect/scripts/jquery.imgareaselect.pack.js"></script>
  <script type="text/javascript" src="<%=path%>/js/easyui/jquery.easyui.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=path%>/js/easyui/themes/default/easyui.css"/>
<link rel='stylesheet' type='text/css' href='<%=path %>/js/imgareaselect/css/style.css'>
<script>
function preview(img, selection){
		    var scaleX = 100 / (selection.width || 1);
		    var scaleY = 100 / (selection.height || 1);
		
		    //动态小头像 获取当前选中框的宽度，高度，左边框，右边框
		    $('#view').css({                          //view是预览图像的id
		        width: Math.round(scaleX * 320) + 'px',
		        height: Math.round(scaleY * 220) + 'px',
		        marginLeft: '-' + Math.round(scaleX * selection.x1) + 'px',
		        marginTop: '-' + Math.round(scaleY * selection.y1) + 'px'
		    });
		    
		}
		
		//加载小头像
		$(document).ready(function () {
		    $('<div><img id="view"  style="position: relative;" /></div>').css({
		            float: 'left',
		            position: 'relative',
		            overflow: 'hidden',
		            width: '100px',
		            height: '100px'
		        }).insertAfter('#biuuu'); //把新建元素放到 #biuuu 之后
		     
		    //.insertAfter($('#biuuu')); //把新建元素放到 #biuuu 之后
		    $("input[type='file']").change(function(){
		        //document.form1.path.value=this.value;
		        previewImage(this);
		        //$("#image_area").find("img").attr({"src":this.value});
		    });
		  //  $("#upload_area").find("a").click(function(){
		   //     document.form1.image.click();
		 //   });
		//
		 //   $("#submit_button").find("a").click(function(){
		 //       $("form:first").submit();
		//    });
		    if(!+[1,]){
		       // $("#upload_area").find("a").hide();
		        $("#upload_area").find("input[type='text']").hide();
		        $("#image").css({
		            width: "240px",
		            height: "20px",
		            filter:"alpha(opacity=100)"
		        });
		    }
		});
		
		//初始化加载
		$(window).load(function () {
		    $('#biuuu').imgAreaSelect({
		        aspectRatio: '1:1',  //截取比例
		        show:true,
		        resizable:true, //是否可调整大小
		        autoHide: false,//选择框选择完毕是否自己取消
		        handles:true,
		        key:true, //是否启用键盘，默认为false
		        //x1: 75, y1: 30, x2: 225, y2: 180, //需要处理的区域，原始的
		        //x1:左上角x轴坐标 y1:左上角y轴坐标 x2:右下角x轴坐标 y2:右下角y轴坐标
		        keys: { arrows: 1, ctrl: 5, shift: 'resize' }, //调整像素大小
		
		        onInit: function(img, selection) {   }, //设置初始函数 画出选择框
		        onSelectChange: preview ,//选框移动时触发的事件
		        onSelectEnd: function(img, selection){
					$('input[name="x1"]').val(selection.x1);
	                $('input[name="y1"]').val(selection.y1);
	                $('input[name="x2"]').val(selection.x2);
	                $('input[name="y2"]').val(selection.y2);
				}  //选框结束时触发的事件
		
		    });
		});
		
		function previewImage(file)
		{
		    var porImg  = $('#biuuu'),
		        viewImg  = $('#view');
		    if (file["files"] && file["files"][0])
		    {
		        var reader = new FileReader();
		        reader.onload = function(evt){
		            porImg.attr({src : evt.target.result});
		            viewImg.attr({src : evt.target.result});
		        }
		        reader.readAsDataURL(file.files[0]);
		    }
		    else
		    {
		        var ieImageDom = document.createElement("div");
		        var proIeImageDom = document.createElement("div");
		        $(ieImageDom).css({
		            float: 'left',
		            position: 'relative',
		            overflow: 'hidden',
		            width: '100px',
		            height: '100px'
		        }).attr({"id":"view"});
		        $(proIeImageDom).attr({"id":"biuuu"});
		        porImg.parent().prepend(proIeImageDom);
		        porImg.remove();
		        viewImg.parent().append(ieImageDom);
		        viewImg.remove();
		        file.select();
		        path = document.selection.createRange().text;
		        $(ieImageDom).css({"filter": "progid:DXImageTransform.Microsoft.AlphaImageLoader(enabled='true',sizingMethod='scale',src=\"" + path + "\")"});
		        $(proIeImageDom).css({"filter": "progid:DXImageTransform.Microsoft.AlphaImageLoader(enabled='true',sizingMethod='scale',src=\"" + path + "\")"});
		    }
		}
		
		function _check(){
			var strSrc = $("#image").val();
			var pos = strSrc.lastIndexOf(".");
	       	var lastname = strSrc.substring(pos, strSrc.length);
	            if (lastname.toLowerCase() != ".jpg"&&lastname.toLowerCase() != ".png"&&lastname.toLowerCase() != ".gif"&&lastname.toLowerCase() != ".bmp") {
	                $.messager.alert("提示","您上传的文件类型为" + lastname + "，图片必须为 JPG、png、bmp、gif 类型","info");
	                return false;
	            }
		}
		
		
		
</script>
	
</head>
<body>
	<div class='main_content'>
			<div id="image_area">
			<span>预览</span>
				<img id="biuuu"  alt="" title="请选择App图标">
			</div>

			<div id ="upload_area">
				<form name = "form1" action ="<%=path %>/showManager/personalAction!loadAppIcon.dhtml?type=<%=request.getParameter("type") %>&id=<%=request.getParameter("id") %>" enctype = 'multipart/form-data'  method = 'POST' onsubmit="return _check();">
					<input type="file" id="image" name="image" value="上传照片"/>
					
					<input type='text' name="path" readonly>
					<input type="hidden" name="x1" value="" />
				    <input type="hidden" name="y1" value="" />
				    <input type="hidden" name="x2" value="" />
				    <input type="hidden" name="y2" value="" />
					<input type= "submit" value = "提交 "/>
				</form>	
			</div>
	</div>
			
</body>
