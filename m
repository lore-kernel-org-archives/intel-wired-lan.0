From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 12 Jan 2016 03:44:08 +0000
Subject: [Intel-wired-lan] [PATCH] igb: constify
	e1000_phy_operations	structure
In-Reply-To: <1451803496-16693-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1451803496-16693-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81E4D3B1@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [intel-wired-lan-bounces at lists.osuosl.org] on behalf of Julia Lawall [Julia.Lawall at lip6.fr]
> Sent: Saturday, January 02, 2016 10:44 PM
> To: Kirsher, Jeffrey T
> Cc: kernel-janitors at vger.kernel.org; linux-kernel at vger.kernel.org; intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH] igb: constify e1000_phy_operations   structure
> 
> This e1000_phy_operations structure is never modified, so declare it as
> const.  Other structures of this type are already const.
> 
> Done with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> ---
>  drivers/net/ethernet/intel/igb/e1000_82575.c |    2 +-
>  drivers/net/ethernet/intel/igb/e1000_hw.h    |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
