From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 21 Nov 2019 02:22:55 +0000
Subject: [Intel-wired-lan] [PATCH v1] igc: Fix parameter descriptions
 for a several functions
In-Reply-To: <20191112151332.5893-1-sasha.neftin@intel.com>
References: <20191112151332.5893-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9717A72D@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Sasha Neftin
> Sent: Tuesday, November 12, 2019 7:14 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v1] igc: Fix parameter descriptions for a
> several functions
> 
> igc_watchdog, igc_set_interrupt_capability, igc_init_interrupt_scheme,
> __igc_open and __igc_close parameter desriptions has not reflected
> functions meaning. Add meaningful description.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
