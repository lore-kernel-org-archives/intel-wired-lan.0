From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Thu, 14 Oct 2021 22:17:08 +0000
Subject: [Intel-wired-lan] [net-next PATCH v2 1/4] ice: devlink: add
 shadow-ram region to snapshot Shadow RAM
In-Reply-To: <20211012004113.1583133-2-jacob.e.keller@intel.com>
References: <20211012004113.1583133-1-jacob.e.keller@intel.com>
 <20211012004113.1583133-2-jacob.e.keller@intel.com>
Message-ID: <BYAPR11MB3367BCF77AD52F22403E5D47FCB89@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jacob Keller
> Sent: Tuesday, October 12, 2021 6:11 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Intel Wired LAN <intel-
> wired-lan at lists.osuosl.org>
> Subject: [Intel-wired-lan] [net-next PATCH v2 1/4] ice: devlink: add shadow-ram
> region to snapshot Shadow RAM
> 
> We have a region for reading the contents of the NVM flash as a snapshot. This
> region does not allow reading the Shadow RAM, as it always passes the
> FLASH_ONLY bit to the low level firmware interface.
> 
> Add a separate shadow-ram region which will allow snapshot of the current
> contents of the Shadow RAM. This data is built from the NVM contents but is
> distinct as the device builds up the Shadow RAM during initialization, so being
> able to snapshot its contents can be useful when attempting to debug flash
> related issues.
> 
> Fix the comment description of the nvm-flash region which incorrectly stated
> that it filled the shadow-ram region, and add a comment explaining that the
> nvm-flash region does not actually read the Shadow RAM.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h         |  1 +
>  drivers/net/ethernet/intel/ice/ice_devlink.c | 93 ++++++++++++++++++--
>  2 files changed, 89 insertions(+), 5 deletions(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
