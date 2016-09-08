From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 8 Sep 2016 17:43:11 +0000
Subject: [Intel-wired-lan] [next PATCH S45 09/10] i40e: removing
 unreachable	code
In-Reply-To: <1473210312-29592-10-git-send-email-bimmy.pujari@intel.com>
References: <1473210312-29592-1-git-send-email-bimmy.pujari@intel.com>
 <1473210312-29592-10-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9FC870@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Tuesday, September 06, 2016 6:05 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Tieman, Henry W <henry.w.tieman@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S45 09/10] i40e: removing
> unreachable code
> 
> From: Henry Tieman <henry.w.tieman@intel.com>
> 
> The return value from i40e_shutdown_adminq() is always 0 (I40E_SUCCESS).
> So, the test for non-0 will never be true. Cleanup by removing the test and
> debug print statement.
> 
> Signed-off-by: Henry Tieman <henry.w.tieman@intel.com>
> Change-ID: Ie51e8e37515c3e3a6a9ff26fa951d0e5e24343c1
> ---
> Testing Hints:
>    Found by static code analysis. Test by code inspection.
> 
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


