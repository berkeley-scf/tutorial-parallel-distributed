all:
	Rscript -e "library(knitr); knit2html('parallel-dist.Rmd')"

clean:
	rm -f parallel-dist.{md,html}
