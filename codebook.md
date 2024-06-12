#  describing the variables for the script run_analysis.R
    #Each column that identified a person was changed from a X1/X2 to "VolunteerID"
    #Each colum for the activity was renamed as "Label"
    #shorthand labels
      #names_vector <- gsub("^t", "Time", names_vector)
      #names_vector <- gsub("^f", "Frequency", names_vector)
      #names_vector <- gsub("Acc", "Accelerometer", names_vector)
      #names_vector <- gsub("Gyro", "Gyroscope", names_vector)
      #names_vector <- gsub("Mag", "Magnitude", names_vector)
      #names_vector <- gsub("BodyBody", "Body", names_vector)
      #names_vector <- gsub("Body", "Body", names_vector)
      #names_vector <- gsub("Gravity", "Gravity", names_vector)
      #names_vector <- gsub("-mean\\(\\)", "-Mean", names_vector, ignore.case = TRUE)
      #names_vector <- gsub("-std\\(\\)", "-STD", names_vector, ignore.case = TRUE)
      #names_vector <- gsub("-freq\\(\\)", "-Frequency", names_vector, ignore.case = TRUE)
      #names_vector <- gsub("angle", "Angle", names_vector)
      #names_vector <- gsub("gravity", "Gravity", names_vector)
