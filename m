From: Leon Romanovsky <leon@kernel.org>
Date: Sat, 25 Sep 2021 14:22:52 +0300
Subject: [Intel-wired-lan] [PATCH net-next v1 12/21] net: mscc: ocelot:
 delay devlink registration to the end
In-Reply-To: <cover.1632565508.git.leonro@nvidia.com>
References: <cover.1632565508.git.leonro@nvidia.com>
Message-ID: <6c20043398a8543fb69795be5ab1e200613fb881.1632565508.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Leon Romanovsky <leonro@nvidia.com>

Open access to the devlink interface when the driver fully initialized.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/net/ethernet/mscc/ocelot_vsc7514.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot_vsc7514.c b/drivers/net/ethernet/mscc/ocelot_vsc7514.c
index 2b8ea48d2fc4..5d01993f6be0 100644
--- a/drivers/net/ethernet/mscc/ocelot_vsc7514.c
+++ b/drivers/net/ethernet/mscc/ocelot_vsc7514.c
@@ -1134,7 +1134,6 @@ static int mscc_ocelot_probe(struct platform_device *pdev)
 	if (err)
 		goto out_put_ports;
 
-	devlink_register(devlink);
 	err = mscc_ocelot_init_ports(pdev, ports);
 	if (err)
 		goto out_ocelot_devlink_unregister;
@@ -1157,6 +1156,7 @@ static int mscc_ocelot_probe(struct platform_device *pdev)
 	register_switchdev_blocking_notifier(&ocelot_switchdev_blocking_nb);
 
 	of_node_put(ports);
+	devlink_register(devlink);
 
 	dev_info(&pdev->dev, "Ocelot switch probed\n");
 
@@ -1166,7 +1166,6 @@ static int mscc_ocelot_probe(struct platform_device *pdev)
 	mscc_ocelot_release_ports(ocelot);
 	mscc_ocelot_teardown_devlink_ports(ocelot);
 out_ocelot_devlink_unregister:
-	devlink_unregister(devlink);
 	ocelot_deinit(ocelot);
 out_put_ports:
 	of_node_put(ports);
@@ -1179,11 +1178,11 @@ static int mscc_ocelot_remove(struct platform_device *pdev)
 {
 	struct ocelot *ocelot = platform_get_drvdata(pdev);
 
+	devlink_unregister(ocelot->devlink);
 	ocelot_deinit_timestamp(ocelot);
 	ocelot_devlink_sb_unregister(ocelot);
 	mscc_ocelot_release_ports(ocelot);
 	mscc_ocelot_teardown_devlink_ports(ocelot);
-	devlink_unregister(ocelot->devlink);
 	ocelot_deinit(ocelot);
 	unregister_switchdev_blocking_notifier(&ocelot_switchdev_blocking_nb);
 	unregister_switchdev_notifier(&ocelot_switchdev_nb);
-- 
2.31.1

