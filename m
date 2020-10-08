From: Nitesh Narayan Lal <nitesh@redhat.com>
Date: Thu, 8 Oct 2020 17:40:36 -0400
Subject: [Intel-wired-lan] [PATCH v4 0/4] isolation: limit msix vectors
 to housekeeping CPUs
In-Reply-To: <20201001154949.GA7303@lothringen>
References: <20200928183529.471328-1-nitesh@redhat.com>
 <20201001154949.GA7303@lothringen>
Message-ID: <9c55624f-2a01-b71c-7f66-3747cb844e5a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


On 10/1/20 11:49 AM, Frederic Weisbecker wrote:
> On Mon, Sep 28, 2020 at 02:35:25PM -0400, Nitesh Narayan Lal wrote:
>> Nitesh Narayan Lal (4):
>>   sched/isolation: API to get number of housekeeping CPUs
>>   sched/isolation: Extend nohz_full to isolate managed IRQs
>>   i40e: Limit msix vectors to housekeeping CPUs
>>   PCI: Limit pci_alloc_irq_vectors() to housekeeping CPUs
>>
>>  drivers/net/ethernet/intel/i40e/i40e_main.c |  3 ++-
>>  drivers/pci/msi.c                           | 18 ++++++++++++++++++
>>  include/linux/sched/isolation.h             |  9 +++++++++
>>  kernel/sched/isolation.c                    |  2 +-
>>  4 files changed, 30 insertions(+), 2 deletions(-)
> Acked-by: Frederic Weisbecker <frederic@kernel.org>
>
> Peter, if you're ok with the set, I guess this should go through
> the scheduler tree?
>
> Thanks.

Hi Peter,

I wanted follow up to check if you have any concerns/suggestions that I
should address in this patch-set before this can be picked?

-- 
Thanks
Nitesh

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: OpenPGP digital signature
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20201008/74292894/attachment.asc>
