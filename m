From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 22 Feb 2022 16:26:57 -0800
Subject: [Intel-wired-lan] [net-next PATCH 10/25] ice: log an error message
 when eswitch fails to configure
In-Reply-To: <20220223002712.2771809-1-jacob.e.keller@intel.com>
References: <20220223002712.2771809-1-jacob.e.keller@intel.com>
Message-ID: <20220223002712.2771809-11-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When ice_eswitch_configure fails, print an error message to make it more
obvious why VF initialization did not succeed.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_sriov.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index b695d479dfb1..d41fce16ddfb 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -2087,8 +2087,10 @@ static int ice_ena_vfs(struct ice_pf *pf, u16 num_vfs)
 	clear_bit(ICE_VF_DIS, pf->state);
 
 	ret = ice_eswitch_configure(pf);
-	if (ret)
+	if (ret) {
+		dev_err(dev, "Failed to configure eswitch, err %d\n", ret);
 		goto err_unroll_sriov;
+	}
 
 	/* rearm global interrupts */
 	if (test_and_clear_bit(ICE_OICR_INTR_DIS, pf->state))
-- 
2.35.1.129.gb80121027d12

