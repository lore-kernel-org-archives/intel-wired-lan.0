From: Miller, Darin J <darin.j.miller@intel.com>
Date: Wed, 28 Oct 2015 20:56:47 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Prevent KR PHY reset
	in	ixgbe_init_phy_ops_x550em
In-Reply-To: <20151016202748.115639.26219.stgit@mdrustad-wks.jf.intel.com>
References: <20151016202748.115639.26219.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <A91205FD8A6E14448BD4414C06E9C3D37520DB0A@fmsmsx115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Mark D Rustad
Sent: Friday, October 16, 2015 1:28 PM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] [PATCH] ixgbe: Prevent KR PHY reset in ixgbe_init_phy_ops_x550em

This patch removes KR PHY reset from ixgbe_init_phy_ops_x550em, since this function is meant to initialize function pointers for the detected PHY type. Internal PHY reset was moved to ixgbe_setup_internal_phy_t_x550em which will now detect which mode the internal PHY operates in and set it up as required.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |   21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

Tested-by: Darin Miller <darin.j.miller@intel.com>
