From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Tue,  6 Sep 2016 18:05:06 -0700
Subject: [Intel-wired-lan] [next PATCH S45 04/10] i40e: Remove 100 Mbps
	SGMII support for X722
In-Reply-To: <1473210312-29592-1-git-send-email-bimmy.pujari@intel.com>
References: <1473210312-29592-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1473210312-29592-5-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>

This patch fixes the problem where driver shows 100 Mbps as a supported speed, 
and allows it to be configured for advertising on X722 devices. This patch 
fixes the problem by not setting the 100 Mbps SGMII flag for X722 devices. 

Without this patch, the user incorrectly thinks that 100 Mbps is supported 
and hence might try to advertise it on X722 devices when it is actually not 
a supported speed. 

Signed-off-by: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
Change-ID: I8c3d7c4251a9402d98994ed29749b7b895a0f205
---
Testing Hints: Test on Copperpeak that 100 Mbps is not listed as
supported or advertised on ethtool. Also ensure we are not able
to configure the speed to 100 Mbps.

HSD-number: 10021180

 drivers/net/ethernet/intel/i40e/i40e_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 68c1253..e83b317 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -8591,7 +8591,6 @@ static int i40e_sw_init(struct i40e_pf *pf)
 			     I40E_FLAG_WB_ON_ITR_CAPABLE |
 			     I40E_FLAG_MULTIPLE_TCP_UDP_RSS_PCTYPE |
 			     I40E_FLAG_NO_PCI_LINK_CHECK |
-			     I40E_FLAG_100M_SGMII_CAPABLE |
 			     I40E_FLAG_USE_SET_LLDP_MIB |
 			     I40E_FLAG_GENEVE_OFFLOAD_CAPABLE;
 	} else if ((pf->hw.aq.api_maj_ver > 1) ||
-- 
2.4.11

