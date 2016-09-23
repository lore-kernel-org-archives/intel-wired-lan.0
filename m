From: Stefan Assmann <sassmann@kpanic.de>
Date: Fri, 23 Sep 2016 15:30:56 +0200
Subject: [Intel-wired-lan] [PATCH net-next v2 0/2] i40e: clean-up and fix
	for the i40e debug code
Message-ID: <1474637458-5255-1-git-send-email-sassmann@kpanic.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

v2 fixes setting the debug_mask in i40e_set_msglevel().

Stefan Assmann (2):
  i40e: remove superfluous I40E_DEBUG_USER statement
  i40e: fix setting debug parameter early

 drivers/net/ethernet/intel/i40e/i40e_common.c  |  3 --
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c |  6 ----
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c |  3 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c    | 43 ++++++++++++--------------
 drivers/net/ethernet/intel/i40e/i40e_type.h    |  2 --
 5 files changed, 21 insertions(+), 36 deletions(-)

-- 
2.7.4

