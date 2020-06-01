From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Mon, 1 Jun 2020 16:43:10 +0000
Subject: [Intel-wired-lan] [next-queue v4] igc: Add initial EEE support
In-Reply-To: <20200527205132.152659-1-jeffrey.t.kirsher@intel.com>
References: <20200527205132.152659-1-jeffrey.t.kirsher@intel.com>
Message-ID: <DM6PR11MB28907FB267763FC928B66C19BC8A0@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Jeff
> Kirsher
> Sent: Wednesday, May 27, 2020 1:52 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Guedes, Andre <andre.guedes@intel.com>
> Subject: [Intel-wired-lan] [next-queue v4] igc: Add initial EEE support
> 
> From: Sasha Neftin <sasha.neftin@intel.com>
> 
> IEEE802.3az-2010 Energy Efficient Ethernet has been
> approved as standard (September 2010) and the driver
> can enable and disable it via ethtool.
> Disable the feature by default on parts which support it.
> Add enable/disable eee options.
> tx-lpi, tx-timer and advertise not supported yet.
> 
> v2:
> Rid of inverted logic and replace eee_disable boolean with
> eee_enable in device specification.
> Address community comments.
> 
> v3:
> Remove pointless ret_val from _set_eee method
> Minor comment fix
> 
> v4:
> Fixed conflicts when applying to next-queue tree
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> Reviewed-by: Andre Guedes <andre.guedes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc.h         |  4 +
>  drivers/net/ethernet/intel/igc/igc_defines.h | 10 ++
>  drivers/net/ethernet/intel/igc/igc_ethtool.c | 97 ++++++++++++++++++++
>  drivers/net/ethernet/intel/igc/igc_hw.h      |  1 +
>  drivers/net/ethernet/intel/igc/igc_i225.c    | 56 +++++++++++
>  drivers/net/ethernet/intel/igc/igc_i225.h    |  2 +
>  drivers/net/ethernet/intel/igc/igc_main.c    | 16 ++++
>  drivers/net/ethernet/intel/igc/igc_regs.h    |  5 +
>  8 files changed, 191 insertions(+)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
