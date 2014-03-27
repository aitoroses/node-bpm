module.exports = """
	<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:com="http://xmlns.oracle.com/bpel/workflow/common">
    <soapenv:Header/>
    <soapenv:Body>
        <com:credential>
	         <com:login><%- login %></com:login>
	         <com:password><%- password %></com:password>
        </com:credential>
    </soapenv:Body>
	</soapenv:Envelope>
"""