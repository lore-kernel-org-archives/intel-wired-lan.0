From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri, 10 Apr 2015 15:55:42 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: Use a signed type to hold
 error codes
In-Reply-To: <20150410173636.9380.22272.stgit@mdrustad-wks.jf.intel.com>
References: <20150410173636.9380.22272.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <1428706542.2729.128.camel@jtkirshe-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2015-04-10 at 10:36 -0700, Mark D Rustad wrote:
> Because error codes are negative, it only makes sense to
> consistently use signed types when handling them. Also remove
> some explicit comparisons with 0 on these variables.
> 
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>

Thanks Mark, I have applied your patch to my queue.
-- 
git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
dev-queue
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150410/d3de88ce/attachment.asc>
