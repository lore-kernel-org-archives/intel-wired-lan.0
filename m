From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri, 08 Jan 2016 02:42:50 -0800
Subject: [Intel-wired-lan] [PATCH] net-i40e: Replace variable
 initialisations by assignments in i40e_vc_get_vf_resources_msg()
In-Reply-To: <56868E0B.5040602@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <56868E0B.5040602@users.sourceforge.net>
Message-ID: <1452249770.19358.34.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2016-01-01 at 15:32 +0100, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 1 Jan 2016 15:11:09 +0100
> 
> Replace explicit initialisations for four local variables at the
> beginning
> by assignments that will only be performed if the corresponding code
> will really be executed.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
> ?drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 15 +++++++++---
> ---
> ?1 file changed, 9 insertions(+), 6 deletions(-)

Dropping this patch based on feedback from Shannon.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160108/d5613803/attachment.asc>
