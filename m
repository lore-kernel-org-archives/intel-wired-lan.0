From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 1 Mar 2019 23:46:39 +0000
Subject: [Intel-wired-lan] [PATCH S15 01/14] ice: Fix for adaptive
 interrupt moderation
In-Reply-To: <20190219230414.25627-2-anirudh.venkataramanan@intel.com>
References: <20190219230414.25627-1-anirudh.venkataramanan@intel.com>
 <20190219230414.25627-2-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D367578@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Tuesday, February 19, 2019 3:04 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S15 01/14] ice: Fix for adaptive interrupt
> moderation
> 
> commit 63f545ed1285 ("ice: Add support for adaptive interrupt moderation")
> was meant to add support for adaptive interrupt moderation but there was
> an error on my part while formatting the patch, and thus only part of the
> patch ended up being submitted.
> 
> This patch rectifies the error by adding the rest of the code.
> 
> Fixes: 63f545ed1285 ("ice: Add support for adaptive interrupt moderation")
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h      |   1 +
>  drivers/net/ethernet/intel/ice/ice_txrx.c | 292
> +++++++++++++++++++++++++++---
>  drivers/net/ethernet/intel/ice/ice_txrx.h |   6 +
>  3 files changed, 275 insertions(+), 24 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


