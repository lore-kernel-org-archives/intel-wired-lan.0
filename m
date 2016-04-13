From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 13 Apr 2016 17:56:16 +0000
Subject: [Intel-wired-lan] [next PATCH S33 03/13] i40e: Code cleanup
	in	i40e_add_fdir_ethtool
In-Reply-To: <1460475052-6348-4-git-send-email-harshitha.ramamurthy@intel.com>
References: <1460475052-6348-1-git-send-email-harshitha.ramamurthy@intel.com>
 <1460475052-6348-4-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D073F@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Harshitha Ramamurthy
> Sent: Tuesday, April 12, 2016 8:31 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S33 03/13] i40e: Code cleanup in
> i40e_add_fdir_ethtool
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> A little bit of code cleanup in prep for more cloud filter work.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Change-ID: I0dc33ce0d4c207944336a07437640fef920c100c
> ---
> Testing Hints :
> 	Compiles, FD filters still work
> 
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Flow director filters work as expected
