From: David Miller <davem@davemloft.net>
Date: Fri, 17 Jun 2016 20:26:41 -0700 (PDT)
Subject: [Intel-wired-lan] [net-next PATCH v3 00/17] Future-proof tunnel
	offload handlers
In-Reply-To: <20160616191851.20872.67154.stgit@localhost.localdomain>
References: <20160616191851.20872.67154.stgit@localhost.localdomain>
Message-ID: <20160617.202641.1821023739498595024.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <aduyck@mirantis.com>
Date: Thu, 16 Jun 2016 12:20:35 -0700

> s patch is meant to address two things.  First we are currently using
> the ndo_add/del_vxlan_port calls with VXLAN-GPE tunnels and we cannot
> really support that as it is likely to cause more harm than good since
> VXLAN-GPE can support tunnels without a MAC address on the inner header.
> 
> As such we need to add a new offload to advertise this, but in doing so it
> would mean introducing 3 new functions for the driver to request the ports,
> and then for the tunnel to push the changes to add and delete the ports to
> the device.  However instead of taking that approach I think it would be
> much better if we just made one common function for fetching the ports, and
> provided a generic means to push the tunnels to the device.  So in order to
> make this work this patch set does several things.
 ...

Series applied, thanks Alexander.

Tom, I've heard your arguments, but I think your fears are unfounded.
Look at what Alexander's patches are actually doing.

First, he's fixing a bug.  Hardware that supports VXLAN offloading
doesn't support VXLAN-GPE, yet we were sending such things to the
VXLAN offload paths.

Second, he's eliminating a metric ton of Kconfig garbage, as drivers
had to have all kinds of contrived dependencies to support UDP tunnel
offloads.

Third, he's consolidating several driver NDO methods into just two.

And finally, he added a big comment explaining that new tunnel types
should not be added to the tunnel type list, and those that exist
should only be used for RX.

Therefore, this isn't openning the door for new random offloads, quite
the contrary.  Instead, if it making clearer what the existing
facilitites support, and putting an explicit cap on them.

Thanks.
