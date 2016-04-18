From: K. Y. Srinivasan <kys@microsoft.com>
Date: Sun, 17 Apr 2016 22:22:47 -0700
Subject: [Intel-wired-lan] [PATCH net-next V2 0/2] ethernet: intel: Support
	Hyper-V hosts
In-Reply-To: <1460956943-17560-1-git-send-email-kys@microsoft.com>
References: <1460956943-17560-1-git-send-email-kys@microsoft.com>
Message-ID: <1460956969-17601-1-git-send-email-kys@microsoft.com>
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
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |   16 ++-
 drivers/net/ethernet/intel/ixgbevf/mbx.c          |   12 ++
 drivers/net/ethernet/intel/ixgbevf/vf.c           |  201 +++++++++++++++++++++
 5 files changed, 242 insertions(+), 4 deletions(-)

-- 
1.7.4.1

