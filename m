From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 04 May 2017 14:18:55 -0700
Subject: [Intel-wired-lan] [PATCH] i40e: fix incorrect assignment of
 I40E_FLAG_HW_ATR_EVICT_CAPABLE
In-Reply-To: <20170504205412.32375-1-jacob.e.keller@intel.com>
References: <20170504205412.32375-1-jacob.e.keller@intel.com>
Message-ID: <1493932735.75086.5.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2017-05-04 at 13:54 -0700, Jacob Keller wrote:
> When attempting to setup I40E_FLAG_HW_ATR_EVICT_ENABLED, we
> accidentally
> broke all PF flags because we directly assigned the value of
> I40E_FLAG_HW_ATR_EVICT_CAPABLE.
> 
> This is incorrect, but the obvious fix of changing the assignment to
> an
> > = is not correct either, since I40E_FLAG_HW_ATR_EVICT_CAPABLE is
> 
> already set in the feature list.
> 
> Instead, we intended to set the I40E_FLAG_HW_ATR_EVICT_ENABLED flag,
> but
> only if I40E_FLAG_HW_ATR_EVICT_CAPABLE had already been set.
> 
> Without this patch we will have many problems including disabling
> MSI-X
> support, and not having HW ATR eviction actually enabled.
> 
> Fixes: 47994c119a36 ("i40e: remove hw_disabled_flags in favor of
> using separate flag bits", 2017-04-19)
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
> ?drivers/net/ethernet/intel/i40e/i40e_main.c | 7 ++++---
> ?1 file changed, 4 insertions(+), 3 deletions(-)

Grr... Patchwork is not picking patches up.  I have sent an email to
Jeremy Kerr (patchwork admin for ozlabs.org).

I will apply Jake's updated version of the patch to my net-queue and
next-queue trees, but plan to push to Dave net tree.

Alex- can I assume your ACK still stands for this updated change?

Andrew- This has high priority and I would like to see testing
completed in the next day or so, please.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170504/9a8231d6/attachment.asc>
