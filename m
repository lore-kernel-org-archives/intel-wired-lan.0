From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 31 Jul 2019 18:11:07 +0000
Subject: [Intel-wired-lan] [PATCH S25 03/12] ice: Don't allow VSI to
 remove unassociated ucast filter
In-Reply-To: <20190725095401.24590-3-anthony.l.nguyen@intel.com>
References: <20190725095401.24590-1-anthony.l.nguyen@intel.com>
 <20190725095401.24590-3-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40EA70@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, July 25, 2019 2:54 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S25 03/12] ice: Don't allow VSI to remove
> unassociated ucast filter
> 
> From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> 
> If a VSI is not using a unicast filter or did not configure that particular unicast
> filter, driver should not allow it to be removed by the rogue VSI.
> 
> Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_switch.c | 56 +++++++++++++++++++++
>  1 file changed, 56 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


