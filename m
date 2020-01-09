From: Jiri Pirko <jiri@resnulli.us>
Date: Thu, 9 Jan 2020 08:00:51 +0100
Subject: [Intel-wired-lan] [PATCH 0/4] devlink region snapshot triggering
In-Reply-To: <20200109010818.1326575-1-jacob.e.keller@intel.com>
References: <20200109010818.1326575-1-jacob.e.keller@intel.com>
Message-ID: <20200109070051.GA2235@nanopsycho.orion>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Thu, Jan 09, 2020 at 02:08:15AM CET, jacob.e.keller at intel.com wrote:
>This series consists of patches to enable devlink to request a snapshot via
>a new DEVLINK_CMD_REGION_TRIGGER_SNAPSHOT.
>
>The netdevsim driver is modified to support the new trigger_snapshot
>callback as an example of how this can be used.
>
>There is also some fix ups for s/shapshot/snapshot/ in documentation
>and the devlink_snapshot_id_get function.

You can already trigger health reporter dump from userspace. Why don't
you use health reporter?


>
>Jacob Keller (3):
>  devlink: correct misspelling of snapshot
>  doc: fix typo of snapshot in documentation
>  devlink: add support for triggering snapshots from userspace
>
>The last patch is a patch to the iproute2 project to implement support for
>the new command.
>
>Jacob Keller (1):
>  devlink: add support for DEVLINK_CMD_REGION_TRIGGER_SNAPSHOT
>
> Documentation/admin-guide/devices.txt       |  2 +-
> Documentation/media/v4l-drivers/meye.rst    |  2 +-
> drivers/net/ethernet/mellanox/mlx4/crdump.c |  6 +--
> drivers/net/netdevsim/dev.c                 | 37 +++++++++++-----
> include/net/devlink.h                       | 14 +++---
> include/uapi/linux/devlink.h                |  2 +
> net/core/devlink.c                          | 49 ++++++++++++++++++---
> 7 files changed, 85 insertions(+), 27 deletions(-)
>
> devlink/devlink.c            | 20 ++++++++++++++++++++
> include/uapi/linux/devlink.h |  2 ++
> 2 files changed, 22 insertions(+)
>
>-- 
>2.25.0.rc1
>
