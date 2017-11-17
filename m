From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Fri, 17 Nov 2017 10:34:10 -0800
Subject: [Intel-wired-lan] [RFC PATCH jkirsher/next-queue 8/9] ixgbe:
 add the Rx ipsec offload processing
In-Reply-To: <CAKgT0UduLToPdn+0ddOJ_FzYrbB3zVEH2khPT11R3LD1vrZrKg@mail.gmail.com>
References: <1510862087-1924-1-git-send-email-shannon.nelson@oracle.com>
 <1510862087-1924-9-git-send-email-shannon.nelson@oracle.com>
 <CAKgT0UduLToPdn+0ddOJ_FzYrbB3zVEH2khPT11R3LD1vrZrKg@mail.gmail.com>
Message-ID: <8d3a8f38-0914-7dd3-7a1c-0d61e022a453@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 11/17/2017 9:45 AM, Alexander Duyck wrote:
> On Thu, Nov 16, 2017 at 11:54 AM, Shannon Nelson
> <shannon.nelson@oracle.com> wrote:
>> Add the ipsec check and processing into the Rx handler.
>>
>> Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
>> ---
>>   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> index a434675..2bb4c5f 100644
>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> @@ -2424,6 +2424,9 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
>>                          }
>>                  }
>>   #endif /* IXGBE_FCOE */
>> +               /* was IPsec offload processing done?  */
>> +               if (adapter->flags2 & IXGBE_FLAG2_IPSEC_ENABLED)
>> +                       ixgbe_ipsec_process_rx_offload(rx_ring, rx_desc, skb);
>>
>>                  ixgbe_rx_skb(q_vector, skb);
> 
> Generally I prefer to use ring flags rather than global ones. It keeps
> us from having to reach too far. In addition you could probably make
> this a part of ixgbe_process_skb_fields since that is the proper place
> for handling anything that updates metadata in the skb.

Both of those comments make sense.

sln
