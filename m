From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 28 Jun 2017 22:37:21 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: handle setting administratively
 set	MAC address back to zero
In-Reply-To: <20170623074624.32405-1-sassmann@kpanic.de>
References: <20170623074624.32405-1-sassmann@kpanic.de>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DAC01E@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Stefan Assmann
> Sent: Friday, June 23, 2017 12:46 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; davem at davemloft.net; sassmann at kpanic.de
> Subject: [Intel-wired-lan] [PATCH] i40e: handle setting administratively set
> MAC address back to zero
> 
> When an administratively set MAC was previously set and should now be
> switched back to 00:00:00:00:00:00 the pf_set_mac flag did not get toggled
> back to false.
> As a result VFs were still treated as if an administratively set MAC was
> present.
> 
> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


