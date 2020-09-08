<?xml version="1.0" encoding="UTF-8"?>
<xsl:package version="3.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:md="http://commonmark.org/xml/1.0"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
xmlns:html="http://www.w3.org/1999/XHTML"

name="urn:hidaruma:commonmark2html"
package-version="0.1.0"
xmlns:cm2h="urn:hidaruma:commonmark2html">
<xsl:output method="html"
            encoding="UTF-8" />
<xsl:mode />
<xsl:preserve-space
 elements="md:code_block md:code md:html_block html_inline custom_inline custom_block" />
<xsl:variable xml:space="preserve" name="cm2h:list-item-css" as="xs:string">
    <xsl:text>
        ol.paren, {
        list-style:none;
        counter-reset: order;
    }
    ol.paren::before{
        counter-increment(order);
        content: counters(order, ")") " 
    }</xsl:text>
</xsl:variable>

<xsl:template match="/" name="cm2h:root">
    <xsl:apply-templates />
</xsl:template>

<xsl:template match="md:document" name="cm2h:document">
<html:html>
    <html:head>
        <html:meta charset="UTF-8" />
    <html:style type="text/css">
    <xsl:value-of select="$cm2h:list-item-css" />
    </html:style>
    </html:head>
    <html:body>
        <xsl:apply-templates />
    </html:body>
</html:html>
</xsl:template>

<xsl:template match="md:heading" name="cm2h:heading">
    <xsl:variable name="htag">
    <xsl:value-of select="'h' || @level" />
    </xsl:variable>
    <xsl:element name="{$htag}" namespace="html">
            <xsl:apply-templates />
    </xsl:element>    
</xsl:template>

<xsl:template match="md:block_quote" name="cm2h:block_quote">
    <html:blockquote>
        <xsl:apply-templates />
    </html:blockquote>
</xsl:template>

<xsl:template match="md:list" name="cm2h:list">
    <xsl:choose>
        <xsl:when test="@type = 'bullet'">
            <html:ul>
                <xsl:apply-templates select="md:item"/>
            </html:ul>
        </xsl:when>
        <xsl:when test="@type = 'ordered'">
            <html:ol start="{@start}">
                
                <xsl:choose>
                    <xsl:when test="@delimiter = 'period'">
                    </xsl:when>
                    <xsl:when test="@delimiter = 'paren'">
                    <xsl:attribute name="class" select="paren" />
                    </xsl:when>
                </xsl:choose>
                <xsl:apply-templates select="md:item"/>
            </html:ol>
        </xsl:when>
    </xsl:choose>
</xsl:template>

<xsl:template match="md:item" name="cm2h:item">
    <html:li>
        <xsl:apply-templates />
    </html:li>
</xsl:template>

<xsl:template match="md:code_block" name="cm2h:code_block">
    <html:pre><html:code>
        <xsl:apply-templates xml:space="@xml:space"/>
    </html:code></html:pre>
</xsl:template>

<xsl:template match="md:paragraph" name="cm2h:paragraph">
    <html:p>
        <xsl:apply-templates />
    </html:p>
</xsl:template>

<xsl:template match="md:themantic_break"
 name="cm2h:themantic_break">
    <html:br />
</xsl:template>

<xsl:template match="md:html_block" name="cm2h:html_block">
        <xsl:copy-of select="." />
</xsl:template>

<xsl:template match="md:custom_block" name="cm2h:custom_block">
    <xsl:copy-of select="." />
</xsl:template>

<xsl:template match="md:html_inline" name="cm2h:html_inline">
    <xsl:copy-of select="." />
</xsl:template>

<xsl:template match="md:custom_inline" name="cm2h:custom_inline">
        <xsl:copy-of select="." />
</xsl:template>

<xsl:template match="md:softbreak" name="cm2h:softbreak">
</xsl:template>

<xsl:template match="md:linebreak" name="cm2h:linebreak">
</xsl:template>

<xsl:template match="md:text" name="cm2h:text">
    <xsl:apply-templates />
</xsl:template>

<xsl:template match="md:code" name="cm2h:code">
    <html:code>
        <xsl:apply-templates />
    </html:code>
</xsl:template>

<xsl:template match="md:emph" name="cm2h:emph">
    <html:emph>
        <xsl:apply-templates />
    </html:emph>
</xsl:template>

<xsl:template match="md:strong" name="cm2h:strong">
    <html:strong>
        <xsl:apply-templates />
    </html:strong>
</xsl:template>


<xsl:template match="md:link" name="cm2h:link">
    <html:a href="{@destination}">
        <xsl:choose>
            <xsl:when test="@title">
                <xsl:attribute name="title" select="@title" />
                    <xsl:value-of select="@title" />
            </xsl:when>
            <xsl:otherwise>
                    <xsl:value-of select="@destination" />
            </xsl:otherwise>
        </xsl:choose>
    </html:a>
</xsl:template>

<xsl:template match="md:image" name="cm2h:image">
    <html:img src="{@destination}">
        <xsl:if test="@title">
            <xsl:attribute name="title" select="@title" />
            <xsl:attribute name="alt" select="@title" />    
        </xsl:if>
    </html:img>
</xsl:template>
</xsl:package>