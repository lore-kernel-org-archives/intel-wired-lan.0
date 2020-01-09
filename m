From: Jiri Pirko <jiri@resnulli.us>
Date: Thu, 9 Jan 2020 08:05:02 +0100
Subject: [Intel-wired-lan] [PATCH 3/4] devlink: add support for
 triggering snapshots from userspace
In-Reply-To: <20200109010818.1326575-4-jacob.e.keller@intel.com>
References: <20200109010818.1326575-1-jacob.e.keller@intel.com>
 <20200109010818.1326575-4-jacob.e.keller@intel.com>
Message-ID: <20200109070502.GC2235@nanopsycho.orion>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Thu, Jan 09, 2020 at 02:08:18AM CET, jacob.e.keller at intel.com wrote:
>Currently, devlink region snapshots are captured by the driver at some
>internal trigger. There is no standard method for userspace to request
>that a snapshot be created.
>
>For some use cases of regions, this is acceptable. The snapshots only
>make sense if taken in response to some internal driver event.
>
>However, regions could be used for other purposes. For example, a driver
>might export a region that represents the contents of some portion of
>the device flash. In this case, there is no event that triggers
>a snapshot. Instead, it makes sense for user space to request a snapshot
>in some manner.
>
>Currently, drivers must implement such a trigger through an out-of-band
>mechanism. The netdevsim driver does this through a debugfs file.
>
>Create a standard interface for requesting snapshots via a new devlink
>command: DEVLINK_CMG_REGION_TRIGGER_SNAPSHOT.
>
>At region creation time, drivers may optionally define
>a trigger_snapshot function callback. If not defined, the
>DEVLINK_CMD_REGION_TRIGGER_SNAPSHOT will simply report EOPNOTSUPP.

Similar mechanism is already implemented for health reporters. Why that
wouln't work for you?
