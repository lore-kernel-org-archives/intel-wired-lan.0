From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 1 May 2020 21:50:35 +0000
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove header redirection
 register
In-Reply-To: <20200422084155.36971-1-sasha.neftin@intel.com>
References: <20200422084155.36971-1-sasha.neftin@intel.com>
Message-ID: <DM6PR11MB28902F9A428D5C7527AD1AF0BCAB0@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Sasha Neftin
> Sent: Wednesday, April 22, 2020 1:42 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove header redirection
> register
> 
> Header redirection missed packet counter not applicable for i225 device.
> This patch comes to clean up this register.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_regs.h | 1 -
>  1 file changed, 1 deletion(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
