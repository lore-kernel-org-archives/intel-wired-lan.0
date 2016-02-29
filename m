From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Mon, 29 Feb 2016 11:00:24 -0800
Subject: [Intel-wired-lan] [PATCH net] i40e: fix errant PCIe bandwidth
	message
Message-ID: <1456772424-6146-1-git-send-email-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

There was an error introduced with commit 3fced535079a ("i40e: X722 is
on the IOSF bus and does not report the PCI bus info"), where code was
added but the enabling flag is never set.

Reported-by: Steve Best <sbest@redhat.com>
Fixes: 3fced535079a ("i40e: X722 is on the IOSF bus ...")
CC: Anjali Singhai Jain <anjali.singhai@intel.com>
CC: Stefan Assman <sassman@redhat.com>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 8f3b53e..4461b55 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -8393,6 +8393,7 @@ static int i40e_sw_init(struct i40e_pf *pf)
 			     I40E_FLAG_OUTER_UDP_CSUM_CAPABLE |
 			     I40E_FLAG_WB_ON_ITR_CAPABLE |
 			     I40E_FLAG_MULTIPLE_TCP_UDP_RSS_PCTYPE |
+			     I40E_FLAG_NO_PCI_LINK_CHECK |
 			     I40E_FLAG_GENEVE_OFFLOAD_CAPABLE;
 	}
 	pf->eeprom_version = 0xDEAD;
-- 
1.8.3.1

