From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 21 Sep 2016 17:50:21 +0000
Subject: [Intel-wired-lan] [PATCH net-next 1/2] i40e: remove
	superfluous	I40E_DEBUG_USER statement
In-Reply-To: <1473946689-28427-2-git-send-email-sassmann@kpanic.de>
References: <1473946689-28427-1-git-send-email-sassmann@kpanic.de>
 <1473946689-28427-2-git-send-email-sassmann@kpanic.de>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA0E53C@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH net-next 1/2] i40e: remove superfluous
> I40E_DEBUG_USER statement
> 
> This debug statement is confusing and never set in the code. Any debug
> output should be guarded by the proper I40E_DEBUG_* statement which
> can be enabled via the debug module parameter.
> Remove or convert the I40E_DEBUG_USER cases to I40E_DEBUG_INIT.
> 
> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c  |  3 ---
> drivers/net/ethernet/intel/i40e/i40e_debugfs.c |  6 -----
> drivers/net/ethernet/intel/i40e/i40e_ethtool.c |  2 --
>  drivers/net/ethernet/intel/i40e/i40e_main.c    | 35 +++++++++++++----------
> ---
>  drivers/net/ethernet/intel/i40e/i40e_type.h    |  2 --
>  5 files changed, 17 insertions(+), 31 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


