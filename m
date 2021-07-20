From: Fuxbrumer, Dvora <dvorax.fuxbrumer@linux.intel.com>
Date: Tue, 20 Jul 2021 16:17:45 +0300
Subject: [Intel-wired-lan] [PATCH v2] igc: Increase timeout value for
 Speed 100/1000/2500
In-Reply-To: <20210717161222.24288-1-muhammad.husaini.zulkifli@intel.com>
References: <20210717161222.24288-1-muhammad.husaini.zulkifli@intel.com>
Message-ID: <ddf8110f-fe47-b8ee-c30e-9d7080f59637@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 7/17/2021 19:12, Muhammad Husaini Zulkifli wrote:
> As the cycle time is set to maximum of 1s, the TX Hang timeout need to
> be increase to avoid possible TX Hang.
> 
> There is no dedicated number specific in data sheet for the timeout factor.
> Timeout factor was determined during the debugging to solve the "Tx Hang"
> issues that happen in some cases mainly during ETF(Earliest TxTime First).
> 
> This can be test by using TSN Schedule Tx Tools udp_tai sample application.
> 
> Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
> Acked-by: Sasha Neftin <sasha.neftin@intel.com>
> 
> ---
> 
> V1 -> V2: Add reason for the timeout factor
> 
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
Tested-by: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
