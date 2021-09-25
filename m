From: Leon Romanovsky <leon@kernel.org>
Date: Sat, 25 Sep 2021 14:23:01 +0300
Subject: [Intel-wired-lan] [PATCH net-next v1 21/21] net: dsa: Move devlink
 registration to be last devlink command
In-Reply-To: <cover.1632565508.git.leonro@nvidia.com>
References: <cover.1632565508.git.leonro@nvidia.com>
Message-ID: <66dd7979b44ac307711c382054f428f9287666a8.1632565508.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Leon Romanovsky <leonro@nvidia.com>

This change prevents from users to access device before devlink
is fully configured.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 net/dsa/dsa2.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/dsa/dsa2.c b/net/dsa/dsa2.c
index a020339e1973..8ca6a1170c9d 100644
--- a/net/dsa/dsa2.c
+++ b/net/dsa/dsa2.c
@@ -848,7 +848,6 @@ static int dsa_switch_setup(struct dsa_switch *ds)
 	dl_priv = devlink_priv(ds->devlink);
 	dl_priv->ds = ds;
 
-	devlink_register(ds->devlink);
 	/* Setup devlink port instances now, so that the switch
 	 * setup() can register regions etc, against the ports
 	 */
@@ -874,8 +873,6 @@ static int dsa_switch_setup(struct dsa_switch *ds)
 	if (err)
 		goto teardown;
 
-	devlink_params_publish(ds->devlink);
-
 	if (!ds->slave_mii_bus && ds->ops->phy_read) {
 		ds->slave_mii_bus = mdiobus_alloc();
 		if (!ds->slave_mii_bus) {
@@ -891,7 +888,7 @@ static int dsa_switch_setup(struct dsa_switch *ds)
 	}
 
 	ds->setup = true;
-
+	devlink_register(ds->devlink);
 	return 0;
 
 free_slave_mii_bus:
@@ -906,7 +903,6 @@ static int dsa_switch_setup(struct dsa_switch *ds)
 	list_for_each_entry(dp, &ds->dst->ports, list)
 		if (dp->ds == ds)
 			dsa_port_devlink_teardown(dp);
-	devlink_unregister(ds->devlink);
 	devlink_free(ds->devlink);
 	ds->devlink = NULL;
 	return err;
@@ -919,6 +915,9 @@ static void dsa_switch_teardown(struct dsa_switch *ds)
 	if (!ds->setup)
 		return;
 
+	if (ds->devlink)
+		devlink_unregister(ds->devlink);
+
 	if (ds->slave_mii_bus && ds->ops->phy_read) {
 		mdiobus_unregister(ds->slave_mii_bus);
 		mdiobus_free(ds->slave_mii_bus);
@@ -934,7 +933,6 @@ static void dsa_switch_teardown(struct dsa_switch *ds)
 		list_for_each_entry(dp, &ds->dst->ports, list)
 			if (dp->ds == ds)
 				dsa_port_devlink_teardown(dp);
-		devlink_unregister(ds->devlink);
 		devlink_free(ds->devlink);
 		ds->devlink = NULL;
 	}
-- 
2.31.1

