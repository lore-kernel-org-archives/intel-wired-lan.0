From: Leon Romanovsky <leon@kernel.org>
Date: Wed, 17 Nov 2021 20:26:18 +0200
Subject: [Intel-wired-lan] [PATCH net-next 2/6] devlink: Delete useless
 checks of holding devlink lock
In-Reply-To: <cover.1637173517.git.leonro@nvidia.com>
References: <cover.1637173517.git.leonro@nvidia.com>
Message-ID: <de107b4b9e547f0adc5946b0cc720de7ee3e8c14.1637173517.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Leon Romanovsky <leonro@nvidia.com>

The snapshot API is fully protected by devlink->lock and these internal
functions are not exported directly to the code outside of the devlink.c.
This makes the checks of holding devlink lock as completely redundant.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 net/core/devlink.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/net/core/devlink.c b/net/core/devlink.c
index 1cb2e0ae9173..dcc09c62f3e5 100644
--- a/net/core/devlink.c
+++ b/net/core/devlink.c
@@ -5223,8 +5223,6 @@ static int __devlink_snapshot_id_increment(struct devlink *devlink, u32 id)
 	unsigned long count;
 	void *p;
 
-	lockdep_assert_held(&devlink->lock);
-
 	p = xa_load(&devlink->snapshot_ids, id);
 	if (WARN_ON(!p))
 		return -EINVAL;
@@ -5259,8 +5257,6 @@ static void __devlink_snapshot_id_decrement(struct devlink *devlink, u32 id)
 	unsigned long count;
 	void *p;
 
-	lockdep_assert_held(&devlink->lock);
-
 	p = xa_load(&devlink->snapshot_ids, id);
 	if (WARN_ON(!p))
 		return;
@@ -5298,8 +5294,6 @@ static void __devlink_snapshot_id_decrement(struct devlink *devlink, u32 id)
  */
 static int __devlink_snapshot_id_insert(struct devlink *devlink, u32 id)
 {
-	lockdep_assert_held(&devlink->lock);
-
 	if (xa_load(&devlink->snapshot_ids, id))
 		return -EEXIST;
 
@@ -5325,8 +5319,6 @@ static int __devlink_snapshot_id_insert(struct devlink *devlink, u32 id)
  */
 static int __devlink_region_snapshot_id_get(struct devlink *devlink, u32 *id)
 {
-	lockdep_assert_held(&devlink->lock);
-
 	return xa_alloc(&devlink->snapshot_ids, id, xa_mk_value(1),
 			xa_limit_32b, GFP_KERNEL);
 }
@@ -5353,8 +5345,6 @@ __devlink_region_snapshot_create(struct devlink_region *region,
 	struct devlink_snapshot *snapshot;
 	int err;
 
-	lockdep_assert_held(&devlink->lock);
-
 	/* check if region can hold one more snapshot */
 	if (region->cur_snapshots == region->max_snapshots)
 		return -ENOSPC;
@@ -5391,8 +5381,6 @@ static void devlink_region_snapshot_del(struct devlink_region *region,
 {
 	struct devlink *devlink = region->devlink;
 
-	lockdep_assert_held(&devlink->lock);
-
 	devlink_nl_region_notify(region, snapshot, DEVLINK_CMD_REGION_DEL);
 	region->cur_snapshots--;
 	list_del(&snapshot->list);
-- 
2.33.1

