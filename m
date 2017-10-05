From: Alan Brady <alan.brady@intel.com>
Date: Thu,  5 Oct 2017 14:53:30 -0700
Subject: [Intel-wired-lan] [PATCH v3 00/14 net-next] i40e: refactor ethtool
	interface
Message-ID: <20171005215344.2886-1-alan.brady@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This series brings i40e ethtool interface back into the modern era by
converting references to the old ethtool API to the new API.

This conversion allows us to provide much better support for new 25G and
10G PHY types.

This also includes a patch which adds new function to ethtool;
ethtool_intersect_link_masks.  i40e uses this function is used to take
what is supported by the PHY type and intersect it with what is
supported by the NVM, giving us what is truly supported.

v2: Removed extra new line.  Fixed comment split.  Removed
i40e_intersect_link_masks and added ethtool_intersect_link_masks to
net/core/ethtool.c.  Removed '.' from title of commit 09/13

v3: Fixed typo in "13/13 i40e: convert i40e_set_link_ksettings to new
API"; "unsuported" to "unsupported".  Extracted the addition of
ethtool_intersect_link_masks into its own patch.

Alan Brady (13):
  i40e: rename 'cmd' variables in ethtool interface
  i40e: remove ifdef SPEED_25000
  i40e: add function header for i40e_get_rxfh
  i40e: fix clearing link masks in i40e_get_link_ksettings
  i40e: fix i40e_phy_type_to_ethtool function header
  i40e: fix comment typo
  i40e: fix whitespace issues in i40e_ethtool.c
  i40e: group autoneg PHY types together
  ethtool: add ethtool_intersect_link_masks
  i40e: convert i40e_phy_type_to_ethtool to new API
  i40e: convert i40e_get_settings_link_up to new API
  i40e: rename 'change' variable to 'autoneg_changed'
  i40e: convert i40e_set_link_ksettings to new API

Sudheer Mogilappagari (1):
  i40e: Add new phy types for 25G AOC and ACC support

 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h  |   4 +
 drivers/net/ethernet/intel/i40e/i40e_common.c      |   2 +
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     | 715 +++++++++++++--------
 drivers/net/ethernet/intel/i40e/i40e_type.h        |   4 +
 .../net/ethernet/intel/i40evf/i40e_adminq_cmd.h    |   4 +
 include/linux/ethtool.h                            |  10 +
 net/core/ethtool.c                                 |  16 +
 7 files changed, 475 insertions(+), 280 deletions(-)

-- 
2.14.1

