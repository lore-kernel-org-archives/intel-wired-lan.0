From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Mon, 25 Oct 2021 17:08:22 -0700
Subject: [Intel-wired-lan] [PATCH net-next v1 0/4] ice: transmit improvement
 series
Message-ID: <20211026000826.156803-1-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Modify the ice driver to make a few modest changes to the transmit
hot path in order to reduce the number of cycles used, particularly
with high intensity workloads such as pktgen or IP forwarding.

Several of these changes are just using simpler API calls in
netdevice.h (welcome to 2015!)

The VSI_DOWN patch is a simple fix to make sure the driver's statements
about holding certain state bits for functions is enforced and remains
that way.

Jesse Brandeburg (4):
  ice: update to newer kernel API
  ice: use prefetch methods
  ice: tighter control over VSI_DOWN state
  ice: use modern kernel API for kick

 drivers/net/ethernet/intel/ice/ice_ethtool.c |  6 ++-
 drivers/net/ethernet/intel/ice/ice_main.c    |  7 ++--
 drivers/net/ethernet/intel/ice/ice_txrx.c    | 40 +++++++++++++-------
 3 files changed, 34 insertions(+), 19 deletions(-)

-- 
2.31.1

