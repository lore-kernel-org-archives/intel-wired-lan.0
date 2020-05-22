From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 22 May 2020 19:27:33 +0000
Subject: [Intel-wired-lan] [PATCH S43 02/15] ice: print Rx MDD auto
 reset message before VF reset
In-Reply-To: <20200516003644.4658-2-anthony.l.nguyen@intel.com>
References: <20200516003644.4658-1-anthony.l.nguyen@intel.com>
 <20200516003644.4658-2-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB1659E660E6AFF8FF01D49FBC8CB40@DM5PR11MB1659.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Friday, May 15, 2020 5:37 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S43 02/15] ice: print Rx MDD auto reset
> message before VF reset
> 
> From: Paul Greenwalt <paul.greenwalt@intel.com>
> 
> Rx MDD auto reset message was not being logged because logging occurred
> after the VF reset and the VF MDD data was reinitialized.
> 
> Log the Rx MDD auto reset message before triggering the VF reset.
> 
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c     |  7 +++++-
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 25 ++++++++++++++-----
> .../net/ethernet/intel/ice/ice_virtchnl_pf.h  |  2 ++
>  3 files changed, 27 insertions(+), 7 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


