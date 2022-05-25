# functions
pacman::p_load(targets, tarchetypes, future, future.callr,
               fs, tidyverse, glue, data.table)
sapply(dir_ls("R/", recurse = TRUE, type = "file"), source)

# options
tar_option_set(format = "parquet")

tar_option_set(
  packages = c("tidyverse", "data.table", "janitor",
               "lubridate", "purrr", "glue", "furrr", "fs", "sf")
)

# targets
list(
  tar_target(f_schedule, dir_ls("data/sweeping/schedule/"), format = "file"),
  tar_target(f_ward, dir_ls("data/sweeping/ward/"), format = "file"),
  tar_target(f_ticket, dir_ls("data/ticket/"), format = "file"),
  tar_target(schedule, read_schedule(f_schedule)),
  tar_target(ward, read_ward(f_ward), format = "qs"),
  tar_target(ticket, read_ticket(f_ticket)),
  tar_target(erroneous, sweeping(ticket, schedule, ward), format = "qs")
)

