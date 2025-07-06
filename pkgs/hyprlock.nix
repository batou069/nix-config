{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
      };

      label = {
        text = "$TIME";
        font_size = 96;
        font_family = "Maple Mono NF";
        color = "rgba(235, 219, 178, 1.0)";
        position = "0, 600";
        halign = "center";

        shadow_passes = 1;
      };

      background = [
        {
          path = "screenshot";
          blur_passes = 4;
          blur_size = 12;
        }
      ];

      input-field = [
        {
          size = "200, 50";
          position = "0, -80";
          monitor = "";
          dots_center = true;
          font_color = "rgb(235, 219, 178)";
          inner_color = "rgb(40, 40, 40)";
          outer_color = "rgb(60, 56, 54)";
          outline_thickness = 5;
          placeholder_text = "sussy baka";
          shadow_passes = 1;
        }
      ];
    };
  };
}
