# SAML Web SSO flow to WS-Federation Passive Requestor Proxy

This is an Apigee API Proxy that converts between a [SAML 2.0 browser POST profile](https://docs.oasis-open.org/security/saml/v2.0/saml-profiles-2.0-os.pdf_) SP initiated SSO flow and a [WS-Federation Passive Requestor flow](http://docs.oasis-open.org/wsfed/federation/v1.2/os/ws-federation-1.2-spec-os.html#_Toc223175004).  Upon receiving a SAML authn request the proxy will forward the request to a designated WS-Federation IP/STS endpoint.  Upon a successful login at the IdP the proxy will receive the WS-Federation sign in response which must contain a valid SAML assertion. The proxy will validate the assertion, then create a new assertion & response envelope suitable for a SAML 2 SSO flow, before triggering a browser POST to the designated assertion consumer service URL at the SAML SP.


## Disclaimer

This example is not an official Google product, nor is it part of an official Google product.


## Notes

* In this sample the entity ID of the SAML SP issuing the authn request is used as the WS-Fed security realm value.
* The SAML response envelope created by the proxy is not signed. The assertion created by the proxy is signed however, and will be validated at the SP.
* In this sample the WS-Fed IP/STS endpoint is configured in an Apigee KVM named `federationInfo`.  This can be changed as desired or hardcoded values could be used instead.
* The Destination and AssertionConsumerService endpoints are passed by the SAML SP in the AuthnRequest, and are used for the remainder of the flow.
* This proxy only supports SP initiated flows. Attemping to pass in an unsolicited request to the `/callback` path will fail.


## Setup

You will need an Apigee Edge login to use this proxy.  If you don't have one you may sign up for a trial account [here](https://login.apigee.com/sign__up).

Before exercising this proxy, you need to:

1. Create a named cache entry in Apigee Edge called `RELAYSTATE_CACHE`.  Set the default expiry time to one hour. This cache is used to maintain state of the request and response context.

2. Deploy the proxy bundle to your Apigee Edge environment.

3. Create a SAML IdP connection in your SAML Service Provider (SP) system and obtain the metadata, including the entity ID and ACS URL at a minimum.  For the SAML sign in URL, use the Apigee proxy basepath + `/auth`, for example `https://orgname-test.apigee.net/v1/ws-fed-saml-proxy/auth`

4. Configure a WS-Federation passive requestor IP/STS endpoint in a system of your choice, for example in [Okta](https://help.okta.com/en/prod/Content/Topics/Apps/Apps_Configure_Okta%20Template_WS_Federation.htm), using the values from the previous step.  Associate with a user account if necessary.

5. Create a [truststore entry](https://docs.apigee.com/api-platform/system-administration/creating-keystores-and-truststore-cloud-using-edge-ui) in Apigee Edge named `IDPKS` and [upload the certificate](https://docs.apigee.com/api-platform/system-administration/creating-keystores-and-truststore-cloud-using-edge-ui#creating-an-alias-from-a-cert-truststore-only) containing the public key used by the IdP to sign assertions.

6. Create or obtain an existing keypair, and [upload the key and certificate](https://docs.apigee.com/api-platform/system-administration/creating-keystores-and-truststore-cloud-using-edge-ui#creating-an-alias-from-a-cert-and-key-keystore-only) with the alias `signingkey`. This will be used by the proxy to sign the assertions that will be sent to the SAML SP.  Note this can be the same as the IdP keypair if you have access to it.

7. Update the SAML SP configuration with the ***IdP's*** entity ID and the signing certificate specified in ***step 6***.  Note you **must** use the certificate as configured in step 6 here.

8. Create a [KVM](https://docs.apigee.com/api-platform/cache/key-value-maps) named `federationInfo` in your Apigee environment.  Add a key named `idpEndpoint` with the value of the WS-Fed IP/STS URL.

9. Trigger an SP initiated SAML login flow.


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

