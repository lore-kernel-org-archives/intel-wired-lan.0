From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Wed, 11 Nov 2020 05:31:10 +0000
Subject: [Intel-wired-lan] [PATCH net v3 3/6] igb: XDP extack message on
 error
In-Reply-To: <20201019080553.24353-4-sven.auhagen@voleatech.de>
References: <20201019080553.24353-1-sven.auhagen@voleatech.de>
 <20201019080553.24353-4-sven.auhagen@voleatech.de>
Message-ID: <MW3PR11MB45546AAC75C837E4C487873A9CE80@MW3PR11MB4554.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: sven.auhagen@voleatech.de <sven.auhagen@voleatech.de> 
Sent: Monday, October 19, 2020 1:36 PM
To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Fijalkowski, Maciej <maciej.fijalkowski@intel.com>; kuba at kernel.org
Cc: davem at davemloft.net; intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org; nhorman at redhat.com; sassmann at redhat.com; Penigalapati, Sandeep <sandeep.penigalapati@intel.com>; brouer at redhat.com
Subject: [PATCH net v3 3/6] igb: XDP extack message on error

From: Sven Auhagen <sven.auhagen@voleatech.de>

Add an extack error message when the RX buffer size is too small for the frame size.

Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Sven Auhagen <sven.auhagen@voleatech.de>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
