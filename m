From: James Smart <jsmart2021@gmail.com>
Date: Fri, 23 Jul 2021 10:15:12 -0700
Subject: [Intel-wired-lan] [PATCH v5 11/14] scsi: lpfc: Use
 irq_set_affinity
In-Reply-To: <20210720232624.1493424-12-nitesh@redhat.com>
References: <20210720232624.1493424-1-nitesh@redhat.com>
 <20210720232624.1493424-12-nitesh@redhat.com>
Message-ID: <f1512e42-f2fa-b4e7-4133-4a6066b7ea0d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 7/20/2021 4:26 PM, Nitesh Narayan Lal wrote:
> The driver uses irq_set_affinity_hint to set the affinity for the lpfc
> interrupts to a mask corresponding to the local NUMA node to avoid
> performance overhead on AMD architectures.
> 
> However, irq_set_affinity_hint() setting the affinity is an undocumented
> side effect that this function also sets the affinity under the hood.
> To remove this side effect irq_set_affinity_hint() has been marked as
> deprecated and new interfaces have been introduced.
> 
> Also, as per the commit dcaa21367938 ("scsi: lpfc: Change default IRQ model
> on AMD architectures"):
> "On AMD architecture, revert the irq allocation to the normal style
> (non-managed) and then use irq_set_affinity_hint() to set the cpu affinity
> and disable user-space rebalancing."
> we don't really need to set the affinity_hint as user-space rebalancing for
> the lpfc interrupts is not desired.
> 
> Hence, replace the irq_set_affinity_hint() with irq_set_affinity() which
> only applies the affinity for the interrupts.
> 
> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
> ---
>   drivers/scsi/lpfc/lpfc_init.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 

Looks good. Thanks

Reviewed-by: James Smart <jsmart2021@gmail.com>

-- james

