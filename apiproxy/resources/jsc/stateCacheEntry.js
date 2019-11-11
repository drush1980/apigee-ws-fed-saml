var relayState = {
    issuer: context.getVariable('issuer'),
    acsURL: context.getVariable('acsURL')
};
context.setVariable('relayStateCacheEntry', JSON.stringify(relayState));