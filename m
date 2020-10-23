From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Fri, 23 Oct 2020 12:42:50 +0200
Subject: [Intel-wired-lan] [PATCH v5] i40e: add support for PTP external
 synchronization clock
In-Reply-To: <20201023103836.25826-1-piotr.kwapulinski@intel.com>
References: <20200728134748.26703-1-piotr.kwapulinski@intel.com>
 <20201023103836.25826-1-piotr.kwapulinski@intel.com>
Message-ID: <20201023104250.GA5254@ranger.igk.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Oct 23, 2020 at 10:38:36AM +0000, Piotr Kwapulinski wrote:
> Add support for external synchronization clock via GPIOs.
> 1PPS signals are handled via the dedicated 3 GPIOs: SDP3_2,
> SDP3_3 and GPIO_4.
> Previously it was not possible to use the external PTP
> synchronization clock.
> 

Where is the changelog?

> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h        |  76 +-
>  drivers/net/ethernet/intel/i40e/i40e_main.c   |  18 +-
>  drivers/net/ethernet/intel/i40e/i40e_ptp.c    | 748 +++++++++++++++++-
>  .../net/ethernet/intel/i40e/i40e_register.h   |  31 +-
>  4 files changed, 846 insertions(+), 27 deletions(-)
