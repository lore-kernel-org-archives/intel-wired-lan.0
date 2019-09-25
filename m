From: Navid Emamdoost <navid.emamdoost@gmail.com>
Date: Wed, 25 Sep 2019 10:48:30 -0500
Subject: [Intel-wired-lan] [PATCH] i40e: prevent memory leak in
 i40e_setup_macvlans
Message-ID: <20190925154831.19044-1-navid.emamdoost@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In i40e_setup_macvlans if i40e_setup_channel fails the allocated memory
for ch should be released.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 6031223eafab..7d4a14c3fe58 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -7168,6 +7168,7 @@ static int i40e_setup_macvlans(struct i40e_vsi *vsi, u16 macvlan_cnt, u16 qcnt,
 		ch->num_queue_pairs = qcnt;
 		if (!i40e_setup_channel(pf, vsi, ch)) {
 			ret = -EINVAL;
+			kfree(ch);
 			goto err_free;
 		}
 		ch->parent_vsi = vsi;
-- 
2.17.1

