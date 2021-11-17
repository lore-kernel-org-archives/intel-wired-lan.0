From: Leon Romanovsky <leon@kernel.org>
Date: Wed, 17 Nov 2021 20:26:21 +0200
Subject: [Intel-wired-lan] [PATCH net-next 5/6] devlink: Reshuffle resource
 registration logic
In-Reply-To: <cover.1637173517.git.leonro@nvidia.com>
References: <cover.1637173517.git.leonro@nvidia.com>
Message-ID: <6176a137a4ded48501e8a06fda0e305f9cfc787c.1637173517.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Leon Romanovsky <leonro@nvidia.com>

The devlink->lock doesn't need to be held during whole execution of
function, but only when recursive path walk and list addition are
performed. So reshuffle the resource registration logic to allocate
resource and configure it without lock.

As part of this change, complain more louder if driver authors used
already existed resource_id. It is performed outside of the locks as
drivers were supposed to provide unique IDs and such error can't happen.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 net/core/devlink.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/net/core/devlink.c b/net/core/devlink.c
index 356057ea2e52..1dda313d6d1b 100644
--- a/net/core/devlink.c
+++ b/net/core/devlink.c
@@ -9833,17 +9833,9 @@ int devlink_resource_register(struct devlink *devlink,
 {
 	struct devlink_resource *resource;
 	struct list_head *resource_list;
-	bool top_hierarchy;
 	int err = 0;
 
-	top_hierarchy = parent_resource_id == DEVLINK_RESOURCE_ID_PARENT_TOP;
-
-	mutex_lock(&devlink->lock);
-	resource = devlink_resource_find(devlink, NULL, resource_id);
-	if (resource) {
-		err = -EINVAL;
-		goto out;
-	}
+	WARN_ON(devlink_resource_find(devlink, NULL, resource_id));
 
 	resource = kzalloc(sizeof(*resource), GFP_KERNEL);
 	if (!resource) {
@@ -9851,7 +9843,17 @@ int devlink_resource_register(struct devlink *devlink,
 		goto out;
 	}
 
-	if (top_hierarchy) {
+	resource->name = resource_name;
+	resource->size = resource_size;
+	resource->size_new = resource_size;
+	resource->id = resource_id;
+	resource->size_valid = true;
+	memcpy(&resource->size_params, size_params,
+	       sizeof(resource->size_params));
+	INIT_LIST_HEAD(&resource->resource_list);
+
+	mutex_lock(&devlink->lock);
+	if (parent_resource_id == DEVLINK_RESOURCE_ID_PARENT_TOP) {
 		resource_list = &devlink->resource_list;
 	} else {
 		struct devlink_resource *parent_resource;
@@ -9868,14 +9870,6 @@ int devlink_resource_register(struct devlink *devlink,
 		}
 	}
 
-	resource->name = resource_name;
-	resource->size = resource_size;
-	resource->size_new = resource_size;
-	resource->id = resource_id;
-	resource->size_valid = true;
-	memcpy(&resource->size_params, size_params,
-	       sizeof(resource->size_params));
-	INIT_LIST_HEAD(&resource->resource_list);
 	list_add_tail(&resource->list, resource_list);
 out:
 	mutex_unlock(&devlink->lock);
-- 
2.33.1

