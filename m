From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 26 Aug 2020 22:15:02 +0000
Subject: [Intel-wired-lan] [PATCH net v2 2/2] igc: Fix not considering
 the TX delay for timestamps
In-Reply-To: <20200818234002.3057510-2-vinicius.gomes@intel.com>
References: <20200818234002.3057510-1-vinicius.gomes@intel.com>
 <20200818234002.3057510-2-vinicius.gomes@intel.com>
Message-ID: <DM6PR11MB2890D4A832500B4467BD120FBC540@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Vinicius Costa Gomes
> Sent: Tuesday, August 18, 2020 4:40 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Guedes, Andre <andre.guedes@intel.com>
> Subject: [Intel-wired-lan] [PATCH net v2 2/2] igc: Fix not considering the TX
> delay for timestamps
> 
> Changes from v1:
>   - Added Fixes tag
> 
> When timestamping a packet there's a delay between the start of the
> packet and the point where the hardware actually captures the
> timestamp. This difference needs to be considered if we want accurate
> timestamps.
> 
> This was done on the RX side, but not on the TX side.
> 
> Fixes: 2c344ae24501 ("igc: Add support for TX timestamping")
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_ptp.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
