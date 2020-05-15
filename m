From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 15 May 2020 19:48:40 +0000
Subject: [Intel-wired-lan] [PATCH S41 15/15] ice: Rename build_ctob to
 ice_build_ctob
In-Reply-To: <20200508004113.39725-15-anthony.l.nguyen@intel.com>
References: <20200508004113.39725-1-anthony.l.nguyen@intel.com>
 <20200508004113.39725-15-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB16595BCE1233A739C55C29698CBD0@DM5PR11MB1659.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Thursday, May 7, 2020 5:41 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S41 15/15] ice: Rename build_ctob to
> ice_build_ctob
> 
> To make the function easier to identify as being part of the ice driver,
> prepend ice to the function name.
> 
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_txrx.c     | 11 ++++++-----
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.c |  4 ++--
> drivers/net/ethernet/intel/ice/ice_txrx_lib.h |  2 +-
>  drivers/net/ethernet/intel/ice/ice_xsk.c      |  4 ++--
>  4 files changed, 11 insertions(+), 10 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


