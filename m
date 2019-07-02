From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 2 Jul 2019 22:46:55 +0000
Subject: [Intel-wired-lan] [PATCH S22 02/16] ice: track hardware stat
 registers past rollover
In-Reply-To: <20190626092027.52845-2-anthony.l.nguyen@intel.com>
References: <20190626092027.52845-1-anthony.l.nguyen@intel.com>
 <20190626092027.52845-2-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3FBDC0@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH S22 02/16] ice: track hardware stat registers
> past rollover
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Currently, ice_stat_update32 and ice_stat_update40 will limit the value of
> the software statistic to 32 or 40 bits wide, depending on which register is
> being read.
> 
> This means that if a driver is running for a long time, the displayed software
> register values will roll over to zero at 40 bits or 32 bits.
> 
> This occurs because the functions directly assign the difference between the
> previous value and current value of the hardware statistic.
> 
> Instead, add this value to the current software statistic, and then update the
> previous value.
> 
> In this way, each time ice_stat_update40 or ice_stat_update32 are called,
> they will increment the software tracking value by the difference of the
> hardware register from its last read. The software tracking value will correctly
> count up until it overflows a u64.
> 
> The only requirement is that the ice_stat_update functions be called at least
> once each time the hardware register overflows.
> 
> While we're fixing ice_stat_update40, modify it to use rd64 instead of two
> calls to rd32. Additionally, drop the now unnecessary hireg function
> parameter.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c   | 57 +++++++-----
>  drivers/net/ethernet/intel/ice/ice_common.h   |  4 +-
>  .../net/ethernet/intel/ice/ice_hw_autogen.h   | 30 -------
>  drivers/net/ethernet/intel/ice/ice_lib.c      | 40 ++++-----
>  drivers/net/ethernet/intel/ice/ice_main.c     | 90 ++++++++-----------
>  5 files changed, 91 insertions(+), 130 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


