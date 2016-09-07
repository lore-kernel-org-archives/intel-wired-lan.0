From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Tue,  6 Sep 2016 18:05:02 -0700
Subject: [Intel-wired-lan] [next PATCH S45-V2 00/10] i40e/i40evf updates
Message-ID: <1473210312-29592-1-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Alexander Duyck adds code to limit TX descriptor count in cases where frag 
size is greater than 16K.

Bimmy Pujari removes unnecessary error checking against i40evf_up_complete.

Alan Brady adds code to fix deleting mac filters.

Harshitha Ramamurthy removes 100 Mbps SGMII support for X722.

Henry Tieman removes unreachable code.

Jacob Keller adds code to cleanup ATR auto_disable_flags use & checks 
conflicting ntuple/sideband rules when re-enabling ATR.

Lihong Yang removes unnecessary error checking against i40e_shutdown_adminq.

Preethi Banala adds encap csum VF offload flag.

 drivers/net/ethernet/intel/i40e/i40e_ethtool.c    |  3 ++
 drivers/net/ethernet/intel/i40e/i40e_main.c       | 43 ++++++++++-------------
 drivers/net/ethernet/intel/i40e/i40e_txrx.c       | 21 +++++------
 drivers/net/ethernet/intel/i40e/i40e_virtchnl.h   |  1 +
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c     |  7 ++--
 drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h |  1 +
 drivers/net/ethernet/intel/i40evf/i40evf_main.c   | 16 +++------
 7 files changed, 39 insertions(+), 53 deletions(-)

-- 
2.4.11

