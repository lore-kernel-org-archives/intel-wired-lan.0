From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 23 Jan 2020 00:10:11 +0000
Subject: [Intel-wired-lan] [PATCH S36 3/8] ice: Populate TCAM filter
 software structures
In-Reply-To: <20200117153919.50321-3-anthony.l.nguyen@intel.com>
References: <20200117153919.50321-1-anthony.l.nguyen@intel.com>
 <20200117153919.50321-3-anthony.l.nguyen@intel.com>
Message-ID: <f3aa1cd2c6f74d2db684e41930204454@intel.com>
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
> Subject: [Intel-wired-lan] [PATCH S36 3/8] ice: Populate TCAM filter software
> structures
> 
> Store the TCAM entry with the profile data and the VSI group in the
> respective SW structures. This will be subsequently used to write out the
> tables to hardware.
> 
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Signed-off-by: Henry Tieman <henry.w.tieman@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   |    1 +
>  drivers/net/ethernet/intel/ice/ice_common.c   |   33 +
>  drivers/net/ethernet/intel/ice/ice_common.h   |    2 +
>  .../net/ethernet/intel/ice/ice_flex_pipe.c    | 1318 +++++++++++++++++
>  .../net/ethernet/intel/ice/ice_flex_pipe.h    |    2 +
>  .../net/ethernet/intel/ice/ice_flex_type.h    |   51 +
>  drivers/net/ethernet/intel/ice/ice_flow.c     |   61 +-
>  drivers/net/ethernet/intel/ice/ice_status.h   |    1 +
>  8 files changed, 1459 insertions(+), 10 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


