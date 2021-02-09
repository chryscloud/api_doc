# Annotate

Forwarding annotations to Chrysalis Cloud.

`Annotate` object structure is compatible with Chrysalis Cloud and makes sure to forward the output annotations from your ML model into Chrysalis Annoation data warehouse, where they can be queried and analyized. 

## Short Q&A

**Q: Do annoatation get forwarded even if the edge is offline?**

*A: Yes. Annotations are temporarily stored on the edge until internet connecton is available, at which point all annotation get forwarded to Chrysalis Cloud.*

## Proto Messages

Request: `AnnotateRequest`

| Fields  | |
|-------------| -- |
| device_name | **string**: required: The name of the camera you've setup in section `Connect RTSP Camera`
| remote_stream_id | **string**: optional: if associated with storage, the ID of Chrysalis Cloud deviceID
| type | **string**: required: event type: e.g. moving, exit, entry, stopped, parked, ...
| start_timestamp | **int64**: required: start of the event
| end_timestamp | **int64**: optional: end of the event
| object_type | **string**: optional: e.g. person, car, face, bag, roadsign,...
| object_tracking_id | **string**: optional: tracking id of the object
| confidence | **double**: confidence of inference [0-1.0]
| Location | **Location**: optional: object GEO location
| object_bouding_box | **BoudingBox**: optional: object bounding box
| object_coordinate | **Coordinate**:  optional: object coordinates within the image
| mask | **repeated Coordinate**:  optional: object mask (polygon)
| object_signature | **repeated double**:  optional: signature of the detected item
| ml_model | **string**:  optional: description of the module that generated this event
| ml_model_version | **string**: optional: version of the ML model
| width | **int32**:  optional: image width
| height | **int32**:  optional: optional: image height
| is_keyframe | **bool**: optional: true/false if this annotation is from keyframe
| video_type | **string**: optional: e.g. mp4 filename, live stream, ...
| offset_timestamp | **int64**: optional: offset from the beginning of the stream
| offset_duration | **int64**: optional: duration from the offset
| offset_frame_id | **int64**: optional: frame id within the packet
| offset_packet_id | **int64**: optional: packet id of withing the stream
| custom_meta_1 | **string**: optional: extending the event message meta data (e.g. gender, hair, car model, ...)
| custom_meta_2 | **string**: optional: extending the event message meta data (e.g. gender, hair, car model, ...)
| custom_meta_3| **string**: optional: extending the event message meta data (e.g. gender, hair, car model, ...)
| custom_meta_4 | **string**: optional: extending the event message meta data (e.g. gender, hair, car model, ...)
| custom_meta_5 | **string**: optional: extending the event message meta data (e.g. gender, hair, car model, ...)

Response: `AnnotateResponse`

Reponse serves and confirmation of the accepted Annotation request.

| Fields  | |
|-------------| -- |
| device_name | **string**: required: The name of the camera you've setup in section `Connect RTSP Camera`
| remote_stream_id | **string**: optional: if associated with storage, the ID of Chrysalis Cloud deviceID
| type | **string**: event type: e.g. moving, exit, entry, stopped, parked, ...
| start_timestamp | **int64**: start of the event


```
// Annotation messages
message AnnotateRequest {

    string device_name = 1; // required: device name (required) identity of device
    string remote_stream_id = 2; //optional: if associated with storage, the ID of Chrysalis Cloud deviceID
    string type = 3; // required: event type: e.g. moving, exit, entry, stopped, parked, ...
    int64 start_timestamp = 4; //required: start of the event
    int64 end_timestamp = 5; // optional: event of the event
    string object_type = 6; // optional: e.g. person, car, face, bag, roadsign,...
    string object_id = 7; // optional: e.g. object id from the ML model
    string object_tracking_id = 8; // optional: tracking id of the object
    double confidence = 9; // confidence of inference [0-1.0]
    BoudingBox object_bouding_box = 10; // optional: object bounding box
    Location location = 11; // optional: object GEO location
    Coordinate object_coordinate = 12; // optional: object coordinates within the image
    repeated Coordinate mask = 13; // optional" object mask (polygon)
    repeated double object_signature = 14; // optional: signature of the detected item
    string ml_model = 15; // optional: description of the module that generated this event
    string ml_model_version = 16; // optional: version of the ML model
    int32 width = 17; // optional: image width
    int32 height = 18; // optional: image height
    bool is_keyframe = 19; // optional: true/false if this annotation is from keyframe
    string video_type = 20; // optional: e.g. mp4 filename, live stream, ...
    int64 offset_timestamp = 21; // optional: offset from the beginning
    int64 offset_duration = 22; // optional: duration from the offset
    int64 offset_frame_id = 23; // optional: frame id of the 
    int64 offset_packet_id = 24; // optional: offset of the packet

    // extending the event message meta data (optional)
    string custom_meta_1 = 25; // e.g. gender, hair, car model, ...
    string custom_meta_2 = 26;
    string custom_meta_3 = 27;
    string custom_meta_4 = 28;
    string custom_meta_5 = 29;
}

message AnnotateResponse {
    string device_name = 1;
    string remote_stream_id = 2;
    string type = 3;
    int64 start_timestamp = 4;
}
```