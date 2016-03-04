From: Samudrala, Sridhar <sridhar.samudrala@intel.com>
Date: Fri, 04 Mar 2016 15:07:03 -0800
Subject: [Intel-wired-lan] [PATCH net-next] net: ixgbe: Fix cls_u32
 offload support for ports and fields with masks.
In-Reply-To: <56DA0AB5.9030602@gmail.com>
References: <1457120869-3489-1-git-send-email-sridhar.samudrala@intel.com>
 <56D9F311.7060402@gmail.com> <56D9FDAC.6060607@intel.com>
 <56DA0AB5.9030602@gmail.com>
Message-ID: <56DA1517.7020307@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 3/4/2016 2:22 PM, John Fastabend wrote:
> On 16-03-04 01:27 PM, Samudrala, Sridhar wrote:
>> On 3/4/2016 12:41 PM, John Fastabend wrote:
>>> On 16-03-04 11:47 AM, Sridhar Samudrala wrote:
>>>> Fix support for 16 bit source/dest port matches in ixgbe model.
>>>> u32 uses a single 32-bit key value for both source and destination ports
>>>> starting at offset 0. So replace the 2 functions with a single function
>>>> that takes this key value/mask to program both source and dest ports.
>>>>
>>>> Remove the incorrect check for mask in ixgbe_configure_clsu32()
>>>>
>>>> Tested with the following filters:
>>>>
>>>>    #tc qdisc add dev p4p1 ingress
>>>>    #tc filter add dev p4p1 parent ffff: protocol ip prio 99 \
>>>>      handle 800:0:1 u32 ht 800: \
>>>>      match ip dst 11.0.0.1/24 match ip src 11.0.0.2/24 action drop
>>>>
>>>>    #tc filter del dev p4p1 parent ffff: protocol ip prio 99 \
>>>>      handle 800:0:1 u32
>>>>    #tc filter add dev p4p1 parent ffff: protocol ip prio 99 \
>>>>      handle 1: u32 divisor 1
>>>>    #tc filter add dev p4p1 parent ffff: protocol ip prio 99 \
>>>>      handle 800:0:10 u32 ht 800: link 1: \
>>>>      offset at 0 mask 0f00 shift 6 plus 0 eat match ip protocol 6 ff
>>>>    #tc filter add dev p4p1 parent ffff: protocol ip prio 99 \
>>>>      handle 1:0:10 u32 ht 1: \
>>>>      match tcp src 1024 ffff match tcp dst 80 ffff action drop
>>>>
>>>> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
>>>> ---
>>> But this will break setting only dst port or only src port.
>> No. This will not break specifying only src or dst port. The value/mask
>> for the
>> unspecified port will be set to zero. So it should be fine.
>>
>> For ex:
>>      match tcp src 1024 ffff match tcp dst 80 ffff
>>          => match 04000050/ffffffff at nexthdr+0
>>      match tcp src 1024 ffff
>>          => match 04000000/ffff0000 at nexthdr+0
>>      match tcp dst 80 ffff
>>          => match 00000050/0000ffff at nexthdr+0
>>
>>
>>>    Do we
>>> actually need three signatures to match? Something like,
>>>
>>>     static struct ixgbe_mat_field ixgbe_tcp_fields[] = {
>>>      {.off = 0, .mask = 0xffffffff, .val = ixgbe_mat_prgm_ports,
>>>          .type = IXGBE_ATR_FLOW_TYPE_TCPV4},
>>>      {.off = 0, .mask = 0xffff0000, .val = ixgbe_mat_prgm_dport,
>>>          .type = IXGBE_ATR_FLOW_TYPE_TCPV4},
>>>      {.off = 0, .mask = 0x0000ffff, .val = ixgbe_mat_prgm_sport,
>>>          .type = IXGBE_ATR_FLOW_TYPE_TCPV4},
>>>         { .val = NULL } /* terminal node */
>>>     };
>>>
>>> Also just a reminder if we get multiple fields in a ixgbe_mat_field
>>> struct we need to abort out of the for loop in the cls_u32 configure
>>> function. Actually we can probably just push that as its own patch
>>> to make the core function more versatile/usable.
>>>
>>> Thanks,
>>> John
> Dropped netdev no reason to push mail to netdev that has to do with our
> driver internals.
>
> OK I see so you dropped the .mask check in fact you actually put it
> there in the commit message I just missed the detail/implication.
>
> I think this is fine and it allows supporting mask entries now which
> I blocked in the initial submission. But with this is there any reason
> to have a mask field in ixgbe_mat_field? We could probably do this with
> two patches, one to drop the 'mask' field and check and another to fix
> the ixgbe_tcp_fields patch?

OK. will remove the 'mask' field and resubmit as 2 patches.

Thanks
Sridhar
