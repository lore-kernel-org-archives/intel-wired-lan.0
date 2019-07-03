From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 3 Jul 2019 18:10:36 +0000
Subject: [Intel-wired-lan] [PATCH S23 v2 01/15] ice: Implement ethtool
 ops for channels
In-Reply-To: <20190628150332.59155-1-anthony.l.nguyen@intel.com>
References: <20190628150332.59155-1-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3FD0DE@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Friday, June 28, 2019 8:03 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S23 v2 01/15] ice: Implement ethtool ops
> for channels
> 
> From: Henry Tieman <henry.w.tieman@intel.com>
> 
> Add code to query and set the number of queues on the primary VSI for a
> PF. This is accessed from the 'ethtool -l' and 'ethtool -L'
> commands, respectively.
> 
> Signed-off-by: Henry Tieman <henry.w.tieman@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h         |   4 +
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c |   9 +-
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.h |   2 +
>  drivers/net/ethernet/intel/ice/ice_ethtool.c |  85 ++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_lib.c     |  52 ++++++++--
>  drivers/net/ethernet/intel/ice/ice_lib.h     |   2 +-
>  drivers/net/ethernet/intel/ice/ice_main.c    | 102 ++++++++++++++++++-
>  7 files changed, 237 insertions(+), 19 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


