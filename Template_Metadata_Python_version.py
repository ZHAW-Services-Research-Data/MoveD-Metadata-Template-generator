# -*- coding: utf-8 -*-

# 1. Import the necessary libraries, and define the pop-up setting
import pandas
import os
import tkinter
import tkinter.simpledialog
import csv
import sys

# Define the constants
popup = True
numeric_entries = ["Age",
        "Height",
        "Weight",
        "Leg length", 
        "Measurement frequency", 
        "Electrode-Skin Impedance",
        "Signal-to-noise ratio",
        "Dynamic range of measurement device",
        "Penetration depth",
        "Image resolution",
        "Sampling rate"]
rounding_entries = numeric_entries

# List of all variables (divided per section)
software_collection = ["Name", "Manufacturer", "Version", "Type of data which were collected (e.g. marker-based kinematics, surface EMG)", "Data format of the raw data (xcp, x1d, x2d etc.)"]
hardware_collection = ["Name", "Manufacturer", "Version of device", "Number of device", "Type of data which were collected (e.g. marker-based kinematics, surface EMG)", "Electrode material, shape, size (if applicable, otherwise enter na)", "Measurement frequency [Hz]", "Range of sensor (if applicable)"]
software_processing = ["Name", "Manufacturer", "Version", "Type of data which were processed"]
software_analysis = ["Name", "Manufacturer", "Version (software and used packages)", "Type of data which were analyzed (kinematics, kinetics, EMG, accelerometer, IMU, EEG, plantar pressure, imaging, video)"]
stats_analyses = ["Statistical model", "Number of analyzed parameters", "Type of parameter (dependent)", "Type of parameter (independent)"]
tasks = ["Naming convention (abbreviation) of task e.g. Squat (sq)", "Description of task (If walking or running was performed: indicate gait speed)"]
sensors = ["Abbreviation e.g. L/RTHI", "Segment name e.g. Thigh", "Explanation marker/sensor placement e.g. half way down the lateral thigh"]
  
all_variables_collect_participant = {
    "Part 1.1: Data Collection - participant specific information" : "Message",
    "Identification number" : "not",
    "Date of data collection" : "not",
    "Age" : "not",
    "Gender" : "not",
    "Height" : "not",
    "Weight" : "not",
    "Leg length" : "not"
}

all_variables_collect_general = {
    "Part 1.2: Data Collection - general information (minimal)" : "Message",
    "Software(s) used for data collection" : "software_collection",
    "Hardware which was used for data collection" : "hardware_collection",
    "Study-specific inclusion criteria" : "repeated",
    "Study-specific exclusion criteria" : "repeated",
    "Task(s)" : "tasks",
    "Randomization of task order (yes/no)" : "not",
    "Name of marker model" : "not",
    "Reference to marker model" : "not",
    "Marker/sensor placement(s)" : "sensor",
    "Part 1.3: general information (if applicable, otherwise enter na)" : "Message",
    "Amplification of device" : "optional",
    "Calibration file" : "optional",
    "Calibration pose" : "optional",
    "Electrode-Skin Impedance" : "optional",
    "Signal-to-noise ratio" : "optional",
    "Mode of measurement device" : "optional",
    "Dynamic range of measurement device" : "optional",
    "Penetration depth" : "optional",
    "Preparation of the subject" : "optional",
    "Reference electrode" : "optional",
    "Synchronization method inter-unit" : "optional",
    "Synchronisation method for multiple measurement devices" : "optional",
    "Image resolution" : "optional",
    "Part 1.4: Data collection - Comments: If there are any additional comments you wish to record, please do so in the next prompt." : "Message",
    "Data collection: additional comment(s)" : "not"
}

all_variables_process = {
    "Part 2.1: Data Processing - general information" : "Message",
    "Date(s) of data processing (one value per participant)" : "repeated",
    "Software(s) used for data processing": "software_processing",
    "Sampling rate" : "not",
    "Quality check (if applicable, otherwise enter na)" : "not",
    "Part 2.2: Data Processing - EMG (if applicable, otherwise enter na)" : "Message",
    "Filter (EMG)" : "optional",
    "Rectification (EMG)" : "optional",
    "EMG amplitude processing" : "optional",
    "Normalization (EMG)" : "optional",
    "Exclusion of trials/muscles" : "optional",
    "Analyzed outcomes (EMG)" : "optional",
    "Part 2.3: Data Processing - EEG (if applicable, otherwise enter na)" : "Message",
    "Filter (EEG)" : "optional",
    "Re-referencing" : "optional",
    "Resampling" : "optional",
    "Artifact removal (EEG)" : "optional",
    "Data epoch extraction" : "optional",
    "Head model" : "optional",
    "File type after export (EEG)" : "optional",
    "Criteria for exclusion of data trials/single joints (EEG)" : "optional",
    "Part 2.4: Data Processing - Marker data (if applicable, otherwise enter na)" : "Message",
    "Labelling" : "optional",
    "Pipelines (marker data)" : "optional",
    "Events" : "optional",
    "Calculation method" : "optional",
    "Naming convention (marker data)" : "optional",
    "File type after export (marker data)" : "optional",
    "Criteria for the exclusion of trials/single joints (marker data)" : "optional",
    "Normalization (marker data)" : "optional",
    "Analyzed outcomes angles" : "optional",
    "Analyzed spatiotemporal outcomes" : "optional",
    "Part 2.5: Data Processing - Kinetics (if applicable, otherwise enter na)" : "Message",
    "Naming convention (kinetics)" : "optional",
    "Pipelines (kinetics)" : "optional",
    "File type after export (kinetics)" : "optional",
    "Criteria for exclusion of forces/moments" : "optional",
    "Normalization (kinetics)" : "optional",
    "Analyzed outcomes moments" : "optional",
    "Analyzed outcomes forces" : "optional",
    "Part 2.6: Data Processing - IMU (if applicable, otherwise enter na)" : "Message",
    "Naming convention (IMU)" : "optional",
    "Filter (IMU)" : "optional",
    "File type after export (IMU)" : "optional",
    "Normalization (IMU)" : "optional",
    "Analyzed outcomes (IMU)" : "optional",
    "Criteria for exclusion of trials (angles, forces, moments, etc.)" : "optional",
    "Kinematic model used (IMU)" : "optional",
    "Coordinate system (IMU)" : "optional",
    "Sensor fusion algorithm" : "optional",
    "Part 2.7: Data Processing - plantar pressure (if applicable, otherwise enter na)" : "Message",
    "Processing steps" : "optional",
    "Criteria for exclusion of trials" : "optional",
    "Analyzed outcomes (plantar pressure)" : "optional",
    "Part 2.8: Data Processing - imaging data (if applicable, otherwise enter na)" : "Message",
    "Applied algorithms for image processing" : "optional",
    "Criteria for exclusion of images" : "optional",
    "Analyzed outcomes (imaging data)" : "optional",
    "Part 2.9: Data Processing - 2D video (if applicable, otherwise enter na)" : "Message",
    "Calculation method for joint angles (if applicable, otherwise enter na)" : "optional",
    "Part 2.10: Data processing - Comments: If there are any additional comments you wish to record, please do so in the next prompt." : "Message",
    "Data processing: additional comment(s)" : "not"
}

all_variables_process_type = {
    "Part 2.1: Data Processing - general information" : "general",
    "Date(s) of data processing (one value per participant)" : "general",
    "Software(s) used for data processing": "general",
    "Sampling rate" : "general",
    "Quality check (if applicable, otherwise enter na)" : "general",
    "Part 2.2: Data Processing - EMG (if applicable, otherwise enter na)" : "EMG",
    "Filter (EMG)" : "EMG",
    "Rectification (EMG)" : "EMG",
    "EMG amplitude processing" : "EMG",
    "Normalization (EMG)" : "EMG",
    "Exclusion of trials/muscles" : "EMG",
    "Analyzed outcomes (EMG)" : "EMG",
    "Part 2.3: Data Processing - EEG (if applicable, otherwise enter na)" : "EEG",
    "Filter (EEG)" : "EEG",
    "Re-referencing" : "EEG",
    "Resampling" : "EEG",
    "Artifact removal (EEG)" : "EEG",
    "Data epoch extraction" : "EEG",
    "Head model" : "EEG",
    "File type after export (EEG)" : "EEG",
    "Criteria for exclusion of data trials/single joints (EEG)" : "EEG",
    "Part 2.4: Data Processing - Marker data (if applicable, otherwise enter na)" : "marker",
    "Labelling" : "marker",
    "Pipelines (marker data)" : "marker",
    "Events" : "marker",
    "Calculation method" : "marker",
    "Naming convention (marker data)" : "marker",
    "File type after export (marker data)" : "marker",
    "Criteria for the exclusion of trials/single joints (marker data)" : "marker",
    "Normalization (marker data)" : "marker",
    "Analyzed outcomes angles" : "marker",
    "Analyzed spatiotemporal outcomes" : "marker",
    "Part 2.5: Data Processing - Kinetics (if applicable, otherwise enter na)" : "kinetics",
    "Naming convention (kinetics)" : "kinetics",
    "Pipelines (kinetics)" : "kinetics",
    "File type after export (kinetics)" : "kinetics",
    "Criteria for exclusion of forces/moments" : "kinetics",
    "Normalization (kinetics)" : "kinetics",
    "Analyzed outcomes moments" : "kinetics",
    "Analyzed outcomes forces" : "kinetics",
    "Part 2.6: Data Processing - IMU (if applicable, otherwise enter na)" : "IMU",
    "Naming convention (IMU)" : "IMU",
    "Filter (IMU)" : "IMU",
    "File type after export (IMU)" : "IMU",
    "Normalization (IMU)" : "IMU",
    "Analyzed outcomes (IMU)" : "IMU",
    "Criteria for exclusion of trials (angles, forces, moments, etc.)" : "IMU",
    "Kinematic model used (IMU)" : "IMU",
    "Coordinate system (IMU)" : "IMU",
    "Sensor fusion algorithm" : "IMU",
    "Part 2.7: Data Processing - plantar pressure (if applicable, otherwise enter na)" : "plantar",
    "Processing steps" : "plantar",
    "Criteria for exclusion of trials" : "plantar",
    "Analyzed outcomes (plantar pressure)" : "plantar",
    "Part 2.8: Data Processing - imaging data (if applicable, otherwise enter na)" : "imaging",
    "Applied algorithms for image processing" : "imaging",
    "Criteria for exclusion of images" : "imaging",
    "Analyzed outcomes (imaging data)" : "imaging",
    "Part 2.9: Data Processing - 2D video (if applicable, otherwise enter na)" : "2dvideo",
    "Calculation method for joint angles (if applicable, otherwise enter na)" : "2dvideo",
    "Part 2.10: Data processing - Comments: If there are any additional comments you wish to record, please do so in the next prompt." : "general",
    "Data processing: additional comment(s)" : "general"
}

all_variables_analyze = {
    "Part 3.1: Data Analysis - general information" : "Message",
    "Date of data analysis" : "not",
    "Software(s) used for data analysis": "software_analysis",
    "Statistical analysis" : "stats",
    "Part 3.2: Data Analysis - Analysis of imaging data (if applicable, otherwise enter na)" : "Message",
    "Statistical analysis (if performed)" : "stats",
    "Part 3.3: Data analysis - Comments: If there are any additional comments you wish to record, please do so in the next prompt." : "Message",
    "Data analysis: additional comment(s)" : "not"
}

all_variables_share = {
    "Part 4.1: Data Sharing - general information" : "Message",
    "Date of data publication" : "not",
    "Used data format(s)": "repeated",
    "Licence type for data reuse" : "not",
    "Stage of data processing" : "not",
    "Storage location/ name of file for nomenclature" : "not",
    "Part 4.2: Data Sharing - Information on encoding/anonymization" : "Message",
    "Encoding/ anonymization of personal data" : "not",
    "Anonymization of quantitative movement data" : "not",
    "Part 4.3: Data Sharing - Information on the data content (description of single files)" : "Message",
    "Information on data collection" : "not",
    "Information on participants/their characteristics" : "not",
    "Information on movement data" : "not",
    "Part 4.4: Data Sharing - Information on data analysis" : "Message",
    "Repository/ location where the data has been stored" : "not",
    "Part 4.5: Data Sharing - Comments: If there are any additional comments you wish to record, please do so in the next prompt." : "Message",
    "Data sharing: additional comment(s)" : "not"
}
multiple_entries = [name for name, key in all_variables_collect_participant.items() if key == "repeated"] \
    + [name for name, key in all_variables_collect_general.items() if key == "repeated"] \
        + [name for name, key in all_variables_process.items() if key == "repeated"] \
            + [name for name, key in all_variables_analyze.items() if key == "repeated"] \
                + [name for name, key in all_variables_share.items() if key == "repeated"]

def save_data(data_processed, extra, popup=False):
    #Inform the user about the saving of the data
    if popup:
        tkinter.messagebox.showwarning("User input", "Data saving")
    else:
        print("Data saving")

    # Write the output to a new file, with the user specifying the name
    continue_save = True
    while True:
        output_text = trycatch_null("Enter the output file name (without extension): ", popup)
        if output_text is None:
            continue_save = False
            #Inform the user that the saving has been cancelled
            if popup:
                tkinter.messagebox.showwarning("User input", "The saving of the data has been cancelled by the user.")
            else:
                print("The saving of the data has been cancelled by the user.")
            break

        else:
            name_output_file = "Output/" + output_text + extra + ".csv"
            if os.path.isfile(name_output_file):
                if popup:
                    validate_file = tkinter.simpledialog.askstring("User input", "File already exists, do you wish to overwrite it? (y/n): ").lower().strip()
                else:
                    validate_file = input("File already exists, do you wish to overwrite it? (y/n): ").lower().strip()
                if validate_file == "y" or validate_file == "yes":
                    break
            else:
                break
            
    if continue_save:
        data_processed.to_csv(
            sep=";", header=False, index=False, path_or_buf=name_output_file, na_rep="",quoting=csv.QUOTE_NONE, quotechar=None, escapechar="\\"
        )

# 2. Create a main function to read in data, process, and write the output to a file
def main():
    #Inform the user about leaving parts empty
    if popup:
        ROOT = tkinter.Tk()
        ROOT.withdraw()
        tkinter.messagebox.showwarning("User input", "Please enter the data into the prompts. If you do not have the data, or if it is not applicable, please enter 'na'. Note that if you press 'cancel' at any point, the program will stop and output may not be saved.")
    else:
        print("Please enter the data into the prompts. If you do not have the data, or if it is not applicable, please enter 'na'. Note that if you press 'cancel' at any point, the program will stop and output may not be saved.")

    # First ask the user which part of the metadata will be filled out: all, collect, process, analyze, or share
    part_metadata = trycatch_null("Which part of the metadata will be filled out (all, collect (participant data), collect (general data), process, analyze, share)?", popup)
    if part_metadata is None:
        if popup:
            tkinter.messagebox.showwarning("User input", "Input cancelled by user, program will be terminated.")
        else:
            print("Input cancelled by user, program will be terminated.")
        sys.exit()
    else:
        part_metadata = part_metadata.lower().strip()

    # Check if the user input is valid
    while part_metadata not in ["all", "collect (participant data)", "collect (general data)", "process", "analyze", "share"]:
        part_metadata = trycatch_null("Which part of the metadata will be filled out (all, collect (participant data), collect (general data), process, analyze, share)?", popup)
        if part_metadata is None:
            if popup:
                tkinter.messagebox.showwarning("User input", "Input cancelled by user, program will be terminated.")
            else:
                print("Input cancelled by user, program will be terminated.")
            sys.exit()
        else:
            part_metadata = part_metadata.lower().strip()

    # Create the output folder, if it does not exists
    if not os.path.isdir("Output"):
        os.makedirs("Output")

    # Read in the correct input file based on the user input, process it, and save the output
    if part_metadata == "collect (participant data)":
        data = pandas.read_csv("Input/Metadata_Template_Collect_Participant.csv", sep=";", header=None)
        data_processed = create_df(data, popup, part="collect (participant data)", all_variables_process_use={})
        save_data(data_processed, "_collect_participant", popup)
    elif part_metadata == "collect (general data)":
        data = pandas.read_csv("Input/Metadata_Template_Collect_General.csv", sep=";", header=None)
        data_processed = create_df(data, popup, part="collect (general data)", all_variables_process_use={})
        save_data(data_processed, "_collect_general", popup)
    elif part_metadata == "process":
        data = pandas.read_csv("Input/Metadata_Template_Process.csv", sep=";", header=None)
        all_variables_process_use = check_optional_data(all_variables_process, all_variables_process_type, popup)
        data_processed = create_df(data, popup, part="process", all_variables_process_use=all_variables_process_use)
        save_data(data_processed, "_process", popup)
    elif part_metadata == "analyze":
        data = pandas.read_csv("Input/Metadata_Template_Analyze.csv", sep=";", header=None)
        data_processed = create_df(data, popup, part="analyze", all_variables_process_use={})
        save_data(data_processed, "_analyze", popup)
    elif part_metadata == "share":
        data = pandas.read_csv("Input/Metadata_Template_Share.csv", sep=";", header=None)
        data_processed = create_df(data, popup, part="share", all_variables_process_use={})
        save_data(data_processed, "_share", popup)
    else:
        data = pandas.read_csv("Input/Metadata_Template_Collect_Participant.csv", sep=";", header=None)
        data_processed = create_df(data, popup, part="collect (participant data)", all_variables_process_use={})
        save_data(data_processed, "_collect_participant", popup)
        data = pandas.read_csv("Input/Metadata_Template_Collect_General.csv", sep=";", header=None)
        data_processed = create_df(data, popup, part="collect (general data)", all_variables_process_use={})
        save_data(data_processed, "_collect_general", popup)
        all_variables_process_use = check_optional_data(all_variables_process, all_variables_process_type, popup)
        data_process = pandas.read_csv("Input/Metadata_Template_Process.csv", sep=";", header=None)
        data_process_processed = create_df(data_process, popup, part="process", all_variables_process_use=all_variables_process_use)
        save_data(data_process_processed, "_process", popup)
        data_analyze = pandas.read_csv("Input/Metadata_Template_Analyze.csv", sep=";", header=None)
        data_analyze_processed = create_df(data_analyze, popup, part="analyze", all_variables_process_use={})
        save_data(data_analyze_processed, "_analyze", popup)
        data_share = pandas.read_csv("Input/Metadata_Template_Share.csv", sep=";", header=None)
        data_share_processed = create_df(data_share, popup, part="share", all_variables_process_use={})
        save_data(data_share_processed, "_share", popup)


# 3) Create a function to query about the software and hardware used
def query_software_hardware(variable, i, popup=False):
    #Create a string to store the output
    if variable == "Software(s) used for data collection":
        variable_list = software_collection
        output_str = "Software " + str(i+1) + ": "
    elif variable == "Hardware which was used for data collection":
        variable_list = hardware_collection
        output_str = "Hardware " + str(i+1) + ": "
    elif variable == "Software(s) used for data processing":
        variable_list = software_processing
        output_str = "Software " + str(i+1) + ": "
    elif variable == "Statistical analysis (if performed)" or variable == "Statistical analysis":
        variable_list = stats_analyses
        output_str = "Statistical analysis " + str(i+1) + ": "
    elif variable == "Task(s)":
        variable_list = tasks
        output_str = "Task " + str(i+1) + ": "
    elif variable == "Marker/sensor placement(s)":
        variable_list = sensors
        output_str = "Sensor/marker " + str(i+1) + ": "
    else:
        variable_list = software_analysis
        output_str = "Software " + str(i+1) + ": "

    #Ask the user to input the variables for the software/hardware and add them to the strin, separated by a comma
    continue_process = True
    for var in variable_list:
        if output_str.startswith("Software"):
            message = "Enter the " + var + " for software " + str(i+1) + ": "
        elif output_str.startswith("Statistical analysis"):
            message = "Enter the " + var + " for statistical analysis " + str(i+1) + ": "
        elif output_str.startswith("Task"):
            message = "Enter the " + var + " for task " + str(i+1) + ": "
        elif output_str.startswith("Sensor/marker"):
            message = "Enter the " + var + " for sensor/marker " + str(i+1) + ": "
        else:
            message = "Enter the " + var + " for hardware " + str(i+1) + ": "
        value_entered = trycatch_null(message, popup)
        if value_entered is None:
            continue_process = False
            break
        output_str = output_str + "[" + var + "] " + value_entered + " - "
    
    #Remove the last dash from the string
    output_str = output_str[:-2]

    #Return the output string
    return output_str

# 3) Create a function to generate the message, and query the user based on that message
def query_user(variable, dataframe, reference_dict, popup=False, extra = ""):
    
    # select the relevant row
    relevant_row = dataframe[dataframe[0] == variable]

    # Create the base message, based on whether the variable starts with "if applicable"
    if  reference_dict[variable] == "optional" and "if applicable" not in variable:
        base_message = (extra +
            "If applicable, enter the "
            + variable
            + " (otherwise enter 'na')"
        )
    else:
        base_message = extra + "Enter the " + variable

    # Next, add the unit, if there is one listed
    try:
        base_message = base_message + " (" + relevant_row.iat[0, 1] + ")"
    except TypeError:
        pass

    # Then add any comments if applicable
    try:
        base_message = base_message + "; Comment: " + relevant_row.iat[0, 2]
    except TypeError:
        pass

    # Add the final ": "
    base_message = base_message + ": "

    # Next, query the user, either via popup or via the command line
    # First check those versions where numeric values need to be checked
    if variable in numeric_entries:
        while True:
            value_entered = trycatch_null(base_message, popup)
            if value_entered is None:
                return None
            else:
                try:
                    if value_entered == "na":
                        break
                    else:
                        value_entered = str(float(value_entered))
                        break
                except ValueError:
                    if popup:
                        tkinter.messagebox.showwarning("User input", "Please enter a numeric value for " + variable)
                    else:
                        print("Please enter a numeric value for " + variable)

    else:
        value_entered = trycatch_null(base_message, popup)

    # Check if the variable needs to be rounded, and do so
    if not value_entered is None:
        if variable in rounding_entries and value_entered != "na":
            value_entered = round_to_n(value_entered, reference_dict, variable, n=2)

    # Finally, return the output
    return value_entered

# 4. Create a function to round a value to a certain number of decimal places
def round_to_n(value, reference_dict, variable, n=2):
    if reference_dict[variable] == "repeated":
        if ";" in value:
            values = value.split(";")
            rounded_values = [round(float(val), n) for val in values]
            return "; ".join(["%.2f" % val for val in rounded_values])
        else:
            if value != "" and value != "na":
                return "%.2f" % round(float(value), n)
            else:
                return "na"
    else:
        if value != "" and value != "na":
            return "%.2f" % round(float(value), n)
        else:
            return "na"

# 5. Query the user for the inputs needed to create the output dataframe
def create_df(dataframe, popup, part, all_variables_process_use):
    #Create a variable to check if the process needs to be continued or not
    continue_process = True

    #Check which part of the metadata is being filled out
    if part == "collect (participant data)":
        all_variables_named = all_variables_collect_participant
    elif part == "collect (general data)":
        all_variables_named = all_variables_collect_general
    elif part == "process":
        all_variables_named = all_variables_process_use
    elif part == "analyze":
        all_variables_named = all_variables_analyze
    else:
        all_variables_named = all_variables_share

    #Make a variable to check if the imaging data needs to be entered in analyze
    imaging_TF = False

    if all_variables_named is None:
        continue_process = False
    else:
        #Loop over the variables and query the user for the input
        for var_name in all_variables_named.keys():

            #Check if imaging is in the df for analyze --> softwares
            if var_name == "Part 3.2: Data Analysis - Analysis of imaging data (if applicable, otherwise enter na)":
                #Ask the user if imaging data has been collected
                imaging_collected = trycatch_null("Was imaging data analyzed? Enter 'yes' or 'no': ", popup)
                if imaging_collected is None:
                    continue_process = False
                    break
                else:
                    imaging_collected = imaging_collected.lower().strip()

                #Check if the user input is valid
                while imaging_collected != "yes" and imaging_collected != "no":
                    imaging_collected = trycatch_null("Please enter a valid option (yes/no): ", popup)
                    if imaging_collected is None:
                        continue_process = False
                        break
                    else:
                        imaging_collected = imaging_collected.lower().strip()
                
                #Check if the process needs to be continued
                if not continue_process:
                    break
                if imaging_collected == "yes":
                    imaging_TF = True
            
            #Create a message if it's just a message variable
            if (all_variables_named[var_name] == "Message" and var_name != "Part 3.2: Data Analysis - Analysis of imaging data (if applicable, otherwise enter na)") or (all_variables_named[var_name] == "Message" and var_name == "Part 3.2: Data Analysis - Analysis of imaging data (if applicable, otherwise enter na)" and imaging_TF == True):
                if popup:
                    tkinter.messagebox.showwarning("User input", var_name)
                else:
                    print(var_name)
            
            #Cases where the variable is not repeated
            elif all_variables_named[var_name] == "not" or all_variables_named[var_name] == "optional":
                output_text = query_user(
                    var_name, dataframe, all_variables_named, popup
                    )
                if not output_text is None:
                    dataframe.loc[dataframe[0] == var_name, 3] = output_text
                else:
                    continue_process = False
                    break
            
            #Cases where a software is added
            elif all_variables_named[var_name] in ["software_collection", "hardware_collection", "software_processing", "software_analysis", "stats", "tasks", "sensor"]:
                if (var_name != "Statistical analysis (if performed)" or (var_name == "Statistical analysis (if performed)" and imaging_TF == True)):
                    if all_variables_named[var_name] == "hardware_collection":
                        message_word = "hardware"
                    elif all_variables_named[var_name] == "stats":  
                        message_word = "statistical analysis"
                    elif all_variables_named[var_name] == "tasks":
                        message_word = "task"
                    elif all_variables_named[var_name] == "sensor":
                        message_word = "sensor/marker"
                    else:
                        message_word = "software"
                    #Check how many softwares need to be added
                    while True:
                        number_soft = trycatch_null("How many " + message_word + " do you wish to record? ", popup)
                        if number_soft is None:
                            continue_process = False
                            break
                        try:
                            number_soft = int(number_soft)
                            break
                        except ValueError:
                            if popup:
                                tkinter.messagebox.showwarning("User input", "Please enter an integer value (>=0).")
                            else:
                                print("Please enter an integer value (>=0).")
                    if not continue_process:
                        break
                            
                    #Loop over the number of softwares, and add to the dataframe
                    continue_process = True
                    for i in range(number_soft):
                        output_text = query_software_hardware(var_name, i, popup)
                        if output_text is None:
                            continue_process = False
                            break
                        if i == 0:
                            dataframe.loc[dataframe[0] == var_name, 3] = output_text
                        else:
                            dataframe.loc[dataframe[0] == var_name, 3] = dataframe.loc[dataframe[0] == var_name, 3] + "\n;;;" + output_text

                    if not continue_process:
                        break

            #Cases that are repeated but are not software/hardware
            elif all_variables_named[var_name] != "Message":
                continue_process = True
                #Check how many values need to be added
                while True:
                    number_inc = trycatch_null("How many " + var_name + " do you wish to record? ", popup)

                    if number_inc is None:
                        continue_process = False
                        break
                    try:
                        number_inc = int(number_inc)
                        break
                    except ValueError:
                        if popup:
                            tkinter.messagebox.showwarning("User input", "Please enter an integer value (>=0)")
                        else:
                            print("Please enter an integer value (>=0)")
                
                if not continue_process:
                    break

                #Loop over the number of values, and add to the dataframe
                continue_process = True
                for i in range(number_inc):
                    output_text =  query_user(
                            var_name, dataframe, all_variables_named, popup, extra=var_name + " " + str(i+1) + ": "
                        )
                    if output_text is None:
                        continue_process = False
                        break

                    if i == 0:
                        dataframe.loc[dataframe[0] == var_name, 3] = output_text
                    else:
                        dataframe.loc[dataframe[0] == var_name, 3] = dataframe.loc[dataframe[0] == var_name, 3] + "\n;;;" + output_text

                if not continue_process:
                    break

    #In case the output got terminated, provide an information comment
    if not continue_process:
        if popup:
            tkinter.messagebox.showwarning("User input", "The text-input was cancelled by the user. The input process will therefore be terminated, and input entered so far saved.")
        else:
            print("The text-input was cancelled by the user. The input process will therefore be terminated, and input entered so far saved.")

    # Return the dataframe
    return dataframe

# Create a function to check which types of optional data have been processed, and filter the reference data accordingly ####
def check_optional_data(all_variables_process, all_variables_process_type, popup):
    continue_process = True
    # Ask the user if EMG data has been collected
    emg_collected = trycatch_null("Has EMG data been collected? (yes/no): ", popup)
    if emg_collected is None:
        continue_process = False
    else:
        emg_collected = emg_collected.lower().strip()
    # Check if the user input is valid
    while emg_collected != "yes" and emg_collected != "no":
        emg_collected = trycatch_null("Please enter a valid option (yes/no): ", popup)
        if emg_collected is None:
            continue_process = False
            break
        else:
            emg_collected = emg_collected.lower().strip()

    # Do the same for the EEG data
    eeg_collected = trycatch_null("Has EEG data been collected? (yes/no): ", popup)
    if eeg_collected is None:
        continue_process = False
    else:
        eeg_collected = eeg_collected.lower().strip()
    # Check if the user input is valid
    while eeg_collected != "yes" and eeg_collected != "no":
        eeg_collected = trycatch_null("Please enter a valid option (yes/no): ", popup)
        if eeg_collected is None:
            continue_process = False
            break
        else:
            eeg_collected = eeg_collected.lower().strip()

    # Then do the same for the marker data
    marker_collected = trycatch_null("Has marker data been collected? (yes/no): ", popup)
    if marker_collected is None:
        continue_process = False
    else:
        marker_collected = marker_collected.lower().strip()
    # Check if the user input is valid
    while marker_collected != "yes" and marker_collected != "no":
        marker_collected = trycatch_null("Please enter a valid option (yes/no): ", popup)
        if marker_collected is None:
            continue_process = False
            break
        else:
            marker_collected = marker_collected.lower().strip()

    # Then do the same for the kinetics data
    kinetics_collected = trycatch_null("Has kinetics data been collected? (yes/no): ", popup)
    if kinetics_collected is None:
        continue_process = False
    else:
        kinetics_collected = kinetics_collected.lower().strip()
    # Check if the user input is valid
    while kinetics_collected != "yes" and kinetics_collected != "no":
        kinetics_collected = trycatch_null("Please enter a valid option (yes/no): ", popup)
        if kinetics_collected is None:
            continue_process = False
            break
        else:
            kinetics_collected = kinetics_collected.lower().strip()

    # Then do the same for the IMU data
    imu_collected = trycatch_null("Has IMU data been collected? (yes/no): ", popup)
    if imu_collected is None:
        continue_process = False
    else:
        imu_collected = imu_collected.lower().strip()
    # Check if the user input is valid
    while imu_collected != "yes" and imu_collected != "no":
        imu_collected = trycatch_null("Please enter a valid option (yes/no): ", popup)
        if imu_collected is None:
            continue_process = False
            break
        else:
            imu_collected = imu_collected.lower().strip()

    # Then do the same for plantar pressure data
    pressure_collected = trycatch_null("Has plantar pressure data been collected? (yes/no): ", popup)
    if pressure_collected is None:
        continue_process = False
    else:
        pressure_collected = pressure_collected.lower().strip()
    # Check if the user input is valid
    while pressure_collected != "yes" and pressure_collected != "no":
        pressure_collected = trycatch_null("Please enter a valid option (yes/no): ", popup)
        if pressure_collected is None:
            continue_process = False
            break
        else:
            pressure_collected = pressure_collected.lower().strip()

    # Then do the same for imaging data
    imaging_collected = trycatch_null("Has imaging data been collected? (yes/no): ", popup)
    if imaging_collected is None:
        continue_process = False
    else:
        imaging_collected = imaging_collected.lower().strip()
    # Check if the user input is valid
    while imaging_collected != "yes" and imaging_collected != "no":
        imaging_collected = trycatch_null("Please enter a valid option (yes/no): ", popup)
        if imaging_collected is None:
            continue_process = False
            break
        else:
            imaging_collected = imaging_collected.lower().strip()

    # Then do the same for 2D video data
    video2d_collected = trycatch_null("Has 2D video data been collected? (yes/no): ", popup)
    if video2d_collected is None:
        continue_process = False
    else:
        video2d_collected = video2d_collected.lower().strip()
    # Check if the user input is valid
    while video2d_collected != "yes" and video2d_collected != "no":
        video2d_collected = trycatch_null("Please enter a valid option (yes/no): ", popup)
        if video2d_collected is None:
            continue_process = False
            break
        else:
            video2d_collected = video2d_collected.lower().strip()

    #Finally, filter the "all_variables_process" list based on the user input
    if emg_collected == "no":
        all_variables_process_type = {k: v for k, v in all_variables_process_type.items() if v != "EMG"}
    if eeg_collected == "no":
        all_variables_process_type = {k: v for k, v in all_variables_process_type.items() if v != "EEG"}
    if marker_collected == "no":
        all_variables_process_type = {k: v for k, v in all_variables_process_type.items() if v != "marker"}
    if kinetics_collected == "no":
        all_variables_process_type = {k: v for k, v in all_variables_process_type.items() if v != "kinetics"}
    if imu_collected == "no":
        all_variables_process_type = {k: v for k, v in all_variables_process_type.items() if v != "IMU"}
    if pressure_collected == "no":
        all_variables_process_type = {k: v for k, v in all_variables_process_type.items() if v != "plantar"}
    if imaging_collected == "no":
        all_variables_process_type = {k: v for k, v in all_variables_process_type.items() if v != "imaging"}
    if video2d_collected == "no":
        all_variables_process_type = {k: v for k, v in all_variables_process_type.items() if v != "2dvideo"}
    
    all_variables_process = {k: v for k, v in all_variables_process.items() if k in all_variables_process_type.keys()}

    #Return the filtered dict
    if continue_process:
        return all_variables_process
    else:
        return None

#Create a function that does a try-catch when entering data, to catch a "cancel" or interrupted input
def trycatch_null(display_text, popup=True):

    if popup:
        #Get the input from the user
        ROOT = tkinter.Tk()
        ROOT.withdraw()
        value_entered = tkinter.simpledialog.askstring("User input", display_text)

        # if the user cancelled, return a None type (NULL) object
        if value_entered is None:
            return None
        else:
            return value_entered
    else:
        value_entered = input(display_text)

        # if the user cancelled, return a None type (NULL) object
        if value_entered is None:
            return None
        else:
            return value_entered

    

if __name__ == "__main__":
    main()
