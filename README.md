# Casino Test

Test Task: Online Casino Flutter application.

Do you remember Rick and Morty cartoon? 
Your goal is to create the app with all the characters from this cartoon, and make it look juicy.

API docs: https://rickandmortyapi.com/documentation

##To-do:

Using clean architecture design pattern
- Refactor application to your best understanding of the design pattern
- Fix loading state and fetching data feature
- Find and fix all other bugs and issues
- Add more information about characters
- Optimize scrolling performance
- Implement pagination

## Optional:
Implement pagination
- Add infinite scrolling pagination
- Implement recovering from an `Error` state after the last request failed in the paginated view (i.e Application should be able to make a request and return a success response when the previous request fails. Read `Notes` for more information)
- Account for all possible states and edge cases
    - Initial
    - Loading
        - Initial loading state (when fetching the first page)
        - Next page loading state (when fetching the next page after previous pages has been fetched successfully)
    - Success
    - Error 
        - Initial error state (when fetching the first page)
        - Next page error state (when fetching the next page after previous pages has been fetched successfully)


## Things to keep in mind
- You need to use same libraries, but you can also add more (reasonable amount)
- Simulate a failure case by turning off your internet connection and a success case by turning on your internet connection.
- Your code should compile without errors and app should run on both iOS and Android seamlessly
- Keep things clean, simple and fun
- Use bloc state-management if possible
- You can fork or clone the repo and share the link (make sure it is public and accessible) 


###################################################################################################

Done and Submitted By : Adeniji Adefisayo

## Features and updates implemented
- Redesigned UI and added detail screen
- Fixed the crashing of application on launch
- Implemented internet connection availability check
- Refactored the codebase 
- Implemented infinite scrolling
- handled exceptions 
- Added bloc unit test

Thank you for the opportunity, I look forward to the next stage of the recruitment.
