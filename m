From: Jia-Ju Bai <baijiaju1990@163.com>
Date: Wed,  5 Aug 2015 22:05:16 +0800
Subject: [Intel-wired-lan] [PATCH] igb: Fix a memory leak in igb_probe
Message-ID: <1438783516-13283-1-git-send-email-baijiaju1990@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In error handling code of igb_probe, the memory adapter->shadow_vfta 
allocated by kcalloc in igb_sw_init is not freed. So when register_netdev 
or igb_init_i2c is failed, a memory leak will occur.
This patch adds kfree to fix it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@163.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 2f70a9b..3efb757 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2645,6 +2645,7 @@ err_eeprom:
 	if (hw->flash_address)
 		iounmap(hw->flash_address);
 err_sw_init:
+	kfree(adapter->shadow_vfta);
 	igb_clear_interrupt_scheme(adapter);
 	pci_iounmap(pdev, hw->hw_addr);
 err_ioremap:
-- 
1.7.9.5


