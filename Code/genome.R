library(ggplot2)
library(MetBrewer)

n <- 100
nCol <- 46
df <- data.frame(xStart = (rep(1:nCol, each = n))+0.9, 
                 xEnd = (rep(1:nCol, each = n)),
                 yStart = 1:n,
                 alpha = rnorm(4*nCol, mean = 0.2, sd = 0.1))
df$yEnd = df$yStart+rnorm(nCol*n, sd = 2)
df$col <- '#FFFFFF'
# Select a random sample of the white:
colSize <- rnorm(n=1, mean = 2*n)
df$col[sample(1:nrow(df), size = colSize)] <- sample(met.brewer(name = sample(colorblind_palettes, size = 1), n = rpois(1, lambda = 12)), size = colSize, replace = T)

(p <- ggplot(df) +
    geom_rect(aes(xmin = xStart, xmax = xEnd, ymin = yStart, ymax = yEnd, fill = I(col))) +
    theme_void() +
    theme(legend.position = 'none', panel.background = element_rect(fill = "black")))

ggsave(p, filename = 'GenomeArt', height = 2160, width = 3840,units = 'px', dpi = 300)
