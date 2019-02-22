From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 22 Feb 2019 23:49:30 +0000
Subject: [Intel-wired-lan] [PATCH S12 03/14] ice: avoid multiple
 unnecessary de-references in probe
In-Reply-To: <20190208205101.12078-4-anirudh.venkataramanan@intel.com>
References: <20190208205101.12078-1-anirudh.venkataramanan@intel.com>
 <20190208205101.12078-4-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D366AD4@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Friday, February 8, 2019 12:51 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S12 03/14] ice: avoid multiple unnecessary
> de-references in probe
> 
> From: Bruce Allan <bruce.w.allan@intel.com>
> 
> Add a local variable struct device *dev to avoid unnecessary de-references
> throughout ice_probe().
> 
> Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 33 ++++++++++++++-------------
> ----
>  1 file changed, 15 insertions(+), 18 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


