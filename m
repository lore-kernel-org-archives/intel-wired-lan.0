From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon,  6 Feb 2017 14:38:37 -0800
Subject: [Intel-wired-lan] [PART1 PATCH 00/11] ethtool flow director fixups
Message-ID: <20170206223846.31052-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This series is PART1 of 2 parts, containing some initial fixups for the
ethtool ntuple filter API. The first part should be relatively
self-contained and each fix should stand on its own. It is textually
necessary for this series to land before PART2 can be applied.

Jacob Keller (11):
  i40e: send correct port number to AdminQ when enabling UDP tunnels
  i40e: don't use arrays for (src|dst)_ip
  i40e: rework exit flow of i40e_add_fdir_ethtool
  i40e: return immediately when failing to add fdir filter
  i40e: exit ATR mode only when adding TCP/IPv4 filter succeeds
  i40e: remove redundant check for fd_tcp_rule when restoring filters
  i40e: reset fd_tcp_rule count when restoring filters
  i40e: don't re-enable ATR when flushing filters if SB has TCP4/IPv4
    rules
  i40e: add counters for UDP/IPv4 and IPv4 filters
  i40e: explicitly fail on extended MAC field for ethtool_rx_flow_spec
  i40e: always remove old filter when adding new FDir filter

 drivers/net/ethernet/intel/i40e/i40e.h         | 16 +++--
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 59 ++++++++----------
 drivers/net/ethernet/intel/i40e/i40e_main.c    | 43 +++++++------
 drivers/net/ethernet/intel/i40e/i40e_txrx.c    | 84 ++++++++++++++------------
 4 files changed, 105 insertions(+), 97 deletions(-)

-- 
2.12.0.rc0.151.g8a5726c42288

