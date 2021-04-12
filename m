From: wangyunjian <wangyunjian@huawei.com>
Date: Mon, 12 Apr 2021 22:41:18 +0800
Subject: [Intel-wired-lan] [PATCH net] i40e: Fix use-after-free in
 i40e_client_subtask()
Message-ID: <1618238478-18068-1-git-send-email-wangyunjian@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Yunjian Wang <wangyunjian@huawei.com>

Currently the call to i40e_client_del_instance frees the object
pf->cinst, however pf->cinst->lan_info is being accessed after
the free. Fix this by adding the missing return.

Addresses-Coverity: ("Read from pointer after free")
Fixes: 7b0b1a6d0ac9 ("i40e: Disable iWARP VSI PETCP_ENA flag on netdev down events")
Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
---
 drivers/net/ethernet/intel/i40e/i40e_client.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.c b/drivers/net/ethernet/intel/i40e/i40e_client.c
index a2dba32383f6..32f3facbed1a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_client.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
@@ -375,6 +375,7 @@ void i40e_client_subtask(struct i40e_pf *pf)
 				clear_bit(__I40E_CLIENT_INSTANCE_OPENED,
 					  &cdev->state);
 				i40e_client_del_instance(pf);
+				return;
 			}
 		}
 	}
-- 
2.23.0

