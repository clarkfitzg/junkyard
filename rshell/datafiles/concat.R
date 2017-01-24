allfiles = list.files(".")
allfiles = grep("txt", allfiles, value = TRUE)

outfile = "all.txt"

for(f in allfiles){
    cmd = sprintf("cat %s >> %s", f, outfile)
    system(cmd)
}
