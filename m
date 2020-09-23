From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 23 Sep 2020 03:38:23 +0000
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove reset disable flag
In-Reply-To: <20200831115329.1238812-1-sasha.neftin@intel.com>
References: <20200831115329.1238812-1-sasha.neftin@intel.com>
Message-ID: <DM6PR11MB289071595B99DB6B45695A3EBC380@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Sasha Neftin
> Sent: Monday, August 31, 2020 4:53 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove reset disable flag
> 
> Boolean reset disable flag not applicable for i225 device and
> could be removed.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_hw.h | 1 -
>  1 file changed, 1 deletion(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
