From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Thu, 30 Sep 2021 17:45:22 +0000
Subject: [Intel-wired-lan] [net-next 1/4] ice: devlink: add shadow-ram
 region to snapshot Shadow RAM
In-Reply-To: <20210908234924.3416592-2-jacob.e.keller@intel.com>
References: <20210908234924.3416592-1-jacob.e.keller@intel.com>
 <20210908234924.3416592-2-jacob.e.keller@intel.com>
Message-ID: <BYAPR11MB336740251CC04C039B4877C2FCAA9@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jacob Keller
> Sent: Thursday, September 9, 2021 5:19 AM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [net-next 1/4] ice: devlink: add shadow-ram region
> to snapshot Shadow RAM
> 
> We have a region for reading the contents of the NVM flash as a snapshot.
> This region does not allow reading the Shadow RAM, as it always passes the
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
