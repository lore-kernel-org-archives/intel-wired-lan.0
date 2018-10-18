From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 18 Oct 2018 21:45:36 +0000
Subject: [Intel-wired-lan] [PATCH 7/7] ice: Poll for link status change
In-Reply-To: <20181018153709.32664-8-anirudh.venkataramanan@intel.com>
References: <20181018153709.32664-1-anirudh.venkataramanan@intel.com>
 <20181018153709.32664-8-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D30F762@FMSMSX152.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Thursday, October 18, 2018 8:37 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 7/7] ice: Poll for link status change
> 
> When the physical link goes up or down, the driver is supposed to receive a
> link status event (LSE). The driver currently has the code to handle LSEs but
> there is no firmware support for this feature yet.
> So this patch adds the ability for the driver to poll for link status changes. The
> polling itself is done in ice_watchdog_subtask.
> 
> For namespace cleanliness, this patch also removes code that handles LSE.
> This code will be reintroduced once the feature is officially supported.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c |  29 +-------
>  drivers/net/ethernet/intel/ice/ice_common.h |   6 --
>  drivers/net/ethernet/intel/ice/ice_main.c   | 110 ++++++----------------------
>  3 files changed, 25 insertions(+), 120 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


