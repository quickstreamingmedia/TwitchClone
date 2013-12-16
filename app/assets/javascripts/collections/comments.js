TwitchClone.Collections.Comments = Backbone.Collection.extend({
  initialize: function(obj){
    console.log(obj.video_id)
    this.url = "/videos/" + videoId + "/comments"
  },
  model: TwitchClone.Models.Comment,
});