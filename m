From: Fuxbrumer, Dvora <dvorax.fuxbrumer@linux.intel.com>
Date: Thu, 8 Jul 2021 14:38:32 +0300
Subject: [Intel-wired-lan] [PATCH next-queue v2 4/5] igc: Make flex
 filter more flexible
In-Reply-To: <20210629044332.3491232-5-vinicius.gomes@intel.com>
References: <20210629044332.3491232-1-vinicius.gomes@intel.com>
 <20210629044332.3491232-5-vinicius.gomes@intel.com>
Message-ID: <c696882c-5e06-77e7-1f1b-af44c242763b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 6/29/2021 07:43, Vinicius Costa Gomes wrote:
> From: Kurt Kanzenbach <kurt@linutronix.de>
> 
> Currently flex filters are only used for filters containing user data.
> However, it makes sense to utilize them also for filters having
> multiple conditions, because that's not supported by the driver at the
> moment. Add it.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc.h         |  1 +
>   drivers/net/ethernet/intel/igc/igc_ethtool.c | 27 ++++++++++++--------
>   drivers/net/ethernet/intel/igc/igc_main.c    | 14 ++++------
>   3 files changed, 22 insertions(+), 20 deletions(-)
> 
Tested-by: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
