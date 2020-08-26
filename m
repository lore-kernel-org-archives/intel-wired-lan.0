From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 26 Aug 2020 22:02:43 +0000
Subject: [Intel-wired-lan] [PATCH 2/2] igc: Fix not considering the TX
 delay for timestamps
In-Reply-To: <20200817231231.2971207-2-vinicius.gomes@intel.com>
References: <20200817231231.2971207-1-vinicius.gomes@intel.com>
 <20200817231231.2971207-2-vinicius.gomes@intel.com>
Message-ID: <DM6PR11MB289072219AE6BFAE2BF89F13BC540@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Vinicius Costa Gomes
> Sent: Monday, August 17, 2020 4:13 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Guedes, Andre <andre.guedes@intel.com>
> Subject: [Intel-wired-lan] [PATCH 2/2] igc: Fix not considering the TX delay for
> timestamps
> 
> When timestamping a packet there's a delay between the start of the
> packet and the point where the hardware actually captures the
> timestamp. This difference needs to be considered if we want accurate
> timestamps.
> 
> This was done on the RX side, but not on the TX side.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_ptp.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
