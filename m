From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 6 Mar 2017 17:37:38 +0000
Subject: [Intel-wired-lan] [PATCH] net: intel: i40e: use new
	api	ethtool_{get|set}_link_ksettings
In-Reply-To: <1486242306-10111-1-git-send-email-tremyfr@gmail.com>
References: <1486242306-10111-1-git-send-email-tremyfr@gmail.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10401CF7@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Philippe Reynes
> Sent: Saturday, February 4, 2017 1:05 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; davem at davemloft.net
> Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org; linux-
> kernel at vger.kernel.org; Philippe Reynes <tremyfr@gmail.com>
> Subject: [Intel-wired-lan] [PATCH] net: intel: i40e: use new api
> ethtool_{get|set}_link_ksettings
> 
> The ethtool api {get|set}_settings is deprecated.
> We move this driver to new api {get|set}_link_ksettings.
> 
> As I don't have the hardware, I'd be very pleased if someone may test this
> patch.
> 
> Signed-off-by: Philippe Reynes <tremyfr@gmail.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c |  224 ++++++++++++++-----
> -----
>  1 files changed, 133 insertions(+), 91 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


