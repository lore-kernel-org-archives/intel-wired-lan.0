From: Tariq Toukan <ttoukan.linux@gmail.com>
Date: Wed, 14 Jul 2021 14:19:20 +0300
Subject: [Intel-wired-lan] [PATCH v3 14/14] net/mlx4: Use
 irq_update_affinity_hint
In-Reply-To: <20210713211502.464259-15-nitesh@redhat.com>
References: <20210713211502.464259-1-nitesh@redhat.com>
 <20210713211502.464259-15-nitesh@redhat.com>
Message-ID: <c2d794bf-20b4-95fa-dfba-e85cf6b74bd4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 7/14/2021 12:15 AM, Nitesh Narayan Lal wrote:
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
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> ---

Thanks for you patch.
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

Tariq
