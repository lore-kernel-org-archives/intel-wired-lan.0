From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 21 Sep 2016 17:14:22 +0000
Subject: [Intel-wired-lan] [PATCH net-next 2/2] i40e: fix setting
	debug	parameter early
In-Reply-To: <1473946689-28427-3-git-send-email-sassmann@kpanic.de>
References: <1473946689-28427-1-git-send-email-sassmann@kpanic.de>
 <1473946689-28427-3-git-send-email-sassmann@kpanic.de>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA0E4C1@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Stefan Assmann
> Sent: Thursday, September 15, 2016 6:38 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; davem at davemloft.net; sassmann at kpanic.de
> Subject: [Intel-wired-lan] [PATCH net-next 2/2] i40e: fix setting debug
> parameter early
> 
> pf->msg_enable is a bitmask, therefore assigning the value of the
> "debug" parameter is wrong. It is initialized again later in
> i40e_sw_init() so it didn't cause any problem, except that we missed early
> debug messages. Moved the initialization and assigned
> pf->hw.debug_mask the bitmask as that's what the driver actually uses
> in i40e_debug(). Otherwise the debug parameter is just a noop.
> 
> Fixes: 5b5faa4 ("i40e: enable debug earlier")
> 
> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


