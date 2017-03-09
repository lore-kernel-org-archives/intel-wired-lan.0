From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 9 Mar 2017 13:35:23 -0800
Subject: [Intel-wired-lan] [net-next PATCH v3 1/3] ixgbe: add XDP
	support for pass and drop actions
In-Reply-To: <58C183E3.7000300@gmail.com>
References: <20170303175526.25015.12183.stgit@john-Precision-Tower-5810>
 <20170303175703.25015.13873.stgit@john-Precision-Tower-5810>
 <CAKgT0Uce50xKSYvVdnZxFeKyPoNtUF=kzguMOascwvev5ue5Lw@mail.gmail.com>
 <58C183E3.7000300@gmail.com>
Message-ID: <CAKgT0UdddqjrmypG0PeZODFxSzLWGyC1M8PP0JmrHL3vE3XwxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Mar 9, 2017 at 8:33 AM, John Fastabend <john.fastabend@gmail.com> wrote:
> On 17-03-03 12:55 PM, Alexander Duyck wrote:
>> On Fri, Mar 3, 2017 at 9:57 AM, John Fastabend <john.fastabend@gmail.com> wrote:
>>> Basic XDP drop support for ixgbe. Uses READ_ONCE/xchg semantics on XDP
>>> programs instead of rcu primitives as suggested by Daniel Borkmann and
>>> Alex Duyck.
>>>
>>> Signed-off-by: John Fastabend <john.r.fastabend@intel.com>
>>> ---
>>>  drivers/net/ethernet/intel/ixgbe/ixgbe.h         |    4 +
>>>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |    4 -
>>>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    |  123 +++++++++++++++++++++-
>>>  3 files changed, 120 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
>>> index b812913..6eaf506 100644
>
> [...]
>
> I'll fix style comments in next version.
>
>>>                 if (!skb) {
>>> @@ -6061,7 +6120,8 @@ static int ixgbe_setup_all_tx_resources(struct ixgbe_adapter *adapter)
>>>   *
>>>   * Returns 0 on success, negative on failure
>>>   **/
>>> -int ixgbe_setup_rx_resources(struct ixgbe_ring *rx_ring)
>>> +int ixgbe_setup_rx_resources(struct ixgbe_adapter *adapter,
>>> +                            struct ixgbe_ring *rx_ring)
>>>  {
>>>         struct device *dev = rx_ring->dev;
>>>         int orig_node = dev_to_node(dev);
>>> @@ -6098,6 +6158,8 @@ int ixgbe_setup_rx_resources(struct ixgbe_ring *rx_ring)
>>>         rx_ring->next_to_clean = 0;
>>>         rx_ring->next_to_use = 0;
>>>
>>> +       xchg(&rx_ring->xdp_prog, adapter->xdp_prog);
>>> +
>>>         return 0;
>>>  err:
>>>         vfree(rx_ring->rx_buffer_info);
>>
>> It occurs to me that I am not sure we even need the xchg here.  This
>> should be protected by an the rtnl lock anyway.  So I don't think we
>> need the xchg unless XDP can update things outside the rtnl lock which
>> if it can we have other issues since adapter->xdp_prog could then be
>> updated while this is going on.
>>
>>> @@ -6121,10 +6183,11 @@ static int ixgbe_setup_all_rx_resources(struct ixgbe_adapter *adapter)
>>>         int i, err = 0;
>>>
>>>         for (i = 0; i < adapter->num_rx_queues; i++) {
>>> -               err = ixgbe_setup_rx_resources(adapter->rx_ring[i]);
>>> +               struct ixgbe_ring *rx_ring = adapter->rx_ring[i];
>>> +
>>> +               err = ixgbe_setup_rx_resources(adapter, rx_ring);
>>>                 if (!err)
>>>                         continue;
>>> -
>>
>> There is a bunch of noise here.  Don't bother modifying white space,
>> just add the adapter reference to the function call.   It will still
>> be below 80 characters anyway.
>>
>>>                 e_err(probe, "Allocation for Rx Queue %u failed\n", i);
>>>                 goto err_setup_rx;
>>>         }
>>> @@ -6189,6 +6252,7 @@ void ixgbe_free_rx_resources(struct ixgbe_ring *rx_ring)
>>>  {
>>>         ixgbe_clean_rx_ring(rx_ring);
>>>
>>> +       xchg(&rx_ring->xdp_prog, NULL);
>>>         vfree(rx_ring->rx_buffer_info);
>>>         rx_ring->rx_buffer_info = NULL;
>>>
>>
>> Same question that I had for the other xchg.  Do we even need it?  The
>> NAPI polling routine should already be unregistered since we are
>> freeing rings at this point.  Odds are we can probably just assign
>> NULL as a value and skip the xchg assuming all callers of this
>> function are holding the rtnl.
>>
>
> As long as we can guarantee the ring is down and no traffic is being received
> then the xchg is not needed. In both of the above cases.

Even if we were passing traffic I don't think the xchg is needed.  It
is only really needed if we want to pull the value out.  If you look
through the RCU code we do a lot of the initialization stuff by just
assigning a NULL pointer since assignment of a pointer is usually an
atomic operation anyway.

- Alex
