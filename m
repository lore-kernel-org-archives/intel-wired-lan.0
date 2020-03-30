From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Mon, 30 Mar 2020 23:29:29 +0000
Subject: [Intel-wired-lan] [next-queue PATCH v3 1/2] igc: Add support
 for taprio offloading
In-Reply-To: <20200214235203.3910513-2-vinicius.gomes@intel.com>
References: <20200214235203.3910513-1-vinicius.gomes@intel.com>
 <20200214235203.3910513-2-vinicius.gomes@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9722CFA6@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Vinicius Costa Gomes
> Sent: Friday, February 14, 2020 3:52 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next-queue PATCH v3 1/2] igc: Add support for taprio
> offloading
> 
> Adds support for translating taprio schedules into i225 cycles. This
> will allow schedules to run in the hardware, making the schedules
> enforcement more precise and saving CPU time.
> 
> Right now, the only simple schedules are allowed, complex schedules are
> rejected. "simple" in this context are schedules that each HW queue is
> opened and closed only once in each cycle.
> 
> Changing schedules is still not supported as well.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/Makefile      |   2 +-
>  drivers/net/ethernet/intel/igc/igc.h         |   7 +
>  drivers/net/ethernet/intel/igc/igc_defines.h |  12 ++
>  drivers/net/ethernet/intel/igc/igc_main.c    | 113 +++++++++++++++
>  drivers/net/ethernet/intel/igc/igc_regs.h    |  12 ++
>  drivers/net/ethernet/intel/igc/igc_tsn.c     | 140 +++++++++++++++++++
>  drivers/net/ethernet/intel/igc/igc_tsn.h     |   9 ++
>  7 files changed, 294 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/intel/igc/igc_tsn.c
>  create mode 100644 drivers/net/ethernet/intel/igc/igc_tsn.h
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
