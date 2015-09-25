From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri, 25 Sep 2015 16:18:25 -0700
Subject: [Intel-wired-lan] [PATCH 1/2] i40e: Fix RS bit update in Tx
 path and disable force WB workaround
In-Reply-To: <1443207609-171288-1-git-send-email-anjali.singhai@intel.com>
References: <1443207609-171288-1-git-send-email-anjali.singhai@intel.com>
Message-ID: <1443223105.2987.48.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2015-09-25 at 12:00 -0700, Anjali Singhai Jain wrote:
> This patch fixes the issue of forcing WB too often causing us to not
> benefit from NAPI.
> 
> Without this patch we were forcing WB/arming interrupt too often
> taking
> away the benefits of NAPI and causing a performance impact.
> 
> With this patch we disable force WB in the clean routine for X710
> and XL710 adapters. X722 adapters do not enable interrupt to force
> a WB and benefit from WB_ON_ITR and hence force WB is left enabled
> for those adapters.
> For XL710 and X710 adapters if we have less than 4 packets pending
> a software Interrupt triggered from service task will force a WB.
> 
> This patch also changes the conditions for setting RS bit as
> described
> in code comments. This optimizes when the HW does a tail bump amd
> when
> it does a WB. It also optimizes when we do a wmb.
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c | 126 ++++++++++++++++++
> ----------
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h |   2 +
>  2 files changed, 86 insertions(+), 42 deletions(-)

This applied with a little massaging, but seeing that the second patch
does not apply at all.  I am dropping this patch.

Please resend an updated patch against my next-queue tree, dev-queue
branch.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150925/6a834ff5/attachment-0001.asc>
