From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 17 Feb 2016 20:01:12 -0800
Subject: [Intel-wired-lan] [next PATCH S29 12/14] i40e: Fix for the NPAR
 PSOD issue
In-Reply-To: <1455754344-6372-13-git-send-email-avinash.dayanand@intel.com>
References: <1455754344-6372-1-git-send-email-avinash.dayanand@intel.com>
 <1455754344-6372-13-git-send-email-avinash.dayanand@intel.com>
Message-ID: <1455768072.3128.1.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2016-02-17 at 16:12 -0800, Avinash Dayanand wrote:
> From: Pandi Kumar Maharajan <pandi.maharajan@intel.com>
> 
> We need to suspend scheduling or any pending service task during
> driver
> unload process, so that new task will not be scheduled. This patch
> sets
> the suspend flag bit during reload which avoids service task
> execution.
> 
> Signed-off-by: Pandi Kumar Maharajan <pandi.maharajan@intel.com>
> Change-ID: I017c57b5d6656564556e3c5387da671369a572ac
> ---
> ?drivers/net/ethernet/intel/i40e/i40e_main.c | 1 +
> ?1 file changed, 1 insertion(+)

Please resend just this patch with the title fixed.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160217/cfedaed8/attachment.asc>
