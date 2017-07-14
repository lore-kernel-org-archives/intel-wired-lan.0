From: Alice Michael <alice.michael@intel.com>
Date: Fri, 14 Jul 2017 09:27:01 -0400
Subject: [Intel-wired-lan] [next PATCH S77-V3 02/10] i40evf: lower message
	level
In-Reply-To: <20170714132709.52657-1-alice.michael@intel.com>
References: <20170714132709.52657-1-alice.michael@intel.com>
Message-ID: <20170714132709.52657-2-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

We see this message regularly on VF reset or unload (which invokes a
reset). It's essentially meaningless unless it's happening constantly.
To prevent consternation, lower the log level to debug so it's not seen
under normal circumstance.

Testing Hints (required if no HSD): Load and unload VF driver, observe
dmesg in VM.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
index 6c403bf..d22813e 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
@@ -52,7 +52,7 @@ static int i40evf_send_pf_msg(struct i40evf_adapter *adapter,
 
 	err = i40e_aq_send_msg_to_pf(hw, op, 0, msg, len, NULL);
 	if (err)
-		dev_err(&adapter->pdev->dev, "Unable to send opcode %d to PF, err %s, aq_err %s\n",
+		dev_dbg(&adapter->pdev->dev, "Unable to send opcode %d to PF, err %s, aq_err %s\n",
 			op, i40evf_stat_str(hw, err),
 			i40evf_aq_str(hw, hw->aq.asq_last_status));
 	return err;
-- 
2.9.3

