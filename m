From: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
Date: Fri, 28 Aug 2015 06:57:10 +0000
Subject: [Intel-wired-lan] [PATCH v8 0/3] Introduce VF trust capability and
	xcast_mode in VF
Message-ID: <7F861DC0615E0C47A872E6F3C5FCDDBD05F28E3D@BPXM14GP.gisp.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>

There is a limitation in the number of multicast L2 addresses in ixgbe
and ixgbevf driver. The number of multicast addresses in VF is 30 in the
current implementation. That means that we can use up to 30 IPv6
addresses only. On the other hand there is a functionality to set VF
multicast promiscuous mode in the NIC.

This patchset addresses the issue.

First, it introduces VF trusting capability. Like VF multicast promiscuous
may hurt security and performance. We would like to enable such
functionality only on trusted VF.
Next, it introduces VF xcast_mode that represents multicast mode in VF
and request it to PF. If ALLMULTI is set in VF network device, it requests
VF multicast promiscuous mode to PF. And the VF is trusted, PF enables VF
multicast promiscuous mode.

Short history
v5->v6
	Reorganize patchsets, make it with VF trust and MC promisc mode.

v6->v7
	Change to introduce xcast_mode instead of dedicated VF multicast
	promisc mode API.

v7->v8
	Fix to use EOPNOTSUPP in ixgbe_update_vf_xcast_mode() on error,
	instead of -1.

Hiroshi Shimamoto (3):
  if_link: Add control trust VF
  ixgbe: Add new ndo to trust VF
  ixgbe, ixgbevf: Add new mbox API xcast mode

 drivers/net/ethernet/intel/ixgbe/ixgbe.h          |  8 ++
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c     |  1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h      |  2 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c    | 96 +++++++++++++++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.h    |  1 +
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h      |  6 ++
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |  8 ++
 drivers/net/ethernet/intel/ixgbevf/mbx.h          |  2 +
 drivers/net/ethernet/intel/ixgbevf/vf.c           | 41 ++++++++++
 drivers/net/ethernet/intel/ixgbevf/vf.h           |  1 +
 include/linux/if_link.h                           |  1 +
 include/linux/netdevice.h                         |  3 +
 include/uapi/linux/if_link.h                      |  6 ++
 net/core/rtnetlink.c                              | 24 +++++-
 14 files changed, 197 insertions(+), 3 deletions(-)

-- 
1.8.3.1

