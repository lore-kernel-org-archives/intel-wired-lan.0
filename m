From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 1 May 2020 21:54:13 +0000
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove per queue good
 transmited counter register
In-Reply-To: <20200422104647.27290-1-sasha.neftin@intel.com>
References: <20200422104647.27290-1-sasha.neftin@intel.com>
Message-ID: <DM6PR11MB28908EC5BC7D7429E21E13EBBCAB0@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Sasha Neftin
> Sent: Wednesday, April 22, 2020 3:47 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove per queue good
> transmited counter register
> 
> Per queue good transmitted packet counter not applicable for i225 device.
> This patch comes to clean up this register.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_regs.h | 3 ---
>  1 file changed, 3 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
