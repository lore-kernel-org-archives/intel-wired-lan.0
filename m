From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 26 Oct 2016 10:21:52 -0700
Subject: [Intel-wired-lan] [net-next PATCH 26/27] igb: Update code to
 better handle incrementing page count
In-Reply-To: <20161025153906.4815.61652.stgit@ahduyck-blue-test.jf.intel.com>
References: <20161025153220.4815.61239.stgit@ahduyck-blue-test.jf.intel.com>
 <20161025153906.4815.61652.stgit@ahduyck-blue-test.jf.intel.com>
Message-ID: <1477502512.2431.1.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2016-10-25 at 11:39 -0400, Alexander Duyck wrote:
> This patch updates the driver code so that we do bulk updates of the page
> reference count instead of just incrementing it by one reference at a
> time.
> The advantage to doing this is that we cut down on atomic operations and
> this in turn should give us a slight improvement in cycles per packet.?
> In
> addition if we eventually move this over to using build_skb the gains
> will
> be more noticeable.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>

Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20161026/c3ba8e63/attachment.asc>
