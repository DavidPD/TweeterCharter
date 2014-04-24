var Chart;

Chart = (function() {
  function Chart(canvas, values) {
    var i, value, _i, _len, _ref,
      _this = this;
    this.canvas = canvas;
    this.values = values;
    this.ctx = this.canvas.getContext('2d');
    this.height = this.canvas.height - 40;
    this.width = this.canvas.width - 40;
    this.ctx.translate(20, 20);
    this.maxValue = 0;
    this.points = [];
    _ref = this.values;
    for (i = _i = 0, _len = _ref.length; _i < _len; i = ++_i) {
      value = _ref[i];
      if (value.count > this.maxValue) {
        this.maxValue = value.count;
      }
      this.points.push({
        x: this.width / (this.values.length - 1) * i,
        y: this.height - (value.count / this.maxValue) * this.height
      });
    }
    ($(canvas)).on('mousemove', function(e) {
      return _this.mouseMoved(e);
    });
    ($(canvas)).on('mouseout', function(e) {
      return _this.mouseOut(e);
    });
  }

  Chart.prototype.draw = function() {
    var point, _i, _len, _ref;
    this.clearCanvas();
    this.ctx.beginPath();
    /*for value, i in @values
    			x = @width / @values.length * i
    			y = @height - (value.count / @maxValue) * @height
    			@ctx.lineTo x, y
    */

    _ref = this.points;
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      point = _ref[_i];
      this.ctx.lineTo(point.x, point.y);
    }
    this.ctx.strokeStyle = 'black';
    this.ctx.lineWidth = 3;
    return this.ctx.stroke();
  };

  Chart.prototype.clearCanvas = function() {
    return this.ctx.clearRect(-20, -20, this.canvas.width, this.canvas.width);
  };

  Chart.prototype.mouseMoved = function(e) {
    var nearestCount, nearestPoint, nearestPointIndex, pointDiffs, pos;
    pos = this.getParentOffset(e);
    pos.x -= 20;
    pos.y -= 20;
    pointDiffs = this.points.map(function(p) {
      return Math.abs(p.x - pos.x);
    });
    nearestPointIndex = pointDiffs.indexOf(pointDiffs.min());
    nearestPoint = this.points[nearestPointIndex];
    nearestCount = this.values[nearestPointIndex].count;
    this.draw();
    this.ctx.beginPath();
    this.ctx.moveTo(nearestPoint.x, 0);
    this.ctx.lineTo(nearestPoint.x, this.height);
    this.ctx.strokeStyle = 'grey';
    this.ctx.lineWidth = 2;
    this.ctx.stroke();
    this.ctx.font = '15px sans-serif';
    return this.ctx.fillText(nearestCount, Math.clamp(nearestPoint.x, 20, this.width - 20), this.height - this.height / 2);
  };

  Chart.prototype.mouseOut = function(e) {
    return this.draw();
  };

  Chart.prototype.getParentOffset = function(e) {
    var parentOffset;
    parentOffset = ($(this.canvas)).parent().offset();
    return {
      x: e.pageX - parentOffset.left,
      y: e.pagY - parentOffset.top
    };
  };

  return Chart;

})();
