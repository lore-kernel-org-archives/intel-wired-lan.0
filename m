From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 14 Dec 2019 01:25:17 +0000
Subject: [Intel-wired-lan] [next-queue PATCH v3 1/5] igc: Add basic
 skeleton for PTP
In-Reply-To: <20191202231953.2203397-2-vinicius.gomes@intel.com>
References: <20191202231953.2203397-1-vinicius.gomes@intel.com>
 <20191202231953.2203397-2-vinicius.gomes@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9719B433@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Vinicius Costa Gomes
> Sent: Monday, December 2, 2019 3:20 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next-queue PATCH v3 1/5] igc: Add basic skeleton
> for PTP
> 
> This allows the creation of the /dev/ptpX device for i225, and reading
> and writing the time.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/Makefile      |   2 +-
>  drivers/net/ethernet/intel/igc/igc.h         |  26 ++
>  drivers/net/ethernet/intel/igc/igc_defines.h |  12 +
>  drivers/net/ethernet/intel/igc/igc_main.c    |  27 ++
>  drivers/net/ethernet/intel/igc/igc_ptp.c     | 349 +++++++++++++++++++
>  drivers/net/ethernet/intel/igc/igc_regs.h    |  24 ++
>  6 files changed, 439 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/intel/igc/igc_ptp.c
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
