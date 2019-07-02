From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 2 Jul 2019 22:58:53 +0000
Subject: [Intel-wired-lan] [PATCH S22 13/16] ice: Don't return error for
 disabling LAN Tx queue that does exist
In-Reply-To: <20190626092027.52845-13-anthony.l.nguyen@intel.com>
References: <20190626092027.52845-1-anthony.l.nguyen@intel.com>
 <20190626092027.52845-13-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3FBE74@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, June 26, 2019 2:20 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Abodunrin, Akeem G <akeem.g.abodunrin@intel.com>
> Subject: [Intel-wired-lan] [PATCH S22 13/16] ice: Don't return error for
> disabling LAN Tx queue that does exist
> 
> From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> 
> Since Tx rings are being managed by FW/NVM, Tx rings might have not been
> set up or driver had already wiped them off - In that case, call to disable LAN
> Tx queue is being returned as not in existence. This patch makes sure we
> don't return unnecessary error for such scenario.
> 
> Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 3 +++
>  1 file changed, 3 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


