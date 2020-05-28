From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 28 May 2020 23:18:28 +0000
Subject: [Intel-wired-lan] [PATCH S46 3/9] ice: Fix inability to set
 channels when down
In-Reply-To: <20200516005506.5113-3-anthony.l.nguyen@intel.com>
References: <20200516005506.5113-1-anthony.l.nguyen@intel.com>
 <20200516005506.5113-3-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB1659AFD89009B1FAF8977F658C8E0@DM5PR11MB1659.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Friday, May 15, 2020 5:55 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S46 3/9] ice: Fix inability to set channels
> when down
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> Currently the driver prevents a user from doing modprobe ice ethtool -L eth0
> combined 5 ip link set eth0 up
> 
> The ethtool command fails, because the driver is checking to see if the
> interface is down before allowing the get_channels to proceed (even for a
> set_channels).
> 
> Remove this check and allow the user to configure the interface before
> bringing it up, which is a much better usability case.
> 
> Fixes: 87324e747fde ("ice: Implement ethtool ops for channels")
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 4 ----
>  1 file changed, 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


