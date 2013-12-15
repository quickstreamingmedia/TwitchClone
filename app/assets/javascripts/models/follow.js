TwitchClone.Models.Follow = Backbone.Model.extend({
  initialize: function(obj){
    this.url = "/users/" + obj.id + "/follows"
  }
})