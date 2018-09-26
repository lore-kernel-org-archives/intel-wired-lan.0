From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 26 Sep 2018 17:10:19 +0000
Subject: [Intel-wired-lan] [PATCH v2 09/16] ice: Extend malicious
 operations detection logic
In-Reply-To: <20180920004308.13772-10-anirudh.venkataramanan@intel.com>
References: <20180920004308.13772-1-anirudh.venkataramanan@intel.com>
 <20180920004308.13772-10-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2FC650@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Wednesday, September 19, 2018 5:43 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v2 09/16] ice: Extend malicious operations
> detection logic
> 
> This patch extends the existing malicious driver operation detection logic to
> cover malicious operations by the VF driver as well.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_hw_autogen.h  |  8 +++++
>  drivers/net/ethernet/intel/ice/ice_main.c        | 46
> ++++++++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h |  8 +++--
>  3 files changed, 60 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


