From: kbuild test robot <fengguang.wu@intel.com>
Date: Fri, 12 Jun 2015 11:35:58 +0800
Subject: [Intel-wired-lan] [PATCH jkirsher-next-queue] ixgbe:
 ixgbe_clear_vxlan_port() can be static
In-Reply-To: <201506121128.L8wLrPre%fengguang.wu@intel.com>
References: <201506121128.L8wLrPre%fengguang.wu@intel.com>
Message-ID: <20150612033558.GA121477@lkp-sb04>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 ixgbe_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index f0dd837..4207ded 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -4276,7 +4276,7 @@ static void ixgbe_napi_disable_all(struct ixgbe_adapter *adapter)
 	}
 }
 
-void ixgbe_clear_vxlan_port(struct ixgbe_adapter *adapter)
+static void ixgbe_clear_vxlan_port(struct ixgbe_adapter *adapter)
 {
 	switch (adapter->hw.mac.type) {
 	case ixgbe_mac_X550:
