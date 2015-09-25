From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri, 25 Sep 2015 16:16:33 -0700
Subject: [Intel-wired-lan] [PATCH 2/2] i40e: Disable Check for Hang
In-Reply-To: <1443207609-171288-2-git-send-email-anjali.singhai@intel.com>
References: <1443207609-171288-1-git-send-email-anjali.singhai@intel.com>
 <1443207609-171288-2-git-send-email-anjali.singhai@intel.com>
Message-ID: <1443222993.2987.45.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2015-09-25 at 12:00 -0700, Anjali Singhai Jain wrote:
> The driver doesn't need its own check for hang logic as there are no
> known issues that cause HW Tx Hangs. This logic was actually
> (mis)firing frequently, causing us to reset when we didn't need to.
> If a true tx hang happens, just wait for the stack logic to catch the
> issue and send us a tx_timeout.
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 99 +------------------
> ----------
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c | 70 -------------------
> -
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h |  8 ---
>  3 files changed, 1 insertion(+), 176 deletions(-)

Does not apply at all to my next-queue tree, dev-queue branch. 
 Dropping this patch.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150925/82234a5d/attachment.asc>
