From: Vlad Zolotarov <vladz@cloudius-systems.com>
Date: Sun, 29 Mar 2015 19:16:30 +0300
Subject: [Intel-wired-lan] [PATCH net-next v9 0/7]: ixgbevf: Allow querying
	VFs RSS indirection table and key
Message-ID: <1427645797-10832-1-git-send-email-vladz@cloudius-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add the ethtool ops to VF driver to allow querying the RSS indirection table
and RSS Random Key. 

Currently we will support only 82599 and x540 devices. On these devices VFs share the
RSS Redirection Table and Hash Key with a PF and letting the VF query this information may
introduce some security risks. Therefore we will disable this feature by default.

The new netdev op is going to allow a system administrator to change the default behaviour with
"ip link set" command. The relevant iproute2 patch has already been sent and awaits for this series to
be accepted.

 - netdev: Add a new netdev op to allow/block VF from querying RSS Indirection Table and
   RSS Hash Key.
 - PF driver: Add new VF-PF channel commands.
 - VF driver: Utilize these new commands and add the corresponding
              ethtool callbacks.

New in v9:
   - Reduce the support to 82599 and x540 devices only.
   - ixgbe: improvements in query RETA VF-PF command implementation:
      - Use the cached RETA contents.
      - Compress the mailbox message.
   - ixgbevf: improvements in RETA query code:
      - Implement a "compression" of VF's RETA contents: pass only 2 bits
        per-entry.
      - RETA querying is done in a single mailbox operation thanks to compression.
   - Get the RSS HASH Key value from the PF's adapter->rss_key[].
   - Added IXGBEVF_RSS_HASH_KEY_SIZE macro.

New in v8:
   - Protect new mailbox operations with adapter.mbx_lock spinlock.

New in v7:
   - Add ixgbe_mbox_api_12 case in ixgbevf_set_num_queues().
   - Properly expand HW RETA into the ethtool buffer.

New in v6:
   - Add a proper return code when an VF query operations are blocked by PF.
   - Added a required get_rxnfc callback to ixgbevf_ethtool_ops.
   - Changed a description of PATCH7: set the correct ethtool options names.

New in v5:
   - Added a new netdev op to allow/block VF from querying RSS Indirection Table and
     RSS Hash Key.
   - Let VF query the RSS info only if VF is allowed to.

New in v4:
   - Forgot to run checkpatch on v3 and there were a few styling things to fix. ;)

New in v3:
   - Added a missing support for x550 devices.
   - Mask the indirection table values according to PSRTYPE[n].RQPL.
   - Minimized the number of added VF-PF commands.

New in v2:
   - Added a detailed description to patches 4 and 5.

New in v1 (compared to RFC):
   - Use "if-else" statement instead of a "switch-case" for a single option case.
     More specifically: in cases where the newly added API version is the only one
     allowed. We may consider using a "switch-case" back again when the list of
     allowed API versions in these specific places grows up.

Vlad Zolotarov (7):
  if_link: Add an additional parameter to ifla_vf_info for RSS querying
  ixgbe: Add a new netdev op to allow/prevent a VF from querying an RSS
    info
  ixgbe: Add a RETA query command to VF-PF channel API
  ixgbevf: Add a RETA query code
  ixgbe: Add GET_RSS_KEY command to VF-PF channel commands set
  ixgbevf: Add RSS Key query code
  ixgbevf: Add the appropriate ethtool ops to query RSS indirection
    table and key

 drivers/net/ethernet/intel/ixgbe/ixgbe.h          |   1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c     |   7 ++
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h      |   5 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c    | 104 ++++++++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.h    |   2 +
 drivers/net/ethernet/intel/ixgbevf/ethtool.c      |  58 +++++++++
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h      |   1 +
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |   5 +-
 drivers/net/ethernet/intel/ixgbevf/mbx.h          |   5 +
 drivers/net/ethernet/intel/ixgbevf/vf.c           | 142 ++++++++++++++++++++++
 drivers/net/ethernet/intel/ixgbevf/vf.h           |   3 +
 include/linux/if_link.h                           |   1 +
 include/linux/netdevice.h                         |   8 ++
 include/uapi/linux/if_link.h                      |   8 ++
 net/core/rtnetlink.c                              |  32 ++++-
 15 files changed, 375 insertions(+), 7 deletions(-)

-- 
2.1.0

