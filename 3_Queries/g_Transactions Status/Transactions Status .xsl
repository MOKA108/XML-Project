<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- This XSL code describes a scenario for a macro market view of the prices of all the studios on the platform. It enables private individuals/professionals to automatically obtain the average price of a studio without parking in each town-->
<xsl:output method="text" encoding="UTF-8"/>

 <xsl:template match="/">
    {
    "TotalTransactionAmount": "<xsl:value-of select="sum(//TRANSACTION/TRANSACTIONAMOUNT)"/>",
    "TotalSalesAmount": "<xsl:value-of select="sum(//TRANSACTION[TRANSACTIONINFO='Sale']/TRANSACTIONAMOUNT)"/>",
    "TotalRentAmount": "<xsl:value-of select="sum(//TRANSACTION[TRANSACTIONINFO='Rent']/TRANSACTIONAMOUNT)"/>",
    "ProspectsWithTransactions": [
        <xsl:for-each select="//PROSPECT[//TRANSACTION[TRANSACTIONPROSPECT=//PROSPECT/@proref]]">
            <xsl:if test="count(//TRANSACTION[TRANSACTIONPROSPECT=current()/@proref]) &gt; 0">"<xsl:value-of select="@proref"/>"<xsl:if test="position() != last()">,</xsl:if></xsl:if>
        </xsl:for-each>
    ],
    "DetailedProspects": [
        <xsl:for-each select="//PROSPECT[//TRANSACTION[TRANSACTIONPROSPECT=//PROSPECT/@proref]]">
            <xsl:if test="count(//TRANSACTION[TRANSACTIONPROSPECT=current()/@proref]) &gt; 0">
            {
                "id": "<xsl:value-of select="@proref"/>",
                "name": "<xsl:value-of select="concat(LastName, ' ', FirstName)"/>",
                "TotalSpent": "<xsl:value-of select="sum(//TRANSACTION[TRANSACTIONPROSPECT=current()/@proref]/TRANSACTIONAMOUNT)"/>",
                "TransactionCount": "<xsl:value-of select="count(//TRANSACTION[TRANSACTIONPROSPECT=current()/@proref])"/>",
                "TransactionIds": [<xsl:for-each select="//TRANSACTION[TRANSACTIONPROSPECT=current()/@proref]">"<xsl:value-of select="@TRANSACTIONref"/>"<xsl:if test="position() != last()">,</xsl:if></xsl:for-each>]
            }<xsl:if test="position() != last()">,</xsl:if>
            </xsl:if>
        </xsl:for-each>
    ]
    }
</xsl:template>
</xsl:stylesheet>