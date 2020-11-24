From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Tue, 24 Nov 2020 14:49:09 +0000
Subject: [Intel-wired-lan] [PATCH v4 6/6] igb: avoid transmit queue
 timeout in xdp path
In-Reply-To: <20201111170453.32693-7-sven.auhagen@voleatech.de>
References: <20201111170453.32693-1-sven.auhagen@voleatech.de>
 <20201111170453.32693-7-sven.auhagen@voleatech.de>
Message-ID: <MW3PR11MB45543A4F861FB94DBF2B01589CFB0@MW3PR11MB4554.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: sven.auhagen@voleatech.de <sven.auhagen@voleatech.de> 
Sent: Wednesday, November 11, 2020 10:35 PM
To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Fijalkowski, Maciej <maciej.fijalkowski@intel.com>; kuba at kernel.org
Cc: davem at davemloft.net; intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org; nhorman at redhat.com; sassmann at redhat.com; Penigalapati, Sandeep <sandeep.penigalapati@intel.com>; brouer at redhat.com; pmenzel at molgen.mpg.de
Subject: [PATCH v4 6/6] igb: avoid transmit queue timeout in xdp path

From: Sven Auhagen <sven.auhagen@voleatech.de>

Since we share the transmit queue with the network stack, it is possible that we run into a transmit queue timeout.
This will reset the queue.
This happens under high load when XDP is using the transmit queue pretty much exclusively.

netdev_start_xmit() sets the trans_start variable of the transmit queue to jiffies which is later utilized by dev_watchdog(), so to avoid timeout, let stack know that XDP xmit happened by bumping the trans_start within XDP Tx routines to jiffies.

Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Sven Auhagen <sven.auhagen@voleatech.de>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 5 +++++
 1 file changed, 5 insertions(+)

Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
