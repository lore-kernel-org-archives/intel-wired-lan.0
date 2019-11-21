From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 21 Nov 2019 02:22:36 +0000
Subject: [Intel-wired-lan] [PATCH v1] igc: Fix the parameter description
 for igc_alloc_rx_buffers
In-Reply-To: <20191111070412.8845-1-sasha.neftin@intel.com>
References: <20191111070412.8845-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9717A71E@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Sasha Neftin
> Sent: Sunday, November 10, 2019 11:04 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v1] igc: Fix the parameter description for
> igc_alloc_rx_buffers
> 
> The function description for igc_alloc_rx_buffers has not reflected
> the function meaning. Add meaningful description.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
