From: Wang Hai <wanghai38@huawei.com>
Date: Thu, 10 Sep 2020 23:09:33 +0800
Subject: [Intel-wired-lan] [PATCH net-next 2/3] i40e: Fix some kernel-doc
 warnings in i40e_common.c
In-Reply-To: <20200910150934.34605-1-wanghai38@huawei.com>
References: <20200910150934.34605-1-wanghai38@huawei.com>
Message-ID: <20200910150934.34605-3-wanghai38@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Fixes the following W=1 kernel build warning(s):

drivers/net/ethernet/intel/i40e/i40e_common.c:3778: warning: Excess function parameter 'buff' description in 'i40e_aq_start_lldp'
drivers/net/ethernet/intel/i40e/i40e_common.c:3778: warning: Excess function parameter 'buff_size' description in 'i40e_aq_start_lldp'

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 drivers/net/ethernet/intel/i40e/i40e_common.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 6ab52cbd697a..361329874d98 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -3766,9 +3766,7 @@ i40e_status i40e_aq_stop_lldp(struct i40e_hw *hw, bool shutdown_agent,
 /**
  * i40e_aq_start_lldp
  * @hw: pointer to the hw struct
- * @buff: buffer for result
  * @persist: True if start of LLDP should be persistent across power cycles
- * @buff_size: buffer size
  * @cmd_details: pointer to command details structure or NULL
  *
  * Start the embedded LLDP Agent on all ports.
-- 
2.17.1

