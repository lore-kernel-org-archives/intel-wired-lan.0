From: Avinash Dayanand <avinash.dayanand@intel.com>
Date: Fri, 18 Mar 2016 12:18:04 -0700
Subject: [Intel-wired-lan] [next PATCH S31 v4 00/12] i40e/i40evf updates
Message-ID: <1458328696-135941-1-git-send-email-avinash.dayanand@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Anjali Singhai Jain has enabled Geneve offload for FW API version 1.5 and
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

 drivers/net/ethernet/intel/i40e/i40e_common.c      |  1 +
 drivers/net/ethernet/intel/i40e/i40e_devids.h      |  1 +
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     | 16 ++++++++++
 drivers/net/ethernet/intel/i40e/i40e_main.c        | 12 +++++--
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 37 ++++++++++------------
 drivers/net/ethernet/intel/i40evf/i40e_common.c    |  1 +
 drivers/net/ethernet/intel/i40evf/i40e_devids.h    |  1 +
 drivers/net/ethernet/intel/i40evf/i40evf_main.c    | 31 +++++++++++++++---
 8 files changed, 74 insertions(+), 26 deletions(-)

-- 
2.4.3

