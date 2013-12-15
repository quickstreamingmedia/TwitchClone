TwitchClone.Collections.Comments = Backbone.Collection.extend({
  initialize: function(obj){
    this.url = "/videos/" + obj.id
  },
  model: TwitchClone.Models.Comment,
});