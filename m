From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Tue,  6 Sep 2016 12:40:00 -0700
Subject: [Intel-wired-lan] [next PATCH S45 03/10] i40evf: remove unnecessary
	error checking against i40e_shutdown_adminq
In-Reply-To: <1473190807-26377-1-git-send-email-bimmy.pujari@intel.com>
References: <1473190807-26377-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1473190807-26377-4-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Lihong Yang <lihong.yang@intel.com>

i40e_shutdown_adminq function never returns failure, thus
remove its error checking to avoid KW hit.

Signed-off-by: Lihong Yang <lihong.yang@intel.com>
Change-ID: Ibb616f09cfb93bd1a872ebf3241a15fb8354b31b
---
Testing Hints:
Found by static code analysis. Check by code inspection.

 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 2074a8f..f2111d2 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -1782,8 +1782,7 @@ continue_reset:
 	i40evf_free_all_tx_resources(adapter);
 
 	/* kill and reinit the admin queue */
-	if (i40evf_shutdown_adminq(hw))
-		dev_warn(&adapter->pdev->dev, "Failed to shut down adminq\n");
+	i40evf_shutdown_adminq(hw);
 	adapter->current_op = I40E_VIRTCHNL_OP_UNKNOWN;
 	err = i40evf_init_adminq(hw);
 	if (err)
-- 
2.4.11

