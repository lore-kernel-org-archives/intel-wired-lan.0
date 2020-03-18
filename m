From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 18 Mar 2020 17:20:39 +0000
Subject: [Intel-wired-lan] [PATCH net-next] i40e: trivial fixup of
 comments in i40e_xsk.c
In-Reply-To: <158435379870.2479973.8293720099992666964.stgit@carbon>
References: <158435379870.2479973.8293720099992666964.stgit@carbon>
Message-ID: <25812f58f1e1431580115028dfdbb0ad@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Jesper Dangaard Brouer
>Sent: Monday, March 16, 2020 3:17 AM
>To: Jesper Dangaard Brouer <brouer@redhat.com>; netdev at vger.kernel.org
>Cc: Topel, Bjorn <bjorn.topel@intel.com>; intel-wired-lan at lists.osuosl.org; Karlsson, Magnus <magnus.karlsson@intel.com>
>Subject: [Intel-wired-lan] [PATCH net-next] i40e: trivial fixup of comments in i40e_xsk.c
>
>The comment above i40e_run_xdp_zc() was clearly copy-pasted from function i40e_xsk_umem_setup, which is just above.
>
>Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
>---
> drivers/net/ethernet/intel/i40e/i40e_xsk.c |    4 +---
>1 file changed, 1 insertion(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


