# TheCatApp

## 📱 TheCatApp  

**TheCatApp** is an app that displays a list of cat breeds. Users can select a breed to view details such as its name, description, and a representative photo.

---

### 🛠 Features  
- 📋 View a complete list of cat breeds.
- 🖼 See detailed information for each breed, including:
    - Name  
    - Description  
    - Representative image
  
---

### 🚀 Installation
- Clone the repository:
- git clone https://github.com/SofiaCantero01/TheCatApp.git
- Open the project in Xcode.

---

### 📦 Requirements
    Swift 5.0
    Xcode 14.0 or later
    Compatible with iOS 14+

---

### 🧪 Unit Tests
- The project includes tests to validate fetching cat data and handling errors.
- testFetchCatListSuccess: Ensures the cat list fetches correctly and displays 3 cats. No errors are shown.
- testFetchCatListError: Verifies that an error shows an empty list and displays an alert.
- testFetchCatDetailSuccess: Confirms fetching detailed info for a specific cat works as expected.
- testFetchCatDetailError: Checks that an error leaves the detail empty and shows an alert.

---

### 🔄 Integration & UI Tests
- The following UI test also serves as an integration test, ensuring end-to-end functionality across multiple components:

- Verify Cat Detail Screen: This test validates that tapping on a breed from the list correctly navigates to the detail screen, displaying breed characteristics and description.

--- 

### 🖇️ License
- This project is licensed under the MIT License.
