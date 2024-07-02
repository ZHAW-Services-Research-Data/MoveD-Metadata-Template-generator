# 1. Clear memory ####
{
 rm(list=ls())
}

#2. install and load the necessary packages, and set the setting for pop-up versus console input ####
{
 # Check if the package is already installed, if not install it
 if (!require("svDialogs", character.only = TRUE)){
  install.packages("svDialogs")
 }
 
 # Load the package
 library("svDialogs")
  
 # Disable warnings
  options(warn=-1)
 
}

# 3. Set the constants ####
{
  # Set the setting for pop-up versus console input
  popup <- TRUE
  
  #Variables that are numeric
  numeric_entries = c("Age",
                      "Height",
                      "Weight",
                      "Leg length", 
                      "Measurement frequency", 
                      "Electrode-Skin Impedance",
                      "Signal-to-noise ratio",
                      "Dynamic range of measurement device",
                      "Penetration depth",
                      "Image resolution",
                      "Sampling rate")
  
  #Variables that need to be rounded to 2 decimals
  rounding_entries = numeric_entries
  
  # List of all variables (divided per section)
  software_collection = c("Name", "Manufacturer", "Version", "Type of data which were collected (e.g. marker-based kinematics, surface EMG)", "Data format of the raw data (xcp, x1d, x2d etc.)")
  hardware_collection = c("Name", "Manufacturer", "Type of data which were collected (e.g. marker-based kinematics, surface EMG)", "Electrode material, shape, size (if applicable, otherwise enter na)", "Measurement frequency [Hz]")
  software_processing = c("Name", "Manufacturer", "Version", "Type of data which were processed")
  software_analysis = c("Name", "Manufacturer", "Version (software and used packages)", "Type of data which were analyzed (kinematics, kinetics, EMG, accelerometer, IMU, EEG, plantar pressure, imaging, video)")
  stats_analyses = c("Statistical model", "Number of analyzed parameters", "Type of parameter (dependent)", "Type of parameter (independent)")
  tasks = c("Naming convention (abbreviation) of task e.g. Squat (sq)", "Description of task (If walking or running was performed: indicate gait speed)")
  sensors = c("Abbreviation e.g. L/RTHI", "Segment name e.g. Thigh", "Explanation marker/sensor placement e.g. half way down the lateral thigh")
  
  all_variables_collect_participant <- c(
    "Part 1.1: Data Collection - participant specific information" = "Message",
    "Identification number" = "not",
    "Age" = "not",
    "Gender" = "not",
    "Height" = "not",
    "Weight" = "not",
    "Leg length" = "not"
  )
  all_variables_collect_general <- c(
    "Part 1.2: Data Collection - general information (minimal)" = "Message",
    "Date of data collection" = "not",
    "Software(s) used for data collection" = "software_collection",
    "Hardware which was used for data collection" = "hardware_collection",
    "Study-specific inclusion criteria" = "repeated",
    "Study-specific exclusion criteria" = "repeated",
    "Task(s)" = "tasks",
    "Randomization of task order (yes/no)" = "not",
    "Name of marker model" = "not",
    "Reference to marker model" = "not",
    "Marker/sensor placement(s)" = "sensor",
    "Part 1.3: general information (if applicable, otherwise enter na)" = "Message",
    "Amplification of device" = "optional",
    "Calibration pose" = "optional",
    "Electrode-Skin Impedance" = "optional",
    "Signal-to-noise ratio" = "optional",
    "Mode of measurement device" = "optional",
    "Dynamic range of measurement device" = "optional",
    "Penetration depth" = "optional",
    "Preparation of the subject" = "optional",
    "Reference electrode" = "optional",
    "Synchronisation method for multiple measurement devices" = "optional",
    "Image resolution" = "optional",
    "Part 1.4: Data collection - Comments: If there are any additional comments you wish to record, please do so in the next prompt." = "Message",
    "Data collection: additional comment(s)" = "not"
  )
  all_variables_process <- c(
    "Part 2.1: Data Processing - general information" = "Message",
    "Date(s) of data processing (one value per participant)" = "repeated",
    "Software(s) used for data processing"= "software_processing",
    "Sampling rate" = "not",
    "Quality check (if applicable, otherwise enter na)" = "not",
    "Part 2.2: Data Processing - EMG (if applicable, otherwise enter na)" = "Message",
    "Filter (EMG)" = "optional",
    "Rectification (EMG)" = "optional",
    "EMG amplitude processing" = "optional",
    "Normalization (EMG)" = "optional",
    "Exclusion of trials/muscles" = "optional",
    "Analyzed outcomes (EMG)" = "optional",
    "Part 2.3: Data Processing - EEG (if applicable, otherwise enter na)" = "Message",
    "Filter (EEG)" = "optional",
    "Re-referencing" = "optional",
    "Resampling" = "optional",
    "Artifact removal (EEG)" = "optional",
    "Data epoch extraction" = "optional",
    "Head model" = "optional",
    "File type after export (EEG)" = "optional",
    "Criteria for exclusion of data trials/single joints (EEG)" = "optional",
    "Part 2.4: Data Processing - Marker data (if applicable, otherwise enter na)" = "Message",
    "Labelling" = "optional",
    "Pipelines (marker data)" = "optional",
    "Events" = "optional",
    "Calculation method" = "optional",
    "Naming convention (marker data)" = "optional",
    "File type after export (marker data)" = "optional",
    "Criteria for the exclusion of trials/single joints (marker data)" = "optional",
    "Normalization (marker data)" = "optional",
    "Analyzed outcomes angles" = "optional",
    "Analyzed spatiotemporal outcomes" = "optional",
    "Part 2.5: Data Processing - Kinetics (if applicable, otherwise enter na)" = "Message",
    "Naming convention (kinetics)" = "optional",
    "Pipelines (kinetics)" = "optional",
    "File type after export (kinetics)" = "optional",
    "Criteria for exclusion of forces/moments" = "optional",
    "Normalization (kinetics)" = "optional",
    "Analyzed outcomes moments" = "optional",
    "Analyzed outcomes forces" = "optional",
    "Part 2.6: Data Processing - IMU (if applicable, otherwise enter na)" = "Message",
    "Naming convention (IMU)" = "optional",
    "Filter (IMU)" = "optional",
    "File type after export (IMU)" = "optional",
    "Normalization (IMU)" = "optional",
    "Analyzed outcomes (IMU)" = "optional",
    "Criteria for exclusion of trials (angles, forces, moments, etc.)" = "optional",
    "Part 2.7: Data Processing - plantar pressure (if applicable, otherwise enter na)" = "Message",
    "Processing steps" = "optional",
    "Criteria for exclusion of trials" = "optional",
    "Analyzed outcomes (plantar pressure)" = "optional",
    "Part 2.8: Data Processing - imaging data (if applicable, otherwise enter na)" = "Message",
    "Applied algorithms for image processing" = "optional",
    "Criteria for exclusion of images" = "optional",
    "Analyzed outcomes (imaging data)" = "optional",
    "Part 2.9: Data Processing - 2D video (if applicable, otherwise enter na)" = "Message",
    "Calculation method for joint angles (if applicable, otherwise enter na)" = "optional",
    "Part 2.10: Data processing - Comments: If there are any additional comments you wish to record, please do so in the next prompt." = "Message",
    "Data processing: additional comment(s)" = "not"
  )
  all_variables_process_type <- c(
    "Part 2.1: Data Processing - general information" = "general",
    "Date(s) of data processing (one value per participant)" = "general",
    "Software(s) used for data processing"= "general",
    "Sampling rate" = "general",
    "Quality check (if applicable, otherwise enter na)" = "general",
    "Part 2.2: Data Processing - EMG (if applicable, otherwise enter na)" = "EMG",
    "Filter (EMG)" = "EMG",
    "Rectification (EMG)" = "EMG",
    "EMG amplitude processing" = "EMG",
    "Normalization (EMG)" = "EMG",
    "Exclusion of trials/muscles" = "EMG",
    "Analyzed outcomes (EMG)" = "EMG",
    "Part 2.3: Data Processing - EEG (if applicable, otherwise enter na)" = "EEG",
    "Filter (EEG)" = "EEG",
    "Re-referencing" = "EEG",
    "Resampling" = "EEG",
    "Artifact removal (EEG)" = "EEG",
    "Data epoch extraction" = "EEG",
    "Head model" = "EEG",
    "File type after export (EEG)" = "EEG",
    "Criteria for exclusion of data trials/single joints (EEG)" = "EEG",
    "Part 2.4: Data Processing - Marker data (if applicable, otherwise enter na)" = "marker",
    "Labelling" = "marker",
    "Pipelines (marker data)" = "marker",
    "Events" = "marker",
    "Calculation method" = "marker",
    "Naming convention (marker data)" = "marker",
    "File type after export (marker data)" = "marker",
    "Criteria for the exclusion of trials/single joints (marker data)" = "marker",
    "Normalization (marker data)" = "marker",
    "Analyzed outcomes angles" = "marker",
    "Analyzed spatiotemporal outcomes" = "marker",
    "Part 2.5: Data Processing - Kinetics (if applicable, otherwise enter na)" = "kinetics",
    "Naming convention (kinetics)" = "kinetics",
    "Pipelines (kinetics)" = "kinetics",
    "File type after export (kinetics)" = "kinetics",
    "Criteria for exclusion of forces/moments" = "kinetics",
    "Normalization (kinetics)" = "kinetics",
    "Analyzed outcomes moments" = "kinetics",
    "Analyzed outcomes forces" = "kinetics",
    "Part 2.6: Data Processing - IMU (if applicable, otherwise enter na)" = "IMU",
    "Naming convention (IMU)" = "IMU",
    "Filter (IMU)" = "IMU",
    "File type after export (IMU)" = "IMU",
    "Normalization (IMU)" = "IMU",
    "Analyzed outcomes (IMU)" = "IMU",
    "Criteria for exclusion of trials (angles, forces, moments, etc.)" = "IMU",
    "Part 2.7: Data Processing - plantar pressure (if applicable, otherwise enter na)" = "plantar",
    "Processing steps" = "plantar",
    "Criteria for exclusion of trials" = "plantar",
    "Analyzed outcomes (plantar pressure)" = "plantar",
    "Part 2.8: Data Processing - imaging data (if applicable, otherwise enter na)" = "imaging",
    "Applied algorithms for image processing" = "imaging",
    "Criteria for exclusion of images" = "imaging",
    "Analyzed outcomes (imaging data)" = "imaging",
    "Part 2.9: Data Processing - 2D video (if applicable, otherwise enter na)" = "2dvideo",
    "Calculation method for joint angles (if applicable, otherwise enter na)" = "2dvideo",
    "Part 2.10: Data processing - Comments: If there are any additional comments you wish to record, please do so in the next prompt." = "general",
    "Data processing: additional comment(s)" = "general"
  )
  all_variables_analyze <- c(
    "Part 3.1: Data Analysis - general information" = "Message",
    "Date of data analysis" = "not",
    "Software(s) used for data analysis"= "software_analysis",
    "Statistical analysis" = "stats",
    "Part 3.2: Data Analysis - Analysis of imaging data (if applicable, otherwise enter na)" = "Message",
    "Statistical analysis (if performed)" = "stats",
    "Part 3.3: Data analysis - Comments: If there are any additional comments you wish to record, please do so in the next prompt." = "Message",
    "Data analysis: additional comment(s)" = "not"
  )
  all_variables_share <- c(
    "Part 4.1: Data Sharing - general information" = "Message",
    "Date of data publication" = "not",
    "Used data format(s)"= "repeated",
    "Licence type for data reuse" = "not",
    "Stage of data processing" = "not",
    "Storage location/ name of file for nomenclature" = "not",
    "Part 4.2: Data Sharing - Information on encoding/anonymization" = "Message",
    "Encoding/ anonymization of personal data" = "not",
    "Anonymization of quantitative movement data" = "not",
    "Part 4.3: Data Sharing - Information on the data content (description of single files)" = "Message",
    "Information on data collection" = "not",
    "Information on participants/their characteristics" = "not",
    "Information on movement data" = "not",
    "Part 4.4: Data Sharing - Information on data analysis" = "Message",
    "Repository/ location where the data has been stored" = "not",
    "Part 4.5: Data Sharing - Comments: If there are any additional comments you wish to record, please do so in the next prompt." = "Message",
    "Data sharing: additional comment(s)" = "not"
  )
  
  multiple_entries <- c(names(all_variables_collect_participant[which(all_variables_collect_participant == "repeated")]),
                        names(all_variables_collect_general[which(all_variables_collect_general == "repeated")]),
                        names(all_variables_process[which(all_variables_process == "repeated")]),
                        names(all_variables_analyze[which(all_variables_analyze == "repeated")]),
                        names(all_variables_share[which(all_variables_share == "repeated")]))
}


#4. Create a function to round a value to a certain number of decimal places ####
round_to_n <- function(value, variable, n=2){
  if (variable %in% multiple_entries){
    if (grepl(";", variable, fixed = TRUE)){
      values <- unlist(strsplit(value, ";"))
      rounded_values <- round(as.numeric(values), n)
      return(paste(rounded_values, collapse = "; "))
    } else{
      if (value != "" && value != "na"){
        return(round(as.numeric(value), n))
      } else{
        return("na")
      }
    }
  } else{
    if (value != "" && value != "na"){
      return(round(as.numeric(value), n))
    } else{
      return("na")
    }
  }
}


# 5. Create a function to generate the message, and query the user based on that message ####
{
  query_user <- function(variable, dataframe, reference_dict, popup=FALSE, extra=""){
    # select the relevant row
    relevant_row = dataframe[which(dataframe[1] == variable), ]
    
    # Create the base message, based on whether the variable starts with "if applicable"
    if (reference_dict[variable] == "optional" & !grepl("if applicable", variable)){
      base_message = paste0(extra, 
        "If applicable, enter the ",
        variable,
        " (otherwise enter 'na')"
      )} else{
        base_message = paste0(extra, "Enter the ", variable)
      }
    
    # Next, add the unit, if there is one listed
    if (relevant_row[1, 2] != ""){
      base_message = paste0(base_message, " (", relevant_row[1, 2], ")")
    }
    
    # Then add any comments if applicable
    if (relevant_row[1, 3] != ""){
      base_message = paste0(base_message, "; Comment: ", relevant_row[1, 3])
    }
    
    # Add the final ": "
    base_message = paste0(base_message, ": ")
    
    # Next, query the user, either via popup or via the command line
    # First check those versions where numeric values need to be checked
    if (variable %in% numeric_entries){
      continue_query = TRUE
      while (continue_query){
        value_entered = trycatch_null(toString(base_message), popup)
        
        if (value_entered == "na" | ! is.na(as.numeric(value_entered))){
          continue_query = FALSE
        } else{
          if (popup){
            dlgMessage(paste0("Please enter a numeric value for ", toString(variable)), type="ok", Sys.info()["user"], rstudio=T)
          } else{
            print(paste0("Please enter a numeric value for ", variable))
          }
        }
      }
    } else{
      # Second do all other cases
      value_entered = trycatch_null(toString(base_message), popup)
    }
    
    # Check if the variable needs to be rounded, and do so
    if (variable %in% rounding_entries & value_entered != "na" & !is.null(value_entered)){
      value_entered = round_to_n(value_entered, variable, n=2)
    }
      
    # Finally, return the output
    return(value_entered)
  }
}

# 6. Query the user for the inputs needed to create the output dataframe ####
create_df <- function(dataframe, popup, part, all_variables_process){
  #Create a variable to check if the process needs to be continued or not
  continue_process = TRUE
  
  #Check which part of the metadata is being filled out
  if (part == "collect (participant data)"){
    all_variables_named <- all_variables_collect_participant
  } else if (part == "collect (general data)"){
    all_variables_named <- all_variables_collect_general
  } else if (part == "process"){
    all_variables_named <- all_variables_process
  } else if (part == "analyze"){
    all_variables_named <- all_variables_analyze
  } else if (part == "share"){
    all_variables_named <- all_variables_share
  }
  
  #Make a variable to check if the imaging data needs to be entered in analyze
  imaging_TF <- FALSE
  
  #Loop over the variables and query the user for the input (part 1: not repeated)
  for (var_name in names(all_variables_named)){
    #Check if imaging is in the df for analyze --> softwares
    if (var_name == "Part 3.2: Data Analysis - Analysis of imaging data (if applicable, otherwise enter na)"){
      # Ask the user if imagine data was analyzed
      imaging_yn = trycatch_null(toString("Was imaging data analyzed? Enter 'yes' or 'no'"), popup)
      if (is.null(imaging_yn)){
        continue_process = FALSE
        break
      } else {
        imaging_yn = trimws(tolower(imaging_yn))
      }
      
      #Check if the input is correct
      while (imaging_yn != "yes" & imaging_yn != "no"){
        if (popup){
          dlgMessage("Please enter 'yes' or 'no'", type="ok", Sys.info()["user"], rstudio=T)
          } else{
          print("Please enter 'yes' or 'no'")
          }
        imaging_yn = trycatch_null(toString("Was imaging data analyzed? Enter 'yes' or 'no'"), popup)
        if (is.null(imaging_yn)){
          continue_process = FALSE
          break
        } else {
          imaging_yn = trimws(tolower(imaging_yn))
        }
      }
      if(continue_process == FALSE){
        break
      }
      
      #If yes, set the imaging_TF to TRUE
      if (imaging_yn == "yes"){
        imaging_TF <- TRUE
      }
    } 
    
    #Create a message if it's just a message variable
    if ((all_variables_named[var_name] == "Message" & var_name != "Part 3.2: Data Analysis - Analysis of imaging data (if applicable, otherwise enter na)") | 
        (var_name == "Part 3.2: Data Analysis - Analysis of imaging data (if applicable, otherwise enter na)" & imaging_TF)){
      if (popup){
        dlgMessage(toString(var_name), type="ok", Sys.info()["user"], rstudio=T)
      } else{
        print(var_name)
      }
    } else if (all_variables_named[var_name] == "not" | all_variables_named[var_name] == "optional"){
      
      #Cases where the variable is not repeated
      output_text = query_user(
        var_name, dataframe, all_variables_named, popup)
      if (is.null(output_text)){
        continue_process == FALSE
        break
      } else {
        dataframe[which(dataframe[1] == var_name), 4] = output_text
      }
      
    } else if (all_variables_named[var_name] %in% c("software_collection", "hardware_collection", "software_processing", "software_analysis", "stats", "tasks", "sensor")){
      if (all_variables_named[var_name] == "hardware_collection"){
        message_word = "hardware"
      } else if (all_variables_named[var_name] == "stats"){
        message_word = "statistical analysis"
      } else if (all_variables_named[var_name] == "tasks"){
        message_word = "task"
      } else if (all_variables_named[var_name] == "sensor"){
        message_word = "Sensor/marker"
      } else {
        message_word = "software"
      }
      
      #Check how many softwares need to be added
      if (var_name != "Statistical analysis (if performed)" | (var_name == "Statistical analysis (if performed)" & imaging_TF)){
        cont_query=TRUE
        while(cont_query){
          number_soft = trycatch_null(toString(paste0(toString(var_name), ": How many ", toString(message_word), " do you wish to record?")), popup)
          if (is.null(number_soft)){
            continue_process = FALSE
            break
          } else {
            number_soft = as.integer(number_soft)
          }
          
          if (!is.na(number_soft)){
            cont_query = FALSE
          } else {
            if (popup){
              dlgMessage(paste0("Please enter an integer value (>=0)."), type="ok", Sys.info()["user"], rstudio=T)
            } else{
              print(paste0("Please enter an integer value (>=0)."))
            }
          }
        }
        if (continue_process == FALSE){
          break
        }
        
        #Loop over the number of softwares, and add to the dataframe
        if (number_soft > 0){
          for (i in 1:number_soft){
            output_text = query_software_hardware(var_name, i, popup)
            if (is.null(output_text)){
              continue_process = FALSE
              break
            } else {
              if (i == 1){
                dataframe[which(dataframe[1] == var_name), 4] = output_text
              } else {
                dataframe[which(dataframe[1] == var_name), 4] = paste0(dataframe[which(dataframe[1] == var_name), 4], "\n;;;",  
                                                                       output_text)
              }
              
            }
          }
          
          if (continue_process == FALSE){
            break
          }
        }
      }
      
      
    } else if (all_variables_named[var_name] != "Message") {
      
      #Cases that are repeated but are not software/hardware
      #Check how many values need to be added
      cont_query=TRUE
      while(cont_query){
        number_inc = trycatch_null(toString(paste0("How many ", toString(var_name), " do you wish to record?")), popup)
        if (is.null(number_inc)){
          continue_process = FALSE
        } else {
          number_inc = as.integer(number_inc)
        }
        if (!is.na(number_inc)){
          cont_query = FALSE
        } else {
          if (popup){
            dlgMessage(paste0("Please enter an integer value (>=0)"), type="ok", Sys.info()["user"], rstudio=T)
          } else{
            print(paste0("Please enter an integer value (>=0)"))
          }
        }
      }
      #Loop over the number of repeated variables, and add to the dataframe
      if (number_inc > 0){
        for (i in 1:number_inc){
          output_text = query_user(var_name, dataframe, all_variables_named, popup, extra=paste0(var_name, " ", as.character(i), ": "))
          if(is.null(output_text)){
            continue_process = FALSE
          } else{
            if (i == 1){
              dataframe[which(dataframe[1] == var_name), 4] = output_text
            } else {
              dataframe[which(dataframe[1] == var_name), 4] = paste0(dataframe[which(dataframe[1] == var_name), 4] , "\n;;;", output_text)
            }
          }
          
        }
      }
      
    }
  }
  
  #In case the output got terminated, provide an information comment
  if (continue_process == FALSE){
    if (popup){
      dlgMessage(paste0("The text-input was cancelled by the user. The input process will therefore be terminated, and input entered so far saved"), type="ok", Sys.info()["user"], rstudio=T)
    } else{
      print(paste0("The text-input was cancelled by the user. The input process will therefore be terminated, and input entered so far saved"))
    }
  }
  
  # Return the dataframe
  return(dataframe)
}

# 7. Create a function to save the data ####
save_data <- function(data_processed, extra, popup=FALSE){
  #Inform the user about the saving of the data
  if (popup){
    dlgMessage("Data saving", type="ok", Sys.info()["user"], rstudio=T)
  } else {
    print("Data saving")
  }
  
  # Write the output to a new file, with the user specifying the name, add a cancel option
  continue_query = TRUE
  continue_save = TRUE
  #Query the user for an output file name
  output_text = trycatch_null(toString("Enter the output file name (without extension): "), popup)
  if (is.null(output_text)){
    continue_save = FALSE
  } else {
    output_file <- paste0("Output/", output_text, extra, ".csv")
  }
  
  # Check if the file already exists
  if (file.exists(output_file)){
    if (popup){
      validate_file = dlgInput("File already exists, do you wish to overwrite it? (y/n): ", default="", Sys.info()["user"], rstudio=T)$res
    } else {
      validate_file = readline(prompt="File already exists, do you wish to overwrite it? (y/n): ")
    }
    if (trimws(tolower(validate_file)) == "y" || trimws(tolower(validate_file)) == "yes"){
      continue_query = FALSE
    }
  } else {
    continue_query = FALSE
  }
  
  if (continue_save){
    # Write the output to a csv file with semicolon separator
    write.table(data_processed, file = output_file, quote = FALSE, col.names = FALSE, sep = ";", row.names=FALSE, fileEncoding="UTF-8", na="") 
    
  }
}

# 8. Create a function to query about the software and hardware used ####
query_software_hardware <- function(variable, i, popup=FALSE){
  
  #Create a string to store the output
  if (variable == "Software(s) used for data collection"){
    variable_list = software_collection
    output_str = paste0("Software ", as.character(i), ": ")
  } else if (variable == "Hardware which was used for data collection"){
    variable_list = hardware_collection
    output_str = paste0("Hardware ", as.character(i), ": ")
  } else if (variable == "Software(s) used for data processing"){
    variable_list = software_processing
    output_str = paste0("Software ", as.character(i), ": ")
  } else if(variable == "Statistical analysis (if performed)" | variable == "Statistical analysis"){
    variable_list = stats_analyses
    output_str = paste0("Statistical analysis ", as.character(i), ": ")
  } else if (variable == "Task(s)"){
    variable_list = tasks
    output_str = paste0("Task ", as.character(i), ": ")
  } else if (variable == "Marker/sensor placement(s)"){
    variable_list = sensors
    output_str = paste0("Sensor/marker ", as.character(i), ": ")
  } else {
    variable_list = software_analysis
    output_str = paste0("Software ", as.character(i), ": ")
  }
  
  #Ask the user to input the variables for the software/hardware and add them to the string, separated by a comma
  continue_process = TRUE
  for (var in variable_list){
    if (startsWith(output_str, "Software")){
      message = paste0("Enter the ", var, " for software ", as.character(i), ": ")
    } else if (startsWith(output_str, "Statistical analysis")){
      message = paste0("Enter the ", var, " for statistical analysis ", as.character(i), ": ")
    } else if (startsWith(output_str, "Task")){
      message = paste0("Enter the ", var, " for task ", as.character(i), ": ")
    } else if (startsWith(output_str, "Sensor/marker")){
      message = paste0("Enter the ", var, " for sensor/marker ", as.character(i), ": ")
    } else {
      message = paste0("Enter the ", var, " for hardware ", as.character(i), ": ")
    }
    
    value_entered = trycatch_null(toString(message), popup)
    if (is.null(value_entered)){
      break
    } else {
      output_str = paste0(output_str, "[", var, "] ", value_entered, " - ")
    }
    
  }
  
  #Remove the last dash from the string
  output_str = substr(output_str, 0, nchar(output_str)-2)
  
  #Return the output string
  return(output_str)
}


# 9. Create a main function to read in data, process, and write the output to a file ####
main <- function(){
  # Start by giving some information about leaving information empty
  if (popup){
    dlgMessage("Please enter the data into the prompts. If you do not have the data, or if it is not applicable, please enter 'na'. Note that if you press 'cancel' at any point, the program will stop and output may not be saved.", type="ok", Sys.info()["user"], rstudio=T)
  } else {
    print("Please enter the data into the prompts. If you do not have the data, or if it is not applicable, please enter 'na'. Note that if you press 'cancel' at any point, the program will stop and output may not be saved.")
  }
  
  # First ask the user which part of the metadata will be filled out: all, collect, process, analyze, or share
  part_metadata = trycatch_null("Which part of the metadata will be filled out? (all, collect (participant data), collect (general data), process, analyze, share)", popup)
  if (part_metadata == FALSE){
    if (popup){
      dlgMessage("Input cancelled by user, program will be terminated", type="ok", Sys.info()["user"], rstudio=T)
    } else {
      print("Input cancelled by user, program will be terminated")
    }
    quit()
  } else {
    part_metadata = trimws(tolower(part_metadata))
  }
  
  # Check if the user input is valid
  while (part_metadata != "all" && part_metadata != "collect (participant data)" && part_metadata != "collect (general data)" && part_metadata != "process" && part_metadata != "analyze" && part_metadata != "share"){
    part_metadata = trycatch_null("Please enter a valid option: (all, collect (participant data), collect (general data), process, analyze, share)", popup)
    if (is.null(part_metadata)){
      if (popup){
        dlgMessage("Input cancelled by user, program will be terminated", type="ok", Sys.info()["user"], rstudio=T)
      } else {
        print("Input cancelled by user, program will be terminated")
      }
      quit()
    } else {
      part_metadata = trimws(tolower(part_metadata))
    }
  }
  
  
  #Create the output folder in case it does not exist yet.
  if (!dir.exists("Output")){
    dir.create("Output", showWarnings = FALSE)
  }
  
  # Read in the correct input file based on the user input, process it, and save the output
  if (part_metadata == "collect (participant data)"){
    input_file <- "Input/Metadata_Template_Collect_Participant.csv"
    data <- read.csv(input_file, header = F, sep = ";", dec = ".", stringsAsFactors = FALSE)
    data_processed = create_df(data, popup, part="collect (participant data)", all_variables_process=c())
    save_data(data_processed, "_collect_participant", popup)
  } else if (part_metadata == "collect (general data)"){
    input_file <- "Input/Metadata_Template_Collect_general.csv"
    data <- read.csv(input_file, header = F, sep = ";", dec = ".", stringsAsFactors = FALSE)
    data_processed = create_df(data, popup, part="collect (general data)", all_variables_process=c())
    save_data(data_processed, "_collect_general", popup)
  }else if (part_metadata == "process"){
    all_variables_process_reworked = check_optional_data(all_variables_process, all_variables_process_type, popup)
    if (is.null(all_variables_process_reworked)){
      quit()
    }
    input_file <- "Input/Metadata_Template_Process.csv"
    data <- read.csv(input_file, header = F, sep = ";", dec = ".", stringsAsFactors = FALSE)
    data_processed = create_df(data, popup, part="process", all_variables_process=all_variables_process_reworked)
    save_data(data_processed, "_process", popup)
  } else if (part_metadata == "analyze"){
    input_file <- "Input/Metadata_Template_Analyze.csv"
    data <- read.csv(input_file, header = F, sep = ";", dec = ".", stringsAsFactors = FALSE)
    data_processed = create_df(data, popup, part="analyze", all_variables_process=c())
    save_data(data_processed, "_analyze", popup)
  } else if (part_metadata == "share"){
    input_file <- "Input/Metadata_Template_Share.csv"
    data <- read.csv(input_file, header = F, sep = ";", dec = ".", stringsAsFactors = FALSE)
    data_processed = create_df(data, popup, part="share", all_variables_process=c())
    save_data(data_processed, "_share", popup)
  } else {
    input_file <- "Input/Metadata_Template_Collect_Participant.csv"
    data <- read.csv(input_file, header = F, sep = ";", dec = ".", stringsAsFactors = FALSE)
    data_processed = create_df(data, popup, part="collect (participant data)", all_variables_process=c())
    save_data(data_processed, "_collect_participant", popup)
    
    input_file <- "Input/Metadata_Template_Collect_general.csv"
    data <- read.csv(input_file, header = F, sep = ";", dec = ".", stringsAsFactors = FALSE)
    data_processed = create_df(data, popup, part="collect (general data)", all_variables_process=c())
    save_data(data_processed, "_collect_general", popup)
    
    input_file <- "Input/Metadata_Template_Process.csv"
    all_variables_process_reworked = check_optional_data(all_variables_process, all_variables_process_type, popup)
    if (is.null(all_variables_process_reworked)){
      quit()
    }
    data_process <- read.csv(input_file, header = F, sep = ";", dec = ".", stringsAsFactors = FALSE)
    data_process_processed = create_df(data_process, popup, part="process", all_variables_process=all_variables_process_reworked)
    save_data(data_process_processed, "_process", popup)
    
    input_file <- "Input/Metadata_Template_Analyze.csv"
    data_analyze <- read.csv(input_file, header = F, sep = ";", dec = ".", stringsAsFactors = FALSE)
    data_analyze_processed = create_df(data_analyze, popup, part="analyze", all_variables_process=c())
    save_data(data_analyze_processed, "_analyze", popup)
    
    input_file <- "Input/Metadata_Template_Share.csv"
    data_share <- read.csv(input_file, header = F, sep = ";", dec = ".", stringsAsFactors = FALSE)
    data_share_processed = create_df(data_share, popup, part="share", all_variables_process=c())
    save_data(data_share_processed, "_share", popup)
  }
}

# 10. Create a function to check which types of optional data have been processed, and filter the reference data accordingly ####
check_optional_data <- function(all_variables_process, all_variables_process_type, popup){
  continue_process = TRUE
  
  # Ask the user if EMG data has been collected
  emg_collected = trycatch_null("Has EMG data been collected? (yes/no)", popup)
  if(is.null(emg_collected)){
    continue_process = FALSE
    break
  }else {
    emg_collected = trimws(tolower(emg_colleccted))
  }
  while (emg_collected != "yes" && emg_collected != "no"){
    emg_collected = trycatch_null("Please enter a valid option (yes/no)", popup)
    if(is.null(emg_collected)){
      continue_process = FALSE
      break
    }else {
      emg_collected = trimws(tolower(emg_colleccted))
    } 
  }
  
  # Do the same for the EEG data
  eeg_collected = trycatch_null("Has EEG data been collected? (yes/no)", popup)
  if(is.null(eeg_collected)){
    continue_process = FALSE
    break
  }else {
    eeg_collected = trimws(tolower(eeg_colleccted))
  }
  while (eeg_collected != "yes" && eeg_collected != "no"){
    eeg_collected = trycatch_null("Please enter a valid option (yes/no)", popup)
    if(is.null(eeg_collected)){
      continue_process = FALSE
      break
    }else {
      eeg_collected = trimws(tolower(eeg_colleccted))
    } 
  }
  
  # Do the same for the marker data
  marker_collected = trycatch_null("Has marker data been collected? (yes/no)", popup)
  if(is.null(marker_collected)){
    continue_process = FALSE
    break
  }else {
    marker_collected = trimws(tolower(marker_colleccted))
  }
  while (marker_collected != "yes" && marker_collected != "no"){
    marker_collected = trycatch_null("Please enter a valid option (yes/no)", popup)
    if(is.null(marker_collected)){
      continue_process = FALSE
      break
    }else {
      marker_collected = trimws(tolower(marker_colleccted))
    } 
  }
  
  # Do the same for the kinetics data
  kinetics_collected = trycatch_null("Has kinetics data been collected? (yes/no)", popup)
  if(is.null(kinetics_collected)){
    continue_process = FALSE
    break
  }else {
    kinetics_collected = trimws(tolower(kinetics_colleccted))
  }
  while (kinetics_collected != "yes" && kinetics_collected != "no"){
    kinetics_collected = trycatch_null("Please enter a valid option (yes/no)", popup)
    if(is.null(kinetics_collected)){
      continue_process = FALSE
      break
    }else {
      kinetics_collected = trimws(tolower(kinetics_colleccted))
    } 
  }
  
  # Do the same for the IMU data
  imu_collected = trycatch_null("Has IMU data been collected? (yes/no)", popup)
  if(is.null(imu_collected)){
    continue_process = FALSE
    break
  }else {
    imu_collected = trimws(tolower(imu_collected))
  }
  while (imu_collected != "yes" && imu_collected != "no"){
    imu_collected = trycatch_null("Please enter a valid option (yes/no)", popup)
    if(is.null(imu_collected)){
      continue_process = FALSE
      break
    }else {
      imu_collected = trimws(tolower(imu_colleccted))
    } 
  }
  
  # Do the same for the pressure data
  pressure_collected = trycatch_null("Has plantar pressure data been collected? (yes/no)", popup)
  if(is.null(pressure_collected)){
    continue_process = FALSE
    break
  }else {
    pressure_collected = trimws(tolower(pressure_collected))
  }
  while (pressure_collected != "yes" && pressure_collected != "no"){
    pressure_collected = trycatch_null("Please enter a valid option (yes/no)", popup)
    if(is.null(pressure_collected)){
      continue_process = FALSE
      break
    }else {
      pressure_collected = trimws(tolower(pressure_colleccted))
    } 
  }
  
  # Do the same for the imaging data
  imaging_collected = trycatch_null("Has imaging data been collected? (yes/no)", popup)
  if(is.null(imaging_collected)){
    continue_process = FALSE
    break
  }else {
    imaging_collected = trimws(tolower(imaging_collected))
  }
  while (imaging_collected != "yes" && imaging_collected != "no"){
    imaging_collected = trycatch_null("Please enter a valid option (yes/no)", popup)
    if(is.null(imaging_collected)){
      continue_process = FALSE
      break
    }else {
      imaging_collected = trimws(tolower(imaging_colleccted))
    } 
  }
  
  # Do the same for the 2D video data
  video2d_collected = trycatch_null("Has 2D video data been collected? (yes/no)", popup)
  if(is.null(video2d_collected)){
    continue_process = FALSE
    break
  }else {
    video2d_collected = trimws(tolower(video2d_collected))
  }
  while (video2d_collected != "yes" && video2d_collected != "no"){
    video2d_collected = trycatch_null("Please enter a valid option (yes/no)", popup)
    if(is.null(video2d_collected)){
      continue_process = FALSE
      break
    }else {
      video2d_collected = trimws(tolower(video2d_colleccted))
    } 
  }
  
  #Finally, filter the "all_variables_process" list based on the user input
  if (eeg_collected != "yes"){
    all_variables_process_type <- all_variables_process_type[!grepl("EEG", all_variables_process_type)]
  }
  if (emg_collected != "yes"){
    all_variables_process_type <- all_variables_process_type[!grepl("EMG", all_variables_process_type)]
  }
  if (marker_collected != "yes"){
    all_variables_process_type <- all_variables_process_type[!grepl("marker", all_variables_process_type)]
  }
  if (kinetics_collected != "yes"){
    all_variables_process_type <- all_variables_process_type[!grepl("kinetics", all_variables_process_type)]
  }
  if (imu_collected != "yes"){
    all_variables_process_type <- all_variables_process_type[!grepl("IMU", all_variables_process_type)]
  }
  if (pressure_collected != "yes"){
    all_variables_process_type <- all_variables_process_type[!grepl("plantar", all_variables_process_type)]
  }
  if (imaging_collected != "yes"){
    all_variables_process_type <- all_variables_process_type[!grepl("imaging", all_variables_process_type)]
  }
  if (video2d_collected != "yes"){
    all_variables_process_type <- all_variables_process_type[!grepl("2dvideo", all_variables_process_type)]
  }
  
  #Now filter the original all_variable_process based on the all_variables_process_type
  all_variables_process <- all_variables_process[names(all_variables_process) %in% names(all_variables_process_type)]
  
  if (continue_process){
    return(all_variables_process)
  } else {
    return(NULL)
  }
}

# 11. Create a function that does a try-catch when entering data, to catch a "cancel" or interrupted input ####
trycatch_null = function(display_text, popup=TRUE){
  if(popup){
    #Get the input from the user
    input_text = dlg_input(message=display_text, type="ok", default="", Sys.info()["user"], rstudio=T)
    
    # if the user cancelled, return a None type (NULL) object
    if (!length(input_text$res)){
      return(NULL) 
    } else{
      return(input_text$res)
    }
  } else {
    #Get the input from the user
    input = readline(prompt=display_text)
    
    #If the entered string is empty, return a NULL object, otherwise return the string
    if (length(input) == 0){
      return(NULL)
    } else {
      return(input)
    }
  }
}
  
# 12. Run the main function
main()

