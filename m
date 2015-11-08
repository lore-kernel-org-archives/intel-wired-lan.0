From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Sun, 08 Nov 2015 04:46:26 -0800
Subject: [Intel-wired-lan] [next PATCH S21 07/14] i40e: propagate
 properly
In-Reply-To: <1446852372-25480-8-git-send-email-joshua.a.hay@intel.com>
References: <1446852372-25480-1-git-send-email-joshua.a.hay@intel.com>
 <1446852372-25480-8-git-send-email-joshua.a.hay@intel.com>
Message-ID: <1446986786.4094.9.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2015-11-06 at 15:26 -0800, Joshua Hay wrote:
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> i40e_sync_vsi_filters() is the surly teenager of this driver. It says
> it's going to report errors, but it doesn't actually do that most of
> the
> time. And when it does, it leaves a mess.
> 
> Change this function to have a common exit point so it will properly
> release the busy lock on the VSI. Propagate errors to the callers.
> Finally, adjust a few callers to check for and deal with errors from
> this function.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: Ic6af4956491e72402ebb3c538a3c31a0ad7f8667
> ---
> ?drivers/net/ethernet/intel/i40e/i40e_main.c??????? | 109
> +++++++++++++--------
> ?drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |? 14 +--
> ?2 files changed, 75 insertions(+), 48 deletions(-)

This does not apply cleanly, so I am not applying this patch (or the
remaining patches in the series). ?Please send me an update to this
patch, which applies cleanly to me next-queue tree (dev-queue branch).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20151108/9e4bc7c5/attachment.asc>
