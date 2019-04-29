From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 29 Apr 2019 18:11:57 +0000
Subject: [Intel-wired-lan] [PATCH S20 04/15] ice: Set minimum default Rx
 descriptor count to 512
In-Reply-To: <20190416173052.28928-5-anirudh.venkataramanan@intel.com>
References: <20190416173052.28928-1-anirudh.venkataramanan@intel.com>
 <20190416173052.28928-5-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D39AC68@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Tuesday, April 16, 2019 10:31 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S20 04/15] ice: Set minimum default Rx
> descriptor count to 512
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently we set the default number of Rx descriptors per queue to the
> system's page size divided by the number of bytes per descriptor. For 4K
> page size systems this is resulting in 128 Rx descriptors per queue. This is
> causing more dropped packets than desired in the default configuration. Fix
> this by setting the minimum default Rx descriptor count per queue to 512.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


