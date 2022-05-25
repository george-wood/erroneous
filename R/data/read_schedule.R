read_schedule <- function(path) {
  
  d        <- map(path, \(x) clean_names(fread(x)))
  names(d) <- str_extract(path, "\\d+")
  d        <- rbindlist(d, idcol = "year")
  
  d <- d[
    , .(day = unlist(strsplit(dates, ","))),
    by = .(year,
           month = month_name,
           ward_section = sprintf("%04s", ward_section_concatenated))
  ][
    , .(ward_section,
        dt_start = dmy_hm(paste(day, month, year, "07:00")),
        dt_end   = dmy_hm(paste(day, month, year, "14:00")))
  ][]
  
  na.omit(d)
  
}
