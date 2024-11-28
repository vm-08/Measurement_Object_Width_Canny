# Project Results and Overview
### Objective 
This project aims to develop an application that accurately determines the width of objects by detecting their edges. The edge detection algorithm is mostly based on the Canny method, as it is particularly suitable due to its multi-stage processing, including noise reduction and gradient calculation. Therefore, the primary objective is the implementation of a system that will reliably detect the boundaries of an object in the data set and calculate the width in a metric unit, in this case Milimeters, based on the distance of the ascertained edges. 
The code is implemented for two types of objects (a dowel pin and a Bosch Rexroth Aluminium Profile) and three different widths. In case of the dowel pin the diameter is determined, whereas for the Bosch profile the outer and inner width are calculated. These assessed dimensions are depicted in the following figures which are generated when the code is run. To achieve more accurate results the algorithm computes the width by detecting the edges over multiple rows in each image and the average of the subsequently calculated distances comprises the determined object width. The first utilized line is drawn in blue, whereas the red indicators at the borders display all lines used for the calculation. 

<p align="left">
  <img src="https://github.com/user-attachments/assets/f7d45d4e-18af-4be1-88a2-2b2914b205bc" alt="dowel pin" width="500"/>
</p>

_Figure 1: Dowel Pin - diameter_


<p align="left">
  <img src="https://github.com/user-attachments/assets/d23b949f-9a8b-4d9f-90af-c1b5c95076da" alt="profile inner width" width="500"/>
</p>

_Figure 2: Bosch Rexroth Aluminium Profile - inner width_ 


<p align="left">
  <img src="https://github.com/user-attachments/assets/b97226d3-d255-47c8-99af-2641dde01427" alt="profile outer width" width="500"/>
</p>

_Figure 3: Bosch Rexroth Aluminium Profile - outer width_


### Results
As mentioned before, the result for the width and the measurement uncertainity, which is calculated according to the Gaussian error propagation, are presented in mm as it is the most convenient unit for the real object dimensions.
The dowel pin has a given diameter of 8 mm and the result of the computation is 8.0281 mm with an uncertainity of 0.0031 mm leading to an accuracy of 99.65 %. The Bosch Rexroth profile has an outer width of 30.5 mm and inner width of 12.1 mm. The algorithm calculates an outer width of 30.1649 mm with an uncertainity of 0.0923 mm and inner width of 12.1673 mm with an uncertainity of 0.0900 mm. Therefore, the accuracy comes up to 99.62 % for the former and 99.45 % for the latter dimension. In total this results in an average accuracy of 99.57 %. Comparing the results to the given dimensions, one can conclude that the determined values are slightly higher than the actual values. The possible causes for this deviation are discussed under "Issues and Contributions". Nevertheless, the accuracy rate of over 99 % suggests that this project is heading towards the right direction and, with a few improvements in the future, will aid in precisely determining object dimensions.

### Motivation and significance
Knowing the exact dimensions of an object is of profound significance in an abundance of fields such as quality control, analysis and automation. Common measurement methods, for example, using mechanical measuring instruments, are typically time-consuming and expensive due to the extensive measurement setup. In contrast to mechanical measuring instruments, which require a different measuring tool depending on the object (for example when the surface is round or flat), the necessary setup for this project merely consists of a camera, telecentric lighting and computer enabling a considerably more versatile method to determine the object dimensions.
Thus, there is a substantial need for a non-invasive, optical method providing fast and comparably cost-effective results from digital images being addressed by this application. 

### Insights
The combination of using a Gaussian filter to reduce noise in the image, evaluating several lines of the image and running the Hampel test to detect outliers immensely decreased the impact of minor variations (such as noise or dirt on the lense) on the measurement making the edge detection more robust. Hence, the results are more reliable. The use of interpolation refines the localization of the edge as it estimates the position of maxima and minima more accurately. However, there are limitations as objects with more complex contours (as the Bosch Rexroth profile) are more error prone, as they could be misaligned to the camera which can't be assessed by merely analyzing the images. Generally speaking, this algorithm also requires a clear background as clutter will affect the quality of the edge detection distorting the results by misinterpreting background clutter as the required edges. These issues are further evaluated under "Issues and Contributions". 


# Source code
### Instructions
The source code is provided as an m-file titled "Measurement_of_object_width", which can be run using MATLAB. There are two toolboxes which need to be installed before the code can executed on MATLAB: "Image Processing Toolbox" and "Statistics and Machine Learning Toolbox". These can be easily installed by using the Add-on Manager. To check which toolboxes are already added, type in "ver" into the command window.
Additionally, the dataset can be found inside the folder "dataset" consisting of the two separate folders "Bosch Rexroth Profile" and "Dowel Pin". It is recommended to simply clone the repository (see "Installation") so that the source code and dataset share the same path. This ensures that the source code can easily locate the images through the directory and makes choosing the source for the images more convenient.

### Structure
```plaintext
Measurement_Object_Width_Canny
├── dataset/                         # contains datasets for both objects
│   ├── Bosch Rexroth Profile.zip    # for the two widths of the Bosch profile
│   └── Dowel Pin.zip                # for the diameter of the dowel pin
└── Measurement_of_object_width.m/   # source code to calculate object width 
```

### Brief algorithm description
After manually selecting the directory, the images are loaded and the first row to analyze is determined. Each row of the image is filtered using a Gaussian filter to smooth the image and reduce noise. Subsquently, the gradient of each filtered line is computed by differentiating the line profile. The edge is then located using interpolation, where the second derivative of the gradient helps finding the extrema. Afterwards it is possible to calculate the width based on the distance between the detected edges. This process is repeated for 50 lines and each image. The Hampel test is included to omit outliers which would negatively affect the result. The average of these pixel results is then converted into mm by using the magnification of the utilized camera lense. Lastly, two figures are generated. The first one visualizes the image and depicts the first row (blue) and all used lines (red). The second figure shows the means and standard deviations across all images to help analyze the algorithms performance. The code is mostly the same for each width, with the exception that the area, in which the edges are searched for, is restricted for the Bosch profile so that solely the edges required for each width are detected (see "Issues and Contributions"). 


# Performance Metrics
As described in the results, the algorithm achieves an average accuracy of 99.57% and the code requires a maximum of 1.60 seconds to be executed after the user selected the directory. In the subsequent diagrams, the calculated width and its standard deviation or each image are depicted as well the total mean and standard deviation (in red). The values are displayed in pixels to simplify the use of the code.
<p align="left">
  <img src="https://github.com/user-attachments/assets/b0e3c62f-4543-43fb-bc7e-405e981d1edc" alt="dowel pin" width="500"/>
</p>

_Figure 4: Means and standard deviations of the invidual images for the dowel pin_ 

<p align="left">
  <img src="https://github.com/user-attachments/assets/ba706bdd-a9ef-4b2e-a887-748bea90d12e" alt="dowel pin" width="500"/>
</p>
  
_Figure 5: Means and standard deviations of the invidual images for the inner width of the Bosch profile_   

<p align="left">
  <img src="https://github.com/user-attachments/assets/4d04dce9-87a0-49e8-b2e8-006fdef4336a" alt="dowel pin" width="500"/>
</p>

_Figure 6: Means and standard deviations of the invidual images for the outer width of the Bosch profile_   

In case of the dowel pin the standard deviation of the average is signficantly smaller compared to the standard deviations of the average widths for the profile. The object was rotated and repositioned after each image. The effect of a higher rotation angle can be clearly seen after for example the first five images in the diagram of the dowel pin. However, as the values are displayed in pixels, the change consists of mere µm which is within the tolerance class of the dowel pin. As for the Bosch Rexroth profile one can infer, that the values are spread over a higher range especially in the case of the outer width, with overall larger standard deviations leading to a lower accuracy than the dowel pin calculation. Possible reasons and improvements are presented in the last two sections of the README.


# Installation and Usage
### Prerequisite
MATLAB version 2014b or newer.

### Installation
1. Clone the repository:
```plaintext
git clone https://github.com/vm-08/Measurement_Object_Width_Canny
cd Measurement_Object_Width_Canny
```
2. Ensure all necessary MATLAB toolboxes are installed
- "Image Processing Toolbox"
- "Statistics and Machine Learning Toolbox"
The toolboxes can be installed by clicking "Add-ons" and selecting "Get Add-ons" in MATLAB. This will open the Add-on Explorer where you can search and install the toolboxes.
  
3. Open the m-file in MATLAB and run the code

### Usage
The project contains the necessary code to calculate each of the widths, however, only the part for one width should be active during the determination. Thus, the other two parts are commented out. Dowel pin code: from line 15 to line 74, Bosch Rexroth profile inner width: from line 75 to line 136, Bosch Rexroth profile outer width: from line 137 to line 196. 
The lines before and after these parts are used for all three widths and should therefore, be active at all times. Consequently, the code for the desired width needs to be uncommented, whereas the other two parts must be commented out before running the project. The parts are divided with a "separation" line and title for better readability. 

When pressing "Run" a screen will pop up with the directory of the source file. This is where you choose the folder with the images for the object you want to calculate the width for. 
Afterwards, the code will automatically print the result and its uncertainity in mm in the command window as well as generate the figures shown in "Project Results and Overview" and the performance diagrams (as depicted in "Performance Metrics"). 


# References and Documents
### Reference Papers
1. [A Computational Approach to Edge Detection](https://ieeexplore.ieee.org/document/4767851) _Canny, J., “A Computational Approach to Edge Detection“, IEEE Transactions
on Pattern Analysis and Machine intelligence, Vol.8, No.6, 1986._
2. [Geometric Image Edge Detection Techniques](https://archive.org/details/4.InformationGeometricImageWadahM.ElNini) _Abdel-All, N. H., Soliman, M.A., Hussien, R. A., El-Nini, Wadah M., “Geometric
Image Edge Detection Techniques“, International Journal of Information Systems
Management Research and Development (IJISMRD), Vol.4, Issue 2, 2014._
3. [A Survey on Edge Detection Methods](https://citeseerx.ist.psu.edu/document?repid=rep1&type=pdf&doi=bf85df5658befb4f2b485bae849841cafe67b130) _Oskoei, M. A., Hu, H. “A Survey on Edge Detection Methods“, Technical Report:
CES-506, School of Computer Science and Electronic Engineering, University of
Essex, 2010._
4. [Study and Comparison of Various Image Edge Detection Techniques](https://www.cscjournals.org/manuscript/Journals/IJIP/Volume3/Issue1/IJIP-15.pdf) _Maini, R., Aggarwal, H., “Study and Comparison of Various Image Edge
Detection Techniques“, International Journal of Image Processing (IJIP), Vol.3,
Issue 1, 2009._

### Dataset
The used dataset is available under the folder /dataset and is split into two separate folders. One containing the images for the dowel pin and the other for the Bosch Rexroth Aluminium profile.


# Issues and Contribution
### Issues
As mentioned in the preceding sections the magnification of the camera lense will be one of the must influential factors for the accuracy of the results. The magnification was determined during the calibration process in the laboratory the images were taken. Errors in the calibration (such as a misaligned object) lead to inaccuracy for the magnification value and thus, a deviation of the calculated width, as the magnification is used in the conversion of the dimension in pixel to mm. Even small errors in the magnification value significantly affect the object width. This problem can be addressed by determining the magnification more accurately or using a camera with a more precise, given magnification decreasing the caused deviation significantly.

Furthermore, the telecentric lighting poses an issue with objects that have a depth (as for example the Bosch profile). As visible in figure 2 and 3, the depth isn't displayed in the image as, due to the telecentric lighting, the object is depicted completely in black. This is an advantage for the edge detection in terms of the high intensity change at the border making it abrupt and sharp. However, if the object isn't aligned perpendicularly to the camera, parts that are further away will appear with the same intensity (instead of "lighter" which would visualize the depth) as the ones required for the edge detection, causing a perspective distortion (they "widen" the object) which leads to an incorrect determination of the edges and consequently larger width. This issue could be targeted with a positioning tool guaranteeing the perpendicular orientation of the object to the camera.

In addition, dirt on the camera lense and background clutter affect the Canny algorithm's ability to correctly detect the actual object edges. The algorithm uses a gradient-based approach, noise or variations in lighting can create false intensity changes that can be mistakenly detected as edges making it harder to isolate the actual object edges. In this case the use of the Gaussian Filter to reduce noise is sufficient, nevertheless this issue becomes more prevelant in environments where the background isn't as "clean" as for the images in the dataset which were taken in a laboratory (for manufactures this wouldn't be a big problem, as they could provide a small area designated for measuring the width that meets this condition). 

Lastly, objects with complex contours (such as the Bosch Rexroth profile) contain many edges. In such cases, the code becomes more complicated and cumbersome as it must be customized to ignore undesired edges. In the current version of the algorithm the area (Region-of-Interest), in which the edges are searched for, is restricted to accomplish this, however, if the edges are in close proximity to each other, a clear separation between the relevant edges and interfering ones becomes more difficult. A different way to approach this problem would be to detect all edges and omit the unwanted ones (in case of the two chosen widths for the profile, the edges between the first and last detected edge in the area would be discarded) to ensure that merely the desired width is calculated.

### Contribution
Others can contribute to improving the algorithm by creating "Issues" which help to track bugs, new features and general enhancement ideas. This requires categorizing the issues with labels as either "Bug", "Enhancement" or "New feature" and a precise description ensuring that the demands are easily understood. It is then possible to suggest code changes through well documented "Pull Requests" which can be included after a thorough review.


# Future work
In the future different datasets including images with other objects in the background and more background clutter in general should be used to evaluate the algorithm's robustness and help find weaknesses that can then be improved. Furthermore, to help with the complexity of the code, it will be modularized in the future to help readability and extension when other objects are added to the dataset.

Additionally, to improve this specific approach with the Canny method, non-maxima suppression and thresholding will be further included into the project. Non-maxima suppression will help create sharper and thinner edges by discarding border pixels which aren't a local maxima helping to reduce imprecision. Furthermore, Thresholding will discard edges that are caused by background noise, thus, improving robustness.

Lastly, alternative algorithms to the Canny edge detection will be explored and compared ensuring that the best approach can be found to develop a more precise application. There are two particularly interesting Deep Learning models: YOLO (You Only Look Once) and SAM (Segment Anything Model). 
YOLO can recognize specific objects in an image and determine their borders. It is more robust against background clutter than the Canny algorithm enhancing the width determination in less ideal environments and often provides precise bounding boxes which can be directly used to compute the distance of the edges. SAM on the other hand precisely segments objects in an image extracting their contours which is specifically suitable for complex objects as it automatically identifies the entire object area.

# Thank you for your contributions!
I am looking forward to your feedback and ideas on how to improve this project.
