From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 21 Aug 2018 19:16:26 +0000
Subject: [Intel-wired-lan] [next PATCH S95 02/12] i40e: convert queue
 stats to i40e_stats array
In-Reply-To: <20180820151233.14629-2-alice.michael@intel.com>
References: <20180820151233.14629-1-alice.michael@intel.com>
 <20180820151233.14629-2-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2E965D@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Monday, August 20, 2018 8:12 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S95 02/12] i40e: convert queue stats
> to i40e_stats array
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Use an i40e_stats array to handle the queue stats, instead of coding similar
> functionality separately. Because of how the queue stats are accessed on
> some kernels, we can't easily use i40e_add_ethtool_stats.
> 
> Instead, implement a separate helper, i40e_add_queue_stats, which we'll
> use instead. This helper will correctly implement the
> u64_stats_fetch_begin_irq logic and allow retries until successful. We share
> the most complex code by re-using i40e_add_one_ethtool_stat.
> 
> This logic additionally easily supports skipping disabled rings by using a
> ternary operator before calling the u64_stats_fetch_begin_irq() function, so
> that we correctly zero-out the stats values without having to perform two
> separate sections of code.
> 
> This significantly reduces the boiler plate code in i40e_get_ethtool_stats, and
> helps keep the complex logic contained to as few functions as possible.
> 
> With this patch, we've finally converted all the statistics to use the helpers
> and the i40e_stats function.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 148 +++++++++++++++----
> ------
>  1 file changed, 89 insertions(+), 59 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


