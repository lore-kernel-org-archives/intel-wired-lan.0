From: Miller, Darin J <darin.j.miller@intel.com>
Date: Wed, 4 Nov 2015 01:30:36 +0000
Subject: [Intel-wired-lan] [PATCH V2] ixgbe: Save VF info and take
 references
In-Reply-To: <20151030222934.93903.57078.stgit@mdrustad-wks.jf.intel.com>
References: <20151030222934.93903.57078.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <A91205FD8A6E14448BD4414C06E9C3D375210BDF@fmsmsx115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Mark D Rustad
Sent: Friday, October 30, 2015 3:30 PM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] [PATCH V2] ixgbe: Save VF info and take references

Save VF device pointers and take references to speed accesses used to monitor the device behavior to avoid slot resets. The saved information avoids lock contention during the search used to access each of the VFs.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
Changes in V2:
- Added check for a status register of 0xffff as suggested by Don Dutile
  at RedHat.
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h       |    1 
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  |   31 +++++----------
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c |   50 +++++++++++++++++++++++-
 3 files changed, 59 insertions(+), 23 deletions(-)

Tested-by: Darin Miller <darin.j.miller@intel.com>

