module.exports="""<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://xmlns.oracle.com/eApp/eAppServices/Service_Form_Get">
    <soapenv:Header/>
    <soapenv:Body>
		<ser:formGet>
			<ser:requestId><%- requestId %></ser:requestId>
			<ser:currentStepId><%- currentStepId %></ser:currentStepId>
		</ser:formGet>
    </soapenv:Body>
</soapenv:Envelope>"""