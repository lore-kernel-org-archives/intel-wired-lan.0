From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 31 Jul 2019 18:10:41 +0000
Subject: [Intel-wired-lan] [PATCH S25 02/12] ice: Fix issues updating
 VSI MAC filters
In-Reply-To: <20190725095401.24590-2-anthony.l.nguyen@intel.com>
References: <20190725095401.24590-1-anthony.l.nguyen@intel.com>
 <20190725095401.24590-2-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40EA64@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH S25 02/12] ice: Fix issues updating VSI MAC
> filters
> 
> From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> 
> VSI, especially VF could request to add or remove filter for another VSI,
> driver should really guide such request and disallow it.
> However, instead of returning error for such malicious request, driver can
> simply return success.
> 
> In addition, we are not tracking number of MAC filters configured per VF
> correctly - and this leads to issue updating VF MAC filters whenever they
> were removed and re-configured via bringing VF interface down and up.
> Also, since VF could send request to update multiple MAC filters at once,
> driver should program those filters individually in the switch, in order to
> determine which action resulted to error, and communicate accordingly to
> the VF.
> 
> So, with this changes, we now track number of filters added right from when
> VF resources allocation is done, and could properly add filters for both
> trusted and non_trusted VFs, without MAC filters mis-match issue in the
> switch...
> 
> Also refactor code, so that driver can use new function to add or remove
> MAC filters.
> 
> Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c      | 30 +++++++++
>  drivers/net/ethernet/intel/ice/ice_lib.h      |  4 ++
>  drivers/net/ethernet/intel/ice/ice_main.c     | 64 +++++--------------
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 42 ++++++------
>  4 files changed, 73 insertions(+), 67 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


