TwitchClone.Views.FollowsIndex = Backbone.View.extend({
  initialize: function(){
    var self = this;
    this.listenTo(self.collection, "change", self.render)
    this.listenTo(self.collection, "add", self.render)
    this.listenTo(self.collection, "remove", self.render)
    //this.listenTo(self.collection, "fetch", self.render)
  },

  render: function(){
    var self = this;
    var renderedContent = JST["follows_index"]({
      follows: this.collection
    })

    this.$el.html(renderedContent);
    return this;
  }
})