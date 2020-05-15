From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 15 May 2020 19:41:05 +0000
Subject: [Intel-wired-lan] [PATCH S41 04/15] ice: only drop link once
 when setting pauseparams
In-Reply-To: <20200508004113.39725-4-anthony.l.nguyen@intel.com>
References: <20200508004113.39725-1-anthony.l.nguyen@intel.com>
 <20200508004113.39725-4-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB1659C7D2934B06BBE86D14FA8CBD0@DM5PR11MB1659.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH S41 04/15] ice: only drop link once when
> setting pauseparams
> 
> From: Dave Ertman <david.m.ertman@intel.com>
> 
> Currently, the ice driver is setting a PHY configuration, which causes a link
> drop, and then additionally it calls for a nway_reset, which restarts auto-
> negotiation on the link, which also causes a link drop.  These two link events
> in such close timing is causing the FW to not be able to generate a link
> interrupt for the driver to respond to.
> 
> Remove the unnecessary auto-negotiation restart from the set pauseparams
> flow.  Also remove error path that would have performed an
> ice_down/ice_up as that is also unnecessary.
> 
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 12 ------------
>  1 file changed, 12 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


