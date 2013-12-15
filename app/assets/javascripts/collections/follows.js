TwitchClone.Collections.Follows = Backbone.Collection.extend({
  initialize: function(obj){
    this.url = "users/" + obj.id + "/follows"
  },
  model: TwitchClone.Models.Follow

})