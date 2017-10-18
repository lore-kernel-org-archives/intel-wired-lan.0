From: Gustavo A. R. Silva <garsilva@embeddedor.com>
Date: Wed, 18 Oct 2017 15:34:25 -0500
Subject: [Intel-wired-lan] [PATCH] i40e/virtchnl: fix application of sizeof
	to pointer
Message-ID: <20171018203425.GA983@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

sizeof when applied to a pointer typed expression gives the size of
the pointer.

The proper fix in this particular case is to code sizeof(*vfres)
instead of sizeof(vfres).

This issue was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
This code was tested by compilation only.

 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index f8a794b..56dd1e8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2086,7 +2086,7 @@ static int i40e_vc_request_queues_msg(struct i40e_vf *vf, u8 *msg, int msglen)
 	}
 
 	return i40e_vc_send_msg_to_vf(vf, VIRTCHNL_OP_REQUEST_QUEUES, 0,
-				      (u8 *)vfres, sizeof(vfres));
+				      (u8 *)vfres, sizeof(*vfres));
 }
 
 /**
-- 
2.7.4

