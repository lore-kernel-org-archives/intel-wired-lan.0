From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 23 Nov 2019 03:59:29 +0000
Subject: [Intel-wired-lan] [PATCH v1 01/15] igc: Remove no need
 declaration of the igc_clean_tx_ring
In-Reply-To: <20191119114332.41655-1-sasha.neftin@intel.com>
References: <20191119114332.41655-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9717BA13@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Sasha Neftin
> Sent: Tuesday, November 19, 2019 3:44 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v1 01/15] igc: Remove no need declaration
> of the igc_clean_tx_ring
> 
> We want to avoid forward-declarations of function if possible.
> Rearrange the igc_clean_tx_ring function implementation.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 75 +++++++++++++++------------
> ----
>  1 file changed, 37 insertions(+), 38 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
