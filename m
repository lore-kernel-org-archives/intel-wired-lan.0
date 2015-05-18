From: John Fastabend <john.fastabend@gmail.com>
Date: Mon, 18 May 2015 08:22:57 -0700
Subject: [Intel-wired-lan] [net-next PATCH v2] ixgbe: Allow flow
 director to use entire queue space
In-Reply-To: <5554F620.4090101@gmail.com>
References: <20150514163616.14473.66892.stgit@nitbit.x32>
 <5554E1F8.1050704@gmail.com> <5554E3F3.2090709@intel.com>
 <5554F620.4090101@gmail.com>
Message-ID: <555A03D1.1070505@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 05/14/2015 12:23 PM, Alexander Duyck wrote:
> On 05/14/2015 11:05 AM, John Fastabend wrote:
>> On 05/14/2015 10:57 AM, Alexander Duyck wrote:
>>> On 05/14/2015 09:36 AM, John Fastabend wrote:
>>>> Flow director is exported to user space using the ethtool ntuple
>>>> support. However, currently it only supports steering traffic to a
>>>> subset of the queues in use by the hardware. This change allows
>>>> flow director to specify queues that have been assigned to virtual
>>>> functions by partitioning the ring_cookie into a 8bit vf specifier
>>>> followed by 32bit queue index. At the moment we don't have any
>>>> ethernet drivers with more than 2^32 queues on a single function
>>>> as best I can tell and nor do I expect this to happen anytime
>>>> soon. This way the ring_cookie's normal use for specifying a queue
>>>> on a specific PCI function continues to work as expected.
>>>>
>>>> Signed-off-by: John Fastabend <john.r.fastabend@intel.com>
>>>> ---
>>>>    drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |   32

[...]

>>> All of the code below this point should really be a separate patch.
>>> vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
>> Really? I think it is likely fine to have this all in one patch.
>
> The general idea is that you don't want to tie driver changes that
> closely to API changes.  It makes it easier for those of us that are
> stuck doing things like backporting functionality into stable kernels.
> So if for example another vendor decides to make use of the same
> functionality you don't necessarily have to backport changes to ixgbe in
> order to get the flow spec changes.

You would backport one vendors feature but not another? Anyways this is
a new feature so talking about backporting into stable kernels doesn't
make any sense. I think its a bit strange but I'll send it as two
patches if you want its trivial.

>
>>
>>>> diff --git a/include/uapi/linux/ethtool.h
>>>> b/include/uapi/linux/ethtool.h
>>>> index 2e49fc8..ecc658d 100644
>>>> --- a/include/uapi/linux/ethtool.h
>>>> +++ b/include/uapi/linux/ethtool.h
>>>> @@ -796,6 +796,26 @@ struct ethtool_rx_flow_spec {
>>>>        __u32        location;
>>>>    };
>>>>
>>>> +/* How rings are layed out when accessing virtual functions or
>>>> + * offloaded queues is device specific. To allow users to flow
>>>> + * steering and specify these queues though break the ring cookie
>>>> + * into a 32bit queue index with an 8 bit virtual function id.
>>>> + * This also leaves the 3bytes for further specifiers.
>>>> + */
>>>> +#define ETHTOOL_RX_FLOW_SPEC_RING    0x00000000FFFFFFFF
>>> The question I would have about this is do we really need to support
>>> 4.3 billion rings, or should we maybe look at conserving some space
>>> by cutting this down to something like 24 or 16 bits?  I guess the
>>> question comes down to how many queues do we ever expect a single
>>> function to support?
>>>
>> We can always find holes later. Anyways if its larger than 2^32 the
>> net_device
>> will break.
>
> For now I would say 2^32 is fine since that is the upper limit on the
> netdev struct.  My concern is user-space lock in.  Once an API is set it
> is locked that is why I want to make sure we have covered all
> conceivable cases.

This flow director stuff is already very loose as far as an API goes.
The ring index is a "cookie" and its 64bits so I suspect the current
"API" is use it however you want. And its really unusable as a stable
cross device API at the moment anyways. Try writing a program to use
this stuff and you will quickly decide to rewrite it in netlink with
a proper API.

I happen to know many out of tree drivers are already overloading this
"cookie".

>
>>
>>>> +#define ETHTOOL_RX_FLOW_SPEC_RING_VF    0x000000FF00000000
>>>> +#define ETHTOOL_RX_FLOW_SPEC_RING_VF_OFF 32
>>> I'd say 256 is probably a bit low for the upper limit on VFs.  I know
>>> PCIe w/ ARI technically allows a 16b requester ID so you should
>>> probably bump this up to 16 bits.
>> Technically yes, but do you know of any ethernet devices that support
>> this? I
>> couldn't find any.
>
> I'm not thinking necessarily about right now, but what we might be asked
> to do.  I'm also thinking about user-space lock in again.  So for now
> with most of the market at only 10Gb/s we see an upper limit of
> something like 64 VFs, however when there is 100Gb/s who is to say that
> this won't be increased to something like 256 or 512.  At a minimum we
> probably want at least 12 bits since that will cover up to 4096
> functions which would require at least 16 busses worth of requester ID
> space.
>

VFs should scale with the number of cores I really see no reason to have
more virtual functions then cores at the moment.

I'm not a big fan of padding an interface for future proofing.

.John


-- 
John Fastabend         Intel Corporation
