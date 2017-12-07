From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Wed, 6 Dec 2017 21:43:27 -0800
Subject: [Intel-wired-lan] [next-queue 04/10] ixgbe: add ipsec data
 structures
In-Reply-To: <CAKgT0UfR5V9c6VW_b2WzjW0-2XQiw=89pmO0OpXEon71kzPtUw@mail.gmail.com>
References: <1512452116-14795-1-git-send-email-shannon.nelson@oracle.com>
 <1512452116-14795-5-git-send-email-shannon.nelson@oracle.com>
 <CAKgT0UfR5V9c6VW_b2WzjW0-2XQiw=89pmO0OpXEon71kzPtUw@mail.gmail.com>
Message-ID: <8a4286b3-05c4-8816-dea4-b9703cb63f8f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 12/5/2017 9:03 AM, Alexander Duyck wrote:
> On Mon, Dec 4, 2017 at 9:35 PM, Shannon Nelson
> <shannon.nelson@oracle.com> wrote:
>> Set up the data structures to be used by the ipsec offload.
>>
>> Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
>> ---
>>   drivers/net/ethernet/intel/ixgbe/ixgbe.h       |  5 ++++
>>   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.h | 40 ++++++++++++++++++++++++++
>>   2 files changed, 45 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
>> index 1e11462..9487750 100644
>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
>> @@ -622,6 +622,7 @@ struct ixgbe_adapter {
>>   #define IXGBE_FLAG2_EEE_CAPABLE                        BIT(14)
>>   #define IXGBE_FLAG2_EEE_ENABLED                        BIT(15)
>>   #define IXGBE_FLAG2_RX_LEGACY                  BIT(16)
>> +#define IXGBE_FLAG2_IPSEC_ENABLED              BIT(17)
>>
>>          /* Tx fast path data */
>>          int num_tx_queues;
>> @@ -772,6 +773,10 @@ struct ixgbe_adapter {
>>
>>   #define IXGBE_RSS_KEY_SIZE     40  /* size of RSS Hash Key in bytes */
>>          u32 *rss_key;
>> +
>> +#ifdef CONFIG_XFRM
>> +       struct ixgbe_ipsec *ipsec;
>> +#endif /* CONFIG_XFRM */
>>   };
>>
>>   static inline u8 ixgbe_max_rss_indices(struct ixgbe_adapter *adapter)
>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.h
>> index 017b13f..cb9a4be 100644
>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.h
>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.h
>> @@ -47,4 +47,44 @@
>>   #define IXGBE_RXMOD_DECRYPT            0x00000008
>>   #define IXGBE_RXMOD_IPV6               0x00000010
>>
>> +struct rx_sa {
>> +       struct hlist_node hlist;
>> +       struct xfrm_state *xs;
>> +       u32 ipaddr[4];
> 
> ipaddr should be stored as a __be32, not a u32.

Yep

> 
>> +       u32 key[4];
>> +       u32 salt;
>> +       u32 mode;
>> +       u8  iptbl_ind;
>> +       bool used;
>> +       bool decrypt;
>> +};
>> +
>> +struct rx_ip_sa {
>> +       u32 ipaddr[4];
> 
> Same thing here.

Yep

> 
>> +       u32 ref_cnt;
>> +       bool used;
>> +};
>> +
>> +struct tx_sa {
>> +       struct xfrm_state *xs;
>> +       u32 key[4];
>> +       u32 salt;
>> +       bool encrypt;
>> +       bool used;
>> +};
>> +
>> +struct ixgbe_ipsec_tx_data {
>> +       u32 flags;
>> +       u16 trailer_len;
>> +       u16 sa_idx;
>> +};
>> +
>> +struct ixgbe_ipsec {
>> +       u16 num_rx_sa;
>> +       u16 num_tx_sa;
>> +       struct rx_ip_sa *ip_tbl;
>> +       struct rx_sa *rx_tbl;
>> +       struct tx_sa *tx_tbl;
>> +       DECLARE_HASHTABLE(rx_sa_list, 8);
> 
> The hash table seems a bit on the small side. You might look at
> increasing this to something like 32 in order to try and cut down on
> the load in each bucket since the upper limit is 1K or so isn't it?

I probably can - didn't want to use too much memory real estate if not 
really needed.  I did a little perf timing with a mostly full table and 
didn't see much degradation.  Maybe boost it to 16?

sln

> 
>> +};
>>   #endif /* _IXGBE_IPSEC_H_ */
>> --
>> 2.7.4
>>
>> _______________________________________________
>> Intel-wired-lan mailing list
>> Intel-wired-lan at osuosl.org
>> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
