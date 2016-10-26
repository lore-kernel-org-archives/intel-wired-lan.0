From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 26 Oct 2016 10:21:05 -0700
Subject: [Intel-wired-lan] [net-next PATCH 25/27] igb: Update driver to
 make use of DMA_ATTR_SKIP_CPU_SYNC
In-Reply-To: <20161025153900.4815.4927.stgit@ahduyck-blue-test.jf.intel.com>
References: <20161025153220.4815.61239.stgit@ahduyck-blue-test.jf.intel.com>
 <20161025153900.4815.4927.stgit@ahduyck-blue-test.jf.intel.com>
Message-ID: <1477502465.2431.0.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2016-10-25 at 11:39 -0400, Alexander Duyck wrote:
> The ARM architecture provides a mechanism for deferring cache line
> invalidation in the case of map/unmap.? This patch makes use of this
> mechanism to avoid unnecessary synchronization.
> 
> A secondary effect of this change is that the portion of the page that
> has
> been synchronized for use by the CPU should be writable and could be
> passed
> up the stack (at least on ARM).
> 
> The last bit that occurred to me is that on architectures where the
> sync_for_cpu call invalidates cache lines we were prefetching and then
> invalidating the first 128 bytes of the packet.? To avoid that I have
> moved
> the sync up to before we perform the prefetch and allocate the skbuff so
> that we can actually make use of it.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
>?

Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20161026/9dad1ece/attachment.asc>
