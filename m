From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Mon, 7 Feb 2022 08:58:54 +0000
Subject: [Intel-wired-lan] [PATCH 2/2 net-next v6] igb: refactor XDP
 registration
In-Reply-To: <20220119145259.1790015-3-vinschen@redhat.com>
References: <20220119145259.1790015-1-vinschen@redhat.com>
 <20220119145259.1790015-3-vinschen@redhat.com>
Message-ID: <MW3PR11MB455413AA525BC82D2CEF33E99C2C9@MW3PR11MB4554.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Corinna Vinschen
>Sent: Wednesday, January 19, 2022 8:23 PM
To: intel-wired-lan@osuosl.org; netdev at vger.kernel.org; Gomes, Vinicius
><vinicius.gomes@intel.com>
>Subject: [Intel-wired-lan] [PATCH 2/2 net-next v6] igb: refactor XDP
>registration
>
>On changing the RX ring parameters igb uses a hack to avoid a warning when
>calling xdp_rxq_info_reg via igb_setup_rx_resources.  It just clears the struct
>xdp_rxq_info content.
>
>Instead, change this to unregister if we're already registered.  Align code to
>the igc code.
>
>Fixes: 9cbc948b5a20c ("igb: add XDP support")
>Signed-off-by: Corinna Vinschen <vinschen@redhat.com>
>---
> drivers/net/ethernet/intel/igb/igb_ethtool.c |  4 ----
> drivers/net/ethernet/intel/igb/igb_main.c    | 19 +++++++++++++------
> 2 files changed, 13 insertions(+), 10 deletions(-)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
