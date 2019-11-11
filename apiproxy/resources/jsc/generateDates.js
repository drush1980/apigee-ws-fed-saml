function addMinutes(d,m) {
  var d1 = new Date();
  d1.setTime(d.getTime() + m * 60 * 1000); 
  return d1;
}

function subtractMinutes(d,m) {
  var d1 = new Date();
  d1.setTime(d.getTime() - m * 60 * 1000); 
  return d1;
}

var now = new Date();
var earlier = subtractMinutes(now, 5); 
var later = addMinutes(now, 5); 

//var dateFormatted = later.getFullYear() + "-" + later.getMonth() + "-" + later.getDay() + "T" + later.getHours() + ":" + later.getMinutes() + ":" + later.getSeconds() + "Z";
context.setVariable("saml.now", dateFormat(now, "isoUtcDateTime"));
context.setVariable("saml.notBefore", dateFormat(earlier, "isoUtcDateTime"));
context.setVariable("saml.notOnOrAfter", dateFormat(later, "isoUtcDateTime"));