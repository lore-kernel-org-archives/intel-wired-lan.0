From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 4 Jan 2018 22:17:18 +0000
Subject: [Intel-wired-lan] [next PATCH S84-V2 08/13] i40e: fix FW_LLDP
 flag on init
In-Reply-To: <20171227131919.23924-1-alice.michael@intel.com>
References: <20171227131919.23924-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A8D7047@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, December 27, 2017 5:19 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S84-V2 08/13] i40e: fix FW_LLDP flag
> on init
> 
> From: Alan Brady <alan.brady@intel.com>
> 
> Using ethtool --set-priv-flags disable-fw-lldp <on/off> is persistent across
> reboots/reloads so we need some mechanism in the driver to detect if it's on
> or off on init so we can set the ethtool private flag appropriately.  Without
> this, every time the driver is reloaded the flag will default to off regardless of
> whether it's on or off in FW.
> 
> We detect this by first attempting to program DCB and if AQ fails returning
> I40E_AQ_RC_EPERM, we know that LLDP is disabled in FW.
> 
> Signed-off-by: Alan Brady <alan.brady@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 3 +++
>  1 file changed, 3 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


