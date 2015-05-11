<%@ page language="java" import="javax.xml.transform.OutputKeys,java.io.File,javax.xml.parsers.DocumentBuilder,javax.xml.parsers.DocumentBuilderFactory,javax.xml.parsers.ParserConfigurationException,javax.xml.transform.Transformer,javax.xml.transform.TransformerException,javax.xml.transform.TransformerFactory,javax.xml.transform.dom.DOMSource,javax.xml.transform.stream.StreamResult,org.w3c.dom.Attr,org.w3c.dom.Document,org.w3c.dom.Element;" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String jobNames=request.getParameter("jobNames");
	out.println(jobNames);
	String listOfJobs[]=jobNames.split(",");
	try
	{
	DocumentBuilderFactory docFactory = DocumentBuilderFactory.newInstance();
	DocumentBuilder docBuilder = docFactory.newDocumentBuilder();
	// root elements
	Document doc = docBuilder.newDocument();
	Element rootElement = doc.createElement("Workflows");
	doc.appendChild(rootElement);
 	Element workflowElement=doc.createElement("Workflow");
 	rootElement.appendChild(workflowElement);
 	Element job[]=new Element[listOfJobs.length];
 	for(int i=0;i<listOfJobs.length;i++){
 		job[i] = doc.createElement("job");
		workflowElement.appendChild(job[i]);
		Attr attr = doc.createAttribute("type");
		String jobType=request.getParameter(listOfJobs[i]+"_jobType");
		attr.setValue(jobType);
		job[i].setAttributeNode(attr);
		//adding jobName
		Element job_name=doc.createElement("jobName");
		job_name.appendChild(doc.createTextNode(listOfJobs[i]));
		job[i].appendChild(job_name);
		//adding predecessors
		String predecessors_value=request.getParameter(listOfJobs[i]+"_predecessors");
		if(predecessors_value==null)
			predecessors_value="";
		Element predecessors=doc.createElement("predecessors");
		predecessors.appendChild(doc.createTextNode(predecessors_value));
		job[i].appendChild(predecessors);
		if(jobType.equals("JavaClass"))
		{
			//adding java class name
			Element java_class=doc.createElement("javaClassName");
			java_class.appendChild(doc.createTextNode(request.getParameter(listOfJobs[i]+"_className").trim()));
			job[i].appendChild(java_class);
			//adding arguments
			Element arguments=doc.createElement("arguments");
			job[i].appendChild(arguments);
			String listOfArguments[]=(request.getParameter(listOfJobs[i]+"_arguments")).split(",");
			Element argument[]=new Element[listOfArguments.length];
			for(int j=0;j<listOfArguments.length;j++)
			{
				argument[j]=doc.createElement("argument");
				arguments.appendChild(argument[j]);
				Element value=doc.createElement("value");
				value.appendChild(doc.createTextNode(listOfArguments[j]));
				argument[j].appendChild(value);
			}
		}
		else if(jobType.equals("MahoutClusterInputConversion"))
		{
			//adding input path
			Element input=doc.createElement("input");
			input.appendChild(doc.createTextNode(request.getParameter(listOfJobs[i]+"_input")));
			job[i].appendChild(input);
			//adding output path
			Element output=doc.createElement("output");
			output.appendChild(doc.createTextNode(request.getParameter(listOfJobs[i]+"_output")));
			job[i].appendChild(output);
			//adding vector class
			Element vectorClass=doc.createElement("vectorClass");
			vectorClass.appendChild(doc.createTextNode(request.getParameter(listOfJobs[i]+"_vectorClass")));
			job[i].appendChild(vectorClass);
		}
		else if(jobType.equals("MahoutKMeansCluster"))
		{
			//adding input path
			Element input=doc.createElement("input");
			input.appendChild(doc.createTextNode(request.getParameter(listOfJobs[i]+"_input")));
			job[i].appendChild(input);
			//adding output path
			Element output=doc.createElement("output");
			output.appendChild(doc.createTextNode(request.getParameter(listOfJobs[i]+"_output")));
			job[i].appendChild(output);
			//adding distanceMeasure class
			Element distanceMeasure=doc.createElement("distanceMeasure");
			distanceMeasure.appendChild(doc.createTextNode(request.getParameter(listOfJobs[i]+"_distanceMeasure")));
			job[i].appendChild(distanceMeasure);
			//adding k points value
			Element kPoints=doc.createElement("kPoints");
			kPoints.appendChild(doc.createTextNode(request.getParameter(listOfJobs[i]+"_kPoints")));
			job[i].appendChild(kPoints);
			//adding iterations value
			Element iterations=doc.createElement("iterations");
			iterations.appendChild(doc.createTextNode(request.getParameter(listOfJobs[i]+"_iterations")));
			job[i].appendChild(iterations);
			//adding clusterPath path
			Element clusterPath=doc.createElement("clusterPath");
			clusterPath.appendChild(doc.createTextNode(request.getParameter(listOfJobs[i]+"_clusterPath")));
			job[i].appendChild(clusterPath);
		}
		else if(jobType.equals("MahoutSeqDumper"))
		{
			//adding input path
			Element input=doc.createElement("input");
			input.appendChild(doc.createTextNode(request.getParameter(listOfJobs[i]+"_input")));
			job[i].appendChild(input);
			//adding output path
			Element output=doc.createElement("output");
			output.appendChild(doc.createTextNode(request.getParameter(listOfJobs[i]+"_output")));
			job[i].appendChild(output);
		}
		else if(jobType.equals("MahoutRandomForestDescribe"))
		{
			//adding input path
			Element input=doc.createElement("input");
			input.appendChild(doc.createTextNode(request.getParameter(listOfJobs[i]+"_input")));
			job[i].appendChild(input);
			//adding output path
			Element output=doc.createElement("output");
			output.appendChild(doc.createTextNode(request.getParameter(listOfJobs[i]+"_output")));
			job[i].appendChild(output);
			//adding describe fields
			Element describe=doc.createElement("describe");
			describe.appendChild(doc.createTextNode(request.getParameter(listOfJobs[i]+"_describe")));
			job[i].appendChild(describe);
		}
		else if(jobType.equals("MahoutBuildForest"))
		{
			//adding input path
			Element input=doc.createElement("input");
			input.appendChild(doc.createTextNode(request.getParameter(listOfJobs[i]+"_input")));
			job[i].appendChild(input);
			//adding output path
			Element output=doc.createElement("output");
			output.appendChild(doc.createTextNode(request.getParameter(listOfJobs[i]+"_output")));
			job[i].appendChild(output);
			//adding describe file path 
			Element describePath=doc.createElement("describePath");
			describePath.appendChild(doc.createTextNode(request.getParameter(listOfJobs[i]+"_describePath")));
			job[i].appendChild(describePath);
			//adding number of trees value
			Element numTrees=doc.createElement("numTrees");
			numTrees.appendChild(doc.createTextNode(request.getParameter(listOfJobs[i]+"_numTrees")));
			job[i].appendChild(numTrees);
			//adding selected attributed value
			Element selectedAttributes=doc.createElement("selectedAttributes");
			selectedAttributes.appendChild(doc.createTextNode(request.getParameter(listOfJobs[i]+"_selectedAttributes")));
			job[i].appendChild(selectedAttributes);
		}
		else if(jobType.equals("MahoutTestForest"))
		{
			//adding input path
			Element input=doc.createElement("input");
			input.appendChild(doc.createTextNode(request.getParameter(listOfJobs[i]+"_input")));
			job[i].appendChild(input);
			//adding output path
			Element output=doc.createElement("output");
			output.appendChild(doc.createTextNode(request.getParameter(listOfJobs[i]+"_output")));
			job[i].appendChild(output);
			//adding describe file path 
			Element describePath=doc.createElement("describePath");
			describePath.appendChild(doc.createTextNode(request.getParameter(listOfJobs[i]+"_describePath")));
			job[i].appendChild(describePath);
			//adding model path value
			Element modelPath=doc.createElement("modelPath");
			modelPath.appendChild(doc.createTextNode(request.getParameter(listOfJobs[i]+"_modelPath")));
			job[i].appendChild(modelPath);
		}
 	}
		
		// write the content into xml file
		TransformerFactory transformerFactory = TransformerFactory.newInstance();
		Transformer transformer = transformerFactory.newTransformer();
		transformer.setOutputProperty(OutputKeys.INDENT, "yes");
		transformer.setOutputProperty("{http://xml.apache.org/xslt}indent-amount", "4");
		DOMSource source = new DOMSource(doc);
		StreamResult result = new StreamResult(new File(request.getParameter("XMLPath")));
 
		// Output to console for testing
		// StreamResult result = new StreamResult(System.out);
 
		transformer.transform(source, result);
 
		out.println("File saved!");
 
	  } catch (ParserConfigurationException pce) {
		pce.printStackTrace();
	  } catch (TransformerException tfe) {
		tfe.printStackTrace();
	  }
%>
</body>
</html>