From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 23 Nov 2019 04:02:05 +0000
Subject: [Intel-wired-lan] [PATCH v1 03/15] igc: Remove no need
 declaration of the igc_set_default_mac_filter
In-Reply-To: <20191119114351.41780-1-sasha.neftin@intel.com>
References: <20191119114351.41780-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9717BA44@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Sasha Neftin
> Sent: Tuesday, November 19, 2019 3:44 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v1 03/15] igc: Remove no need declaration
> of the igc_set_default_mac_filter
> 
> We want to avoid forward-declarations of function if possible.
> Rearrange the igc_set_default_mac_filter function implementation.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 91 +++++++++++++++------------
> ----
>  1 file changed, 45 insertions(+), 46 deletions(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
