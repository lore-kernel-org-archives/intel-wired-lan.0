From: Young, James M <james.m.young@intel.com>
Date: Sat, 9 May 2015 00:21:53 +0000
Subject: [Intel-wired-lan] [net-next S4 12/15] i40evf: skb->xmit_more
 support
In-Reply-To: <1429229172-143692-13-git-send-email-catherine.sullivan@intel.com>
References: <1429229172-143692-1-git-send-email-catherine.sullivan@intel.com>
 <1429229172-143692-13-git-send-email-catherine.sullivan@intel.com>
Message-ID: <68C85B5FC2FE974B87244D7222BC92783E9F998B@ORSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Thursday, April 16, 2015 5:06 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Daniel Borkmann; Eric Dumazet
> Subject: [Intel-wired-lan] [net-next S4 12/15] i40evf: skb->xmit_more
> support
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> Eric added support for skb->xmit_more in i40e, this ports that into i40evf as
> well.
> 
> Support skb->xmit_more in i40evf is straightforward; we need to move
> around i40e_maybe_stop_tx() call to correctly test netif_xmit_stopped()
> before taking the decision to not kick the NIC.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Daniel Borkmann <dborkman@redhat.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Change-ID: Idddda6a2e4a7ab335631c91ced51f55b25eb8468
> ---
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 88 ++++++++++++++---------
> ----
>  1 file changed, 47 insertions(+), 41 deletions(-)

Tested-by: Jim Young <james.m.young@intel.com>

