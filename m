From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Mon, 28 Nov 2016 22:49:38 +0000
Subject: [Intel-wired-lan] [PATCH RFC v1] ethtool: implement helper to
	get flow_type value
In-Reply-To: <20161125.160634.944615331208897862.davem@davemloft.net>
References: <20161122234453.31611-1-jacob.e.keller@intel.com>
 <20161125.160634.944615331208897862.davem@davemloft.net>
Message-ID: <02874ECE860811409154E81DA85FBB5857CCA45D@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: netdev-owner at vger.kernel.org [mailto:netdev-owner at vger.kernel.org] On
> Behalf Of David Miller
> Sent: Friday, November 25, 2016 1:07 PM
> To: Keller, Jacob E <jacob.e.keller@intel.com>
> Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org
> Subject: Re: [PATCH RFC v1] ethtool: implement helper to get flow_type value
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> Date: Tue, 22 Nov 2016 15:44:53 -0800
> 
> > @@ -880,6 +880,14 @@ struct ethtool_rx_flow_spec {
> >  	__u32		location;
> >  };
> >
> > +/* Flag to enable additional fields in struct ethtool_rx_flow_spec */
> > +#define	FLOW_EXT	0x80000000
> > +#define	FLOW_MAC_EXT	0x40000000
> > +static inline __u32 ethtool_get_flow_spec_type(__u32 flow_type)
> > +{
> > +	return flow_type & (FLOW_EXT | FLOW_MAC_EXT);
> > +}
> > +
> >  /* How rings are layed out when accessing virtual functions or
> >   * offloaded queues is device specific. To allow users to do flow
> >   * steering and specify these queues the ring cookie is partitioned
> > @@ -1579,9 +1587,6 @@ static inline int ethtool_validate_duplex(__u8 duplex)
> >  #define	IPV4_FLOW	0x10	/* hash only */
> >  #define	IPV6_FLOW	0x11	/* hash only */
> >  #define	ETHER_FLOW	0x12	/* spec only (ether_spec) */
> > -/* Flag to enable additional fields in struct ethtool_rx_flow_spec */
> > -#define	FLOW_EXT	0x80000000
> > -#define	FLOW_MAC_EXT	0x40000000
> >
> >  /* L3-L4 network traffic flow hash options */
> >  #define	RXH_L2DA	(1 << 1)
> 
> Please put the helper after the FLOW_* definitions rather than moving
> them earlier in the file.

Will do. I originally moved them to place these with other similar helpers but I can re-spin this.

Thanks,
Jake
