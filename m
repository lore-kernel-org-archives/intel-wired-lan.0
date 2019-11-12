From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 12 Nov 2019 19:36:30 +0000
Subject: [Intel-wired-lan] [PATCH S33 13/15] ice: Implement ethtool ops
 for channels
In-Reply-To: <20191108142331.10221-13-anthony.l.nguyen@intel.com>
References: <20191108142331.10221-1-anthony.l.nguyen@intel.com>
 <20191108142331.10221-13-anthony.l.nguyen@intel.com>
Message-ID: <0b6331348a80494691d1a6eb78ad4f9f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Friday, November 8, 2019 6:23 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S33 13/15] ice: Implement ethtool ops for
> channels
> 
> From: Henry Tieman <henry.w.tieman@intel.com>
> 
> Add code to query and set the number of channels on the primary VSI for a
> PF. This is accessed from the 'ethtool -l' and 'ethtool -L' commands,
> respectively.  Though the ice driver supports asymmetric queues report an
> IRQ vector that has both Rx and Tx queues attached and is counted as a
> 'combined' channel.
> 
> Signed-off-by: Henry Tieman <henry.w.tieman@intel.com>
> Co-developed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h         |   4 +
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c |   4 +-
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.h |   2 +
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 194 +++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_lib.c     |  70 +++++--
>  drivers/net/ethernet/intel/ice/ice_lib.h     |   2 +-
>  drivers/net/ethernet/intel/ice/ice_main.c    |  87 ++++++++-
>  7 files changed, 344 insertions(+), 19 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


