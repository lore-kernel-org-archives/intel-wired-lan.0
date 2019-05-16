From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 16 May 2019 15:36:14 -0700
Subject: [Intel-wired-lan] ixgbe device for Intel C3508
In-Reply-To: <CAMcMvsgiebYeAc7csDog=j4cj9h2_QdLm7dO=7hU5BOceN6anw@mail.gmail.com>
References: <CAMcMvsgiebYeAc7csDog=j4cj9h2_QdLm7dO=7hU5BOceN6anw@mail.gmail.com>
Message-ID: <19c1d6910766549625766d4209ded28c26cebfe8.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2019-05-16 at 12:53 -0700, Paul Stewart wrote:
> I was pleased to fine that the ixgbe driver had good support for the
> 10GBit interfaces on the Atom C3708 device I was using.  However, the
> same is not true of the 2.5GBit interfaces on the Atom C3508.  The
> PCI
> IDs on these interfaces are very similar -- 8086:15cf on the C3508 vs
> 8086:15ce on the C3708.  Modifying the ixgbe driver to simply treat
> 8086:15cf almost works -- the 4 Ethernet interfaces are discovered
> and
> *something* happens when I plug in a Gigiabit ethernet cable into the
> SFP port:
> 
> [  269.233242] ixgbe 0000:0c:00.0 eth1: NIC Link is Up 1 Gbps, Flow
> Control: RX/
> TX
> [  269.240733] IPv6: ADDRCONF(NETDEV_CHANGE): eth1: link becomes
> ready
> [  269.337230] ixgbe 0000:0c:00.0 eth1: NIC Link is Down
> [  289.682588] ixgbe 0000:0c:00.1 eth2: detected SFP+: 6
> [  392.859888] ixgbe 0000:0c:00.0: removed PHC on eth1
> [  393.497099] ixgbe 0000:0c:00.1: removed PHC on eth2
> [  394./MA257214] ixgbe 0000:0d:00.0: removed PHC on eth3
> [  394.867122] ixgbe 0000:0d:00.1 eth4: NIC Link is Up 1 Gbps, Flow
> Control: RX/TX
> [  394.889384] ixgbe 0000:0d:00.1: removed PHC on eth4
> 
> Clearly not all is well, as could be expected -- I'm sure there's a
> real reason why these are separate PCI IDs.   Is there someone out
> there that can point me at docs I can use to support the device
> myself, or does anyone know if support is coming?  Should this device
> be considered an X550 or is this a different device fundamentally
> (should I not use the Intel X550 docs as a reference, if I were to
> hunt down some documentation about the difference between these
> parts?)

Adding the intel-wired-lan mailing, which is the proper mailing list
for issues like this.

Let me look into this and get back to you.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190516/8fccabb2/attachment.asc>
