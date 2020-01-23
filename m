From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 23 Jan 2020 00:09:07 +0000
Subject: [Intel-wired-lan] [PATCH S36 1/8] ice: Enable writing hardware
 filtering tables
In-Reply-To: <20200117153919.50321-1-anthony.l.nguyen@intel.com>
References: <20200117153919.50321-1-anthony.l.nguyen@intel.com>
Message-ID: <3299008f7b994321841a8e30bb022229@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Friday, January 17, 2020 7:39 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S36 1/8] ice: Enable writing hardware
> filtering tables
> 
> Enable the driver to write the filtering hardware tables to allow for changing
> of RSS rules. Upon loading of DDP package, a minimal configuration should be
> written to hardware.
> 
> Introduce and initialize structures for storing configuration and make the top
> level calls to configure the RSS tables to initial values. A packet segment will
> be created but nothing is written to hardware yet.
> 
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Signed-off-by: Henry Tieman <henry.w.tieman@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/Makefile       |   3 +-
>  drivers/net/ethernet/intel/ice/ice_common.c   |   6 +-
>  .../net/ethernet/intel/ice/ice_flex_pipe.c    |  31 ++-
>  drivers/net/ethernet/intel/ice/ice_flow.c     | 250 ++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_flow.h     | 114 ++++++++
>  drivers/net/ethernet/intel/ice/ice_lib.c      |  87 +++++-
>  drivers/net/ethernet/intel/ice/ice_type.h     |   4 +
>  7 files changed, 491 insertions(+), 4 deletions(-)  create mode 100644
> drivers/net/ethernet/intel/ice/ice_flow.c
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_flow.h

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


