From: Jakub Kicinski <kuba@kernel.org>
Date: Wed, 1 Dec 2021 17:56:15 -0800
Subject: [Intel-wired-lan] [PATCH v4 net-next 4/4] ice: add support for
 SyncE recovered clocks
In-Reply-To: <20211201180208.640179-5-maciej.machnikowski@intel.com>
References: <20211201180208.640179-1-maciej.machnikowski@intel.com>
 <20211201180208.640179-5-maciej.machnikowski@intel.com>
Message-ID: <20211201175615.4b403560@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed,  1 Dec 2021 19:02:08 +0100 Maciej Machnikowski wrote:
> Implement ethtool netlink functions for handling SyncE recovered clocks
> configuration on ice driver:
> - ETHTOOL_MSG_RCLK_SET
> - ETHTOOL_MSG_RCLK_GET
> 
> Co-developed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Maciej Machnikowski <maciej.machnikowski@intel.com>

drivers/net/ethernet/intel/ice/ice_ethtool.c:4090: warning: Excess function parameter 'ena_mask' description in 'ice_get_rclk_range'

drivers/net/ethernet/intel/ice/ice_dcb_nl.c:66:6: warning: variable 'bwcfg' set but not used [-Wunused-but-set-variable]
        int bwcfg = 0, bwrec = 0;
            ^
