<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<!-- The scenario is based on a informations request of estate agence to find all the suppliers available to Monaco in order to prepare them for a rent or a sale-->
<!-- The basis of this xsl code is inspired from transfo2_0 and output5.html of Data Pipelines of DSTI courses and modified for recursive part according to 
chap 4 of the book "XSLT" by Dough Tidwell, 2001 avalaible on https://learning.oreilly.com/library/view/xslt/0596000537/ch04s06.html-->
<!--For remeinder, the distance between Nice - Monaco is 20kM by M6007 to compare to Nice - Cannes is 34km by A8 from Google maps-->
	<xsl:output method="html" encoding="UTF-8"/>
	
	<xsl:template match="/">
		<html>
			<head>
				<title>Suppliers - Monaco</title>
			</head>
			<body>
				<h1> ESTATEPLATEFORME provides  <strong>
						<xsl:value-of select="count(//SUPPLIER[(SUPPLIERZONEINTERVENTION = 'MONACO') or (SUPPLIERZONEINTERVENTION = 'NICE' and (ZONEFLEXIBILITY = 'UpTO20KM' or ZONEFLEXIBILITY = 'UpTO30KM'))])"/>
					</strong> suppliers intervening to Monaco
				</h1>
				
				<table border="1">
					<tr bgcolor="#04AA6D"> <!-- Color code from https://www.w3schools.com/Css/css_table_style.asp -->
						<th align="center"> Function</th> <!-- Align = "center" from https://www.jameshbyrd.com/building-html-tables-with-xsl/"-->
						<th align="center">Name</th>
						<th align="center">Prestation</th>
						<th align="center">Time</th>
						<th align="center">Mail</th>
						<th align="center">Tel. Number</th>
					</tr>
					<xsl:call-template name="recursive-supplier-list"> 
						<xsl:with-param name="suppliers" select="//SUPPLIER[(SUPPLIERZONEINTERVENTION = 'MONACO') or (SUPPLIERZONEINTERVENTION = 'NICE' and (ZONEFLEXIBILITY = 'UpTO20KM' or ZONEFLEXIBILITY = 'UpTO30KM'))]"/> <!-- This list send the recursive template a list of suppliers filtred according to their area of operation-->
					</xsl:call-template>
				</table>
			</body>
		</html>
	</xsl:template>
	
	<xsl:template name="recursive-supplier-list"> 
		<xsl:param name="suppliers"/> <!-- The recursive-supplier-list template receives a list of suppliers to be processed-->
		<xsl:if test="count($suppliers) > 0"> <!-- This condition checks if there are still suppliers to process in the suppliers list, the recursion continues as long as at least one supplier remains-->
			<xsl:variable name="current" select="$suppliers[1]"/> <!-- The variable $current takes the first supplier list, representing the supplier currently being processed during the recursion-->
			<xsl:variable name="remaining" select="$suppliers[position() > 1]"/> <!-- $remaining contains the list of suppliers except the first one, and its value is passed to the parameter suppliers in the next recursive call-->
			<tr>
				<td><xsl:value-of select="$current/SUPPLIERACTIVITY"/></td> <!-- Initializing of the row by first attribut i.e. supplieractivity node = Fonction-->
				<td><xsl:value-of select="$current/SUPPLIERNAME"/></td>
				<td><xsl:value-of select="$current/SUPPLIERPRESTATION"/></td>
				<td><xsl:value-of select="$current/SUPPLIERHOURSINTERVENTION"/></td>
				<td><xsl:value-of select="$current/SUPPLIERMAIL"/></td>
				<td><xsl:value-of select="$current/SUPPLIERTEL"/></td> <!-- End of row by the last node SUPPLIERTEL node = Tel. number -->
			</tr>
			<xsl:call-template name="recursive-supplier-list"> <!-- Call and run the recursive-supplier-list template -->
				<xsl:with-param name="suppliers" select="$remaining"/> <!-- This line sends a list of remaining supplier to be processed to the recursive template until count($suppliers)=0-->
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>