# run targets sequentially:
targets::tar_make()

# latest pipeline
htmltools::save_html(
  html = targets::tar_visnetwork(),
  file = "pipeline.html"
)
webshot::webshot(
  "pipeline.html",
  selector = "body",
  zoom = 10,
  file = "pipeline.png"
)

