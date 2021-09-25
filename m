From: Leon Romanovsky <leon@kernel.org>
Date: Sat, 25 Sep 2021 14:22:54 +0300
Subject: [Intel-wired-lan] [PATCH net-next v1 14/21] ionic: Move devlink
 registration to be last devlink command
In-Reply-To: <cover.1632565508.git.leonro@nvidia.com>
References: <cover.1632565508.git.leonro@nvidia.com>
Message-ID: <cb187a035b75dbcc27f6dd10d72f18f1101bad44.1632565508.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Leon Romanovsky <leonro@nvidia.com>

This change prevents from users to access device before devlink is
fully configured.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_devlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_devlink.c b/drivers/net/ethernet/pensando/ionic/ionic_devlink.c
index 93282394d332..2267da95640b 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_devlink.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_devlink.c
@@ -82,7 +82,6 @@ int ionic_devlink_register(struct ionic *ionic)
 	struct devlink_port_attrs attrs = {};
 	int err;
 
-	devlink_register(dl);
 	attrs.flavour = DEVLINK_PORT_FLAVOUR_PHYSICAL;
 	devlink_port_attrs_set(&ionic->dl_port, &attrs);
 	err = devlink_port_register(dl, &ionic->dl_port, 0);
@@ -93,6 +92,7 @@ int ionic_devlink_register(struct ionic *ionic)
 	}
 
 	devlink_port_type_eth_set(&ionic->dl_port, ionic->lif->netdev);
+	devlink_register(dl);
 	return 0;
 }
 
@@ -100,6 +100,6 @@ void ionic_devlink_unregister(struct ionic *ionic)
 {
 	struct devlink *dl = priv_to_devlink(ionic);
 
-	devlink_port_unregister(&ionic->dl_port);
 	devlink_unregister(dl);
+	devlink_port_unregister(&ionic->dl_port);
 }
-- 
2.31.1

