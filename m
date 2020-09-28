From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 28 Sep 2020 09:17:44 +0200
Subject: [Intel-wired-lan] [PATCH] net: ethernet: ixgbe: don't propagate
 -ENODEV from ixgbe_mii_bus_init()
Message-ID: <20200928071744.18253-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

It's a valid use-case for ixgbe_mii_bus_init() to return -ENODEV - we
still want to finalize the registration of the ixgbe device. Check the
error code and don't bail out if err == -ENODEV.

This fixes an issue on C3000 family of SoCs where four ixgbe devices
share a single MDIO bus and ixgbe_mii_bus_init() returns -ENODEV for
three of them but we still want to register them.

Fixes: 09ef193fef7e ("net: ethernet: ixgbe: check the return value of ixgbe_mii_bus_init()")
Reported-by: Yongxin Liu <yongxin.liu@windriver.com>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 2f8a4cfc5fa1..d1623af30125 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -11032,7 +11032,7 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 			true);
 
 	err = ixgbe_mii_bus_init(hw);
-	if (err)
+	if (err && err != -ENODEV)
 		goto err_netdev;
 
 	return 0;
-- 
2.26.1

