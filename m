From: Yury Kylulin <yury.kylulin@intel.com>
Date: Tue,  7 Mar 2017 11:20:24 +0300
Subject: [Intel-wired-lan] [PATCH 0/2] igb/igbvf: MAC filter handling
Message-ID: <1488874826-5978-1-git-send-email-yury.kylulin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This small patch set enables support for configuring up to 3 additional MAC
filters for the VF. In some cases applications in the VM require
capabilities to assign several MAC addresses for the SRIOV interface by
leveraging HW offloads and work without enabling unicast promiscuous mode.

The idea was grabbed from implementation of the similar feature for ixgbe
out-of-tree driver.

Some basic tests have been done on i350 and 82576 based cards.

Yury Kylulin (2):
  igb: improve MAC filter handling
  igb/igbvf: Add VF MAC filter request capabilities

 drivers/net/ethernet/intel/igb/e1000_mbx.h |   4 +
 drivers/net/ethernet/intel/igb/igb.h       |  23 ++
 drivers/net/ethernet/intel/igb/igb_main.c  | 393 +++++++++++++++++++++++------
 drivers/net/ethernet/intel/igbvf/igbvf.h   |   2 +
 drivers/net/ethernet/intel/igbvf/mbx.h     |   4 +
 drivers/net/ethernet/intel/igbvf/netdev.c  |  44 +++-
 drivers/net/ethernet/intel/igbvf/vf.c      |  42 +++
 drivers/net/ethernet/intel/igbvf/vf.h      |   1 +
 8 files changed, 433 insertions(+), 80 deletions(-)

-- 
2.7.4

