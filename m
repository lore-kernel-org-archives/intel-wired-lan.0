From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 23 Apr 2020 19:39:27 +0000
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove unused
 IGC_ICS_DRSTA define
In-Reply-To: <20200412062829.17781-1-sasha.neftin@intel.com>
References: <20200412062829.17781-1-sasha.neftin@intel.com>
Message-ID: <DM6PR11MB2890140235CEF6C534D38897BCD30@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Sasha Neftin
> Sent: Saturday, April 11, 2020 11:28 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove unused
> IGC_ICS_DRSTA define
> 
> Device reset assert for interrupt cause register not in
> use for i225 device.
> This patch comes to clean up this define.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_defines.h | 1 -
>  1 file changed, 1 deletion(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
