TwitchClone.Views.CommentsIndex = Backbone.View.extend({
  initialize: function(obj){
    var self = this;
    this.$el = obj.$el
    this.comments_by_parent_id = obj.comments_by_parent_id
    this.listenTo(self.collection, "change", self.render);
    this.listenTo(self.collection, "add", self.render);
    this.expandedComments = [];
  },
  events:{
    "click a.exp-col": "toggleExpCol",
    "click a.reply" : "replyForm",
    "click button.replyButton" : "submitReply",
    "click button.newCommentButton": "submitNew"
  },
  submitNew: function(event){
    event.preventDefault();
    if (!CURRENT_USER_ID){ return null };

    var $button = $(event.currentTarget);
    var $textArea = $(".taNew");
    comment = new TwitchClone.Models.Comment({
      body:$textArea.val(),
      parent_id:null
    });
    comment.save({
      success: function(resp){
        comment.set({
          username:resp.username,
          page_logo_url:resp.page_logo_url
        })
      }
    });
    this.collection.add(comment);
    $textArea.val("");
  },
  submitReply: function(event){
    event.preventDefault();
    if (!CURRENT_USER_ID){ return null };

    var $button = $(event.currentTarget);
    var commentId = $button.attr("data-id")*1;
    var $textArea = $(".ta-" + commentId + "");
    comment = new TwitchClone.Models.Comment({
      body:$textArea.val(),
      parent_id:commentId
    });
    comment.save({
      success: function(resp){
        comment.set({
          username:resp.username,
          page_logo_url:resp.page_logo_url
        })
      }
    });
    if (!this.comments_by_parent_id[commentId + ""]){
      this.comments_by_parent_id[commentId + ""] = [comment];
    }
    if (this.expandedComments.indexOf(commentId) < 0){
      this.expandedComments.push(commentId);
    }
    this.collection.add(comment);

    $textArea.val("");
    var $replyDiv = $(".replyBox-" + commentId + "");
    $replyDiv.css("display","none");
  },
  replyForm: function(event){
    event.preventDefault();
    var $a = $(event.currentTarget);
    var $li = $a.closest("li");
    var commentId = $li.attr("data-id")*1;
    var $replyDiv = $(".replyBox-" + commentId + "");
    $replyDiv.css("display","block");
  },
  render: function(){
    var renderedContent = JST["comments_index"]({
      comments: this.collection,
      check_id: null,
      comments_by_parent_id: this.comments_by_parent_id,
      expandedComments: this.expandedComments
    });
    this.$el.html(renderedContent);
    return this;
  },
  toggleExpCol: function(event){
    event.preventDefault();
    var $a = $(event.currentTarget);
    var $li = $a.closest("li");
    var commentId = $li.attr("data-id")*1;
    if (this.expandedComments.indexOf(commentId) >= 0){
      var idx = this.expandedComments.indexOf(commentId);
      this.expandedComments.splice(idx,1);
      //$a.html("+");
    } else {
      this.expandedComments.push(commentId);
      //$a.html("-");
    }
    this.render();
  }
});