From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Fri, 17 Nov 2017 10:32:54 -0800
Subject: [Intel-wired-lan] [RFC PATCH jkirsher/next-queue 1/9] ixgbe:
 remove undefined and conflicting bits
In-Reply-To: <CAKgT0UdJ38aE48TNm2UGbzV+QWXxFor8TwgvYWMnxqSWXzpfZQ@mail.gmail.com>
References: <1510862087-1924-1-git-send-email-shannon.nelson@oracle.com>
 <1510862087-1924-2-git-send-email-shannon.nelson@oracle.com>
 <CAKgT0UdJ38aE48TNm2UGbzV+QWXxFor8TwgvYWMnxqSWXzpfZQ@mail.gmail.com>
Message-ID: <571a3c5d-58db-e974-60a9-d706c7091925@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 11/17/2017 8:58 AM, Alexander Duyck wrote:
> On Thu, Nov 16, 2017 at 11:54 AM, Shannon Nelson
> <shannon.nelson@oracle.com> wrote:
>> The PE and OSE error bits from the Advanced Receive Writeback
>> descriptor are undefined in the published Niantic family datasheets
>> and conflict with the defined SECERR bits, which we will need in
>> a coming patch.
>>
>> The CE and LE error bits are also marked as reserved in the
>> datasheet, but I'll let someone else remove them.
>>
>> Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
>> ---
>>   drivers/net/ethernet/intel/ixgbe/ixgbe_type.h | 4 ----
>>   1 file changed, 4 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
>> index ffa0ee5..0a77941 100644
>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
>> @@ -2375,8 +2375,6 @@ enum {
>>   #define IXGBE_RXDADV_ERR_HBO    0x00800000 /*Header Buffer Overflow */
>>   #define IXGBE_RXDADV_ERR_CE     0x01000000 /* CRC Error */
>>   #define IXGBE_RXDADV_ERR_LE     0x02000000 /* Length Error */
>> -#define IXGBE_RXDADV_ERR_PE     0x08000000 /* Packet Error */
>> -#define IXGBE_RXDADV_ERR_OSE    0x10000000 /* Oversize Error */
>>   #define IXGBE_RXDADV_ERR_USE    0x20000000 /* Undersize Error */
>>   #define IXGBE_RXDADV_ERR_TCPE   0x40000000 /* TCP/UDP Checksum Error */
>>   #define IXGBE_RXDADV_ERR_IPE    0x80000000 /* IP Checksum Error */
>> @@ -2482,8 +2480,6 @@ enum {
>>   #define IXGBE_RXDADV_ERR_FRAME_ERR_MASK ( \
>>                                        IXGBE_RXDADV_ERR_CE | \
>>                                        IXGBE_RXDADV_ERR_LE | \
>> -                                     IXGBE_RXDADV_ERR_PE | \
>> -                                     IXGBE_RXDADV_ERR_OSE | \
>>                                        IXGBE_RXDADV_ERR_USE)
>>
>>   /* Multicast bit mask */
> 
> So I have to NAK this. Those bits do apply to 82598, and were
> redefined for 82599 and later.
> 
> I'm assuming int he later patches I will see the reason why you needed
> to drop them, but for now you might look at splitting the mask up and
> leaving this as-is for 82598 and then dropping those two bits for
> 82599 if we need to.

The reason is not necessarily clear from the patches, but this macro is 
used in ixgbe_cleanup_headers() to check for errors and subsequently 
throw away the packets if any of these bits are seen.  This means that 
any packets with ipsec errors are thrown away before the ipsec code sees 
them.

As it turns out, the XFRM code further up in the stack really doesn't 
want the broken packets anyway, so we might as well throw them out, tho' 
it might be nice to track some statistics about bad ipsec packets.

I can leave the multiply-defined bits and add some commentary on the 
macro definition that this is going to catch IPsec error bits as well.

sln


