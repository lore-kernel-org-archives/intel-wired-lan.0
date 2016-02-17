From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Wed, 17 Feb 2016 15:55:06 -0800
Subject: [Intel-wired-lan] [PATCH] ixgbe: make __ixgbe_setup_tc static
Message-ID: <20160217235506.31327.63137.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This function is only used in ixgbe_main.c
Resolves a "missing prototype" warning when building the driver with W=1

Reported-by: Phil Schmitt <phillip.j.schmitt@intel.com>
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 46b0ac5..e8e0818 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -8355,8 +8355,8 @@ err_out:
 	return -EINVAL;
 }
 
-int __ixgbe_setup_tc(struct net_device *dev, u32 handle, __be16 proto,
-		     struct tc_to_netdev *tc)
+static int __ixgbe_setup_tc(struct net_device *dev, u32 handle, __be16 proto,
+			    struct tc_to_netdev *tc)
 {
 	struct ixgbe_adapter *adapter = netdev_priv(dev);
 

