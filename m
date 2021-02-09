From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Tue, 9 Feb 2021 12:02:23 -0800
Subject: [Intel-wired-lan] 710/i40e, RSS and 802.1ad (double vlan)
In-Reply-To: <d3f0614118192ba0df5ec0e845f61e092f187744.camel@coverfire.com>
References: <fc55ca6fb012c9e36e53d2ab80d47894c38e85a8.camel@coverfire.com>
 <AB117487-C2C3-47EF-A3C4-FDCED9304282@intel.com>
 <8c7d255047890290948cf51450b1f860e013b48c.camel@coverfire.com>
 <d3f0614118192ba0df5ec0e845f61e092f187744.camel@coverfire.com>
Message-ID: <20210209120223.000041ca@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dan Siemon wrote:

> On Sat, 2021-02-06 at 22:59 -0500, Dan Siemon wrote:
> > On Sun, 2021-02-07 at 02:24 +0000, Brandeburg, Jesse wrote:
> > > Hi Dan, I am asking around to see what we can do, will get back to
> > > you in the coming week.
> > 
> > Thanks. I was looking at some old Intel presentations that sort of
> > hinted that the PPPoE DDP profile might support double VLANs. I've
> > been
> > experimenting with that today without luck so far. The profile loads
> > fine (via ethtool) but I don't see any change in the traffic
> > distribution.

Hi Dan, I've got some good and bad news, and I have a request. Thanks
for your work troubleshooting this and reporting the issue.

...

> Given some of the complex parsing that the GTP and PPP DDP profiles do,
> I suspect the hardware is capable of doing what I require.
> 
> For clarity, what I need is the ability to skip 0,1,2 VLAN headers
> (802.1a or 802.1ad) and parse the IP/IPv6 flow to get the RSS hash and
> spread the traffic across queues. Currently it only handles one VLAN.
> 
> Nested VLANs are very common in the service provider space.

The hardware *can* support what you're trying to do, our organization
is aware of the issue, but I am going to file a separate internal
ticket to track your issue. The good news is the work is in progress,
the bad news is that we don't have an immediate fix for you. I suspect
the work on flushing out the features and interactions won't be complete
until Q2 or Q3 of this year. The complexity (and delay) comes from
making sure all the options of stacking vlans, working with SR-IOV, etc
still work with the changes. 

Please provide us with which driver/kernel/firmware you're running,
uname -a
ethtool -i ethx
lspci -vvv -s < your pci bus:dev.fn>

This will help me provide details to our engineering. I'd like us to be
able to provide you a short term workaround in code, but I'm
investigating if that is feasible.

Jesse
