{
  username,
  config,
  ...
}: {
  services.mpd = {
    enable = true;
    dataDir = "/home/${username}/Music";
    musicDirectory = "/home/${username}/Music";
    # fluidsynth = true;
    network.listenAddress = "any";
    network.startWhenNeeded = true;
    # user = "userRunningPipeWire";
    extraConfig = ''
        audio_output {
          type "pipewire"
          name "My PipeWire"
        }
        password: None
        volume_step: 5
        max_fps: 30
        scrolloff: 0
        wrap_navigation: false
        enable_mouse: true
        status_update_interval_ms: 1000
        select_current_song_on_change: false
        browser_column_widths: [20, 38, 42]
        album_art: (
            method: Auto
            max_size_px: (width: 900, height: 900)
            vertical_align: Top
            horizontal_align: Center
        )
        keybinds: (
            global: {
                ":":       CommandMode
                ",":       VolumeDown
                "s":       Stop
                ".":       VolumeUp
                "<Tab>":   NextTab
                "<S-Tab>": PreviousTab
                "1":       SwitchToTab("Queue")
                "2":       SwitchToTab("Artists")
                "3":       SwitchToTab("Albums")
                "4":       SwitchToTab("Search")
                "5":       SwitchToTab("Directories")
                "6":       SwitchToTab("Lyrics")
                "q":       Quit
                ">":       NextTrack
                "p":       TogglePause
                "<":       PreviousTrack
                "f":       SeekForward
                "z":       ToggleRepeat
                "x":       ToggleRandom
                "c":       ToggleConsume
                "v":       ToggleSingle
                "b":       SeekBack
                "~":       ShowHelp
                "I":       ShowCurrentSongInfo
                "O":       ShowOutputs
                "P":       ShowDecoders
            },
            navigation: {
                "k":         Up
                "j":         Down
                "h":         Left
                "l":         Right
                "<Up>":      Up
                "<Down>":    Down
                "<Left>":    Left
                "<Right>":   Right
                "<C-k>":     PaneUp
                "<C-j>":     PaneDown
                "<C-h>":     PaneLeft
                "<C-l>":     PaneRight
                "<C-u>":     UpHalf
                "N":         PreviousResult
                "a":         Add
                "A":         AddAll
                "r":         Rename
                "n":         NextResult
                "g":         Top
                "<Space>":   Select
                "<C-Space>": InvertSelection
                "G":         Bottom
                "<CR>":      Confirm
                "i":         FocusInput
                "J":         MoveDown
                "<C-d>":     DownHalf
                "/":         EnterSearch
                "<C-c>":     Close
                "<Esc>":     Close
                "K":         MoveUp
                "D":         Delete
            }
            queue: {
                "D":       DeleteAll
                "<CR>":    Play
                "<C-s>":   Save
                "a":       AddToPlaylist
                "d":       Delete
                "i":       ShowInfo
                "C":       JumpToCurrent
            }
        )
        search: (
            case_sensitive: false
            mode: Contains
            tags: [
                (value: "any",         label: "Any Tag")
                (value: "artist",      label: "Artist")
                (value: "album",       label: "Album")
                (value: "title",       label: "Title")
                (value: "filename",    label: "Filename")
                (value: "genre",       label: "Genre")
                (value: "albumartist", label: "Featured")
            ]
        )
        artists: (
            album_display_mode: SplitByDate
            album_sort_by: Date
        ),
        tabs: [
            (
                name: "Queue"
                pane: Split(
                    direction: Horizontal
                    panes: [(size: "20%", pane: Pane(AlbumArt)), (size: "80%", pane: Pane(Queue))]
                )
            )
            (
                name: "Artists"
                pane: Pane(Artists)
            )
            (
                name: "Albums"
                pane: Pane(Albums)
            )
            (
                name: "Search"
                pane: Pane(Search)
            )
            (
                name: "Directories"
                pane: Pane(Directories)
            )
            (
                name: "Lyrics"
                pane: Split(
                    direction: Vertical
                    panes: [(size: "25%", pane: Pane(AlbumArt)), (size: "70%", pane: Pane(Lyrics), vertical_align: Bottom)]
                )
            )
        ]
    '';
  };
}
