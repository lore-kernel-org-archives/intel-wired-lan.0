From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 8 Jul 2020 01:17:05 +0000
Subject: [Intel-wired-lan] [PATCH v1 1/2] igc: Fix double definition
In-Reply-To: <20200622072017.31186-1-sasha.neftin@intel.com>
References: <20200622072017.31186-1-sasha.neftin@intel.com>
Message-ID: <DM6PR11MB2890A9E476809242F1B8C97EBC670@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Sasha Neftin
> Sent: Monday, June 22, 2020 12:20 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v1 1/2] igc: Fix double definition
> 
> Accordance to the i225 specification address 0x4118 used for
> Host Good Packet Transmitted Count and defined as read on clear.
> IGC_ICTXQEC not in use and could be removed.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_mac.c  | 1 -
>  drivers/net/ethernet/intel/igc/igc_main.c | 1 -
>  drivers/net/ethernet/intel/igc/igc_regs.h | 2 --
>  3 files changed, 4 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
