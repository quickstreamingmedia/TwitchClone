TwitchClone.Models.Comment = Backbone.Model.extend({
  initialize: function(obj){//videoId is set globally on videos#show view
    this.url = "/videos/" + videoId + "/comments"
  }
})