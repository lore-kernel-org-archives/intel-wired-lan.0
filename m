From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon,  6 Feb 2017 14:38:43 -0800
Subject: [Intel-wired-lan] [PART2 PATCH 0/9] ethtool ntuple filters
Message-ID: <20170206223852.31177-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This series (labeled PART2) contains patches to implement flexible data
filters for the ntuple ethtool API, making use of the user-def field.
First, it resolves a longstanding issue with the API not properly
honoring mask fields.

Second, it implements support for partial filtering, allowing the user
to filter only partially on some fields, rather than requiring all
fields to be used.

Finally, it implements the flexible byte ntuple filters on top of the
cleaned up code.

It is dependent on the series labeled PART1 which has self-contained bug
fixes.

Jacob Keller (9):
  i40e: correctly honor the mask fields for ETHTOOL_SRXCLSRLINS
  i40e: check current configured input set when adding ntuple filters
  i40e: restore default input set for each flow type
  i40e: allow changing input set for ntuple filters
  i40e: partition the ring_cookie to get VF index
  i40e: add parsing of flexible filter fields from userdef
  i40e: implement support for flexible word payload
  i40e: add support for SCTPv4 FDir filters
  i40e: document drivers use of ntuple filters

 Documentation/networking/i40e.txt              |  72 ++
 drivers/net/ethernet/intel/i40e/i40e.h         | 130 ++++
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 970 ++++++++++++++++++++++++-
 drivers/net/ethernet/intel/i40e/i40e_main.c    |  37 +
 drivers/net/ethernet/intel/i40e/i40e_txrx.c    | 107 +++
 5 files changed, 1283 insertions(+), 33 deletions(-)

-- 
2.12.0.rc0.151.g8a5726c42288

