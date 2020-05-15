From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 15 May 2020 19:44:34 +0000
Subject: [Intel-wired-lan] [PATCH S41 06/15] ice: Provide more
 meaningful error message
In-Reply-To: <20200508004113.39725-6-anthony.l.nguyen@intel.com>
References: <20200508004113.39725-1-anthony.l.nguyen@intel.com>
 <20200508004113.39725-6-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB16597EB6599B6D441DD2F6498CBD0@DM5PR11MB1659.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Thursday, May 7, 2020 5:41 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S41 06/15] ice: Provide more meaningful
> error message
> 
> From: Lihong Yang <lihong.yang@intel.com>
> 
> When printing the ice status or AQ error codes, instead of printing out the
> numerical value, provide the description of the error code. This provides
> more info about the issue than a number.
> 
> Signed-off-by: Lihong Yang <lihong.yang@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h          |   2 +
>  drivers/net/ethernet/intel/ice/ice_base.c     |   8 +-
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  |  42 +++--
>  drivers/net/ethernet/intel/ice/ice_lib.c      | 103 +++++-----
>  drivers/net/ethernet/intel/ice/ice_main.c     | 177 +++++++++++++++---
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  |  28 +--
>  6 files changed, 247 insertions(+), 113 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


