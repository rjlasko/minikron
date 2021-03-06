![logo](https://raw.githubusercontent.com/rjlasko/minikron/master/logo.png)

# minikron
A minimal container used to run Cron jobs.

# About this container
This is an image based on Alpine Linux that provides a minimal construct to run cron-jobs within a Docker container. `msmtp` has been installed to replace BusyBox `sendmail` as the default mail transfer agent. `cronic` has also been installed to interpret the execution and format output of jobs run within cron to help control its emailed output.

# How to use this image

## docker-compose
The simplest way to use this image is to use a `docker-compose.yml` file.  Here is a fully configured example.

```
version: '2.1'
services:
  mykron:
    image: rjlasko/minikron
    containername: kron
    restart: unless-stopped
    environment:
      - CRONTAB_MAILTO=your@email.here
      - CRONTAB_USEDEFAULT=true
    volumes:
      - "${MSMTPRC}:/etc/msmtprc:ro"
      - "${CRONTAB}:/etc/periodic/cron.tab:ro"
      - "${HOURLY_01}:/etc/periodic/hourly/01.sh:ro"
      - "${DAILY_01}:/etc/periodic/daily/01.sh:ro"
      - "${DAILY_02}:/etc/periodic/daily/02.sh:ro"
      - "${TZ}:/etc/localtime:ro"
```

## docker
Slightly more work, but just as functional is to use the CLI interface to configure and build your own container from just the `Dockerfile`.

```
docker run -d \
	--name kron \
	--restart=always \
	--env CRONTAB_MAILTO=your@email.here \
	--env CRONTAB_USEDEFAULT=true \
	-v "${MSMTPRC}":/etc/msmtprc:ro \
	-v "${CRONTAB}":/etc/periodic/cron.tab:ro \
	-v "${HOURLY_01}":/etc/periodic/hourly/01.sh:ro \
	-v "${DAILY_01}":/etc/periodic/daily/01.sh:ro \
	-v "${DAILY_02}":/etc/periodic/daily/02.sh:ro \
	-v "${TZ}":/etc/localtime \
	rjlasko/minikron
```

## Cron
Cron jobs may be called by two different methods

### Classic Cron formatted
If the following crontab standard format file is found during container start time, it will be appended to the root user's crontab.

```
/etc/periodic/cron.tab
```

### Running jobs using the default crontab
On container start, the environment variable `CRONTAB_USEDEFAULT` is evaluated.  If it is equal (case-insensitive) to `TRUE`, then the default crontab is not cleared.  In this case, placing executable files in a directory structure corresponding to pre-defined cron-jobs calling the `run-parts` executable on the given directories occurring with the stated periodicity.

```
/etc/periodic/15min
/etc/periodic/hourly
/etc/periodic/daily
/etc/periodic/weekly
/etc/periodic/monthly
```

## MSMTP & Email
A primary goal of this project is to support `crond`'s ability to send emails to the email address defined by the `MAILTO` variable in the `crontab` definition.  The `CRONTAB_MAILTO` environment variable is provided to specify the destination of any `cron` generated emails.

The Alpine Linux default email program `sendmail` has been replaced by `msmtp` due to its ease of use, and active development.  This will allow us to leverage all of its functionality, mostly through the specification of its standard configuration file, to be located at:

```
/etc/msmtprc
```

## Cronic
Typically, we want Cron to email us when a job failed. To ensure that we get as much output from a failed script as possible, we utilize the great utility `cronic`.  This allows `cron` to generate a message (that gets logged and/or emailed) that contains the exit code of the job, as well as its STDOUT and STDERR.  To use this, simply pass your commands as arguments to `cronic`, within the `crontab`.

```
* * * * * cronic boom
```

## Timezone
The default OS-defined time zone is set to UTC. Changing of the timezone is supported by overriding the `TZ` environment variable, as defined by the 'TZ database name' enumeration. This enumeration set can be found on [Wikipedia](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones).

```
TZ=US/Mountain
```

## Links
[rjlasko/alpine-s6](https://github.com/rjlasko/alpine-s6/)

[BusyBox Cron](https://busybox.net/downloads/BusyBox.html)

[msmtp](http://msmtp.sourceforge.net/)

[Cronic](http://habilis.net/cronic/)

