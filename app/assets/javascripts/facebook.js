window.fbAsyncInit = function() {
  // init the FB JS SDK
  FB.init({
    appId      : '1881845702141870', // App ID from the App Dashboard
    status     : true, // check the login status upon init?
    cookie     : true, // set sessions cookies to allow your server to access the session?
    xfbml      : true  // parse XFBML tags on this page?
  });

  // Additional initialization code such as adding Event Listeners goes here

};

function postToFeed(url){
  FB.ui({
    method: 'feed',
    link: 'http://www.letterloose.com' + url,
  }, function(response){
    console.log(response);
  });

  ga('send', 'event', 'social', 'share', 'Facebook');
};

// Load the SDK's source Asynchronously
(function(d){
   var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
   if (d.getElementById(id)) {return;}
   js = d.createElement('script'); js.id = id; js.async = true;
   js.src = "//connect.facebook.net/en_US/all.js";
   ref.parentNode.insertBefore(js, ref);
 }(document));
