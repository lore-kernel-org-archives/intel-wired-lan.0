From: Avinash Dayanand <avinash.dayanand@intel.com>
Date: Fri, 18 Mar 2016 12:18:11 -0700
Subject: [Intel-wired-lan] [next PATCH S31 v4 07/12] i40e: Disable link
	polling
In-Reply-To: <1458328696-135941-1-git-send-email-avinash.dayanand@intel.com>
References: <1458328696-135941-1-git-send-email-avinash.dayanand@intel.com>
Message-ID: <1458328696-135941-8-git-send-email-avinash.dayanand@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Shannon Nelson <shannon.nelson@intel.com>

Periodic link polling was added when the link events were found not to be
trustworthy.  This was the case early on, but was likely because the link
event mask was being used incorrectly.  As this has been fixed in recent
code, we can disable the link polling to lessen the AQ traffic.

Testing Hints:
	Do some link tests, removing and reinserting the wire, etc.

Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
Change-ID: Id890b5ee3c2d04381fc76ffa434777644f5d8eb0
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 33b6c68..18877f0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -8389,7 +8389,6 @@ static int i40e_sw_init(struct i40e_pf *pf)
 	/* Set default capability flags */
 	pf->flags = I40E_FLAG_RX_CSUM_ENABLED |
 		    I40E_FLAG_MSI_ENABLED     |
-		    I40E_FLAG_LINK_POLLING_ENABLED |
 		    I40E_FLAG_MSIX_ENABLED;
 
 	if (iommu_present(&pci_bus_type))
-- 
2.4.3

