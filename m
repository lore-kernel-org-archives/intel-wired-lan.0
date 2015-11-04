From: Miller, Darin J <darin.j.miller@intel.com>
Date: Wed, 4 Nov 2015 01:35:40 +0000
Subject: [Intel-wired-lan] [PATCH 1/3] ixgbe: Use private workqueue to
 avoid certain possible hangs
In-Reply-To: <20151022002110.51120.4643.stgit@mdrustad-wks.jf.intel.com>
References: <20151022002110.51120.4643.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <A91205FD8A6E14448BD4414C06E9C3D375210C02@fmsmsx115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Mark D Rustad
Sent: Wednesday, October 21, 2015 5:21 PM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] [PATCH 1/3] ixgbe: Use private workqueue to avoid certain possible hangs

Use a private workqueue to avoid hangs that were otherwise possible when performing stress tests, such as creating and destroying many vfs repeatedly.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 0 files changed

Tested-by: Darin Miller <darin.j.miller@intel.com>

