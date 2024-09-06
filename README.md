# MoveD Metadata Template generator

## About the template generator
This repository contains input documents (.csv), as well as code (for R and Python) to generate templates for metadata for research projects of movement laboratories. You can generate templates for specific parrs of the data lifecycle (data collection, processing, analysis, and publication), or for everything at once. For more information, and extensive documentation, of all information that should/could be included in the metadata, see the [Open Research Data Guidelines for Movement Laboratories Zenodo Community](https://zenodo.org/communities/moved/records?q=&l=list&p=1&s=10&sort=newest).

## How to use
* Clone the repository on your device.
* Run (depending on preference) the Python or R script. Make sure that the working directory for running the script is the main folder of the repository.
* Fill out the prompts with the requested inputs. (Note: on preference, you can answer the prompts on the command line interface instead of pop-ups, by disabling the pop-up setting at the top of either script.
* When prompted, provide a name for the output file. Note that file extension and an extension for the part of the metadata (e.g. _analyse) will automatically be added.
* The script will generate an "output" folder in the main local folder of the repository, where your metadata templates will be stored.
* You can run the script as many times as you like, to generate all metadata files you need.