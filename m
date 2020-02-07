From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 7 Feb 2020 22:31:53 +0000
Subject: [Intel-wired-lan] [PATCH S37 v3 02/15] ice: Fix switch between
 FW and SW LLDP
In-Reply-To: <20200206092013.23388-2-anthony.l.nguyen@intel.com>
References: <20200206092013.23388-1-anthony.l.nguyen@intel.com>
 <20200206092013.23388-2-anthony.l.nguyen@intel.com>
Message-ID: <6f708d0f5ec545478fb4765c4040680f@intel.com>
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
> Subject: [Intel-wired-lan] [PATCH S37 v3 02/15] ice: Fix switch between FW
> and SW LLDP
> 
> From: Dave Ertman <david.m.ertman@intel.com>
> 
> When switching between FW and SW LLDP mode, the number of configured
> TLV apps in the driver's DCB configuration is getting out of synch with what
> lldpad thinks is configured.  This is causing a problem when shutting down
> lldpad.  The cleanup is trying to delete TLV apps that are not defined in the
> kernel.
> 
> Since the driver is keeping an accurate account of the apps defined, use the
> drivers number of apps to determine if there is an app to delete.
> If the number of apps is <= 1, then do not attempt to delete.
> 
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dcb_nl.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


