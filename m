From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 5 Jan 2018 19:30:16 +0000
Subject: [Intel-wired-lan] [next PATCH S85-V1 10/14] i40e/i40evf: Don't
 bother setting the CLEARPBA bit
In-Reply-To: <20171229135055.14598-1-alice.michael@intel.com>
References: <20171229135055.14598-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A8D7257@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, December 29, 2017 5:51 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S85-V1 10/14] i40e/i40evf: Don't
> bother setting the CLEARPBA bit
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> The CLEARPBA bit in the dynamic interrupt control register actually has no
> effect either way on the hardware. As per errata 28 in the XL710 specification
> update the interrupt is actually cleared any time the register is written with
> the INTENA_MSK bit set to 0. As such the act of toggling the enable bit
> actually will trigger the interrupt being cleared and could lead to potential lost
> events if auto-masking is not enabled.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 11 ++++++++++-
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 11 ++++++++++-
>  2 files changed, 20 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


