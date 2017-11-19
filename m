From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Sat, 18 Nov 2017 20:40:57 -0800
Subject: [Intel-wired-lan] [RFC PATCH jkirsher/next-queue 3/9] ixgbe:
 add the ipsec support code files
In-Reply-To: <CAKgT0UdcG0xzgxxufe1xepbMYY4o0-Giubw9VMedpDfFD0P90A@mail.gmail.com>
References: <1510862087-1924-1-git-send-email-shannon.nelson@oracle.com>
 <1510862087-1924-4-git-send-email-shannon.nelson@oracle.com>
 <CAKgT0UchEafhUNaP9zSi+n1orrFpk4SD_2Z-zc5YC3v+OUq=qA@mail.gmail.com>
 <5386178a-972d-1b50-a353-6a6490b266f3@oracle.com>
 <CAKgT0UdcG0xzgxxufe1xepbMYY4o0-Giubw9VMedpDfFD0P90A@mail.gmail.com>
Message-ID: <627a275b-06a1-eda5-9485-c2dc88120a3c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 11/18/2017 4:55 PM, Alexander Duyck wrote:
> On Sat, Nov 18, 2017 at 12:18 PM, Shannon Nelson
>> On 11/17/2017 1:30 PM, Alexander Duyck wrote:
>>>
>>> On Thu, Nov 16, 2017 at 11:54 AM, Shannon Nelson
>>> <shannon.nelson@oracle.com> wrote:
>>>>
>>>> This adds the ipsec support code into the driver, but doesn't yet
>>>> include it into the compile.
>>>>
>>>> It is possible that the .h file contents could simply go into
>>>> the ixgbe_type.h and ixgbe.h files.
>>>>
>>>> Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
>>>
>>>
>>> Generally I really hate it when code is just thrown in like this as it
>>> is really difficult to review and/or debug. I would really much prefer
>>> to have this code added as it is needed for specific functionality.
>>>
>>>> ---
>>>>    drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 1133
>>>> ++++++++++++++++++++++++
>>>>    drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.h |   80 ++
>>>>    2 files changed, 1213 insertions(+)
>>>>    create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
>>>>    create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.h
>>>>
>>>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
>>>> b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
>>>> new file mode 100644
>>>> index 0000000..177b915
>>>> --- /dev/null
>>>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
>>>> @@ -0,0 +1,1133 @@
>>>>
> 
> <snip>
> 
>>>> +
>>>> +       /* decode error bits, if any */
>>>> +       if ((status_error & IXGBE_RXDADV_ERR_IPSEC_AUTH_FAILED) ==
>>>> IXGBE_RXDADV_ERR_IPSEC_AUTH_FAILED) {
>>>> +               if (pkt_info & IXGBE_RXDADV_PKTTYPE_IPSEC_AH)
>>>> +                       crypto_status = CRYPTO_TRANSPORT_AH_AUTH_FAILED;
>>>> +               else if (pkt_info & IXGBE_RXDADV_PKTTYPE_IPSEC_ESP)
>>>> +                       crypto_status = CRYPTO_TRANSPORT_ESP_AUTH_FAILED;
>>>> +       } else if (status_error & IXGBE_RXDADV_ERR_IPSEC_INV_PROTOCOL) {
>>>> +               crypto_status = CRYPTO_INVALID_PROTOCOL;
>>>> +       } else if (status_error & IXGBE_RXDADV_ERR_IPSEC_INV_LENGTH) {
>>>> +               crypto_status = CRYPTO_INVALID_PACKET_SYNTAX;
>>>> +       } else {
>>>> +               crypto_status = CRYPTO_SUCCESS;
>>>> +       }
>>>> +
>>>
>>>
>>> You might look at converting this into a look-up table since you have
>>> essentially 2 protocols (AH or ESP), and 4 possible return values that
>>> have to be translated int the final result value. A single 2
>>> dimensional 8 byte array should be enough to handle all the possible
>>> crypto_status return values.
>>
>>
>> Actually, if we throw the packet away earlier in the path when looking at
>> the IXGBE_RXDADV_ERR_FRAME_ERR_MASK macro, we won't need to look for these
>> error bits at all.
> 
> The question is if it is valid to throw away the frame or if we should
> handle this like we handle a checksum error and just pass it up the
> stack to be processed. I assume if we have an error we don't decode
> the frame. If so we could probably pass the frame up with no offloads
> at all and let the stack deal with it all. That way if there end up
> being any false bugs in the hardware we don't end up dropping valid
> frames.

I need to double check what the XFRM code expects and work from there. 
Steffen has suggested that packets with errors from the chip shouldn't 
be passed up the stack.  Given that, I'm not sure why we would bother 
with having error values here, so just dropping the packets seems to be 
the thing to do.

> 
>>>
>>>> +       skb->sp = secpath_dup(skb->sp);
>>>> +       if (unlikely(!skb->sp))
>>>> +               return;
>>>> +
>>>
>>>
>>> It seems like this should be done as soon as you have found your
>>> transform state. Otherwise there isn't much point in decoding the
>>> status_error bits.
>>>
>>>> +       skb->sp->xvec[skb->sp->len++] = xs;
>>>> +       skb->sp->olen++;
>>>> +       xo = xfrm_offload(skb);
>>>> +       xo->flags = CRYPTO_DONE;
>>>> +       xo->status = crypto_status;
>>>> +
>>>> +       if (xo->status == CRYPTO_SUCCESS)
>>>> +               rx_ring->rx_stats.ipsec_offloads++;
>>>> +       else
>>>> +               rx_ring->rx_stats.ipsec_offload_faileds++;
>>>
>>>
>>> You might rename offload_faileds to offload_errors, since the word
>>> "failed" isn't really something to pluralize.
>>
>>
>> I'm trying to decide if I want to keep these stats around at all.
> 
> I'd say the stats are useful so they could probably be kept. If
> nothing else they tell you if the offload is on, and if it is working
> or not.

Maybe I'll fix it so that the stats aren't printed in the ethtool output 
if there are no current ipsec offloads?  Or maybe I'll combine them into 
a single pair of offloads and faileds counts rather than a pair for 
every queue - this might be better.

sln

> 
