From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Mon, 30 Mar 2020 23:29:50 +0000
Subject: [Intel-wired-lan] [next-queue PATCH v3 2/2] igc: Add support
 for ETF offloading
In-Reply-To: <20200214235203.3910513-3-vinicius.gomes@intel.com>
References: <20200214235203.3910513-1-vinicius.gomes@intel.com>
 <20200214235203.3910513-3-vinicius.gomes@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9722CFB4@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Vinicius Costa Gomes
> Sent: Friday, February 14, 2020 3:52 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next-queue PATCH v3 2/2] igc: Add support for
> ETF offloading
> 
> This adds support for ETF offloading for the i225 controller.
> 
> For i225, the LaunchTime feature is almost a subset of the Qbv
> feature. The main change from the i210 is that the launchtime of each
> packet is specified as an offset applied to the BASET register. BASET
> is automatically incremented each cycle.
> 
> For i225, the approach chosen is to re-use most of the setup used for
> taprio offloading. With a few changes:
> 
>  - The more or less obvious one is that when ETF is enabled, we should
>  set add the expected launchtime to the (advanced) transmit
>  descriptor;
> 
>  - The less obvious, is that when taprio offloading is not enabled, we
>  add a dummy schedule (all queues are open all the time, with a cycle
>  time of 1 second).
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_defines.h |  1 +
>  drivers/net/ethernet/intel/igc/igc_main.c    | 70 +++++++++++++++++++-
>  drivers/net/ethernet/intel/igc/igc_tsn.c     | 19 +++++-
>  3 files changed, 86 insertions(+), 4 deletions(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
