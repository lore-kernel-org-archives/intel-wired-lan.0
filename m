From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 4 Dec 2018 17:01:24 +0000
Subject: [Intel-wired-lan] [PATCH] intel: ice: Do not enable NAPI on
 q_vectors that have no rings
In-Reply-To: <HK0PR01MB21630071FC7DAA5B3189A40EADD20@HK0PR01MB2163.apcprd01.prod.exchangelabs.com>
References: <HK0PR01MB21630071FC7DAA5B3189A40EADD20@HK0PR01MB2163.apcprd01.prod.exchangelabs.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D32C629@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Yang Xiao
> Sent: Wednesday, November 28, 2018 5:54 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; davem at davemloft.net
> Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org; Yang Xiao
> <YangX92@hotmail.com>
> Subject: [Intel-wired-lan] [PATCH] intel: ice: Do not enable NAPI on
> q_vectors that have no rings
> 
> From: Young Xiao <YangX92@hotmail.com>
> 
> If ice driver has q_vectors w/ active NAPI that has no rings, then this will
> result in a divide by zero error. To correct it I am updating the driver code so
> that we only support NAPI on q_vectors that have 1 or more rings allocated
> to them.
> 
> See commit 13a8cd191a2b ("i40e: Do not enable NAPI on q_vectors that have
> no rings") for detail.
> 
> Signed-off-by: Young Xiao <YangX92@hotmail.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


