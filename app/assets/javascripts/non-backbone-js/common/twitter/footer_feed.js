$(document).ready(function () {
	var twitterBox = $(".col.twitter");
    $.getJSON("http://api.twitter.com/1/statuses/user_timeline.json?screen_name=jangalamarket&count=2&callback=?", function (tweetdata) {
		
        $.each(tweetdata, function (i, tweet) {
        	var created_date = parseDate(this.created_at);
        	
            tweet.text = tweet.text.replace(/(\b(https?|ftp|file):\/\/[-A-Z0-9+&@#\/%?=~_|!:,.;]*[-A-Z0-9+&@#\/%=~_|])/ig, function (url) {
                return '<a href="' + url + '">' + url + '</a>';
            })
            
            twitterBox.append("<article><p>" + tweet.text + "<br/><span>" + $.datepicker.formatDate('d M', new Date(created_date)) + "</span>" + "</p></article>\n");
        });

    });
    function parseDate(str) {
	    var v=str.split(' ');
	    return new Date(Date.parse(v[1]+" "+v[2]+", "+v[5]+" "+v[3]+" UTC"));
  	} 
});