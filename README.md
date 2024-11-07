## Pre-Processor

### Description:
  ```
  This is an old project that I had lying around. The primary use was to upload Animations, models, and games to Roblox.
  At the time, this was intended to bypass Roblox's then-new Copyright Protection system, particularly with regards to games such as Pet Simulator X.
  However, I do not do such activities anymore, as I've moved on to much better (and legal) occupations!

  I am not sure if this still works. At the time, it had a few weird bugs. This is almost 2 years old and I'm not too familiar with the inner workings anymore, but the way we used to do it was like:
  - out/models are .rbxm files containing specific portions of the game(s), such as "pets", "food", etc. We used base64 & reversed the result to create the file name(s)
  - ci/dev runs remodel, which is a multi-tool developed by rojo-rbx: https://github.com/rojo-rbx/remodel. we run the generateDriver script, which in turn:
    - correctly sorts where scripts should go
    - runs the core of the bypass, taken "gracefully" from Faithful, the creator of Project Bronze Forever, a revival project aimed at Pokemon Brick Bronze. however, we did not include any nintendo related assets, names, or code-words for obvious reasons
  - as i am writing this, i honestly have forgot a majority of what this did. i deeply apologize! please read the source code yourself :v
  ```

## License:

This project is licensed under GPL 3.0. Please read the LICENSE to determine what this means for you.

## Usage:
  ``` 
  * Download nodejs!!!!!
  * Add the asset-id of the driver into the bypass-loader
  * Open a terminal and run ".\ci\dev.bat"
  * Open a terminal and run ".\ci\publish.bat"
  ```
  
