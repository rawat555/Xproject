//
//  DBViewLayer.m
//  database
//
//  Created by thinksysuser on 11/12/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#import "DBViewLayer.h"

@implementation DBViewLayer

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	DBViewLayer *layer = [DBViewLayer node];
	[scene addChild: layer];
	return scene;
}

-(id) init
{ 
    if (self = [super initWithColor:ccc4(255,255,255,255)])
    {
        /*********************** Creating UIFIELDS, LABELS, BUTTONS ***************************/
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(220,240,140,30)];
        titleLabel.text = @"RED Vs. BLUE";
        titleLabel.font = [UIFont fontWithName:@"American Typewriter" size:20.0f];
        titleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
        titleLabel.transform = CGAffineTransformMakeRotation(M_PI * 90 / 180.0f);
        [[[[CCDirector sharedDirector]view]window]addSubview:titleLabel];
        
        
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(180,60,100,20)];
        nameLabel.text = @"Name";
        nameLabel.transform = CGAffineTransformMakeRotation(M_PI * 90 / 180.0f);
       [[[[CCDirector sharedDirector]view]window]addSubview:nameLabel];
        
        emailLabel = [[UILabel alloc] initWithFrame:CGRectMake(130,60,100,20)];
        emailLabel.text = @"Email ID";
        emailLabel.transform = CGAffineTransformMakeRotation(M_PI * 90 / 180.0f);
        [[[[CCDirector sharedDirector]view]window]addSubview:emailLabel];
        
        passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(80,60,100,20)];
        passwordLabel.text = @"PassWord";
        passwordLabel.transform = CGAffineTransformMakeRotation(M_PI * 90 / 180.0f);
        [[[[CCDirector sharedDirector]view]window]addSubview:passwordLabel];

        
		nameField = [[UITextField alloc]initWithFrame:CGRectMake(105,250,250,30)];
        nameField.transform = CGAffineTransformMakeRotation(M_PI * 90 / 180.0f);
        nameField.borderStyle = UITextBorderStyleRoundedRect;
        nameField.delegate = self;        
        [[[[CCDirector sharedDirector]view]window]addSubview:nameField];
        
                
        emailField = [[UITextField alloc]initWithFrame:CGRectMake(55,250,250,30)];
        emailField.borderStyle = UITextBorderStyleRoundedRect;
        emailField.delegate = self;
        emailField.transform = CGAffineTransformMakeRotation(M_PI * 90 / 180.0f);
        [[[[CCDirector sharedDirector]view]window]addSubview:emailField];
        
        passwordField = [[UITextField alloc]initWithFrame:CGRectMake(5,250,250,30)];
        passwordField.borderStyle = UITextBorderStyleRoundedRect;
        passwordField.delegate = self;
        passwordField.transform = CGAffineTransformMakeRotation(M_PI * 90 / 180.0f);
        [[[[CCDirector sharedDirector]view]window]addSubview:passwordField];
        
        submitButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        submitButton.transform = CGAffineTransformMakeRotation(M_PI * 90 / 180.0f);
        [submitButton setFrame:CGRectMake(50, 350, 30, 100)];
        [submitButton setTitle:@"Save" forState:UIControlStateNormal];
        [submitButton addTarget:self action:@selector(saveitem) forControlEvents:UIControlEventTouchUpInside];
        [[[[CCDirector sharedDirector]view]window]addSubview:submitButton];
        
        playButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        playButton.transform = CGAffineTransformMakeRotation(M_PI * 90 / 180.0f);
        [playButton setFrame:CGRectMake(50, 350, 30, 100)];
        [playButton setTitle:@"Play" forState:UIControlStateNormal];
        [playButton addTarget:self action:@selector(playGame) forControlEvents:UIControlEventTouchUpInside];
        [[[[CCDirector sharedDirector]view]window]addSubview:playButton];
        playButton.hidden = YES;
        
        
        /****************** END OF Creating UIFIELDS, LABELS, BUTTONS *********************/
        
        
        
        

        
        
        /******************************* CREATING DATABASE ***************************************/
        
        NSString *docsdir;
        NSArray *dirPaths;
        
        //GET THE DOCUMENT DIRECTORY
        dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        docsdir = [dirPaths objectAtIndex:0];
        
        //BUILD A PATH TO DATABASE FILE
        databasePath = [[NSString alloc]initWithString:[docsdir stringByAppendingPathComponent:@"myDB.sqlite"]];
        NSLog(@"%@",databasePath);
        
        const char *dbpath = [databasePath UTF8String];
        if(sqlite3_open(dbpath, &db) == SQLITE_OK)
        {
            NSLog(@"Success to create database");
            char *errmsg;
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS PlayerInfo (NAME Text, eMail Text, Password Varchar (10))";
            
            if (sqlite3_exec(db, sql_stmt, NULL, NULL, &errmsg) == SQLITE_OK)
            {
                NSLog(@"Success to create table");
            }
            else
            {
                NSLog(@"Failed to create Table");
            }
            
            sqlite3_close(db);
            
        }
        else
        {
            NSLog(@"Failed to create Database");
        }
        
        /******************************* END OF DATABASE CREATION ********************************/
    }
	return self;
}


-(void)playGame
{
    [titleLabel setHidden:YES];
    [nameLabel setHidden:YES];
    [emailLabel setHidden:YES];
    [passwordLabel setHidden:YES];
    [nameField setHidden:YES];
    [emailField setHidden:YES];
    [passwordField setHidden:YES];
    [submitButton setHidden:YES];
    [playButton setHidden:YES];

    [[CCDirector sharedDirector]replaceScene:[HelloWorldLayer node]];
}

            /**************************Submit Button Action ********************************/

-(void)saveitem
{
    char *error;
    
    int lowbound  = 00000000;
    int highbound = 99999999;
    
    int uid_no = arc4random() % (highbound - lowbound + 1);
    
    NSLog(@"REDBLU%d",uid_no);
    
    const char *dbpath = [databasePath UTF8String];
    
   
    
       
    if (sqlite3_open(dbpath, &db) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO PlayerInfo VALUES (\"%@\",\"%@\",\"%@\")", nameField.text,emailField.text,passwordField.text];
        
        const char *insert_stmt = [insertSQL UTF8String];
        
        NSLog(@"%s",insert_stmt);
        
        if(sqlite3_exec(db, insert_stmt, NULL, NULL, &error) == SQLITE_OK)
        {
            NSLog(@"DATA SAVED");
            nameField.text = @"";
            emailField.text = @"";
            passwordField.text = @"";
            playButton.hidden = NO;
            submitButton.hidden = YES;
        }
        else
        {
            NSLog(@"DATA NOT SAVED");
        }
        sqlite3_close(db);
    }
    
}
        /**************************End Of Submit Button Action ********************************/





- (void) dealloc
{
	[super dealloc];
}



        /************************** KEYBOARD DOWN FUNCTION ********************************/
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
        /************************** END OF KEYBOARD DOWN FUNCTION ********************************/


@end
