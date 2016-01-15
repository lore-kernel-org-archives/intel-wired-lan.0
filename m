From: Joshua Hay <joshua.a.hay@intel.com>
Date: Fri, 15 Jan 2016 14:33:08 -0800
Subject: [Intel-wired-lan] [next PATCH S28 01/15] i40e: get rid of magic
	number
In-Reply-To: <1452897202-15204-1-git-send-email-joshua.a.hay@intel.com>
References: <1452897202-15204-1-git-send-email-joshua.a.hay@intel.com>
Message-ID: <1452897202-15204-2-git-send-email-joshua.a.hay@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

We have a define for this, use it. No functional change.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: Ic0e3ea4f562e46de63b2a8de07f291ccc10205fd
---
Testing Hints: No functional change. Just make sure
it compiles.

 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 3e0d87e..597f209 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -461,7 +461,7 @@ static int i40e_config_vsi_rx_queue(struct i40e_vf *vf, u16 vsi_id,
 		rx_ctx.hbuff = info->hdr_size >> I40E_RXQ_CTX_HBUFF_SHIFT;
 
 		/* set splitalways mode 10b */
-		rx_ctx.dtype = 0x2;
+		rx_ctx.dtype = I40E_RX_DTYPE_HEADER_SPLIT;
 	}
 
 	/* databuffer length validation */
-- 
2.1.0

