From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Tue, 13 Jul 2021 14:52:10 -0700
Subject: [Intel-wired-lan] [PATCH v3 03/14] i40e: Use
 irq_update_affinity_hint
In-Reply-To: <20210713211502.464259-4-nitesh@redhat.com>
References: <20210713211502.464259-1-nitesh@redhat.com>
 <20210713211502.464259-4-nitesh@redhat.com>
Message-ID: <4eca6f2d-c5d2-1f1d-ffc4-4d8f7bbed68e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 7/13/2021 2:14 PM, Nitesh Narayan Lal wrote:
> The driver uses irq_set_affinity_hint() for two purposes:
>
> - To set the affinity_hint which is consumed by the userspace for
>    distributing the interrupts
>
> - To apply an affinity that it provides for the i40e interrupts
>
> The latter is done to ensure that all the interrupts are evenly spread
> across all available CPUs. However, since commit a0c9259dc4e1 ("irq/matrix:
> Spread interrupts on allocation") the spreading of interrupts is
> dynamically performed at the time of allocation. Hence, there is no need
> for the drivers to enforce their own affinity for the spreading of
> interrupts.
>
> Also, irq_set_affinity_hint() applying the provided cpumask as an affinity
> for the interrupt is an undocumented side effect. To remove this side
> effect irq_set_affinity_hint() has been marked as deprecated and new
> interfaces have been introduced. Hence, replace the irq_set_affinity_hint()
> with the new interface irq_update_affinity_hint() that only sets the
> pointer for the affinity_hint.
>
> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
Thanks!

Acked-by: Jesse Brandeburg <jesse.brandeburg@intel.com>


