From: Kuruvinakunnel, George <george.kuruvinakunnel@intel.com>
Date: Tue, 13 Oct 2020 06:34:58 +0000
Subject: [Intel-wired-lan] [PATCH net-next] i40e: remove redundant
 assigment
In-Reply-To: <20200908123440.11278-1-marekx.majtyka@intel.com>
References: <20200908123440.11278-1-marekx.majtyka@intel.com>
Message-ID: <SN6PR11MB30082C2927FF8287E58FF69EE2040@SN6PR11MB3008.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Marek Majtyka
Sent: Tuesday, September 8, 2020 6:05 PM
To: Karlsson, Magnus <magnus.karlsson@intel.com>; Topel, Bjorn <bjorn.topel@intel.com>; intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
Cc: netdev at vger.kernel.org; Fijalkowski, Maciej <maciej.fijalkowski@intel.com>; Majtyka, MarekX <marekx.majtyka@intel.com>; maciejromanfijalkowski at gmain.com
Subject: [Intel-wired-lan] [PATCH net-next] i40e: remove redundant assigment

Remove a redundant assigment of the software ring pointer in the i40e driver. The variable is assigned twice with no use in between, so just get rid of the first occurrence.

Fixes: 3b4f0b66c2b3 ("i40e, xsk: Migrate to new MEM_TYPE_XSK_BUFF_POOL")
Signed-off-by: Marek Majtyka <marekx.majtyka@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_xsk.c | 1 -
 1 file changed, 1 deletion(-)

Tested-by: George Kuruvinakunnel <george.kuruvinakunnel@intel.com>


