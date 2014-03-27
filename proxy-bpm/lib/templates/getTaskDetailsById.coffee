module.exports = """
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tas="http://xmlns.oracle.com/bpel/workflow/taskQueryService" xmlns:com="http://xmlns.oracle.com/bpel/workflow/common">
   <soapenv:Header/>
   <soapenv:Body>
      <tas:taskDetailsByIdRequest>
        <workflowContext xmlns="http://xmlns.oracle.com/bpel/workflow/common">
        	<token><%- token %></token>
     	</workflowContext>
        <tas:taskId><%- taskId %></tas:taskId>
      </tas:taskDetailsByIdRequest>
   </soapenv:Body>
</soapenv:Envelope>
"""