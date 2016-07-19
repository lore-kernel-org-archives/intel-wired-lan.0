From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 19 Jul 2016 16:23:28 -0700
Subject: [Intel-wired-lan] [PATCH v1 0/3] i40e: fix RSS on X722
Message-ID: <20160719232331.31422-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The X722 device supports configuring the RSS lookup table and hash key
using the admin queue instead of using registers. However, this
functionality is broken due to a couple of missing refactors which got
lost in the mix. This patch series moves some code around and finishes
the missing refactors so that things work as expected. It resolves a
NULL pointer dereference caused by ethtool -X and fixes VMQd user
configured RSS settings.

Jacob Keller (3):
  i40e: move i40e_vsi_config_rss below i40e_get_rss_aq
  i40e: fix broken i40e_config_rss_aq function
  i40e: use configured RSS key and lookup table in i40e_vsi_config_rss

 drivers/net/ethernet/intel/i40e/i40e_main.c | 124 ++++++++++++++--------------
 1 file changed, 63 insertions(+), 61 deletions(-)

-- 
2.9.0.rc1.405.g81f467e

