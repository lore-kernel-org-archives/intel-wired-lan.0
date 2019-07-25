From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 25 Jul 2019 02:18:18 +0000
Subject: [Intel-wired-lan] [PATCH v1] igc: Remove useless forward
 declaration
In-Reply-To: <20190716123539.3224-1-sasha.neftin@intel.com>
References: <20190716123539.3224-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B970D7752@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Sasha Neftin
> Sent: Tuesday, July 16, 2019 5:36 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v1] igc: Remove useless forward
> declaration
> 
> Move igc_phy_setup_autoneg,igc_wait_autoneg and
> igc_set_fc_watermarks
> up to avoid forward declaration.
> It is not necessary to forward declare these static methods.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_mac.c |  73 ++++++------
>  drivers/net/ethernet/intel/igc/igc_phy.c | 192 +++++++++++++++------------
> ----
>  2 files changed, 129 insertions(+), 136 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
