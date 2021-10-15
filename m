From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Date: Fri, 15 Oct 2021 18:04:09 +0800
Subject: [Intel-wired-lan] [PATCH] ice: Fix missing error code in
 ice_ena_vfs()
Message-ID: <1634292249-63098-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The error code is missing in this code scenario, add the error code
'-EINVAL' to the return value 'ret'.

Eliminate the follow smatch warning:

drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c:1979 ice_ena_vfs()
warn: missing error code 'ret'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Fixes: 1c54c839935b ("ice: enable/disable switchdev when managing VFs")
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index 4d0b643..b2a018c 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -1975,8 +1975,10 @@ static int ice_ena_vfs(struct ice_pf *pf, u16 num_vfs)
 
 	clear_bit(ICE_VF_DIS, pf->state);
 
-	if (ice_eswitch_configure(pf))
+	if (ice_eswitch_configure(pf)) {
+		ret = -EINVAL;
 		goto err_unroll_sriov;
+	}
 
 	return 0;
 
-- 
1.8.3.1

