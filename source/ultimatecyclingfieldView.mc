import Toybox.Activity;
using Toybox.Graphics as Gfx;
using Toybox.WatchUi as Ui;
import Toybox.Lang;

class ultimatecyclingfieldView extends Ui.DataField {
  // Calculated values that change on every call to compute()

  function initialize() {
    DataField.initialize();
  }

  // Display the value you computed here. This will be called
  // once a second when the data field is visible.
  function compute(info) {}

  function onUpdate(dc) {
    var darkGreen = Gfx.COLOR_DK_GREEN;
    var lightGreen = Gfx.COLOR_GREEN;

    var labelFont = Gfx.FONT_SYSTEM_XTINY;
    var labelColor = Gfx.COLOR_LT_GRAY;

    var halfWidth = dc.getWidth() / 2;
    var VERT_OFFSET_ELE = dc.getHeight() * 0.25;
    var HOR_OFFSET_CAD = dc.getWidth() * 0.28;

    var elePosX = halfWidth - 32;
    var elePosY = 10;
    var grdPosX = halfWidth + 32;
    var grdPosY = 10;

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

    dc.drawText(elePosX, elePosY, labelFont, "CLK", Gfx.TEXT_JUSTIFY_CENTER);

    dc.drawText(grdPosX, grdPosY, labelFont, "DIS", Gfx.TEXT_JUSTIFY_CENTER);

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
      "6:28pm",
      Gfx.TEXT_JUSTIFY_CENTER
    );

    // Battery section
    dc.drawText(
      grdPosX,
      grdPosY + 20,
      Gfx.FONT_XTINY,
      "11 km",
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
      "25",
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
      "87",
      Gfx.TEXT_JUSTIFY_CENTER
    );

    dc.drawText(
      dc.getWidth() - 12,
      dc.getHeight() / 2 - 14,
      Gfx.FONT_MEDIUM,
      "120",
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
      "92.6%",
      Gfx.TEXT_JUSTIFY_CENTER
    );
  }
}
