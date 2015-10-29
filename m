From: Miller, Darin J <darin.j.miller@intel.com>
Date: Thu, 29 Oct 2015 01:39:07 +0000
Subject: [Intel-wired-lan] [PATCH 3/3] ixgbevf: Minor cleanups
In-Reply-To: <20151022002120.51120.55397.stgit@mdrustad-wks.jf.intel.com>
References: <20151022002110.51120.4643.stgit@mdrustad-wks.jf.intel.com>
 <20151022002120.51120.55397.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <A91205FD8A6E14448BD4414C06E9C3D37520DF27@fmsmsx115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Mark D Rustad
Sent: Wednesday, October 21, 2015 5:21 PM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] [PATCH 3/3] ixgbevf: Minor cleanups

Make some minor cleanups, such as simplifying return paths, deleting unneded initializations, return values more directly and so forth.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |   36 +++++++--------------
 1 file changed, 12 insertions(+), 24 deletions(-)

Tested-by: Darin Miller <darin.j.miller@intel.com>
