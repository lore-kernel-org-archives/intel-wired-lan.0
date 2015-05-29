From: Chris Friesen <chris.friesen@windriver.com>
Date: Fri, 29 May 2015 14:59:48 -0600
Subject: [Intel-wired-lan] vlan packet handling in ixgbevf driver when in
	promiscuous mode
Message-ID: <5568D344.9090903@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

I'm doing some work with ixgbevf in the 3.10 kernel, but the current linux 
kernel git version seems to have similar behaviour.

Basically I'm interested in doing packet sniffing in a VM guest using PCI 
passthrough of a VF of an 82599.

What I'm seeing is that if I register for a vlan in the guest (creating 
eth1.100, for example) and then run tcpdump on the underlying device (eth1, for 
example) then I see the packet with the vlan header in it.

If I remove that vlan, then I see the packet with no vlan header.

I think this is coming from ixgbevf_receive_skb() in 3.10 (or 
ixgbevf_process_skb_fields() in current upstream git) where it has code that 
looks like this:

	if (test_bit(vid & VLAN_VID_MASK, active_vlans))
		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vid);

While this makes sense for normal operation (where traffic from other vlans 
isn't coming in anyways) I don't think it makes sense when promiscuous mode is 
enabled.

In promiscuous mode I want to be able to see exactly what packets are coming on 
the (virtual) wire, so I should be able to see the vlan header even if I haven't 
actually registered for that vlan.

Basically I think that code above should add an "or device is in promiscuous 
mode" clause.

Thoughts?

Chris
