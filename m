From: kbuild test robot <fengguang.wu@intel.com>
Date: Tue, 19 Dec 2017 04:59:24 +0800
Subject: [Intel-wired-lan] [RFC PATCH jkirsher-next-queue] ixgbe:
 ixgbe_ipsec_clear_hw_tables() can be static
In-Reply-To: <201712190407.gmgPG1WL%fengguang.wu@intel.com>
References: <201712190407.gmgPG1WL%fengguang.wu@intel.com>
Message-ID: <20171218205924.GA83605@lkp-snb01>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


Fixes: 7efd4bc27356 ("ixgbe: add ipsec register access routines")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 ixgbe_ipsec.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
index 4d71517..c726136 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
@@ -129,7 +129,7 @@ static void ixgbe_ipsec_set_rx_ip(struct ixgbe_hw *hw, u16 idx, __be32 addr[])
  * ixgbe_ipsec_clear_hw_tables - because some tables don't get cleared on reset
  * @adapter: board private structure
  **/
-void ixgbe_ipsec_clear_hw_tables(struct ixgbe_adapter *adapter)
+static void ixgbe_ipsec_clear_hw_tables(struct ixgbe_adapter *adapter)
 {
 	struct ixgbe_hw *hw = &adapter->hw;
 	u32 buf[4] = {0, 0, 0, 0};
