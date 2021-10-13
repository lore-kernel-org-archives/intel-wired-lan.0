From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 13 Oct 2021 11:00:12 +0300
Subject: [Intel-wired-lan] [PATCH net-next] ice: fix an error code in
 ice_ena_vfs()
Message-ID: <20211013080012.GB6010@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Return the error code if ice_eswitch_configure() fails.  Don't return
success.

Fixes: 1c54c839935b ("ice: enable/disable switchdev when managing VFs")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index 4d0b643906ff..2bd783ec685c 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -1975,7 +1975,8 @@ static int ice_ena_vfs(struct ice_pf *pf, u16 num_vfs)
 
 	clear_bit(ICE_VF_DIS, pf->state);
 
-	if (ice_eswitch_configure(pf))
+	ret = ice_eswitch_configure(pf);
+	if (ret)
 		goto err_unroll_sriov;
 
 	return 0;
-- 
2.20.1

