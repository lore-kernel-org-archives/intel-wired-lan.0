From: Miller, Darin J <darin.j.miller@intel.com>
Date: Wed, 4 Nov 2015 01:36:10 +0000
Subject: [Intel-wired-lan] [PATCH 2/3] ixgbevf: Use a private workqueue
 to avoid certain possible hangs
In-Reply-To: <20151022002115.51120.4428.stgit@mdrustad-wks.jf.intel.com>
References: <20151022002110.51120.4643.stgit@mdrustad-wks.jf.intel.com>
 <20151022002115.51120.4428.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <A91205FD8A6E14448BD4414C06E9C3D375210C0C@fmsmsx115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Mark D Rustad
Sent: Wednesday, October 21, 2015 5:21 PM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] [PATCH 2/3] ixgbevf: Use a private workqueue to avoid certain possible hangs

Use a private workqueue to avoid hangs that were otherwise possible when performing stress tests, such as creating and destroying many vfs repeatedly.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

Tested-by: Darin Miller <darin.j.miller@intel.com>

