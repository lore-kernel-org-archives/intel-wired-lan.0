From: Koehrer Mathias (ETAS/ESW5) <mathias.koehrer@etas.com>
Date: Tue, 18 Oct 2016 08:43:56 +0000
Subject: [Intel-wired-lan] Kernel 4.6.7-rt13: Intel Ethernet driver igb
 causes huge latencies in cyclictest
In-Reply-To: <20161017183209.GA18465@jcartwri.amer.corp.natinst.com>
References: <AAEA33E297BCAC4B9BB20A7C2DF0AB8D8045E418@FMSMSX113.amr.corp.intel.com>
 <29250f87b1d84aacb8aa312935582291@FE-MBX1012.de.bosch.com>
 <20161010193958.GE22235@jcartwri.amer.corp.natinst.com>
 <e9661abf93194ad3849e3864a8361993@FE-MBX1012.de.bosch.com>
 <b77ea8ab312149d2b20a717d3ab0a8dc@FE-MBX1012.de.bosch.com>
 <20161013161839.GV10625@jcartwri.amer.corp.natinst.com>
 <f395ea6cd1274fac83d2744121da7441@FE-MBX1012.de.bosch.com>
 <20161014195536.GB27124@jcartwri.amer.corp.natinst.com>
 <82dcd5bb210f4f82af1e88313c3ec742@FE-MBX1012.de.bosch.com>
 <CAKgT0Uf-F9V+AeP0+92Gf=40Tye-687_GFbhp4Sex=Hat+Ha+w@mail.gmail.com>
 <20161017183209.GA18465@jcartwri.amer.corp.natinst.com>
Message-ID: <2c1c6a2b71ce476aa8495f22bb32e1e5@FE-MBX1012.de.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi all,

> > >>
> > >> Can you continue your bisection using 'git bisect'?  You've already
> > >> narrowed it down between 4.0 and 4.1, so you're well on your way.
> > >>
> > >
> > > OK - done.
> > > And finally I was successful!
> > > The following git commit is the one that is causing the trouble!
> > > (The full commit is in the attachment).
> > > +++++++++++++++++++++ BEGIN +++++++++++++++++++++++++++
> > > commit 387d37577fdd05e9472c20885464c2a53b3c945f
> > > Author: Matthew Garrett <mjg59@coreos.com>
> > > Date:   Tue Apr 7 11:07:00 2015 -0700
> > >
> > >     PCI: Don't clear ASPM bits when the FADT declares it's
> > > unsupported
> > >
> > >     Communications with a hardware vendor confirm that the expected
> behaviour
> > >     on systems that set the FADT ASPM disable bit but which still grant full
> > >     PCIe control is for the OS to leave any BIOS configuration intact and
> > >     refuse to touch the ASPM bits.  This mimics the behaviour of Windows.
> > >
> > >     Signed-off-by: Matthew Garrett <mjg59@coreos.com>
> > >     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > > +++++++++++++++++++++ HEADER +++++++++++++++++++++++++++
> > >
> > > The only files that are modified by this commit are
> > > drivers/acpi/pci_root.c drivers/pci/pcie/aspm.c
> > > include/linux/pci-aspm.h
> > >
> > > This is all generic PCIe stuff - however I do not really understand
> > > what the changes of the commit are...
> > >
> > > In my setup I am using a dual port igb Ethernet adapter.
> > > This has an onboard PCIe switch and it might be that the
> > > configuration of this PCIe switch on the Intel board is causing the trouble.
> > >
> > > Please see also the output of "lspci -v" in the attachment.
> > > The relevant PCI address of the NIC is 04:00.0 / 04:00.1
> > >
> > Hi Mathias,
> >
> > If you could set the output of lspci -vvv it might be more useful as
> > most of the configuration data isn't present in the lspci dump you had
> > attached.  Specifically if you could do this for the working case and
> > the non-working case we could verify if this issue is actually due to
> > the ASPM configuration on the device.
> >
> > Also one thing you might try is booting your kernel with the kernel
> > parameter "pcie_aspm=off".  It sounds like the extra latency is likely
> > due to your platform enabling ASPM on the device and this in turn will
> > add latency if the PCIe link is disabled when you attempt to perform a
> > read as it takes some time to bring the PCIe link up when in L1 state.
> 
> So if we assume it's this commit causing the regression, then it's safe to assume that
> this system's BIOS is claiming to not support ASPM in the FADT, but the BIOS is
> leaving ASPM configured in some way on the relevant devices.
> 
> Also, unfortunately, taking a look at the code which handles "pcie_aspm=off", it
> won't be sufficient to disable ASPM on these this system, as disabling these states is
> skipped when the FADT doesn't advertise ASPM support.
> 
> What would be needed is an option like "force", but which force _disables_ ASPM.
> "force-disable", maybe.
> 

OK, I have now built a "good" kernel 
(using commit 37a9c502c0af013aaae094556830100c2bb133ac) and
a "bad" kernel
(using commit 387d37577fdd05e9472c20885464c2a53b3c945f).

Please find attached the outputs of "lspci -vvv" for both cases.
As assumed, in the "bad" case, the PCIe switch on the NIC board and the
two Ethernet controllers show "ASPM L1 Enabled" in "LnkCtl".
In the "good" case this is "ASPM disabled".

I tried also the kernel option "pcie_aspm=off" in the "bad" case.
However this had no impact, the issue still occurred!


Switching to kernel 4.8 I set the configuration for 
"Default ASPM policy" to CONFIG_PCIEASPM_PERFORMANCE
however this did not show any effect. 
This in contrast to the help text provided in the kernel configuration:
"Disable PCI Express ASPM L0s and L1, even if the BIOS enabled them."

For me the first step should be to make the CONFIG_PCIEASPM_PERFORMANCE
work as expected: It this is set, the ASPM should be forced to be disabled.
This is currently not the case.

During the boot phase I see in dmesg: 
"ACPI FADT declares the system doesn't support PCIe ASPM, so disable it"
This leads to a call of pcie_no_aspm() and this sets the aspm_policy to POLICY_DEFAULT
instead to the value that has been selected in the kernel configuration.

The following patch fixes the issue for me on kernel 4.8.
The config value CONFIG_PCIEASPM_PERFORMANCE is considered correctly.

+++++++++++++++++++++++ BEGIN +++++++++++++++++++
Consider the CONFIG_PCIEASPM_* values within pcie_no_aspm().

Signed-off-by: Mathias Koehrer <mathias.koehrer@etas.com>

---
 drivers/pci/pcie/aspm.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Index: linux-4.8/drivers/pci/pcie/aspm.c
===================================================================
--- linux-4.8.orig/drivers/pci/pcie/aspm.c
+++ linux-4.8/drivers/pci/pcie/aspm.c
@@ -79,10 +79,13 @@ static LIST_HEAD(link_list);
 
 #ifdef CONFIG_PCIEASPM_PERFORMANCE
 static int aspm_policy = POLICY_PERFORMANCE;
+static int aspm_default_config_policy = POLICY_PERFORMANCE;
 #elif defined CONFIG_PCIEASPM_POWERSAVE
 static int aspm_policy = POLICY_POWERSAVE;
+static int aspm_default_config_policy = POLICY_POWERSAFE;
 #else
 static int aspm_policy;
+static int aspm_default_config_policy;
 #endif
 
 static const char *policy_str[] = {
@@ -946,7 +949,7 @@ void pcie_no_aspm(void)
 	 * (b) prevent userspace from changing policy
 	 */
 	if (!aspm_force) {
-		aspm_policy = POLICY_DEFAULT;
+		aspm_policy = aspm_default_config_policy;
 		aspm_disabled = 1;
 	}
 }
+++++++++++++++++++++++ END +++++++++++++++++++

Apart from that a kernel parameter - as proposed by Julia - like
"pcie_aspm=force-disable" would be helpful as well.

Any feedback is welcome!

Regards

Mathias

-------------- next part --------------
A non-text attachment was scrubbed...
Name: lspci.bad.gz
Type: application/x-gzip
Size: 5127 bytes
Desc: lspci.bad.gz
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20161018/2deeb2f8/attachment-0002.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: lspci.good.gz
Type: application/x-gzip
Size: 5123 bytes
Desc: lspci.good.gz
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20161018/2deeb2f8/attachment-0003.bin>
