From: Nitesh Narayan Lal <nitesh@redhat.com>
Date: Tue, 20 Jul 2021 19:26:23 -0400
Subject: [Intel-wired-lan] [PATCH v5 13/14] net/mlx5: Use
 irq_set_affinity_and_hint
In-Reply-To: <20210720232624.1493424-1-nitesh@redhat.com>
References: <20210720232624.1493424-1-nitesh@redhat.com>
Message-ID: <20210720232624.1493424-14-nitesh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The driver uses irq_set_affinity_hint() to update the affinity_hint mask
that is consumed by the userspace to distribute the interrupts and to apply
the provided mask as the affinity for the mlx5 interrupts. However,
irq_set_affinity_hint() applying the provided cpumask as an affinity for
the interrupt is an undocumented side effect.

To remove this side effect irq_set_affinity_hint() has been marked
as deprecated and new interfaces have been introduced. Hence, replace the
irq_set_affinity_hint() with the new interface irq_set_affinity_and_hint()
where the provided mask needs to be applied as the affinity and
affinity_hint pointer needs to be set and replace with
irq_update_affinity_hint() where only affinity_hint needs to be updated.

Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
index b25f764daa08..4efa3f643b79 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
@@ -144,11 +144,11 @@ static void irq_release(struct kref *kref)
 	struct mlx5_irq_pool *pool = irq->pool;
 
 	xa_erase(&pool->irqs, irq->index);
-	/* free_irq requires that affinity and rmap will be cleared
+	/* free_irq requires that affinity_hint and rmap will be cleared
 	 * before calling it. This is why there is asymmetry with set_rmap
 	 * which should be called after alloc_irq but before request_irq.
 	 */
-	irq_set_affinity_hint(irq->irqn, NULL);
+	irq_update_affinity_hint(irq->irqn, NULL);
 	free_cpumask_var(irq->mask);
 	free_irq(irq->irqn, &irq->nh);
 	kfree(irq);
@@ -283,7 +283,7 @@ static struct mlx5_irq *irq_pool_create_irq(struct mlx5_irq_pool *pool,
 	if (IS_ERR(irq))
 		return irq;
 	cpumask_copy(irq->mask, affinity);
-	irq_set_affinity_hint(irq->irqn, irq->mask);
+	irq_set_affinity_and_hint(irq->irqn, irq->mask);
 	return irq;
 }
 
@@ -364,7 +364,7 @@ irq_pool_request_vector(struct mlx5_irq_pool *pool, int vecidx,
 	if (IS_ERR(irq) || !affinity)
 		goto unlock;
 	cpumask_copy(irq->mask, affinity);
-	irq_set_affinity_hint(irq->irqn, irq->mask);
+	irq_set_affinity_and_hint(irq->irqn, irq->mask);
 unlock:
 	mutex_unlock(&pool->lock);
 	return irq;
-- 
2.27.0

