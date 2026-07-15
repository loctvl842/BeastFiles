return {
  dark2 = "#33353a",
  dark1 = "#282a30",
  background = "#14161b",
  text = "#e0e2ea",
  accent1 = "#ffc0b9",
  accent2 = "#fce094",
  accent3 = "#b3f6c0",
  accent4 = "#8cf8f7",
  accent5 = "#a6dbff",
  accent6 = "#ffcaff",
  dimmed1 = "#adafb6",
  dimmed2 = "#84868d",
  dimmed3 = "#66686e",
  dimmed4 = "#47494f",
  dimmed5 = "#282a30",
  -- This palette's accent slots don't follow the monokai convention
  -- (accent4=green, accent3=yellow, accent1=red). Define explicit semantic
  -- VCS colors so shell tools get the right hues without per-theme case logic.
  vcs_clean    = "#b3f6c0",  -- accent3: mint green (add / good)
  vcs_modified = "#fce094",  -- accent2: soft yellow (warn)
  vcs_conflict = "#ffc0b9",  -- accent1: salmon (delete / bad)
}
