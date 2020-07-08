From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 8 Jul 2020 01:26:39 +0000
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove ledctl_ fields
 from the mac_info structure
In-Reply-To: <20200701113043.9053-1-sasha.neftin@intel.com>
References: <20200701113043.9053-1-sasha.neftin@intel.com>
Message-ID: <DM6PR11MB2890C015C16D71EF2A5B1A3DBC670@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Sasha Neftin
> Sent: Wednesday, July 1, 2020 4:31 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove ledctl_ fields from the
> mac_info structure
> 
> LED control currently not implemented.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_hw.h | 3 ---
>  1 file changed, 3 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
