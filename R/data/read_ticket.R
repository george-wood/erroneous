read_ticket <- function(path) {
  
  fread(
    path, 
    select = c("ticket_number",
               "violation_code",
               "unit_description",
               "issue_date", 
               "officer",
               "fine_level1_amount",
               "ticket_queue",
               "geocoded_lng",
               "geocoded_lat",
               "geocode_accuracy"
    )
  )[issue_date >= ymd("2014-01-01") &
      violation_code %in% c("09205020", "0964040B")][
    , .(ticket    = ticket_number,
        violation = violation_code,
        unit      = unit_description,
        dt        = issue_date,
        star      = as.character(officer),
        fine      = fine_level1_amount,
        queue     = ticket_queue,
        lon       = geocoded_lng,
        lat       = geocoded_lat,
        accuracy  = geocode_accuracy)
  ]
  
}
