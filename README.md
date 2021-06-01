# steps_tracker

A new Flutter project.

## Requirements
Functional
1. Users could be authenticated anonymously, no need to take a phone number or email. 
Upon first installation the app should ask for their name and (Bonus!) image. [V]
2. The application should track the user footsteps and update them in real-time, meaning
while the app is in the foreground, and the user walks around, they should be able to
see the steps counter increasing. [V]
3. For each number of footsteps taken, a function must run to exchange it to “Health
Points”, e.g., 100 footsteps = 1 Health Point. [V]
4. There should be a history that lists all the exchanges that happened by date and time
(e.g., “+10 health points on 24 April, 12 AM”), along with any redemption (e.g., “-120
health points spent in Jarir on 25 April, 4 PM”). [V]
5. Show a visual feedback (e.g., Snack bar) when users gain extra points.[X]
6. There should be a catalog of rewards so users can pick a reward they like and redeem it.
Each reward is linked to one partner (e.g., 150 SAR off on Digital Watches from Jarir).[V]
7. Rewards are paid with health points, feedback should be given upon all cases: if the
redemption can happen, show a confirmation dialog, if it cannot due to a low number of
points, show an error message stating clearly what’s wrong. [V]
8. (Bonus!) There is a leaderboard page where the user can see their ranking (how many
steps they have made since installing the app) compared to all other users, to encourage
them to walk more. [X]
9. (Bonus!) If the application is in background, or turned off, the exchange will happen
while they are walking, and a notification would be sent from the app telling them that
they gained extra points. [X]
10. (Bonus!) The app is multilingual, supports both Arabic and English. [X]

## Non-functional requirements
1. Usable and user-friendly interface. [V]
2. Follow Material design rules. [V]
3. Use a proper architecture for the code, UI code must not include any DB queries or
business logic. [V]
4. Use clear models for data. [V]
5. Document every function and provide meaningful variable names and follow Effective
Dart to write your code. [V]
6. (Bonus!) Dark mode. [X]
7. (Bonus!) Privacy and security (e.g., Firestore database rules). [X]
8. (Bonus!) The project is null-safe. [V]
