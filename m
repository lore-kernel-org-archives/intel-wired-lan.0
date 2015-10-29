From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Thu, 29 Oct 2015 00:34:22 +0000
Subject: [Intel-wired-lan] [next-queue] fm10k: initialize xps at driver
 load
In-Reply-To: <804857E1F29AAC47BF68C404FC60A1847EC6D967@ORSMSX105.amr.corp.intel.com>
References: <1445894912-10174-1-git-send-email-jacob.e.keller@intel.com>
 <804857E1F29AAC47BF68C404FC60A1847EC6D967@ORSMSX105.amr.corp.intel.com>
Message-ID: <02874ECE860811409154E81DA85FBB58577C58E5@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Allan, Bruce W
> Sent: Wednesday, October 28, 2015 5:12 PM
> To: Keller, Jacob E; Intel Wired LAN
> Subject: RE: [Intel-wired-lan] [next-queue] fm10k: initialize xps at driver
> load
> 
> > -----Original Message-----
> > From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org]
> On
> > Behalf Of Jacob Keller
> > Sent: Monday, October 26, 2015 2:29 PM
> > To: Intel Wired LAN
> > Subject: [Intel-wired-lan] [next-queue] fm10k: initialize xps at driver load
> >
> > Similar to ixgbe and i40e, initialize XPS on driver load so that we can
> > take advantage of this kernel feature.
> >
> > Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> > ---
> >  drivers/net/ethernet/intel/fm10k/fm10k.h     |  3 +++
> >  drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 18 ++++++++++++++++--
> >  2 files changed, 19 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/fm10k/fm10k.h
> > b/drivers/net/ethernet/intel/fm10k/fm10k.h
> > index 2a16cd1b2a8b..c84be8189f4c 100644
> > --- a/drivers/net/ethernet/intel/fm10k/fm10k.h
> > +++ b/drivers/net/ethernet/intel/fm10k/fm10k.h
> > @@ -23,6 +23,7 @@
> >
> >  #include <linux/types.h>
> >  #include <linux/etherdevice.h>
> > +#include <linux/cpumask.h>
> >  #include <linux/rtnetlink.h>
> >  #include <linux/if_vlan.h>
> >  #include <linux/pci.h>
> > @@ -66,6 +67,7 @@ struct fm10k_l2_accel {
> >  enum fm10k_ring_state_t {
> >  	__FM10K_TX_DETECT_HANG,
> >  	__FM10K_HANG_CHECK_ARMED,
> > +	__FM10K_TX_XPS_INIT_DONE,
> >  };
> >
> >  #define check_for_tx_hang(ring) \
> > @@ -209,6 +211,7 @@ struct fm10k_q_vector {
> >  	struct fm10k_ring_container rx, tx;
> >
> >  	struct napi_struct napi;
> > +	cpumask_t affinity_mask;
> >  	char name[IFNAMSIZ + 9];
> >
> >  #ifdef CONFIG_DEBUG_FS
> > diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
> > b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
> > index 15d8e10c2504..15e67a383d27 100644
> > --- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
> > +++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
> > @@ -727,6 +727,13 @@ static void fm10k_configure_rx_ring(struct
> > fm10k_intfc *interface,
> >
> >  	fm10k_write_reg(hw, FM10K_RXINT(reg_idx), rxint);
> >
> > +	/* Initialize XPS */
> > +	if (!test_and_set_bit(__FM10K_TX_XPS_INIT_DONE, &ring->state)
> > &&
> > +	    ring->q_vector)
> > +		netif_set_xps_queue(ring->netdev,
> > +				    &ring->q_vector->affinity_mask,
> > +				    ring->queue_index);
> > +
> 
> The above hunk belongs in fm10k_configure_tx_ring() instead???
> 

Oops, I think you're right.

Regards,
Jake

