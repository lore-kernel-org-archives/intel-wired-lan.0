From: Tushar Dave <tushar.n.dave@oracle.com>
Date: Fri, 19 May 2017 18:01:52 -0700
Subject: [Intel-wired-lan] [PATCH] i40e: Fix incorrect pf->flags
Message-ID: <1495242112-14835-1-git-send-email-tushar.n.dave@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Fix bug introduced by 'commit 47994c119a36e ("i40e: remove
hw_disabled_flags in favor of using separate flag bits")' that
mistakenly wipes out pf->flags.

Signed-off-by: Tushar Dave <tushar.n.dave@oracle.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index d5c9c9e..6b98d34 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -8821,9 +8821,9 @@ static int i40e_sw_init(struct i40e_pf *pf)
 		    (pf->hw.aq.api_min_ver > 4))) {
 		/* Supported in FW API version higher than 1.4 */
 		pf->flags |= I40E_FLAG_GENEVE_OFFLOAD_CAPABLE;
-		pf->flags = I40E_FLAG_HW_ATR_EVICT_CAPABLE;
+		pf->flags |= I40E_FLAG_HW_ATR_EVICT_CAPABLE;
 	} else {
-		pf->flags = I40E_FLAG_HW_ATR_EVICT_CAPABLE;
+		pf->flags |= I40E_FLAG_HW_ATR_EVICT_CAPABLE;
 	}
 
 	pf->eeprom_version = 0xDEAD;
-- 
1.9.1

