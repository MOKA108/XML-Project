<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- This XSL code describes a scenario for a macro market view of the prices of all the studios on the platform. It enables private individuals/professionals to automatically obtain the average price of a studio without parking in each town-->
<xsl:output method="xml" encoding="UTF-8"/>

    
<xsl:template match="/">
    <html>
        <head>
            <title>Displaying Seller Information</title>
                <style>
                    .spacer {margin-top: 20px;}
                    body {background-color: #c8dee3;}
                </style>
        </head>
        <body>
            <h1>Displaying Seller Information</h1>
            <p>Sellers are displayed in descending order according to the total money received</p>
            <hr/>
            <br/>			           

            <xsl:for-each select="//SELLER">
            <xsl:sort select="sum(//TRANSACTION[TRANSACTIONSELLER=current()/@SELLERref]/TRANSACTIONAMOUNT)" data-type="number" order="descending"/>
                         
                <h2><xsl:value-of select="@SELLERref"/>: <xsl:value-of select="SELLERNAME"/></h2>
                
                <ul>
                    <li>Subscription Status: <xsl:if test="SELLERSUBSCRIPTION = 'NO'">Unsubscribe</xsl:if><xsl:if test="SELLERSUBSCRIPTION='YES'">Subscribe</xsl:if></li>
                    <li>
                        Additional Options:<xsl:if test="not(SELLERPAIDOPTION/OPTION)"> No option</xsl:if>
                        <ul>
                            <xsl:for-each select="SELLERPAIDOPTION/OPTION">
                                <li><xsl:value-of select="."/></li>
                            </xsl:for-each>
                        </ul>
                    </li>
                </ul>
                <ul>
                    <li>
                        Number of Listed Properties: <xsl:value-of select="count(//IMMOPRODUCT[SELLERref=current()/@SELLERref])"/>
                        <xsl:if test="count(//IMMOPRODUCT[SELLERref=current()/@SELLERref]) &gt; 0">
                            <ul>
                                <li>Rent: <xsl:value-of select="count(//IMMOPRODUCT[SELLERref=current()/@SELLERref and IMMOTRANSACTION='Rent'])"/></li>
                                <li>Sale: <xsl:value-of select="count(//IMMOPRODUCT[SELLERref=current()/@SELLERref and IMMOTRANSACTION='Sale'])"/></li>
                            </ul>
                        </xsl:if>
                    </li>
                </ul>
                <ul>
                    <li>Number of Transactions: <xsl:value-of select="count(//TRANSACTION[TRANSACTIONSELLER=current()/@SELLERref])"/></li>
                    <li>Total Transactions Received (eur): <xsl:value-of select="sum(//TRANSACTION[TRANSACTIONSELLER=current()/@SELLERref]/TRANSACTIONAMOUNT)"/></li>
                </ul>
            </xsl:for-each>
        </body>
    </html>
</xsl:template>
</xsl:stylesheet>
