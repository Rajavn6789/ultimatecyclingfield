import Toybox.Activity;
using Toybox.Graphics as Gfx;
using Toybox.WatchUi as Ui;
using Toybox.System as Sys;
// using Toybox.UserProfile as User;
import Toybox.Lang;

class UltimateCyclingFieldView extends Ui.DataField {
  var elapsedDistance;

  var currentSpeed;
  var averageSpeed;
  var maxSpeed;

  var currentCadence;
  var averageCadence;

  var currentHeartRate;
  var averageHeartRate;

  hidden var hrZones = [92, 110, 128, 147, 156];

  var clockTime;

  function initialize() {
    DataField.initialize();
  }

  function compute(info) {
    elapsedDistance =
      (info.elapsedDistance != null ? info.elapsedDistance : 0) / 1000;

    currentSpeed = (info.currentSpeed != null ? info.currentSpeed : 0) * 3.6;
    averageSpeed = (info.averageSpeed != null ? info.averageSpeed : 0) * 3.6;
    maxSpeed = (info.maxSpeed != null ? info.maxSpeed : 0) * 3.6;

    currentCadence = info.currentCadence != null ? info.currentCadence : 0.0;
    averageCadence = info.averageCadence != null ? info.averageCadence : 0.0;

    currentHeartRate =
      info.currentHeartRate != null ? info.currentHeartRate : 0.0;
    averageHeartRate =
      info.averageHeartRate != null ? info.averageHeartRate : 0.0;
  }

  function onUpdate(dc) {
    var darkGreen = Gfx.COLOR_DK_GREEN;
    var halfWidth = dc.getWidth() / 2;
    var halfHeight = dc.getHeight() / 2;
    var VERT_OFFSET_ELE = dc.getHeight() * 0.2;
    var HOR_OFFSET_CAD = dc.getWidth() * 0.28;
    var CAD_HR_VALUE_HORI_OFFSET = 36;
    var DIS_TIME_VER_OFFSET = 16;

    var HR_POSX = dc.getWidth() - CAD_HR_VALUE_HORI_OFFSET;
    var CAD_POSX = 0 + CAD_HR_VALUE_HORI_OFFSET;

    var backgroundColour = Gfx.COLOR_WHITE;

    clockTime = Sys.getClockTime();

    var speedColor;
    if (currentSpeed >= 20) {
      speedColor = darkGreen;
    } else {
      speedColor = Gfx.COLOR_BLACK;
    }

    dc.setColor(backgroundColour, backgroundColour);
    dc.fillRectangle(0, 0, dc.getWidth(), dc.getHeight());

    // Draw  Lines
    dc.setColor(darkGreen, Gfx.COLOR_TRANSPARENT);
    dc.drawLine(0, VERT_OFFSET_ELE, dc.getWidth(), VERT_OFFSET_ELE);
    dc.drawLine(
      0,
      dc.getHeight() - VERT_OFFSET_ELE,
      dc.getWidth(),
      dc.getHeight() - VERT_OFFSET_ELE
    );

    dc.drawLine(
      HOR_OFFSET_CAD,
      VERT_OFFSET_ELE,
      HOR_OFFSET_CAD,
      dc.getHeight() - VERT_OFFSET_ELE
    );
    dc.drawLine(
      dc.getWidth() - HOR_OFFSET_CAD,
      VERT_OFFSET_ELE,
      dc.getWidth() - HOR_OFFSET_CAD,
      dc.getHeight() - VERT_OFFSET_ELE
    );

    dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);

    // Distance section
    dc.drawText(
      halfWidth,
      DIS_TIME_VER_OFFSET,
      Gfx.FONT_TINY,
      formatDistance(elapsedDistance) + " km",
      Gfx.TEXT_JUSTIFY_CENTER
    );

    // Speed Section
    dc.setColor(speedColor, Gfx.COLOR_TRANSPARENT);
    dc.drawText(
      halfWidth - 4,
      halfHeight - 44,
      Gfx.FONT_NUMBER_HOT,
      currentSpeed.format("%d"),
      Gfx.TEXT_JUSTIFY_CENTER
    );

    dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);

    dc.drawText(
      halfWidth,
      VERT_OFFSET_ELE + 12,
      Gfx.FONT_TINY,
      "max: " + maxSpeed.format("%.1f"),
      Gfx.TEXT_JUSTIFY_CENTER
    );

    dc.drawText(
      halfWidth,
      halfHeight + 36,
      Gfx.FONT_TINY,
      "avg: " + averageSpeed.format("%.1f"),
      Gfx.TEXT_JUSTIFY_CENTER
    );

    drawKPH(dc, halfWidth + 40, halfHeight);

    // Cadence Section
    drawFieldWIthVal(
      dc,
      CAD_POSX,
      VERT_OFFSET_ELE + 16,
      "CAD",
      currentCadence.format("%d")
    );

    drawFieldWIthVal(
      dc,
      CAD_POSX,
      VERT_OFFSET_ELE + 16 + 60,
      "avg",
      averageCadence.format("%d")
    );

    // Heart Rate Section
    drawFieldWIthVal(
      dc,
      HR_POSX,
      VERT_OFFSET_ELE + 16,
      "HR",
      currentHeartRate.format("%d")
    );

    drawFieldWIthVal(
      dc,
      HR_POSX,
      VERT_OFFSET_ELE + 16 + 60,
      "avg",
      averageHeartRate.format("%d")
    );

    // Time section
    dc.drawText(
      halfWidth,
      dc.getHeight() - DIS_TIME_VER_OFFSET - 24,
      Gfx.FONT_TINY,
      formatTime(clockTime),
      Gfx.TEXT_JUSTIFY_CENTER
    );
  }

  function formatTime(clockTime) {
    var hour = clockTime.hour;
    var ampm = "";
    //handle midnight and noon, which return as 0
    hour = clockTime.hour % 12 == 0 ? 12 : clockTime.hour % 12;
    ampm = clockTime.hour >= 12 && clockTime.hour < 24 ? " pm" : " am";

    var timeString = Lang.format("$1$:$2$$3$", [
      hour.format("%02d"),
      clockTime.min.format("%02d"),
      ampm,
    ]);
    return timeString;
  }

  function formatDistance(distance) {
    if (distance != null && distance > 0) {
      if (distance >= 1000) {
        return distance.format("%d");
      } else if (distance >= 100) {
        return distance.format("%.1f");
      } else {
        return distance.format("%.2f");
      }
    } else {
      return "0.00";
    }
  }

  function drawKPH(dc, x, y) {
    dc.setColor(Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT);
    dc.drawText(x, y - 24, Gfx.FONT_XTINY, "k", Gfx.TEXT_JUSTIFY_CENTER);
    dc.drawText(x, y - 12, Gfx.FONT_XTINY, "p", Gfx.TEXT_JUSTIFY_CENTER);

    dc.drawText(x, y + 4, Gfx.FONT_XTINY, "h", Gfx.TEXT_JUSTIFY_CENTER);
    dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
  }

  function drawFieldWIthVal(dc, x, y, label, val) {
    // label
    dc.setColor(0x026e1f, Gfx.COLOR_TRANSPARENT);
    dc.drawText(x, y, Gfx.FONT_XTINY, label, Gfx.TEXT_JUSTIFY_CENTER);

    //value
    dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
    dc.drawText(x, y + 16, Gfx.FONT_SMALL, val, Gfx.TEXT_JUSTIFY_CENTER);
  }
}
