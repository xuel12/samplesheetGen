## INPUT SETUP

# set number of pools and fractions, if label free num_pools = 1
num_pools = 2
num_fractions = 3

# each row is a pool, each column is a fraction
rawfilenamelist = c('pool1_F1.raw','pool1_F2.raw','pool1_F3.raw',
                    'pool2_F1.raw','pool2_F2.raw','pool2_F3.raw')

# specify all TMT.channels
multiplex = c('126','127N','127C','128N','128C','129N','129C','130N','130C','131N','131C')
# # for label-free
# multiplex = c('-')


## EXECUTION
samplelist = list()
i = 1
# go over raw files and create sample sheet for each rawfile
for (pool in 1:num_pools) {
  for (fraction in 1:num_fractions) {
    rawfilename <- rawfilenamelist[(pool-1)*num_fractions+fraction]

    for (channel in 1:length(multiplex)) {
      expcondition = ''
      tmtlabel = multiplex[channel]
      silaclabel = 'L'
      techrep = 1
      sampletype = 'sample'
      biorep <- paste(paste0('pool', pool), 
                      paste0('channel', tmtlabel), 
                      sep = '_')
      biospecimenname <- biorep
      
      samplelist[[i]] <- c(rawfilename, expcondition,
              tmtlabel, silaclabel,
              biospecimenname, biorep, techrep, 
              pool, fraction, sampletype)
      i = i+1
    }
  }
}

sampledf <- do.call(rbind, samplelist)
colnames(sampledf) <- c('Raw.file','Exp','TMT.label','SILAC.label',
                        'biospecimenName','BioRep',	'TechRep',	'msBatch',
                        'fraction',	'sample.type')
write.csv(sampledf, 'meta.csv', row.names = F)

