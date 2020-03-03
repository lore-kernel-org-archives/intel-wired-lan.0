From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 3 Mar 2020 19:10:13 +0000
Subject: [Intel-wired-lan] [PATCH S40 14/15] ice: use variable name more
 descriptive than type
In-Reply-To: <20200227181505.61720-14-anthony.l.nguyen@intel.com>
References: <20200227181505.61720-1-anthony.l.nguyen@intel.com>
 <20200227181505.61720-14-anthony.l.nguyen@intel.com>
Message-ID: <edbbf198c07146e4a5913d60628a3ac1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, February 27, 2020 10:15 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S40 14/15] ice: use variable name more
> descriptive than type
> 
> From: Bruce Allan <bruce.w.allan@intel.com>
> 
> The variable name 'type' is not very descriptive. Replace instances of those
> with a variable name that is more descriptive or replace it if not needed.
> 
> Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 16 ++++++-------
>  drivers/net/ethernet/intel/ice/ice_flow.c    |  8 +++----
>  drivers/net/ethernet/intel/ice/ice_lib.c     | 24 ++++++++++----------
>  drivers/net/ethernet/intel/ice/ice_lib.h     |  4 ++--
>  drivers/net/ethernet/intel/ice/ice_switch.c  | 20 ++++++++--------
>  5 files changed, 36 insertions(+), 36 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


