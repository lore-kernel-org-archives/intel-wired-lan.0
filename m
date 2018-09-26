From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 26 Sep 2018 16:55:53 +0000
Subject: [Intel-wired-lan] [PATCH 10/16] ice: Fix forward to queue group
 logic
In-Reply-To: <20180920002339.11107-11-anirudh.venkataramanan@intel.com>
References: <20180920002339.11107-1-anirudh.venkataramanan@intel.com>
 <20180920002339.11107-11-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2FC4BB@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Wednesday, September 19, 2018 5:24 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 10/16] ice: Fix forward to queue group logic
> 
> When adding a rule, queue region size needs to be provided as log base 2 of
> the number of queues in region. Fix that.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_switch.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


