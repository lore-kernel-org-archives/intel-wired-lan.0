From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 1 Feb 2020 02:02:38 +0000
Subject: [Intel-wired-lan] [PATCH v1] igc: Add dump options
In-Reply-To: <20200114075554.14538-1-sasha.neftin@intel.com>
References: <20200114075554.14538-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B971D26A5@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Sasha Neftin
> Sent: Monday, January 13, 2020 11:56 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v1] igc: Add dump options
> 
> Placeholder for debugging functionality.
> In this patch, we add some registers and rings summary dumps.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/Makefile      |   2 +-
>  drivers/net/ethernet/intel/igc/igc.h         |   4 +
>  drivers/net/ethernet/intel/igc/igc_defines.h |   3 +
>  drivers/net/ethernet/intel/igc/igc_dump.c    | 323
> +++++++++++++++++++++++++++
>  drivers/net/ethernet/intel/igc/igc_main.c    |   2 +
>  drivers/net/ethernet/intel/igc/igc_regs.h    |   5 +
>  6 files changed, 338 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/intel/igc/igc_dump.c
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
