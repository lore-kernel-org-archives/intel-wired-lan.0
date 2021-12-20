From: Sreenivas, Bharathi <bharathi.sreenivas@intel.com>
Date: Mon, 20 Dec 2021 11:40:34 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2] ice: Add flow director
 support for channel mode
In-Reply-To: <20211213172511.1083932-1-sudheer.mogilappagari@intel.com>
References: <20211213172511.1083932-1-sudheer.mogilappagari@intel.com>
Message-ID: <MN2PR11MB36146F67D5192545677223C08E7B9@MN2PR11MB3614.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> sudheer.mogilappagari at intel.com
> Sent: Monday, December 13, 2021 10:55 PM
> To: intel-wired-lan at osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next v2] ice: Add flow director support for
> channel mode
> 
> From: Kiran Patil <kiran.patil@intel.com>
> 
> Add support to enable flow-director filter when multiple TCs are configured.
> Flow director filter can be configured using ethtool (--config-ntuple option).
> When multiple TCs are configured, each TC is mapped to an unique HW VSI. So
> VSI corresponding to queue used in filter is identified and flow director context is
> updated with correct VSI while configuring ntuple filter in HW.
> 
> Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
> Signed-off-by: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h          |   7 +-
>  .../net/ethernet/intel/ice/ice_ethtool_fdir.c | 260 +++++++++++++++++-
>  drivers/net/ethernet/intel/ice/ice_fdir.h     |   1 +
>  drivers/net/ethernet/intel/ice/ice_flow.c     |  51 ++++
>  drivers/net/ethernet/intel/ice/ice_flow.h     |   1 +
>  drivers/net/ethernet/intel/ice/ice_lib.c      |  69 ++++-
>  drivers/net/ethernet/intel/ice/ice_main.c     |  75 +++++
>  drivers/net/ethernet/intel/ice/ice_type.h     |   5 +-
>  8 files changed, 444 insertions(+), 25 deletions(-)
> 
Tested-by: Bharathi Sreenivas <bharathi.sreenivas@intel.com>
