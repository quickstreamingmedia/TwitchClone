TwitchClone.Views.FollowsForm = Backbone.View.extend({
  initialize: function(obj){
    console.log(obj)
    this.followeeId = obj.followeeId,
    this.followClass = obj.followClass
    this.$el = obj.$el
    console.log(this.followClass)
  },
  events: {
    "click button.follow": "addFollow",
    "click button.unfollow": "destroyFollow"
  },
  addFollow: function(event){
    var self = this;
    event.preventDefault();
    var $button = $(event.currentTarget);
    var followeeId = $button.attr("data-id")*1;
    this.followClass = "unfollow";
    $.ajax({
      type: "POST",
      url: "/follows",
      data: { "followee_id": followeeId },
      success: function(resp){
        TwitchClone.Collections.follows.add(resp);
        self.render();
      }
    })
  },
  destroyFollow: function(event){
    var self = this;
    event.preventDefault();
    var $button = $(event.currentTarget);
    var followeeId = $button.attr("data-id")*1;
    this.followClass = "follow";
    $.ajax({
      type: "DELETE",
      url: "/follows/" + followeeId,
      success: function(resp){
        TwitchClone.Collections.follows.remove(TwitchClone.Collections.follows.findWhere({id: followeeId}))
        self.render();
      }
    })
  },
  render: function(){
    var self = this;
    var renderedContent = JST["follows_form"]({
      "followeeId": this.followeeId,
      "followClass": this.followClass
    })

    this.$el.html(renderedContent);
    if (this.followClass == "follow"){
      this.$el.removeClass("can-unfollow")
      this.$el.addClass("can-follow")
    } else {
      this.$el.removeClass("can-follow")
      this.$el.addClass("can-unfollow")
    }

    console.log("rendertime")
    console.log(this.$el)

    return this;
  }

});