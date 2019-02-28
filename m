From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 28 Feb 2019 23:47:56 +0000
Subject: [Intel-wired-lan] [PATCH S14 13/15] ice: use virt channel
 status codes
In-Reply-To: <20190213185115.25877-14-anirudh.venkataramanan@intel.com>
References: <20190213185115.25877-1-anirudh.venkataramanan@intel.com>
 <20190213185115.25877-14-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D36724E@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Wednesday, February 13, 2019 10:51 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S14 13/15] ice: use virt channel status
> codes
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> When communicating with the AVF driver, we need to use the status codes
> from virtchnl.h, not our own ice-specific codes. Without this, when an error
> occurs, the VF will report nonsensical results.
> 
> NOTE: this depends on changes made to include/linux/avf/virtchnl.h by
> commit bb58fd7eeffc ("i40e: Update status codes")
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned
> up commit message]
> ---
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 273 +++++++++++++------
> ----
>  1 file changed, 154 insertions(+), 119 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


