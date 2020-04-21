From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 21 Apr 2020 18:26:20 +0000
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Clean up obsolete NVM
 defines
In-Reply-To: <20200401113844.17969-1-sasha.neftin@intel.com>
References: <20200401113844.17969-1-sasha.neftin@intel.com>
Message-ID: <DM6PR11MB289096437A6606295C1A2080BCD50@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Sasha
> Neftin
> Sent: Wednesday, April 1, 2020 4:39 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Clean up obsolete NVM defines
> 
> Packet buffer allocation, reserved word and pointer guard
> not applicable for i225 parts.
> This patch comes to clean up these obsolete defines
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_defines.h | 5 -----
>  1 file changed, 5 deletions(-)
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
