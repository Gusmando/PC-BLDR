 ![](https://github.com/Gusmando/PC-BLDR/blob/master/bldrLogoHelv.png)

PC BLDR is an ios application developed in Swift which makes it easy to create lists and keep track of Computer Builds, while also providing other features such as displaying part deals and nearby computer hardware locations.

### Tools and Attributions

- The app was entirely developed in Swift utilizing storyboard in [Xcode](https://developer.apple.com/xcode/)
- UI Planning for the app was entirely done in [Figma](https://www.figma.com/ui-design-tool/)
- The class level design was done using the free diagramming tool [Draw.io](https://app.diagrams.net/)
- Main app logo was created in [Adobe Illustrator](https://www.adobe.com/products/illustrator.html)
- Icons made by <a href="https://www.flaticon.com/authors/smashicons" title="Smashicons">Smashicons</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a></div>

### Class Level Design
The application was designed with the MVC architecture model in mind, and consequently this is reflected within the class level design. Classes are intended to act as the Model, View, and Controller components of the model by communicating with each other and reacting to user interaction.

![class diag](https://i.ibb.co/Trh0RPf/PCBuild-Class.png)

### Features

- Build List (Allows the user to see a list of all created builds, allowing for the creation and deletion of user builds)
  - Each build contains a list of every part relating to that build as well as a name and picture
- Part Deals (Enables the user to choose a part type and then utilizes the Reddit API to show a list of all deals related to that part type, the user may then view any deal)
- Nearby Parts (Utilizes the user's current location to create a search for nearby computer hardware stores and displays these locations, allowing the user to view the website of any of the businesses upon clicking them)

### Post-Mortem

This project was a great foray into learning mobile app development and it gave me the opportunity of learning essential swift and storyboard features which could be beneficial to me in future endeavors. Specifically, I was able to gain experience within such built in features as the Image picker, map information/user location data , as well as API decoding. Ultimately, I was able to implement the different features into a cohesive idea and the planning of the project enabled efficient and focused devlopement which could be completed in a timely manner. In the future, I hope to create a more ambitious project, and I look forward to learning more about the libraries available for ios development.
