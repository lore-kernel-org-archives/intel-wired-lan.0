From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 24 Jan 2020 23:17:07 +0000
Subject: [Intel-wired-lan] [PATCH S37 02/15] ice: Fix switch between FW
 and SW LLDP
In-Reply-To: <20200122152041.41498-2-anthony.l.nguyen@intel.com>
References: <20200122152041.41498-1-anthony.l.nguyen@intel.com>
 <20200122152041.41498-2-anthony.l.nguyen@intel.com>
Message-ID: <f36e6fafc0e1406e8fd14f3e73c4d3d9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, January 22, 2020 7:20 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S37 02/15] ice: Fix switch between FW and
> SW LLDP
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


