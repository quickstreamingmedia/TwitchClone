TwitchClone.Collections.Follows = Backbone.Collection.extend({
  //follows are really users!
  initialize: function(obj){
    this.url = "/users/" + CURRENT_USER_ID + "/follows"
  },
  model: TwitchClone.Models.Follow,
  comparator: function(obj1,obj2){
    var s1 = obj1.escape("status");
    var s2 = obj2.escape("status");
    if (s1 == "(LIVE)" && s2 == "(LIVE)"){
      return obj1.escape("sort_priority")*1 - obj2.escape("sort_priority")*1;
    } else if (s1 == "(LIVE)"){
      return -1;
    } else if (s2 == "(LIVE)"){
      return 1;
    } else {
      return obj1.escape("sort_priority")*1 - obj2.escape("sort_priority")*1;
    }

    // l1 = obj1.get("status") ? obj1.get("status").length : 0
//     l2 = obj2.get("status") ? obj2.get("status").length : 0
//     return l2 - l1
  }

})