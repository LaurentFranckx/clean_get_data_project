filelist <- unzip("SamsunDat.zip",list=TRUE)
unzip("SamsunDat.zip")

# loading general data ----------------------------------------------------
setwd("./UCI HAR Dataset")

features <- read.table("features.txt")
activity_labels <- read.table("activity_labels.txt")
  
# loading from test set ---------------------------------------------------
setwd("./test/")

subject_test <- read.table("subject_test.txt")
X_test <- read.table("X_test.txt")
y_test <- read.table("y_test.txt")

# loading from training set -----------------------------------------------

setwd("../")
setwd("./train")

subject_train <- read.table("subject_train.txt")
X_train <- read.table("X_train.txt")
y_train <- read.table("y_train.txt")

# merging the test set ----------------------------------------------------

names(y_test) <- "label"
names(activity_labels) <- c("label","activityname")
y_test_named <- merge(y_test,activity_labels)

names(features) <- c("feature_label","feature_name")
names(X_test) <- features$feature_name

X_test_name <- cbind(y_test_named,X_test)
names(subject_test) <- "subject"
X_test_name <- cbind(subject_test,X_test_name)


# merging the training set ----------------------------------------------------

names(y_train) <- "label"
y_train_named <- merge(y_train,activity_labels)

names(features) <- c("feature_label","feature_name")
names(X_train) <- features$feature_name

X_train_name <- cbind(y_train_named,X_train)
names(subject_train) <- "subject"
X_train_name <- cbind(subject_train,X_train_name)


# merging test and training sets, selecting columns ------------------------------------------

any(names(X_test_name) != names(X_train_name))
globalset <- rbind(X_test_name, X_train_name)

globalset_std <- grep("std\\(\\)", names(globalset), value = TRUE)
globalset_avg <- grep("mean\\(\\)",names(globalset), value = TRUE)

vars_to_include <- c(globalset_std,globalset_avg)
cols_to_include <- c("activityname","subject", vars_to_include)

globalset_restrict <- globalset[  , cols_to_include]
dim(globalset_restrict)

names(globalset_restrict) <- tolower(names(globalset_restrict))
names(globalset_restrict) <- gsub("^t", "time-sign-"  , names(globalset_restrict))
names(globalset_restrict) <- gsub("^f", "freq-dom-"  , names(globalset_restrict))
names(globalset_restrict) <- gsub("\\(", ""  , names(globalset_restrict))
names(globalset_restrict) <- gsub("\\)", ""  , names(globalset_restrict))
#Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ)
# names(globalset_restrict) <- gsub("bodyacc", "body-acceleration-"  , names(globalset_restrict))
# names(globalset_restrict) <- gsub("bodyacc", "body-acceleration-"  , names(globalset_restrict))
# names(globalset_restrict) <- gsub("gravityacc", "gravity-acceleration-"  , names(globalset_restrict))
# names(globalset_restrict) <- gsub("bodygyro", "angular-velocity-"  , names(globalset_restrict))
#names(globalset_restrict) <- gsub("bodygyro", "angular-velocity-"  , names(globalset_restrict))
names(globalset_restrict) <- gsub("acc", "acceleration"  , names(globalset_restrict))


# calculate means per subject and activity --------------------------------

library(plyr)
vars_to_include <- setdiff(names(globalset_restrict),"activityname")
vars_to_include <- setdiff(vars_to_include,"subject")
globalset_restr_avg <- aggregate(globalset_restrict[ vars_to_include], by = list(globalset_restrict$activityname,globalset_restrict$subject), mean )

names(globalset_restr_avg) <- gsub( "Group.1", "activityname", names(globalset_restr_avg) )
names(globalset_restr_avg) <- gsub( "Group.2", "subject", names(globalset_restr_avg) )

setwd("../")
setwd("../")

write.table(globalset_restr_avg, "average_activity_subject.txt", row.names = FALSE)
