From: Andre Guedes <andre.guedes@intel.com>
Date: Tue, 26 May 2020 15:13:17 -0700
Subject: [Intel-wired-lan] [PATCH v3 1/1] igc: Add initial EEE support
In-Reply-To: <20200525150248.37783-1-sasha.neftin@intel.com>
References: <20200525150248.37783-1-sasha.neftin@intel.com>
Message-ID: <159053119782.17101.888644900727677101@tmcao-mobl.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> IEEE802.3az-2010 Energy Efficient Ethernet has been
> approved as standard (September 2010) and the driver
> can enable and disable it via ethtool.
> Disable the feature by default on parts which support it.
> Add enable/disable eee options.
> tx-lpi, tx-timer and advertise not supported yet.
> 
> v1-v2:
> Rid of inverted logic and replace eee_disable boolean with
> eee_enable in device specification.
> Address community comments.
> 
> v2-v3:
> Remove pointless ret_val from _set_eee method
> Minor comment fix
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>

Reviewed-by: Andre Guedes <andre.guedes@intel.com>
