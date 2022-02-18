From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 18 Feb 2022 12:15:38 -0800
Subject: [Intel-wired-lan] [PATCH] fixup! ice: convert VF storage to hash
 table with krefs and RCU
Message-ID: <20220218201538.818568-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add a missing ice_put_vf in ice_vf_lan_overflow_event, since otherwise
we'll leak the VF structure here.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Noticed another missing ice_put_vf() in ice_vf_lan_overflow_event. Tony, can
you squash this into the mentioned commit?

 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index 537cdc7a1653..0541db39964e 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -2340,6 +2340,7 @@ ice_vf_lan_overflow_event(struct ice_pf *pf, struct ice_rq_event_info *event)
 		return;
 
 	ice_vc_reset_vf(vf);
+	ice_put_vf(vf);
 }
 
 /**

base-commit: 477606a501d0705cb1bb86fe7aa86f553861ae7f
prerequisite-patch-id: 52d10a04856713e454419d1fab93a8eb8fc8b46b
prerequisite-patch-id: 5e147a8595d06a154c4d4bd96a00123b9d7aeff3
prerequisite-patch-id: 219a2374784bc332860587188fff3b52875bf75b
prerequisite-patch-id: 9c0a3c2a0f103f375d154874cb2f6c05460fce4f
prerequisite-patch-id: 0d93364319183aa07095f318faa1ab04818a0122
prerequisite-patch-id: f6646bb747160540b8aad64bc8bf6eec2f8a0751
prerequisite-patch-id: 30b94ac0dc91fa628dac13700d71b1dbcb466207
prerequisite-patch-id: 7d2e698ae3bc185dfb1d622219774cb3eaf2747b
prerequisite-patch-id: c323612611a89bb6c6fd39c16c2cbec947eac0be
prerequisite-patch-id: 9c0e97be6504c4ebb3ad317cf7a58983369f852d
prerequisite-patch-id: 9d8a69cab472a9920a226840cf9ba0e664b2d48a
-- 
2.35.1.129.gb80121027d12

