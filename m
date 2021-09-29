From: Leon Romanovsky <leon@kernel.org>
Date: Wed, 29 Sep 2021 13:16:37 +0300
Subject: [Intel-wired-lan] [PATCH net-next 3/5] devlink: Allow set specific
 ops callbacks dynamically
In-Reply-To: <cover.1632909221.git.leonro@nvidia.com>
References: <cover.1632909221.git.leonro@nvidia.com>
Message-ID: <4e99e3996118ce0e2da5367b8fc2a427095dfffd.1632909221.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Leon Romanovsky <leonro@nvidia.com>

Introduce new devlink call to set specific ops callback during
device initialization phase after devlink_alloc() is already
called.

This allows us to set reload_* specific ops based on device property
which sometimes is known almost at the end of driver initialization.

For the sake of simplicity, this API lacks any type of locking and
needs to be called before devlink_register() to make sure that no
parallel access to the ops is possible at this stage.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 include/net/devlink.h |  1 +
 net/core/devlink.c    | 41 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index 317b09917c41..305be548ac21 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1565,6 +1565,7 @@ static inline struct devlink *devlink_alloc(struct devlink_ops *ops,
 {
 	return devlink_alloc_ns(ops, priv_size, &init_net, dev);
 }
+void devlink_set_ops(struct devlink *devlink, struct devlink_ops *ops);
 void devlink_register(struct devlink *devlink);
 void devlink_unregister(struct devlink *devlink);
 void devlink_reload_enable(struct devlink *devlink);
diff --git a/net/core/devlink.c b/net/core/devlink.c
index cee2be47c40e..71d0c5671f43 100644
--- a/net/core/devlink.c
+++ b/net/core/devlink.c
@@ -8907,6 +8907,43 @@ static bool devlink_reload_actions_valid(struct devlink_ops *ops)
 	return true;
 }
 
+/**
+ *	devlink_set_ops - Set devlink ops dynamically
+ *
+ *	@devlink: devlink
+ *	@ops: devlink ops to set
+ *
+ *	This interface allows us to set ops based on device property
+ *	which is known after devlink_alloc() was already called. For now,
+ *	it is applicable for reload_* assignments only and all other
+ *	callbacks are ignored.
+ *
+ *	It should be called before devlink_register(), so doesn't have any
+ *	protection from concurent access.
+ */
+void devlink_set_ops(struct devlink *devlink, struct devlink_ops *ops)
+{
+	struct devlink_ops *dev_ops = devlink->ops;
+
+	WARN_ON(!devlink_reload_actions_valid(ops));
+
+#define SET_DEVICE_OP(ptr, name)                                               \
+	do {                                                                   \
+		if (ops->name)                                                 \
+			if (!((ptr)->name))				       \
+				(ptr)->name = ops->name;                       \
+	} while (0)
+
+	/* Keep sorted */
+	SET_DEVICE_OP(dev_ops, reload_actions);
+	SET_DEVICE_OP(dev_ops, reload_down);
+	SET_DEVICE_OP(dev_ops, reload_limits);
+	SET_DEVICE_OP(dev_ops, reload_up);
+
+#undef SET_DEVICE_OP
+}
+EXPORT_SYMBOL_GPL(devlink_set_ops);
+
 /**
  *	devlink_alloc_ns - Allocate new devlink instance resources
  *	in specific namespace
@@ -8927,8 +8964,6 @@ struct devlink *devlink_alloc_ns(struct devlink_ops *ops, size_t priv_size,
 	int ret;
 
 	WARN_ON(!ops || !dev);
-	if (!devlink_reload_actions_valid(ops))
-		return NULL;
 
 	devlink = kzalloc(sizeof(*devlink) + priv_size, GFP_KERNEL);
 	if (!devlink)
@@ -8943,6 +8978,8 @@ struct devlink *devlink_alloc_ns(struct devlink_ops *ops, size_t priv_size,
 
 	devlink->dev = dev;
 	devlink->ops = ops;
+	/* To check validity of reload actions */
+	devlink_set_ops(devlink, ops);
 	xa_init_flags(&devlink->snapshot_ids, XA_FLAGS_ALLOC);
 	write_pnet(&devlink->_net, net);
 	INIT_LIST_HEAD(&devlink->port_list);
-- 
2.31.1

