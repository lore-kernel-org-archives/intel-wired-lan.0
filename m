From: Wang Hai <wanghai38@huawei.com>
Date: Thu, 10 Sep 2020 23:09:32 +0800
Subject: [Intel-wired-lan] [PATCH net-next 1/3] i40e: Fix some kernel-doc
 warnings in i40e_client.c
In-Reply-To: <20200910150934.34605-1-wanghai38@huawei.com>
References: <20200910150934.34605-1-wanghai38@huawei.com>
Message-ID: <20200910150934.34605-2-wanghai38@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Fixes the following W=1 kernel build warning(s):

drivers/net/ethernet/intel/i40e/i40e_client.c:286: warning: Excess function parameter 'client' description in 'i40e_client_add_instance'
drivers/net/ethernet/intel/i40e/i40e_client.c:286: warning: Excess function parameter 'existing' description in 'i40e_client_add_instance'

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 drivers/net/ethernet/intel/i40e/i40e_client.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.c b/drivers/net/ethernet/intel/i40e/i40e_client.c
index befd3018183f..a2dba32383f6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_client.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
@@ -278,8 +278,6 @@ void i40e_client_update_msix_info(struct i40e_pf *pf)
 /**
  * i40e_client_add_instance - add a client instance struct to the instance list
  * @pf: pointer to the board struct
- * @client: pointer to a client struct in the client list.
- * @existing: if there was already an existing instance
  *
  **/
 static void i40e_client_add_instance(struct i40e_pf *pf)
-- 
2.17.1

