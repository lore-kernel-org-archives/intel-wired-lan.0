From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 7 Feb 2020 22:33:45 +0000
Subject: [Intel-wired-lan] [PATCH S37 v3 08/15] ice: fix and consolidate
 logging of NVM/firmware version information
In-Reply-To: <20200206092013.23388-8-anthony.l.nguyen@intel.com>
References: <20200206092013.23388-1-anthony.l.nguyen@intel.com>
 <20200206092013.23388-8-anthony.l.nguyen@intel.com>
Message-ID: <476631e6a7d046ffa7ffc74fec908750@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, February 6, 2020 1:20 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S37 v3 08/15] ice: fix and consolidate
> logging of NVM/firmware version information
> 
> From: Bruce Allan <bruce.w.allan@intel.com>
> 
> Logging the firmware/NVM information during driver load is redundant since
> that information is also available via ethtool.  Move the functionality found in
> ice_nvm_version_str() directly into ice_get_drvinfo() and remove calling the
> former and logging that info during driver probe.  This also gets rid of a bug in
> ice_nvm_version_str() where it returns a pointer to a buffer which is free'ed
> when that function exits.
> 
> Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 15 +++++++++++++--
>  drivers/net/ethernet/intel/ice/ice_lib.c     | 19 -------------------
>  drivers/net/ethernet/intel/ice/ice_lib.h     |  2 --
>  drivers/net/ethernet/intel/ice/ice_main.c    |  5 -----
>  4 files changed, 13 insertions(+), 28 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


