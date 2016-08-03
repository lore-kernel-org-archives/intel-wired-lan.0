From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Wed,  3 Aug 2016 11:02:34 -0700
Subject: [Intel-wired-lan] [next PATCH S41 0/5] i40e/i40evf updates
Message-ID: <1470247359-31334-1-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Carolyn Wyborny adds code to refactor tail_bump, adds support for HMC 
 resource and profile for X722 & adds support for ARP NS in X722.

Jacob Keller adds code to use alloc_workqueue instead of 
create_singlethread_workqueue.

Mitch Williams adds code to report link speed.

 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h  | 61 ++++++++++++++++------
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  3 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        |  6 +--
 .../net/ethernet/intel/i40evf/i40e_adminq_cmd.h    | 61 ++++++++++++++++------
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c      |  6 +--
 drivers/net/ethernet/intel/i40evf/i40evf.h         |  1 +
 drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c | 26 +++++++--
 drivers/net/ethernet/intel/i40evf/i40evf_main.c    |  3 +-
 .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    | 55 +++++++++++++++----
 9 files changed, 166 insertions(+), 56 deletions(-)

-- 
2.4.11

