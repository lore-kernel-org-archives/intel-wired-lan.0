From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 26 May 2020 20:22:42 +0000
Subject: [Intel-wired-lan] [PATCH S44 02/14] ice: Handle critical FW
 error during admin queue initialization
In-Reply-To: <20200516004226.4795-2-anthony.l.nguyen@intel.com>
References: <20200516004226.4795-1-anthony.l.nguyen@intel.com>
 <20200516004226.4795-2-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB16598FDE1B5A1B7488D4E26E8CB00@DM5PR11MB1659.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Friday, May 15, 2020 5:42 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S44 02/14] ice: Handle critical FW error
> during admin queue initialization
> 
> From: Evan Swanson <evan.swanson@intel.com>
> 
> A race condition between FW and SW can occur between admin queue setup
> and the first command sent. A link event may occur and FW attempts to
> notify a non-existent queue. FW will set the critical error bit and disable the
> queue. When this happens retry queue setup.
> 
> Signed-off-by: Evan Swanson <evan.swanson@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_controlq.c | 126 ++++++++++--------
>  drivers/net/ethernet/intel/ice/ice_controlq.h |   3 +
>  .../net/ethernet/intel/ice/ice_hw_autogen.h   |   2 +
>  drivers/net/ethernet/intel/ice/ice_main.c     |   2 +
>  drivers/net/ethernet/intel/ice/ice_status.h   |   1 +
>  5 files changed, 80 insertions(+), 54 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


