From: Chris Friesen <chris.friesen@windriver.com>
Date: Tue, 1 Dec 2015 10:19:01 -0600
Subject: [Intel-wired-lan] PCI ACS quirk for X710/XL710?
In-Reply-To: <565DC5D4.70300@windriver.com>
References: <565DC5D4.70300@windriver.com>
Message-ID: <565DC875.1020902@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 12/01/2015 10:07 AM, Chris Friesen wrote:
> Hi all,
>
> The three of you in the "to" list were involved with adding commits d748804 and
> 100ebb2 to address the fact that these multi-port NICs will not do peer-to-peer
> between functions, but do not report this via ACS.
>
> We've got an X710 device (PCI device 0x1572, driver version 1.3.1-k, firmware
> 4.40) and we're seeing all the ports being assigned to the same IOMMU group.
>
> I'm guessing that this is due to a lack of ACS, and that it would be valid to
> add the X710/XL710 PCI IDs to the pci_dev_acs_enabled table.  Could someone from
> Intel confirm this?

Looking at the datasheet (I suppose I should have done that first, sorry) it 
looks like this device supports ACS.  However, we're still seeing all the ports 
being placed into the same IOMMU group.

Is there a way to prevent/disable this behaviour?  We want to be able to assign 
each port to a separate VM, and thus for our purposes they need to be in 
separate IOMMU groups.

Chris
