From: Jiri Pirko <jiri@resnulli.us>
Date: Sun, 24 Jun 2018 10:38:36 +0200
Subject: [Intel-wired-lan] [patch net-next 0/3] net: sched: couple of
 ndo_setup_tc fixes and adjustments
Message-ID: <20180624083839.1692-1-jiri@resnulli.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jiri Pirko <jiri@mellanox.com>

This patchset includes couple of patches that fix or adjust default
cases and return values in ndo_setup_tc implementations in drivers.

Jiri Pirko (3):
  bnxt: simplify cls_flower command switch and handle default case
  nfp: handle cls_flower command default case
  cls_flower: fix error values for commands not supported by drivers

 drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c        | 16 +++++-----------
 drivers/net/ethernet/intel/i40e/i40e_main.c         |  2 +-
 drivers/net/ethernet/intel/i40evf/i40evf_main.c     |  2 +-
 drivers/net/ethernet/intel/igb/igb_main.c           |  2 +-
 drivers/net/ethernet/netronome/nfp/flower/offload.c |  4 ++--
 5 files changed, 10 insertions(+), 16 deletions(-)

-- 
2.14.4

