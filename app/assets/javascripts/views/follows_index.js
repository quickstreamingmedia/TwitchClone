TwitchClone.Views.FollowsIndex = Backbone.View.extend({
  initialize: function(){
    var self = this;
    //this.listenTo(self.collection, "change", self.render)
    this.listenTo(self.collection, "change:status", self.notify)
    this.listenTo(self.collection, "add", self.render)
    this.listenTo(self.collection, "remove", self.render)
    //this.listenTo(self.collection, "fetch", self.render)
  },
  notify: function(model, value, options){
    var $notifications = $(".notifications");
    if (value != null){
      if (model.escape("page_logo_url")){
        var imgSrc = model.escape("page_logo_url");
      } else {
        var imgSrc = "http://upload.wikimedia.org/wikipedia/commons/a/a4/Socrates_Louvre.jpg";
      }
      var $img = "<img src=" + imgSrc + ">";
      var text = "<div class=notification-text>" + model.escape("username") + " changed status to: " + value + "</div>"
      var internal = "<div class=group>" + $img + text + "<br>" + "</div>"
      $notifications.append(internal);
      $notifications.css("display","block");
      window.setTimeout(function(){
        $notifications.css("display","none");
        $notifications.html("");
      },10000)

    }
    //console.log(model, value, options)
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