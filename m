From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Mon, 12 Sep 2016 14:18:37 -0700
Subject: [Intel-wired-lan] [next PATCH S46 1/8] i40e: Increase minimum
	number of allocated VSI
In-Reply-To: <1473715124-31296-1-git-send-email-bimmy.pujari@intel.com>
References: <1473715124-31296-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1473715124-31296-2-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Akeem Abodunrin <akeem.g.abodunrin@intel.com>

This patch increases minimum number of allocated VSIs, so as to resolve
failure adding VSI for VF when 64-VFs assigned to a PF. The driver
supports up to 128 VFs per device, users can decide to enable up to
64-VFs on a single PF, especially 2 X 40 devices. In that scenario, with
VMDq co-existence, there would be starvation of VSIs - with this patch,
supported features would have enough VSIs for configuration now.

Signed-off-by: Akeem Abodunrin <akeem.g.abodunrin@intel.com>
Change-ID: If084f4cd823667af8fe7fdc11489c705b32039d5
---
HSD-number: 7660915

 drivers/net/ethernet/intel/i40e/i40e.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 22657ea..ca2d317 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -77,7 +77,7 @@
 #define I40E_MIN_NUM_DESCRIPTORS	64
 #define I40E_MIN_MSIX			2
 #define I40E_DEFAULT_NUM_VMDQ_VSI	8 /* max 256 VSIs */
-#define I40E_MIN_VSI_ALLOC		51 /* LAN, ATR, FCOE, 32 VF, 16 VMDQ */
+#define I40E_MIN_VSI_ALLOC            83 /* LAN, ATR, FCOE, 64 VF */
 /* max 16 qps */
 #define i40e_default_queues_per_vmdq(pf) \
 		(((pf)->flags & I40E_FLAG_RSS_AQ_CAPABLE) ? 4 : 1)
-- 
2.4.11

