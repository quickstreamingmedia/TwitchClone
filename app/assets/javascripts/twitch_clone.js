window.TwitchClone = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    var data = JSON.parse($("#bootstrapped_current_user_json").html());
    CURRENT_USER_ID = data["CURRENT_USER_ID"];
    //don't need global CURRENT_USER_ID?
    //rails should know
    if (CURRENT_USER_ID){
      TwitchClone.Collections.follows = new TwitchClone.Collections.Follows(data["FOLLOWS"],{sort:false})
      TwitchClone.Collections.follows.each(function(model, index){
        model.set({
          "page_logo_url": data["PAGES"][index]["logo_url"]
        })
      });
      TwitchClone.Collections.follows.sort();
      TwitchClone.Views.followsIndex = new TwitchClone.Views.FollowsIndex({
        "collection": TwitchClone.Collections.follows,
        "$el": $(".follows-area")
      });
      $(".follows-area").html(TwitchClone.Views.followsIndex.render().$el);
      var self = this;
      //UNCOMMENT THE LINE BELOW FOR A CONTINUOUS FOLLOWER CHECK
      //window.setInterval(self.refetch.bind(self), 45000);
    }
    //alert('Hello from Backbone!');
  },
  refetch: function(){
    TwitchClone.Collections.follows = new TwitchClone.Collections.Follows({id: CURRENT_USER_ID});
    TwitchClone.Collections.follows.fetch();
  }
};

$(document).ready(function(){
  TwitchClone.initialize();
});
