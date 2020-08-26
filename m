From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 26 Aug 2020 21:50:26 +0000
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Expose LPI counters
In-Reply-To: <20200813151815.2970941-1-sasha.neftin@intel.com>
References: <20200813151815.2970941-1-sasha.neftin@intel.com>
Message-ID: <DM6PR11MB28901824833072738FF60801BC540@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Sasha
> Neftin
> Sent: Thursday, August 13, 2020 8:18 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Expose LPI counters
> 
> Completion to commit 900d1e8b346b ("igc: Add LPI counters")
> LPI counters exposed by statitics update method.
> A EEE TX LPI counter reflect the transmitter entries EEE (IEEE 802.3az)
> into the LPI state. A EEE RX LPI counter reflect the receiver link
> partner entries into EEE(IEEE 802.3az) LPI state.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_ethtool.c | 3 +++
>  drivers/net/ethernet/intel/igc/igc_hw.h      | 2 ++
>  drivers/net/ethernet/intel/igc/igc_main.c    | 2 ++
>  3 files changed, 7 insertions(+)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
