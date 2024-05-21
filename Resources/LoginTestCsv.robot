*** Settings ***
Documentation    To validate the Login Form
Library     SeleniumLibrary
Library    DataDriver       file=../Resources/LoginData.csv    encoding=utf_8      dialect=unix
Test Template    Validate Unsuccessful Login
 
*** Variables ***
${browser_name}     Chrome
${login_btn}        css:.orangehrm-login-button
${login_error_message}      css:.oxd-alert-content--error
#${Username}    abc
#${Password}    123    
 
*** Test Cases ***
Login to form using     ${Username}    ${Password} 
 
 
*** Keywords ***
Validate Unsuccessful Login
    [Arguments]    ${Username}   ${Password}
    Open the Browser with URL
    Fill the login form     ${Username}   ${Password}
    verify error message is correct
 
 
Open the Browser with URL
    Create Webdriver    ${browser_name}  
    Go To    https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
    Maximize Browser Window
    Set Selenium Implicit Wait    2
 
Fill the login form
  [Arguments]        ${Username}       ${Password}
   Input Text        name:username     ${Username}
   Input Password    name:password     ${Password}
   Click Button    ${login_btn}
 
Verify error message is correct
    Element Text Should Be    ${login_error_message}   Invalid credentials
      
Close Browser Session
    Close Browser