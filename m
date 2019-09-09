From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 9 Sep 2019 21:17:37 +0000
Subject: [Intel-wired-lan] [PATCH S29 v2 4/6] ice: Initialize DDP
 package structures
In-Reply-To: <20190906134626.37344-4-anthony.l.nguyen@intel.com>
References: <20190906134626.37344-1-anthony.l.nguyen@intel.com>
 <20190906134626.37344-4-anthony.l.nguyen@intel.com>
Message-ID: <00b5e04df3864e7fbbfda43fc92298f6@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Friday, September 6, 2019 6:46 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S29 v2 4/6] ice: Initialize DDP package
> structures
> 
> Add functions to initialize, parse, and clean structures representing the DDP
> package.
> 
> Upon completion of package download, read and store the DDP package
> contents to these structures.  This configuration is used to identify the
> default behavior and later used to update the HW table entries.
> 
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c   |   5 +-
>  .../net/ethernet/intel/ice/ice_flex_pipe.c    | 945 +++++++++++++++++-
>  .../net/ethernet/intel/ice/ice_flex_pipe.h    |   3 +
>  .../net/ethernet/intel/ice/ice_flex_type.h    |   2 +
>  4 files changed, 953 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


