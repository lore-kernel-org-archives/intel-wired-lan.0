From: Wyborny, Carolyn <carolyn.wyborny@intel.com>
Date: Wed, 21 Sep 2016 18:30:42 +0000
Subject: [Intel-wired-lan] [PATCH net-next 0/2] i40e: clean-up and fix
 for the i40e debug code
In-Reply-To: <1473946689-28427-1-git-send-email-sassmann@kpanic.de>
References: <1473946689-28427-1-git-send-email-sassmann@kpanic.de>
Message-ID: <9BBC4E0CF881AA4299206E2E1412B6265028E486@ORSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: netdev-owner at vger.kernel.org [mailto:netdev-owner at vger.kernel.org]
> On Behalf Of Stefan Assmann
> Sent: Thursday, September 15, 2016 6:38 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; davem at davemloft.net; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>; sassmann at kpanic.de
> Subject: [PATCH net-next 0/2] i40e: clean-up and fix for the i40e debug code
> 
> Stefan Assmann (2):
>   i40e: remove superfluous I40E_DEBUG_USER statement
>   i40e: fix setting debug parameter early
> 
>  drivers/net/ethernet/intel/i40e/i40e_common.c  |  3 --
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c |  6 ----
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c |  2 --
>  drivers/net/ethernet/intel/i40e/i40e_main.c    | 43 ++++++++++++--------------
>  drivers/net/ethernet/intel/i40e/i40e_type.h    |  2 --
>  5 files changed, 20 insertions(+), 36 deletions(-)
> 
> --
> 2.7.4
NACK

I'm not sure what problem is intended to be solved here.  This is code that enables output by the user using ethtool's msglvl feature.  I40E_DEBUG_USER is not superfluous is a mask for user input.
