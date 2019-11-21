From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 21 Nov 2019 02:19:15 +0000
Subject: [Intel-wired-lan] [PATCH v1] igc: Improve the DMA mapping flow
In-Reply-To: <20191105094413.1405-1-sasha.neftin@intel.com>
References: <20191105094413.1405-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9717A6E9@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Sasha Neftin
> Sent: Tuesday, November 5, 2019 1:44 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v1] igc: Improve the DMA mapping flow
> 
> Improve the probe flow and set both the DMA mask and the coherent
> to the same thing. Make the flow optimized and cleared.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 24 +++++++++---------------
>  1 file changed, 9 insertions(+), 15 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
