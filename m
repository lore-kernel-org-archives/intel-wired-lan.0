From: Alexander Duyck <alexander.h.duyck@intel.com>
Date: Mon, 04 Jun 2018 11:17:38 -0400
Subject: [Intel-wired-lan] [RFC PATCH 0/4] Add support for DCB and XPS with
 MACVLAN offload
Message-ID: <20180604150847.74754.8585.stgit@ahduyck-green-test.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch set is meant to address a number of shortcomings in the current
implementation of MACVLAN offload. The main issue being the fact that the
current Tx queue implementation for ixgbe required the use of
ndo_select_queue which doesn't necessarily play well with DCB or XPS.

I started this patch set to address that and thought I would submit the
start of the series as an RFC just to make sure I am headed in the right
direction and to see if there is anything I am overlooking. With these
patches applied we now start seeing what I am calling "subordinate
channels" which show themselves via a "-x" suffix where the "-x" can be
anything from "-1" to "-32767". So for example traffic class 0 with a
subordinate class of 5 will be called out as "0-5" if you dump the traffic
class via the sysfs value for the queue.

The main pieces that still need to be handled are the updating of the
ndo_select_queue function and the fallback call to allow support for
passing the accel_priv which I am changing to a netdev. I figure those
patches will be mostly noise so I didn't see the need to include them in
this RFC.

---

Alexander Duyck (4):
      net-sysfs: Drop support for XPS and traffic_class on single queue device
      net: Add support for subordinate device traffic classes
      ixgbe: Add code to populate and use macvlan tc to Tx queue map
      net: Add support for subordinate traffic classes to netdev_pick_tx


 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   55 +++++++---
 drivers/net/macvlan.c                         |   10 --
 include/linux/netdevice.h                     |   20 +++
 net/core/dev.c                                |  144 +++++++++++++++++++++----
 net/core/net-sysfs.c                          |   36 ++++++
 5 files changed, 215 insertions(+), 50 deletions(-)

--
