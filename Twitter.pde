import twitter4j.conf.*;
import twitter4j.*;
import twitter4j.auth.*;
import twitter4j.api.*;
import java.util.*;

Twitter twitter;
TwitterStream twitterStream;

void setupTwitter(){
  ConfigurationBuilder cb = new ConfigurationBuilder();
  cb.setOAuthConsumerKey("NmWP8G7FnFcaXp7GFCYVGLWrx");
  cb.setOAuthConsumerSecret("GeP0ZGiDHK1Uf3YBREG3X8O29kLun4j5UWn4234e3dEJDsPApE");
  cb.setOAuthAccessToken("725566959559925761-N22762CPcZQpCFm4E4RfULGN5m6iovh");
  cb.setOAuthAccessTokenSecret("MYW6K221HQBGsGq7hCUnES2ULMPhFpFocMbIreuDDB4wW");
  
  Configuration cg = cb.build();
  TwitterFactory tf = new TwitterFactory(cg);
  twitter = tf.getInstance();
  twitterStream = new TwitterStreamFactory(cg).getInstance();

  twitterStream.addListener(new StatusListener() {
    
    @Override
    public void onStatus(Status status) {
      System.out.println("@" + status.getUser().getScreenName() + " - " + status.getText());
      animation = !animation;
      mousePressed();
    }

    @Override
    public void onDeletionNotice(StatusDeletionNotice statusDeletionNotice) {
      System.out.println("Got a status deletion notice id:" + statusDeletionNotice.getStatusId());
    }

    @Override
    public void onTrackLimitationNotice(int numberOfLimitedStatuses) {
      System.out.println("Got track limitation notice:" + numberOfLimitedStatuses);
    }

    @Override
    public void onScrubGeo(long userId, long upToStatusId) {
      System.out.println("Got scrub_geo event userId:" + userId + " upToStatusId:" + upToStatusId);
    }

    @Override
    public void onStallWarning(StallWarning warning) {
      System.out.println("Got stall warning:" + warning);
    }

    @Override
    public void onException(Exception ex) {
      ex.printStackTrace();
    }
    });

    FilterQuery tweetFilterQuery = new FilterQuery(); // See 
    tweetFilterQuery.track(new String[]{"participationplus"}); // OR on keywords
    twitterStream.filter(tweetFilterQuery);

}

void sendTweet(Entry[] args){
  
  if(twitterMode){
    String tweet = "NEXT:";
    String names = "";
    int numberTwitterUser = 0;
    for(int i=0; i<args.length; i++){
      if(args[i].twitterName != ""){
        names += " @"+args[i].twitterName;
        numberTwitterUser++;
      };  
    }
  
    for(int i=0; i<args.length; i++){
      int length = 0;
      if(args[i].message.length()>(140-names.length()-17)/numberTwitterUser){
        length = (140-names.length()-17)/numberTwitterUser;
      }else{
        length = args[i].message.length();
      }
      tweet += "+"+args[i].message.substring(0, length);
    }
  
    tweet += names;
  
    try{
      Status status = twitter.updateStatus(tweet);
    } catch (TwitterException te) {
      System.out.println("Failed to get timeline: " + te.getMessage());
    }
  }
}