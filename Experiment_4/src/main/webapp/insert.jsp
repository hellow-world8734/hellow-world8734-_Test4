<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<title>新增用户</title>
<!-- 引入解析xlsx需要的库 -->
<script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.js"></script>
<script src="https://cdn.bootcss.com/xlsx/0.11.5/xlsx.core.min.js"></script>
</head>
<body>
	<%@include file="navList.jsp" %>
	<div class="error" style="color: ${color };">${error }<br/></div>
	<form id="insertShowForm" action="insertShow.jsp" method="post">
		请输入id： <input id="id" type="text" name="id"><br /> 请输入姓名： <input
			id="name" type="text" name="name"><br /> 请输入密码： <input type="text" id="password" 
			name="password"><br /> 使用excel批量添加： <input id="file-input"
			type="file"
			accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" /><br />
		<input id="btn" type="button" value="提交">
		<input id="xlsx-value" name="users" value="" style="display: none;" />
	</form>
	<div class="show-xlsx-data">
		
	</div>
	<script>
		const form = document.getElementById("insertShowForm");
		const valueInput = document.getElementById("xlsx-value");
		const btn = document.getElementById("btn");
		const fileInput = document.getElementById("file-input");
		let file = null;
		let originalType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
		
		let users = [];
		
		btn.addEventListener("click", async () => {
			if(file != null){
				// 通过excel添加
				if(users.length > 0){
					
					let id = document.getElementById("id");
					let name = document.getElementById("name");
					let password = document.getElementById("password");
					// 通过文件添加就不用输入的数据，直接将其清空
					id.value = "";
					name.value = "";
					password.value = "";
					
					let usersString = JSON.stringify(users);
					valueInput.value = usersString;
					console.log(usersString);
					form.submit();
				}
			}else{
				// 通过输入添加
				form.submit();
			}
		});
		
		// 给input标签绑定change事件，一上传选中的.xls文件就会触发该函数
	    $('#file-input').change(function(e) {
	        file = e.target.files[0];
	        if(file != null){
	        	var fileReader = new FileReader();
		        fileReader.onload = function(ev) {
		            try {
		                var data = ev.target.result
		                var workbook = XLSX.read(data, {
		                    type: 'binary'
		                }); // 以二进制流方式读取得到整份excel表格对象
		            } catch (err) {
		            	file = null;
			        	e.target.value = "";
			        	users = [];
			        	alert("仅支持XLSX格式的文件");
		                return;
		            };
		            // 表格的表格范围，可用于判断表头是否数量是否正确
		            var fromTo = '';
		            // 遍历每张表读取
		            for (var sheet in workbook.Sheets) {
		                if (workbook.Sheets.hasOwnProperty(sheet)) {
		                    fromTo = workbook.Sheets[sheet]['!ref'];
		                    users = users.concat(XLSX.utils.sheet_to_json(workbook.Sheets[sheet]));
		                    // break; // 如果只取第一张表，就取消注释这行
		                }
		            }
		        };
		        // 以二进制方式打开文件
		        fileReader.readAsBinaryString(file);
	        }else{
	        	file = null;
	        	e.target.value = "";
	        	users = [];
	        	return;
	        }
	       
	    });
	</script>
</body>
</html>
