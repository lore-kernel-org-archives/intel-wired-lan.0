From: Sridhar Samudrala <sridhar.samudrala@intel.com>
Date: Tue,  3 Jan 2017 10:07:48 -0800
Subject: [Intel-wired-lan] [net-next PATCH v2 0/6] i40e: Add VF Port
	representator support for SR-IOV VFs
Message-ID: <1483466874-2962-1-git-send-email-sridhar.samudrala@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

- Patch 1 introduces devlink interface to get/set the mode of SRIOV switch.
- Patch 2 adds support to create VF port representor(VFPR) netdevs associated
  with SR-IOV VFs that can be used to control/configure VFs from PF name space.
- Patch 3 enables syncing link state between VFs and VFPRs.
- Patch 4 adds a new type to metadata_dst to allow passing VF id to lower device.
- Patch 5 adds TX and RX support to VFPR netdevs.
- Patch 6 enables HW and SW VFPR statistics to be exposed via netlink on VFPR
  netdevs.

v2:
- handle i40e_alloc_vfpr_netdev() failures.
- minor comment/commit msg updates.

Jakub Kicinski (1):
  net: store port/representator id in metadata_dst

Sridhar Samudrala (5):
  i40e: Introduce devlink interface.
  i40e: Introduce VF Port Representator(VFPR) netdevs.
  i40e: Sync link state between VFs and VFPRs
  i40e: Add TX and RX support in switchdev mode.
  i40e: Add support for exposing VF port statistics via VFPR netdev on
    the host.

 drivers/net/ethernet/intel/Kconfig                 |   1 +
 drivers/net/ethernet/intel/i40e/i40e.h             |   4 +
 drivers/net/ethernet/intel/i40e/i40e_main.c        | 103 ++++++-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        | 132 ++++++++-
 drivers/net/ethernet/intel/i40e/i40e_txrx.h        |   1 +
 drivers/net/ethernet/intel/i40e/i40e_type.h        |   3 +
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 324 ++++++++++++++++++++-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h |  25 ++
 include/net/dst_metadata.h                         |  35 ++-
 net/core/dst.c                                     |  15 +-
 net/core/filter.c                                  |   1 +
 net/ipv4/ip_tunnel_core.c                          |   6 +-
 net/openvswitch/flow_netlink.c                     |   4 +-
 13 files changed, 620 insertions(+), 34 deletions(-)

-- 
2.5.5

