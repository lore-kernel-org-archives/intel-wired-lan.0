From: wangyunjian <wangyunjian@huawei.com>
Date: Wed, 27 Jan 2021 19:50:44 +0800
Subject: [Intel-wired-lan] [PATCH net-next] ice: remove redundant null check
 on pf
Message-ID: <1611748244-20592-1-git-send-email-wangyunjian@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Yunjian Wang <wangyunjian@huawei.com>

Before calling ice_set_dflt_mib(), the 'pf' has been dereferenced.
So the additional check is unnecessary, just remove it.

Addresses-Coverity: ("Dereference before null check")
Fixes: 7d9c9b791f9e ("ice: Implement LFC workaround")
Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 6e251dfffc91..43117cb4ef18 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -788,11 +788,6 @@ static void ice_set_dflt_mib(struct ice_pf *pf)
 	struct ice_hw *hw;
 	u32 ouisubtype;
 
-	if (!pf) {
-		dev_dbg(dev, "%s NULL pf pointer\n", __func__);
-		return;
-	}
-
 	hw = &pf->hw;
 	mib_type = SET_LOCAL_MIB_TYPE_LOCAL_MIB;
 	lldpmib = kzalloc(ICE_LLDPDU_SIZE, GFP_KERNEL);
-- 
2.23.0

