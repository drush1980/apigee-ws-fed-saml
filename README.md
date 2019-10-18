# SAML Web SSO flow to WS-Federation Passive Requestor Proxy

This is an Apigee API Proxy that converts between a [SAML 2.0 browser POST profile](https://docs.oasis-open.org/security/saml/v2.0/saml-profiles-2.0-os.pdf_) SP initiated SSO flow and a [WS-Federation Passive Requestor flow](http://docs.oasis-open.org/wsfed/federation/v1.2/os/ws-federation-1.2-spec-os.html#_Toc223175004).  Upon receiving a SAML authn request the proxy will forward the request to a designated WS-Federation IP/STS endpoint.  Upon a successful login the proxy will receive the WS-Federation response which must contain a valid SAML assertion. The proxy will extract the assertion and wrap it in a SAML response envelope, before triggering a browser POST to the designated assertion consumer service URL at the SAML SP.


## Disclaimer

This example is not an official Google product, nor is it part of an official Google product.


## Notes

* In this sample the issuing SAML SP's  entity ID is used as the WS-Fed security realm value.
* The SAML authn request and resulting assertion is not validated in this proxy (although this could be added using Apigee [SAML policies](https://docs.apigee.com/api-platform/reference/policies/saml-assertion-policy)).  The assumption is that the WS-Fed Identity Provider and SAML Service Provider are configured with the correct security realms, audiences and certs etc.
* The SAML response envelope created in the proxy is not signed. The expectation is that the assertion returned from the WS-Federation endpoint is signed and will be validated at the SP.
* In this sample both the WS-Fed IP/STS the SAML SP ACS endpoints are configured in an Apigee KVM named `federationInfo`.  This can be changed as desired or hardcoded values could be used instead.


## Setup

You will need an Apigee Edge login to use this proxy.  If you don't have one you may sign up for a trial account [here](https://login.apigee.com/sign__up).

Before exercising this proxy, you need to:

1. Deploy the proxy bundle to your Apigee Edge environment.

2. Create a SAML IdP connection in your SAML Service Provider system and obtain the metadata, including the entity ID and ACS URL at a minimum.  For the SAML sign in URL, use the Apigee proxy basepath + `/auth`, for example `https://orgname-test.apigee.net/v1/ws-fed-saml-proxy/auth`

3. Configure a WS-Federation passive requestor IP/STS endpoint in a system of your choice, for example in [Okta](https://help.okta.com/en/prod/Content/Topics/Apps/Apps_Configure_Okta%20Template_WS_Federation.htm), using the values from the previous step.  Associate with a user account if necessary.

4. Update the SAML SP configuration with the IdP's entity ID and signing certificate.

5. Create a [KVM](https://docs.apigee.com/api-platform/cache/key-value-maps) named `federationInfo` in your Apigee environment.  Add two keys, named `acsURL` (value of the SP assertion consumer service URL), and `idpEndpoint` (value of WS-Fed IP/STS URL).

6. Trigger an SP initiated SAML login flow.


## Deploying the Proxy

To deploy the proxy you may use the [apigeetool](https://www.npmjs.com/package/apigeetool) utility.  After installing, run the following command from the root of this project, replacing the values for username, password and the Apigee org/env with the appropriate values for your setup.

```
apigeetool deployproxy -u youremail@example.com -p yourPassword -o orgName -e test -n ws-fed-saml-proxy -d .
```

## Support

This example is just an illustration. It is not a supported part of Apigee Edge.
If you have questions on it, or would like assistance with it, you can try
enquiring on [The Apigee Community Site](https://community.apigee.com).  There
is no service-level guarantee for responses to enquiries regarding this example.


## License

This material is copyright 2019 Google LLC.
and is licensed under the [Apache 2.0 License](LICENSE).

