# Custom redis configuration
Default configuration is in the root folder of the project: `./redis.conf`

* Update default `redis.conf` in the root directory of the project
* Uncomment volumes section in redis config

		# volumes:
	    #   - /data/chrysalis/redis:/data
	    #   - ./redis.conf:/usr/local/etc/redis/redis.conf
	    # command:
	    #   - redis-server
	    #   - /usr/local/etc/redis/redis.conf

Modify folders accordingly for Mac OS X and Windows
