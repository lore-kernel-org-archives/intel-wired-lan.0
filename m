From: Greg Edwards <gedwards@ddn.com>
Date: Thu, 20 Jul 2017 10:00:56 -0600
Subject: [Intel-wired-lan] [PATCH v2 0/2] igbvf: VF mailbox timeouts with
	multiple VF messages
Message-ID: <20170720160058.8198-1-gedwards@ddn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

We've encountered VF mailbox timeout issues with I350 VFs assigned to VMs, when
NetworkManager or lldpad (LLDP) are assigning multicast addresses in rapid
succession.  A VF message may encounter a mailbox timeout waiting for the ACK
from the PF, and the igbvf_watchdog_task will detect the condition and reset
the VF.  This pattern can continue for some time or indefinitely.

Changes from v1:
  - fix in igbvf VF driver instead of igb PF driver, per suggestion by
    Alex.

Greg Edwards (2):
  igbvf: add lock around mailbox ops
  igbvf: after mailbox write, wait for reply

 drivers/net/ethernet/intel/igbvf/ethtool.c |  4 +++
 drivers/net/ethernet/intel/igbvf/mbx.c     |  4 +++
 drivers/net/ethernet/intel/igbvf/netdev.c  | 47 ++++++++++++++++++++++++++++++
 drivers/net/ethernet/intel/igbvf/vf.c      | 10 +++++--
 drivers/net/ethernet/intel/igbvf/vf.h      |  1 +
 5 files changed, 64 insertions(+), 2 deletions(-)

-- 
2.13.3

