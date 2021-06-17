From: Nitesh Narayan Lal <nitesh@redhat.com>
Date: Thu, 17 Jun 2021 14:22:41 -0400
Subject: [Intel-wired-lan] [PATCH v1 13/14] net/mlx5: Use
 irq_update_affinity_hint
In-Reply-To: <20210617182242.8637-1-nitesh@redhat.com>
References: <20210617182242.8637-1-nitesh@redhat.com>
Message-ID: <20210617182242.8637-14-nitesh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The driver uses irq_set_affinity_hint() to update the affinity_hint mask
that is consumed by the userspace to distribute the interrupts. However,
under the hood irq_set_affinity_hint() also applies the provided cpumask
(if not NULL) as the affinity for the given interrupt which is an
undocumented side effect.

To remove this side effect irq_set_affinity_hint() has been marked
as deprecated and new interfaces have been introduced. Hence, replace the
irq_set_affinity_hint() with the new interface irq_update_affinity_hint()
that only updates the affinity_hint pointer.

Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
index c3373fb1cd7f..a1b9434f4e25 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
@@ -276,8 +276,8 @@ static int set_comp_irq_affinity_hint(struct mlx5_core_dev *mdev, int i)
 	cpumask_set_cpu(cpumask_local_spread(i, mdev->priv.numa_node),
 			irq->mask);
 	if (IS_ENABLED(CONFIG_SMP) &&
-	    irq_set_affinity_hint(irqn, irq->mask))
-		mlx5_core_warn(mdev, "irq_set_affinity_hint failed, irq 0x%.4x",
+	    irq_update_affinity_hint(irqn, irq->mask))
+		mlx5_core_warn(mdev, "irq_update_affinity_hint failed, irq 0x%.4x",
 			       irqn);
 
 	return 0;
@@ -291,7 +291,7 @@ static void clear_comp_irq_affinity_hint(struct mlx5_core_dev *mdev, int i)
 
 	irq = mlx5_irq_get(mdev, vecidx);
 	irqn = pci_irq_vector(mdev->pdev, vecidx);
-	irq_set_affinity_hint(irqn, NULL);
+	irq_update_affinity_hint(irqn, NULL);
 	free_cpumask_var(irq->mask);
 }
 
-- 
2.27.0

