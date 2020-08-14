From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 14 Aug 2020 02:03:37 +0000
Subject: [Intel-wired-lan] [PATCH 1/3] igc: Clean RX descriptor error
 flags
In-Reply-To: <20200810210832.34699-1-andre.guedes@intel.com>
References: <20200810210832.34699-1-andre.guedes@intel.com>
Message-ID: <DM6PR11MB2890BC434D3ED3EEF4609CADBC400@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Andre Guedes
> Sent: Monday, August 10, 2020 2:09 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 1/3] igc: Clean RX descriptor error flags
> 
> I225 advanced receive descriptor doesn't have the following extend error
> bits: CE, SE, SEQ, CXE. In addition to that, the bit TCPE is called L4E
> in the datasheet.
> 
> This patch cleans up the code accordingly, and gets rid of the macro
> IGC_RXDEXT_ERR_FRAME_ERR_MASK since it doesn't make much sense
> anymore.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_defines.h | 14 +-------------
>  drivers/net/ethernet/intel/igc/igc_main.c    |  5 ++---
>  2 files changed, 3 insertions(+), 16 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
