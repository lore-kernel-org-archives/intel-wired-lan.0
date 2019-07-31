From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 31 Jul 2019 18:13:35 +0000
Subject: [Intel-wired-lan] [PATCH S25 09/12] ice: Don't clog kernel
 debug log with VF MDD events errors
In-Reply-To: <20190725095401.24590-9-anthony.l.nguyen@intel.com>
References: <20190725095401.24590-1-anthony.l.nguyen@intel.com>
 <20190725095401.24590-9-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40EADC@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH S25 09/12] ice: Don't clog kernel debug log
> with VF MDD events errors
> 
> From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> 
> In case of MDD events on VF, don't clog kernel log with unlimited VF mdd
> events message "VF 0 has had 1018 MDD events since last boot" - limit
> events log message to 30, based on the observation in some experimenation
> with sending malicious packet once, and number of events reported before
> device stopped observing MDD events.
> 
> Also removed defunct macro "ICE_DFLT_NUM_MDD_EVENTS_ALLOWED"
> for tracking number of MDD events allowed before disabling the interface...
> 
> Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c        | 6 ++++--
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h | 2 +-
>  2 files changed, 5 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


