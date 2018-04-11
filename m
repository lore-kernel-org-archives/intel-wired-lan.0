From: Jia-Ju Bai <baijiaju1990@gmail.com>
Date: Wed, 11 Apr 2018 10:08:18 +0800
Subject: [Intel-wired-lan] [PATCH] intel: i40evf: Replace GFP_ATOMIC with
 GFP_KERNEL in i40evf_add_vlan
Message-ID: <1523412498-2177-1-git-send-email-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

i40evf_add_vlan() is never called in atomic context.

i40evf_add_vlan() is only called by i40evf_vlan_rx_add_vid(), 
which is only set as ".ndo_vlan_rx_add_vid" in struct net_device_ops.
".ndo_vlan_rx_add_vid" is not called in atomic context.

Despite never getting called from atomic context, 
i40evf_add_vlan() calls kzalloc() with GFP_ATOMIC, 
which does not sleep for allocation.
GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL, 
which can sleep and improve the possibility of sucessful allocation.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 1825d95..04b2b9c 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -770,7 +770,7 @@ i40evf_vlan_filter *i40evf_add_vlan(struct i40evf_adapter *adapter, u16 vlan)
 
 	f = i40evf_find_vlan(adapter, vlan);
 	if (!f) {
-		f = kzalloc(sizeof(*f), GFP_ATOMIC);
+		f = kzalloc(sizeof(*f), GFP_KERNEL);
 		if (!f)
 			goto clearout;
 
-- 
1.9.1

