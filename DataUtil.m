//
//  DataUtil.m
//  ไม้ในไร่Project
//
//  Created by Adisorn Chatnaratanakun on 3/30/2558 BE.
//  Copyright (c) 2558 Adisorn Chatnartanakun. All rights reserved.
//

#import "DataUtil.h"
#import "PlaceData.h"
#import "Location.h"

@implementation DataUtil

static NSString *jsonString;
static NSArray *dataInstance = nil;

//Get All season data
- (NSArray*)getData{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    
        NSString *path =@"http://rmfl.nagasoftware.com/api/plant_by_season.php?lang_code=1&season_id=0";
        if(path){
         ////NSLog(@"%@",path);
            NSURL *json = [NSURL URLWithString:path]; // jsonString
             ////NSLog(@"URL is %@",[json absoluteString]);
            NSData *jsonData = [NSData dataWithContentsOfURL:json];
            
           // //NSLog(@"jsonData is %@",jsonData);
            
          //  NSString *myString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
           ////NSLog(@"String %@", myString);
           // //NSLog(@"NSDATA is %@",jsonData);
            if(jsonData){
                NSError *error = nil;
                NSArray *jsonObjects = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
                ////NSLog(@"jsonObjects %@",jsonObjects);
                
                for(NSDictionary *itemDic in jsonObjects){
                    PlaceData *item = [[PlaceData alloc] init];
                    ////NSLog(@"item %@",itemDic);
                    for(NSString *key in itemDic){
    
                        if([item respondsToSelector:NSSelectorFromString(key)]){
                            
                            // Check for thai language
                            if([key isEqualToString:@"locations"]){
                                
                                NSArray *locationJsonObjects = [itemDic objectForKey:key];
                                NSMutableArray *locations = [[NSMutableArray alloc] init];
                                
                                for(NSDictionary *locationDic in locationJsonObjects){
                                    Location *location = [[Location alloc] init];
                                    
                                    for(NSString *locationKey in locationDic){
                                        [location setValue:[locationDic valueForKey:locationKey] forKey:locationKey];
                                    }
                                    
                                    ////NSLog(@"%@ %@", location.lat, location.lng);
                                    
                                    [locations addObject:location];
                                }
                                // Set value to locations
                                [item setValue: locations forKey:key];
                            }else{
                                // For general detail
                                [item setValue:[itemDic valueForKey:key] forKey:key];
                                
                            }
                        }
                    }
                    
                    [result addObject:item];
                }
            }else{
                //NSLog(@"JSON NOT FOUND");
            }
        }else{
            //NSLog(@"PATH NOT FOUND");
        }

    return result;
}
//Get Hot season data
- (NSArray*)getHotData{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    NSString *path =@"http://rmfl.nagasoftware.com/api/plant_by_season.php?lang_code=1&season_id=1";
    if(path){
        // //NSLog(@"%@",path);
        NSURL *json = [NSURL URLWithString:path]; // jsonString
        //  //NSLog(@"URL is %@",[json absoluteString]);
        NSData *jsonData = [NSData dataWithContentsOfURL:json];
        // NSString *myString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        // //NSLog(@"String %@", myString);
        ////NSLog(@"NSDATA is %@",jsonData);
        if(jsonData){
            NSError *error = nil;
            NSArray *jsonObjects = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
            //////NSLog(@"jsonObjects %@",jsonObjects);
            
            for(NSDictionary *itemDic in jsonObjects){
                PlaceData *item = [[PlaceData alloc] init];
                for(NSString *key in itemDic){
                    
                    if([item respondsToSelector:NSSelectorFromString(key)]){
                        
                        // Check for thai language
                        if([key isEqualToString:@"locations"]){
                            
                            NSArray *locationJsonObjects = [itemDic objectForKey:key];
                            NSMutableArray *locations = [[NSMutableArray alloc] init];
                            
                            for(NSDictionary *locationDic in locationJsonObjects){
                                Location *location = [[Location alloc] init];
                                
                                for(NSString *locationKey in locationDic){
                                    [location setValue:[locationDic valueForKey:locationKey] forKey:locationKey];
                                }
                                
                                ////NSLog(@"%@ %@", location.lat, location.lng);
                                
                                [locations addObject:location];
                            }
                            // Set value to locations
                            [item setValue: locations forKey:key];
                        }else{
                            // For general detail
                            [item setValue:[itemDic valueForKey:key] forKey:key];
                            
                        }
                    }
                }
                
                [result addObject:item];
            }
        }else{
            //NSLog(@"JSON NOT FOUND");
        }
    }else{
        //NSLog(@"PATH NOT FOUND");
    }
    
    return result;
}
//Get RainyData
- (NSArray*)getRainyData{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    NSString *path =@"http://rmfl.nagasoftware.com/api/plant_by_season.php?lang_code=1&season_id=2";
    if(path){
        // //NSLog(@"%@",path);
        NSURL *json = [NSURL URLWithString:path]; // jsonString
        //  //NSLog(@"URL is %@",[json absoluteString]);
        NSData *jsonData = [NSData dataWithContentsOfURL:json];
        // NSString *myString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        // //NSLog(@"String %@", myString);
        ////NSLog(@"NSDATA is %@",jsonData);
        if(jsonData){
            NSError *error = nil;
            NSArray *jsonObjects = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
            //////NSLog(@"jsonObjects %@",jsonObjects);
            
            for(NSDictionary *itemDic in jsonObjects){
                PlaceData *item = [[PlaceData alloc] init];
                for(NSString *key in itemDic){
                    
                    if([item respondsToSelector:NSSelectorFromString(key)]){
                        
                        // Check for thai language
                        if([key isEqualToString:@"locations"]){
                            
                            NSArray *locationJsonObjects = [itemDic objectForKey:key];
                            NSMutableArray *locations = [[NSMutableArray alloc] init];
                            
                            for(NSDictionary *locationDic in locationJsonObjects){
                                Location *location = [[Location alloc] init];
                                
                                for(NSString *locationKey in locationDic){
                                    [location setValue:[locationDic valueForKey:locationKey] forKey:locationKey];
                                }
                                
                                ////NSLog(@"%@ %@", location.lat, location.lng);
                                
                                [locations addObject:location];
                            }
                            // Set value to locations
                            [item setValue: locations forKey:key];
                        }else{
                            // For general detail
                            [item setValue:[itemDic valueForKey:key] forKey:key];
                            
                        }
                    }
                }
                
                [result addObject:item];
            }
        }else{
            //NSLog(@"JSON NOT FOUND");
        }
    }else{
        //NSLog(@"PATH NOT FOUND");
    }
    
    return result;
}
//Get Cold season data
- (NSArray*)getColdData{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    NSString *path =@"http://rmfl.nagasoftware.com/api/plant_by_season.php?lang_code=1&season_id=3";
    if(path){
        // //NSLog(@"%@",path);
        NSURL *json = [NSURL URLWithString:path]; // jsonString
        //  //NSLog(@"URL is %@",[json absoluteString]);
        NSData *jsonData = [NSData dataWithContentsOfURL:json];
        // NSString *myString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        // //NSLog(@"String %@", myString);
        ////NSLog(@"NSDATA is %@",jsonData);
        if(jsonData){
            NSError *error = nil;
            NSArray *jsonObjects = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
            //////NSLog(@"jsonObjects %@",jsonObjects);
            
            for(NSDictionary *itemDic in jsonObjects){
                PlaceData *item = [[PlaceData alloc] init];
                for(NSString *key in itemDic){
                    
                    if([item respondsToSelector:NSSelectorFromString(key)]){
                        
                        // Check for thai language
                        if([key isEqualToString:@"locations"]){
                            
                            NSArray *locationJsonObjects = [itemDic objectForKey:key];
                            NSMutableArray *locations = [[NSMutableArray alloc] init];
                            
                            for(NSDictionary *locationDic in locationJsonObjects){
                                Location *location = [[Location alloc] init];
                                
                                for(NSString *locationKey in locationDic){
                                    [location setValue:[locationDic valueForKey:locationKey] forKey:locationKey];
                                }
                                
                                ////NSLog(@"%@ %@", location.lat, location.lng);
                                
                                [locations addObject:location];
                            }
                            // Set value to locations
                            [item setValue: locations forKey:key];
                        }else{
                            // For general detail
                            [item setValue:[itemDic valueForKey:key] forKey:key];
                            
                        }
                    }
                }
                
                [result addObject:item];
            }
        }else{
            //NSLog(@"JSON NOT FOUND");
        }
    }else{
        //NSLog(@"PATH NOT FOUND");
    }
    
    return result;
}
//Get Recomendation  data
- (NSArray*)getRecomendationData{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    NSString *path =@"http://rmfl.nagasoftware.com/api/plant_by_recommendation.php?lang_code=1";
    if(path){
        // //NSLog(@"%@",path);
        NSURL *json = [NSURL URLWithString:path]; // jsonString
        //  //NSLog(@"URL is %@",[json absoluteString]);
        NSData *jsonData = [NSData dataWithContentsOfURL:json];
        // NSString *myString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        // //NSLog(@"String %@", myString);
        ////NSLog(@"NSDATA is %@",jsonData);
        if(jsonData){
            NSError *error = nil;
            NSArray *jsonObjects = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
            //////NSLog(@"jsonObjects %@",jsonObjects);
            
            for(NSDictionary *itemDic in jsonObjects){
                PlaceData *item = [[PlaceData alloc] init];
                for(NSString *key in itemDic){
                    
                    if([item respondsToSelector:NSSelectorFromString(key)]){
                        
                        // Check for thai language
                        if([key isEqualToString:@"locations"]){
                            
                            NSArray *locationJsonObjects = [itemDic objectForKey:key];
                            NSMutableArray *locations = [[NSMutableArray alloc] init];
                            
                            for(NSDictionary *locationDic in locationJsonObjects){
                                Location *location = [[Location alloc] init];
                                
                                for(NSString *locationKey in locationDic){
                                    [location setValue:[locationDic valueForKey:locationKey] forKey:locationKey];
                                }
                                
                                ////NSLog(@"%@ %@", location.lat, location.lng);
                                
                                [locations addObject:location];
                            }
                            // Set value to locations
                            [item setValue: locations forKey:key];
                        }else{
                            // For general detail
                            [item setValue:[itemDic valueForKey:key] forKey:key];
                            
                        }
                    }
                }
                
                [result addObject:item];
            }
        }else{
            //NSLog(@"JSON NOT FOUND");
        }
    }else{
        //NSLog(@"PATH NOT FOUND");
    }
    
    return result;
}

@end

