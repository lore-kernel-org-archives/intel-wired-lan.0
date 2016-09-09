From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 9 Sep 2016 20:10:29 +0000
Subject: [Intel-wired-lan] [next PATCH S45 08/10] i40e: check
 conflicting	ntuple/sideband rules when re-enabling ATR
In-Reply-To: <1473210312-29592-9-git-send-email-bimmy.pujari@intel.com>
References: <1473210312-29592-1-git-send-email-bimmy.pujari@intel.com>
 <1473210312-29592-9-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9FCABA@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S45 08/10] i40e: check conflicting
> ntuple/sideband rules when re-enabling ATR
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> In i40e_fdir_check_and_reenable(), the driver performs some checks to
> determine whether it is safe to re-enable FD Sideband and FD ATR support.
> The current check will only determine if there is available space in the flow
> director table. However, this ignores the fact that ATR should be disabled
> when there are TCP/IPv4 sideband rules in effect.
> Add the missing check, and update the info message printed when
> I40E_DEBUG_FD is enabled.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: Ibb9c63e5be95d63c53a498fdd5dbf69f54a00e08
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Bugs no longer present

