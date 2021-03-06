//设置代码发布目录，源代码存放地址，部署目录，
$(function(){
    $("#project_name").on("input",function(e){
    	$("#project_dir").attr("value",'/var/lib/opsmanage/workspaces/release/'+e.delegateTarget.value+'/');
    	$("#project_repo_dir").attr("value",'/var/lib/opsmanage/workspaces/source/'+e.delegateTarget.value+'/');
    	$("#project_target_root").attr("value",'/var/www/'+e.delegateTarget.value+'/');
    });
    
});

function requests(method,url,data){
	var ret = '';
	$.ajax({
		async:false,
		url:url, //请求地址
		type:method,  //提交类似
       	success:function(response){
             ret = response;
        },
        error:function(data){
            ret = {};
        }
	});	
	return 	ret
}

// 代码类型选择
function setAceEditMode(ids,model,theme) {
	try
	  {
		var editor = ace.edit(ids);
		require("ace/ext/old_ie");
		var langTools = ace.require("ace/ext/language_tools");
		editor.removeLines();
		editor.setTheme(theme);
		editor.getSession().setMode(model);
		editor.setShowPrintMargin(false);
		editor.setOptions({
		    enableBasicAutocompletion: true,
		    enableSnippets: true,
		    enableLiveAutocompletion: true
		}); 
	 	return editor
	  }
	catch(err)
	  {
		console.log(err)
	  }

			 
}

//目标服务器选择
function oBtBusinessSelect(){
	//移除被选元素的所有子节点和内容
	   $("#server").empty();
	   var obj = document.getElementById("project_business"); 
	   var index = obj.selectedIndex;
	   var businessId = obj.options[index].value; 
	   if ( businessId > 0){	 
			$.ajax({
				dataType: "JSON",
				url:'/api/assets_list/?id='+ businessId, //请求地址
				type:"GET",  //提交类似
				success:function(response){
					var binlogHtml = '<select class="selectpicker" name="server" id="server" required><option  name="ipvs_assets" value=""><a>请选择服务器</a></option>'
					var selectHtml = '';
					for (var i=0; i <response.length; i++){
						 selectHtml += '<option name="server" value="'+ response[i]["id"] +'">' + response[i]["ip"] + '</option>'
					}
					binlogHtml =  binlogHtml + selectHtml + '</select>';
					$("#server").html(binlogHtml)
					$('.selectpicker').selectpicker('refresh');							
				},
			});	
	   }   
}

$(document).ready(function() {
	//业务线选择
	if ($("#project_business").length){
		$.ajax({
			async : true,  
			url:'/api/apps_list/', //请求地址
			type:"GET",  //提交类型
			success:function(response){
				var binlogHtml = '<select required="required" class="selectpicker form-control" data-live-search="true"  data-size="10" data-width="100%" name="project_business"  id="project_business" autocomplete="off" onchange="javascript:oBtBusinessSelect();"><option selected="selected" value="">请选择一个进行操作</option>'
				var selectHtml = '';
				for (var i=0; i <response.length; i++){
					selectHtml += '<option value="'+ response[i]["id"] +'">'+ response[i]["name"] +'</option>'
				}
				binlogHtml =  binlogHtml + selectHtml + '</select>';
				$("#project_business").html(binlogHtml)
				$("#project_business").selectpicker('refresh');							
			}					
		});			
	}
	 // 远程仓库选择
	 $("#project_repertory").change(function(){
		   var project_model = '<select class="form-control" id="project_model" name="project_model" required>' +
								'<option selected="selected" value="">选择上线版本控制类型</option>' +
								'<option value="tag" name="project_model">Tag</option>'
		   var obj = document.getElementById("project_repertory"); 
		   var index = obj.selectedIndex;
		   var value = obj.options[index].value; 
		   if (value=="svn"){
			   $("#repo_type").show();  
			   $("#project_model").html(project_model + '<option value="trunk" name="project_model">Trunk</option></select>')
		   }
		   else {
			   $("#repo_type").hide();
			   $("#project_model").html(project_model + '<option value="branch" name="project_model">Branch</option>')
		   }
	});	 
	// 编译命令
	var compile_type = 'noncompile';
	if ($("#project_local_command").length){
		var aceEditAdd = setAceEditMode("project_local_command","ace/mode/sh","ace/theme/terminal");
	}
	try
		{
			$("button[name='compile_type']").click(function(){
				compile_type = $(this).val()
				if (compile_type=='compile'){
					$("#compile").show()
				}
				else{
					$("#compile").hide()
				}
			});			  
		}
	catch(err)
		{
			console.log(err)
		}	
	//提交配置到数据库
    $('#btn_add_project').click(function(){
    	 	swal({
                title: '确认提交数据吗？',
                text: '提交后无法撤回',
                type: "warning",
                showCancelButton: true,
                confirmButtonColor: "#DD6B55",
                confirmButtonText: '确认',
                cancelButtonText:'取消',
                closeOnConfirm: false
            },function () {
				var btnObj = $(this);
				btnObj.attr('disabled', true);
				var required = ["project_business", "project_name", "project_env", "project_repertory", "project_address", "server", "project_user", "dir", "project_model"];
				btnObj.attr('disabled', true);
				var form = document.getElementById('add_deploy_project');
				for (var i = 0; i < form.length; ++i) {
					var name = form[i].name;
					var value = form[i].value;
					idx = $.inArray(name, required);
					if (idx >= 0 && value.length == 0) {
						swal('Warning', 'Warning' + "[ 请注意必填项不能为空~ ]" + 'Error', "error");
						btnObj.removeAttr('disabled');
						return false;
					}
				}
				var formData = new FormData();
				var serverList = new Array();
				$("#server option:selected").each(function () {
					serverList.push($(this).val())
				})
				formData.append('type', 'create');
				formData.append('project_env', $('#project_env').val());
				formData.append('project_name', $('#project_name').val());
				formData.append('project_address', $('#project_address').val());
				formData.append('project_user', $('#project_user').val());
				formData.append('project_target_root', $('#project_target_root').val());
				formData.append('project_pre_remote_command', $('#project_pre_remote_command').val());
				formData.append('project_remote_command', $('#project_remote_command').val());
				formData.append('project_exclude', $('#project_exclude').val());
				formData.append('project_dir', $('#project_dir').val());
				formData.append('project_logpath', $('#project_logpath').val());
				formData.append('project_repo_dir', $('#project_repo_dir').val());
				formData.append('project_repo_user', $('#project_repo_user').val());
				formData.append('project_repo_passwd', $('#project_repo_passwd').val());
				formData.append('project_is_include', $('#project_is_include  option:selected').val());
				formData.append('project_business', $('#project_business option:selected').val());
				formData.append('project_repertory', $('#project_repertory option:selected').val());
				formData.append('project_model', $('#project_model option:selected').val());
				formData.append('project_servers', serverList);
				formData.append('project_local_command', aceEditAdd.getSession().getValue());
				formData.append('project_type', compile_type);
				$.ajax({
					url: '/cicd/config/', //请求地址
					type: "POST",  //提交类似
					processData: false,
					contentType: false,
					data: formData,  //提交参数
					success: function (response) {
						btnObj.removeAttr('disabled');
						if (response["code"] == 200) {
							swal({title: 'Create', text:  'Create Successfully', type: "success"}, function () {
                                window.location.href='/cicd/list/';
                            })
						} else {
							swal('Delete Error', 'Delete Error' + "[ " + response["msg"] + " ]" + 'Error', "error");
						}
					},
					error: function (response) {
						btnObj.removeAttr('disabled');
						swal('Delete Error', 'Delete Error' + "[ " + response.responseText + " ]" + 'Error', "error");
					}
				});
			})
    })
 })
