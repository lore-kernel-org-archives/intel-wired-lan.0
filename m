From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 30 Dec 2015 23:47:21 -0800
Subject: [Intel-wired-lan] [PATCH] patch for Intel igb driver to support
 broadcom phys
In-Reply-To: <1831EC2B04379B47B6D129255B9BF2212D34A8D1@SRV-EXMBX2.accton.com.tw>
References: <1831EC2B04379B47B6D129255B9BF2212D34A8D1@SRV-EXMBX2.accton.com.tw>
Message-ID: <1451548041.3348.129.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2015-12-31 at 05:46 +0000, David Yang wrote:
> 
> We are bare metal network switch developers who contribute codes
> for OCP ONIE (https://github.com/opencomputeproject/onie).
> 
> Up to now, many switches have Intel CPU module with Ethernet?
> controller (i354) which connects to external Broadcom PHY
> (bcm54616s).
> We revised linux igb driver for making the PHY work.
> 
> The patch is for linux-4.1.12.??Please help to review the?
> patch for upstream to the igb driver.

Well, first off, this was suggested by guys at Cumulus Networks back in
April of 2015. ?In short, we would support the idea of using the PHYLib
approach. ?I believe i210 and i211 currently uses the PHYLib approach,
so it probably would not take much to extend that approach to the other
devices.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20151230/8dfbdb98/attachment.asc>
