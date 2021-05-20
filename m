From: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
Date: Thu, 20 May 2021 09:58:18 +0300
Subject: [Intel-wired-lan] [PATCH v6 5/9] igc: Introduce TX/RX stats
 helpers
In-Reply-To: <20210423062555.14972-6-jithu.joseph@intel.com>
References: <20210423062555.14972-1-jithu.joseph@intel.com>
 <20210423062555.14972-6-jithu.joseph@intel.com>
Message-ID: <387c45da-27e8-e51c-ff7e-04c5d5dc001e@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 23/04/2021 09:25, Jithu Joseph wrote:
> From: Andre Guedes <andre.guedes@intel.com>
> 
> In preparation for AF_XDP zero-copy support, encapsulate the code that
> updates the driver RX stats in its own local helper so it can be reused
> in the zero-copy path. Likewise, encapsulate TX stats code as well.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> Signed-off-by: Vedang Patel <vedang.patel@intel.com>
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c | 43 ++++++++++++++++-------
>   1 file changed, 31 insertions(+), 12 deletions(-)
> 
Tested-by: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
