From: Peterson, Scott D <scott.d.peterson@intel.com>
Date: Tue, 15 Nov 2016 22:27:21 +0000
Subject: [Intel-wired-lan] [net-next PATCH] ixgbe/ixgbevf: Enables TSO
 for MPLS encapsulated packets
In-Reply-To: <1479236637.26945.70.camel@intel.com>
References: <1479236637.26945.70.camel@intel.com>
Message-ID: <1479248840.26945.108.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2016-11-15 at 19:03 +0000, Peterson, Scott D wrote:
> This patch advertises TSO & GSO features in netdev->mpls_features.?
> In ixgbe(vf)_tso() where we set up segmentation offload, the IP?
> header will be the inner network header when eth_p_mpls() indicates
> the Ethernet protocol is MPLS (UC or MC).
> 
> We're submitting this upstream first, because it depends on related
> upstream changes not yet present in the OOT drivers.
> 
> Suggested-by: Alexander Duyck <alexander.h.duyck@intel.com>
> Signed-off-by: Scott Peterson <scott.d.peterson@intel.com>
> ---

The missing testing-hints:

I did basic testing of this by setting up a simple MPLS tunnel (one label)
between two nodes. I sent a megabyte of random data with ncat from the node
with this patch, and verified the rx pattern matched the tx pattern. There is
no TSO stat in ixgbe AFAIK. To confirm TSO occurred in the test, I ran it once
with a pr_err() added to the clause below that detects MPLS. I repeated the
verification test after removing the debug logging. ?This was done for each
driver. I would not be surprised to discover there is a better way to verify
TSO occurs on ixgbe.

A more complete test would verify that all the GSO features supported by
ixgbe/ixgbevf (see IXGBE_GSO_PARTIAL_FEATURES) work correctly when nested
inside MPLS. This needs to be done at least once on both drivers.

Clues for setting up an MPLS tunnel follow. ?This may be obvious, but note the
rp_filter step was required.

On both nodes:

modprobe mpls-router
modprobe mpls-iptunnel
modprobe mpls-gso
echo 1 > /proc/sys/net/mpls/conf/<your ixgbe>/input
echo 1 > /proc/sys/net/mpls/conf/lo/input
echo 1048575 > /proc/sys/net/mpls/platform_labels
#Relax reverse path filtering
echo 2 > /proc/sys/net/ipv4/conf/all/rp_filter

On both nodes add a /32 address outside the range of all local subnets to lo
for use as the MPLS endpoint addresses.

Add a route over MPLS with tag 101 from each node, like:

ip route add <other mpls ip>/32 encap mpls 101 via inet <other ixgbe ip>

Add an MPLS decapsulation (deliver tag 101 to lo) route on both nodes:

ip -f mpls route add 101 dev lo

Now from either end ping <other mpls ip> will work, and wireshark on ixgbe will
show MPLS encapsulated ICMP messages exchanged.

When you unload/load ixgbe/ixgbevf, these need to be repeated:

echo 1 > /proc/sys/net/mpls/conf/<your ixgbe>/input
ip route add <other mpls
ip>/32 encap mpls 101 via inet <other ixgbe ip>

When you transfer the file with ncat, use the <other mpls ip>, of course. ?It will work if you use <other ixgbe>, but that won't be MPLS encapsulated.

--- sdp

