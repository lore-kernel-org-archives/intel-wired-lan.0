From: Miller, Darin J <darin.j.miller@intel.com>
Date: Wed, 11 Nov 2015 23:38:11 +0000
Subject: [Intel-wired-lan] [PATCH 1/2] ixgbe: Correct spec violations
	by	waiting after reset
In-Reply-To: <20151027202314.87452.46904.stgit@mdrustad-wks.jf.intel.com>
References: <20151027202314.87452.46904.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <A91205FD8A6E14448BD4414C06E9C3D3752218B7@fmsmsx115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Mark D Rustad
Sent: Tuesday, October 27, 2015 1:23 PM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] [PATCH 1/2] ixgbe: Correct spec violations by waiting after reset

The ixgbe driver was violating the specification in the datasheel by not waiting 1ms before checking for the reset bit clearing. This is called out for devices supported by ixgbe, so implement the required delay.

Reported-by: Dan Streetman <dan.streetman@canonical.com>
Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c |    5 +++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c |    3 ++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c  |    3 ++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c  |    3 ++-
 4 files changed, 9 insertions(+), 5 deletions(-)

Tested-by: Darin Miller <darin.j.miller@intel.com>

