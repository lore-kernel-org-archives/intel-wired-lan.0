From: tndave <tushar.n.dave@oracle.com>
Date: Wed, 29 Jun 2016 13:05:59 -0700
Subject: [Intel-wired-lan] Question on i40e PCIe relaxed ordering (RO)
Message-ID: <57742A27.5040207@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

Running iperf tcp test on 2 sparc systems with i40e connected back to
back, I see huge number of 'port.rx_dropped' (on iperf server). Based on
past experience with ixgbe, this could very well because of PCIe RO
(relaxed ordering) not enabled.

I am trying to confirm RO is enabled. i40e datasheet mentioned RO
settings in 3 different sections:

1. section 10.2.2.2.38 PCIe Global Config 2 - GLPCI_CNF2 register
contains global status fields of PCIe configuration. The bit 0 of the
register is "RO_DIS". If this bit is set to 1 RO is disabled.

RO_DIS in my setup is 0 imply RO is not disabled.

2. section 12.3.5.5 Device Control Register (0xA8; RW) has bit 4
that enable/disable RO. This is pcie cap register.

In my i40e pcie config space value at offset 0xA8 is "2110". i.e 4th bit
set to 1 imply RO is enabled.

3. section 3.1.2.7.2 mentions some relaxed ordering rules
e.g. "The GLLAN_RCTL.RXDESCRDROEN bit (loaded from NVM) enables relaxed
ordering for Rx descriptor reads"

However, GLLAN_RCTL register definition has not bit like RXDESCRDROEN.
Same goes for GLLAN_TCTL.TXDESCRDROEN.

Am I missing anything? please advise.

Thanks.

-Tushar

(Ref:http://www.intel.com/content/dam/www/public/us/en/documents/datasheets/xl710-10-40-controller-datasheet.pdf)



