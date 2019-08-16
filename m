From: Jonathan Lemon <jonathan.lemon@gmail.com>
Date: Fri, 16 Aug 2019 15:08:34 -0700
Subject: [Intel-wired-lan] [PATCH bpf-next 0/5] Add support for SKIP_BPF
 flag for AF_XDP sockets
In-Reply-To: <CAJ+HfNj=devuEky3VwbibA-j+o=bKi4Gg=MeHsuuDGAKc9p2Vw@mail.gmail.com>
References: <1565840783-8269-1-git-send-email-sridhar.samudrala@intel.com>
 <bebfb097-5357-91d8-ebc7-2f8ede392ad7@intel.com>
 <cc3a09eb-bcb8-a6e1-7175-77bddaf10c11@intel.com>
 <CAJ+HfNj=devuEky3VwbibA-j+o=bKi4Gg=MeHsuuDGAKc9p2Vw@mail.gmail.com>
Message-ID: <331CAEDB-776A-4928-93EF-F45F1339848F@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 16 Aug 2019, at 6:32, Bj?rn T?pel wrote:

> On Thu, 15 Aug 2019 at 18:46, Samudrala, Sridhar
> <sridhar.samudrala@intel.com> wrote:
>>
>> On 8/15/2019 5:51 AM, Bj?rn T?pel wrote:
>>> On 2019-08-15 05:46, Sridhar Samudrala wrote:
>>>> This patch series introduces XDP_SKIP_BPF flag that can be 
>>>> specified
>>>> during the bind() call of an AF_XDP socket to skip calling the BPF
>>>> program in the receive path and pass the buffer directly to the 
>>>> socket.
>>>>
>>>> When a single AF_XDP socket is associated with a queue and a HW
>>>> filter is used to redirect the packets and the app is interested in
>>>> receiving all the packets on that queue, we don't need an 
>>>> additional
>>>> BPF program to do further filtering or lookup/redirect to a socket.
>>>>
>>>> Here are some performance numbers collected on
>>>>    - 2 socket 28 core Intel(R) Xeon(R) Platinum 8180 CPU @ 2.50GHz
>>>>    - Intel 40Gb Ethernet NIC (i40e)
>>>>
>>>> All tests use 2 cores and the results are in Mpps.
>>>>
>>>> turbo on (default)
>>>> ---------------------------------------------
>>>>                        no-skip-bpf    skip-bpf
>>>> ---------------------------------------------
>>>> rxdrop zerocopy           21.9         38.5
>>>> l2fwd  zerocopy           17.0         20.5
>>>> rxdrop copy               11.1         13.3
>>>> l2fwd  copy                1.9          2.0
>>>>
>>>> no turbo :  echo 1 > /sys/devices/system/cpu/intel_pstate/no_turbo
>>>> ---------------------------------------------
>>>>                        no-skip-bpf    skip-bpf
>>>> ---------------------------------------------
>>>> rxdrop zerocopy           15.4         29.0
>>>> l2fwd  zerocopy           11.8         18.2
>>>> rxdrop copy                8.2         10.5
>>>> l2fwd  copy                1.7          1.7
>>>> ---------------------------------------------
>>>>
>>>
>>> This work is somewhat similar to the XDP_ATTACH work [1]. Avoiding 
>>> the
>>> retpoline in the XDP program call is a nice performance boost! I 
>>> like
>>> the numbers! :-) I also like the idea of adding a flag that just 
>>> does
>>> what most AF_XDP Rx users want -- just getting all packets of a
>>> certain queue into the XDP sockets.
>>>
>>> In addition to Toke's mail, I have some more concerns with the 
>>> series:
>>>
>>> * AFAIU the SKIP_BPF only works for zero-copy enabled sockets. IMO, 
>>> it
>>>    should work for all modes (including XDP_SKB).
>>
>> This patch enables SKIP_BPF for AF_XDP sockets where an XDP program 
>> is
>> attached at driver level (both zerocopy and copy modes)
>> I tried a quick hack to see the perf benefit with generic XDP mode, 
>> but
>> i didn't see any significant improvement in performance in that
>> scenario. so i didn't include that mode.
>>
>>>
>>> * In order to work, a user still needs an XDP program running. 
>>> That's
>>>    clunky. I'd like the behavior that if no XDP program is attached,
>>>    and the option is set, the packets for a that queue end up in the
>>>    socket. If there's an XDP program attached, the program has
>>>    precedence.
>>
>> I think this would require more changes in the drivers to take XDP
>> datapath even when there is no XDP program loaded.
>>
>
> Today, from a driver perspective, to enable XDP you pass a struct
> bpf_prog pointer via the ndo_bpf. The program get executed in
> BPF_PROG_RUN (via bpf_prog_run_xdp) from include/linux/filter.h.
>
> I think it's possible to achieve what you're doing w/o *any* driver
> modification. Pass a special, invalid, pointer to the driver (say
> (void *)0x1 or smth more elegant), which has a special handling in
> BPF_RUN_PROG e.g. setting a per-cpu state and return XDP_REDIRECT. The
> per-cpu state is picked up in xdp_do_redirect and xdp_flush.
>
> An approach like this would be general, and apply to all modes
> automatically.
>
> Thoughts?

All the default program does is check that the map entry contains a xsk,
and call bpf_redirect_map().  So this is pretty much the same as above,
without any special case handling.

Why would this be so expensive?  Is the JIT compilation time being 
counted?
-- 
Jonathan

>
>>>
>>> * It requires changes in all drivers. Not nice, and scales badly. 
>>> Try
>>>    making it generic (xdp_do_redirect/xdp_flush), so it Just Works 
>>> for
>>>    all XDP capable drivers.
>>
>> I tried to make this as generic as possible and make the changes to 
>> the
>> driver very minimal, but could not find a way to avoid any changes at
>> all to the driver. xdp_do_direct() gets called based after the call 
>> to
>> bpf_prog_run_xdp() in the drivers.
>>
>>>
>>> Thanks for working on this!
>>>
>>>
>>> Bj?rn
>>>
>>> [1]
>>> https://lore.kernel.org/netdev/20181207114431.18038-1-bjorn.topel at gmail.com/
>>>
>>>
>>>
>>>> Sridhar Samudrala (5):
>>>>    xsk: Convert bool 'zc' field in struct xdp_umem to a u32 bitmap
>>>>    xsk: Introduce XDP_SKIP_BPF bind option
>>>>    i40e: Enable XDP_SKIP_BPF option for AF_XDP sockets
>>>>    ixgbe: Enable XDP_SKIP_BPF option for AF_XDP sockets
>>>>    xdpsock_user: Add skip_bpf option
>>>>
>>>>   drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 22 +++++++++-
>>>>   drivers/net/ethernet/intel/i40e/i40e_xsk.c    |  6 +++
>>>>   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 20 ++++++++-
>>>>   drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c  | 16 ++++++-
>>>>   include/net/xdp_sock.h                        | 21 ++++++++-
>>>>   include/uapi/linux/if_xdp.h                   |  1 +
>>>>   include/uapi/linux/xdp_diag.h                 |  1 +
>>>>   net/xdp/xdp_umem.c                            |  9 ++--
>>>>   net/xdp/xsk.c                                 | 43 
>>>> ++++++++++++++++---
>>>>   net/xdp/xsk_diag.c                            |  5 ++-
>>>>   samples/bpf/xdpsock_user.c                    |  8 ++++
>>>>   11 files changed, 135 insertions(+), 17 deletions(-)
>>>>
>> _______________________________________________
>> Intel-wired-lan mailing list
>> Intel-wired-lan at osuosl.org
>> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
