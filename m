From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 22 Nov 2017 10:56:10 -0800
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH 00/16] ixgbe/fm10k:
 macvlan fixes
Message-ID: <20171122185256.29785.93548.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch series is meant to make it so that both fm10k and ixgbe drivers
will at least function when macvlan offload is enabled. Prior to these
patches both fm10k and ixgbe had numerous issues that had a negative impact
on driver stability with the offload enabled, or in the case of fm10k the
interfaces would never actually receive any traffic as the filters were
never configured correctly.

There are still a few issues outstanding after these patches, but I needed
to flush out what I had before this patch set became too large.

The next set of patches will include changes to the macvlan interface
itself and so I thought that would make a good division between this patch
set and the one to follow.

---

Alexander Duyck (16):
      ixgbe: Fix interaction between SR-IOV and macvlan offload
      ixgbe: Perform reinit any time number of VFs change
      ixgbe: Add support for macvlan offload RSS on X550 and clean-up pool handling
      ixgbe: There is no need to update num_rx_pools in L2 fwd offload
      ixgbe: Fix limitations on macvlan so we can support up to 63 offloaded devices
      ixgbe: Use ring values to test for Tx pending
      ixgbe: Drop l2_accel_priv data pointer from ring struct
      ixgbe: Assume provided MAC filter has been verified by macvlan
      ixgbe: Default to 1 pool always being allocated
      ixgbe: Don't assume dev->num_tc is equal to hardware TC config
      ixgbe/fm10k: Record macvlan stats instead of Rx queue for macvlan offloaded rings
      ixgbe: Do not manipulate macvlan Tx queues when performing macvlan offload
      ixgbe: avoid bringing rings up/down as macvlans are added/removed
      ixgbe: Fix handling of macvlan Tx offload
      net: Cap number of queues even with accel_priv
      fm10k: Fix configuration for macvlan offload


 drivers/net/ethernet/intel/fm10k/fm10k_main.c    |   14 -
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c  |   25 +
 drivers/net/ethernet/intel/ixgbe/ixgbe.h         |    8 
 drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c  |    2 
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |    6 
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c     |   72 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    |  407 ++++++++--------------
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c   |   63 +--
 net/core/dev.c                                   |    3 
 9 files changed, 256 insertions(+), 344 deletions(-)

--
