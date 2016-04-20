From: K. Y. Srinivasan <kys@microsoft.com>
Date: Tue, 19 Apr 2016 19:17:35 -0700
Subject: [Intel-wired-lan] [PATCH net-next V5 0/2] ethernet: intel: Support
	Hyper-V hosts
Message-ID: <1461118655-28103-1-git-send-email-kys@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Make adjustments to the Intel 10G VF driver to support
running on Hyper-V hosts.

K. Y. Srinivasan (2):
  ethernet: intel: Add the device ID's presented while running on
    Hyper-V
  intel: ixgbevf: Support Windows hosts (Hyper-V)

 drivers/net/ethernet/intel/ixgbevf/defines.h      |    5 +
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h      |   12 ++
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |   31 +++-
 drivers/net/ethernet/intel/ixgbevf/mbx.c          |   12 ++
 drivers/net/ethernet/intel/ixgbevf/vf.c           |  216 +++++++++++++++++++++
 drivers/net/ethernet/intel/ixgbevf/vf.h           |    2 +
 6 files changed, 271 insertions(+), 7 deletions(-)

-- 
1.7.4.1

