From: Alice Michael <alice.michael@intel.com>
Date: Tue, 14 May 2019 10:37:02 -0700
Subject: [Intel-wired-lan] [next PATCH S5 iavf 04/11] iavf: Change
 GFP_KERNEL to GFP_ATOMIC in kzalloc()
In-Reply-To: <20190514173709.62431-1-alice.michael@intel.com>
References: <20190514173709.62431-1-alice.michael@intel.com>
Message-ID: <20190514173709.62431-4-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

iavf_add_vlan() is being called in atomic context
so kzalloc() needs GFP_ATOMIC. This patch fixes it.

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 9ce04a8c0d0f..8a37b9f604e2 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -659,7 +659,7 @@ iavf_vlan_filter *iavf_add_vlan(struct iavf_adapter *adapter, u16 vlan)
 
 	f = iavf_find_vlan(adapter, vlan);
 	if (!f) {
-		f = kzalloc(sizeof(*f), GFP_KERNEL);
+		f = kzalloc(sizeof(*f), GFP_ATOMIC);
 		if (!f)
 			goto clearout;
 
-- 
2.19.2

