From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Sat, 3 Dec 2016 12:58:42 +0530
Subject: [Intel-wired-lan] [PATCH v2] ethernet: intel: Replace
	pci_pool_alloc by pci_pool_zalloc
In-Reply-To: <1480707894.2415.16.camel@intel.com>
References: <20161201190427.GA3357@jordon-HP-15-Notebook-PC>
 <1480707894.2415.16.camel@intel.com>
Message-ID: <CAFqt6zbAVxVu-bsH2P+km2tX_4RsdqD0aCS6a9RLJ-bm9kzX7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sat, Dec 3, 2016 at 1:14 AM, Jeff Kirsher
<jeffrey.t.kirsher@intel.com> wrote:
> On Fri, 2016-12-02 at 00:34 +0530, Souptick Joarder wrote:
>> In e100_alloc_cbs(), pci_pool_alloc() followed by memset will be
>> replaced by pci_pool_zalloc()
>>
>> Signed-off-by: Souptick joarder <jrdr.linux@gmail.com>
>
> Why the change?  Is pci_pool_alloc() being deprecated?  I ask because this
> is a very old driver and changes will cause a huge regression, where many
> of the parts/NICs may not be available to test with.

pci_pool_alloc is not deprecated. As pci_pool_zalloc can do the same as
pci_pool_alloc/memset, hence this change.

Do we need to go through complete regression to validate this patch?

>
>> ---
>> v2:
>>   - Alignment changes
>>
>>  drivers/net/ethernet/intel/e100.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/e100.c
>> b/drivers/net/ethernet/intel/e100.c
>> index 068789e..0cf338f 100644
>> --- a/drivers/net/ethernet/intel/e100.c
>> +++ b/drivers/net/ethernet/intel/e100.c
>> @@ -1910,11 +1910,10 @@ static int e100_alloc_cbs(struct nic *nic)
>>       nic->cb_to_use = nic->cb_to_send = nic->cb_to_clean = NULL;
>>       nic->cbs_avail = 0;
>>
>> -     nic->cbs = pci_pool_alloc(nic->cbs_pool, GFP_KERNEL,
>> -                               &nic->cbs_dma_addr);
>> +     nic->cbs = pci_pool_zalloc(nic->cbs_pool, GFP_KERNEL,
>> +                                &nic->cbs_dma_addr);
>>       if (!nic->cbs)
>>               return -ENOMEM;
>> -     memset(nic->cbs, 0, count * sizeof(struct cb));
>>
>>       for (cb = nic->cbs, i = 0; i < count; cb++, i++) {
>>               cb->next = (i + 1 < count) ? cb + 1 : nic->cbs;
>> --
>> 1.9.1
>>
