From: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Date: Fri, 6 Aug 2021 14:24:49 +0530
Subject: [Intel-wired-lan] [PATCH v5 05/14] scsi: mpt3sas: Use
 irq_set_affinity_and_hint
In-Reply-To: <20210720232624.1493424-6-nitesh@redhat.com>
References: <20210720232624.1493424-1-nitesh@redhat.com>
 <20210720232624.1493424-6-nitesh@redhat.com>
Message-ID: <CAK=zhgo29UsFsK_q9RYnEocmTA20kUVX4BNnrpJPh35Ssb49zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Jul 21, 2021 at 4:57 AM Nitesh Narayan Lal <nitesh@redhat.com> wrote:
>
> The driver uses irq_set_affinity_hint() specifically for the high IOPS
> queue interrupts for two purposes:
>
> - To set the affinity_hint which is consumed by the userspace for
>   distributing the interrupts
>
> - To apply an affinity that it provides
>
> The driver enforces its own affinity to bind the high IOPS queue interrupts
> to the local NUMA node. However, irq_set_affinity_hint() applying the
> provided cpumask as an affinity (if not NULL) for the interrupt is an
> undocumented side effect.
>
> To remove this side effect irq_set_affinity_hint() has been marked
> as deprecated and new interfaces have been introduced. Hence, replace the
> irq_set_affinity_hint() with the new interface irq_set_affinity_and_hint()
> where the provided mask needs to be applied as the affinity and
> affinity_hint pointer needs to be set and replace with
> irq_update_affinity_hint() where only affinity_hint needs to be updated.
>

Changes looks good and also verified that the high iops queue's IRQs
are affinitied to local numa node.

Reviewed-by: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
> ---
>  drivers/scsi/mpt3sas/mpt3sas_base.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
> index c39955239d1c..c1a11962f227 100644
> --- a/drivers/scsi/mpt3sas/mpt3sas_base.c
> +++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
> @@ -2991,6 +2991,7 @@ _base_check_enable_msix(struct MPT3SAS_ADAPTER *ioc)
>  static void
>  _base_free_irq(struct MPT3SAS_ADAPTER *ioc)
>  {
> +       unsigned int irq;
>         struct adapter_reply_queue *reply_q, *next;
>
>         if (list_empty(&ioc->reply_queue_list))
> @@ -2998,9 +2999,10 @@ _base_free_irq(struct MPT3SAS_ADAPTER *ioc)
>
>         list_for_each_entry_safe(reply_q, next, &ioc->reply_queue_list, list) {
>                 list_del(&reply_q->list);
> -               if (ioc->smp_affinity_enable)
> -                       irq_set_affinity_hint(pci_irq_vector(ioc->pdev,
> -                           reply_q->msix_index), NULL);
> +               if (ioc->smp_affinity_enable) {
> +                       irq = pci_irq_vector(ioc->pdev, reply_q->msix_index);
> +                       irq_update_affinity_hint(irq, NULL);
> +               }
>                 free_irq(pci_irq_vector(ioc->pdev, reply_q->msix_index),
>                          reply_q);
>                 kfree(reply_q);
> @@ -3056,16 +3058,13 @@ _base_request_irq(struct MPT3SAS_ADAPTER *ioc, u8 index)
>   * @ioc: per adapter object
>   *
>   * The enduser would need to set the affinity via /proc/irq/#/smp_affinity
> - *
> - * It would nice if we could call irq_set_affinity, however it is not
> - * an exported symbol
>   */
>  static void
>  _base_assign_reply_queues(struct MPT3SAS_ADAPTER *ioc)
>  {
> -       unsigned int cpu, nr_cpus, nr_msix, index = 0;
> +       unsigned int cpu, nr_cpus, nr_msix, index = 0, irq;
>         struct adapter_reply_queue *reply_q;
> -       int local_numa_node;
> +       const struct cpumask *mask;
>
>         if (!_base_is_controller_msix_enabled(ioc))
>                 return;
> @@ -3088,11 +3087,11 @@ _base_assign_reply_queues(struct MPT3SAS_ADAPTER *ioc)
>                  * corresponding to high iops queues.
>                  */
>                 if (ioc->high_iops_queues) {
> -                       local_numa_node = dev_to_node(&ioc->pdev->dev);
> +                       mask = cpumask_of_node(dev_to_node(&ioc->pdev->dev));
>                         for (index = 0; index < ioc->high_iops_queues;
>                             index++) {
> -                               irq_set_affinity_hint(pci_irq_vector(ioc->pdev,
> -                                   index), cpumask_of_node(local_numa_node));
> +                               irq = pci_irq_vector(ioc->pdev, index);
> +                               irq_set_affinity_and_hint(irq, mask);
>                         }
>                 }
>
> --
> 2.27.0
>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 4218 bytes
Desc: S/MIME Cryptographic Signature
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20210806/eb95c8f7/attachment.p7s>
