From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Mon, 12 Oct 2020 15:53:26 -0700
Subject: [Intel-wired-lan] [PATCH] ice: remove dead code
Message-ID: <20201012225326.15722-1-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bruce Allan <bruce.w.allan@intel.com>

The check for a NULL pf pointer is moot since the earlier declaration and
assignment of struct device *dev already de-referenced the pointer.  Also,
the only caller of ice_set_dflt_mib() already ensures pf is not NULL.

Cc: Dave Ertman <david.m.ertman@intel.com>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 0e62142416b2..99c8555dd6a9 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -785,15 +785,9 @@ static void ice_set_dflt_mib(struct ice_pf *pf)
 	u8 mib_type, *buf, *lldpmib = NULL;
 	u16 len, typelen, offset = 0;
 	struct ice_lldp_org_tlv *tlv;
-	struct ice_hw *hw;
+	struct ice_hw *hw = &pf->hw;
 	u32 ouisubtype;
 
-	if (!pf) {
-		dev_dbg(dev, "%s NULL pf pointer\n", __func__);
-		return;
-	}
-
-	hw = &pf->hw;
 	mib_type = SET_LOCAL_MIB_TYPE_LOCAL_MIB;
 	lldpmib = kzalloc(ICE_LLDPDU_SIZE, GFP_KERNEL);
 	if (!lldpmib) {
-- 
2.20.1

