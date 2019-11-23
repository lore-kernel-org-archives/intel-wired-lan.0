From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 23 Nov 2019 04:07:11 +0000
Subject: [Intel-wired-lan] [PATCH v1 15/15] igc: Remove no need
 declaration of the igc_sw_init
In-Reply-To: <20191119114540.42607-1-sasha.neftin@intel.com>
References: <20191119114540.42607-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9717BB2B@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Sasha Neftin
> Sent: Tuesday, November 19, 2019 3:46 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v1 15/15] igc: Remove no need declaration
> of the igc_sw_init
> 
> We want to avoid forward-declarations of function if possible.
> Rearrange the igc_sw_init function implementation.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 2733 ++++++++++++++-----------
> ----
>  1 file changed, 1365 insertions(+), 1368 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
