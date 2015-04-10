From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri, 10 Apr 2015 15:55:31 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: Release semaphore bits in the
 right order
In-Reply-To: <20150410173631.9380.46865.stgit@mdrustad-wks.jf.intel.com>
References: <20150410173631.9380.46865.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <1428706531.2729.127.camel@jtkirshe-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2015-04-10 at 10:36 -0700, Mark D Rustad wrote:
> The global semaphore bits should be released in the reverse of the
> order that they were taken, so correct that.
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
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150410/b90ec94f/attachment.asc>
