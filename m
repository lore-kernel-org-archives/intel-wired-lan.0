From: Gangfeng <gangfeng.huang@ni.com>
Date: Mon, 7 Mar 2016 17:38:24 +0800
Subject: [Intel-wired-lan] [PATCH v4 0/4] igb: enable RX network flow
	classification
Message-ID: <1457343508-7119-1-git-send-email-gangfeng.huang@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

After apply this series of patches, igb driver will supports advanced
RX filter that direct receive packets by flows to different hardware
queue. Enables tight control on routing a flow in the platform.

The ethtool commands and options:

-n --show-nfc
   Retrieves the receive network flow classification configurations

-N --config-nfc
   Configures the receive network flow classification classification

Change history of this patches:
Version 1:
  Split the patch to 3 patches for review;
  Save the filters and restore them after a reset;
  In ethtool command, use key word "proto" to replace "vlan-etype:
  Fix bugs
Version 2:
  Rebase the patches on the the latest dev-queue;
Version 3:
  Report a meaningful error code for misoperation;
Version 4:
  Rebase the patches on latest dev-queue;
  Update the patch description and code comments; 

Gangfeng Huang (4):
  igb: add support of RX network flow classification
  igb: support RX flow classification by ethertype
  igb: support RX flow classification by VLAN priority
  igb: fix error code in igb_add_ethtool_nfc_entry()

 drivers/net/ethernet/intel/igb/e1000_82575.h   |   5 +
 drivers/net/ethernet/intel/igb/e1000_defines.h |   4 +
 drivers/net/ethernet/intel/igb/e1000_regs.h    |   1 +
 drivers/net/ethernet/intel/igb/igb.h           |  53 ++++
 drivers/net/ethernet/intel/igb/igb_ethtool.c   | 345 +++++++++++++++++++++++++
 drivers/net/ethernet/intel/igb/igb_main.c      |  44 ++++
 drivers/net/ethernet/intel/igb/igb_ptp.c       |   4 +-
 7 files changed, 454 insertions(+), 2 deletions(-)

-- 
2.7.2

