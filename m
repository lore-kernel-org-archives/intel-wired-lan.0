From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed,  9 Oct 2019 07:09:53 -0700
Subject: [Intel-wired-lan] [PATCH S31 15/15] ice: Fix return value when
 SR-IOV is not supported
In-Reply-To: <20191009140953.14087-1-anthony.l.nguyen@intel.com>
References: <20191009140953.14087-1-anthony.l.nguyen@intel.com>
Message-ID: <20191009140953.14087-15-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>

When the device is not capable of supporting SR-IOV -ENODEV is being
returned; -EOPNOTSUPP is more appropriate.

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index 965bbd68caa1..5fc59e8003da 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -1383,7 +1383,7 @@ static int ice_pci_sriov_ena(struct ice_pf *pf, int num_vfs)
 
 	if (!test_bit(ICE_FLAG_SRIOV_CAPABLE, pf->flags)) {
 		dev_err(dev, "This device is not capable of SR-IOV\n");
-		return -ENODEV;
+		return -EOPNOTSUPP;
 	}
 
 	if (pre_existing_vfs && pre_existing_vfs != num_vfs)
-- 
2.20.1

