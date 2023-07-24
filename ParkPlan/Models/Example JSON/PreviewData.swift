//
//  PreviewData.swift
//  ParkPlan
//
//  Created by Hunter Dobbelmann on 7/23/23.
//

import Foundation

/*
 let exampleNameLiveData: Data = """

 """.data(using: .utf8)!
 */

// MARK: - Live Data
let exampleRestaurantLiveData: Data = """
{
 "id": "e847a8bd-7d21-432b-a7a1-f483517a22b5",
 "name": "Be Our Guest Restaurant",
 "entityType": "RESTAURANT",
 "parkId": "75ea578a-adc8-4116-a54d-dccb60765ef9",
 "externalId": "16660079;entityType=restaurant",
 "queue": {
  "STANDBY": {
   "waitTime": 10
  }
 },
 "status": "OPERATING",
 "diningAvailability": [
  {
   "waitTime": 10,
   "partySize": 1
  },
  {
   "waitTime": 10,
   "partySize": 2
  }
 ],
 "lastUpdated": "2023-07-17T21:01:35Z"
}
""".data(using: .utf8)!

let exampleShowLiveData: Data = """
{
 "id": "a2d92647-634d-4eb4-886b-9da858e871f1",
 "name": "Meet Mickey at Town Square Theater",
 "entityType": "SHOW",
 "parkId": "75ea578a-adc8-4116-a54d-dccb60765ef9",
 "externalId": "15850196;entityType=Entertainment",
 "queue": {
  "STANDBY": {
   "waitTime": 45
  },
  "RETURN_TIME": {
   "state": "AVAILABLE",
   "returnEnd": null,
   "returnStart": "2023-07-17T18:10:00-04:00"
  }
 },
 "status": "OPERATING",
 "forecast": [
  {
   "time": "2023-07-17T09:00:00-04:00",
   "waitTime": 30,
   "percentage": 25
  },
  {
   "time": "2023-07-17T10:00:00-04:00",
   "waitTime": 55,
   "percentage": 47
  },
  {
   "time": "2023-07-17T11:00:00-04:00",
   "waitTime": 55,
   "percentage": 47
  },
  {
   "time": "2023-07-17T12:00:00-04:00",
   "waitTime": 45,
   "percentage": 38
  },
  {
   "time": "2023-07-17T13:00:00-04:00",
   "waitTime": 35,
   "percentage": 30
  },
  {
   "time": "2023-07-17T14:00:00-04:00",
   "waitTime": 25,
   "percentage": 21
  },
  {
   "time": "2023-07-17T15:00:00-04:00",
   "waitTime": 30,
   "percentage": 25
  },
  {
   "time": "2023-07-17T16:00:00-04:00",
   "waitTime": 35,
   "percentage": 30
  },
  {
   "time": "2023-07-17T17:00:00-04:00",
   "waitTime": 35,
   "percentage": 30
  },
  {
   "time": "2023-07-17T18:00:00-04:00",
   "waitTime": 25,
   "percentage": 21
  },
  {
   "time": "2023-07-17T19:00:00-04:00",
   "waitTime": 40,
   "percentage": 34
  },
  {
   "time": "2023-07-17T20:00:00-04:00",
   "waitTime": 40,
   "percentage": 34
  },
  {
   "time": "2023-07-17T21:00:00-04:00",
   "waitTime": 40,
   "percentage": 34
  },
  {
   "time": "2023-07-17T22:00:00-04:00",
   "waitTime": 55,
   "percentage": 47
  }
 ],
 "showtimes": [
  {
   "type": "Operating",
   "endTime": "2023-07-17T22:30:00-04:00",
   "startTime": "2023-07-17T09:00:00-04:00"
  }
 ],
 "lastUpdated": "2023-07-17T21:34:09Z"
}
""".data(using: .utf8)!

let exampleAttractionLiveData: Data = """
{
 "id": "9167db1d-e5e7-46da-a07f-ae30a87bc4c4",
 "name": "Space Mountain",
 "entityType": "ATTRACTION",
 "parkId": "7340550b-c14d-4def-80bb-acdb51d49a66",
 "externalId": "353435;entityType=Attraction",
 "queue": {
  "STANDBY": {
   "waitTime": 65
  },
  "RETURN_TIME": {
   "state": "AVAILABLE",
   "returnEnd": null,
   "returnStart": "2023-07-17T19:45:00-07:00"
  }
 },
 "status": "OPERATING",
 "forecast": [
  {
   "time": "2023-07-17T08:00:00-07:00",
   "waitTime": 20,
   "percentage": 16
  },
  {
   "time": "2023-07-17T09:00:00-07:00",
   "waitTime": 45,
   "percentage": 37
  },
  {
   "time": "2023-07-17T10:00:00-07:00",
   "waitTime": 55,
   "percentage": 45
  },
  {
   "time": "2023-07-17T11:00:00-07:00",
   "waitTime": 65,
   "percentage": 54
  },
  {
   "time": "2023-07-17T12:00:00-07:00",
   "waitTime": 60,
   "percentage": 50
  },
  {
   "time": "2023-07-17T13:00:00-07:00",
   "waitTime": 65,
   "percentage": 54
  },
  {
   "time": "2023-07-17T14:00:00-07:00",
   "waitTime": 70,
   "percentage": 58
  },
  {
   "time": "2023-07-17T15:00:00-07:00",
   "waitTime": 65,
   "percentage": 54
  },
  {
   "time": "2023-07-17T16:00:00-07:00",
   "waitTime": 75,
   "percentage": 62
  },
  {
   "time": "2023-07-17T17:00:00-07:00",
   "waitTime": 80,
   "percentage": 66
  },
  {
   "time": "2023-07-17T18:00:00-07:00",
   "waitTime": 80,
   "percentage": 66
  },
  {
   "time": "2023-07-17T19:00:00-07:00",
   "waitTime": 65,
   "percentage": 54
  },
  {
   "time": "2023-07-17T20:00:00-07:00",
   "waitTime": 65,
   "percentage": 54
  },
  {
   "time": "2023-07-17T21:00:00-07:00",
   "waitTime": 60,
   "percentage": 50
  },
  {
   "time": "2023-07-17T22:00:00-07:00",
   "waitTime": 65,
   "percentage": 54
  },
  {
   "time": "2023-07-17T23:00:00-07:00",
   "waitTime": 55,
   "percentage": 45
  }
 ],
 "operatingHours": [
  {
   "type": "Early Entry",
   "endTime": "2023-07-17T08:00:00-07:00",
   "startTime": "2023-07-17T07:30:00-07:00"
  },
  {
   "type": "Operating",
   "endTime": "2023-07-18T00:00:00-07:00",
   "startTime": "2023-07-17T08:00:00-07:00"
  }
 ],
 "lastUpdated": "2023-07-17T21:22:57Z"
}
""".data(using: .utf8)!
