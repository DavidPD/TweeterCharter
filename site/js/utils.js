if (!Array.max) {
  Array.max = function(array) {
    return Math.max.apply(Math, array);
  };
}

if (!Array.min) {
  Array.min = function(array) {
    return Math.min.apply(Math, array);
  };
}

if (!Array.prototype.max) {
  Array.prototype.max = function() {
    return Array.max(this);
  };
}

if (!Array.prototype.min) {
  Array.prototype.min = function() {
    return Array.min(this);
  };
}

if (!Math.clamp) {
  Math.clamp = function(num, min, max) {
    return Math.max(min, Math.min(max, num));
  };
}
