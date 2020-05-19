From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 19 May 2020 16:35:19 +0000
Subject: [Intel-wired-lan] [PATCH S42 1/7] ice: Initialize Flow Director
 resources
In-Reply-To: <20200512010146.41303-1-anthony.l.nguyen@intel.com>
References: <20200512010146.41303-1-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB1659EC231376B8A6430C0CAE8CB90@DM5PR11MB1659.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH S42 1/7] ice: Initialize Flow Director
> resources
> 
> From: Henry Tieman <henry.w.tieman@intel.com>
> 
> Flow Director allows for redirection based on ntuple rules. Rules are
> programmed using the ethtool set-ntuple interface. Supported actions are
> redirect to queue and drop.
> 
> Setup the initial framework to process Flow Director filters. Create and
> allocate resources to manage and program filters to the hardware. Filters
> are processed via a sideband interface; a control VSI is created to manage
> communication and process requests through the sideband. Upon allocation
> of
> resources, update the hardware tables to accept perfect filters.
> 
> Signed-off-by: Henry Tieman <henry.w.tieman@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/Makefile       |   2 +
>  drivers/net/ethernet/intel/ice/ice.h          |  24 ++
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   9 +
>  drivers/net/ethernet/intel/ice/ice_base.c     |   1 +
>  drivers/net/ethernet/intel/ice/ice_common.c   |  36 ++
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  |  11 +-
>  .../net/ethernet/intel/ice/ice_ethtool_fdir.c | 399 ++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_fdir.c     |  54 +++
>  drivers/net/ethernet/intel/ice/ice_fdir.h     |  12 +
>  .../net/ethernet/intel/ice/ice_flex_pipe.c    | 224 ++++++++++
>  drivers/net/ethernet/intel/ice/ice_flow.c     | 169 +++++++-
>  drivers/net/ethernet/intel/ice/ice_flow.h     |  32 +-
>  .../net/ethernet/intel/ice/ice_hw_autogen.h   |  11 +
>  drivers/net/ethernet/intel/ice/ice_lib.c      | 210 +++++++--
>  drivers/net/ethernet/intel/ice/ice_lib.h      |   2 +
>  drivers/net/ethernet/intel/ice/ice_main.c     | 160 ++++++-
>  .../ethernet/intel/ice/ice_protocol_type.h    |   1 +
>  drivers/net/ethernet/intel/ice/ice_switch.c   |  75 ++++
>  drivers/net/ethernet/intel/ice/ice_switch.h   |   7 +
>  drivers/net/ethernet/intel/ice/ice_txrx.c     | 100 ++++-
>  drivers/net/ethernet/intel/ice/ice_txrx.h     |   7 +-
>  drivers/net/ethernet/intel/ice/ice_type.h     |  45 +-
>  22 files changed, 1552 insertions(+), 39 deletions(-)
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_fdir.c
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_fdir.h


Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


