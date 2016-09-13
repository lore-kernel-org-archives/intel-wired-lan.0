From: Tom Herbert <tom@herbertland.com>
Date: Mon, 12 Sep 2016 21:25:43 -0700
Subject: [Intel-wired-lan] [net-next PATCH v3 1/3] e1000: track BQL
 bytes regardless of skb or not
In-Reply-To: <CAKgT0UdShvcviYP=VVp8c0OOESDnqsppArVeUhjxfM6XqX6HwQ@mail.gmail.com>
References: <20160912220312.5610.77528.stgit@john-Precision-Tower-5810>
 <20160912221327.5610.74333.stgit@john-Precision-Tower-5810>
 <CAKgT0UdShvcviYP=VVp8c0OOESDnqsppArVeUhjxfM6XqX6HwQ@mail.gmail.com>
Message-ID: <CALx6S364cmWz-6trzyX5pdhk_G_AC4XNoxCga13=_6uoWb5CTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Sep 12, 2016 at 8:00 PM, Alexander Duyck
<alexander.duyck@gmail.com> wrote:
> On Mon, Sep 12, 2016 at 3:13 PM, John Fastabend
> <john.fastabend@gmail.com> wrote:
>> The BQL API does not reference the sk_buff nor does the driver need to
>> reference the sk_buff to calculate the length of a transmitted frame.
>> This patch removes an sk_buff reference from the xmit irq path and
>> also allows packets sent from XDP to use BQL.
>>
>> Signed-off-by: John Fastabend <john.r.fastabend@intel.com>
>> ---
>>  drivers/net/ethernet/intel/e1000/e1000_main.c |    7 ++-----
>>  1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
>> index f42129d..62a7f8d 100644
>> --- a/drivers/net/ethernet/intel/e1000/e1000_main.c
>> +++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
>> @@ -3882,11 +3882,8 @@ static bool e1000_clean_tx_irq(struct e1000_adapter *adapter,
>>                         if (cleaned) {
>>                                 total_tx_packets += buffer_info->segs;
>>                                 total_tx_bytes += buffer_info->bytecount;
>> -                               if (buffer_info->skb) {
>> -                                       bytes_compl += buffer_info->skb->len;
>> -                                       pkts_compl++;
>> -                               }
>> -
>> +                               bytes_compl += buffer_info->length;
>> +                               pkts_compl++;
>>                         }
>>                         e1000_unmap_and_free_tx_resource(adapter, buffer_info);
>>                         tx_desc->upper.data = 0;
>
> Actually it might be worth looking into why we have two different
> stats for tracking bytecount and segs.  From what I can tell the
> pkts_compl value is never actually used.  The function doesn't even
> use the value so it is just wasted cycles.  And as far as the bytes go

Transmit flow steering which I posted and is pending on some testing
uses the pkt count BQL to track inflight packets.

> the accounting would be more accurate if you were to use bytecount
> instead of buffer_info->skb->len.  You would just need to update the
> xmit function to use that on the other side so that they match.
>
> - Alex
