From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Fri, 22 May 2015 23:34:01 +0000
Subject: [Intel-wired-lan] [net-next PATCH v4 2/2] ixgbe: Allow flow
 director to use entire queue space
In-Reply-To: <20150518161930.8927.83186.stgit@nitbit.x32>
References: <20150518161847.8927.65430.stgit@nitbit.x32>
 <20150518161930.8927.83186.stgit@nitbit.x32>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E2717055D@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of John Fastabend
Sent: Monday, May 18, 2015 9:20 AM
To: alexander.h.duyck@redhat.com
Cc: intel-wired-lan at lists.osuosl.org
Subject: [Intel-wired-lan] [net-next PATCH v4 2/2] ixgbe: Allow flow director to use entire queue space

Flow director is exported to user space using the ethtool ntuple support. However, currently it only supports steering traffic to a subset of the queues in use by the hardware. This change allows flow director to specify queues that have been assigned to virtual functions by partitioning the ring_cookie into a 8bit vf specifier followed by 32bit queue index. At the moment we don't have any ethernet drivers with more than 2^32 queues on a single function as best I can tell and nor do I expect this to happen anytime soon. This way the ring_cookie's normal use for specifying a queue on a specific PCI function continues to work as expected.

Signed-off-by: John Fastabend <john.r.fastabend@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |   34 ++++++++++++++++------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index eafa9ec..057a7c5 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c

Tested-by:  Krishneil Singh <Krishneil.k.singh@intel.com>


