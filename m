From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 8 Sep 2016 16:59:25 +0000
Subject: [Intel-wired-lan] [next PATCH S45 03/10] i40evf: remove
 unnecessary	error checking against i40e_shutdown_adminq
In-Reply-To: <1473210312-29592-4-git-send-email-bimmy.pujari@intel.com>
References: <1473210312-29592-1-git-send-email-bimmy.pujari@intel.com>
 <1473210312-29592-4-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9FC83D@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S45 03/10] i40evf: remove
> unnecessary error checking against i40e_shutdown_adminq
> 
> From: Lihong Yang <lihong.yang@intel.com>
> 
> The i40e_shutdown_adminq function never returns failure. There is no need
> to check the non-0 return value. Clean up the unnecessary error checking
> and warning against it.
> 
> Signed-off-by: Lihong Yang <lihong.yang@intel.com>
> Change-ID: Ibb616f09cfb93bd1a872ebf3241a15fb8354b31b
> ---
> Testing Hints:
> Found by static code analysis. Check by code inspection.
> 
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


