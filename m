From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Mon, 25 Jul 2016 16:15:53 -0700
Subject: [Intel-wired-lan] [next PATCH S40 11/13] i40e: fix memory leak
In-Reply-To: <1469488555-28187-1-git-send-email-bimmy.pujari@intel.com>
References: <1469488555-28187-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1469488555-28187-12-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

When we allocate memory, we must free it. It's simple courtesy.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: Id007294096fb53344f1a8b9a0f78eddf9853c5d6
---
Testing Hints : Found by inspection. The VF driver
doesn't currently call this function, so not testable.

 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 5ea659c..68e3482 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2318,6 +2318,7 @@ err:
 	/* send the response back to the VF */
 	aq_ret = i40e_vc_send_msg_to_vf(vf, I40E_VIRTCHNL_OP_GET_RSS_HENA_CAPS,
 					aq_ret, (u8 *)vrh, len);
+	kfree(vrh);
 	return aq_ret;
 }
 
-- 
2.4.11

