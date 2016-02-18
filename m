From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 18 Feb 2016 19:04:58 +0000
Subject: [Intel-wired-lan] [next PATCH S29 06/14] i40e: Fix for
 unexpected	messaging
In-Reply-To: <1455754344-6372-7-git-send-email-avinash.dayanand@intel.com>
References: <1455754344-6372-1-git-send-email-avinash.dayanand@intel.com>
 <1455754344-6372-7-git-send-email-avinash.dayanand@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F98F275@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S29 06/14] i40e: Fix for unexpected
> messaging
> 
> From: Carolyn Wyborny <carolyn.wyborny@intel.com>
> 
> This fixes an issue where a previously removed message has returned.
> Changing the message type to dev_dbg leaves the info, if desired, but takes
> it out of normal everyday usage. Also changed call to only provide port data
> when its valid and not when its not (delete case).
> 
> Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
> Change-ID: Ief6f33b915f6364c24fa8e5789c2fc3168b5e2ed
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes properly applied
