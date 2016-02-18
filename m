From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 18 Feb 2016 22:58:07 +0000
Subject: [Intel-wired-lan] [v2 next PATCH S29 08/14] i40e: add check
	for	null vsi
In-Reply-To: <1455815965-9735-1-git-send-email-avinash.dayanand@intel.com>
References: <1455815965-9735-1-git-send-email-avinash.dayanand@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F98F340@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Avinash Dayanand
> Sent: Thursday, February 18, 2016 9:19 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [v2 next PATCH S29 08/14] i40e: add check for null
> vsi
> 
> From: John Underwood <johnx.underwood@intel.com>
> 
> Return from i40e_vsi_reinit_setup() if vsi param is NULL.
> This makes this code consistent with all the other code that checks for NULL
> before using one of the VSI pointers accessed with an indexed variable.
> (Indexed VSI pointers are intentionally set to NULL in i40e_vsi_clear() and
> i40e_remove().
> 
> v2: change patch title
> 
> Signed-off-by: John Underwood <johnx.underwood@intel.com>
> Change-ID: I3bc8b909c70fd2439334eeae994d151f61480985
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes properly applied
