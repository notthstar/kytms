// JavaScript Document
$(document).ready(function(){
	
	$("#add").click(function(){
        $("#select2").append($("#select1 option:selected").clone())
		});
		
	$("#add_all").click(function(){
		
		$("#select1 option").appendTo("#select2");
		
		});
		
	$("#remove").click(function(){
		
		$("#select2 option:selected").appendTo("#select1");
		
		});	
		
	$("#remove_all").click(function(){
		
		$("#select2 option").appendTo("#select1");
		
		});	
		
		$("#select1").dblclick(function(){
			
		$("#select1 option:selected").appendTo("#select2");	
			
			});
		
				$("#select2").dblclick(function(){
			
		$("#select2 option:selected").appendTo("#select1");	
			
			});
		

	});