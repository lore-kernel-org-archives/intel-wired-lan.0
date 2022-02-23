From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 22 Feb 2022 16:27:02 -0800
Subject: [Intel-wired-lan] [net-next PATCH 15/25] ice: fix a long line
 warning in ice_reset_vf
In-Reply-To: <20220223002712.2771809-1-jacob.e.keller@intel.com>
References: <20220223002712.2771809-1-jacob.e.keller@intel.com>
Message-ID: <20220223002712.2771809-16-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

We're about to move ice_reset_vf out of ice_sriov.c and into
ice_vf_lib.c

One of the dev_err statements has a checkpatch.pl violation due to
putting the vf->vf_id on the same line as the dev_err. Fix this style
issue first before moving the code.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_sriov.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index be6ec42f97c1..b2376e3b746e 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -1251,7 +1251,8 @@ bool ice_reset_vf(struct ice_vf *vf, bool is_vflr)
 	ice_vf_pre_vsi_rebuild(vf);
 
 	if (vf->vf_ops->vsi_rebuild(vf)) {
-		dev_err(dev, "Failed to release and setup the VF%u's VSI\n", vf->vf_id);
+		dev_err(dev, "Failed to release and setup the VF%u's VSI\n",
+			vf->vf_id);
 		return false;
 	}
 
-- 
2.35.1.129.gb80121027d12

