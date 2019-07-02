From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 2 Jul 2019 22:45:49 +0000
Subject: [Intel-wired-lan] [PATCH S22 01/16] ice: add lp_advertising
 flow control support
In-Reply-To: <20190626092027.52845-1-anthony.l.nguyen@intel.com>
References: <20190626092027.52845-1-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3FBDAB@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, June 26, 2019 2:20 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S22 01/16] ice: add lp_advertising flow
> control support
> 
> From: Paul Greenwalt <paul.greenwalt@intel.com>
> 
> Add support for reporting link partner advertising when
> ETHTOOL_GLINKSETTINGS defined. Get pause param reports the Tx/Rx
> pause configured, and then ethtool issues ETHTOOL_GSET ioctl and
> ice_get_settings_link_up reports the negotiated Tx/Rx pause. Negotiated
> pause frame report per IEEE 802.3-2005 table 288-3.
> 
> $ ethtool --show-pause ens6f0
> Pause parameters for ens6f0:
> Autonegotiate:  on
> RX:             on
> TX:             on
> RX negotiated:  on
> TX negotiated:  on
> 
> $ ethtool ens6f0
> Settings for ens6f0:
>         Supported ports: [ FIBRE ]
>         Supported link modes:   25000baseCR/Full
>         Supported pause frame use: Symmetric
>         Supports auto-negotiation: Yes
>         Supported FEC modes: None BaseR RS
>         Advertised link modes:  25000baseCR/Full
>         Advertised pause frame use: Symmetric Receive-only
>         Advertised auto-negotiation: Yes
>         Advertised FEC modes: None BaseR RS
>         Link partner advertised link modes:  Not reported
>         Link partner advertised pause frame use: Symmetric
>         Link partner advertised auto-negotiation: Yes
>         Link partner advertised FEC modes: Not reported
>         Speed: 25000Mb/s
>         Duplex: Full
>         Port: Direct Attach Copper
>         PHYAD: 0
>         Transceiver: internal
>         Auto-negotiation: on
>         Supports Wake-on: g
>         Wake-on: g
>         Current message level: 0x00000007 (7)
>                                drv probe link
>         Link detected: yes
> 
> When ETHTOOL_GLINKSETTINGS is not defined, get pause param reports the
> negotiated Tx/Rx pause.
> 
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 104 +++++++++++++------
>  1 file changed, 72 insertions(+), 32 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


