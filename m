From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Tue, 26 Oct 2021 18:47:17 +0200
Subject: [Intel-wired-lan] [PATCH intel-next 0/2] ice: ethtool -L fixes
Message-ID: <20211026164719.1766911-1-maciej.fijalkowski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi there,

here are the two fixes for issues around ethtool's set_channels()
callback for ice driver. Both are related to XDP resources. First one
corrects the size of vsi->txq_map that is used to track the usage of Tx
resources and the second one prevents the wrong refcounting of bpf_prog.

Thanks!

Maciej Fijalkowski (2):
  ice: fix vsi->txq_map sizing
  ice: avoid bpf_prog refcount underflow

 drivers/net/ethernet/intel/ice/ice_lib.c  |  9 +++++++--
 drivers/net/ethernet/intel/ice/ice_main.c | 18 +++++++++++++++++-
 2 files changed, 24 insertions(+), 3 deletions(-)

-- 
2.31.1

