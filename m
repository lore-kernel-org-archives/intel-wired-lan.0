From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 6 May 2020 06:59:47 +0000
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove unused
 descriptor's flags
In-Reply-To: <20200504062925.18819-1-sasha.neftin@intel.com>
References: <20200504062925.18819-1-sasha.neftin@intel.com>
Message-ID: <DM6PR11MB28900156D80235D2A71BA467BCA40@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Sasha
> Neftin
> Sent: Sunday, May 3, 2020 11:29 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove unused descriptor's flags
> 
> Enable Tidv register, Report Packet Sent, Report Status and
> Ethernet CRC flags not in use.
> This patch comes to clean up these flags.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_defines.h | 4 ----
>  1 file changed, 4 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
