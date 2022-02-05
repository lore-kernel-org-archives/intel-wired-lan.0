From: Corinna Vinschen <vinschen@redhat.com>
Date: Sat, 5 Feb 2022 13:14:47 +0100
Subject: [Intel-wired-lan] [PATCH 2/2 net-next v6] igb: refactor XDP
 registration
In-Reply-To: <20220119145259.1790015-3-vinschen@redhat.com>
References: <20220119145259.1790015-1-vinschen@redhat.com>
 <20220119145259.1790015-3-vinschen@redhat.com>
Message-ID: <Yf5qN/AAv2gQLWyf@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Jan 19 15:52, Corinna Vinschen wrote:
> On changing the RX ring parameters igb uses a hack to avoid a warning
> when calling xdp_rxq_info_reg via igb_setup_rx_resources.  It just
> clears the struct xdp_rxq_info content.
> 
> Instead, change this to unregister if we're already registered.  Align
> code to the igc code.
> 
> Fixes: 9cbc948b5a20c ("igb: add XDP support")
> Signed-off-by: Corinna Vinschen <vinschen@redhat.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_ethtool.c |  4 ----
>  drivers/net/ethernet/intel/igb/igb_main.c    | 19 +++++++++++++------
>  2 files changed, 13 insertions(+), 10 deletions(-)

Any chance this could be set to "Tested" to go forward here?


Thanks,
Corinna

