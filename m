From: Fuxbrumer, Dvora <dvorax.fuxbrumer@linux.intel.com>
Date: Tue, 20 Jul 2021 16:14:44 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove phy->type checking
In-Reply-To: <20210710175750.2088213-1-sasha.neftin@intel.com>
References: <20210710175750.2088213-1-sasha.neftin@intel.com>
Message-ID: <04a90818-8797-8a7d-6842-725ac6ba691f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 7/10/2021 20:57, Sasha Neftin wrote:
> i225 devices have only one phy->type: copper. There is no point checking
> phy->type during the igc_has_link method from the watchdog that
> invoked every 2 seconds.
> This patch comes to clean up these pointless checkings.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c | 15 ++++-----------
>   1 file changed, 4 insertions(+), 11 deletions(-)
> 
Tested-by: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
