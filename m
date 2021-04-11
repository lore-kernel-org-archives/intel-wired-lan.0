From: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
Date: Sun, 11 Apr 2021 10:15:44 +0300
Subject: [Intel-wired-lan] [PATCH next-queue v2 1/2] igc: Enable
 internal i225 PPS
In-Reply-To: <20210219013104.54436-2-ederson.desouza@intel.com>
References: <20210219013104.54436-1-ederson.desouza@intel.com>
 <20210219013104.54436-2-ederson.desouza@intel.com>
Message-ID: <771f5092-3762-4312-0760-c9e709c96ee7@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 19/02/2021 03:31, Ederson de Souza wrote:
> The i225 device can produce one interrupt on the full second, much
> like i210 - from where this patch is inspired.
> 
> This patch sets up the full second interruption on the i225 and when
> receiving it, it sends a PPS event to PTP (Precision Time Protocol)
> kernel subsystem.
> 
> The PTP subsystem exposes the PPS events via ioctl and sysfs, and one
> can use the `testptp` tool (tools/testing/selftests/ptp) to check that
> the events are being generated.
> 
> Signed-off-by: Ederson de Souza <ederson.desouza@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc.h      |  2 ++
>   drivers/net/ethernet/intel/igc/igc_main.c |  8 +++++++
>   drivers/net/ethernet/intel/igc/igc_ptp.c  | 28 ++++++++++++++++++++++-
>   3 files changed, 37 insertions(+), 1 deletion(-)
> 
Tested-by: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
