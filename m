From: Fuxbrumer, Dvora <dvorax.fuxbrumer@linux.intel.com>
Date: Tue, 20 Jul 2021 15:31:52 +0300
Subject: [Intel-wired-lan] [PATCH v1] igc: Set QBVCYCLET_S to 0 for TSN
 Basic Scheduling
In-Reply-To: <20210709234017.22817-1-muhammad.husaini.zulkifli@intel.com>
References: <20210709234017.22817-1-muhammad.husaini.zulkifli@intel.com>
Message-ID: <26b36944-57b1-8123-85e4-47fc0691615e@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 7/10/2021 02:40, Muhammad Husaini Zulkifli wrote:
> According to datasheet section 8.12.19, when there's no TSN offloading
> Shadow_QbvCycle bit[29:0] must be set to zero for basic scheduling.
> 
> Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_tsn.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
Tested-by: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
