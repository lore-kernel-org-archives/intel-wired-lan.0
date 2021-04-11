From: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
Date: Sun, 11 Apr 2021 10:16:20 +0300
Subject: [Intel-wired-lan] [PATCH next-queue v2 2/2] igc: enable
 auxiliary PHC functions for the i225
In-Reply-To: <20210219013104.54436-3-ederson.desouza@intel.com>
References: <20210219013104.54436-1-ederson.desouza@intel.com>
 <20210219013104.54436-3-ederson.desouza@intel.com>
Message-ID: <1e3a6124-879c-7b4f-3804-30d323ca1fc7@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 19/02/2021 03:31, Ederson de Souza wrote:
> The i225 device offers a number of special PTP Hardware Clock features on
> the Software Defined Pins (SDPs) - much like i210, which is used as
> inspiration for this patch. It enables two possible functions, namely
> time stamping external events and periodic output signals.
> 
> The assignment of PHC functions to the four SDP can be freely chosen by
> the user.
> 
> For the external events time stamping, when the SDP (configured as input
> by user) level changes, an interrupt is generated and the kernel
> Precision Time Protocol (PTP) is informed.
> 
> For the periodic output signals, the i225 is configured to generate them
> (so the SDP level will change periodically) and the driver also has to
> keep updating the time of the next level change. However, this work is
> not necessary for some frequencies as the i225 takes care of them
> (namely, anything with a half-cycle of 500ms, 250ms, 125ms or < 70ms).
> 
> While i225 allows up to four timers to be used to source the time used
> on the external events or output signals, this patch uses only one of
> those timers. Main reason is to keep it simple, as it's not clear how
> these extra timers would be exposed to users. Note that currently a NIC
> can expose a single PTP device.
> 
> Signed-off-by: Ederson de Souza <ederson.desouza@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc.h         |  11 +
>   drivers/net/ethernet/intel/igc/igc_defines.h |  63 +++++
>   drivers/net/ethernet/intel/igc/igc_main.c    |  55 +++-
>   drivers/net/ethernet/intel/igc/igc_ptp.c     | 269 ++++++++++++++++++-
>   drivers/net/ethernet/intel/igc/igc_regs.h    |  10 +
>   5 files changed, 405 insertions(+), 3 deletions(-)
> 
Tested-by: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
