From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 22 May 2020 19:31:10 +0000
Subject: [Intel-wired-lan] [PATCH S43 05/15] ice: check for
 compatibility between DDP package and firmware
In-Reply-To: <20200516003644.4658-5-anthony.l.nguyen@intel.com>
References: <20200516003644.4658-1-anthony.l.nguyen@intel.com>
 <20200516003644.4658-5-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB1659F8573E93E83CA7619B188CB40@DM5PR11MB1659.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Friday, May 15, 2020 5:37 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S43 05/15] ice: check for compatibility
> between DDP package and firmware
> 
> From: Victor Raj <victor.raj@intel.com>
> 
> Require the Dynamic Device Personalization (DDP) file to have the same
> major version number and the same or older minor number than the
> firmware version major and minor, respectively.
> 
> Check the OS and NVM package versions before downloading the package.
> If the OS package version is not compatible with NVM then return an
> appropriate error.
> 
> Split the 32-byte segment name into a 28-byte segment name and a 4-byte
> Track-ID. Older packages will still work with this change because no package
> has a name that will take up more than 28 bytes; in this case the Track-ID will
> be 0.
> 
> Note that the driver will store the segment name as 32-bytes in the ice_hw
> structure, in order to normalize the length of the various package name
> strings that it uses.
> 
> Also add section ID and structure for the segment metadata section.
> 
> Signed-off-by: Victor Raj <victor.raj@intel.com>
> Signed-off-by: Dan Nowlin <dan.nowlin@intel.com>
> Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   4 +-
>  .../net/ethernet/intel/ice/ice_flex_pipe.c    | 112 ++++++++++++++----
>  .../net/ethernet/intel/ice/ice_flex_type.h    |   8 +-
>  drivers/net/ethernet/intel/ice/ice_main.c     |   5 +
>  drivers/net/ethernet/intel/ice/ice_status.h   |   2 +
>  drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
>  6 files changed, 102 insertions(+), 30 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


