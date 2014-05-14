setwd("./data")

# loading general data ----------------------------------------------------
setwd("./UCI HAR Dataset")

features <- read.table("features.txt")
names(features) <- c("feature_label","feature_name")
activity_labels <- read.table("activity_labels.txt")
names(activity_labels) <- c("label","activityname")
  
# loading and combining test set ---------------------------------------------------
setwd("./test/")

subject_test <- read.table("subject_test.txt")
X_test <- read.table("X_test.txt")
y_test <- read.table("y_test.txt")

names(y_test) <- "label"
names(X_test) <- features$feature_name
names(subject_test) <- "subject"

X_test_name <- cbind(y_test,X_test)
X_test_name <- cbind(subject_test,X_test_name)

# loading and combining training set -----------------------------------------------

setwd("../")
setwd("./train")

subject_train <- read.table("subject_train.txt")
X_train <- read.table("X_train.txt")
y_train <- read.table("y_train.txt")

names(y_train) <- "label"
names(X_train) <- features$feature_name
names(subject_train) <- "subject"

X_train_name <- cbind(y_train,X_train)
X_train_name <- cbind(subject_train,X_train_name)


# merging test and training sets, selecting columns ------------------------------------------

if(any(names(X_test_name) != names(X_train_name))) stop("The column names in the training and 
                                                        test datatsets are not equal.")
globalset <- rbind(X_test_name, X_train_name)

globalset_std <- grep("std\\(\\)", names(globalset), value = TRUE)
globalset_avg <- grep("mean\\(\\)",names(globalset), value = TRUE)

vars_to_include <- c(globalset_std,globalset_avg)
cols_to_include <- c("label","subject", vars_to_include)

globalset_restrict <- globalset[  , cols_to_include]


names(globalset_restrict) <- gsub("\\(", ""  , names(globalset_restrict))
names(globalset_restrict) <- gsub("\\)", ""  , names(globalset_restrict))
names(globalset_restrict) <- gsub("-", ""  , names(globalset_restrict))
names(globalset_restrict) <- gsub("std", "StanDev"  , names(globalset_restrict))
names(globalset_restrict) <- gsub("mean", "Mean"  , names(globalset_restrict))
names(globalset_restrict) <- gsub("^t", "TimeSign"  , names(globalset_restrict))
names(globalset_restrict) <- gsub("^f", "FreqDom"  , names(globalset_restrict))
names(globalset_restrict) <- gsub("acc", "Accel"  , names(globalset_restrict))

# calculate means per subject and activity --------------------------------

library(plyr)
vars_to_include <- setdiff(names(globalset_restrict),"label")
vars_to_include <- setdiff(vars_to_include,"subject")
globalset_restr_avg <- aggregate(globalset_restrict[ vars_to_include], by = list(globalset_restrict$label,globalset_restrict$subject), mean )

names(globalset_restr_avg) <- gsub( "Group.1", "label", names(globalset_restr_avg) )
names(globalset_restr_avg) <- gsub( "Group.2", "subject", names(globalset_restr_avg) )

globalset_restr_avg <- merge(activity_labels, globalset_restr_avg)

setwd("../")
setwd("../")

write.table(globalset_restr_avg, "average_activity_subject.txt", row.names = FALSE)


