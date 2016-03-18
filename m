From: kbuild test robot <fengguang.wu@intel.com>
Date: Fri, 18 Mar 2016 23:44:01 +0800
Subject: [Intel-wired-lan] [RFC PATCH linux-next] net: __ixgbe_setup_tc()
	can be static
In-Reply-To: <201603182332.ZrvaiiNr%fengguang.wu@intel.com>
References: <201603182332.ZrvaiiNr%fengguang.wu@intel.com>
Message-ID: <20160318154401.GA62161@cairo>
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
index 1ba714e..3339249 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -8200,7 +8200,7 @@ int ixgbe_setup_tc(struct net_device *dev, u8 tc)
 	return 0;
 }
 
-int __ixgbe_setup_tc(struct net_device *dev, u32 handle, u8 tc)
+static int __ixgbe_setup_tc(struct net_device *dev, u32 handle, u8 tc)
 {
 	/* Only support egress tc setup for now */
 	if (handle != TC_H_ROOT)
