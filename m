From: Alexander Duyck <alexander.h.duyck@intel.com>
Date: Tue, 03 Apr 2018 17:15:53 -0400
Subject: [Intel-wired-lan] [iwl next-queue PATCH 00/10] Clean-up macvlan
 offloading
Message-ID: <20180403211519.7880.70243.stgit@ahduyck-green-test.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch set represents yet another phase of the macvlan cleanup I have
been working on.

The main goal of these changes is to make it so that we only support
offloading what we can actually offload and we don't break any existing
functionality. So for example we were claiming to advertise source mode
macvlan and we were doing nothing of the sort, so support for that has been
dropped.

The biggest change with this set is that broadcast/multicast replication is
no longer being supported in software. I am dropping it as it leads to
scaling issues when a broadcast frame has to be replciated up to 64 times.

Beyond that this set goes through and optimized the time needed to bring up
and tear down the macvlan interfaces on ixgbe and provides a clean way for
us to disable the macvlan offload when needed.

---

Alexander Duyck (10):
      ixgbe: Drop support for macvlan specific unicast lists
      macvlan: Rename fwd_priv to accel_priv and add accessor function
      macvlan: Use software path for offloaded local, broadcast, and multicast traffic
      ixgbe/fm10k: Drop tracking stats for macvlan broadcast/multicast
      macvlan: macvlan_count_rx shouldn't be static inline AND extern
      macvlan: Add function to test for destination filtering support
      macvlan: Provide function for interfaces to release HW offload
      ixgbe/fm10k: Only support macvlan offload for types that support hairpin switching
      ixgbe: Drop real_adapter from l2 fwd acceleration structure
      ixgbe: Avoid performing unnecessary resets for macvlan offload


 drivers/net/ethernet/intel/fm10k/fm10k_main.c   |    7 -
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c |   12 +
 drivers/net/ethernet/intel/ixgbe/ixgbe.h        |    1 
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c   |  306 +++++++++++++----------
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c  |    5 
 drivers/net/macvlan.c                           |   68 +++--
 include/linux/if_macvlan.h                      |   29 ++
 7 files changed, 243 insertions(+), 185 deletions(-)

--
