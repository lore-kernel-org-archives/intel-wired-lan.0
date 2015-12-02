From: Alex Williamson <alex.williamson@redhat.com>
Date: Wed, 02 Dec 2015 08:21:34 -0700
Subject: [Intel-wired-lan] PCI ACS quirk for X710/XL710?
In-Reply-To: <565DF592.7090606@windriver.com>
References: <565DC5D4.70300@windriver.com> <565DC875.1020902@windriver.com>
 <1448992637.15753.8.camel@redhat.com> <565DF592.7090606@windriver.com>
Message-ID: <1449069694.15753.31.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2015-12-01 at 13:31 -0600, Chris Friesen wrote:
> On 12/01/2015 11:57 AM, Alex Williamson wrote:
> > On Tue, 2015-12-01 at 10:19 -0600, Chris Friesen wrote:
> >> On 12/01/2015 10:07 AM, Chris Friesen wrote:
> >>> Hi all,
> >>>
> >>> The three of you in the "to" list were involved with adding commits d748804 and
> >>> 100ebb2 to address the fact that these multi-port NICs will not do peer-to-peer
> >>> between functions, but do not report this via ACS.
> >>>
> >>> We've got an X710 device (PCI device 0x1572, driver version 1.3.1-k, firmware
> >>> 4.40) and we're seeing all the ports being assigned to the same IOMMU group.
> >>>
> >>> I'm guessing that this is due to a lack of ACS, and that it would be valid to
> >>> add the X710/XL710 PCI IDs to the pci_dev_acs_enabled table.  Could someone from
> >>> Intel confirm this?
> >>
> >> Looking at the datasheet (I suppose I should have done that first, sorry) it
> >> looks like this device supports ACS.  However, we're still seeing all the ports
> >> being placed into the same IOMMU group.
> >>
> >> Is there a way to prevent/disable this behaviour?  We want to be able to assign
> >> each port to a separate VM, and thus for our purposes they need to be in
> >> separate IOMMU groups.
> > 
> > Are you sure the grouping isn't caused by the root port and not the X710
> > endpoints?  Please provide:
> > 
> > $ find /sys/kernel/iommu_groups/ -type l
> > 
> > $ sudo lspci -vvv
> > 
> 
> 
> Now that you mention it, no I'm not sure it's not caused by the root port. 
> Can you describe what to look for?
> 
> I've got the data that you asked for.  The raw results are quite large,
> so I trimmed the lspci output somewhat.  IOMMU groups 11 and 13 correspond
> to the 0x1572 devices.
> 
> I should mention that this is a 3.10-based kernel.
> 
> Chris
> 
> 
> [root at compute-0 ~(keystone_admin)]# find /sys/kernel/iommu_groups/ -type l
...
> /sys/kernel/iommu_groups/11/devices/0000:01:00.0
> /sys/kernel/iommu_groups/11/devices/0000:01:00.1
...
> /sys/kernel/iommu_groups/13/devices/0000:03:00.0
> /sys/kernel/iommu_groups/13/devices/0000:03:00.1
> /sys/kernel/iommu_groups/13/devices/0000:03:00.2
> /sys/kernel/iommu_groups/13/devices/0000:03:00.3
...
> 
> partial lspci -t output:
> 
>  |           +-1f.0
>  |           \-1f.2
>  \-[0000:00]-+-00.0
>              +-01.0-[02]----00.0
>              +-02.0-[03]--+-00.0
>              |            +-00.1
>              |            +-00.2
>              |            \-00.3
>              +-03.0-[01]--+-00.0
>              |            \-00.1
>              +-05.0
>              +-05.1
>              +-05.2
> 
> 
> 
...
> 00:02.0 PCI bridge: Intel Corporation Haswell-E PCI Express Root Port 2 (rev 02) (prog-if 00 [Normal decode])
>         Capabilities: [110 v1] Access Control Services
>                 ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
>                 ACSCtl: SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-

> 00:03.0 PCI bridge: Intel Corporation Haswell-E PCI Express Root Port 3 (rev 02) (prog-if 00 [Normal decode])
>         Capabilities: [110 v1] Access Control Services
>                 ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
>                 ACSCtl: SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-
>         Capabilities: [148 v1] Advanced Error Reporting

> 01:00.0 Ethernet controller: Intel Corporation Device 1572 (rev 01)
> 	Capabilities: [1b0 v1] Access Control Services
> 		ACSCap:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
> 		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-

> 01:00.1 Ethernet controller: Intel Corporation Device 1572 (rev 01)
> 	Capabilities: [1b0 v1] Access Control Services
> 		ACSCap:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
> 		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-

> 03:00.0 Ethernet controller: Intel Corporation Device 1572 (rev 01)
> 	Capabilities: [1b0 v1] Access Control Services
> 		ACSCap:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
> 		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-

> 03:00.1 Ethernet controller: Intel Corporation Device 1572 (rev 01)
> 	Capabilities: [1b0 v1] Access Control Services
> 		ACSCap:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
> 		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-

> 03:00.2 Ethernet controller: Intel Corporation Device 1572 (rev 01)
> 	Capabilities: [1b0 v1] Access Control Services
> 		ACSCap:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
> 		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-

> 03:00.3 Ethernet controller: Intel Corporation Device 1572 (rev 01)
> 	Capabilities: [1b0 v1] Access Control Services
> 		ACSCap:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
> 		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-


The root ports support ACS and so does the endpoint.  I believe this
empty ACS capability on the endpoint should be all we need per the spec
to indicate no internal peer-to-peer is possible.  What 3.10-based
kernel are you using?  RHEL?  Can you see what happens with an upstream
kernel?  Thanks,

Alex

