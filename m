From: Switzer, David <david.switzer@intel.com>
Date: Fri, 9 Apr 2021 19:39:20 +0000
Subject: [Intel-wired-lan] [net PATCH] ixgbe: Fix NULL pointer
 dereference in ethtool loopback test
In-Reply-To: <161523611656.36376.3641992659589167121.stgit@localhost.localdomain>
References: <161523611656.36376.3641992659589167121.stgit@localhost.localdomain>
Message-ID: <MW3PR11MB4748FAECF13CAF958B57A9B5EB739@MW3PR11MB4748.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


>-----Original Message-----
>From: Alexander Duyck <alexander.duyck@gmail.com>
>Sent: Monday, March 8, 2021 12:42 PM
To: intel-wired-lan@lists.osuosl.org
>Cc: Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L
><anthony.l.nguyen@intel.com>; netdev at vger.kernel.org
>Subject: [net PATCH] ixgbe: Fix NULL pointer dereference in ethtool loopback test
>
>From: Alexander Duyck <alexanderduyck@fb.com>
>
>The ixgbe driver currently generates a NULL pointer dereference when
>performing the ethtool loopback test. This is due to the fact that there isn't a
>q_vector associated with the test ring when it is setup as interrupts are not
>normally added to the test rings.
>
>To address this I have added code that will check for a q_vector before returning
>a napi_id value. If a q_vector is not present it will return a value of 0.
>
>Fixes: b02e5a0ebb17 ("xsk: Propagate napi_id to XDP socket Rx path")
>Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
>---
> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    9 ++++++++-
> 1 file changed, 8 insertions(+), 1 deletion(-)
>
Tested-by: Dave Switzer <david.switzer@intel.com>

