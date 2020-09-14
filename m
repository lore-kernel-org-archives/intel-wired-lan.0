From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Mon, 14 Sep 2020 16:22:44 -0700
Subject: [Intel-wired-lan] [PATCH][next] i40e: switch kvzalloc to
 allocate rx/tx_bi buffer
In-Reply-To: <1598000514-5951-1-git-send-email-lirongqing@baidu.com>
References: <1598000514-5951-1-git-send-email-lirongqing@baidu.com>
Message-ID: <20200914162244.00001783@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Li RongQing wrote:

> when changes the rx/tx ring to 4096, rx/tx_bi needs an order
> 5 pages, and allocation maybe fail due to memory fragmentation
> so switch to kvzalloc

Hi Li,
Thanks for your patches, but I think you're solving a problem that isn't
a problem (besides that the warning is being printed.) After all, the
driver either gets the memory that it needed via the kernel waiting
(since we didn't set GFP_NOWAIT), or ENOMEM gets returned to the user.
If your kernel is so close to OOM that it's having this problem aren't
you going to have other issues? Anyway....

This driver goes to great lengths to not make any changes to the
existing queues if an allocation fails via ethtool (in fact this is
code I authored).

Maybe a better option is to just set __GFP_NOWARN on the kcalloc call?
Then if there is a memory allocation error we'll just reflect it to
user space and let the user retry, with no noisy kernel message.

For performance reasons, having actually contiguous regions from
kcalloc should help performance vs kvcalloc virtually contiguous
regions.

I'd prefer that you don't solve the problem this way. How about just
marking the allocations as GFP_RETRY_MAYFAIL and GFP_NOWARN?

The same goes for the iavf patch.

Jesse
