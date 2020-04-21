From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 21 Apr 2020 18:23:54 +0000
Subject: [Intel-wired-lan] [PATCH v1] igc: remove IGC_REMOVED function
In-Reply-To: <20200401091644.5863-1-vitaly.lifshits@intel.com>
References: <20200401091644.5863-1-vitaly.lifshits@intel.com>
Message-ID: <DM6PR11MB28901366E4E5D658EEC0A9BBBCD50@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Vitaly
> Lifshits
> Sent: Wednesday, April 1, 2020 2:17 AM
> To: intel-wired-lan at osuosl.org
> Subject: [Intel-wired-lan] [PATCH v1] igc: remove IGC_REMOVED function
> 
> igc driver has leftovers from the previous device that supported
> virtualization. This can be found in the function IGC_REMOVED which
> became obsolete, and can be removed.
> 
> Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_mac.h  | 4 ----
>  drivers/net/ethernet/intel/igc/igc_main.c | 3 ---
>  drivers/net/ethernet/intel/igc/igc_regs.h | 3 +--
>  3 files changed, 1 insertion(+), 9 deletions(-)
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
