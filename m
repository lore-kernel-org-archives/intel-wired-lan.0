From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 26 Jul 2019 18:16:14 +0000
Subject: [Intel-wired-lan] [PATCH S24 03/12] ice: Don't call
 synchronize_irq() for VF's from the host
In-Reply-To: <20190723092759.3614-3-anthony.l.nguyen@intel.com>
References: <20190723092759.3614-1-anthony.l.nguyen@intel.com>
 <20190723092759.3614-3-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40CD93@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Tuesday, July 23, 2019 2:28 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S24 03/12] ice: Don't call synchronize_irq()
> for VF's from the host
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently we will call synchronize_irq() from the host for VF's. This is not
> correct, so don't allow it.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 4 ++++
>  1 file changed, 4 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


