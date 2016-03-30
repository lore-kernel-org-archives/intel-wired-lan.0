From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
Date: Wed, 30 Mar 2016 03:49:37 -0700
Subject: [Intel-wired-lan] [v2 next PATCH S32 02/13] i40e: Leave debug_mask
	cleared at init
In-Reply-To: <1459334988-19951-1-git-send-email-harshitha.ramamurthy@intel.com>
References: <1459334988-19951-1-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <1459334988-19951-3-git-send-email-harshitha.ramamurthy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Shannon Nelson <shannon.nelson@intel.com>

Don't set our internal debug_mask at startup unless we get specific signal
to from the debug module parameter.

This should take care of the issue with all the device capabilities getting
printed even when we hadn't asked for the debug info.

Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
Change-ID: I7fbc6bd8b11ed9b0631ec018ff36015a04100b6c
---
Testing Hints:
	Force a PFR and see that the extra debug message don't show up

	enable debug with
		ethtool -i <ethX> msglvl 0xf0000001
	then force a PFR, and see that the debug message *do* show up

	disable debug with
		ethtool -i <ethX> msglvl 0xf0000000
	then force a PFR, and see that the debug message do *not* show up

 drivers/net/ethernet/intel/i40e/i40e_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index d6147f8..86abd08 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -8438,7 +8438,6 @@ static int i40e_sw_init(struct i40e_pf *pf)
 
 	pf->msg_enable = netif_msg_init(I40E_DEFAULT_MSG_ENABLE,
 				(NETIF_MSG_DRV|NETIF_MSG_PROBE|NETIF_MSG_LINK));
-	pf->hw.debug_mask = pf->msg_enable | I40E_DEBUG_DIAG;
 	if (debug != -1 && debug != I40E_DEFAULT_MSG_ENABLE) {
 		if (I40E_DEBUG_USER & debug)
 			pf->hw.debug_mask = debug;
-- 
2.4.3

