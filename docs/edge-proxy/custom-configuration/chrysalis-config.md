# Custom Chrysalis configuration

Create `conf.yaml` file in the location:

=== "Linux" 
    `/data/chrysalis` folder 
=== "Mac OS X"
    `on_disk_folder` custom folder created during setup
=== "Windows"
    `on_disk_folder` by prefixing with `/C/`
    Example: `on_disk_folder: /C/Users/user/chrys-video-egde-proxy/videos`

The configuration file is automatically picked up if it exists otherwise system fallbacks to it's default configuration.

### Configuration

    version: 0.0.3
    title: Chrysalis Video Edge Proxy
    description: Chrysalis Video Edge Proxy Service for Computer Vision
    mode: release # "debug": or "release"

    redis:
      connection: "redis:6379"
      database: 0
      password: ""

    api:
      endpoint: https://api.chryscloud.com

    annotation:
      endpoint: "https://event.chryscloud.com/api/v1/annotate"
      unacked_limit: 1000
      poll_duration_ms: 300
      max_batch_size: 299

    buffer:
      in_memory: 1 # number of images to store in memory buffer (1 = default)
      on_disk: false # store key-frame separated mp4 file segments to disk
      on_disk_folder: /data/chrysalis/archive # can be any custom folder you'd like to store video segments to
      on_disk_clean_older_than: "5m" # remove older mp4 segments than 5m

- `mode: release`: disables debug mode for http server (default: release)
- `redis -> connection`: redis host with port (default: "redis:6379")
- `redis -> database` : 0 - 15. 0 is redis default database. (default: 0)
- `redis -> password`: optional redis password (default: "")
- `api -> endpoint`: chrysalis API location for remote signaling such as enable/disable storage (default: https://api.chryscloud.com)
- `annotation -> endpoint`: Crysalis Cloud annotation endpoint (default: https://event.chryscloud.com/api/v1/annotate)
- `annotation -> unacked limit`: maximum number of unacknowledged annotatoons (default: 299)
- `annotation -> poll_duration_ms`: poll every x miliseconds for batching purposes (default: 300ms)
- `annotation -> max_match_size`: maximum number of annotation per batch size (default: 299)
- `buffer -> in_memory`: number of decoded frames to store in memory per camera (default: 1)
- `on_disk`: true/false, store key-frame chunked mp4 files to disk (default: false)
- `on_disk_folder`: path to the folder where segments will be stored
- `on_disk_clean_older_than`: remove mp4 segments older than (default: 5m)
- `on_disk_schedule`: run disk cleanup scheduler cron job [#https://en.wikipedia.org/wiki/Cron](https://en.wikipedia.org/wiki/Cron)
- `on_disk` creates mp4 segments in format: `"current_timestamp in ms"_"duration_in_ms".mp4`. For example: `1600685088000_2000.mp4`