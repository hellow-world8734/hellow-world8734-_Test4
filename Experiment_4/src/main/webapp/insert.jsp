<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<title>�����û�</title>
<!-- �������xlsx��Ҫ�Ŀ� -->
<script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.js"></script>
<script src="https://cdn.bootcss.com/xlsx/0.11.5/xlsx.core.min.js"></script>
</head>
<body>
	<%@include file="navList.jsp" %>
	<div class="error" style="color: ${color };">${error }<br/></div>
	<form id="insertShowForm" action="insertShow.jsp" method="post">
		������id�� <input id="id" type="text" name="id"><br /> ������������ <input
			id="name" type="text" name="name"><br /> ���������룺 <input type="text" id="password" 
			name="password"><br /> ʹ��excel������ӣ� <input id="file-input"
			type="file"
			accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" /><br />
		<input id="btn" type="button" value="�ύ">
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
				// ͨ��excel���
				if(users.length > 0){
					
					let id = document.getElementById("id");
					let name = document.getElementById("name");
					let password = document.getElementById("password");
					// ͨ���ļ���ӾͲ�����������ݣ�ֱ�ӽ������
					id.value = "";
					name.value = "";
					password.value = "";
					
					let usersString = JSON.stringify(users);
					valueInput.value = usersString;
					console.log(usersString);
					form.submit();
				}
			}else{
				// ͨ���������
				form.submit();
			}
		});
		
		// ��input��ǩ��change�¼���һ�ϴ�ѡ�е�.xls�ļ��ͻᴥ���ú���
	    $('#file-input').change(function(e) {
	        file = e.target.files[0];
	        if(file != null){
	        	var fileReader = new FileReader();
		        fileReader.onload = function(ev) {
		            try {
		                var data = ev.target.result
		                var workbook = XLSX.read(data, {
		                    type: 'binary'
		                }); // �Զ���������ʽ��ȡ�õ�����excel������
		            } catch (err) {
		            	file = null;
			        	e.target.value = "";
			        	users = [];
			        	alert("��֧��XLSX��ʽ���ļ�");
		                return;
		            };
		            // ���ı��Χ���������жϱ�ͷ�Ƿ������Ƿ���ȷ
		            var fromTo = '';
		            // ����ÿ�ű��ȡ
		            for (var sheet in workbook.Sheets) {
		                if (workbook.Sheets.hasOwnProperty(sheet)) {
		                    fromTo = workbook.Sheets[sheet]['!ref'];
		                    users = users.concat(XLSX.utils.sheet_to_json(workbook.Sheets[sheet]));
		                    // break; // ���ֻȡ��һ�ű���ȡ��ע������
		                }
		            }
		        };
		        // �Զ����Ʒ�ʽ���ļ�
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
