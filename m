From: Fuxbrumer, Dvora <dvorax.fuxbrumer@linux.intel.com>
Date: Tue, 20 Jul 2021 15:21:09 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove _I_PHY_ID checking
In-Reply-To: <20210707051440.1795979-1-sasha.neftin@intel.com>
References: <20210707051440.1795979-1-sasha.neftin@intel.com>
Message-ID: <13035df1-7331-f8dd-cf2d-0bdbe34265d2@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 7/7/2021 08:14, Sasha Neftin wrote:
> i225 devices have only one PHY vendor. There is no point checking
> _I_PHY_ID during the link establishment and auto-negotiation process.
> This patch comes to clean up these pointless checkings.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_base.c | 10 +---------
>   drivers/net/ethernet/intel/igc/igc_main.c |  3 +--
>   drivers/net/ethernet/intel/igc/igc_phy.c  |  6 ++----
>   3 files changed, 4 insertions(+), 15 deletions(-)
> 
Tested-by: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
