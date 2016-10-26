From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 26 Oct 2016 10:22:41 -0700
Subject: [Intel-wired-lan] [net-next PATCH 27/27] igb: Revert "igb:
 Revert support for build_skb in igb"
In-Reply-To: <20161025153911.4815.45366.stgit@ahduyck-blue-test.jf.intel.com>
References: <20161025153220.4815.61239.stgit@ahduyck-blue-test.jf.intel.com>
 <20161025153911.4815.45366.stgit@ahduyck-blue-test.jf.intel.com>
Message-ID: <1477502561.2431.2.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2016-10-25 at 11:39 -0400, Alexander Duyck wrote:
> This reverts commit f9d40f6a9921 ("igb: Revert support for build_skb in
> igb") and adds a few changes to update it to work with the latest version
> of igb. We are now able to revert the removal of this due to the fact
> that with the recent changes to the page count and the use of
> DMA_ATTR_SKIP_CPU_SYNC we can make the pages writable so we should not be
> invalidating the additional data added when we call build_skb.
> 
> The biggest risk with this change is that we are now not able to support
> full jumbo frames when using build_skb.? Instead we can only support up
> to
> 2K minus the skb overhead and padding offset.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>

Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20161026/2f59ec72/attachment.asc>
