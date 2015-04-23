<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>A Generic Workflow Submitter on Apache YARN</title>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script src="https://code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
</head>
<body>
<input type="button" value="Create a job" id="createJob">
<input type="hidden" value="" id="jobNames">
<form action="#" method="POST">
<div id="WorkflowArea">
</div>
</form>
<div id="dialog-form-jobName">
    <form>
        <label for="name">Enter a job name</label>
        <input type="text" id="jobName" value=""/>
    </form>
</div>
</body>
<script>
	//Script to execute when create a job button has pressed
	var jobName;
	$("#createJob").click(function(){
		
		$("#dialog-form-jobName").dialog("open");
	});
	$("#jobType").on("change",function(){
		var JOBTYPE=$("#jobType :selected").val();
		var content="";
		var currentDiv=this.id;
		currentDiv.empty();
		if(JOBTYPE=="JavaClass")
		{
			content='<div id="'+currentDiv+'"> <br/> <b>Job Name:</b>'+currentDiv+'<br/><b>Job Type:</b><select id="jobType"><option value="JavaClass" selected="selected">Java Class</option><option value="MahoutClusterInputConversion">Mahout Cluster Input Conversion</option><option value="MahoutKMeansCluster">Mahout KMeans Cluster</option></select><br/><b>Java Class Name:</b><input type="Text" value="" name="'+currentDiv+'className"/><br/><b>Arguments:</b><input type="Text" value="" name="'+currentDiv+'arguments"/><br/><b>Predecessors:</b><input type="Text" value="" name="'+currentDiv+'predecessors"/></div>';
		}
		else if(JOBTYPE=="MahoutClusterInputConversion")
		{
			content='<div id="'+currentDiv+'"> <br/> <b>Job Name:</b>'+currentDiv+'<br/><b>Job Type:</b><select id="jobType"><option value="JavaClass" >Java Class</option><option value="MahoutClusterInputConversion" selected="selected">Mahout Cluster Input Conversion</option><option value="MahoutKMeansCluster">Mahout KMeans Cluster</option></select><br/><b>Input:</b><input type="Text" value="" name="'+currentDiv+'input"/><br/><b>Output:</b><input type="Text" value="" name="'+currentDiv+'output"/><br/><b>Vector Class:</b><input type="Text" value="" name="'+currentDiv+'vectorClass"/><br/><b>Predecessors:</b><input type="Text" value="" name="'+currentDiv+'predecessors"/></div>';
		}
		else if(JOBTYPE=="MahoutKMeansCluster")
		{
			content='<div id="'+currentDiv+'"> <br/> <b>Job Name:</b>'+currentDiv+'<br/><b>Job Type:</b><select id="jobType"><option value="JavaClass" >Java Class</option><option value="MahoutClusterInputConversion" >Mahout Cluster Input Conversion</option><option value="MahoutKMeansCluster" selected="selected">Mahout KMeans Cluster</option></select><br/><b>Input:</b><input type="Text" value="" name="'+currentDiv+'input"/><br/><b>Output:</b><input type="Text" value="" name="'+currentDiv+'output"/><br/><b>Distance Measure:</b><input type="Text" value="" name="'+currentDiv+'distanceMeasure"/><br/><b>K Points:</b><input type="Text" value="" name="'+currentDiv+'kPoints"/><br/><b>Iterations:</b><input type="Text" value="" name="'+currentDiv+'iterations"/><br/><b>Cluster Path:</b><input type="Text" value="" name="'+currentDiv+'clusterPath"/><br/><b>Predecessors:</b><input type="Text" value="" name="'+currentDiv+'predecessors"/></div>';
		}
		$(content).appendTo("#"+currentDiv);
	});
	$(function(){
	    $("#dialog-form-jobName").dialog({
	        autoOpen: false,
	        modal: true,
	        buttons: {
	            "Ok": function() {
	            	var jobNamesString=$("#jobNames").val();
	        		var jobNames=jobNamesString.split(",");
	        		jobName=$.trim($("#jobName").val());
	        		$("#jobName").val("");
	        		if(jobName != ""){
	        		    	jobNames[jobNames.length]=jobName;
	        		    	$("#jobNames").val(jobNames);
	        		    	var content='<div id="'+jobName+'"> <br/> <b>Job Name:</b>'+jobName+'<br/><b>Job Type:</b><select id="jobType"><option value="JavaClass" selected="selected">Java Class</option><option value="MahoutClusterInputConversion">Mahout Cluster Input Conversion</option><option value="MahoutKMeansCluster">Mahout KMeans Cluster</option></select><br/><b>Java Class Name:</b><input type="Text" value="" name="'+jobName+'className"/><br/><b>Arguments:</b><input type="Text" value="" name="'+jobName+'arguments"/><br/><b>Predecessors:</b><input type="Text" value="" name="'+jobName+'predecessors"/></div>';
	        				$(content).appendTo("#WorkflowArea");
	        		    }
	        		    else
	        		    {
	        		    	alert("Enter a job name");
	        		    }
	                $(this).dialog("close");
	            },
	            "Cancel": function() {
	                $(this).dialog("close");
	            }
	        }
	    });
	});
</script>
</html>