From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri, 03 Apr 2015 01:56:18 -0700
Subject: [Intel-wired-lan] [net-next v2] igb: simplify and clean up
 igb_enable_mas()
In-Reply-To: <20150403085138.6124.95003.stgit@gmw-smvitp108.amr.corp.intel.com>
References: <20150403085138.6124.95003.stgit@gmw-smvitp108.amr.corp.intel.com>
Message-ID: <1428051378.2662.76.camel@jtkirshe-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2015-04-03 at 01:52 -0700, Todd Fujinaka wrote:
> 
> igb_enable_mas() should only be called for the 82575 and has no clear
> return so changing it to void. Also simplify the odd conditional
> expression.
> 
> Signed-off-by: Todd Fujinaka <todd.fujinaka@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> v2: made igb_enable_mas() static based on feedback from automated
> testing
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c |   27
> +++++++--------------------
>  1 file changed, 7 insertions(+), 20 deletions(-)

I have applied your patch to my queue.
-- 
git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
dev-queue
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150403/e7f747cc/attachment.asc>
