var chat = {};

chat.Client = function(options) {
  this.options = options;
  
  var now = new Date();
  this.datetime_from = new Date(now.getFullYear(), now.getMonth(), now.getDate(), 0, 0, 0);
  this.datetime_to = now;
};

chat.Client.prototype.start = function(callback) {
  var next_datetime = new Date();
  var params = {
    datetime_from: this._format_datetime(this.datetime_from),
    datetime_to: this._format_datetime(this.datetime_to)
  };

  var that = this;
  $.get(that.options.index_path, params, function(logs) {
    that._render_logs(logs);
    that.datetime_from = that.datetime_to;
    that.datetime_to = next_datetime;

    if (callback) {
      callback.call();
    }
    
    that.tick = setTimeout(function() {
      that.start();
    }, 1000);
  });
};

chat.Client.prototype.send_message = function() {
  var message = $('#m').val();
  if (message) {
    var params = {
      name: 'Tarou',
      message: message
    };
    
    if (this.tick) {
      clearTimeout(this.tick);
      this.tick = null;
    }

    var that = this;
    $.post(that.options.index_path, params, function() {
      that.start(function() {
        $('#m').val('');
      });
    });
  }
};

chat.Client.prototype._render_logs = function(logs) {
  if (logs.length > 0) {
    var ul = $('#messages');
    for (var i = 0; i < logs.length; i ++) {
      var log = logs[i];
      ul.append('<li><div class="who">' + log.name + '</div><div>' + log.message + '</div></li>');
    }
    
    var diff = $(document).height() - $(window).height() + 20;
    if (diff > 0) {
      $(window).scrollTop(diff);
    }
  }
};

chat.Client.prototype._format_datetime = function(datetime) {
  var y = datetime.getFullYear();
  var m = datetime.getMonth() + 1;
  var d = datetime.getDate();
  var H = datetime.getHours();
  var M = datetime.getMinutes();
  var S = datetime.getSeconds();

  m = ('0' + m).slice(-2);
  d = ('0' + d).slice(-2);
  H = ('0' + H).slice(-2);
  M = ('0' + M).slice(-2);
  S = ('0' + S).slice(-2);

  // フォーマット整形済みの文字列を戻り値にする
  return y + '-' + m + '-' + d + ' ' + H + ':' + M + ':' + S;
};
