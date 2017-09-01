From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 1 Sep 2017 18:37:16 +0000
Subject: [Intel-wired-lan] [next PATCH S79-V2 11/13] i40e: do not enter
 PHY	debug mode while setting LEDs behaviour
In-Reply-To: <20170829093242.41026-11-alice.michael@intel.com>
References: <20170829093242.41026-1-alice.michael@intel.com>
 <20170829093242.41026-11-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EA9695@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Tuesday, August 29, 2017 2:33 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Stachura, Mariusz <mariusz.stachura@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S79-V2 11/13] i40e: do not enter PHY
> debug mode while setting LEDs behaviour
> 
> From: Mariusz Stachura <mariusz.stachura@intel.com>
> 
> Previous implementation of LED set/get functions required to enter PHY
> debug mode, in order to prevent access to it from FW and SW at the same
> time. Reset of all ports was a unwanted side effect.
> 
> Signed-off-by: Mariusz Stachura <mariusz.stachura@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


