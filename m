From: Corinna Vinschen <vinschen@redhat.com>
Date: Fri, 14 Jan 2022 11:27:43 +0100
Subject: [Intel-wired-lan] [PATCH net-next] igc: avoid kernel warning
 when changing RX ring parameters
In-Reply-To: <87sftr6tle.fsf@intel.com>
References: <20220113160021.1027704-1-vinschen@redhat.com>
 <87sftr6tle.fsf@intel.com>
Message-ID: <YeFQH0/LY9R9GWxF@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Jan 13 16:37, Vinicius Costa Gomes wrote:
> Corinna Vinschen <vinschen@redhat.com> writes:
> 
> > Calling ethtool changing the RX ring parameters like this:
> >
> >   $ ethtool -G eth0 rx 1024
> >
> > triggers the "Missing unregister, handled but fix driver" warning in
> > xdp_rxq_info_reg().
> >[...]
> 
> Reaching "inside" xdp_rxq to reset it doesn't feel right in this
> context, even if it's going to work fine (for now).
> 
> I think that the suggestion that Alexander gave in that other thread is
> the best approach. And thanks for noticing that igb '_set_ringparam()'
> has the same underlying problem and also needs to be fixed.

Yeah, it didn't sit overly well with me either, but I thought if it's
good for igb...

Either way, the better approach should be sth. like this in both,
ig[bc]_setup_rx_resources:

	if (xdp_rxq_info_is_reg(&rx_ring->xdp_rxq))
		xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
	res = xdp_rxq_info_reg(&rx_ring->xdp_rxq, ndev, index,
			       rx_ring->q_vector->napi.napi_id);

And while at it, wouldn't it make sense to move the xdp_rxq_info_reg
call in igc_setup_rx_resources down to be the last action, so the error
path doesn't have to call xdp_rxq_info_unreg, just like in
igb_setup_rx_resources?


Thanks,
Corinna

