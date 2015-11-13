From: Deepthi Kavalur <deepthi.kavalur@intel.com>
Date: Fri, 13 Nov 2015 15:47:07 -0800
Subject: [Intel-wired-lan] [next PATCH S22 07/14] i40e: use explicit cast
	from u16 to u8
In-Reply-To: <1447458434-4555-1-git-send-email-deepthi.kavalur@intel.com>
References: <1447458434-4555-1-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <1447458434-4555-8-git-send-email-deepthi.kavalur@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Kamil Krawczyk <kamil.krawczyk@intel.com>

Current implementation generates compilation warnings.

Signed-off-by: Kamil Krawczyk <kamil.krawczyk@intel.com>
Acked-by: Shannon Nelson <shannon.nelson@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Change-ID: Icceefb50fe62aefaf90a64afb7192e08355a4ec5
---
 drivers/net/ethernet/intel/i40e/i40e_lan_hmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_lan_hmc.c b/drivers/net/ethernet/intel/i40e/i40e_lan_hmc.c
index 79ae7be..daa9204 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_lan_hmc.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_lan_hmc.c
@@ -762,7 +762,7 @@ static void i40e_write_byte(u8 *hmc_bits,
 
 	/* prepare the bits and mask */
 	shift_width = ce_info->lsb % 8;
-	mask = BIT(ce_info->width) - 1;
+	mask = (u8)(BIT(ce_info->width) - 1);
 
 	src_byte = *from;
 	src_byte &= mask;
-- 
2.1.0

