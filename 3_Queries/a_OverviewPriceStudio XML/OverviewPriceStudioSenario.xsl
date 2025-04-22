<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- This XSL code describes a scenario for a macro market view of the prices of all the studios on the platform. It enables private individuals/professionals to automatically obtain the average price of a studio without parking in each town-->
<xsl:output method="xml" encoding="UTF-8"/>

<xsl:key name="city-key" match="IMMOPRODUCT[IMMONATURE = 'Apartment' and DESCRIPTIF/IMMONUMBEROFROOM = 1 and DESCRIPTIF/IMMOEXTERIORS/IMMOPARKING/IMMOCARNUMBER = 0]" use="IMMOADRESS/IMMOCITY"/>
	<!-- The Goup by function doesn't work in XSLT 1.0, so we used Muench method  to allow to create an uniq identifiant for each IMMOPRODUCT (based XPath filter) in which one of each first IMMOCITY designation is choosen to name the subgroup.   
	This code is inspired of XSL lins with a HTML outpout from on chap. 10 of "XSLT Cookbook", 2nd edition, Sal Mangano, 2005, available on https://learning.oreilly.com/library/view/xslt-cookbook-2nd/0596009747/ch10.html#xsltckbk2-CHP-10-SECT-3
	We decided to adapt it in order to have a result with XML format-->

	<xsl:template match="/">
		<Cities> 
			<xsl:variable name="unique-cities" select="//IMMOPRODUCT[IMMONATURE = 'Apartment'and DESCRIPTIF/IMMONUMBEROFROOM = 1 and DESCRIPTIF/IMMOEXTERIORS/IMMOPARKING/IMMOCARNUMBER = 0 and generate-id(.) = generate-id(key('city-key', IMMOADRESS/IMMOCITY)[1])] /IMMOADRESS/IMMOCITY"/>
			<xsl:for-each select="$unique-cities">
				<xsl:variable name="current-city" select="."/> <!-- https://www.w3schools.com/xml/ref_xsl_el_variable.asp-->
				<City>
					<xsl:value-of select="$current-city"/>
				</City>
				<Average_Price>
					<xsl:call-template name="calculate-average">
						<xsl:with-param name="city" select="$current-city"/> <!-- As describe in https://learning.oreilly.com/library/view/xslt-cookbook-2nd/0596009747/ch10.html#xsltckbk2-CHP-10-SECT-3-->
					</xsl:call-template> <xsl:text> (EUR) </xsl:text> <!-- This line is from https://www.w3schools.com/XML/ref_xsl_el_text.asp-->
				</Average_Price>
			</xsl:for-each>
		</Cities>
	</xsl:template>

	<xsl:template name="calculate-average">
		<xsl:param name="city"/>
		<xsl:variable name="total-price" select="sum(//IMMOPRODUCT[IMMONATURE = 'Apartment'and DESCRIPTIF/IMMONUMBEROFROOM = 1 and DESCRIPTIF/IMMOEXTERIORS/IMMOPARKING/IMMOCARNUMBER = 0 and IMMOADRESS/IMMOCITY = $city] /IMMOPRICE)"/>
		<xsl:variable name="count" select="count(//IMMOPRODUCT[IMMONATURE = 'Apartment'and DESCRIPTIF/IMMONUMBEROFROOM = 1 and DESCRIPTIF/IMMOEXTERIORS/IMMOPARKING/IMMOCARNUMBER = 0 and IMMOADRESS/IMMOCITY = $city])"/>
		<xsl:variable name="average" select="($total-price div $count)"/> <!-- Call (by $symbole) the TotalPrice fonction ("totalPrice") which is divided (div operator) by count function (count) 
		from https://www.developpez.net/forums/d846239/autres-langages/xml-xsl-soap/xsl-xslt-xpath/xslt-calcul-entre-noeuds-resultat-noeud/ and https://www.w3schools.com/Tags/tag_div.asp-->
		<xsl:value-of select="format-number($average, '0.00')"/> <!-- This line displays a float value (2 digits) from https://www.w3schools.com/xml/func_formatnumber.asp-->
	</xsl:template>
</xsl:stylesheet>
