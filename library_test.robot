*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported Selenium2Library.
Resource          ACO-Common/ACO-Common.robot
Resource          ACO-Pages/ACO-Main.robot
Library           RequestsLibrary
Library           Selenium2Library
Library           Collections
Library           String


*** Variables ***




*** Keywords ***
























