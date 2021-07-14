From: Leon Romanovsky <leonro@nvidia.com>
Date: Wed, 14 Jul 2021 15:01:11 +0300
Subject: [Intel-wired-lan] [PATCH v3 13/14] net/mlx5: Use
 irq_set_affinity_and_hint
In-Reply-To: <20210713211502.464259-14-nitesh@redhat.com>
References: <20210713211502.464259-1-nitesh@redhat.com>
 <20210713211502.464259-14-nitesh@redhat.com>
Message-ID: <YO7SB4q9Q7S0lIbR@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Jul 13, 2021 at 05:15:01PM -0400, Nitesh Narayan Lal wrote:
> The driver uses irq_set_affinity_hint() to update the affinity_hint mask
> that is consumed by the userspace to distribute the interrupts and to apply
> the provided mask as the affinity for the mlx5 interrupts. However,
> irq_set_affinity_hint() applying the provided cpumask as an affinity for
> the interrupt is an undocumented side effect.
> 
> To remove this side effect irq_set_affinity_hint() has been marked
> as deprecated and new interfaces have been introduced. Hence, replace the
> irq_set_affinity_hint() with the new interface irq_set_affinity_and_hint()
> where the provided mask needs to be applied as the affinity and
> affinity_hint pointer needs to be set and replace with
> irq_update_affinity_hint() where only affinity_hint needs to be updated.
> 
> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
