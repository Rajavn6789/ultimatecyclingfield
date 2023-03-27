import Toybox.Activity;
using Toybox.Graphics as Gfx;
using Toybox.WatchUi as Ui;
using Toybox.Application as App;
import Toybox.Lang;

class ultimatecyclingView extends Ui.DataField {
  var kmOrMileInMetersDistance;

  // Settings
  var is24Hour;

  // Calculated values that change on every call to compute()
  var elapsedDistance;
  var elapsedTime;
  var currentCadence;
  var currentHeartRate;
  var currentSpeed;
  var battery;

  function initialize() {
    DataField.initialize();
  }

  // Display the value you computed here. This will be called
  // once a second when the data field is visible.
  function compute(info) {
    var myStats = System.getSystemStats();
    elapsedDistance =
      (info.elapsedDistance != null ? info.elapsedDistance : 0) / 1000.0f;
    elapsedTime = info.elapsedTime != null ? info.elapsedTime : 0;
    currentCadence = info.currentCadence != null ? info.currentCadence : 0;
    currentHeartRate = info.currentHeartRate != null ? info.currentHeartRate : 0;
    currentSpeed = info.currentSpeed != null ? info.currentSpeed : 0;
    battery  =  myStats.battery;
  }


  function onUpdate(dc) {
    var darkGreen = Gfx.COLOR_DK_GREEN;

    var labelFont = Gfx.FONT_SYSTEM_XTINY;
    var labelColor = Gfx.COLOR_LT_GRAY;

    var halfWidth = dc.getWidth() / 2;
    var VERT_OFFSET_ELE = dc.getHeight() * 0.25;
    var HOR_OFFSET_CAD = dc.getWidth() * 0.28;

    var elePosX = halfWidth - 40;
    var elePosY = 8;
    var grdPosX = halfWidth + 40;
    var grdPosY = 8;

    var backgroundColour = Gfx.COLOR_WHITE;

    dc.setColor(backgroundColour, backgroundColour);
    dc.fillRectangle(0, 0, dc.getWidth(), dc.getHeight());

    // Draw horizontal Lines
    dc.setColor(darkGreen, Gfx.COLOR_TRANSPARENT);
    dc.drawLine(0, VERT_OFFSET_ELE, dc.getWidth(), VERT_OFFSET_ELE);
    dc.drawLine(
      0,
      dc.getHeight() - VERT_OFFSET_ELE,
      dc.getWidth(),
      dc.getHeight() - VERT_OFFSET_ELE
    );

    // Draw vertical lines
    dc.drawLine(halfWidth, 0, halfWidth, VERT_OFFSET_ELE);
    dc.drawLine(
      halfWidth,
      dc.getHeight() - VERT_OFFSET_ELE,
      halfWidth,
      dc.getHeight()
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

    // Draw labels
    dc.setColor(labelColor, Gfx.COLOR_TRANSPARENT);

    // dc.drawText(elePosX, elePosY, labelFont, "DIS", Gfx.TEXT_JUSTIFY_CENTER);

    // dc.drawText(grdPosX, grdPosY, labelFont, "ELA", Gfx.TEXT_JUSTIFY_CENTER);

    dc.drawText(
      halfWidth - 28,
      dc.getHeight() - VERT_OFFSET_ELE + 4,
      labelFont,
      "GPS",
      Gfx.TEXT_JUSTIFY_CENTER
    );

    dc.drawText(
      halfWidth + 28,
      dc.getHeight() - VERT_OFFSET_ELE + 4,
      labelFont,
      "BAT",
      Gfx.TEXT_JUSTIFY_CENTER
    );

    dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);

    // GPS section
    dc.drawText(
      elePosX,
      elePosY + 20,
      Gfx.FONT_XTINY,
      formatDistance(elapsedDistance) + " km",
      Gfx.TEXT_JUSTIFY_CENTER
    );

    // Battery section
    dc.drawText(
      grdPosX,
      grdPosY + 20,
      Gfx.FONT_XTINY,
      formatElapsedTime(elapsedTime),
      Gfx.TEXT_JUSTIFY_CENTER
    );

    // Speed section
    dc.drawText(
      dc.getWidth() - HOR_OFFSET_CAD - 10,
      dc.getHeight() / 2 - 24,
      Gfx.FONT_XTINY,
      "k",
      Gfx.TEXT_JUSTIFY_CENTER
    );

    dc.drawText(
      dc.getWidth() - HOR_OFFSET_CAD - 10,
      dc.getHeight() / 2 - 12,
      Gfx.FONT_XTINY,
      "p",
      Gfx.TEXT_JUSTIFY_CENTER
    );

    dc.drawText(
      dc.getWidth() - HOR_OFFSET_CAD - 10,
      dc.getHeight() / 2 + 4,
      Gfx.FONT_XTINY,
      "h",
      Gfx.TEXT_JUSTIFY_CENTER
    );

    dc.drawText(
      halfWidth,
      dc.getHeight() / 2 - 44,
      Gfx.FONT_NUMBER_HOT,
      currentSpeed,
      Gfx.TEXT_JUSTIFY_CENTER
    );

    dc.drawText(
      halfWidth,
      VERT_OFFSET_ELE + 8,
      Gfx.FONT_XTINY,
      "35",
      Gfx.TEXT_JUSTIFY_CENTER
    );

    dc.drawText(
      halfWidth,
      dc.getHeight() / 2 + 32,
      Gfx.FONT_XTINY,
      "20",
      Gfx.TEXT_JUSTIFY_CENTER
    );

    dc.drawText(
      0 + 32,
      dc.getHeight() / 2 - 14,
      Gfx.FONT_MEDIUM,
      currentCadence,
      Gfx.TEXT_JUSTIFY_CENTER
    );

    dc.drawText(
      dc.getWidth() - 12,
      dc.getHeight() / 2 - 14,
      Gfx.FONT_MEDIUM,
      currentHeartRate,
      Gfx.TEXT_JUSTIFY_RIGHT
    );

    // GPS section
    dc.drawText(
      halfWidth - 28,
      dc.getHeight() - 36,
      Gfx.FONT_XTINY,
      "good",
      Gfx.TEXT_JUSTIFY_CENTER
    );

    // Battery section
    dc.drawText(
      halfWidth + 32,
      dc.getHeight() - 36,
      Gfx.FONT_XTINY,
      battery,
      Gfx.TEXT_JUSTIFY_CENTER
    );
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

  function formatElapsedTime(msValue) {
    var hours = msValue / 1000 / 60 / 60;
    var mins = (msValue / 1000 / 60) % 60;
    var secs = (msValue / 1000) % 60;
    var timeStr = Lang.format("$1:$2$:$3$", [
      hours.format("%01d"),
      mins.format("%02d"),
      secs.format("%02d"),
    ]);
    return timeStr;
  }
}
