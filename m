From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 26 Sep 2018 16:59:40 +0000
Subject: [Intel-wired-lan] [PATCH 09/16] ice: Expand use of VSI handles
 part 1/2
In-Reply-To: <20180920002319.10971-10-anirudh.venkataramanan@intel.com>
References: <20180920002319.10971-1-anirudh.venkataramanan@intel.com>
 <20180920002319.10971-10-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2FC52B@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Wednesday, September 19, 2018 5:23 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 09/16] ice: Expand use of VSI handles part
> 1/2
> 
> A VSI handle is just a number the driver maintains to uniquely identify a VSI.
> A VSI handle is backed by a VSI number in the hardware. When interacting
> when the hardware, VSI handles are coverted into VSI numbers.
> 
> In commit 0f9d5027a749 ("ice: Refactor VSI allocation, deletion and rebuild
> flow"), VSI handles were introduced but it was used only when creating and
> deleting VSIs. This patch is part one of two patches that expands the use of
> VSI handles across the rest of the driver. Also in this patch, certain parts of
> the code had to be refactored to correctly use VSI handles.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c    |  28 +-
>  drivers/net/ethernet/intel/ice/ice_main.c   |   4 +-
>  drivers/net/ethernet/intel/ice/ice_switch.c | 462 +++++++++++++++++-----
> ------  drivers/net/ethernet/intel/ice/ice_switch.h |  34 +-
>  4 files changed, 328 insertions(+), 200 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


