# Install new packages
install.packages(c("plyr", "ggplot2", "highcharter", "sp", "dplyr", 
                   "lubridate", "rmarkdown", "tidyr", "nycflights13", 
                   "ggthemes", "xts", "cluster", "maps"))

# Get and view working dir
wdPath <- getwd()
wdPath

# Create a folder Data. Write wdPath to file
if (!file.exists("Data1")) {
  dir.create("Data1")
} 

saveRDS(wdPath, "Data/wdPath.RData")
write.table(wdPath, "Data/wdPath.txt")



# ------------ Some DS aRt

#####
# 1 #
#####


library(grid) 

dev.new()
pushViewport(viewport(width=1, height=1, angle=0, name="vp1"))
grid.rect()

for(i in 1:54){
  pushViewport(viewport(width=0.95, height=0.95, angle=5, name="vp1"))
  grid.rect()
  
}


#####
# 2 #
#####

library(dplyr)
library(ggplot2)
library(ggthemes)

n <- 20000
a <- 0.5

set.seed(101)

make_circle <- function(tx, ty) {
  data <- data.frame(angle = runif(n, 0, 2 * pi)) %>%
    mutate(x = a * cos(angle) + tx, y = a * sin(angle) + ty) %>%
    select(x, y)
  data2 <- data[sample(nrow(data)),]
  data <- bind_cols(data, data2)
  names(data) <- c("x1", "y1", "x2", "y2")
  data
}

data <- rbind(make_circle(cos(0), sin(0)),
              make_circle(cos(pi/4), sin(pi/4)),
              make_circle(cos(pi/2), sin(pi/2)),
              make_circle(cos(3*pi/4), sin(3*pi/4)),
              make_circle(cos(pi), sin(pi)),
              make_circle(cos(5*pi/4), sin(5*pi/4)),
              make_circle(cos(3*pi/2), sin(3*pi/2)),
              make_circle(cos(7*pi/4), sin(7*pi/4)))

ggplot() +
  geom_segment(aes(x = x1, xend = x2, y = y1, yend = y2), data %>% filter(x1 != x2),
               alpha = 0.15, size = 0.015) +
  coord_equal() +
  theme_tufte() +
  theme(line = element_blank(),
        axis.ticks = element_blank(),
        axis.ticks.length = unit(0, "null"),
        axis.title = element_blank(),
        axis.text = element_blank(),
        text = element_blank(),
        legend.position = "none",
        legend.margin=unit(0, "null"),
        panel.background = element_blank(),
        panel.border=element_blank(),
        panel.grid = element_blank(),
        panel.margin=unit(c(0,0,0,0), "null"),
        plot.background = element_blank(),
        plot.margin=unit(c(0,0,0,0), "null"),
        strip.text = element_blank())
