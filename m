From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 2 Mar 2016 21:32:32 +0000
Subject: [Intel-wired-lan] [PATCH] i40evf: remove dead code
In-Reply-To: <1456876935-4810-1-git-send-email-jeffrey.t.kirsher@intel.com>
References: <1456876935-4810-1-git-send-email-jeffrey.t.kirsher@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F99C386@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Tuesday, March 01, 2016 4:02 PM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Cc: Alan Cox <alan@linux.intel.com>
> Subject: [Intel-wired-lan] [PATCH] i40evf: remove dead code
> 
> From: Alan Cox <alan@linux.intel.com>
> 
> The only error case is when the malloc fails, in which case the clean up loop
> does nothing at all, so remove it
> 
> Signed-off-by: Alan Cox <alan@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c |   11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
