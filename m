From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 17 Feb 2016 20:00:32 -0800
Subject: [Intel-wired-lan] [next PATCH S29 08/14] i40e: Fix PSOD's when
 npar enabled
In-Reply-To: <1455754344-6372-9-git-send-email-avinash.dayanand@intel.com>
References: <1455754344-6372-1-git-send-email-avinash.dayanand@intel.com>
 <1455754344-6372-9-git-send-email-avinash.dayanand@intel.com>
Message-ID: <1455768032.3128.0.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2016-02-17 at 16:12 -0800, Avinash Dayanand wrote:
> From: John Underwood <johnx.underwood@intel.com>
> 
> Return from i40e_vsi_reinit_setup() if vsi param is NULL.
> This makes this code consistent with all the other code that
> checks for NULL before using one of the VSI pointers accessed
> with an indexed variable. (Indexed VSI pointers are
> intentionally set to NULL in i40e_vsi_clear() and
> i40e_remove().
> 
> Signed-off-by: John Underwood <johnx.underwood@intel.com>
> Change-ID: I3bc8b909c70fd2439334eeae994d151f61480985
> ---
> ?drivers/net/ethernet/intel/i40e/i40e_main.c | 7 ++++++-
> ?1 file changed, 6 insertions(+), 1 deletion(-)

Please resend just this patch with the title fixed.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160217/bb2abac8/attachment.asc>
