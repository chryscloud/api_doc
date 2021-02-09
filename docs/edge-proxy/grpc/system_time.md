# SystemTime

Chrysalis Edge system time. Addressing possible clock drifts between systems. This will be deprecated in the future in favor of `VideoProbe`



```
message SystemTimeResponse {
    int64 current_time = 1;
}
message SystemTimeRequest {}
```