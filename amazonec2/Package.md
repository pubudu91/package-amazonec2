Connects to Amazon ec2 from Ballerina. 

# Package Overview

The Amazon ec2 connector allows you to run, describe, and terminate the ec2 instances through the Amazon ec2 REST API.

**Instance Operations**

The `kana/amazonec2` package contains operations that work with instances. You can launch, describe, and stop the 
instances with these operations.

## Compatibility
|                    |    Version     |  
|:------------------:|:--------------:|
| Ballerina Language |   0.981.0      |
| Amazon ec2 API     |   2016-11-15   |

## Sample

First, import the `kana/amazonec2` package into the Ballerina project.

```ballerina
import kana/amazonec2;
```
The Amazon ec2 connector can be instantiated using the accessKeyId, secretAccessKey and region, 
in the Amazon ec2 client config.

**Obtaining Access Keys to Run the Sample**

 1. Create a amazon account by visiting <https://aws.amazon.com/ec2/>
 2. Obtain the following parameters
   * Access key ID.
   * Secret access key.
   * Desired Server region.

You can now enter the credentials in the Amazon ec2 client config:
```ballerina
endpoint amazonec2:Client amazonEC2Client {
    accessKeyId:"<your_access_key_id>",
    secretAccessKey:"<your_secret_access_key>",
    region:"<your_region>"
};
```
The `runInstances` function launches the specified number of instances using an AMI for which you have permissions.
You can specify the maximum number of instances to launch and the minimum number of instances to launch.

   `var runInstancesResponse = amazonEC2Client->runInstances(imgId, maxCount, minCount);`
   
If the instance started successfully, the response from the `runInstances` function is a `InstanceList` object with 
one or more launched instance ids. If it is unsuccessful, the response is a `AmazonEC2Error`. 
The `match` operation can be used to handle the response if an error occurs.

```ballerina
match runInstancesResponse {
        amazonec2:InstanceList instance => {
            io:println(" Successfully launch the instance : ");
            string instanceId = (instance.instanceSet[0].instanceId);
            io:println("Instance Id : " + instanceId);
        }
        amazonec2:AmazonEC2Error e => io:println(e);
    }
```

The `describeInstances` function describes one or more of your instances.. It returns a `ReservationList` object 
with reservation ids if it is successful or the response is a `AmazonEC2Error`. 

```ballerina
match describeInstancesResponse {
        amazonec2:ReservationList reservations => {
            io:println(" Successfully describe the instances : ");
            string reservationId = (reservations.reservationSet[0].reservationId);
            io:println("Reservation Id : " + reservationId);
        }
        amazonec2:AmazonEC2Error e => io:println(e);
    }
```
The `terminateInstances` function shuts down one or more instances. It returns a `InstanceList` object 
with terminated instance ids if it is successful or the response is a `AmazonEC2Error`. 

```ballerina
match terminateInstancesResponse {
        amazonec2:InstanceList instance => {
            io:println(" Successfully terminate the instances : ");
            string instanceId = (instance.instanceSet[0].instanceId);
            io:println("Terminated Instance Id : " + instanceId);
        }
        amazonec2:AmazonEC2Error e => io:println(e);
}
```

## Example
```ballerina
import ballerina/io;
import kana/amazonec2;

function main(string... args) {
    endpoint amazonec2:Client amazonEC2Client {
        accessKeyId: "",
        secretAccessKey: "",
        region: "",
   	clientConfig:{}
    };

    string[] instanceArray = ["i-05ec3efvfff7f41474a60d", "i-0gddff97b6190273d0aecd"];
    string imgId = "ami-0ad9l9772";
    int maxCount = 2;
    int minCount = 1;
    var runInstancesResponse = amazonEC2Client->runInstances(imgId, maxCount, minCount);
    match runInstancesResponse {
        amazonec2:InstanceList instance => {
            io:println(" Successfully launch the instance : ");
            string instanceId = (instance.instanceSet[0].instanceId);
            io:println("Instance Id : " + instanceId);
        }
        amazonec2:AmazonEC2Error e => io:println(e);
    }

    var describeInstancesResponse = amazonEC2Client->describeInstances();
    match describeInstancesResponse {
        amazonec2:ReservationList reservations => {
            io:println(" Successfully describe the instances : ");
            string reservationId = (reservations.reservationSet[0].reservationId);
            io:println("Reservation Id : " + reservationId);
        }
        amazonec2:AmazonEC2Error e => io:println(e);
    }

    var terminateInstancesResponse = amazonEC2Client->terminateInstances(instanceArray);
    match terminateInstancesResponse {
        amazonec2:InstanceList instance => {
            io:println(" Successfully terminate the instances : ");
            string instanceIds = (instance.instanceSet[0].instanceId);
            io:println("Terminated Instance Id : " + instanceIds);
        }
        amazonec2:AmazonEC2Error e => io:println(e);
    }
}
```
