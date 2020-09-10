<?xml version="1.0" encoding="UTF-8"?>
<xsl:package version="3.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:md="http://commonmark.org/xml/1.0"
xmlns:xs="http://www.w3.org/2001/XMLSchema"

name="urn:hidaruma:commonmark2html"
package-version="0.1.1"
xmlns:cm2h="urn:hidaruma:commonmark2html"
xmlns="http://www.w3.org/1999/XHTML"
exclude-result-prefixes="#all">
<!-- 
    A XSLT 3.0 Package, CommonMark Document transform into HTML5

    Author: YOKOTA Tasturo <hidaruma@outlook.jp>

    LICENE: MIT LICENSE

-->
<xsl:output method="html"
            omit-xml-declaration="yes"
            encoding="UTF-8"
            indent="yes"
            html-version="5.0"
            byte-order-mark="no"
            expand-text="yes" />
<xsl:mode streamable="yes"
          on-no-match="shallow-copy"/>
<xsl:preserve-space
 elements="md:code_block md:code md:html_block html_inline custom_inline custom_block" />
<xsl:variable name="cm2h:list-item-css" as="xs:string">
<xsl:text>    ol.paren, {list-style:none;counter-reset: order;}
    ol.paren::before{counter-increment(order);content: counters(order, ")") " }</xsl:text>
</xsl:variable>
<xsl:param name="lang" as="xs:string" select="'en'"/>

<xsl:template match="/" name="cm2h:root">
    <xsl:apply-templates />
</xsl:template>

<xsl:template name="cm2h:meta">
        <meta charset="UTF-8" />
        <meta name="generator" content="XSLT 3.0" />
</xsl:template>

<xsl:template match="md:document" name="cm2h:document">
<html lang="{$lang}">
    <head>
        <title>
        <xsl:value-of select=".//md:heading[@level = '1']" />
    </title>
        <xsl:call-template name="cm2h:meta" />
        <style type="text/css">
            <xsl:comment>
                <xsl:value-of select="$cm2h:list-item-css" />
            </xsl:comment>
        </style>
    </head>
    <body>
        <xsl:apply-templates />
    </body>
</html>
</xsl:template>

<xsl:template match="md:heading" name="cm2h:heading">
    <xsl:variable name="htag">
        <xsl:value-of 
            select="'h' || @level" />
        </xsl:variable>
    <xsl:element name="{$htag}">
            <xsl:apply-templates />
    </xsl:element>    
</xsl:template>

<xsl:template match="md:block_quote" name="cm2h:block_quote">
    <blockquote>
        <xsl:apply-templates />
    </blockquote>
</xsl:template>

<xsl:template match="md:list" name="cm2h:list">
    <xsl:choose>
        <xsl:when test="@type = 'bullet'">
            <ul>
                <xsl:apply-templates select="md:item"/>
            </ul>
        </xsl:when>
        <xsl:when test="@type = 'ordered'">
            <ol start="{@start}">
                
                <xsl:choose>
                    <xsl:when test="@delimiter = 'period'">
                    </xsl:when>
                    <xsl:when test="@delimiter = 'paren'">
                    <xsl:attribute name="class" select="paren" />
                    </xsl:when>
                </xsl:choose>
                <xsl:apply-templates select="md:item"/>
            </ol>
        </xsl:when>
    </xsl:choose>
</xsl:template>

<xsl:template match="md:item" name="cm2h:item">
    <li>
        <xsl:apply-templates />
    </li>
</xsl:template>

<xsl:template match="md:code_block" name="cm2h:code_block">
    <pre><code>
        <xsl:apply-templates xml:space="@xml:space"/>
    </code></pre>
</xsl:template>

<xsl:template match="md:paragraph" name="cm2h:paragraph">
    <p>
        <xsl:apply-templates />
    </p>
</xsl:template>

<xsl:template match="md:themantic_break"
 name="cm2h:themantic_break">
    <br />
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
    <code>
        <xsl:apply-templates />
    </code>
</xsl:template>

<xsl:template match="md:emph" name="cm2h:emph">
    <emph>
        <xsl:apply-templates />
    </emph>
</xsl:template>

<xsl:template match="md:strong" name="cm2h:strong">
    <strong>
        <xsl:apply-templates />
    </strong>
</xsl:template>


<xsl:template match="md:link" name="cm2h:link">
    <a href="{@destination}">
        <xsl:choose>
            <xsl:when test="@title">
                <xsl:attribute name="title" select="@title" />
                    <xsl:value-of select="@title" />
            </xsl:when>
            <xsl:otherwise>
                    <xsl:value-of select="@destination" />
            </xsl:otherwise>
        </xsl:choose>
    </a>
</xsl:template>

<xsl:template match="md:image" name="cm2h:image">
    <img src="{@destination}">
        <xsl:if test="@title">
            <xsl:attribute name="title" select="@title" />
            <xsl:attribute name="alt" select="@title" />    
        </xsl:if>
    </img>
</xsl:template>
</xsl:package>