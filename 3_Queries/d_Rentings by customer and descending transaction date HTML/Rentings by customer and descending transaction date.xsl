<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- 
This style sheet creates an html output where all the rentings of each PROSPECT
is displayed, ordered by descending transaction date. The two first lines count the total number of rentings and
the number of distinct prospects involved in those transactions.

This stylesheet uses the same grouping method ("MUENCHIAN method") as in OverviewPriceStudioOverviewSenariot.xsl,
as there is no grouping feature in xsl 1.0 (no xsl:for-each-group in xsl v1.0)

This Stylesheet uses two nested for-each loops.

-->


    <xsl:output method="html" encoding="UTF-8"/>
	

    <!-- Define a key for grouping products by transaction, with a filter -->
    <xsl:key name="transactions-by-prospect" match="//TRANSACTION[TRANSACTIONINFO = 'Rent']" use="TRANSACTIONPROSPECT"/>

    <xsl:template match="/">
        <html>
            <head>
                <title>Rentings, by customer and descending transaction date</title>
					<style>
						.spacer {margin-top: 20px;}
						body {background-color: lightblue;}
					</style>
            </head>
            <body>
                <h1>Rentings, by customer and descending transaction date</h1>
				<h2>Total number of transactions: <xsl:value-of select="count(//TRANSACTION[TRANSACTIONINFO = 'Rent'])"/></h2>
				
				<!-- The heart of the Muenchian method : the code "generate-id() = generate-id(key('transactions-by-prospect', TRANSACTIONPROSPECT)[1])" ensures
				the uniqueness of selected node -->
				<h2>Number of customers: <xsl:value-of select="count(//TRANSACTION[TRANSACTIONINFO = 'Rent' and generate-id() = generate-id(key('transactions-by-prospect', TRANSACTIONPROSPECT)[1])])"/></h2>
			    <br/>
			    <hr/>				

                <!-- Again, the Muenchian method is used to find unique transactions -->
                <xsl:for-each select="//TRANSACTION[generate-id() = generate-id(key('transactions-by-prospect', TRANSACTIONPROSPECT)[1])]">
                    
					<!-- The variable current-grouping-key stores the TRANSACTIONPROSPECT value of the current TRANSACTION.
					This variable is used 3 times (2 for FirstName + LastName) and 1 later in the second for-each loop
					-->
					<xsl:variable name="current-grouping-key" select="TRANSACTIONPROSPECT"/>
                    
					<!-- using @proref to retrieve FirstName and LastName -->
					<h2>Prospect: <xsl:value-of select="//PROSPECT[@proref = $current-grouping-key]/FirstName"/> <xsl:text> </xsl:text> <xsl:value-of select="//PROSPECT[@proref = $current-grouping-key]/LastName"/></h2>
					
                    <ul>
                        <!-- Select all TRANSACTIONs for given PROSPECT -->
                        <xsl:for-each select="key('transactions-by-prospect', $current-grouping-key)">
							
							<!-- ordering by TRANSACTIONDATE before fetching the data -->
							<xsl:sort select="TRANSACTIONDATE" order="descending"/>
						
                            <li>Date: <xsl:value-of select="TRANSACTIONDATE"/></li>
                            <li>Amount (eur): <xsl:value-of select="TRANSACTIONAMOUNT"/></li>
                            <li>Product Ref.: <xsl:value-of select="TRANSACTIONIMMOPRODUCT"/></li>
							<div class="spacer"></div>
                        </xsl:for-each>
                    </ul>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>