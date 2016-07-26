From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 26 Jul 2016 13:39:42 -0700
Subject: [Intel-wired-lan] [next PATCH S40 10/13] i40e: fix lookup table
 when RSS disabled/enabled
In-Reply-To: <C8326AE922E1A04D91DF73B4913A8DCB01625281@ORSMSX102.amr.corp.intel.com>
References: <1469488555-28187-1-git-send-email-bimmy.pujari@intel.com>
 <1469488555-28187-11-git-send-email-bimmy.pujari@intel.com>
 <C8326AE922E1A04D91DF73B4913A8DCB01625281@ORSMSX102.amr.corp.intel.com>
Message-ID: <1469565582.2851.16.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2016-07-26 at 15:48 +0000, Brady, Alan wrote:
> ACK
> 
> -----Original Message-----
> From: Pujari, Bimmy?
> Sent: Monday, July 25, 2016 4:16 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Brady, Alan <alan.brady@intel.com>
> Subject: [next PATCH S40 10/13] i40e: fix lookup table when RSS
> disabled/enabled
> 
> From: "Alan, Brady" <alan.brady@intel.com>
> 
> This patch fixes the bug which causes RSS to continue to work after being
> disabled.? After disabling RSS, traffic would continue to be assigned to
> different queues instead of falling back to a single queue. Without this
> patch, attempting to disable RSS would not work as expected. This patch
> fixes the bug by clearing the lookup table used by RSS such that all
> traffic is assigned to a single queue.? This patch also addresses the
> issue of reinstating? the lookup table should RSS then be re-enabled.
> 
> Signed-off-by: Alan Brady <alan.brady@intel.com>
> Change-ID: Ib20c7c6a7e9f1f772bb787370f8a8c664796b141
> ---
> ?drivers/net/ethernet/intel/i40e/i40e_main.c | 28
> ++++++++++++++++++++++++++++
> ?1 file changed, 28 insertions(+)

First why are you ACK'ing your own patch, which you already Signed-off-by
on? ?Second, never top post.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160726/0a26257e/attachment.asc>
