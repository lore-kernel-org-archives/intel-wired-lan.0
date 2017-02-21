From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Tue, 21 Feb 2017 15:55:38 -0800
Subject: [Intel-wired-lan] [next PATCH S61 00/10] i40e/i40evf updates
Message-ID: <1487721348-25617-1-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Alexander Duyck updated code to better handle incrementing page count, 
added code to fix use after free in Rx cleanup path, cleans-up 
process_skb_fields function, drops FCoE code from core driver files 
and drops FCoE code that always evaluates to false or 0.

Bimmy Pujari removed delays which were no loger needed.

Carolyn Wyborny fixed code for queue timing delays.

Harshitha Ramamurthy added code to fix configuration of RSS table with
DCB.

Henry Tieman added support for 25G in ethtool.

Robert Konklewski added code to fix race conditions in VF reset.

 drivers/net/ethernet/intel/Kconfig                 |  11 -
 drivers/net/ethernet/intel/i40e/Makefile           |   1 -
 drivers/net/ethernet/intel/i40e/i40e.h             |  62 ---
 drivers/net/ethernet/intel/i40e/i40e_common.c      |  27 -
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c     |  19 -
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     | 618 +++++++++++++++++++--
 drivers/net/ethernet/intel/i40e/i40e_main.c        | 300 +---------
 drivers/net/ethernet/intel/i40e/i40e_osdep.h       |   3 -
 drivers/net/ethernet/intel/i40e/i40e_prototype.h   |   3 -
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        |  60 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.h        |  24 +-
 drivers/net/ethernet/intel/i40e/i40e_type.h        | 138 -----
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  43 +-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h |   1 -
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c      |  33 +-
 drivers/net/ethernet/intel/i40evf/i40e_txrx.h      |  19 +-
 16 files changed, 690 insertions(+), 672 deletions(-)

-- 
2.4.11

