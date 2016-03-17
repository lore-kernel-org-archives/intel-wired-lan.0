From: Avinash Dayanand <avinash.dayanand@intel.com>
Date: Thu, 17 Mar 2016 09:41:18 -0700
Subject: [Intel-wired-lan] [next PATCH S31 v3 00/12] i40e/i40evf updates
Message-ID: <1458232890-110933-1-git-send-email-avinash.dayanand@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Anjali Singhai Jain has enabled Geneve offload for FW API version 1.4 and
	above for XL710/X710 devices

Avinash Dayanand has provided a fix for supported link modes in
	10GBaseT PHY's.

Catherine Sullivan has provided a fix for get_rss_aq issue and added new
	device ID for X722.

Mitch Williams has removed an unused variable, fixed VLAN features, made
	VF resets more reliable, added longer wait after removing the
	module and lowered some message levels

Shannon Nelson has added code to disable link polling and added support
	to request phy media event at reset time.

 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     | 16 +++++++++
 drivers/net/ethernet/intel/i40e/i40e_main.c        | 41 ++++++++++++++++++----
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        |  1 -
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 37 +++++++++----------
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c      |  1 -
 drivers/net/ethernet/intel/i40evf/i40evf_main.c    | 37 ++++++++++++++++---
 6 files changed, 101 insertions(+), 32 deletions(-)

-- 
2.4.3

