From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 14 Apr 2015 05:58:55 -0700
Subject: [Intel-wired-lan] [PATCH v5] e1000e i219 fix unit hang on reset
 and runtime D3
In-Reply-To: <1428967221-32195-1-git-send-email-yanirx.lubetkin@intel.com>
References: <1428967221-32195-1-git-send-email-yanirx.lubetkin@intel.com>
Message-ID: <1429016335.2638.7.camel@jtkirshe-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2015-04-14 at 02:20 +0300, Yanir Lubetkin wrote:
> unit hang may occur if multiple descriptors are available in the rings
> during
> reset or runtime suspend. This state can be detected by testing bit 8
> in the
> FEXTNVM7 register. if this bit is set and there are pending
> descriptors in one
> of the rings, we must flush them prior to reset. same applies entering
> runtime
> suspend.
> 
> Signed-off-by: Yanir Lubetkin <yanirx.lubetkin@intel.com>
> ---
>  drivers/net/ethernet/intel/e1000e/ich8lan.h |   5 ++
>  drivers/net/ethernet/intel/e1000e/netdev.c  | 102
> ++++++++++++++++++++++++++++
>  drivers/net/ethernet/intel/e1000e/regs.h    |   1 +
>  3 files changed, 108 insertions(+)

Thanks Yanir, I have applied your patch to my queue.
-- 
git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
dev-queue
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150414/e5c476fc/attachment.asc>
