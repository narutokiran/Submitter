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
<form id="workflowForm" action="generateXml.jsp" method="POST">
<input type="hidden" value="" name="jobNames" id="jobNames">
<input type="button" value="Create a job" id="createJob">
<input type="button" value="submit" id="submitWorkflow">
XML path: <input type="text" value"" name="XMLPath">
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
	$('#submitWorkflow').click(function(){
		$('#workflowForm').submit();
	});
	$("#createJob").click(function(){
		
		$("#dialog-form-jobName").dialog("open");
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
	        				if(jobNamesString!="")
	        		    	jobNames[jobNames.length]=jobName;
	        		    	else
	        		    	jobNames[0]=jobName;
	        		    	$("#jobNames").val(jobNames);
	        		    	var content='<div name="'+jobName+'" id="'+jobName+'"> <br/> <b>Job Name:</b>'+jobName+'<br/><b>Job Type:</b><select class="jobType" name="'+jobName+'_jobType" id="'+jobName+'jobType"><option value="JavaClass" selected="selected">Java Class</option><option value="MahoutClusterInputConversion">Mahout Cluster Input Conversion</option><option value="MahoutKMeansCluster">Mahout KMeans Cluster</option><option value="MahoutSeqDumper">Mahout Sequence Dumper</option><option value="MahoutRandomForestDescribe">Mahout Random Forest Describe</option><option value="MahoutBuildForest">Mahout Build Forest</option><option value="MahoutTestForest">Mahout Test Forest</option><option value="HadoopMR">Map Reduce Hadoop</option></select><br/><b>Java Class Name:</b><input type="Text" value="" name="'+jobName+'_className"/><br/><b>Arguments:</b><input type="Text" value="" name="'+jobName+'_arguments"/><br/><b>Predecessors:</b><input type="Text" value="" name="'+jobName+'_predecessors"/></div>';
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
$(document).on("change",".jobType",function(){
		var JOBTYPE=$("#"+this.id+" :selected").val();
		var content="";
		var currentDiv=$("#"+this.id).closest("div").attr("id");
		$("#"+currentDiv).empty();
		if(JOBTYPE=="JavaClass")
		{
			content='<div name="'+currentDiv+'" id="'+currentDiv+'"> <br/> <b>Job Name:</b>'+currentDiv+'<br/><b>Job Type:</b><select class="jobType" name="'+currentDiv+'_jobType" id="'+currentDiv+'jobType"><option value="JavaClass" selected="selected">Java Class</option><option value="MahoutClusterInputConversion">Mahout Cluster Input Conversion</option><option value="MahoutKMeansCluster">Mahout KMeans Cluster</option><option value="MahoutSeqDumper">Mahout Sequence Dumper</option><option value="MahoutRandomForestDescribe">Mahout Random Forest Describe</option><option value="MahoutBuildForest">Mahout Build Forest</option><option value="MahoutTestForest">Mahout Test Forest</option><option value="HadoopMR">Map Reduce Hadoop</option></select><br/><b>Java Class Name:</b><input type="Text" value="" name="'+currentDiv+'_className"/><br/><b>Arguments:</b><input type="Text" value="" name="'+currentDiv+'_arguments"/><br/><b>Predecessors:</b><input type="Text" value="" name="'+currentDiv+'_predecessors"/></div>';
		}
		else if(JOBTYPE=="MahoutClusterInputConversion")
		{
			content='<div id="'+currentDiv+'"> <br/> <b>Job Name:</b>'+currentDiv+'<br/><b>Job Type:</b><select class="jobType" name="'+currentDiv+'_jobType" id="'+currentDiv+'jobType"><option value="JavaClass" >Java Class</option><option value="MahoutClusterInputConversion" selected="selected">Mahout Cluster Input Conversion</option><option value="MahoutKMeansCluster">Mahout KMeans Cluster</option><option value="MahoutSeqDumper">Mahout Sequence Dumper</option><option value="MahoutRandomForestDescribe">Mahout Random Forest Describe</option><option value="MahoutBuildForest">Mahout Build Forest</option><option value="MahoutTestForest">Mahout Test Forest</option><option value="HadoopMR">Map Reduce Hadoop</option></select><br/><b>Input:</b><input type="Text" value="" name="'+currentDiv+'_input"/><br/><b>Output:</b><input type="Text" value="" name="'+currentDiv+'_output"/><br/><b>Vector Class:</b><input type="Text" value="" name="'+currentDiv+'_vectorClass"/><br/><b>Predecessors:</b><input type="Text" value="" name="'+currentDiv+'_predecessors"/></div>';
		}
		else if(JOBTYPE=="MahoutKMeansCluster")
		{
			content='<div id="'+currentDiv+'"> <br/> <b>Job Name:</b>'+currentDiv+'<br/><b>Job Type:</b><select class="jobType" name="'+currentDiv+'_jobType" id="'+currentDiv+'jobType"><option value="JavaClass" >Java Class</option><option value="MahoutClusterInputConversion" >Mahout Cluster Input Conversion</option><option value="MahoutKMeansCluster" selected="selected">Mahout KMeans Cluster</option><option value="MahoutSeqDumper">Mahout Sequence Dumper</option><option value="MahoutRandomForestDescribe">Mahout Random Forest Describe</option><option value="MahoutBuildForest">Mahout Build Forest</option><option value="MahoutTestForest">Mahout Test Forest</option><option value="HadoopMR">Map Reduce Hadoop</option></select><br/><b>Input:</b><input type="Text" value="" name="'+currentDiv+'_input"/><br/><b>Output:</b><input type="Text" value="" name="'+currentDiv+'_output"/><br/><b>Distance Measure:</b><input type="Text" value="" name="'+currentDiv+'_distanceMeasure"/><br/><b>K Points:</b><input type="Text" value="" name="'+currentDiv+'_kPoints"/><br/><b>Iterations:</b><input type="Text" value="" name="'+currentDiv+'_iterations"/><br/><b>Cluster Path:</b><input type="Text" value="" name="'+currentDiv+'_clusterPath"/><br/><b>Predecessors:</b><input type="Text" value="" name="'+currentDiv+'_predecessors"/></div>';
		}
		else if(JOBTYPE=="MahoutSeqDumper")
		{
			content='<div id="'+currentDiv+'"> <br/> <b>Job Name:</b>'+currentDiv+'<br/><b>Job Type:</b><select class="jobType" name="'+currentDiv+'_jobType" id="'+currentDiv+'jobType"><option value="JavaClass" >Java Class</option><option value="MahoutClusterInputConversion" >Mahout Cluster Input Conversion</option><option value="MahoutKMeansCluster" >Mahout KMeans Cluster</option><option value="MahoutSeqDumper" selected="selected">Mahout Sequence Dumper</option><option value="MahoutRandomForestDescribe">Mahout Random Forest Describe</option><option value="MahoutBuildForest">Mahout Build Forest</option><option value="MahoutTestForest">Mahout Test Forest</option><option value="HadoopMR">Map Reduce Hadoop</option></select><br/><b>Input:</b><input type="Text" value="" name="'+currentDiv+'_input"/><br/><b>Output:</b><input type="Text" value="" name="'+currentDiv+'_output"/><br/><b>Predecessors:</b><input type="Text" value="" name="'+currentDiv+'_predecessors"/></div>';
		}
		else if(JOBTYPE=="MahoutRandomForestDescribe")
		{
			content='<div id="'+currentDiv+'"> <br/> <b>Job Name:</b>'+currentDiv+'<br/><b>Job Type:</b><select class="jobType" name="'+currentDiv+'_jobType" id="'+currentDiv+'jobType"><option value="JavaClass" >Java Class</option><option value="MahoutClusterInputConversion" >Mahout Cluster Input Conversion</option><option value="MahoutKMeansCluster" >Mahout KMeans Cluster</option><option value="MahoutSeqDumper">Mahout Sequence Dumper</option><option value="MahoutRandomForestDescribe" selected="selected">Mahout Random Forest Describe</option><option value="MahoutBuildForest">Mahout Build Forest</option><option value="MahoutTestForest">Mahout Test Forest</option><option value="HadoopMR">Map Reduce Hadoop</option></select><br/><b>Input:</b><input type="Text" value="" name="'+currentDiv+'_input"/><br/><b>Output:</b><input type="Text" value="" name="'+currentDiv+'_output"/><br/><b>Describe:</b><input type="Text" value="" name="'+currentDiv+'_describe"/><br/><b>Predecessors:</b><input type="Text" value="" name="'+currentDiv+'_predecessors"/></div>';
		}
		else if(JOBTYPE=="MahoutBuildForest")
		{
			content='<div id="'+currentDiv+'"> <br/> <b>Job Name:</b>'+currentDiv+'<br/><b>Job Type:</b><select class="jobType" name="'+currentDiv+'_jobType" id="'+currentDiv+'jobType"><option value="JavaClass" >Java Class</option><option value="MahoutClusterInputConversion" >Mahout Cluster Input Conversion</option><option value="MahoutKMeansCluster" >Mahout KMeans Cluster</option><option value="MahoutSeqDumper">Mahout Sequence Dumper</option><option value="MahoutRandomForestDescribe">Mahout Random Forest Describe</option><option value="MahoutBuildForest" selected="selected">Mahout Build Forest</option><option value="MahoutTestForest">Mahout Test Forest</option><option value="HadoopMR">Map Reduce Hadoop</option></select><br/><b>Input:</b><input type="Text" value="" name="'+currentDiv+'_input"/><br/><b>Output:</b><input type="Text" value="" name="'+currentDiv+'_output"/><br/><b>Describe Path:</b><input type="Text" value="" name="'+currentDiv+'_describePath"/><br/><b>Number of Trees:</b><input type="Text" value="" name="'+currentDiv+'_numTrees"/><br/><b>Selected Attributes:</b><input type="Text" value="" name="'+currentDiv+'_selectedAttributes"/><br/><b>Predecessors:</b><input type="Text" value="" name="'+currentDiv+'_predecessors"/></div>';
		}
		else if(JOBTYPE=="MahoutTestForest")
		{
			content='<div id="'+currentDiv+'"> <br/> <b>Job Name:</b>'+currentDiv+'<br/><b>Job Type:</b><select class="jobType" name="'+currentDiv+'_jobType" id="'+currentDiv+'jobType"><option value="JavaClass" >Java Class</option><option value="MahoutClusterInputConversion" >Mahout Cluster Input Conversion</option><option value="MahoutKMeansCluster" >Mahout KMeans Cluster</option><option value="MahoutSeqDumper">Mahout Sequence Dumper</option><option value="MahoutRandomForestDescribe">Mahout Random Forest Describe</option><option value="MahoutBuildForest">Mahout Build Forest</option><option value="MahoutTestForest" selected="selected">Mahout Test Forest</option><option value="HadoopMR">Map Reduce Hadoop</option></select><br/><b>Input:</b><input type="Text" value="" name="'+currentDiv+'_input"/><br/><b>Output:</b><input type="Text" value="" name="'+currentDiv+'_output"/><br/><b>Describe Path:</b><input type="Text" value="" name="'+currentDiv+'_describePath"/><br/><b>Model Path:</b><input type="Text" value="" name="'+currentDiv+'_modelPath"/><br/><b>Predecessors:</b><input type="Text" value="" name="'+currentDiv+'_predecessors"/></div>';
		}
		else if(JOBTYPE=="HadoopMR")
		{
			content='<div id="'+currentDiv+'"> <br/> <b>Job Name:</b>'+currentDiv+'<br/><b>Job Type:</b><select class="jobType" name="'+currentDiv+'_jobType" id="'+currentDiv+'jobType"><option value="JavaClass" >Java Class</option><option value="MahoutClusterInputConversion" >Mahout Cluster Input Conversion</option><option value="MahoutKMeansCluster" >Mahout KMeans Cluster</option><option value="MahoutSeqDumper">Mahout Sequence Dumper</option><option value="MahoutRandomForestDescribe">Mahout Random Forest Describe</option><option value="MahoutBuildForest">Mahout Build Forest</option><option value="MahoutTestForest" >Mahout Test Forest</option><option value="HadoopMR" selected="selected">Map Reduce Hadoop</option></select><br/><b>Job Class:</b><input type="Text" value="" name="'+currentDiv+'_jobClass"/><br/><b>Mapper Class:</b><input type="Text" value="" name="'+currentDiv+'_mapperClass"/><br/><b>Combiner Class:</b><input type="Text" value="" name="'+currentDiv+'_combinerClass"/><br/><b>Reducer Class:</b><input type="Text" value="" name="'+currentDiv+'_reducerClass"/><br/><b>Output Key Class:</b><input type="Text" value="" name="'+currentDiv+'_outputKeyClass"/><br/><b>Output Value Class:</b><input type="Text" value="" name="'+currentDiv+'_outputValueClass"/><br/><b>Input Paths:</b><input type="Text" value="" name="'+currentDiv+'_inputPaths"/><br/><b>outputPath:</b><input type="Text" value="" name="'+currentDiv+'_outputPath"/><br/><b>Predecessors:</b><input type="Text" value="" name="'+currentDiv+'_predecessors"/></div>';
		}
		$(content).appendTo("#"+currentDiv);
	});
</script>
</html>