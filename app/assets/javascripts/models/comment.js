TwitchClone.Models.Comment = Backbone.Model.extend({
  initialize: function(obj){
    this.url = "/videos/" + obj.id
  }
})