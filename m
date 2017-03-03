From: John Fastabend <john.fastabend@gmail.com>
Date: Fri, 3 Mar 2017 08:23:30 -0800
Subject: [Intel-wired-lan] [net-next PATCH v2 1/3] ixgbe: add XDP
 support for pass and drop actions
In-Reply-To: <CAKgT0UdoHK-5=pXHGcgbSp5zFSzHuSwiqY=5B2czjkLbN4KuQA@mail.gmail.com>
References: <20170302005417.30505.14047.stgit@john-Precision-Tower-5810>
 <CAKgT0UdoHK-5=pXHGcgbSp5zFSzHuSwiqY=5B2czjkLbN4KuQA@mail.gmail.com>
Message-ID: <58B99882.4080104@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 17-03-02 08:22 AM, Alexander Duyck wrote:
> On Wed, Mar 1, 2017 at 4:54 PM, John Fastabend <john.fastabend@gmail.com> wrote:
>> Basic XDP drop support for ixgbe. Uses READ_ONCE/xchg semantics on XDP
>> programs instead of rcu primitives as suggested by Daniel Borkmann and
>> Alex Duyck.
>>
>> Signed-off-by: John Fastabend <john.r.fastabend@intel.com>
> 
> So it still looks like this is doing a bunch of hacking in the Rx
> path.  I suggested a few items below to streamline this.
> 
>> ---
>>  drivers/net/ethernet/intel/ixgbe/ixgbe.h      |    2
>>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  114 ++++++++++++++++++++++++-
>>  2 files changed, 113 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
>> index b812913..2d12c24 100644
>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
>> @@ -273,6 +273,7 @@ struct ixgbe_ring {
>>         struct ixgbe_ring *next;        /* pointer to next ring in q_vector */
>>         struct ixgbe_q_vector *q_vector; /* backpointer to host q_vector */
>>         struct net_device *netdev;      /* netdev ring belongs to */
>> +       struct bpf_prog *xdp_prog;
>>         struct device *dev;             /* device for DMA mapping */
>>         struct ixgbe_fwd_adapter *l2_accel_priv;
>>         void *desc;                     /* descriptor ring memory */
>> @@ -510,6 +511,7 @@ struct ixgbe_adapter {
>>         unsigned long active_vlans[BITS_TO_LONGS(VLAN_N_VID)];
>>         /* OS defined structs */
>>         struct net_device *netdev;
>> +       struct bpf_prog *xdp_prog;
>>         struct pci_dev *pdev;
>>
>>         unsigned long state;
>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> index e3da397..0b802b5 100644
>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> @@ -49,6 +49,9 @@
>>  #include <linux/if_macvlan.h>
>>  #include <linux/if_bridge.h>
>>  #include <linux/prefetch.h>
>> +#include <linux/bpf.h>
>> +#include <linux/bpf_trace.h>
>> +#include <linux/atomic.h>
>>  #include <scsi/fc/fc_fcoe.h>
>>  #include <net/udp_tunnel.h>
>>  #include <net/pkt_cls.h>
>> @@ -2051,7 +2054,7 @@ static void ixgbe_put_rx_buffer(struct ixgbe_ring *rx_ring,
>>                 /* hand second half of page back to the ring */
>>                 ixgbe_reuse_rx_page(rx_ring, rx_buffer);
>>         } else {
>> -               if (IXGBE_CB(skb)->dma == rx_buffer->dma) {
>> +               if (skb && IXGBE_CB(skb)->dma == rx_buffer->dma) {
>>                         /* the page has been released from the ring */
>>                         IXGBE_CB(skb)->page_released = true;
>>                 } else {
> 
> So you can probably change this to "if (!IS_ERR(skb) &&
> IXGBE_CB(skb)->dma == rx_buffer->dma) {" more on why below.
> 

OK I will go with this. I think using 'int consumed' is a bit easier to read for
folks not overly familiar with the driver, but I get the point it removes some
special cases.

should have a v3 shortly.

[...]

>> @@ -2207,6 +2255,18 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
>>
>>                 rx_buffer = ixgbe_get_rx_buffer(rx_ring, rx_desc, &skb, size);
>>
>> +               consumed = ixgbe_run_xdp(rx_ring, rx_buffer, size);
>> +               rcu_read_unlock();
>> +
> 
> Did you leave an rcu_read_unlock here?  I'm assuming you meant to drop this.
> 

ugh patch sequence error its fixed in v2 as you note.

>> +               if (consumed) {
>> +                       ixgbe_put_rx_buffer(rx_ring, rx_buffer, skb);
>> +                       cleaned_count++;
>> +                       ixgbe_is_non_eop(rx_ring, rx_desc, skb);
>> +                       total_rx_packets++;
>> +                       total_rx_bytes += size;
>> +                       continue;
>> +               }
>> +
> 
> Looks like this wasn't adding one back to the pagecnt_bias.  That
> would trigger a memory leak.
> 

It is done in the ixgbe_run_xdp path. Perhaps its better to do here.

[...]

>>                         ixgbe_add_rx_frag(rx_ring, rx_buffer, skb, size);
>> @@ -6121,9 +6181,13 @@ static int ixgbe_setup_all_rx_resources(struct ixgbe_adapter *adapter)
>>         int i, err = 0;
>>
>>         for (i = 0; i < adapter->num_rx_queues; i++) {
>> -               err = ixgbe_setup_rx_resources(adapter->rx_ring[i]);
>> -               if (!err)
>> +               struct ixgbe_ring *rx_ring = adapter->rx_ring[i];
>> +
>> +               err = ixgbe_setup_rx_resources(rx_ring);
>> +               if (!err) {
>> +                       xchg(&rx_ring->xdp_prog, adapter->xdp_prog);
>>                         continue;
>> +               }
>>

Sure done.

>>                 e_err(probe, "Allocation for Rx Queue %u failed\n", i);
>>                 goto err_setup_rx;
> 
> I still think it makes more sense to just place this in
> ixgbe_setup_rx_resources.  No point in putting here as it just adds
> more complication.
> 
> If I am not mistaken all you would have to add is the xchg line and
> that would be it.
> 
>> @@ -6191,6 +6255,7 @@ void ixgbe_free_rx_resources(struct ixgbe_ring *rx_ring)
>>
>>         vfree(rx_ring->rx_buffer_info);
>>         rx_ring->rx_buffer_info = NULL;
>> +       xchg(&rx_ring->xdp_prog, NULL);
>>
>>         /* if not set, then don't free */
>>         if (!rx_ring->desc)
> 
> Just for the sake of symmetry I would suggest placing the xchg in
> front of the vfree.  Also this code being here makes a stronger
> argument for us setting up xdp in setup_rx_resources.
> 

done.


Thanks,
John

