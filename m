From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 8 Sep 2016 16:47:32 +0000
Subject: [Intel-wired-lan] [next PATCH S45 01/10] i40evf: remove
 unnecessary	error checking against i40evf_up_complete
In-Reply-To: <1473210312-29592-2-git-send-email-bimmy.pujari@intel.com>
References: <1473210312-29592-1-git-send-email-bimmy.pujari@intel.com>
 <1473210312-29592-2-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9FC81A@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S45 01/10] i40evf: remove
> unnecessary error checking against i40evf_up_complete
> 
> Function i40evf_up_complete() always returns success. Changed this to a
> void type and removed the code that checks the return status and prints an
> error message.
> 
> Signed-off-by: Bimmy Pujari <bimmy.pujari@intel.com>
> Change-ID: I8c400f174786b9c855f679e470f35af292fb50ad
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


