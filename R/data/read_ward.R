read_ward <- function(path) {
  
  map(
    path, 
    \(x)
    select(
      clean_names(
        st_make_valid(
          read_sf(x)
        )
      ),
      ward_section = any_of(c("wardsweep", "code"))
    )
  )
  
}
