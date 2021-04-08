From: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
Date: Thu, 8 Apr 2021 13:11:20 +0300
Subject: [Intel-wired-lan] [PATCH v5 5/9] igc: Introduce TX/RX stats
 helpers
In-Reply-To: <20210226002308.2348-6-jithu.joseph@intel.com>
References: <20210226002308.2348-1-jithu.joseph@intel.com>
 <20210226002308.2348-6-jithu.joseph@intel.com>
Message-ID: <dd22c274-bb8b-b365-6162-39dac18861dd@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 26/02/2021 02:23, Jithu Joseph wrote:
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
