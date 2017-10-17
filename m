From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Tue, 17 Oct 2017 14:18:07 -0700
Subject: [Intel-wired-lan] [RFC PATCH next 0/2] Add support for macvlan
	offload
Message-ID: <1508275089-430113-1-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The XL710 and family was originally designed as a device to support the
growing "cloud" networking needs.  With its large number of queues,
filters, VFs, and other features, it can be a very handy device for
sorting traffic in a variety of ways.  However, one early design point
was to support macvlan offloads, and this was never really worked out;
as the Intel group knows, this has bothered me for a rather long time.

The original intent was to use a separate VSI for each macvlan offloaded.
This would make multiple queues and various other features available for
the new pseudo-device.  Unfortunately, there are 2 problems with this
approach: (1) the interraction between the stack and the driver makes it
hard to figure out which VSI:queue pair to transmit through, and (2) there
are a lot more queues available for offload duties than there are VSIs.

Using a simpler design, we can partition off some of the queues in the
PF's primary VSI and use the XL710's macaddr-to-queue filtering capability
to make a large number of macvlan offload channels available.

This RFC is with code that has been shown to get packets in and out of the
right queues, but has gone through very little testing.  In the spirit
of fail fast, I wanted to get this out quickly for comments and get the
rework cycle started.

Shannon Nelson (2):
  i40e: add ToQueue specific handling for mac filters
  i40e: add support for macvlan hardware offload

 drivers/net/ethernet/intel/i40e/i40e.h             |   27 ++-
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c     |    4 +-
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |   15 +
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  311 ++++++++++++++++++--
 drivers/net/ethernet/intel/i40e/i40e_txrx.h        |    1 +
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |   10 +-
 6 files changed, 327 insertions(+), 41 deletions(-)

