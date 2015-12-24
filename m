From: Gangfeng <gangfeng.huang@ni.com>
Date: Thu, 24 Dec 2015 10:44:59 +0800
Subject: [Intel-wired-lan] [next PATCH 0/3] igb: add Rx ethertype filter and
	VLAN priority filter
Message-ID: <1450925102-28992-1-git-send-email-gangfeng.huang@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Rebase the patch on the next-queue tree

Gangfeng Huang (3):
  igb: Enable the ethtool interface fo Rx filter
  igb: add support of ethertype RX filters
  igb: add support of Rx VLAN priority filters

 drivers/net/ethernet/intel/igb/e1000_82575.h   |    5 +
 drivers/net/ethernet/intel/igb/e1000_defines.h |    5 +
 drivers/net/ethernet/intel/igb/e1000_regs.h    |    1 +
 drivers/net/ethernet/intel/igb/igb.h           |   52 ++++
 drivers/net/ethernet/intel/igb/igb_ethtool.c   |  345 ++++++++++++++++++++++++
 drivers/net/ethernet/intel/igb/igb_main.c      |   57 ++++
 drivers/net/ethernet/intel/igb/igb_ptp.c       |    4 +-
 7 files changed, 467 insertions(+), 2 deletions(-)

-- 
1.7.9.5

