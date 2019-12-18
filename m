From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 18 Dec 2019 22:34:35 +0000
Subject: [Intel-wired-lan] [PATCH S35 15/15] ice: Suppress Coverity
 warnings for xdp_rxq_info_reg
In-Reply-To: <20191212111307.33566-15-anthony.l.nguyen@intel.com>
References: <20191212111307.33566-1-anthony.l.nguyen@intel.com>
 <20191212111307.33566-15-anthony.l.nguyen@intel.com>
Message-ID: <e0b1b810ca2e4efea9e04e80b707ce05@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, December 12, 2019 3:13 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S35 15/15] ice: Suppress Coverity warnings
> for xdp_rxq_info_reg
> 
> From: Krzysztof Kazimierczak <krzysztof.kazimierczak@intel.com>
> 
> Coverity reports some of the calls to xdp_rxq_info_reg() as potential issues,
> because the driver does not check its return value. However, those calls are
> wrapped with "if (!xdp_rxq_info_is_reg(&ring->xdp_rxq))"
> and this check alone is enough to be sure that the function will never fail.
> 
> All possible states of xdp_rxq_info are:
>  - NEW,
>  - REGISTERED,
>  - UNREGISTERED,
>  - UNUSED.
> 
> The driver won't mark a queue as UNUSED under no circumstance, so the
> return value can be ignored safely.
> 
> Add comments for Coverity right above calls to xdp_rxq_info_reg() to
> suppress the warnings.
> 
> Signed-off-by: Krzysztof Kazimierczak <krzysztof.kazimierczak@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_base.c | 2 ++
>  1 file changed, 2 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


