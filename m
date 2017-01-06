From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri, 06 Jan 2017 08:39:57 -0800
Subject: [Intel-wired-lan] [next PATCH 9/9] igb: Revert "igb: Revert
 support for build_skb in igb"
In-Reply-To: <20170106161131.2030.4342.stgit@localhost.localdomain>
References: <20170106160850.2030.39073.stgit@localhost.localdomain>
 <20170106161131.2030.4342.stgit@localhost.localdomain>
Message-ID: <1483720797.25700.60.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2017-01-06 at 08:11 -0800, Alexander Duyck wrote:
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> This reverts commit f9d40f6a9921 ("igb: Revert support for build_skb in
> igb") and adds a few changes to update it to work with the latest version
> of igb. We are now able to revert the removal of this due to the fact
> that with the recent changes to the page count and the use of
> DMA_ATTR_SKIP_CPU_SYNC we can make the pages writable so we should not be
> invalidating the additional data added when we call build_skb.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
> ?drivers/net/ethernet/intel/igb/igb_main.c |?? 47
> +++++++++++++++++++++++++++++
> ?1 file changed, 47 insertions(+)

Weird, this patch is not showing up in patchworks.  I will get this patch
added as well to my tree and work on getting it to show up in patchworks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170106/a0e96a3b/attachment.asc>
