# Chrysalis Clouds' REST APIs

The Chrysalis Clouds' video-edge-ai-proxy server exposes RESTful APIs for stream management. With these APIs you can start, stop, delete, and list the rtmp_to_rtsp containers.

### Start rtsp container

Start a new rtsp stream process

=== "Go"
			
``` go
func (ph *rtspProcessHandler) StartRTSP(c *gin.Context) {
	var streamProcess models.StreamProcess
	if err := c.ShouldBindWith(&streamProcess, binding.JSON); err != nil {
		g.Log.Warn("missing required fields", err)
		AbortWithError(c, http.StatusBadRequest, err.Error())
		return
	}

	if streamProcess.RTSPEndpoint == "" {
		AbortWithError(c, http.StatusBadRequest, "RTP endpoint required")
		return
	}
	deviceID := streamProcess.Name
	if streamProcess.Name == "" {
		hash := fmt.Sprintf("%x", md5.Sum([]byte(streamProcess.RTSPEndpoint)))
		deviceID = hash
	}
	streamProcess.RTMPStreamStatus = &models.RTMPStreamStatus{
		Storing:   false,
		Streaming: true,
	}

	rtspImageTag := models.CameraTypeToImageTag["rtsp"]
	currentImagesList, err := ph.settingsManager.ListDockerImages(rtspImageTag)
	if err != nil {
		g.Log.Error("failed to list currently available images", err)
		AbortWithError(c, http.StatusInternalServerError, err.Error())
		return
	}

	err = ph.processManager.Start(&streamProcess, currentImagesList)
	if err != nil {
		g.Log.Warn("failed to start process ", deviceID, err)
		AbortWithError(c, http.StatusConflict, err.Error())
		return
	}
	c.Status(http.StatusOK)
}

```

### Find upgrades

Check if each process has an upgradable version available on local disk

=== "Go"

``` go
func (ph *rtspProcessHandler) FindRTSPUpgrades(c *gin.Context) {

	imageTag := models.CameraTypeToImageTag["rtsp"]

	imageUpgrade, err := ph.settingsManager.ListDockerImages(imageTag)
	if err != nil {
		AbortWithError(c, http.StatusInternalServerError, err.Error())
		return
	}

	upgrades, err := ph.processManager.FindUpgrades(imageUpgrade)
	if err != nil {
		g.Log.Error("failed finding image upgrades", err)
		AbortWithError(c, http.StatusInternalServerError, err.Error())
		return
	}

	c.JSON(http.StatusOK, upgrades)
}
```

### Upgrade Container

Upgrade a running container for specific process

=== "Go"

``` go
func (ph *rtspProcessHandler) UpgradeContainer(c *gin.Context) {

	var process models.StreamProcess
	if err := c.ShouldBindWith(&process, binding.JSON); err != nil {
		g.Log.Warn("missing required fields", err)
		AbortWithError(c, http.StatusBadRequest, err.Error())
		return
	}

	if process.ImageTag == "" {
		AbortWithError(c, http.StatusBadRequest, "imagetag is empty on StreamProcess")
		return
	}

	splitted := strings.Split(process.ImageTag, ":")
	if len(splitted) != 2 {
		AbortWithError(c, http.StatusBadRequest, "invalid image. tag (verion) required")
		return
	}
	baseTag := splitted[0]

	newProc, err := ph.processManager.UpgradeRunningContainer(&process, baseTag+":"+process.NewerVersion)
	if err != nil {
		g.Log.Error("failed to upgrade running container", process.Name, process.ImageTag)
		AbortWithError(c, http.StatusConflict, err.Error())
		return
	}
	c.JSON(http.StatusOK, newProc)
}
```

### Stop

Stop a running rtsp process

=== "GO"

``` go
func (ph *rtspProcessHandler) Stop(c *gin.Context) {
	deviceID := c.Param("name")
	if deviceID == "" {
		AbortWithError(c, http.StatusBadRequest, "required device_id")
		return
	}
	err := ph.processManager.Stop(deviceID)
	if err != nil {
		g.Log.Warn("failed to start process ", deviceID, err)
		AbortWithError(c, http.StatusConflict, err.Error())
		return
	}
	c.Status(http.StatusOK)
}
```

### Info

Get information about a particular process

=== "Go"

``` go
func (ph *rtspProcessHandler) Info(c *gin.Context) {
	deviceID := c.Param("name")
	if deviceID == "" {
		AbortWithError(c, http.StatusBadRequest, "required device_id")
		return
	}
	info, err := ph.processManager.Info(deviceID)
	if err != nil {
		AbortWithError(c, http.StatusBadRequest, err.Error())
		return
	}
	c.JSON(http.StatusOK, info)
}

```

### List

List all the processes that are in any state

=== "Go"

``` go
func (ph *rtspProcessHandler) List(c *gin.Context) {
	processes, err := ph.processManager.List()
	if err != nil {
		AbortWithError(c, http.StatusInternalServerError, err.Error())
		return
	}
	c.JSON(http.StatusOK, processes)
}
```