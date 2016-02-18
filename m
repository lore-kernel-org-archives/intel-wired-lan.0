From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 18 Feb 2016 19:07:17 +0000
Subject: [Intel-wired-lan] [next PATCH S29 07/14] i40e: Expose
	some	registers to program parser, FD and RSS logic
In-Reply-To: <1455754344-6372-8-git-send-email-avinash.dayanand@intel.com>
References: <1455754344-6372-1-git-send-email-avinash.dayanand@intel.com>
 <1455754344-6372-8-git-send-email-avinash.dayanand@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F98F281@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Avinash Dayanand
> Sent: Wednesday, February 17, 2016 4:12 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S29 07/14] i40e: Expose some
> registers to program parser, FD and RSS logic
> 
> From: Anjali Singhai Jain <anjali.singhai@intel.com>
> 
> This patch adds 7 new register definitions for programming the parser, flow
> director and RSS blocks in the HW.
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> Change-ID: I31e76673125275f3c69a14c646361919d04dc987
> ---
>  drivers/net/ethernet/intel/i40e/i40e_register.h | 48
> +++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes properly applied
