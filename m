From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Tue, 8 Jun 2021 23:08:08 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2] ice: add tracepoints
In-Reply-To: <20210608092705.00005761@intel.com>
References: <20210528014943.3036054-1-jesse.brandeburg@intel.com>
 <20210608092705.00005761@intel.com>
Message-ID: <1e972693734fc6c19fc03b74cb3037b0a4f42852.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2021-06-08 at 09:27 -0700, Jesse Brandeburg wrote:
> Jesse Brandeburg wrote:
> 
> > This patch is modeled after one by Scott Peterson for i40e.
> 
> I found a little bug in the code, Tony do you want to correct it or
> have me send a v3?

A v3 would be preferable.

Thanks,
Tony

> > +DECLARE_EVENT_CLASS(ice_tx_dim_template,
> > +		    TP_PROTO(struct ice_q_vector *q_vector, struct dim
> > *dim),
> > +		    TP_ARGS(q_vector, dim),
> > +		    TP_STRUCT__entry(__field(struct ice_q_vector *,
> > q_vector)
> > +				     __field(struct dim *, dim)
> > +				     __string(devname, q_vector-
> > >tx.ring->netdev->name)),
> > +
> > +		    TP_fast_assign(__entry->q_vector = q_vector;
> > +				   __entry->dim = dim;
> > +				   __assign_str(devname, q_vector-
> > >tx.ring->netdev->name);),
> > +
> > +		    TP_printk("netdev: %s Tx-Q: %d dim-state: %d dim-
> > profile: %d dim-tune: %d dim-st-right: %d dim-st-left: %d dim-
> > tired: %d",
> > +			      __get_str(devname),
> > +			      __entry->q_vector->rx.ring->q_index,
> 
> should be:                                       tx.ring
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
