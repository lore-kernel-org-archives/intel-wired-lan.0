From: Ilya Maximets <i.maximets@samsung.com>
Date: Thu, 22 Aug 2019 19:30:13 +0300
Subject: [Intel-wired-lan] [PATCH net] ixgbe: fix double clean of tx
 descriptors with xdp
In-Reply-To: <CALDO+SaRNMvmXrQqOtNiRsOkgfOQAW4EA2yVgmeoGQto2zvfMQ@mail.gmail.com>
References: <CGME20190820151644eucas1p179d6d1da42bb6be0aad8f58ac46624ce@eucas1p1.samsung.com>
 <20190820151611.10727-1-i.maximets@samsung.com>
 <CAKgT0Udn0D0_f=SOH2wpBRWV_u4rb1Qe2h7gguXnRNzJ_VkRzg@mail.gmail.com>
 <625791af-c656-1e42-b60e-b3a5cedcb4c4@samsung.com>
 <CAKgT0Uc27+ucd=a_sgTmv5g7_+ZTg1zK4isYJ0H7YWQj3d=Ejg@mail.gmail.com>
 <f7d0f7a5-e664-8b72-99c7-63275aff4c18@samsung.com>
 <CAKgT0UcCKiM1Ys=vWxctprN7fzWcBCk-PCuKB-8=RThM=CqLSQ@mail.gmail.com>
 <CALDO+SZCbxEEwCS6MyHk-Cp_LJ33N=QFqwZ8uRm0e-PBRgxRYw@mail.gmail.com>
 <cbf7c51b-9ce7-6ef6-32c4-981258d4af4c@samsung.com>
 <CALDO+SaRNMvmXrQqOtNiRsOkgfOQAW4EA2yVgmeoGQto2zvfMQ@mail.gmail.com>
Message-ID: <5bcebb64-2bd8-902e-eebe-3a94f317b074@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 22.08.2019 19:07, William Tu wrote:
> On Thu, Aug 22, 2019 at 1:17 AM Ilya Maximets <i.maximets@samsung.com> wrote:
>>
>> On 22.08.2019 0:38, William Tu wrote:
>>> On Wed, Aug 21, 2019 at 9:57 AM Alexander Duyck
>>> <alexander.duyck@gmail.com> wrote:
>>>>
>>>> On Wed, Aug 21, 2019 at 9:22 AM Ilya Maximets <i.maximets@samsung.com> wrote:
>>>>>
>>>>> On 21.08.2019 4:17, Alexander Duyck wrote:
>>>>>> On Tue, Aug 20, 2019 at 8:58 AM Ilya Maximets <i.maximets@samsung.com> wrote:
>>>>>>>
>>>>>>> On 20.08.2019 18:35, Alexander Duyck wrote:
>>>>>>>> On Tue, Aug 20, 2019 at 8:18 AM Ilya Maximets <i.maximets@samsung.com> wrote:
>>>>>>>>>
>>>>>>>>> Tx code doesn't clear the descriptor status after cleaning.
>>>>>>>>> So, if the budget is larger than number of used elems in a ring, some
>>>>>>>>> descriptors will be accounted twice and xsk_umem_complete_tx will move
>>>>>>>>> prod_tail far beyond the prod_head breaking the comletion queue ring.
>>>>>>>>>
>>>>>>>>> Fix that by limiting the number of descriptors to clean by the number
>>>>>>>>> of used descriptors in the tx ring.
>>>>>>>>>
>>>>>>>>> Fixes: 8221c5eba8c1 ("ixgbe: add AF_XDP zero-copy Tx support")
>>>>>>>>> Signed-off-by: Ilya Maximets <i.maximets@samsung.com>
>>>>>>>>
>>>>>>>> I'm not sure this is the best way to go. My preference would be to
>>>>>>>> have something in the ring that would prevent us from racing which I
>>>>>>>> don't think this really addresses. I am pretty sure this code is safe
>>>>>>>> on x86 but I would be worried about weak ordered systems such as
>>>>>>>> PowerPC.
>>>>>>>>
>>>>>>>> It might make sense to look at adding the eop_desc logic like we have
>>>>>>>> in the regular path with a proper barrier before we write it and after
>>>>>>>> we read it. So for example we could hold of on writing the bytecount
>>>>>>>> value until the end of an iteration and call smp_wmb before we write
>>>>>>>> it. Then on the cleanup we could read it and if it is non-zero we take
>>>>>>>> an smp_rmb before proceeding further to process the Tx descriptor and
>>>>>>>> clearing the value. Otherwise this code is going to just keep popping
>>>>>>>> up with issues.
>>>>>>>
>>>>>>> But, unlike regular case, xdp zero-copy xmit and clean for particular
>>>>>>> tx ring always happens in the same NAPI context and even on the same
>>>>>>> CPU core.
>>>>>>>
>>>>>>> I saw the 'eop_desc' manipulations in regular case and yes, we could
>>>>>>> use 'next_to_watch' field just as a flag of descriptor existence,
>>>>>>> but it seems unnecessarily complicated. Am I missing something?
>>>>>>>
>>>>>>
>>>>>> So is it always in the same NAPI context?. I forgot, I was thinking
>>>>>> that somehow the socket could possibly make use of XDP for transmit.
>>>>>
>>>>> AF_XDP socket only triggers tx interrupt on ndo_xsk_async_xmit() which
>>>>> is used in zero-copy mode. Real xmit happens inside
>>>>> ixgbe_poll()
>>>>>  -> ixgbe_clean_xdp_tx_irq()
>>>>>     -> ixgbe_xmit_zc()
>>>>>
>>>>> This should be not possible to bound another XDP socket to the same netdev
>>>>> queue.
>>>>>
>>>>> It also possible to xmit frames in xdp_ring while performing XDP_TX/REDIRECT
>>>>> actions. REDIRECT could happen from different netdev with different NAPI
>>>>> context, but this operation is bound to specific CPU core and each core has
>>>>> its own xdp_ring.
>>>>>
>>>>> However, I'm not an expert here.
>>>>> Bj?rn, maybe you could comment on this?
>>>>>
>>>>>>
>>>>>> As far as the logic to use I would be good with just using a value you
>>>>>> are already setting such as the bytecount value. All that would need
>>>>>> to happen is to guarantee that the value is cleared in the Tx path. So
>>>>>> if you clear the bytecount in ixgbe_clean_xdp_tx_irq you could
>>>>>> theoretically just use that as well to flag that a descriptor has been
>>>>>> populated and is ready to be cleaned. Assuming the logic about this
>>>>>> all being in the same NAPI context anyway you wouldn't need to mess
>>>>>> with the barrier stuff I mentioned before.
>>>>>
>>>>> Checking the number of used descs, i.e. next_to_use - next_to_clean,
>>>>> makes iteration in this function logically equal to the iteration inside
>>>>> 'ixgbe_xsk_clean_tx_ring()'. Do you think we need to change the later
>>>>> function too to follow same 'bytecount' approach? I don't like having
>>>>> two different ways to determine number of used descriptors in the same file.
>>>>>
>>>>> Best regards, Ilya Maximets.
>>>>
>>>> As far as ixgbe_clean_xdp_tx_irq() vs ixgbe_xsk_clean_tx_ring(), I
>>>> would say that if you got rid of budget and framed things more like
>>>> how ixgbe_xsk_clean_tx_ring was framed with the ntc != ntu being
>>>> obvious I would prefer to see us go that route.
>>>>
>>>> Really there is no need for budget in ixgbe_clean_xdp_tx_irq() if you
>>>> are going to be working with a static ntu value since you will only
>>>> ever process one iteration through the ring anyway. It might make more
>>>> sense if you just went through and got rid of budget and i, and
>>>> instead used ntc and ntu like what was done in
>>>> ixgbe_xsk_clean_tx_ring().
>>>>
>>>> Thanks.
>>>>
>>>> - Alex
>>>
>>> Not familiar with the driver details.
>>> I tested this patch and the issue mentioned in OVS mailing list.
>>> https://www.mail-archive.com/ovs-dev at openvswitch.org/msg35362.html
>>> and indeed the problem goes away.
>>
>> Good. Thanks for testing!
>>
>>> But I saw a huge performance drop,
>>> my AF_XDP tx performance drops from >9Mpps to <5Mpps.
>>
>> I didn't expect so big performance difference with this change.
>> What is your test scenario?
> 
> I was using OVS with dual port NIC, setting one OpenFlow rule
> in_port=eth2 actions=output:eth3
> and eth2 for rx and measure eth3 tx
> 'sar -n DEV 1'  shows pretty huge drop on eth3 tx.

'sar' just parses net procfs to obtain interface stats, but interface stats
are not correct due to this bug (same packets accounted several times).

> 
>> Is it possible that you're accounting same
>> packet several times due to broken completion queue?
> 
> That's possible.
> Let me double check on your v2 patch.
> 
> @Eelco: do you also see some performance difference?
> 
> Regards,
> William
> 
>>
>> Looking at samples/bpf/xdpsock_user.c:complete_tx_only(), it accounts
>> sent packets (tx_npkts) by accumulating results of xsk_ring_cons__peek()
>> for completion queue, so it's not a trusted source of pps information.
>>
>> Best regards, Ilya Maximets.
>>
>>>
>>> Tested using kernel 5.3.0-rc3+
>>> 03:00.0 Ethernet controller: Intel Corporation Ethernet Controller
>>> 10-Gigabit X540-AT2 (rev 01)
>>> Subsystem: Intel Corporation Ethernet 10G 2P X540-t Adapter
>>> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>>> Stepping- SERR- FastB2B- DisINTx+
>>>
>>> Regards,
>>> William
> 
> 
