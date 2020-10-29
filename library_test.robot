*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported Selenium2Library.
Resource          FETS-Common/FETS-Common.robot
Resource          FETS-Pages/FETS-Main.robot
Resource          FETS-Pages/FETS-AWSLogin.robot
Resource          FETS-Pages/FETS-AWSHome.robot
Resource          FETS-Pages/FETS-AWSSwitchRole.robot
Resource          FETS-Pages/FETS-AWSBucket.robot
Resource          FETS-Pages/FxForms.robot
Library           CombineLibrary.py
Library           RequestsLibrary
Library           Selenium2Library
Library           Collections
Library           String


*** Variables ***




*** Keywords ***
























