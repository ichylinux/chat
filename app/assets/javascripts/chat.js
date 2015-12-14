var chat = {};

chat.Client = function(options) {
  this.options = options;
};

chat.Client.prototype.start = function() {
  var that = this;

  $.get(that.options.index_path, {room_id: 1, format: 'json'}, function(logs) {
    that._render_logs(logs);
    setTimeout(function() {
      that.start();
    }, 1000);
  });
};

chat.Client.prototype._render_logs = function(logs) {
  if (logs.length > 0) {
    console.log(logs);
  }
};
