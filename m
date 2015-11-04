From: Miller, Darin J <darin.j.miller@intel.com>
Date: Wed, 4 Nov 2015 01:21:56 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Add support for newer thermal
 alarm
In-Reply-To: <20151019162214.127450.12072.stgit@mdrustad-wks.jf.intel.com>
References: <20151019162214.127450.12072.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <A91205FD8A6E14448BD4414C06E9C3D375210B72@fmsmsx115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Mark D Rustad
Sent: Monday, October 19, 2015 9:22 AM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] [PATCH] ixgbe: Add support for newer thermal alarm

The newer copper phy implementation used with newer X550EM_x devices uses a different thermal alarm type than the earlier one. Make changes to support both types.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |    4 ++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |   22 +++++++++++++++++++---
 2 files changed, 23 insertions(+), 3 deletions(-)

Tested-by: Darin Miller <darin.j.miller@intel.com>

