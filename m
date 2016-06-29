From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 29 Jun 2016 13:32:42 -0700
Subject: [Intel-wired-lan] Question on i40e PCIe relaxed ordering (RO)
In-Reply-To: <1467231519.3404.11.camel@gmail.com>
References: <57742A27.5040207@oracle.com> <1467231519.3404.11.camel@gmail.com>
Message-ID: <1467232362.3733.23.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2016-06-29 at 13:18 -0700, Greg wrote:
> On Wed, 2016-06-29 at 13:05 -0700, tndave wrote:
> > Hi,
> >?
> > Running iperf tcp test on 2 sparc systems with i40e connected back to
> > back, I see huge number of 'port.rx_dropped' (on iperf server). Based
> on
> > past experience with ixgbe, this could very well because of PCIe RO
> > (relaxed ordering) not enabled.
> >?
> > I am trying to confirm RO is enabled. i40e datasheet mentioned RO
> > settings in 3 different sections:
> >?
> > 1. section 10.2.2.2.38 PCIe Global Config 2 - GLPCI_CNF2 register
> > contains global status fields of PCIe configuration. The bit 0 of the
> > register is "RO_DIS". If this bit is set to 1 RO is disabled.
> >?
> > RO_DIS in my setup is 0 imply RO is not disabled.
> >?
> > 2. section 12.3.5.5 Device Control Register (0xA8; RW) has bit 4
> > that enable/disable RO. This is pcie cap register.
> >?
> > In my i40e pcie config space value at offset 0xA8 is "2110". i.e 4th
> bit
> > set to 1 imply RO is enabled.
> >?
> > 3. section 3.1.2.7.2 mentions some relaxed ordering rules
> > e.g. "The GLLAN_RCTL.RXDESCRDROEN bit (loaded from NVM) enables relaxed
> > ordering for Rx descriptor reads"
> >?
> > However, GLLAN_RCTL register definition has not bit like RXDESCRDROEN.
> > Same goes for GLLAN_TCTL.TXDESCRDROEN.
> >?
> > Am I missing anything? please advise.
> 
> I would try posting this question to the e1000 developer list over at
> Source Forge.? The Intel customer support folks used to monitor that
> list closely when I was there, hopefully they still are.

We are supposed to be monitoring both lists, but just in case I have added
e1000-devel list...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160629/401d5a31/attachment.asc>
