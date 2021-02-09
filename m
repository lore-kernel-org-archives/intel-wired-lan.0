From: Dan Siemon <dan@coverfire.com>
Date: Tue, 09 Feb 2021 10:03:16 -0500
Subject: [Intel-wired-lan] 710/i40e, RSS and 802.1ad (double vlan)
In-Reply-To: <8c7d255047890290948cf51450b1f860e013b48c.camel@coverfire.com>
References: <fc55ca6fb012c9e36e53d2ab80d47894c38e85a8.camel@coverfire.com>
 <AB117487-C2C3-47EF-A3C4-FDCED9304282@intel.com>
 <8c7d255047890290948cf51450b1f860e013b48c.camel@coverfire.com>
Message-ID: <d3f0614118192ba0df5ec0e845f61e092f187744.camel@coverfire.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sat, 2021-02-06 at 22:59 -0500, Dan Siemon wrote:
> On Sun, 2021-02-07 at 02:24 +0000, Brandeburg, Jesse wrote:
> > Hi Dan, I am asking around to see what we can do, will get back to
> > you in the coming week.
> 
> Thanks. I was looking at some old Intel presentations that sort of
> hinted that the PPPoE DDP profile might support double VLANs. I've
> been
> experimenting with that today without luck so far. The profile loads
> fine (via ethtool) but I don't see any change in the traffic
> distribution.
> 
> The GTP DDP package documentations says:
> 
> "To enable RSS for GTPv1-U with the IPv4 payload we need to map
> packet
> classifier type 22 to the DPDK flow type. Flow types are defined in
> rte_eth_ctrl.h; the first 21 are in use in DPDK 17.11 and so can map
> to
> flows 22 and up. After mapping to a flow type, we can start to port
> again and enable RSS for flow type 22:"
> 
> I haven't been able to find anything that hints at how to do
> something
> like that outside of DPDK.

I loaded the PPP DDP profile via the DPDK tools. Looking at the list of
protocols supported via 'ddp get info' it looks like they don't do
anything with VLANs:

List of used protocols:
  12: IPV4
  13: IPV6
  15: GRENAT
  17: TCP
  18: UDP
  19: SCTP
  20: ICMP
  22: L2TPv2CTRL
  23: ICMPV6
  26: L2TPv2
  27: L2TPv2PAY
  28: PPPoL2TPv2
  29: PPPoE
  33: PAY2
  34: PAY3
  35: PAY4
  44: IPV4FRAG
  48: IPV6FRAG
  52: OIPV4
  53: OIPV6

I found the presentation linked below which introduces DDP and talks
about ctag, ctag in the context of PPPoE.

https://www.slideshare.net/MichelleHolley1/enabling-new-protocol-processing-with-dpdk-using-dynamic-device-personalization

Given some of the complex parsing that the GTP and PPP DDP profiles do,
I suspect the hardware is capable of doing what I require.

For clarity, what I need is the ability to skip 0,1,2 VLAN headers
(802.1a or 802.1ad) and parse the IP/IPv6 flow to get the RSS hash and
spread the traffic across queues. Currently it only handles one VLAN.

Nested VLANs are very common in the service provider space.

