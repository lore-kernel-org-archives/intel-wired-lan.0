From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@intel.com>
Date: Wed, 19 Aug 2020 10:31:02 +0200
Subject: [Intel-wired-lan] 
 =?utf-8?b?562U5aSNOiDnrZTlpI06ICBbUEFUQ0ggMC8y?=
 =?utf-8?q?=5D_intel/xdp_fixes_for_fliping_rx_buffer?=
In-Reply-To: <c3695fc71ca140d08a795bbd32d8522f@baidu.com>
References: <1594967062-20674-1-git-send-email-lirongqing@baidu.com>
 <CAJ+HfNi2B+2KYP9A7yCfFUhfUBd=sFPeuGbNZMjhNSdq3GEpMg@mail.gmail.com>
 <4268316b200049d58b9973ec4dc4725c@baidu.com>
 <83e45ec2-1c66-59f6-e817-d4c523879007@intel.com>
 <c3695fc71ca140d08a795bbd32d8522f@baidu.com>
Message-ID: <c691e3d2-8b16-744c-8918-5be042bd37dc@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2020-08-19 10:17, Li,Rongqing wrote:
> 
> 
>> -----????-----
>> ???: Bj?rn T?pel [mailto:bjorn.topel at intel.com]
>> ????: 2020?8?19? 14:45
>> ???: Li,Rongqing <lirongqing@baidu.com>; Bj?rn T?pel
>> <bjorn.topel@gmail.com>
>> ??: Netdev <netdev@vger.kernel.org>; intel-wired-lan
>> <intel-wired-lan@lists.osuosl.org>; Karlsson, Magnus
>> <magnus.karlsson@intel.com>; bpf <bpf@vger.kernel.org>; Maciej Fijalkowski
>> <maciej.fijalkowski@intel.com>; Piotr <piotr.raczynski@intel.com>; Maciej
>> <maciej.machnikowski@intel.com>
>> ??: Re: ??: [Intel-wired-lan] [PATCH 0/2] intel/xdp fixes for fliping rx buffer
>>
>> On 2020-08-19 03:37, Li,Rongqing wrote:
>> [...]
>>   > Hi:
>>   >
>>   > Thanks for your explanation.
>>   >
>>   > But we can reproduce this bug
>>   >
>>   > We use ebpf to redirect only-Vxlan packets to non-zerocopy AF_XDP, First we
>> see panic on tcp stack, in tcp_collapse: BUG_ON(offset < 0); it is very hard to
>> reproduce.
>>   >
>>   > Then we use the scp to do test, and has lots of vxlan packet at the same
>> time, scp will be broken frequently.
>>   >
>>
>> Ok! Just so that I'm certain of your setup. You receive packets to an i40e netdev
>> where there's an XDP program. The program does XDP_PASS or XDP_REDIRECT
>> to e.g. devmap for non-vxlan packets. However, vxlan packets are redirected to
>> AF_XDP socket(s) in *copy-mode*. Am I understanding that correct?
>>
> Similar as your description,
> 
> but the xdp program only redirects vxlan packets to af_xdp socket, other packets will go to Linux kernel networking stack, like scp/ssh packets
> 
> 
>> I'm assuming this is an x86-64 with 4k page size, right? :-) The page flipping is a
>> bit different if the PAGE_SIZE is not 4k.
>>
> 
> We use 4k page size, page flipping is 4k, we did not change the i40e drivers, 4.19 stable kernel
>

Would you mind testing on a newer kernel? Say the latest stable 5.8.2?


>>   > With this fixes, scp has not been broken again, and kernel is not panic
>> again  >
>>
>> Let's dig into your scenario.
>>
>> Are you saying the following:
>>
>> Page A:
>> +------------
>> | "first skb" ----> Rx HW ring entry X
>> +------------
>> | "second skb"----> Rx HW ring entry X+1 (or X+n)
>> +------------
>>
> 
> Like:
> 
> First skb will be into tcp socket rx queue
> 
> Seconds skb is vxlan packet, will be copy to af_xdp socket, and released.
> 
>> This is a scenario that shouldn't be allowed, because there are now two users
>> of the page. If that's the case, the refcounting is broken. Is that the case?
>>
> 
> True, it is broken for copy mode xsk
>

Ok. However, the fix is not avoiding the page_frag_free, but finding and 
fixing the refcount bug. I'll have a deeper look.

But please, try to reproduce with a newer kernel.


Thanks,
Bj?rn
