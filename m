From: Tantilov, Emil S <emil.s.tantilov@intel.com>
Date: Tue, 18 Jul 2017 20:33:08 +0000
Subject: [Intel-wired-lan] Device isolation for X550 functions
In-Reply-To: <CAL1RGDW0ThAtTR-o_RUCmrKBAEM_a2wDLG7=2HRV5McRNa0DyQ@mail.gmail.com>
References: <CAL1RGDW0ThAtTR-o_RUCmrKBAEM_a2wDLG7=2HRV5McRNa0DyQ@mail.gmail.com>
Message-ID: <87618083B2453E4A8714035B62D67992B3EAAEA7@FMSMSX105.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf
>Of Roland Dreier
>Sent: Monday, July 17, 2017 1:48 PM
To: intel-wired-lan@lists.osuosl.org
>Subject: [Intel-wired-lan] Device isolation for X550 functions
>
>Hi ixgbe maintainers -
>
>We've been trying to do passthrough of X550 VFs to a KVM virtual
>machine for our application, and we noticed that the kernel does not
>put the different functions in different iommu groups the same way it
>does for X520.  This is because the kernel change that enabled
>appropriate ACS bits for X520 does not include the X550 device ID
>(1563h in our case):

According to the X540/550 datasheet ACS is supported starting with X540
and it can be enabled in the NVM.

Is it not possible to determine the state from the PCIe config space,
rather than adding device IDs?

I did a quick check on my system with 0x1563 device and I can see the
ACS capabilities being reported:

	Capabilities: [1b0 v1] Access Control Services
		ACSCap:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-
		ACSCtl:	SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- EgressCtrl- DirectTrans-

That being said I am not an expert on this and I will try to get some
clarification from our HW folks.

Thanks,
Emil
