From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@intel.com>
Date: Wed, 19 Aug 2020 08:44:32 +0200
Subject: [Intel-wired-lan] 
 =?utf-8?b?562U5aSNOiAgW1BBVENIIDAvMl0gaW50ZWwv?=
 =?utf-8?q?xdp_fixes_for_fliping_rx_buffer?=
In-Reply-To: <4268316b200049d58b9973ec4dc4725c@baidu.com>
References: <1594967062-20674-1-git-send-email-lirongqing@baidu.com>
 <CAJ+HfNi2B+2KYP9A7yCfFUhfUBd=sFPeuGbNZMjhNSdq3GEpMg@mail.gmail.com>
 <4268316b200049d58b9973ec4dc4725c@baidu.com>
Message-ID: <83e45ec2-1c66-59f6-e817-d4c523879007@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2020-08-19 03:37, Li,Rongqing wrote:
[...]
 > Hi:
 >
 > Thanks for your explanation.
 >
 > But we can reproduce this bug
 >
 > We use ebpf to redirect only-Vxlan packets to non-zerocopy AF_XDP, 
First we see panic on tcp stack, in tcp_collapse: BUG_ON(offset < 0); it 
is very hard to reproduce.
 >
 > Then we use the scp to do test, and has lots of vxlan packet at the 
same time, scp will be broken frequently.
 >

Ok! Just so that I'm certain of your setup. You receive packets to an
i40e netdev where there's an XDP program. The program does XDP_PASS or
XDP_REDIRECT to e.g. devmap for non-vxlan packets. However, vxlan
packets are redirected to AF_XDP socket(s) in *copy-mode*. Am I
understanding that correct?

I'm assuming this is an x86-64 with 4k page size, right? :-) The page
flipping is a bit different if the PAGE_SIZE is not 4k.

 > With this fixes, scp has not been broken again, and kernel is not 
panic again
 >

Let's dig into your scenario.

Are you saying the following:

Page A:
+------------
| "first skb" ----> Rx HW ring entry X
+------------
| "second skb"----> Rx HW ring entry X+1 (or X+n)
+------------

This is a scenario that shouldn't be allowed, because there are now
two users of the page. If that's the case, the refcounting is
broken. Is that the case?

Check out i40e_can_reuse_rx_page(). The idea with page flipping/reuse
is that the page is only reused if there is only one user.

 > Seem your explanation is unable to solve my analysis:
 >
 >         1. first skb is not for xsk, and forwarded to another device
 >            or socket queue

The data for the "first skb" resides on a page:
A:
+------------
| "first skb"
+------------
| to be reused
+------------
refcount >>1

 >         2. seconds skb is for xsk, copy data to xsk memory, and page
 >            of skb->data is released

Note that page B != page A.

B:
+------------
| to be reused/or used by the stack
+------------
| "second skb for xsk"
+------------
refcount >>1

data is copied to socket, page_frag_free() is called, and the page
count is decreased. The driver will then check if the page can be
reused. If not, it's freed to the page allocator.

 >         3. rx_buff is reusable since only first skb is in it, but
 >            *_rx_buffer_flip will make that page_offset is set to
 >            first skb data

I'm having trouble grasping how this is possible. More than one user
implies that it wont be reused. If this is possible, the
recounting/reuse mechanism is broken, and that is what should be
fixed.

The AF_XDP redirect should not have semantics different from, say,
devmap redirect. It's just that the page_frag_free() is called earlier
for AF_XDP, instead of from i40e_clean_tx_irq() as the case for
devmap/XDP_TX.

 >         4. then reuse rx buffer, first skb which still is living
 >            will be corrupted.
 >
 >
 > The root cause is difference you said upper, so I only fixes for 
non-zerocopy AF_XDP
 >

I have only addressed non-zerocopy, so we're on the same page (pun
intended) here!


Bj?rn

 > -Li
