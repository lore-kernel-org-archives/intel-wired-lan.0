From: Leon Romanovsky <leon@kernel.org>
Date: Sat, 25 Sep 2021 14:22:48 +0300
Subject: [Intel-wired-lan] [PATCH net-next v1 08/21] net/prestera: Split
 devlink and traps registrations to separate routines
In-Reply-To: <cover.1632565508.git.leonro@nvidia.com>
References: <cover.1632565508.git.leonro@nvidia.com>
Message-ID: <0e3101259046a001c417415b84b834ca56d1bfd3.1632565508.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Leon Romanovsky <leonro@nvidia.com>

Separate devlink registrations and traps registrations so devlink will
be registered when driver is fully initialized.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 .../marvell/prestera/prestera_devlink.c       | 29 ++++---------------
 .../marvell/prestera/prestera_devlink.h       |  4 ++-
 .../ethernet/marvell/prestera/prestera_main.c |  8 +++--
 3 files changed, 14 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/marvell/prestera/prestera_devlink.c b/drivers/net/ethernet/marvell/prestera/prestera_devlink.c
index 5cca007a3e17..06279cd6da67 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_devlink.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_devlink.c
@@ -345,8 +345,6 @@ static struct prestera_trap prestera_trap_items_arr[] = {
 	},
 };
 
-static void prestera_devlink_traps_fini(struct prestera_switch *sw);
-
 static int prestera_drop_counter_get(struct devlink *devlink,
 				     const struct devlink_trap *trap,
 				     u64 *p_drops);
@@ -381,8 +379,6 @@ static int prestera_trap_action_set(struct devlink *devlink,
 				    enum devlink_trap_action action,
 				    struct netlink_ext_ack *extack);
 
-static int prestera_devlink_traps_register(struct prestera_switch *sw);
-
 static const struct devlink_ops prestera_dl_ops = {
 	.info_get = prestera_dl_info_get,
 	.trap_init = prestera_trap_init,
@@ -407,34 +403,18 @@ void prestera_devlink_free(struct prestera_switch *sw)
 	devlink_free(dl);
 }
 
-int prestera_devlink_register(struct prestera_switch *sw)
+void prestera_devlink_register(struct prestera_switch *sw)
 {
 	struct devlink *dl = priv_to_devlink(sw);
-	int err;
 
 	devlink_register(dl);
-
-	err = prestera_devlink_traps_register(sw);
-	if (err) {
-		devlink_unregister(dl);
-		dev_err(sw->dev->dev, "devlink_traps_register failed: %d\n",
-			err);
-		return err;
-	}
-
-	return 0;
 }
 
 void prestera_devlink_unregister(struct prestera_switch *sw)
 {
-	struct prestera_trap_data *trap_data = sw->trap_data;
 	struct devlink *dl = priv_to_devlink(sw);
 
-	prestera_devlink_traps_fini(sw);
 	devlink_unregister(dl);
-
-	kfree(trap_data->trap_items_arr);
-	kfree(trap_data);
 }
 
 int prestera_devlink_port_register(struct prestera_port *port)
@@ -482,7 +462,7 @@ struct devlink_port *prestera_devlink_get_port(struct net_device *dev)
 	return &port->dl_port;
 }
 
-static int prestera_devlink_traps_register(struct prestera_switch *sw)
+int prestera_devlink_traps_register(struct prestera_switch *sw)
 {
 	const u32 groups_count = ARRAY_SIZE(prestera_trap_groups_arr);
 	const u32 traps_count = ARRAY_SIZE(prestera_trap_items_arr);
@@ -621,8 +601,9 @@ static int prestera_drop_counter_get(struct devlink *devlink,
 						 cpu_code_type, p_drops);
 }
 
-static void prestera_devlink_traps_fini(struct prestera_switch *sw)
+void prestera_devlink_traps_unregister(struct prestera_switch *sw)
 {
+	struct prestera_trap_data *trap_data = sw->trap_data;
 	struct devlink *dl = priv_to_devlink(sw);
 	const struct devlink_trap *trap;
 	int i;
@@ -634,4 +615,6 @@ static void prestera_devlink_traps_fini(struct prestera_switch *sw)
 
 	devlink_trap_groups_unregister(dl, prestera_trap_groups_arr,
 				       ARRAY_SIZE(prestera_trap_groups_arr));
+	kfree(trap_data->trap_items_arr);
+	kfree(trap_data);
 }
diff --git a/drivers/net/ethernet/marvell/prestera/prestera_devlink.h b/drivers/net/ethernet/marvell/prestera/prestera_devlink.h
index cc34c3db13a2..b322295bad3a 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_devlink.h
+++ b/drivers/net/ethernet/marvell/prestera/prestera_devlink.h
@@ -9,7 +9,7 @@
 struct prestera_switch *prestera_devlink_alloc(struct prestera_device *dev);
 void prestera_devlink_free(struct prestera_switch *sw);
 
-int prestera_devlink_register(struct prestera_switch *sw);
+void prestera_devlink_register(struct prestera_switch *sw);
 void prestera_devlink_unregister(struct prestera_switch *sw);
 
 int prestera_devlink_port_register(struct prestera_port *port);
@@ -22,5 +22,7 @@ struct devlink_port *prestera_devlink_get_port(struct net_device *dev);
 
 void prestera_devlink_trap_report(struct prestera_port *port,
 				  struct sk_buff *skb, u8 cpu_code);
+int prestera_devlink_traps_register(struct prestera_switch *sw);
+void prestera_devlink_traps_unregister(struct prestera_switch *sw);
 
 #endif /* _PRESTERA_DEVLINK_H_ */
diff --git a/drivers/net/ethernet/marvell/prestera/prestera_main.c b/drivers/net/ethernet/marvell/prestera/prestera_main.c
index 44c670807fb3..78a7a00bce22 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_main.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_main.c
@@ -851,7 +851,7 @@ static int prestera_switch_init(struct prestera_switch *sw)
 	if (err)
 		goto err_span_init;
 
-	err = prestera_devlink_register(sw);
+	err = prestera_devlink_traps_register(sw);
 	if (err)
 		goto err_dl_register;
 
@@ -863,12 +863,13 @@ static int prestera_switch_init(struct prestera_switch *sw)
 	if (err)
 		goto err_ports_create;
 
+	prestera_devlink_register(sw);
 	return 0;
 
 err_ports_create:
 	prestera_lag_fini(sw);
 err_lag_init:
-	prestera_devlink_unregister(sw);
+	prestera_devlink_traps_unregister(sw);
 err_dl_register:
 	prestera_span_fini(sw);
 err_span_init:
@@ -888,9 +889,10 @@ static int prestera_switch_init(struct prestera_switch *sw)
 
 static void prestera_switch_fini(struct prestera_switch *sw)
 {
+	prestera_devlink_unregister(sw);
 	prestera_destroy_ports(sw);
 	prestera_lag_fini(sw);
-	prestera_devlink_unregister(sw);
+	prestera_devlink_traps_unregister(sw);
 	prestera_span_fini(sw);
 	prestera_acl_fini(sw);
 	prestera_event_handlers_unregister(sw);
-- 
2.31.1

