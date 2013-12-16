TwitchClone.Collections.Follows = Backbone.Collection.extend({
  //follows are really users!
  initialize: function(obj){
    this.url = "/users/" + CURRENT_USER_ID + "/follows"
  },
  model: TwitchClone.Models.Follow,
  comparator: function(obj1,obj2){
    l1 = obj1.get("status") ? obj1.get("status").length : 0
    l2 = obj2.get("status") ? obj2.get("status").length : 0
    return l2 - l1
  }

})