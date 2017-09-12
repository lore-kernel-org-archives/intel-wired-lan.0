From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 12 Sep 2017 20:30:50 +0000
Subject: [Intel-wired-lan] [next PATCH S80-V3 03/11] i40e/i40evf:
	fix	incorrect default ITR values on driver load
In-Reply-To: <20170907120556.45699-3-alice.michael@intel.com>
References: <20170907120556.45699-1-alice.michael@intel.com>
 <20170907120556.45699-3-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAA0B1@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Thursday, September 7, 2017 5:06 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S80-V3 03/11] i40e/i40evf: fix
> incorrect default ITR values on driver load
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The ITR register expects to be programmed in units of 2 microseconds.
> Because of this, all of the drivers I40E_ITR_* constants are in terms of this 2
> microsecond register.
> 
> Unfortunately, the rx_itr_default value is expected to be programmed in
> microseconds.
> 
> Effectively the driver defaults to an ITR value of half the expected value (in
> terms of minimum microseconds between interrupts).
> 
> Fix this by changing the default values to be calculated using
> ITR_REG_TO_USEC macro which indicates that we're converting from the
> register units into microseconds.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c     | 4 ++--
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h     | 6 ++++--
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.h   | 6 ++++--
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 4 ++--
>  4 files changed, 12 insertions(+), 8 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


