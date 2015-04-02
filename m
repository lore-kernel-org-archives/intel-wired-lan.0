From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 01 Apr 2015 17:54:38 -0700
Subject: [Intel-wired-lan] [PATCH] igb: simplify and clean up
 igb_enable_mas()
In-Reply-To: <20150401171704.16815.42901.stgit@htfujina-fc.jf.intel.com>
References: <20150401171704.16815.42901.stgit@htfujina-fc.jf.intel.com>
Message-ID: <1427936078.2662.44.camel@jtkirshe-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2015-04-01 at 10:17 -0700, Todd Fujinaka wrote:
> igb_enable_mas() should only be called for the 82575 and has no clear
> return so changing it to void. Also simplify the odd conditional
> expression.
> 
> Signed-off-by: Todd Fujinaka <todd.fujinaka@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c |   27
> +++++++--------------------
>  1 file changed, 7 insertions(+), 20 deletions(-)

I have applied this to my queue.
-- 
git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
dev-queue
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150401/5fe71456/attachment.asc>
