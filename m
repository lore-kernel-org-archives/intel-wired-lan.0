From: Leon Romanovsky <leon@kernel.org>
Date: Thu, 23 Sep 2021 21:12:47 +0300
Subject: [Intel-wired-lan] [PATCH net-next 0/6] Batch of devlink related
 fixes
Message-ID: <cover.1632420430.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Leon Romanovsky <leonro@nvidia.com>

Hi,

I'm asking to apply this batch of devlink fixes to net-next and not to
net, because most if not all fixes are for old code or/and can be considered
as cleanup.

It will cancel the need to deal with merge conflicts for my next devlink series :).

Thanks

Leon Romanovsky (6):
  bnxt_en: Check devlink allocation and registration status
  bnxt_en: Properly remove port parameter support
  devlink: Delete not used port parameters APIs
  devlink: Remove single line function obfuscations
  ice: Delete always true check of PF pointer
  qed: Don't ignore devlink allocation failures

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |   5 +-
 .../net/ethernet/broadcom/bnxt/bnxt_devlink.c |  26 +---
 .../net/ethernet/broadcom/bnxt/bnxt_devlink.h |  13 --
 drivers/net/ethernet/intel/ice/ice_main.c     |   3 -
 drivers/net/ethernet/qlogic/qede/qede_main.c  |  12 +-
 drivers/scsi/qedf/qedf_main.c                 |   2 +
 include/net/devlink.h                         |   6 -
 net/core/devlink.c                            | 123 +++++-------------
 8 files changed, 47 insertions(+), 143 deletions(-)

-- 
2.31.1

