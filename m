From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 22 May 2018 10:13:46 -0700
Subject: [Intel-wired-lan] [next-queue PATCH] ixgbevf: Fix coexistence
 of malicious driver detection with XDP
In-Reply-To: <0031c065-9673-2e39-7cf7-bf30b7a2fb4b@oracle.com>
References: <20180522154429.80364.17986.stgit@ahduyck-green-test.jf.intel.com>
 <0031c065-9673-2e39-7cf7-bf30b7a2fb4b@oracle.com>
Message-ID: <CAKgT0UfbmP-Z552JpgqcM26FbDoLi6Yiyg1iprJ8VmRMhyHagg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, May 22, 2018 at 10:02 AM, Shannon Nelson
<shannon.nelson@oracle.com> wrote:
> On 5/22/2018 8:44 AM, Alexander Duyck wrote:
>>
>> In the case of the VF driver it is supposed to provide a context
>> descriptor
>> that allows us to provide information about the header offsets inside of
>> the frame. However in the case of XDP we don't really have any of that
>> information since the data is minimally processed. As a result we were
>> seeing malicious driver detection (MDD) events being triggered when the PF
>> had that functionality enabled.
>>
>> To address this I have added a bit of new code that will "prime" the XDP
>> ring by providing one context descriptor that assumes the minimal setup of
>> an Ethernet frame which is an L2 header length of 14. With just that we
>> can
>> provide enough information to make the hardware happy so that we don't
>> trigger MDD events.
>>
>> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
>> ---
>>   drivers/net/ethernet/intel/ixgbevf/ixgbevf.h      |    1 +
>>   drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |   36
>> +++++++++++++++++----
>>   2 files changed, 30 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
>> b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
>> index 70c7568..56a1031 100644
>> --- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
>> +++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
>> @@ -76,6 +76,7 @@ enum ixgbevf_ring_state_t {
>>         __IXGBEVF_TX_DETECT_HANG,
>>         __IXGBEVF_HANG_CHECK_ARMED,
>>         __IXGBEVF_TX_XDP_RING,
>> +       __IXGBEVF_TX_XDP_RING_PRIMED,
>>   };
>>     #define ring_is_xdp(ring) \
>> diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
>> b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
>> index c298614..e2a8a03 100644
>> --- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
>> +++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
>> @@ -991,24 +991,45 @@ static int ixgbevf_xmit_xdp_ring(struct ixgbevf_ring
>> *ring,
>>                 return IXGBEVF_XDP_CONSUMED;
>>         /* record the location of the first descriptor for this packet */
>> -       tx_buffer = &ring->tx_buffer_info[ring->next_to_use];
>> -       tx_buffer->bytecount = len;
>> -       tx_buffer->gso_segs = 1;
>> -       tx_buffer->protocol = 0;
>> -
>>         i = ring->next_to_use;
>> -       tx_desc = IXGBEVF_TX_DESC(ring, i);
>> +       tx_buffer = &ring->tx_buffer_info[i];
>>         dma_unmap_len_set(tx_buffer, len, len);
>>         dma_unmap_addr_set(tx_buffer, dma, dma);
>>         tx_buffer->data = xdp->data;
>> -       tx_desc->read.buffer_addr = cpu_to_le64(dma);
>> +       tx_buffer->bytecount = len;
>> +       tx_buffer->gso_segs = 1;
>> +       tx_buffer->protocol = 0;
>> +
>> +       /* Populate minimal context descriptor that will provide for the
>> +        * fact that we are expected to process Ethernet frames.
>> +        */
>> +       if (!test_bit(__IXGBEVF_TX_XDP_RING_PRIMED, &ring->state)) {
>> +               struct ixgbe_adv_tx_context_desc *context_desc;
>> +
>> +               set_bit(__IXGBEVF_TX_XDP_RING_PRIMED, &ring->state);
>> +
>> +               context_desc = IXGBEVF_TX_CTXTDESC(ring, 0);
>> +               context_desc->vlan_macip_lens   =
>> +                       cpu_to_le32(ETH_HLEN <<
>> IXGBE_ADVTXD_MACLEN_SHIFT);
>> +               context_desc->seqnum_seed       = 0;
>> +               context_desc->type_tucmd_mlhl   =
>> +                       cpu_to_le32(IXGBE_TXD_CMD_DEXT |
>> +                                   IXGBE_ADVTXD_DTYP_CTXT);
>> +               context_desc->mss_l4len_idx     = 0;
>> +
>> +               i = 1;
>
>
> This setting of i looks odd to me.  If i is the index of the next Tx
> descriptor to be used, why are hard coding it to 1 here?  If this bit of
> code is only run the first time after the ring has been configured, then
> next_to_use was 0, and the data is in tx_buffer_info[0], but now tx_desc[1]
> will be filled in?  Or am I misreading this?
>
> sln

No, you are reading this correctly.

We populate tx_buffer_info[0], populate tx_desc[0] with the context
descriptor, and tx_desc[1] with the data descriptor. This only happens
for the first packet placed in the ring so we can just bump the
tx_desc reference directly to 1 in this case since we will always know
that next_to_use will be 0.

We actually do this kind of thing in the normal transmit path,
although there we reference the first tx_buffer_info structure via the
"first" pointer.

Thanks.

- Alex
