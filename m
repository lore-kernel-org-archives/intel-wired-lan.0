From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 23 Jan 2020 00:11:04 +0000
Subject: [Intel-wired-lan] [PATCH S36 5/8] ice: Optimize table usage
In-Reply-To: <20200117153919.50321-5-anthony.l.nguyen@intel.com>
References: <20200117153919.50321-1-anthony.l.nguyen@intel.com>
 <20200117153919.50321-5-anthony.l.nguyen@intel.com>
Message-ID: <0eb40cfb8b6249b1b191a6225e27edea@intel.com>
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
> Subject: [Intel-wired-lan] [PATCH S36 5/8] ice: Optimize table usage
> 
> Attempt to optimize TCAM entries and reduce table resource usage by
> searching for profiles that can be reused. Provide resource cleanup of both
> hardware and software structures.
> 
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Signed-off-by: Henry Tieman <henry.w.tieman@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_flex_pipe.c    | 394 ++++++++++++++++++
>  .../net/ethernet/intel/ice/ice_flex_pipe.h    |   4 +
>  drivers/net/ethernet/intel/ice/ice_flow.c     | 338 +++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_flow.h     |  10 +
>  drivers/net/ethernet/intel/ice/ice_lib.c      |  28 +-
>  5 files changed, 773 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


