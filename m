From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Thu, 27 Aug 2020 01:25:38 -0700
Subject: [Intel-wired-lan] [PATCH] iavf: use kvzalloc instead of kzalloc
 for rx/tx_bi buffer
In-Reply-To: <1598514788-31039-1-git-send-email-lirongqing@baidu.com>
References: <1598514788-31039-1-git-send-email-lirongqing@baidu.com>
Message-ID: <6d89955c-78a2-fa00-9f39-78648d3558a0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 8/27/20 12:53 AM, Li RongQing wrote:
> when changes the rx/tx ring to 4096, kzalloc may fail due to
> a temporary shortage on slab entries.
> 
> kvmalloc is used to allocate this memory as there is no need
> to have this memory area physical continuously.
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---


Well, fallback to vmalloc() overhead because order-1 pages are not readily available
when the NIC is setup (usually one time per boot)
is adding TLB cost at run time, for billions of packets to come, maybe for months.

Surely trying a bit harder to get order-1 pages is desirable.

 __GFP_RETRY_MAYFAIL is supposed to help here.


