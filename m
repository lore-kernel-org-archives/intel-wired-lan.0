From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 23 Sep 2020 03:44:35 +0000
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Clean up _nvm_info
 structure
In-Reply-To: <20200910081605.2562950-1-sasha.neftin@intel.com>
References: <20200910081605.2562950-1-sasha.neftin@intel.com>
Message-ID: <DM6PR11MB2890A4586C2860B8E6FEA271BC380@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Sasha Neftin
> Sent: Thursday, September 10, 2020 1:16 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Clean up _nvm_info structure
> 
> flash_bank_size and flash_base_addr field not in use and can
> be removed from a _nvm_info structure
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_hw.h | 3 ---
>  1 file changed, 3 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>

