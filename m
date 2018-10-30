From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 30 Oct 2018 21:54:45 +0000
Subject: [Intel-wired-lan] [PATCH S8 02/16] ice: Check for reset in
 progress during remove
In-Reply-To: <20181026174105.11628-3-anirudh.venkataramanan@intel.com>
References: <20181026174105.11628-1-anirudh.venkataramanan@intel.com>
 <20181026174105.11628-3-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D328C99@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Friday, October 26, 2018 10:41 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S8 02/16] ice: Check for reset in progress
> during remove
> 
> The remove path does not currently check to see if a reset is in progress
> before proceeding.  This can cause a resource collision resulting in various
> types of errors.
> 
> Check for reset in progress and wait for a reasonable amount of time before
> allowing the remove to progress.
> 
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h      | 2 ++
>  drivers/net/ethernet/intel/ice/ice_main.c | 6 ++++++
>  2 files changed, 8 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


