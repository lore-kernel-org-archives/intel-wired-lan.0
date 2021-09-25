From: Leon Romanovsky <leon@kernel.org>
Date: Sat, 25 Sep 2021 14:22:43 +0300
Subject: [Intel-wired-lan] [PATCH net-next v1 03/21] liquidio: Overcome
 missing device lock protection in init/remove flows
In-Reply-To: <cover.1632565508.git.leonro@nvidia.com>
References: <cover.1632565508.git.leonro@nvidia.com>
Message-ID: <4e78bd8c6f45eef8093547a37c4d00ef0d1fef56.1632565508.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Leon Romanovsky <leonro@nvidia.com>

The liquidio driver is broken by design. It initialize PCI devices
in separate delayed works. It causes to the situation where device lock
is dropped during initialize and remove sequences.

That lock is part of driver/core and needed to protect from races during
init, destroy and bus invocations.

In addition to lack of locking protection, it has incorrect order of
destroy flows and very questionable synchronization scheme based on
atomic_t.

This change doesn't fix that driver but makes sure that rest of the
netdev subsystem doesn't suffer from such basic protection by adding
device_lock over devlink_*() APIs and by moving devlink_register()
to be last command in setup_nic_devices().

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 .../net/ethernet/cavium/liquidio/lio_main.c   | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
index a34b3bb2dd4f..dafc79bd34f4 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
@@ -1279,6 +1279,14 @@ static int liquidio_stop_nic_module(struct octeon_device *oct)
 	struct lio *lio;
 
 	dev_dbg(&oct->pci_dev->dev, "Stopping network interfaces\n");
+	device_lock(&oct->pci_dev->dev);
+	if (oct->devlink) {
+		devlink_unregister(oct->devlink);
+		devlink_free(oct->devlink);
+		oct->devlink = NULL;
+	}
+	device_unlock(&oct->pci_dev->dev);
+
 	if (!oct->ifcount) {
 		dev_err(&oct->pci_dev->dev, "Init for Octeon was not completed\n");
 		return 1;
@@ -1300,12 +1308,6 @@ static int liquidio_stop_nic_module(struct octeon_device *oct)
 	for (i = 0; i < oct->ifcount; i++)
 		liquidio_destroy_nic_device(oct, i);
 
-	if (oct->devlink) {
-		devlink_unregister(oct->devlink);
-		devlink_free(oct->devlink);
-		oct->devlink = NULL;
-	}
-
 	dev_dbg(&oct->pci_dev->dev, "Network interfaces stopped\n");
 	return 0;
 }
@@ -3749,10 +3751,12 @@ static int setup_nic_devices(struct octeon_device *octeon_dev)
 		}
 	}
 
+	device_lock(&octeon_dev->pci_dev->dev);
 	devlink = devlink_alloc(&liquidio_devlink_ops,
 				sizeof(struct lio_devlink_priv),
 				&octeon_dev->pci_dev->dev);
 	if (!devlink) {
+		device_unlock(&octeon_dev->pci_dev->dev);
 		dev_err(&octeon_dev->pci_dev->dev, "devlink alloc failed\n");
 		goto setup_nic_dev_free;
 	}
@@ -3760,9 +3764,10 @@ static int setup_nic_devices(struct octeon_device *octeon_dev)
 	lio_devlink = devlink_priv(devlink);
 	lio_devlink->oct = octeon_dev;
 
-	devlink_register(devlink);
 	octeon_dev->devlink = devlink;
 	octeon_dev->eswitch_mode = DEVLINK_ESWITCH_MODE_LEGACY;
+	devlink_register(devlink);
+	device_unlock(&octeon_dev->pci_dev->dev);
 
 	return 0;
 
-- 
2.31.1

