# octopusNiche
Code and data input to replicate the article "Climate change effect on Octopus maya (Voss and Solís-Ramírez, 1966) suitability and distribution in the Yucatan Peninsula, Gulf of Mexico: A correlative and mechanistic approach".

In order to replicate the results of this study, open the octopusNiche.Rproj and follow the order provided in the code folder:

* 0) 0_auxiliar_functions.R (You do not need to run this code. It will be called from the following scripts).

* 1) 1_niche_model_maxent.R

* 2) 2_binary_maps.R

* 3) 3_physiology_maps.R

All the scripts have comments for an easy understanding of the process.

Nevertheless, you need to download maxent software from: https://biodiversityinformatics.amnh.org/open_source/maxent/. After that **you have to create a folder named maxent**, inside this folder there will be: **maxent.bat, maxent.jar, maxent.sh, readme.txt**.

Also, you need to install *kuenm* package. Please follow the instructions provided in this link: https://github.com/marlonecobos/kuenm


Example of the files structure:

- code

- dataset

- G_variables

- M_variables

- **maxent**

- octopusNiche.Rproj

- README.md


If you want to replicate the maps or other plots of the paper, contact to Luis Enrique Angeles-González (luis.angeles0612@gmail.com) or Josymar Torrejón-Magallanes (ejosymart@gmail.com).

For Mac users: Before install the kuenm package, follow these instructions to install Xcode on your Mac: https://clanfear.github.io/CSSS508/docs/compiling.html
Xcode will replace RTools.

If you find any problem in the code, please add this at the Issues section of the github.