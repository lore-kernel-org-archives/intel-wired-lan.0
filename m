From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 23 Jul 2020 01:25:16 +0000
Subject: [Intel-wired-lan] [PATCH S49 09/15] ice: support Total Port
 Shutdown on devices that support it
In-Reply-To: <20200709161614.61098-9-anthony.l.nguyen@intel.com>
References: <20200709161614.61098-1-anthony.l.nguyen@intel.com>
 <20200709161614.61098-9-anthony.l.nguyen@intel.com>
Message-ID: <BN6PR1101MB2145CE86EBFA74E799E9B71F8C760@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Thursday, July 9, 2020 9:16 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S49 09/15] ice: support Total Port
> Shutdown on devices that support it
> 
> From: Bruce Allan <bruce.w.allan@intel.com>
> 
> When the Port Disable bit is set in the Link Default Override Mask TLV PFA
> module in the NVM, Total Port Shutdown mode is supported and enabled.
> In this mode, the driver should act as if the link-down-on-close ethool private
> flag is always enabled and dis-allow any change to that flag.
> 
> Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h         |  1 +
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 12 ++++++++++++
>  drivers/net/ethernet/intel/ice/ice_main.c    | 14 +++++++++++++-
>  3 files changed, 26 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


