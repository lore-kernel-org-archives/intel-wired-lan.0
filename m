From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 21 Mar 2016 22:47:39 +0000
Subject: [Intel-wired-lan] [next PATCH S31 v4 05/12] i40e: Make VF
 resets	more reliable
In-Reply-To: <1458328696-135941-6-git-send-email-avinash.dayanand@intel.com>
References: <1458328696-135941-1-git-send-email-avinash.dayanand@intel.com>
 <1458328696-135941-6-git-send-email-avinash.dayanand@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F99ECAB@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Avinash Dayanand
> Sent: Friday, March 18, 2016 12:18 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S31 v4 05/12] i40e: Make VF resets
> more reliable
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> Clear the VFLR bit immediately after triggering a reset instead of waiting until
> after cleanup is complete. Make sure to trigger a reset every time, not just if
> the PF is up.
> 
> These changes fix a problem where VF resets would get lost by the PF,
> preventing the VF driver from initializing.
> 
> Testing Hints: Do VF driver load/unload test with lots of VFs in the system.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: I5945cf2884095b7b0554867c64df8617e71d9d29
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes correctly applied, unloading and reloading VF driver with VFs created does not result in errors
