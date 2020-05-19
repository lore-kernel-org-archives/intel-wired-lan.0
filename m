From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 19 May 2020 16:37:36 +0000
Subject: [Intel-wired-lan] [PATCH S42 6/7] ice: Restore filters
 following reset
In-Reply-To: <20200512010146.41303-6-anthony.l.nguyen@intel.com>
References: <20200512010146.41303-1-anthony.l.nguyen@intel.com>
 <20200512010146.41303-6-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB1659EA592E541FAAF9B9CC1C8CB90@DM5PR11MB1659.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH S42 6/7] ice: Restore filters following reset
> 
> From: Henry Tieman <henry.w.tieman@intel.com>
> 
> Following a reset, Flow Director filters are cleared from the hardware.
> Rebuild the filters using the software structures containing the filter rules.
> 
> Signed-off-by: Henry Tieman <henry.w.tieman@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h          |  2 +
>  .../net/ethernet/intel/ice/ice_ethtool_fdir.c | 65 +++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_lib.c      | 17 +++--
>  drivers/net/ethernet/intel/ice/ice_main.c     | 31 +++++++++
>  4 files changed, 109 insertions(+), 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


