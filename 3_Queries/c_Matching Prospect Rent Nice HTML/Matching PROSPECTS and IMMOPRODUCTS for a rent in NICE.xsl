<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--
This stylesheet finds all the PROSPECTs looking to rent in Nice,
who can afford at least one IMMOPRODUCT : PROSPECT/CRITERIA/BUDGET >= IMMOPRODUCT/IMMOPRICE

Data is displayed in a web page.

For each prospect, the following data is shown :

PROSPECT: FirstName LastName
BUDGET: X
IMMOPRODUCT:Iyy
PRICE:Y

This stylesheet doesn't use any for-each loop, but two successive templates.

-->

    <xsl:output method="html" encoding="UTF-8"/>

    <xsl:template match="/">
        <html>
            <head>
                <title>Matching PROSPECTS and IMMOPRODUCTS for a rent in NICE</title>
                <style>
                    .spacer { margin-top: 20px; }
                    body { background-color: lightblue; }
                </style>
            </head>
            <body>
                <h2>Matching PROSPECTS and IMMOPRODUCTS for a rent in NICE</h2>
				
				<!-- selecting the IMMOPRODUCTs for Rent in Nice. The template for IMMOPRODUCTS will then be applied -->
                <xsl:apply-templates select="//IMMOPRODUCT[IMMOTRANSACTION = 'Rent' and IMMOADRESS/IMMOCITY = 'NICE']"/>
            </body>
        </html>
    </xsl:template>

    <!-- Template for IMMOPRODUCT -->
    <xsl:template match="IMMOPRODUCT">
	
		<!-- For each IMMOPRODUCT, we find the PROSPECTs whose budget is greater than the asked price.
		These PROSPECTs will be passed on to the PROSPECT template below.
		Note : current() is used to refer to the current IMMOPRODUCT -->
        <xsl:apply-templates select="//PROSPECT[
            CRITERIA/CITYSEARCH = 'NICE' and 
            CRITERIA/KINDOFTRANSACTION = 'Rent' and 
            CRITERIA/BUDGET >= current()/IMMOPRICE  
        ]">
			<!-- The current IMMOPRODUCT is stored in with-param parameter-->
			<xsl:with-param name="product" select="."/>
        </xsl:apply-templates>
    </xsl:template>

    <!-- For each corresponding PROSPECT, along with the IMMOPRODUCT passed as a param,
	we form the needed informatrion blocks-->
    <xsl:template match="PROSPECT">
        <xsl:param name="product"/>

        <div>
			<!-- For PROSPECT and BUDGET : data is accessed directly, as this template is for PROSPECT elements
			For IMMOPRODUCT, the data is accessed via the param variable $product -->
            <strong>PROSPECT: </strong> <xsl:value-of select="FirstName"/> <xsl:text> </xsl:text> <xsl:value-of select="LastName"/><br/>			
            <strong>BUDGET:</strong> <xsl:value-of select="CRITERIA/BUDGET"/><br/>
            <strong>IMMOPRODUCT: </strong> <xsl:value-of select="$product/@immoref"/><br/>
            <strong>PRICE: </strong> <xsl:value-of select="$product/IMMOPRICE"/><br/>
        </div>
        <div class="spacer"></div>
    </xsl:template>

</xsl:stylesheet>
