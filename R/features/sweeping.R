sweeping <- function(ticket, schedule, ward) {
  
  impose_boundary <- 
    function(dt,
             change = ymd("2015-05-18"),
             end = ymd("2015-12-31")) {
      fifelse(between(dt, change, end), year(dt) + 1e-01, year(dt))
    }

  # filter to street cleaning
  t <- 
    ticket |>
    filter(
      !is.na(lon),
      !is.na(lat),
      accuracy >= 0.8
    ) |>
    group_split(
      boundary = impose_boundary(dt)
    )
  
  s <- 
    schedule |>
    group_split(
      boundary = impose_boundary(dt_start)
    )
  
  out <- 
    tibble(
      t,
      s = lapply(s, as.data.table),
      ward
    ) |>
    rowwise() |>
    mutate(
      t = list(
        st_as_sf(t, coords = c("lon", "lat"), crs = st_crs(ward))
      ),
      t = list(
        as.data.table(
          mutate(
            t,
            ward_section = ward$ward_section[
              as.integer(st_intersects(t, ward))
            ]
          )
        )
      ),
      error = list(
        t[!s, on = .(ward_section, dt >= dt_start, dt <= dt_end)
        ][, type := fifelse(!ward_section %in% s$ward_section,
                            "ward_section", "date_time")]
      )
    )

  return(out)
  
}
