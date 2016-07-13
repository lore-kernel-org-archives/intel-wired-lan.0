From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 13 Jul 2016 19:09:06 +0000
Subject: [Intel-wired-lan] [PATCH net-next] i40e: add missing link
 advertise	setting
In-Reply-To: <1467032623-1078-1-git-send-email-sassmann@kpanic.de>
References: <1467032623-1078-1-git-send-email-sassmann@kpanic.de>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9EA5CF@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Stefan Assmann
> Sent: Monday, June 27, 2016 6:04 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; davem at davemloft.net; sassmann at kpanic.de
> Subject: [Intel-wired-lan] [PATCH net-next] i40e: add missing link advertise
> setting
> 
> Adding the missing link advertise for some X710 NICs.
> This can be observed by simply calling ethtool on the interface.
> root at rhel7:~ # ethtool eth0
> Settings for eth0:
>         Supported ports: [ FIBRE ]
>         Supported link modes:   10000baseT/Full
>         Supported pause frame use: Symmetric
>         Supports auto-negotiation: No
>         Advertised link modes:  Not reported [...] With fix applied.
> root at rhel7:~ # ethtool eth0
> Settings for eth0:
>         Supported ports: [ FIBRE ]
>         Supported link modes:   10000baseT/Full
>         Supported pause frame use: Symmetric
>         Supports auto-negotiation: No
>         Advertised link modes:  10000baseT/Full [...]
> 
> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 1 +
>  1 file changed, 1 insertion(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
