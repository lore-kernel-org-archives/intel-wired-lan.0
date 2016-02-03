From: Stefan Assmann <sassmann@kpanic.de>
Date: Wed,  3 Feb 2016 09:20:46 +0100
Subject: [Intel-wired-lan] [PATCH net-next V2 0/6] net/intel: call
	ndo_stop() instead of dev_close() when running offline selftest
Message-ID: <1454487652-1545-1-git-send-email-sassmann@kpanic.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Calling dev_close() causes IFF_UP to be cleared which will remove the
interfaces routes and some addresses. That's probably not what the user
intended when running the offline selftest. Besides this does not happen
if the interface is brought down before the test, so the current
behaviour is inconsistent.
Instead call the net_device_ops ndo_stop function directly and avoid
touching IFF_UP at all.

Tested this with igb, e1000e, ixgbe and i40e. All drivers now are able to
resume operation without restoring the IP address, gateway or such.

V2: rename e1000_open(), e1000_close() to e1000e_open(), e1000e_close()
to avoid name clash with e1000.


Stefan Assmann (6):
  i40e: call ndo_stop() instead of dev_close() when running offline
    selftest
  ixgbe: call ndo_stop() instead of dev_close() when running offline
    selftest
  ixgbevf: call ndo_stop() instead of dev_close() when running offline
    selftest
  igb: call ndo_stop() instead of dev_close() when running offline
    selftest
  e1000: call ndo_stop() instead of dev_close() when running offline
    selftest
  e1000e: call ndo_stop() instead of dev_close() when running offline
    selftest

 drivers/net/ethernet/intel/e1000/e1000.h          |  2 ++
 drivers/net/ethernet/intel/e1000/e1000_ethtool.c  |  4 ++--
 drivers/net/ethernet/intel/e1000/e1000_main.c     |  8 ++++----
 drivers/net/ethernet/intel/e1000e/e1000.h         |  2 ++
 drivers/net/ethernet/intel/e1000e/ethtool.c       |  4 ++--
 drivers/net/ethernet/intel/e1000e/netdev.c        | 12 ++++++------
 drivers/net/ethernet/intel/i40e/i40e.h            |  2 +-
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c    |  4 ++--
 drivers/net/ethernet/intel/i40e/i40e_main.c       |  4 ----
 drivers/net/ethernet/intel/igb/igb.h              |  2 ++
 drivers/net/ethernet/intel/igb/igb_ethtool.c      |  4 ++--
 drivers/net/ethernet/intel/igb/igb_main.c         |  8 ++++----
 drivers/net/ethernet/intel/ixgbe/ixgbe.h          |  2 ++
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |  4 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c     |  4 ++--
 drivers/net/ethernet/intel/ixgbevf/ethtool.c      |  4 ++--
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h      |  2 ++
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |  4 ++--
 18 files changed, 41 insertions(+), 35 deletions(-)

-- 
2.5.0

