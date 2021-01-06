From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Wed,  6 Jan 2021 13:55:37 -0800
Subject: [Intel-wired-lan] [PATCH net-next v1 0/2] GRO drop accounting
Message-ID: <20210106215539.2103688-1-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add some accounting for when the stack drops a packet
that a driver tried to indicate with a gro* call. This
helps users track where packets might have disappeared
to and will show up in the netdevice stats that already
exist.

After that, remove the driver specific workaround
that was added to do the same, just scoped too small.

Jesse Brandeburg (2):
  net: core: count drops from GRO
  ice: remove GRO drop accounting

 drivers/net/ethernet/intel/ice/ice.h          | 1 -
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 1 -
 drivers/net/ethernet/intel/ice/ice_main.c     | 4 +---
 drivers/net/ethernet/intel/ice/ice_txrx.h     | 1 -
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 2 --
 net/core/dev.c                                | 2 ++
 6 files changed, 3 insertions(+), 8 deletions(-)

-- 
2.29.2

