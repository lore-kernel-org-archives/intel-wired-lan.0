From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 16 Oct 2019 16:16:39 +0000
Subject: [Intel-wired-lan] [PATCH S31 01/15] ice: implement set_eeprom
 functionality
In-Reply-To: <20191009140953.14087-1-anthony.l.nguyen@intel.com>
References: <20191009140953.14087-1-anthony.l.nguyen@intel.com>
Message-ID: <20f3ca4b838942cf92c6b6e5d0cb4d30@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, October 9, 2019 7:10 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S31 01/15] ice: implement set_eeprom
> functionality
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> The driver needs set_eeprom to work so that it can program the onboard
> NVM using our update application.
> 
> Add functions that are necessary to enable reading the NVM image.  They
> implement basic functionality to lock, read, unlock during an NVM read.  Also
> remove shadow ram functionality since it is no longer used. In addition move
> a few function declarations into ice_nvm.h.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Co-developed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   3 +
>  drivers/net/ethernet/intel/ice/ice_common.h   |   4 +-
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  | 125 ++++++-
>  .../net/ethernet/intel/ice/ice_hw_autogen.h   |   2 +
>  drivers/net/ethernet/intel/ice/ice_lib.c      |  24 ++
>  drivers/net/ethernet/intel/ice/ice_lib.h      |   2 +
>  drivers/net/ethernet/intel/ice/ice_nvm.c      | 341 +++++++++++++-----
>  drivers/net/ethernet/intel/ice/ice_nvm.h      |  79 ++++
>  8 files changed, 468 insertions(+), 112 deletions(-)  create mode 100644
> drivers/net/ethernet/intel/ice/ice_nvm.h

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


