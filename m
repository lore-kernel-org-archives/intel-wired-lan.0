From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 19 May 2020 16:35:43 +0000
Subject: [Intel-wired-lan] [PATCH S42 2/7] ice: Support displaying
 ntuple rules
In-Reply-To: <20200512010146.41303-2-anthony.l.nguyen@intel.com>
References: <20200512010146.41303-1-anthony.l.nguyen@intel.com>
 <20200512010146.41303-2-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB1659FC5B468AF1A71DE097A28CB90@DM5PR11MB1659.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Monday, May 11, 2020 6:02 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S42 2/7] ice: Support displaying ntuple rules
> 
> From: Henry Tieman <henry.w.tieman@intel.com>
> 
> Add functionality for ethtool --show-ntuple, allowing for filters to be
> displayed when set functionality is added. Add statistics related to Flow
> Director matches and status.
> 
> Signed-off-by: Henry Tieman <henry.w.tieman@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h          |   9 +
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  |  17 ++
> .../net/ethernet/intel/ice/ice_ethtool_fdir.c | 161 ++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_fdir.c     |  33 ++++
>  drivers/net/ethernet/intel/ice/ice_fdir.h     |  47 +++++
>  .../net/ethernet/intel/ice/ice_hw_autogen.h   |   1 +
>  drivers/net/ethernet/intel/ice/ice_main.c     |   9 +
>  drivers/net/ethernet/intel/ice/ice_type.h     |   3 +
>  8 files changed, 280 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


