TwitchClone.Views.CommentsIndex = Backbone.View.extend({
  initialize: function(obj){
    var self = this;
    this.$el = obj.$el
    this.comments_by_parent_id = obj.comments_by_parent_id
    this.listenTo(self.collection, "change", self.render);
    this.listenTo(self.collection, "add", self.render);
  },
  render: function(){
    var renderedContent = JST["comments_index"]({
      comments: this.collection,
      check_id: null,
      comments_by_parent_id: this.comments_by_parent_id
    });
    this.$el.html(renderedContent);
    return this;
  }
});