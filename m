From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 31 Jul 2020 19:56:17 +0000
Subject: [Intel-wired-lan] [PATCH S51 08/13] ice: port fix for
 chk_linearlize
In-Reply-To: <20200730001922.52568-8-anthony.l.nguyen@intel.com>
References: <20200730001922.52568-1-anthony.l.nguyen@intel.com>
 <20200730001922.52568-8-anthony.l.nguyen@intel.com>
Message-ID: <BN6PR1101MB21451FF54FFF932E89C8761B8C4E0@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Wednesday, July 29, 2020 5:19 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S51 08/13] ice: port fix for chk_linearlize
> 
> From: Kiran Patil <kiran.patil@intel.com>
> 
> This is a port of commit 248de22e638f ("i40e/i40evf: Account for frags split
> over multiple descriptors in check linearize")
> 
> As part of testing workloads (read/write) using larger IO size (128K)
> tx_timeout is observed and whenever it happens, it was due to tx_linearize.
> 
> Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_txrx.c | 26 ++++++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


