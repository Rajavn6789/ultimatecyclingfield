import Toybox.Activity;
using Toybox.Graphics as Gfx;
using Toybox.WatchUi as Ui;
import Toybox.Lang;

class ultimatecyclingfieldView extends Ui.DataField {
  var currentSpeed;

  function initialize() {
    DataField.initialize();
  }

  function compute(info) {
    currentSpeed = (info.currentSpeed != null ? info.currentSpeed : 0) * 3.6;

  }

  function onUpdate(dc) {
    var darkGreen = Gfx.COLOR_DK_GREEN;
    var halfWidth = dc.getWidth() / 2;
    var VERT_OFFSET_ELE = dc.getHeight() * 0.2;
    var HOR_OFFSET_CAD = dc.getWidth() * 0.28;
    var CAD_HR_VALUE_HORI_OFFSET = 36;
    var DIS_TIME_VER_OFFSET = 16;

    var backgroundColour = Gfx.COLOR_WHITE;

    var speedColor;
    if (currentSpeed > 5 ) {
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
      "11.45 km",
      Gfx.TEXT_JUSTIFY_CENTER
    );

    // Speed section
    // dc.drawText(
    //   dc.getWidth() - HOR_OFFSET_CAD - 12,
    //   dc.getHeight() / 2 - 24,
    //   Gfx.FONT_XTINY,
    //   "k",
    //   Gfx.TEXT_JUSTIFY_CENTER
    // );

    // dc.drawText(
    //   dc.getWidth() - HOR_OFFSET_CAD - 12,
    //   dc.getHeight() / 2 - 12,
    //   Gfx.FONT_XTINY,
    //   "p",
    //   Gfx.TEXT_JUSTIFY_CENTER
    // );

    // dc.drawText(
    //   dc.getWidth() - HOR_OFFSET_CAD - 12,
    //   dc.getHeight() / 2 + 4,
    //   Gfx.FONT_XTINY,
    //   "h",
    //   Gfx.TEXT_JUSTIFY_CENTER
    // );

    dc.setColor(speedColor, Gfx.COLOR_TRANSPARENT);
    dc.drawText(
      halfWidth - 4,
      dc.getHeight() / 2 - 44,
      Gfx.FONT_NUMBER_HOT,
      currentSpeed.format("%d"),
      Gfx.TEXT_JUSTIFY_CENTER
    );

    dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);

    dc.drawText(
      halfWidth,
      VERT_OFFSET_ELE + 16,
      Gfx.FONT_XTINY,
      "35.8" + " kph",
      Gfx.TEXT_JUSTIFY_CENTER
    );

    dc.drawText(
      halfWidth,
      dc.getHeight() / 2 + 36,
      Gfx.FONT_XTINY,
      "20.4" + " kph",
      Gfx.TEXT_JUSTIFY_CENTER
    );

    // Cadence

    dc.drawText(
      0 + CAD_HR_VALUE_HORI_OFFSET,
      dc.getHeight() / 2 - 36,
      Gfx.FONT_XTINY,
      "130",
      Gfx.TEXT_JUSTIFY_CENTER
    );

    dc.drawText(
      0 + CAD_HR_VALUE_HORI_OFFSET,
      dc.getHeight() / 2 + 24,
      Gfx.FONT_XTINY,
      "80",
      Gfx.TEXT_JUSTIFY_CENTER
    );

    dc.drawText(
      0 + CAD_HR_VALUE_HORI_OFFSET,
      dc.getHeight() / 2 - 14,
      Gfx.FONT_LARGE,
      "87",
      Gfx.TEXT_JUSTIFY_CENTER
    );

    // Heart Rate

    dc.drawText(
      dc.getWidth() - CAD_HR_VALUE_HORI_OFFSET,
      dc.getHeight() / 2 - 36,
      Gfx.FONT_XTINY,
      "150",
      Gfx.TEXT_JUSTIFY_CENTER
    );

    dc.drawText(
      dc.getWidth() - CAD_HR_VALUE_HORI_OFFSET,
      dc.getHeight() / 2 + 24,
      Gfx.FONT_XTINY,
      "120",
      Gfx.TEXT_JUSTIFY_CENTER
    );

    dc.drawText(
      dc.getWidth() - CAD_HR_VALUE_HORI_OFFSET,
      dc.getHeight() / 2 - 14,
      Gfx.FONT_MEDIUM,
      "130",
      Gfx.TEXT_JUSTIFY_CENTER
    );

    // Time section
    dc.drawText(
      halfWidth,
      dc.getHeight() - DIS_TIME_VER_OFFSET - 24,
      Gfx.FONT_TINY,
      "10:20" + " pm",
      Gfx.TEXT_JUSTIFY_CENTER
    );
  }
}
