<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:wst="http://docs.oasis-open.org/ws-sx/ws-trust/200512" xmlns:saml2="urn:oasis:names:tc:SAML:2.0:assertion">
	<xsl:param name="dest"/>
	<xsl:template match="/">
		<saml2p:Response InResponseTo="" Version="2.0" xmlns:saml2p="urn:oasis:names:tc:SAML:2.0:protocol">
			<xsl:attribute name="Destination">
				<xsl:value-of select="$dest"/>
			</xsl:attribute>							
			<xsl:attribute name="IssueInstant">
				<xsl:value-of select="/wst:RequestSecurityTokenResponse/wst:RequestedSecurityToken/saml2:Assertion/@IssueInstant"/>
			</xsl:attribute>							
			<xsl:attribute name="ID">
				<xsl:value-of select="/wst:RequestSecurityTokenResponse/wst:RequestedSecurityToken/saml2:Assertion/@ID"/>
			</xsl:attribute>				
			<xsl:copy-of select="/wst:RequestSecurityTokenResponse/wst:RequestedSecurityToken/saml2:Assertion/saml2:Issuer"/>
			<saml2p:Status xmlns:saml2p="urn:oasis:names:tc:SAML:2.0:protocol">
				<saml2p:StatusCode Value="urn:oasis:names:tc:SAML:2.0:status:Success"/>
			</saml2p:Status>
			<xsl:copy-of select="/wst:RequestSecurityTokenResponse/wst:RequestedSecurityToken/saml2:Assertion"/>
		</saml2p:Response>	
	</xsl:template>
</xsl:stylesheet>