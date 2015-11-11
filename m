From: Miller, Darin J <darin.j.miller@intel.com>
Date: Wed, 11 Nov 2015 23:41:31 +0000
Subject: [Intel-wired-lan] [PATCH 2/2] ixgbe: Wait for master disable to
 be	set
In-Reply-To: <20151027202323.87452.79685.stgit@mdrustad-wks.jf.intel.com>
References: <20151027202314.87452.46904.stgit@mdrustad-wks.jf.intel.com>
 <20151027202323.87452.79685.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <A91205FD8A6E14448BD4414C06E9C3D3752218D8@fmsmsx115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Mark D Rustad
Sent: Tuesday, October 27, 2015 1:23 PM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] [PATCH 2/2] ixgbe: Wait for master disable to be set

According to the datasheets, the driver should wait for the master disable bit to read as being set before checking the status register for master disable.

Reported-by: Dan Streetman <dan.streetman@canonical.com>
Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

Tested-by: Darin Miller <darin.j.miller@intel.com>

