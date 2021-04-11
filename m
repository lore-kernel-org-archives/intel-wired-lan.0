From: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
Date: Sun, 11 Apr 2021 10:04:47 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Expose LPI counters
In-Reply-To: <20210324131525.2196955-1-sasha.neftin@intel.com>
References: <20210324131525.2196955-1-sasha.neftin@intel.com>
Message-ID: <b42f9d98-d18c-eebd-291a-eb83e90219fb@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 24/03/2021 15:15, Sasha Neftin wrote:
> Expose EEE tx and rx low power idle counters via ethtool
> A EEE TX or RX LPI event occurs when the transmitter or the receiver
> enters EEE (IEEE802.3az) LPI state.
> ethtool --statistics <iface>
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_ethtool.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
Tested-by: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
