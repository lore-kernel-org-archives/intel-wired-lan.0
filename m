From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 16 Nov 2016 20:39:36 +0000
Subject: [Intel-wired-lan] [next PATCH S52-V2 08/15] i40e: change
 message to	only appear when extra debug info is wanted
In-Reply-To: <1478639119-14656-9-git-send-email-bimmy.pujari@intel.com>
References: <1478639119-14656-1-git-send-email-bimmy.pujari@intel.com>
 <1478639119-14656-9-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA36D92@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Tuesday, November 08, 2016 1:05 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S52-V2 08/15] i40e: change message
> to only appear when extra debug info is wanted
> 
> From: Carolyn Wyborny <carolyn.wyborny@intel.com>
> 
> This patch changes an X722 informational message so that it only appears
> when extra messages are desired.  Without this patch, on X722 devices, this
> message appears at load, potentially causing unnecessary alarm.
> 
> Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
> Change-ID: I94f7aae15dc5b2723cc9728c630c72538a3e670e
> ---
> Testing Hints :  "cleared PE_CRITERR message should no longer appear.
> 
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Message no longer appears on init
