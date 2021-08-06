From: Sumit Saxena <sumit.saxena@broadcom.com>
Date: Fri, 6 Aug 2021 17:01:17 +0530
Subject: [Intel-wired-lan] [PATCH v5 04/14] scsi: megaraid_sas: Use
 irq_set_affinity_and_hint
In-Reply-To: <20210720232624.1493424-5-nitesh@redhat.com>
References: <20210720232624.1493424-1-nitesh@redhat.com>
 <20210720232624.1493424-5-nitesh@redhat.com>
Message-ID: <CAL2rwxqz4dcjdbqtPMaCTud+3jPhuFvJeuVgt774Rpm-+_KJxQ@mail.gmail.com>
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
> provided cpumask as an affinity for the interrupt is an undocumented side
> effect.
>
> To remove this side effect irq_set_affinity_hint() has been marked
> as deprecated and new interfaces have been introduced. Hence, replace the
> irq_set_affinity_hint() with the new interface irq_set_affinity_and_hint()
> where the provided mask needs to be applied as the affinity and
> affinity_hint pointer needs to be set and replace with
> irq_update_affinity_hint() where only affinity_hint needs to be updated.
>
> Change the megasas_set_high_iops_queue_affinity_hint function name to
> megasas_set_high_iops_queue_affinity_and_hint to clearly indicate that the
> function is setting both affinity and affinity_hint.
>
> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
Looks good.
Acked-by: Sumit Saxena <sumit.saxena@broadcom.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 4209 bytes
Desc: S/MIME Cryptographic Signature
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20210806/513d1083/attachment.p7s>
