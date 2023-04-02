import Toybox.Lang;

// An efficient circular queue implementation that will store the most recently added X entries
class DataQueue {
  var data as Array;
  var trackAvg = false;
  var maxSize = 0;
  var pos = 0;
  var total = 0.0;
  var size = 0;

  function initialize(arraySize) {
    data = new [arraySize];
    maxSize = arraySize;
  }

  // Add a new element to the array
  function add(element) {
    data[pos] = element;
    pos = (pos + 1) % maxSize;
  }

  // Reset all the entries in the array to null
  function reset() {
    data = new [maxSize];
    pos = 0;
    total = 0.0;
    size = 0;
  }

  // Get the least recently added entry in the array
  function getOldest() {
    return data[pos] != null ? data[pos] : data[0];
  }

  // Get the most recently added entry in the array
  function getNewest() {
    return data[pos == 0 ? maxSize - 1 : (pos - 1) % maxSize];
  }
}
