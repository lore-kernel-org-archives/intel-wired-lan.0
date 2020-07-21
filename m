From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 21 Jul 2020 23:15:28 +0000
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Clean up the _mac_info
 structure
In-Reply-To: <20200707110503.32407-1-sasha.neftin@intel.com>
References: <20200707110503.32407-1-sasha.neftin@intel.com>
Message-ID: <DM6PR11MB28904549AAE4DB772E510C68BC780@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Sasha Neftin
> Sent: Tuesday, July 7, 2020 4:05 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Clean up the _mac_info structure
> 
> collision_delta, tx_packet_delta, txcw, adaptive_ifs and
> fwsm fields not in use.
> This patch come to clean up the driver code.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_hw.h | 5 -----
>  1 file changed, 5 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
