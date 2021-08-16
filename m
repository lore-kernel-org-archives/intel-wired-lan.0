From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Mon, 16 Aug 2021 13:11:47 -0500
Subject: [Intel-wired-lan] [PATCH v5 10/14] mailbox: Use
 irq_update_affinity_hint
In-Reply-To: <20210720232624.1493424-11-nitesh@redhat.com>
References: <20210720232624.1493424-1-nitesh@redhat.com>
 <20210720232624.1493424-11-nitesh@redhat.com>
Message-ID: <CABb+yY3Wz57dYZ8pa5zHatGRu1RFmyRK+UvN+B8txCcOUTPQzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Jul 20, 2021 at 6:27 PM Nitesh Narayan Lal <nitesh@redhat.com> wrote:
>
> The driver uses irq_set_affinity_hint() to:
>
> - Set the affinity_hint which is consumed by the userspace for
>   distributing the interrupts
>
> - Enforce affinity
>
> As per commit 6ac17fe8c14a ("mailbox: bcm-flexrm-mailbox: Set IRQ affinity
> hint for FlexRM ring IRQs") the latter is done to ensure that the FlexRM
> ring interrupts are evenly spread across all available CPUs. However, since
> commit a0c9259dc4e1 ("irq/matrix: Spread interrupts on allocation") the
> spreading of interrupts is dynamically performed at the time of allocation.
> Hence, there is no need for the drivers to enforce their own affinity for
> the spreading of interrupts.
>
> Also, irq_set_affinity_hint() applying the provided cpumask as an affinity
> for the interrupt is an undocumented side effect. To remove this side
> effect irq_set_affinity_hint() has been marked as deprecated and new
> interfaces have been introduced. Hence, replace the irq_set_affinity_hint()
> with the new interface irq_update_affinity_hint() that only sets the
> affinity_hint pointer.
>
> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
> ---
>  drivers/mailbox/bcm-flexrm-mailbox.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mailbox/bcm-flexrm-mailbox.c b/drivers/mailbox/bcm-flexrm-mailbox.c
> index 78073ad1f2f1..16982c13d323 100644
> --- a/drivers/mailbox/bcm-flexrm-mailbox.c
> +++ b/drivers/mailbox/bcm-flexrm-mailbox.c
> @@ -1298,7 +1298,7 @@ static int flexrm_startup(struct mbox_chan *chan)
>         val = (num_online_cpus() < val) ? val / num_online_cpus() : 1;
>         cpumask_set_cpu((ring->num / val) % num_online_cpus(),
>                         &ring->irq_aff_hint);
> -       ret = irq_set_affinity_hint(ring->irq, &ring->irq_aff_hint);
> +       ret = irq_update_affinity_hint(ring->irq, &ring->irq_aff_hint);
>         if (ret) {
>                 dev_err(ring->mbox->dev,
>                         "failed to set IRQ affinity hint for ring%d\n",
> @@ -1425,7 +1425,7 @@ static void flexrm_shutdown(struct mbox_chan *chan)
>
>         /* Release IRQ */
>         if (ring->irq_requested) {
> -               irq_set_affinity_hint(ring->irq, NULL);
> +               irq_update_affinity_hint(ring->irq, NULL);
>                 free_irq(ring->irq, ring);
>                 ring->irq_requested = false;
>         }
>
Seems ok to me. But I don't have the h/w to test.

Acked-by: Jassi Brar <jaswinder.singh@linaro.org>

cheers.
