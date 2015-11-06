From: Joshua Hay <joshua.a.hay@intel.com>
Date: Fri,  6 Nov 2015 15:26:06 -0800
Subject: [Intel-wired-lan] [next PATCH S21 08/14] i40evf: use correct types
In-Reply-To: <1446852372-25480-1-git-send-email-joshua.a.hay@intel.com>
References: <1446852372-25480-1-git-send-email-joshua.a.hay@intel.com>
Message-ID: <1446852372-25480-9-git-send-email-joshua.a.hay@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

Don't use uint32_t type the kernel. Use u32 instead. No functional
change.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: I77bbf3b6464edaef747c7104b43534032a4dba63
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 9f845fe..fb170b3 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -259,7 +259,7 @@ static void i40evf_fire_sw_int(struct i40evf_adapter *adapter, u32 mask)
 {
 	struct i40e_hw *hw = &adapter->hw;
 	int i;
-	uint32_t dyn_ctl;
+	u32 dyn_ctl;
 
 	if (mask & 1) {
 		dyn_ctl = rd32(hw, I40E_VFINT_DYN_CTL01);
-- 
2.1.0

