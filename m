From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 3 Jul 2019 18:15:53 +0000
Subject: [Intel-wired-lan] [PATCH S23 v2 09/15] ice: Do not always bring
 up PF VSI in ice_ena_vsi()
In-Reply-To: <20190628150332.59155-9-anthony.l.nguyen@intel.com>
References: <20190628150332.59155-1-anthony.l.nguyen@intel.com>
 <20190628150332.59155-9-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3FD163@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Friday, June 28, 2019 8:03 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S23 v2 09/15] ice: Do not always bring up PF
> VSI in ice_ena_vsi()
> 
> During rebuild ice_ena_vsi() is called to recover the VSI state.
> This function assumes the PF VSI is always to be enabled, however, it's
> possible that during reset/rebuild the interface can be brought down.  If this
> occurs, we can attempt to bring up the PF VSI on a downed interface which
> can lead to various crashes. If the interface is not running, do not bring up the
> associated VSI.
> 
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 2 --
>  1 file changed, 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


