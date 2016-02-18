From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 18 Feb 2016 01:15:01 -0800
Subject: [Intel-wired-lan] [next] igb: allow setting MAC address on i211
 using a device tree blob V4
In-Reply-To: <97579B9E-E7C6-4DBE-B1A2-027C2EA7F754@gmail.com>
References: <56C506FD.5040408@gmail.com>
 <20160217.212910.1758016077144502307.davem@davemloft.net>
 <97579B9E-E7C6-4DBE-B1A2-027C2EA7F754@gmail.com>
Message-ID: <1455786901.3128.13.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2016-02-18 at 08:53 +0100, John Holland wrote:
> 
> > On Feb 18, 2016, at 03:29, David Miller <davem@davemloft.net>
> wrote:
> >?
> > From: John Holland <jotihojr@gmail.com>
> > Date: Thu, 18 Feb 2016 00:49:17 +0100
> >?
> >> The Intel i211 LOM pcie ethernet controllers' iNVM operates as an
> OTP
> >> and has no externel EEPROM interface [1]. The following allows the
> >> driver to pickup the MAC address from a device tree blob when
> >> CONFIG_OF
> >> has been enabled.
> >?
> > Please use the generic eth_platform_get_mac_address(), or
> > alternatively structure your code like the ixgbe and other cases so
> > that SPARC and other OF platforms get this support as well.
> 
> Don't know what you mean. The PCI path in
> eth_platform_get_mac_address() didn't return a devicetree node and I
> can find no instance of of_<function> use in ixgbe.

See commit?e1be080f292eba2ef96af999057d1603cd50b473 in my dev-queue
branch. ?Sowmini Varadhan provided a patch to
use?eth_platform_get_mac_address() instead of the "CONFIG_SPARC"
solution.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160218/9f38b301/attachment.asc>
