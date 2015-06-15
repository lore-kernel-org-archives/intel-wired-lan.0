From: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
Date: Mon, 15 Jun 2015 10:46:32 +0000
Subject: [Intel-wired-lan] [PATCH 0/3] ixgbe,
	ixgbevf: make VF driver check MC promisc enabled
Message-ID: <7F861DC0615E0C47A872E6F3C5FCDDBD05EDEF80@BPXM14GP.gisp.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>

Make PF returns error against VF multicast promiscuous mode request from
untrusted VF, and VF handles that error.
To reconfigure, PF send reset to VF when trust status is changed.

This patchset is against the latest Jeff's tree which contains my VF
multicast promiscuous mode patches.

Hiroshi Shimamoto (3):
  ixgbevf: refactor ixgbevf_update_mc_addr_list_vf
  ixgbe, ixgbevf: error MC promisc unless trusted
  ixgbe: ping to reset on changing trust status

 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 32 ++++++++++++------
 drivers/net/ethernet/intel/ixgbevf/vf.c        | 46 +++++++++++++++++++-------
 2 files changed, 55 insertions(+), 23 deletions(-)

-- 
1.8.3.1

