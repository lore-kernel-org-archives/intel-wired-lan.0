From: Fuxbrumer, Dvora <dvorax.fuxbrumer@linux.intel.com>
Date: Thu, 8 Jul 2021 14:34:45 +0300
Subject: [Intel-wired-lan] [PATCH next-queue v2 1/5] igc: Add
 possibility to add flex filter
In-Reply-To: <20210629044332.3491232-2-vinicius.gomes@intel.com>
References: <20210629044332.3491232-1-vinicius.gomes@intel.com>
 <20210629044332.3491232-2-vinicius.gomes@intel.com>
Message-ID: <3164a39f-0435-ebe2-e7a7-60c0e8103170@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 6/29/2021 07:43, Vinicius Costa Gomes wrote:
> From: Kurt Kanzenbach <kurt@linutronix.de>
> 
> The Intel i225 NIC has the possibility to add flex filters which can
> match up to the first 128 byte of a packet. These filters are useful
> for all kind of packet matching. One particular use case is Profinet,
> as the different traffic classes are distinguished by the frame id
> range which cannot be matched by any other means.
> 
> Add code to configure and enable flex filters.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc.h         |  13 ++
>   drivers/net/ethernet/intel/igc/igc_defines.h |  48 ++++++-
>   drivers/net/ethernet/intel/igc/igc_main.c    | 134 +++++++++++++++++++
>   drivers/net/ethernet/intel/igc/igc_regs.h    |  17 +++
>   4 files changed, 207 insertions(+), 5 deletions(-)
> 
Tested-by: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
