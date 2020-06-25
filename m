From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 25 Jun 2020 17:04:23 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2 3/3] i40e: move check of
 full Tx ring to outside of send loop
In-Reply-To: <1592905458-850-4-git-send-email-magnus.karlsson@intel.com>
References: <1592905458-850-1-git-send-email-magnus.karlsson@intel.com>
 <1592905458-850-4-git-send-email-magnus.karlsson@intel.com>
Message-ID: <BN6PR1101MB2145E97EE9FE44B7BA49F75D8C920@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Magnus Karlsson
> Sent: Tuesday, June 23, 2020 2:44 AM
> To: Karlsson, Magnus <magnus.karlsson@intel.com>; Topel, Bjorn
> <bjorn.topel@intel.com>; intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>; Samudrala, Sridhar
> <sridhar.samudrala@intel.com>
> Cc: maciejromanfijalkowski at gmail.com; Fijalkowski, Maciej
> <maciej.fijalkowski@intel.com>; netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH net-next v2 3/3] i40e: move check of full Tx
> ring to outside of send loop
> 
> Move the check if the Hw Tx ring is full to outside the send loop. Currently it
> is checked for every single descriptor that we send. Instead, tell the send
> loop to only process a maximum number of packets equal to the number of
> available slots in the Tx ring. This way, we can remove the check inside the
> send loop to and gain some performance.
> 
> Suggested-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c | 20 +++++---------------
>  1 file changed, 5 insertions(+), 15 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


