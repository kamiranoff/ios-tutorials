//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created by Kevin Amiranoff on 08/03/2016.
//  Copyright © 2016 Kevin Amiranoff. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  // 1 = circles, 2 = crosses
  var activePlayer = 1;
  
  var gameActive = true;
  
  // list of possible moves
  var gameState = [0,0,0,0,0,0,0,0,0]
  var winningCombinations = [
    [0,1,2],[3,4,5],[6,7,8],
    [0,3,6],[1,4,7],[2,5,8],
    [0,4,8],[2,4,6]
  ];
  
  @IBOutlet var button: UIButton!
  
  @IBOutlet var gameOverLabel: UILabel!
  @IBOutlet var playAgainButton: UIButton!
  
  @IBAction func playAgainPressed(sender: AnyObject) {
    
    //reset everything
    activePlayer = 1;
    gameActive = true;
    gameState = [0,0,0,0,0,0,0,0,0]
    
    var button : UIButton
    for(var i=0;i<9;i++){
      button = view.viewWithTag(i) as! UIButton
      button.setImage(nil, forState: .Normal)
    }
      hideVictoryElems()
    
  }
  
  @IBAction func buttonPressed(sender: AnyObject) {
    
    //if gameState has been played already, exit.
    if(gameState[sender.tag] != 0 || gameActive == false){
      return;
    }
    
    //else the player is making a move
    var image = UIImage();
    
    //set gameState of tag of the sender
    gameState[sender.tag] = activePlayer;
    
    if (activePlayer == 1){
      image = UIImage(named:"circle.png")!
      activePlayer = 2
    }else{
      image = UIImage(named:"cross.png")!
      activePlayer = 1
    }
    sender.setImage(image, forState: .Normal);
    
    
    //loops through winning combinations and check if one is matching
    for combination in winningCombinations{
      
      if(gameState[combination[0]] != 0 && gameState[combination[0]] == gameState[combination[1]] && gameState[combination[1]] == gameState[combination[2]] ){
        print("we have a winner");
        
        
        var labelText = "Noughts has won !"
        
        if (gameState[combination[0]] == 2){

          labelText = "crosses has won !"
        }
        
        gameOverLabel.text = labelText;
        gameOverLabel.hidden = false;
        playAgainButton.hidden = false;
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
          self.gameOverLabel.center = CGPointMake(self.gameOverLabel.center.x + 400,self.gameOverLabel.center.y)
          self.playAgainButton.center = CGPointMake(self.playAgainButton.center.x - 400,self.playAgainButton.center.y)
        })
        
        gameActive = false;
      }
      
    }
    
    
    
  
  }
  
  func hideVictoryElems(){
    gameOverLabel.hidden = true;
    playAgainButton.hidden = true;
    gameOverLabel.center = CGPointMake(gameOverLabel.center.x - 400,gameOverLabel.center.y)
    playAgainButton.center = CGPointMake(playAgainButton.center.x + 400,playAgainButton.center.y)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    hideVictoryElems()
    

  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func viewDidLayoutSubviews() {
      }


}

