//
// Copyright (c) 2018, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.
//

import ballerina/io;

documentation {
    Define the AmazonEC2 Connector.
    E{{}}
    F{{amazonEC2Config}} - AmazonEC2 connector configurations
    F{{amazonEC2Connector}} - AmazonEC2 Connector object
}
public type Client object {

    public AmazonEC2Configuration amazonEC2Config = {};
    public AmazonEC2Connector amazonEC2Connector = new;

    documentation {
        AmazonEC2 connector endpoint initialization function
        P{{config}} - AmazonEC2 connector configuration
    }
    public function init(AmazonEC2Configuration config);

    documentation {
        Return the AmazonEC2 connector client
        R{{}} - AmazonEC2 connector client
    }
    public function getCallerActions() returns AmazonEC2Connector;

};

documentation {
        Define the Amazon ec2 connector.
        F{{uri}} - The Amazon ec2 endpoint
        F{{accessKeyId}} - The access key of Amazon ec2 account
        F{{secretAccessKey}} - The secret key of the Amazon ec2 account
        F{{region}} - The AWS region
        F{{clientEndpoint}} - HTTP client endpoint
}
public type AmazonEC2Connector object {
    string uri;
    public string accessKeyId;
    public string secretAccessKey;
    public string region;
    public http:Client clientEndpoint = new;

    documentation {
        Launches the specified number of instances using an AMI for which you have permissions.
        P{{imgId}} -  The ID of the AMI which is required to launch an instance
        P{{maxCount}} - The maximum number of instances to launch
        P{{minCount}} - The minimum number of instances to launch
        R{{}} - If success, returns InstanceList of launched instances, else returns AmazonEC2Error object.}
    public function runInstances(string imgId, int maxCount, int minCount) returns InstanceList|AmazonEC2Error;

    documentation {
        Describes one or more of your instances.
        R{{}} - If success, returns ReservationList with zero or more reservations., else returns AmazonEC2Error object.}
    public function describeInstances() returns ReservationList|AmazonEC2Error;

    documentation {
        Shuts down one or more instances.
        P{{instanceArray}} - One or more instance IDs
        R{{}} - If success, returns InstanceList with terminated instances, else returns AmazonEC2Error object.}
    public function terminateInstances(string[] instanceArray) returns InstanceList|AmazonEC2Error;
};

documentation {
        Define the configurations for Amazon ec2 connector.
        F{{uri}} - The Amazon ec2 endpoint
        F{{accessKeyId}} - The access key of Amazon ec2 account
        F{{secretAccessKey}} - The secret key of the Amazon ec2 account
        F{{region}} - The AWS region
        F{{clientConfig}} - HTTP client endpoint config
}
public type AmazonEC2Configuration record {
    string uri;
    string accessKeyId;
    string secretAccessKey;
    string region;
    http:ClientEndpointConfig clientConfig = {};
};

documentation {
    Define the Instance object details
    F{{instanceSet}} - Instance set with instance ids
    F{{requestId}} - request id
}
public type InstanceList record {
    InstanceSet[] instanceSet;
    string requestId;
};

documentation {
    Define the Instance set with instane id's
    F{{instanceId}} - Instance set of with instance id
}
public type InstanceSet record {
    string instanceId;
};

documentation {
    Define the Reservation object details
    F{{reservationSet}} - Reservation set with instance details.
    F{{requestId}} - request id
}
public type ReservationList record {
    ReservationSet[] reservationSet;
    string requestId;
};

documentation {
    Define the Reservation set with reservation id's
    F{{reservationId}} - Reservation id
}
public type ReservationSet record {
    string reservationId;
};

documentation {
    Amazon ec2 Client Error
    F{{message}} - Error message of the response
    F{{cause}} - The error which caused the error
    F{{statusCode}} - Status code of the response
}
public type AmazonEC2Error record {
    string message;
    error? cause;
    int statusCode;
};
