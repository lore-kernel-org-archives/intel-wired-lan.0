From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 21 Mar 2016 22:58:45 +0000
Subject: [Intel-wired-lan] [next PATCH S31 v4 06/12] i40evf: Add longer
 wait	after remove module
In-Reply-To: <1458328696-135941-7-git-send-email-avinash.dayanand@intel.com>
References: <1458328696-135941-1-git-send-email-avinash.dayanand@intel.com>
 <1458328696-135941-7-git-send-email-avinash.dayanand@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F99ECBE@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S31 v4 06/12] i40evf: Add longer wait
> after remove module
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> Upon module remove, wait a little longer after requesting a reset before
> checking to see if the firmware responded. This change prevents double
> resets when the firmware is busy.
> 
> Testing Hints: Load and unload VF driver repeatedly with a lot of VFs enabled
> and make sure it reinitializes properly each time.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: Ieedc988ee82fac1f32a074bf4d9e4dba426bfa58
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Multiple repeated loading and unloading of VF driver with VFs active does not result in errors
