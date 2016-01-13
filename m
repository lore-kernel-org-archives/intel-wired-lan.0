From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Tue, 12 Jan 2016 19:32:29 -0800
Subject: [Intel-wired-lan] [PATCH 0/2] Convert ixgbe/i40e to use
	eth_platform_get_mac_address
Message-ID: <cover.1452655483.git.sowmini.varadhan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Commit c7f5d105495a ("net: Add eth_platform_get_mac_address()
helper.") provides a consolidation path for platforms like SPARC
to implement arch specific code to extract the MAC address
from Open Firmware, IDPROM etc.

This patchset converts ixgbe and i40e to use eth_platform_get_mac_address()

Sowmini Varadhan (2):
  ixgbe: use eth_platform_get_mac_address()
  i40e: use eth_platform_get_mac_address()

 drivers/net/ethernet/intel/i40e/i40e_main.c   |   19 +-------------
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   35 +-----------------------
 2 files changed, 3 insertions(+), 51 deletions(-)

