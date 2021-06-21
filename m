From: Leon Romanovsky <leon@kernel.org>
Date: Mon, 21 Jun 2021 11:01:20 +0300
Subject: [Intel-wired-lan] [PATCH v1 13/14] net/mlx5: Use
 irq_update_affinity_hint
In-Reply-To: <20210617182242.8637-14-nitesh@redhat.com>
References: <20210617182242.8637-1-nitesh@redhat.com>
 <20210617182242.8637-14-nitesh@redhat.com>
Message-ID: <YNBHUMRqc+s0JesY@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Jun 17, 2021 at 02:22:41PM -0400, Nitesh Narayan Lal wrote:
> The driver uses irq_set_affinity_hint() to update the affinity_hint mask
> that is consumed by the userspace to distribute the interrupts. However,
> under the hood irq_set_affinity_hint() also applies the provided cpumask
> (if not NULL) as the affinity for the given interrupt which is an
> undocumented side effect.
> 
> To remove this side effect irq_set_affinity_hint() has been marked
> as deprecated and new interfaces have been introduced. Hence, replace the
> irq_set_affinity_hint() with the new interface irq_update_affinity_hint()
> that only updates the affinity_hint pointer.
> 
> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
