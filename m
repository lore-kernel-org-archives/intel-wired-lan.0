From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
Date: Tue, 12 Apr 2016 08:30:41 -0700
Subject: [Intel-wired-lan] [next PATCH S33 02/13] i40evf: Don't Panic
In-Reply-To: <1460475052-6348-1-git-send-email-harshitha.ramamurthy@intel.com>
References: <1460475052-6348-1-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <1460475052-6348-3-git-send-email-harshitha.ramamurthy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

Under some circumstances the driver remove function may be called before
the driver is fully initialized. So we can't assume that we know where
our towel is at, or that all of the data structures are initialized.

To ensure that we don't panic, check that the vsi_res pointer is valid
before dereferencing it. Then drink beer and eat peanuts.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: If697b4db57348e39f9538793e16aa755e3e1af03
---
 drivers/net/ethernet/intel/i40evf/i40evf.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf.h b/drivers/net/ethernet/intel/i40evf/i40evf.h
index e657ecc..017c83b 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf.h
+++ b/drivers/net/ethernet/intel/i40evf/i40evf.h
@@ -256,8 +256,10 @@ struct i40evf_adapter {
 	bool netdev_registered;
 	bool link_up;
 	enum i40e_virtchnl_ops current_op;
-#define CLIENT_ENABLED(_a) ((_a)->vf_res->vf_offload_flags & \
-			    I40E_VIRTCHNL_VF_OFFLOAD_IWARP)
+#define CLIENT_ENABLED(_a) ((_a)->vf_res ? \
+			    (_a)->vf_res->vf_offload_flags & \
+				I40E_VIRTCHNL_VF_OFFLOAD_IWARP : \
+			    0)
 #define RSS_AQ(_a) ((_a)->vf_res->vf_offload_flags & \
 		    I40E_VIRTCHNL_VF_OFFLOAD_RSS_AQ)
 #define VLAN_ALLOWED(_a) ((_a)->vf_res->vf_offload_flags & \
-- 
2.4.3

