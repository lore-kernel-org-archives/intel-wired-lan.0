From: Stefan Dietrich <roots@gmx.de>
Date: Fri, 10 Dec 2021 15:51:53 +0100
Subject: [Intel-wired-lan] [PATCH] igc: Avoid possible deadlock during
 suspend/resume
In-Reply-To: <5c5b606a-4694-be1b-0d4b-80aad1999bd9@leemhuis.info>
References: <87r1awtdx3.fsf@intel.com>
 <20211201185731.236130-1-vinicius.gomes@intel.com>
 <5a4b31d43d9bf32e518188f3ef84c433df3a18b1.camel@gmx.de>
 <87o85yljpu.fsf@intel.com>
 <063995d8-acf3-9f33-5667-f284233c94b4@leemhuis.info>
 <8e59b7d6b5d4674d5843bb45dde89e9881d0c741.camel@gmx.de>
 <5c5b606a-4694-be1b-0d4b-80aad1999bd9@leemhuis.info>
Message-ID: <d4c9bb101aa79c5acaaa6dd7b42159fb0c91a341.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Agreed and thanks for the pointers; please see the log files and
.config attached as requested.


Cheers,
Stefan


On Fri, 2021-12-10 at 15:01 +0100, Thorsten Leemhuis wrote:
> On 10.12.21 14:45, Stefan Dietrich wrote:
> > thanks for keeping an eye on the issue. I've sent the files in
> > private
> > because I did not want to spam the mailing lists with them. Please
> > let
> > me know if this is the correct procedure.
>
> It's likely okay in this case, but FWIW: most of the time it's the
> wrong
> thing to do as outlined here:
>
> https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html#general-advice-for-further-interactions
>
> One reason for this: others that might want to look into the issue
> now
> or a in a year or two might be unable to if crucial data was only
> sent
> in private.
>
> Ciao, Thorsten
>
> > On Fri, 2021-12-10 at 10:40 +0100, Thorsten Leemhuis wrote:
> > > Hi, this is your Linux kernel regression tracker speaking.
> > >
> > > On 02.12.21 23:34, Vinicius Costa Gomes wrote:
> > > > Hi Stefan,
> > > >
> > > > Stefan Dietrich <roots@gmx.de> writes:
> > > >
> > > > > Hi Vinicius,
> > > > >
> > > > > thanks for the patch - unfortunately it did not solve the
> > > > > issue
> > > > > and I
> > > > > am still getting reboots/lockups.
> > > > >
> > > >
> > > > Thanks for the test. We learned something, not a lot, but
> > > > something: the
> > > > problem you are facing is PTM related and it's not the same bug
> > > > as
> > > > that
> > > > PM deadlock.
> > > >
> > > > I am still trying to understand what's going on.
> > > >
> > > > Are you able to send me the 'dmesg' output for the two kernel
> > > > configs
> > > > (CONFIG_PCIE_PTM enabled and disabled)? (no need to bring the
> > > > network
> > > > interface up or down). Your kernel .config would be useful as
> > > > well.
> > >
> > > Stefan, could you provide the data Vinicius asked for? Or did you
> > > do
> > > that in private already? Or was progress made somewhere else and
> > > I
> > > simply missed this?
> > >
> > > Ciao, Thorsten, your Linux kernel regression tracker.
> > >
> > > P.S.: As a Linux kernel regression tracker I'm getting a lot of
> > > reports
> > > on my table. I can only look briefly into most of them.
> > > Unfortunately
> > > therefore I sometimes will get things wrong or miss something
> > > important.
> > > I hope that's not the case here; if you think it is, don't
> > > hesitate
> > > to
> > > tell me about it in a public reply. That's in everyone's
> > > interest, as
> > > what I wrote above might be misleading to everyone reading this;
> > > any
> > > suggestion I gave they thus might sent someone reading this down
> > > the
> > > wrong rabbit hole, which none of us wants.
> > >
> > > BTW, I have no personal interest in this issue, which is tracked
> > > using
> > > regzbot, my Linux kernel regression tracking bot
> > > (https://linux-regtracking.leemhuis.info/regzbot/). I'm only
> > > posting
> > > this mail to get things rolling again and hence don't need to be
> > > CC
> > > on
> > > all further activities wrt to this regression.
> > >
> > > #regzbot poke
> > >
> > > > > On Wed, 2021-12-01 at 10:57 -0800, Vinicius Costa Gomes
> > > > > wrote:
> > > > > > Inspired by:
> > > > > > https://bugzilla.kernel.org/show_bug.cgi?id=215129
> > > > > >
> > > > > > Signed-off-by: Vinicius Costa Gomes <
> > > > > > vinicius.gomes at intel.com>
> > > > > > ---
> > > > > > Just to see if it's indeed the same problem as the bug
> > > > > > report
> > > > > > above.
> > > > > >
> > > > > >  drivers/net/ethernet/intel/igc/igc_main.c | 19
> > > > > > +++++++++++++
> > > > > > ------
> > > > > >  1 file changed, 13 insertions(+), 6 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/net/ethernet/intel/igc/igc_main.c
> > > > > > b/drivers/net/ethernet/intel/igc/igc_main.c
> > > > > > index 0e19b4d02e62..c58bf557a2a1 100644
> > > > > > --- a/drivers/net/ethernet/intel/igc/igc_main.c
> > > > > > +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> > > > > > @@ -6619,7 +6619,7 @@ static void
> > > > > > igc_deliver_wake_packet(struct
> > > > > > net_device *netdev)
> > > > > >  	netif_rx(skb);
> > > > > >  }
> > > > > >
> > > > > > -static int __maybe_unused igc_resume(struct device *dev)
> > > > > > +static int __maybe_unused __igc_resume(struct device *dev,
> > > > > > bool rpm)
> > > > > >  {
> > > > > >  	struct pci_dev *pdev = to_pci_dev(dev);
> > > > > >  	struct net_device *netdev = pci_get_drvdata(pdev);
> > > > > > @@ -6661,20 +6661,27 @@ static int __maybe_unused
> > > > > > igc_resume(struct
> > > > > > device *dev)
> > > > > >
> > > > > >  	wr32(IGC_WUS, ~0);
> > > > > >
> > > > > > -	rtnl_lock();
> > > > > > +	if (!rpm)
> > > > > > +		rtnl_lock();
> > > > > >  	if (!err && netif_running(netdev))
> > > > > >  		err = __igc_open(netdev, true);
> > > > > >
> > > > > >  	if (!err)
> > > > > >  		netif_device_attach(netdev);
> > > > > > -	rtnl_unlock();
> > > > > > +	if (!rpm)
> > > > > > +		rtnl_unlock();
> > > > > >
> > > > > >  	return err;
> > > > > >  }
> > > > > >
> > > > > >  static int __maybe_unused igc_runtime_resume(struct device
> > > > > > *dev)
> > > > > >  {
> > > > > > -	return igc_resume(dev);
> > > > > > +	return __igc_resume(dev, true);
> > > > > > +}
> > > > > > +
> > > > > > +static int __maybe_unused igc_resume(struct device *dev)
> > > > > > +{
> > > > > > +	return __igc_resume(dev, false);
> > > > > >  }
> > > > > >
> > > > > >  static int __maybe_unused igc_suspend(struct device *dev)
> > > > > > @@ -6738,7 +6745,7 @@ static pci_ers_result_t
> > > > > > igc_io_error_detected(struct pci_dev *pdev,
> > > > > >   *  @pdev: Pointer to PCI device
> > > > > >   *
> > > > > >   *  Restart the card from scratch, as if from a cold-boot.
> > > > > > Implementation
> > > > > > - *  resembles the first-half of the igc_resume routine.
> > > > > > + *  resembles the first-half of the __igc_resume routine.
> > > > > >   **/
> > > > > >  static pci_ers_result_t igc_io_slot_reset(struct pci_dev
> > > > > > *pdev)
> > > > > >  {
> > > > > > @@ -6777,7 +6784,7 @@ static pci_ers_result_t
> > > > > > igc_io_slot_reset(struct pci_dev *pdev)
> > > > > >   *
> > > > > >   *  This callback is called when the error recovery driver
> > > > > > tells us
> > > > > > that
> > > > > >   *  its OK to resume normal operation. Implementation
> > > > > > resembles the
> > > > > > - *  second-half of the igc_resume routine.
> > > > > > + *  second-half of the __igc_resume routine.
> > > > > >   */
> > > > > >  static void igc_io_resume(struct pci_dev *pdev)
> > > > > >  {
> > > >
> > > > Cheers,
> > > >
> >
> >
-------------- next part --------------
[    0.000000] Linux version 5.15.7 (root at computer) (gcc (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0, GNU ld (GNU Binutils for Ubuntu) 2.34) #1 SMP Fri Dec 10 13:41:46 CET 2021
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-5.15.7 root=UUID=f1d17af1-b114-4204-be05-fb71851a14ff ro noresume
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Hygon HygonGenuine
[    0.000000]   Centaur CentaurHauls
[    0.000000]   zhaoxin   Shanghai  
[    0.000000] x86/split lock detection: #AC: crashing the kernel on kernel split_locks and warning on user-space split_locks
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x020: 'AVX-512 opmask'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x040: 'AVX-512 Hi256'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x080: 'AVX-512 ZMM_Hi256'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: xstate_offset[5]:  832, xstate_sizes[5]:   64
[    0.000000] x86/fpu: xstate_offset[6]:  896, xstate_sizes[6]:  512
[    0.000000] x86/fpu: xstate_offset[7]: 1408, xstate_sizes[7]: 1024
[    0.000000] x86/fpu: xstate_offset[9]: 2432, xstate_sizes[9]:    8
[    0.000000] x86/fpu: Enabled xstate features 0x2e7, context size is 2440 bytes, using 'compacted' format.
[    0.000000] signal: max sigframe size: 3632
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009dbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009dc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000063e45fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000063e46000-0x0000000063e46fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000063e47000-0x0000000063e9bfff] usable
[    0.000000] BIOS-e820: [mem 0x0000000063e9c000-0x0000000063e9cfff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000063e9d000-0x000000007407dfff] usable
[    0.000000] BIOS-e820: [mem 0x000000007407e000-0x0000000077d7dfff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000077d7e000-0x0000000078140fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x0000000078141000-0x000000007871efff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000007871f000-0x0000000079ffefff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000079fff000-0x0000000079ffffff] usable
[    0.000000] BIOS-e820: [mem 0x000000007a000000-0x000000007dffffff] reserved
[    0.000000] BIOS-e820: [mem 0x000000007ee00000-0x000000007fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000c0000000-0x00000000cfffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed20000-0x00000000fed7ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000087fffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 3.4.0 present.
[    0.000000] DMI: ASUS System Product Name/ROG STRIX Z690-A GAMING WIFI D4, BIOS 0707 11/10/2021
[    0.000000] tsc: Detected 3200.000 MHz processor
[    0.000000] tsc: Detected 3187.200 MHz TSC
[    0.000258] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000260] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000263] last_pfn = 0x880000 max_arch_pfn = 0x400000000
[    0.000358] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.001269] total RAM covered: 63488M
[    0.001323] Found optimal setting for mtrr clean up
[    0.001323]  gran_size: 64K 	chunk_size: 64K 	num_reg: 5  	lose cover RAM: 0G
[    0.001578] e820: update [mem 0x80000000-0xffffffff] usable ==> reserved
[    0.001579] last_pfn = 0x7a000 max_arch_pfn = 0x400000000
[    0.004485] found SMP MP-table at [mem 0x000fcf30-0x000fcf3f]
[    0.004490] Using GB pages for direct mapping
[    0.004681] RAMDISK: [mem 0x26379000-0x2f1b3fff]
[    0.004682] ACPI: Early table checksum verification disabled
[    0.004683] ACPI: RSDP 0x00000000000F05B0 000024 (v02 ALASKA)
[    0.004686] ACPI: XSDT 0x000000007813F728 00010C (v01 ALASKA A M I    01072009 AMI  01000013)
[    0.004689] ACPI: FACP 0x000000007813D000 000114 (v06 ALASKA A M I    01072009 AMI  01000013)
[    0.004691] ACPI: DSDT 0x00000000780C8000 074735 (v02 ALASKA A M I    01072009 INTL 20200717)
[    0.004693] ACPI: FACS 0x000000007871E000 000040
[    0.004695] ACPI: MCFG 0x000000007813E000 00003C (v01 ALASKA A M I    01072009 MSFT 00000097)
[    0.004697] ACPI: FIDT 0x00000000780C7000 00009C (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.004698] ACPI: WSMT 0x00000000780AF000 000028 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.004700] ACPI: SSDT 0x00000000780C5000 00038C (v02 PmaxDv Pmax_Dev 00000001 INTL 20200717)
[    0.004702] ACPI: SSDT 0x00000000780BF000 005D01 (v02 CpuRef CpuSsdt  00003000 INTL 20200717)
[    0.004703] ACPI: SSDT 0x00000000780BC000 002A95 (v02 SaSsdt SaSsdt   00003000 INTL 20200717)
[    0.004705] ACPI: SSDT 0x00000000780B8000 003316 (v02 INTEL  IgfxSsdt 00003000 INTL 20200717)
[    0.004707] ACPI: HPET 0x00000000780B7000 000038 (v01 ALASKA A M I    01072009 AMI  01000013)
[    0.004708] ACPI: APIC 0x00000000780B6000 0001DC (v05 ALASKA A M I    01072009 AMI  01000013)
[    0.004710] ACPI: MCFG 0x00000000780B5000 00003C (v01 ALASKA A M I    01072009 AMI  01000013)
[    0.004712] ACPI: SSDT 0x00000000780B3000 001F1A (v02 ALASKA Ther_Rvp 00001000 INTL 20200717)
[    0.004713] ACPI: NHLT 0x00000000780B1000 00002D (v00 ALASKA A M I    01072009 AMI  01000013)
[    0.004715] ACPI: LPIT 0x00000000780B0000 0000CC (v01 ALASKA A M I    01072009 AMI  01000013)
[    0.004716] ACPI: SSDT 0x00000000780AC000 002357 (v02 ALASKA TbtTypeC 00000000 INTL 20200717)
[    0.004718] ACPI: SSDT 0x00000000780A9000 002A83 (v02 ALASKA PtidDevc 00001000 INTL 20200717)
[    0.004720] ACPI: DBGP 0x00000000780A8000 000034 (v01 ALASKA A M I    01072009 AMI  01000013)
[    0.004721] ACPI: DBG2 0x00000000780A7000 000054 (v00 ALASKA A M I    01072009 AMI  01000013)
[    0.004723] ACPI: SSDT 0x00000000780A6000 000C1F (v02 ALASKA UsbCTabl 00001000 INTL 20200717)
[    0.004725] ACPI: DMAR 0x00000000780A5000 000050 (v02 INTEL  EDK2     00000002      01000013)
[    0.004726] ACPI: SSDT 0x00000000780A3000 001E67 (v02 INTEL  xh_adls3 00000000 INTL 20200717)
[    0.004728] ACPI: SSDT 0x000000007809F000 003AEA (v02 SocGpe SocGpe   00003000 INTL 20200717)
[    0.004730] ACPI: SSDT 0x000000007809C000 002B2A (v02 SocCmn SocCmn   00003000 INTL 20200717)
[    0.004731] ACPI: SSDT 0x000000007809B000 000144 (v02 Intel  ADebTabl 00001000 INTL 20200717)
[    0.004733] ACPI: UEFI 0x00000000782DE000 00063A (v01 INTEL  RstVmdE  00000000 INTL 00000000)
[    0.004734] ACPI: UEFI 0x00000000782DD000 00005C (v01 INTEL  RstVmdV  00000000 INTL 00000000)
[    0.004736] ACPI: WPBT 0x0000000077F6D000 000040 (v01 ALASKA A M I    00000001 ASUS 00000001)
[    0.004738] ACPI: PHAT 0x0000000077F6C000 0005ED (v00 ALASKA A M I    00000005 MSFT 0100000D)
[    0.004739] ACPI: FPDT 0x0000000077F6B000 000044 (v01 ALASKA A M I    01072009 AMI  01000013)
[    0.004741] ACPI: Reserving FACP table memory at [mem 0x7813d000-0x7813d113]
[    0.004742] ACPI: Reserving DSDT table memory at [mem 0x780c8000-0x7813c734]
[    0.004742] ACPI: Reserving FACS table memory at [mem 0x7871e000-0x7871e03f]
[    0.004743] ACPI: Reserving MCFG table memory at [mem 0x7813e000-0x7813e03b]
[    0.004744] ACPI: Reserving FIDT table memory at [mem 0x780c7000-0x780c709b]
[    0.004744] ACPI: Reserving WSMT table memory at [mem 0x780af000-0x780af027]
[    0.004745] ACPI: Reserving SSDT table memory at [mem 0x780c5000-0x780c538b]
[    0.004745] ACPI: Reserving SSDT table memory at [mem 0x780bf000-0x780c4d00]
[    0.004746] ACPI: Reserving SSDT table memory at [mem 0x780bc000-0x780bea94]
[    0.004746] ACPI: Reserving SSDT table memory at [mem 0x780b8000-0x780bb315]
[    0.004747] ACPI: Reserving HPET table memory at [mem 0x780b7000-0x780b7037]
[    0.004747] ACPI: Reserving APIC table memory at [mem 0x780b6000-0x780b61db]
[    0.004748] ACPI: Reserving MCFG table memory at [mem 0x780b5000-0x780b503b]
[    0.004749] ACPI: Reserving SSDT table memory at [mem 0x780b3000-0x780b4f19]
[    0.004749] ACPI: Reserving NHLT table memory at [mem 0x780b1000-0x780b102c]
[    0.004750] ACPI: Reserving LPIT table memory at [mem 0x780b0000-0x780b00cb]
[    0.004750] ACPI: Reserving SSDT table memory at [mem 0x780ac000-0x780ae356]
[    0.004751] ACPI: Reserving SSDT table memory at [mem 0x780a9000-0x780aba82]
[    0.004751] ACPI: Reserving DBGP table memory at [mem 0x780a8000-0x780a8033]
[    0.004752] ACPI: Reserving DBG2 table memory at [mem 0x780a7000-0x780a7053]
[    0.004753] ACPI: Reserving SSDT table memory at [mem 0x780a6000-0x780a6c1e]
[    0.004753] ACPI: Reserving DMAR table memory at [mem 0x780a5000-0x780a504f]
[    0.004754] ACPI: Reserving SSDT table memory at [mem 0x780a3000-0x780a4e66]
[    0.004754] ACPI: Reserving SSDT table memory at [mem 0x7809f000-0x780a2ae9]
[    0.004755] ACPI: Reserving SSDT table memory at [mem 0x7809c000-0x7809eb29]
[    0.004755] ACPI: Reserving SSDT table memory at [mem 0x7809b000-0x7809b143]
[    0.004756] ACPI: Reserving UEFI table memory at [mem 0x782de000-0x782de639]
[    0.004757] ACPI: Reserving UEFI table memory at [mem 0x782dd000-0x782dd05b]
[    0.004757] ACPI: Reserving WPBT table memory at [mem 0x77f6d000-0x77f6d03f]
[    0.004758] ACPI: Reserving PHAT table memory at [mem 0x77f6c000-0x77f6c5ec]
[    0.004758] ACPI: Reserving FPDT table memory at [mem 0x77f6b000-0x77f6b043]
[    0.004879] No NUMA configuration found
[    0.004879] Faking a node at [mem 0x0000000000000000-0x000000087fffffff]
[    0.004883] NODE_DATA(0) allocated [mem 0x87ffd6000-0x87fffffff]
[    0.005013] Zone ranges:
[    0.005013]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.005014]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.005015]   Normal   [mem 0x0000000100000000-0x000000087fffffff]
[    0.005015]   Device   empty
[    0.005016] Movable zone start for each node
[    0.005017] Early memory node ranges
[    0.005017]   node   0: [mem 0x0000000000001000-0x000000000009cfff]
[    0.005018]   node   0: [mem 0x0000000000100000-0x0000000063e45fff]
[    0.005019]   node   0: [mem 0x0000000063e47000-0x0000000063e9bfff]
[    0.005019]   node   0: [mem 0x0000000063e9d000-0x000000007407dfff]
[    0.005019]   node   0: [mem 0x0000000079fff000-0x0000000079ffffff]
[    0.005020]   node   0: [mem 0x0000000100000000-0x000000087fffffff]
[    0.005021] Initmem setup node 0 [mem 0x0000000000001000-0x000000087fffffff]
[    0.005023] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.005034] On node 0, zone DMA: 99 pages in unavailable ranges
[    0.006246] On node 0, zone DMA32: 1 pages in unavailable ranges
[    0.006443] On node 0, zone DMA32: 1 pages in unavailable ranges
[    0.006537] On node 0, zone DMA32: 24449 pages in unavailable ranges
[    0.030195] On node 0, zone Normal: 24576 pages in unavailable ranges
[    0.030460] ACPI: PM-Timer IO Port: 0x1808
[    0.030464] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.030465] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.030465] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.030466] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.030466] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.030466] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.030467] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.030467] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.030468] ACPI: LAPIC_NMI (acpi_id[0x09] high edge lint[0x1])
[    0.030468] ACPI: LAPIC_NMI (acpi_id[0x0a] high edge lint[0x1])
[    0.030468] ACPI: LAPIC_NMI (acpi_id[0x0b] high edge lint[0x1])
[    0.030469] ACPI: LAPIC_NMI (acpi_id[0x0c] high edge lint[0x1])
[    0.030469] ACPI: LAPIC_NMI (acpi_id[0x0d] high edge lint[0x1])
[    0.030470] ACPI: LAPIC_NMI (acpi_id[0x0e] high edge lint[0x1])
[    0.030470] ACPI: LAPIC_NMI (acpi_id[0x0f] high edge lint[0x1])
[    0.030471] ACPI: LAPIC_NMI (acpi_id[0x10] high edge lint[0x1])
[    0.030471] ACPI: LAPIC_NMI (acpi_id[0x11] high edge lint[0x1])
[    0.030471] ACPI: LAPIC_NMI (acpi_id[0x12] high edge lint[0x1])
[    0.030472] ACPI: LAPIC_NMI (acpi_id[0x13] high edge lint[0x1])
[    0.030472] ACPI: LAPIC_NMI (acpi_id[0x14] high edge lint[0x1])
[    0.030473] ACPI: LAPIC_NMI (acpi_id[0x15] high edge lint[0x1])
[    0.030473] ACPI: LAPIC_NMI (acpi_id[0x16] high edge lint[0x1])
[    0.030473] ACPI: LAPIC_NMI (acpi_id[0x17] high edge lint[0x1])
[    0.030474] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.030497] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
[    0.030498] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.030499] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.030501] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.030502] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.030503] TSC deadline timer available
[    0.030504] smpboot: Allowing 16 CPUs, 0 hotplug CPUs
[    0.030513] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.030514] PM: hibernation: Registered nosave memory: [mem 0x0009d000-0x0009dfff]
[    0.030515] PM: hibernation: Registered nosave memory: [mem 0x0009e000-0x0009ffff]
[    0.030515] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000dffff]
[    0.030516] PM: hibernation: Registered nosave memory: [mem 0x000e0000-0x000fffff]
[    0.030516] PM: hibernation: Registered nosave memory: [mem 0x63e46000-0x63e46fff]
[    0.030517] PM: hibernation: Registered nosave memory: [mem 0x63e9c000-0x63e9cfff]
[    0.030518] PM: hibernation: Registered nosave memory: [mem 0x7407e000-0x77d7dfff]
[    0.030519] PM: hibernation: Registered nosave memory: [mem 0x77d7e000-0x78140fff]
[    0.030519] PM: hibernation: Registered nosave memory: [mem 0x78141000-0x7871efff]
[    0.030519] PM: hibernation: Registered nosave memory: [mem 0x7871f000-0x79ffefff]
[    0.030520] PM: hibernation: Registered nosave memory: [mem 0x7a000000-0x7dffffff]
[    0.030521] PM: hibernation: Registered nosave memory: [mem 0x7e000000-0x7edfffff]
[    0.030521] PM: hibernation: Registered nosave memory: [mem 0x7ee00000-0x7fffffff]
[    0.030521] PM: hibernation: Registered nosave memory: [mem 0x80000000-0xbfffffff]
[    0.030522] PM: hibernation: Registered nosave memory: [mem 0xc0000000-0xcfffffff]
[    0.030522] PM: hibernation: Registered nosave memory: [mem 0xd0000000-0xfdffffff]
[    0.030523] PM: hibernation: Registered nosave memory: [mem 0xfe000000-0xfe010fff]
[    0.030523] PM: hibernation: Registered nosave memory: [mem 0xfe011000-0xfebfffff]
[    0.030523] PM: hibernation: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
[    0.030524] PM: hibernation: Registered nosave memory: [mem 0xfec01000-0xfecfffff]
[    0.030524] PM: hibernation: Registered nosave memory: [mem 0xfed00000-0xfed00fff]
[    0.030525] PM: hibernation: Registered nosave memory: [mem 0xfed01000-0xfed1ffff]
[    0.030525] PM: hibernation: Registered nosave memory: [mem 0xfed20000-0xfed7ffff]
[    0.030525] PM: hibernation: Registered nosave memory: [mem 0xfed80000-0xfedfffff]
[    0.030526] PM: hibernation: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
[    0.030526] PM: hibernation: Registered nosave memory: [mem 0xfee01000-0xfeffffff]
[    0.030527] PM: hibernation: Registered nosave memory: [mem 0xff000000-0xffffffff]
[    0.030527] [mem 0x80000000-0xbfffffff] available for PCI devices
[    0.030528] Booting paravirtualized kernel on bare hardware
[    0.030529] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.030532] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:16 nr_cpu_ids:16 nr_node_ids:1
[    0.030815] percpu: Embedded 61 pages/cpu s212992 r8192 d28672 u262144
[    0.030818] pcpu-alloc: s212992 r8192 d28672 u262144 alloc=1*2097152
[    0.030819] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 12 13 14 15 
[    0.030835] Built 1 zonelists, mobility grouping on.  Total pages: 8209019
[    0.030835] Policy zone: Normal
[    0.030836] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-5.15.7 root=UUID=f1d17af1-b114-4204-be05-fb71851a14ff ro noresume
[    0.030864] Unknown kernel command line parameters "BOOT_IMAGE=/boot/vmlinuz-5.15.7", will be passed to user space.
[    0.032133] Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes, linear)
[    0.032793] Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
[    0.032855] mem auto-init: stack:off, heap alloc:on, heap free:off
[    0.070027] Memory: 32526480K/33357924K available (14345K kernel code, 3533K rwdata, 10468K rodata, 2904K init, 5704K bss, 831184K reserved, 0K cma-reserved)
[    0.070030] random: get_random_u64 called from __kmem_cache_create+0x2d/0x450 with crng_init=0
[    0.070105] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=16, Nodes=1
[    0.070111] ftrace: allocating 49237 entries in 193 pages
[    0.076749] ftrace: allocated 193 pages with 3 groups
[    0.076808] rcu: Hierarchical RCU implementation.
[    0.076809] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=16.
[    0.076810] 	Rude variant of Tasks RCU enabled.
[    0.076810] 	Tracing variant of Tasks RCU enabled.
[    0.076811] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.076811] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=16
[    0.078381] NR_IRQS: 524544, nr_irqs: 2184, preallocated irqs: 16
[    0.078638] random: crng done (trusting CPU's manufacturer)
[    0.082031] Console: colour VGA+ 80x25
[    0.095244] printk: console [tty0] enabled
[    0.095305] ACPI: Core revision 20210730
[    0.095553] hpet: HPET dysfunctional in PC10. Force disabled.
[    0.095610] APIC: Switch to symmetric I/O mode setup
[    0.095663] DMAR: Host address width 39
[    0.095716] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.095772] DMAR: dmar0: reg_base_addr fed91000 ver 5:0 cap d2008c40660462 ecap f050da
[    0.095829] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 0
[    0.095882] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    0.095935] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
[    0.096707] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    0.096761] x2apic enabled
[    0.096820] Switched APIC routing to cluster x2apic.
[    0.099032] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x2df10e7656b, max_idle_ns: 440795364873 ns
[    0.099094] Calibrating delay loop (skipped), value calculated using timer frequency.. 6374.40 BogoMIPS (lpj=12748800)
[    0.099152] pid_max: default: 32768 minimum: 301
[    0.099219] LSM: Security Framework initializing
[    0.099284] Yama: becoming mindful.
[    0.099346] AppArmor: AppArmor initialized
[    0.099444] Mount-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.099524] Mountpoint-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.099712] x86/tme: not enabled by BIOS
[    0.099772] CPU0: Thermal monitoring enabled (TM1)
[    0.099825] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.099967] process: using mwait in idle threads
[    0.100024] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.100078] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.100132] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.100188] Spectre V2 : Mitigation: Enhanced IBRS
[    0.100240] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.100295] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.100350] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl and seccomp
[    0.102724] Freeing SMP alternatives memory: 40K
[    0.103092] smpboot: Estimated ratio of average max frequency by base frequency (times 1024): 1760
[    0.103092] smpboot: CPU0: 12th Gen Intel(R) Core(TM) i9-12900K (family: 0x6, model: 0x97, stepping: 0x2)
[    0.103092] Performance Events: XSAVE Architectural LBR, PEBS fmt4+-baseline,  AnyThread deprecated, Alderlake Hybrid events, 32-deep LBR, full-width counters, 
[    0.103092] ------------[ cut here ]------------
[    0.103092] hw perf events fixed 5 > max(4), clipping!
[    0.103092] WARNING: CPU: 0 PID: 1 at arch/x86/events/intel/core.c:5411 intel_pmu_check_num_counters+0x68/0x82
[    0.103092] Modules linked in:
[    0.103092] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.15.7 #1
[    0.103092] Hardware name: ASUS System Product Name/ROG STRIX Z690-A GAMING WIFI D4, BIOS 0707 11/10/2021
[    0.103092] RIP: 0010:intel_pmu_check_num_counters+0x68/0x82
[    0.103092] Code: 8b 0e b8 01 00 00 00 48 d3 e0 48 ff c8 48 89 03 41 8b 75 00 83 fe 04 7e 1b ba 04 00 00 00 48 c7 c7 08 54 99 86 e8 e9 76 00 00 <0f> 0b 41 c7 45 00 04 00 00 00 49 c1 e4 20 4c 09 23 5b 41 5c 41 5d
[    0.103092] RSP: 0000:ffffa8eac0063d70 EFLAGS: 00010282
[    0.103092] RAX: 000000000000002a RBX: ffff8e150026ed80 RCX: c0000000ffffdfff
[    0.103092] RDX: ffffa8eac0063b68 RSI: 00000000ffffdfff RDI: ffffa8eac0063bb8
[    0.103092] RBP: ffffa8eac0063d90 R08: 0000000000000000 R09: ffffa8eac0063b60
[    0.103092] R10: 0000000000000001 R11: 0000000000000001 R12: 000000000000000f
[    0.103092] R13: ffff8e150026ed90 R14: ffff8e150026ed8c R15: ffffffff878755f8
[    0.103092] FS:  0000000000000000(0000) GS:ffff8e1c5fa00000(0000) knlGS:0000000000000000
[    0.103092] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.103094] CR2: ffff8e1ab2e01000 CR3: 00000006b2210001 CR4: 0000000000770ef0
[    0.103146] PKRU: 55555554
[    0.103199] Call Trace:
[    0.103252]  <TASK>
[    0.103305]  intel_pmu_init+0x1afd/0x1b6b
[    0.103360]  ? map_vsyscall+0x81/0x81
[    0.103414]  init_hw_perf_events+0x46/0x607
[    0.103467]  ? map_vsyscall+0x81/0x81
[    0.103520]  do_one_initcall+0x46/0x1d0
[    0.103574]  ? wake_up_process+0x15/0x20
[    0.103628]  kernel_init_freeable+0x124/0x25e
[    0.103682]  ? rest_init+0xd0/0xd0
[    0.103736]  kernel_init+0x1a/0x120
[    0.103789]  ret_from_fork+0x1f/0x30
[    0.103844]  </TASK>
[    0.103900] ---[ end trace b25bb91ee9f934d1 ]---
[    0.103953] Intel PMU driver.
[    0.104027] Broken PMU hardware detected, using software events only.
[    0.104083] Failed to access perfctr msr (MSR 18e is ffffffffffffffff)
[    0.104148] rcu: Hierarchical SRCU implementation.
[    0.104379] NMI watchdog: Perf NMI watchdog permanently disabled
[    0.104488] smp: Bringing up secondary CPUs ...
[    0.104576] x86: Booting SMP configuration:
[    0.104632] .... node  #0, CPUs:        #1
[    0.024503] Broken PMU hardware detected, using software events only.
[    0.024503] Failed to access perfctr msr (MSR 18e is ffffffffffffffff)
[    0.106497]   #2
[    0.024503] Broken PMU hardware detected, using software events only.
[    0.024503] Failed to access perfctr msr (MSR 18e is ffffffffffffffff)
[    0.108456]   #3
[    0.024503] Broken PMU hardware detected, using software events only.
[    0.024503] Failed to access perfctr msr (MSR 18e is ffffffffffffffff)
[    0.108987]   #4
[    0.024503] Broken PMU hardware detected, using software events only.
[    0.024503] Failed to access perfctr msr (MSR 18e is ffffffffffffffff)
[    0.112244]   #5
[    0.024503] Broken PMU hardware detected, using software events only.
[    0.024503] Failed to access perfctr msr (MSR 18e is ffffffffffffffff)
[    0.112906]   #6
[    0.024503] Broken PMU hardware detected, using software events only.
[    0.024503] Failed to access perfctr msr (MSR 18e is ffffffffffffffff)
[    0.115915]   #7
[    0.024503] Broken PMU hardware detected, using software events only.
[    0.024503] Failed to access perfctr msr (MSR 18e is ffffffffffffffff)
[    0.116890]   #8
[    0.024503] Broken PMU hardware detected, using software events only.
[    0.024503] Failed to access perfctr msr (MSR 18e is ffffffffffffffff)
[    0.119560]   #9
[    0.024503] Broken PMU hardware detected, using software events only.
[    0.024503] Failed to access perfctr msr (MSR 18e is ffffffffffffffff)
[    0.120857]  #10
[    0.024503] Broken PMU hardware detected, using software events only.
[    0.024503] Failed to access perfctr msr (MSR 18e is ffffffffffffffff)
[    0.123170]  #11
[    0.024503] Broken PMU hardware detected, using software events only.
[    0.024503] Failed to access perfctr msr (MSR 18e is ffffffffffffffff)
[    0.124855]  #12
[    0.024503] Broken PMU hardware detected, using software events only.
[    0.024503] Failed to access perfctr msr (MSR 18e is ffffffffffffffff)
[    0.124921]  #13
[    0.024503] Broken PMU hardware detected, using software events only.
[    0.024503] Failed to access perfctr msr (MSR 18e is ffffffffffffffff)
[    0.128569]  #14
[    0.024503] Broken PMU hardware detected, using software events only.
[    0.024503] Failed to access perfctr msr (MSR 18e is ffffffffffffffff)
[    0.128948]  #15
[    0.024503] Broken PMU hardware detected, using software events only.
[    0.024503] Failed to access perfctr msr (MSR 18e is ffffffffffffffff)
[    0.132254] smp: Brought up 1 node, 16 CPUs
[    0.132254] smpboot: Max logical packages: 1
[    0.132254] smpboot: Total of 16 processors activated (101990.40 BogoMIPS)
[    0.135507] devtmpfs: initialized
[    0.135507] x86/mm: Memory block size: 128MB
[    0.135859] ACPI: PM: Registering ACPI NVS region [mem 0x78141000-0x7871efff] (6152192 bytes)
[    0.135859] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.135859] futex hash table entries: 4096 (order: 6, 262144 bytes, linear)
[    0.135859] pinctrl core: initialized pinctrl subsystem
[    0.135859] PM: RTC time: 13:32:22, date: 2021-12-10
[    0.135859] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.135882] DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic allocations
[    0.136095] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.136309] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.136370] audit: initializing netlink subsys (disabled)
[    0.136425] audit: type=2000 audit(1639143142.036:1): state=initialized audit_enabled=0 res=1
[    0.136425] thermal_sys: Registered thermal governor 'fair_share'
[    0.136425] thermal_sys: Registered thermal governor 'bang_bang'
[    0.136425] thermal_sys: Registered thermal governor 'step_wise'
[    0.136425] thermal_sys: Registered thermal governor 'user_space'
[    0.136425] thermal_sys: Registered thermal governor 'power_allocator'
[    0.136425] EISA bus registered
[    0.136425] cpuidle: using governor ladder
[    0.136425] cpuidle: using governor menu
[    0.136425] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    0.136425] ACPI: bus type PCI registered
[    0.136425] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.136425] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xc0000000-0xcfffffff] (base 0xc0000000)
[    0.136425] PCI: MMCONFIG at [mem 0xc0000000-0xcfffffff] reserved in E820
[    0.136425] PCI: Using configuration type 1 for base access
[    0.136425] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.139432] Kprobes globally optimized
[    0.139489] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.139489] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.139489] ACPI: Added _OSI(Module Device)
[    0.139489] ACPI: Added _OSI(Processor Device)
[    0.139489] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.139489] ACPI: Added _OSI(Processor Aggregator Device)
[    0.139489] ACPI: Added _OSI(Linux-Dell-Video)
[    0.139489] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.139489] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.194013] ACPI: 13 ACPI AML tables successfully acquired and loaded
[    0.200868] ACPI: Dynamic OEM Table Load:
[    0.200929] ACPI: SSDT 0xFFFF8E15002AE400 0001AB (v02 PmRef  Cpu0Psd  00003000 INTL 20200717)
[    0.201524] ACPI: \_SB_.PR00: _OSC native thermal LVT Acked
[    0.202610] ACPI: Dynamic OEM Table Load:
[    0.202670] ACPI: SSDT 0xFFFF8E15010B9400 000394 (v02 PmRef  Cpu0Cst  00003001 INTL 20200717)
[    0.203388] ACPI: Dynamic OEM Table Load:
[    0.203448] ACPI: SSDT 0xFFFF8E1501107000 000647 (v02 PmRef  Cpu0Ist  00003000 INTL 20200717)
[    0.204243] ACPI: Dynamic OEM Table Load:
[    0.204302] ACPI: SSDT 0xFFFF8E1501100000 00044D (v02 PmRef  Cpu0Hwp  00003000 INTL 20200717)
[    0.205239] ACPI: Dynamic OEM Table Load:
[    0.205300] ACPI: SSDT 0xFFFF8E1501EEE000 001BAF (v02 PmRef  ApIst    00003000 INTL 20200717)
[    0.206446] ACPI: Dynamic OEM Table Load:
[    0.206505] ACPI: SSDT 0xFFFF8E1501EEA000 001038 (v02 PmRef  ApHwp    00003000 INTL 20200717)
[    0.207507] ACPI: Dynamic OEM Table Load:
[    0.207567] ACPI: SSDT 0xFFFF8E1501EF6000 001349 (v02 PmRef  ApPsd    00003000 INTL 20200717)
[    0.208598] ACPI: Dynamic OEM Table Load:
[    0.208658] ACPI: SSDT 0xFFFF8E150007D000 000FBB (v02 PmRef  ApCst    00003000 INTL 20200717)
[    0.213094] ACPI: EC: EC started
[    0.213151] ACPI: EC: interrupt blocked
[    0.213210] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.213263] ACPI: \_SB_.PC00.LPCB.EC0_: Boot DSDT EC used to handle transactions
[    0.213317] ACPI: Interpreter enabled
[    0.213400] ACPI: PM: (supports S0 S3 S4 S5)
[    0.213456] ACPI: Using IOAPIC for interrupt routing
[    0.213534] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.214371] ACPI: Enabled 6 GPEs in block 00 to 7F
[    0.224842] ACPI: PM: Power Resource [BTRT]
[    0.227736] ACPI: PM: Power Resource [WRST]
[    0.231894] ACPI: PM: Power Resource [FN00]
[    0.231981] ACPI: PM: Power Resource [FN01]
[    0.232066] ACPI: PM: Power Resource [FN02]
[    0.232148] ACPI: PM: Power Resource [FN03]
[    0.232231] ACPI: PM: Power Resource [FN04]
[    0.232606] ACPI: PM: Power Resource [PIN]
[    0.232927] ACPI: PCI Root Bridge [PC00] (domain 0000 [bus 00-e0])
[    0.232986] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    0.233214] acpi PNP0A08:00: _OSC: platform does not support [PCIeHotplug SHPCHotplug PME]
[    0.233437] acpi PNP0A08:00: _OSC: OS now controls [AER PCIeCapability LTR]
[    0.233494] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
[    0.234194] PCI host bridge to bus 0000:00
[    0.234261] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.234315] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.234368] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.234422] pci_bus 0000:00: root bus resource [mem 0x80000000-0xbfffffff window]
[    0.234476] pci_bus 0000:00: root bus resource [mem 0x4000000000-0x7fffffffff window]
[    0.234532] pci_bus 0000:00: root bus resource [bus 00-e0]
[    0.234705] pci 0000:00:00.0: [8086:4660] type 00 class 0x060000
[    0.235293] pci 0000:00:01.0: [8086:460d] type 01 class 0x060400
[    0.235391] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.235829] pci 0000:00:06.0: [8086:464d] type 01 class 0x060400
[    0.235926] pci 0000:00:06.0: PME# supported from D0 D3hot D3cold
[    0.236303] pci 0000:00:0a.0: [8086:467d] type 00 class 0x118000
[    0.236365] pci 0000:00:0a.0: reg 0x10: [mem 0x4002210000-0x4002217fff 64bit]
[    0.236431] pci 0000:00:0a.0: enabling Extended Tags
[    0.236703] pci 0000:00:0e.0: [8086:467f] type 00 class 0x010400
[    0.236767] pci 0000:00:0e.0: reg 0x10: [mem 0x4000000000-0x4001ffffff 64bit]
[    0.236836] pci 0000:00:0e.0: reg 0x18: [mem 0x92000000-0x93ffffff]
[    0.236902] pci 0000:00:0e.0: reg 0x20: [mem 0x4002100000-0x40021fffff 64bit]
[    0.237183] pci 0000:00:14.0: [8086:7ae0] type 00 class 0x0c0330
[    0.237251] pci 0000:00:14.0: reg 0x10: [mem 0x4002200000-0x400220ffff 64bit]
[    0.237369] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.237603] pci 0000:00:14.2: [8086:7aa7] type 00 class 0x050000
[    0.237676] pci 0000:00:14.2: reg 0x10: [mem 0x400221c000-0x400221ffff 64bit]
[    0.237742] pci 0000:00:14.2: reg 0x18: [mem 0x4002225000-0x4002225fff 64bit]
[    0.238138] pci 0000:00:15.0: [8086:7acc] type 00 class 0x0c8000
[    0.238256] pci 0000:00:15.0: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
[    0.238742] pci 0000:00:15.1: [8086:7acd] type 00 class 0x0c8000
[    0.238858] pci 0000:00:15.1: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
[    0.239345] pci 0000:00:15.2: [8086:7ace] type 00 class 0x0c8000
[    0.239462] pci 0000:00:15.2: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
[    0.239874] pci 0000:00:16.0: [8086:7ae8] type 00 class 0x078000
[    0.239949] pci 0000:00:16.0: reg 0x10: [mem 0x4002221000-0x4002221fff 64bit]
[    0.240088] pci 0000:00:16.0: PME# supported from D3hot
[    0.240516] pci 0000:00:17.0: [8086:7ae2] type 00 class 0x010601
[    0.240581] pci 0000:00:17.0: reg 0x10: [mem 0x96100000-0x96101fff]
[    0.240642] pci 0000:00:17.0: reg 0x14: [mem 0x96103000-0x961030ff]
[    0.240703] pci 0000:00:17.0: reg 0x18: [io  0x5050-0x5057]
[    0.240764] pci 0000:00:17.0: reg 0x1c: [io  0x5040-0x5043]
[    0.240824] pci 0000:00:17.0: reg 0x20: [io  0x5020-0x503f]
[    0.240885] pci 0000:00:17.0: reg 0x24: [mem 0x96102000-0x961027ff]
[    0.240977] pci 0000:00:17.0: PME# supported from D3hot
[    0.241297] pci 0000:00:1a.0: [8086:7ac8] type 01 class 0x060400
[    0.241452] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    0.241927] pci 0000:00:1b.0: [8086:7ac4] type 01 class 0x060400
[    0.242081] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.242550] pci 0000:00:1c.0: [8086:7ab8] type 01 class 0x060400
[    0.242677] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.243110] pci 0000:00:1c.3: [8086:7abb] type 01 class 0x060400
[    0.243256] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
[    0.243716] pci 0000:00:1c.4: [8086:7abc] type 01 class 0x060400
[    0.243862] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.244319] pci 0000:00:1f.0: [8086:7a84] type 00 class 0x060100
[    0.244697] pci 0000:00:1f.3: [8086:7ad0] type 00 class 0x040300
[    0.244794] pci 0000:00:1f.3: reg 0x10: [mem 0x4002218000-0x400221bfff 64bit]
[    0.244911] pci 0000:00:1f.3: reg 0x20: [mem 0x4002000000-0x40020fffff 64bit]
[    0.245066] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    0.245510] pci 0000:00:1f.4: [8086:7aa3] type 00 class 0x0c0500
[    0.245585] pci 0000:00:1f.4: reg 0x10: [mem 0x4002220000-0x40022200ff 64bit]
[    0.245664] pci 0000:00:1f.4: reg 0x20: [io  0xefa0-0xefbf]
[    0.245910] pci 0000:00:1f.5: [8086:7aa4] type 00 class 0x0c8000
[    0.245979] pci 0000:00:1f.5: reg 0x10: [mem 0xfe010000-0xfe010fff]
[    0.246197] pci 0000:01:00.0: [10de:2204] type 00 class 0x030000
[    0.246260] pci 0000:01:00.0: reg 0x10: [mem 0x94000000-0x94ffffff]
[    0.246319] pci 0000:01:00.0: reg 0x14: [mem 0x80000000-0x8fffffff 64bit pref]
[    0.246378] pci 0000:01:00.0: reg 0x1c: [mem 0x90000000-0x91ffffff 64bit pref]
[    0.246435] pci 0000:01:00.0: reg 0x24: [io  0x4000-0x407f]
[    0.246492] pci 0000:01:00.0: reg 0x30: [mem 0x95000000-0x9507ffff pref]
[    0.246578] pci 0000:01:00.0: PME# supported from D0 D3hot
[    0.246769] pci 0000:01:00.1: [10de:1aef] type 00 class 0x040300
[    0.246832] pci 0000:01:00.1: reg 0x10: [mem 0x95080000-0x95083fff]
[    0.246958] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.247016] pci 0000:00:01.0:   bridge window [io  0x4000-0x4fff]
[    0.247070] pci 0000:00:01.0:   bridge window [mem 0x94000000-0x950fffff]
[    0.247094] pci 0000:00:01.0:   bridge window [mem 0x80000000-0x91ffffff 64bit pref]
[    0.247174] pci 0000:02:00.0: [8086:2700] type 00 class 0x010802
[    0.247241] pci 0000:02:00.0: reg 0x10: [mem 0x96010000-0x96013fff 64bit]
[    0.247326] pci 0000:02:00.0: reg 0x30: [mem 0x96000000-0x9600ffff pref]
[    0.247386] pci 0000:02:00.0: enabling Extended Tags
[    0.247516] pci 0000:00:06.0: PCI bridge to [bus 02]
[    0.247574] pci 0000:00:06.0:   bridge window [mem 0x96000000-0x960fffff]
[    0.247678] pci 0000:03:00.0: [144d:a804] type 00 class 0x010802
[    0.247752] pci 0000:03:00.0: reg 0x10: [mem 0x95f00000-0x95f03fff 64bit]
[    0.248025] pci 0000:00:1a.0: PCI bridge to [bus 03]
[    0.248081] pci 0000:00:1a.0:   bridge window [mem 0x95f00000-0x95ffffff]
[    0.248190] pci 0000:04:00.0: [15b7:5011] type 00 class 0x010802
[    0.248262] pci 0000:04:00.0: reg 0x10: [mem 0x95e00000-0x95e03fff 64bit]
[    0.248534] pci 0000:00:1b.0: PCI bridge to [bus 04]
[    0.248592] pci 0000:00:1b.0:   bridge window [mem 0x95e00000-0x95efffff]
[    0.248678] pci 0000:00:1c.0: PCI bridge to [bus 05]
[    0.248732] pci 0000:00:1c.0:   bridge window [io  0x3000-0x3fff]
[    0.248787] pci 0000:00:1c.0:   bridge window [mem 0x95100000-0x95afffff]
[    0.248907] pci 0000:06:00.0: [8086:15f3] type 00 class 0x020000
[    0.248980] pci 0000:06:00.0: reg 0x10: [mem 0x95b00000-0x95bfffff]
[    0.249066] pci 0000:06:00.0: reg 0x1c: [mem 0x95c00000-0x95c03fff]
[    0.249251] pci 0000:06:00.0: PME# supported from D0 D3hot D3cold
[    0.249416] pci 0000:00:1c.3: PCI bridge to [bus 06]
[    0.249474] pci 0000:00:1c.3:   bridge window [mem 0x95b00000-0x95cfffff]
[    0.249579] pci 0000:07:00.0: [8086:2700] type 00 class 0x010802
[    0.249650] pci 0000:07:00.0: reg 0x10: [mem 0x95d10000-0x95d13fff 64bit]
[    0.249742] pci 0000:07:00.0: reg 0x30: [mem 0x95d00000-0x95d0ffff pref]
[    0.249802] pci 0000:07:00.0: enabling Extended Tags
[    0.250006] pci 0000:00:1c.4: PCI bridge to [bus 07]
[    0.250062] pci 0000:00:1c.4:   bridge window [mem 0x95d00000-0x95dfffff]
[    0.250729] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    0.250846] ACPI: PCI: Interrupt link LNKB configured for IRQ 1
[    0.250962] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    0.251079] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    0.251152] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    0.251268] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    0.251384] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[    0.251499] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    0.257217] ACPI: EC: interrupt unblocked
[    0.257271] ACPI: EC: event unblocked
[    0.257345] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.257398] ACPI: EC: GPE=0x7
[    0.257452] ACPI: \_SB_.PC00.LPCB.EC0_: Boot DSDT EC initialization complete
[    0.257504] ACPI: \_SB_.PC00.LPCB.EC0_: EC: Used to handle transactions and events
[    0.257589] iommu: Default domain type: Translated 
[    0.257589] iommu: DMA domain TLB invalidation policy: lazy mode 
[    0.257589] pci 0000:01:00.0: vgaarb: setting as boot VGA device
[    0.257589] pci 0000:01:00.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.257589] pci 0000:01:00.0: vgaarb: bridge control possible
[    0.257589] vgaarb: loaded
[    0.257589] SCSI subsystem initialized
[    0.257589] libata version 3.00 loaded.
[    0.257589] ACPI: bus type USB registered
[    0.257589] usbcore: registered new interface driver usbfs
[    0.257589] usbcore: registered new interface driver hub
[    0.257589] usbcore: registered new device driver usb
[    0.257589] pps_core: LinuxPPS API ver. 1 registered
[    0.257589] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.257589] PTP clock support registered
[    0.257589] EDAC MC: Ver: 3.0.0
[    0.257589] NetLabel: Initializing
[    0.257589] NetLabel:  domain hash size = 128
[    0.257589] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.257589] NetLabel:  unlabeled traffic allowed by default
[    0.257589] PCI: Using ACPI for IRQ routing
[    0.267005] PCI: pci_cache_line_size set to 64 bytes
[    0.267092] pci 0000:00:1f.5: can't claim BAR 0 [mem 0xfe010000-0xfe010fff]: no compatible bridge window
[    0.267224] e820: reserve RAM buffer [mem 0x0009dc00-0x0009ffff]
[    0.267225] e820: reserve RAM buffer [mem 0x63e46000-0x63ffffff]
[    0.267226] e820: reserve RAM buffer [mem 0x63e9c000-0x63ffffff]
[    0.267226] e820: reserve RAM buffer [mem 0x7407e000-0x77ffffff]
[    0.267227] e820: reserve RAM buffer [mem 0x7a000000-0x7bffffff]
[    0.267228] clocksource: Switched to clocksource tsc-early
[    0.270388] VFS: Disk quotas dquot_6.6.0
[    0.270451] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.270537] AppArmor: AppArmor Filesystem Enabled
[    0.270606] pnp: PnP ACPI init
[    0.270776] system 00:00: [io  0x0290-0x029f] has been reserved
[    0.270908] system 00:01: [io  0x0680-0x069f] has been reserved
[    0.270948] system 00:01: [io  0x164e-0x164f] has been reserved
[    0.271076] system 00:02: [io  0x1854-0x1857] has been reserved
[    0.271463] system 00:03: [mem 0xfedc0000-0xfedc7fff] has been reserved
[    0.271520] system 00:03: [mem 0xfeda0000-0xfeda0fff] has been reserved
[    0.271573] system 00:03: [mem 0xfeda1000-0xfeda1fff] has been reserved
[    0.271625] system 00:03: [mem 0xc0000000-0xcfffffff] has been reserved
[    0.271678] system 00:03: [mem 0xfed20000-0xfed7ffff] has been reserved
[    0.271731] system 00:03: [mem 0xfed90000-0xfed93fff] could not be reserved
[    0.271784] system 00:03: [mem 0xfed45000-0xfed8ffff] could not be reserved
[    0.271837] system 00:03: [mem 0xfee00000-0xfeefffff] could not be reserved
[    0.272371] system 00:04: [io  0x2000-0x20fe] has been reserved
[    0.272897] pnp: PnP ACPI: found 6 devices
[    0.277785] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.277868] NET: Registered PF_INET protocol family
[    0.278031] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.278756] tcp_listen_portaddr_hash hash table entries: 16384 (order: 6, 262144 bytes, linear)
[    0.278923] TCP established hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.279132] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, linear)
[    0.279218] TCP: Hash tables configured (established 262144 bind 65536)
[    0.279346] MPTCP token hash table entries: 32768 (order: 7, 786432 bytes, linear)
[    0.279455] UDP hash table entries: 16384 (order: 7, 524288 bytes, linear)
[    0.279552] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes, linear)
[    0.279643] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.279701] NET: Registered PF_XDP protocol family
[    0.279758] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 05] add_size 200000 add_align 100000
[    0.279820] pci 0000:00:1c.0: BAR 15: assigned [mem 0x4002300000-0x40024fffff 64bit pref]
[    0.284263] pci 0000:00:15.0: BAR 0: assigned [mem 0x4002222000-0x4002222fff 64bit]
[    0.284368] pci 0000:00:15.1: BAR 0: assigned [mem 0x4002223000-0x4002223fff 64bit]
[    0.284475] pci 0000:00:15.2: BAR 0: assigned [mem 0x4002224000-0x4002224fff 64bit]
[    0.284582] pci 0000:00:1f.5: BAR 0: assigned [mem 0x96104000-0x96104fff]
[    0.284644] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.284698] pci 0000:00:01.0:   bridge window [io  0x4000-0x4fff]
[    0.284752] pci 0000:00:01.0:   bridge window [mem 0x94000000-0x950fffff]
[    0.284807] pci 0000:00:01.0:   bridge window [mem 0x80000000-0x91ffffff 64bit pref]
[    0.284865] pci 0000:00:06.0: PCI bridge to [bus 02]
[    0.284919] pci 0000:00:06.0:   bridge window [mem 0x96000000-0x960fffff]
[    0.284974] pci 0000:00:1a.0: PCI bridge to [bus 03]
[    0.285029] pci 0000:00:1a.0:   bridge window [mem 0x95f00000-0x95ffffff]
[    0.285087] pci 0000:00:1b.0: PCI bridge to [bus 04]
[    0.285143] pci 0000:00:1b.0:   bridge window [mem 0x95e00000-0x95efffff]
[    0.285201] pci 0000:00:1c.0: PCI bridge to [bus 05]
[    0.285254] pci 0000:00:1c.0:   bridge window [io  0x3000-0x3fff]
[    0.285310] pci 0000:00:1c.0:   bridge window [mem 0x95100000-0x95afffff]
[    0.285365] pci 0000:00:1c.0:   bridge window [mem 0x4002300000-0x40024fffff 64bit pref]
[    0.285423] pci 0000:00:1c.3: PCI bridge to [bus 06]
[    0.285479] pci 0000:00:1c.3:   bridge window [mem 0x95b00000-0x95cfffff]
[    0.285537] pci 0000:00:1c.4: PCI bridge to [bus 07]
[    0.285592] pci 0000:00:1c.4:   bridge window [mem 0x95d00000-0x95dfffff]
[    0.285651] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.285704] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.285757] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.285810] pci_bus 0000:00: resource 7 [mem 0x80000000-0xbfffffff window]
[    0.285863] pci_bus 0000:00: resource 8 [mem 0x4000000000-0x7fffffffff window]
[    0.285917] pci_bus 0000:01: resource 0 [io  0x4000-0x4fff]
[    0.285970] pci_bus 0000:01: resource 1 [mem 0x94000000-0x950fffff]
[    0.286022] pci_bus 0000:01: resource 2 [mem 0x80000000-0x91ffffff 64bit pref]
[    0.286077] pci_bus 0000:02: resource 1 [mem 0x96000000-0x960fffff]
[    0.286130] pci_bus 0000:03: resource 1 [mem 0x95f00000-0x95ffffff]
[    0.286183] pci_bus 0000:04: resource 1 [mem 0x95e00000-0x95efffff]
[    0.286236] pci_bus 0000:05: resource 0 [io  0x3000-0x3fff]
[    0.286289] pci_bus 0000:05: resource 1 [mem 0x95100000-0x95afffff]
[    0.286342] pci_bus 0000:05: resource 2 [mem 0x4002300000-0x40024fffff 64bit pref]
[    0.286396] pci_bus 0000:06: resource 1 [mem 0x95b00000-0x95cfffff]
[    0.286449] pci_bus 0000:07: resource 1 [mem 0x95d00000-0x95dfffff]
[    0.371864] pci 0000:00:14.0: quirk_usb_early_handoff+0x0/0x620 took 83282 usecs
[    0.372003] pci 0000:01:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.372084] pci 0000:01:00.1: D0 power state depends on 0000:01:00.0
[    0.372158] PCI: CLS 64 bytes, default 64
[    0.372236] DMAR: No RMRR found
[    0.372248] Trying to unpack rootfs image as initramfs...
[    0.372292] DMAR: No ATSR found
[    0.372293] DMAR: No SATC found
[    0.372294] DMAR: dmar0: Using Queued invalidation
[    0.372525] pci 0000:00:00.0: Adding to iommu group 0
[    0.372585] pci 0000:00:01.0: Adding to iommu group 1
[    0.372642] pci 0000:00:06.0: Adding to iommu group 2
[    0.372697] pci 0000:00:0a.0: Adding to iommu group 3
[    0.372753] pci 0000:00:0e.0: Adding to iommu group 4
[    0.372812] pci 0000:00:14.0: Adding to iommu group 5
[    0.372867] pci 0000:00:14.2: Adding to iommu group 5
[    0.372928] pci 0000:00:15.0: Adding to iommu group 6
[    0.372999] pci 0000:00:15.1: Adding to iommu group 6
[    0.373055] pci 0000:00:15.2: Adding to iommu group 6
[    0.373113] pci 0000:00:16.0: Adding to iommu group 7
[    0.373169] pci 0000:00:17.0: Adding to iommu group 8
[    0.373226] pci 0000:00:1a.0: Adding to iommu group 9
[    0.373283] pci 0000:00:1b.0: Adding to iommu group 10
[    0.373343] pci 0000:00:1c.0: Adding to iommu group 11
[    0.373401] pci 0000:00:1c.3: Adding to iommu group 12
[    0.373458] pci 0000:00:1c.4: Adding to iommu group 13
[    0.373519] pci 0000:00:1f.0: Adding to iommu group 14
[    0.373590] pci 0000:00:1f.3: Adding to iommu group 14
[    0.373645] pci 0000:00:1f.4: Adding to iommu group 14
[    0.373701] pci 0000:00:1f.5: Adding to iommu group 14
[    0.373760] pci 0000:01:00.0: Adding to iommu group 15
[    0.373817] pci 0000:01:00.1: Adding to iommu group 15
[    0.373873] pci 0000:02:00.0: Adding to iommu group 16
[    0.373930] pci 0000:03:00.0: Adding to iommu group 17
[    0.373986] pci 0000:04:00.0: Adding to iommu group 18
[    0.374043] pci 0000:06:00.0: Adding to iommu group 19
[    0.374100] pci 0000:07:00.0: Adding to iommu group 20
[    0.375169] DMAR: Intel(R) Virtualization Technology for Directed I/O
[    0.375226] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.375279] software IO TLB: mapped [mem 0x000000007007e000-0x000000007407e000] (64MB)
[    0.375387] resource sanity check: requesting [mem 0xfedc0000-0xfedcdfff], which spans more than pnp 00:03 [mem 0xfedc0000-0xfedc7fff]
[    0.375449] caller tgl_uncore_imc_freerunning_init_box+0xab/0xd0 mapping multiple BARs
[    0.375557] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2df10e7656b, max_idle_ns: 440795364873 ns
[    0.375630] clocksource: Switched to clocksource tsc
[    0.375702] platform rtc_cmos: registered platform RTC device (no PNP device found)
[    0.377514] Initialise system trusted keyrings
[    0.377579] Key type blacklist registered
[    0.377658] workingset: timestamp_bits=36 max_order=23 bucket_order=0
[    0.378080] zbud: loaded
[    0.378224] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.378323] fuse: init (API version 7.34)
[    0.378429] integrity: Platform Keyring initialized
[    0.382362] Key type asymmetric registered
[    0.382419] Asymmetric key parser 'x509' registered
[    0.382479] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 243)
[    0.382548] io scheduler mq-deadline registered
[    0.382812] pcieport 0000:00:01.0: AER: enabled with IRQ 121
[    0.382883] pcieport 0000:00:01.0: DPC: enabled with IRQ 121
[    0.382945] pcieport 0000:00:01.0: DPC: error containment capabilities: Int Msg #0, RPExt+ PoisonedTLP+ SwTrigger+ RP PIO Log 4, DL_ActiveErr+
[    0.383114] pcieport 0000:00:06.0: AER: enabled with IRQ 122
[    0.383183] pcieport 0000:00:06.0: DPC: enabled with IRQ 122
[    0.383246] pcieport 0000:00:06.0: DPC: error containment capabilities: Int Msg #0, RPExt+ PoisonedTLP+ SwTrigger+ RP PIO Log 4, DL_ActiveErr+
[    0.383447] pcieport 0000:00:1a.0: AER: enabled with IRQ 123
[    0.383520] pcieport 0000:00:1a.0: DPC: enabled with IRQ 123
[    0.383577] pcieport 0000:00:1a.0: DPC: error containment capabilities: Int Msg #0, RPExt+ PoisonedTLP+ SwTrigger+ RP PIO Log 4, DL_ActiveErr+
[    0.383802] pcieport 0000:00:1b.0: AER: enabled with IRQ 124
[    0.383874] pcieport 0000:00:1b.0: DPC: enabled with IRQ 124
[    0.383930] pcieport 0000:00:1b.0: DPC: error containment capabilities: Int Msg #0, RPExt+ PoisonedTLP+ SwTrigger+ RP PIO Log 4, DL_ActiveErr+
[    0.384212] pcieport 0000:00:1c.3: AER: enabled with IRQ 126
[    0.384284] pcieport 0000:00:1c.3: DPC: enabled with IRQ 126
[    0.384340] pcieport 0000:00:1c.3: DPC: error containment capabilities: Int Msg #0, RPExt+ PoisonedTLP+ SwTrigger+ RP PIO Log 4, DL_ActiveErr+
[    0.384560] pcieport 0000:00:1c.4: AER: enabled with IRQ 127
[    0.384633] pcieport 0000:00:1c.4: DPC: enabled with IRQ 127
[    0.384689] pcieport 0000:00:1c.4: DPC: error containment capabilities: Int Msg #0, RPExt+ PoisonedTLP+ SwTrigger+ RP PIO Log 4, DL_ActiveErr+
[    0.384815] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    0.385010] Monitor-Mwait will be used to enter C-1 state
[    0.385012] Monitor-Mwait will be used to enter C-2 state
[    0.385013] Monitor-Mwait will be used to enter C-3 state
[    0.385014] ACPI: \_SB_.PR00: Found 3 idle states
[    0.385336] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input0
[    0.385406] ACPI: button: Sleep Button [SLPB]
[    0.385485] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
[    0.385556] ACPI: button: Power Button [PWRB]
[    0.385635] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
[    0.385716] ACPI: button: Power Button [PWRF]
[    0.385902] smpboot: Estimated ratio of average max frequency by base frequency (times 1024): 1760
[    0.387202] thermal LNXTHERM:00: registered as thermal_zone0
[    0.387260] ACPI: thermal: Thermal Zone [TZ00] (28 C)
[    0.387401] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.408202] serial8250: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    0.408753] hpet_acpi_add: no address or irqs in _CRS
[    0.408827] Linux agpgart interface v0.103
[    0.411170] loop: module loaded
[    0.411315] libphy: Fixed MDIO Bus: probed
[    0.411372] tun: Universal TUN/TAP device driver, 1.6
[    0.411432] PPP generic driver version 2.4.2
[    0.411514] VFIO - User Level meta-driver version: 0.3
[    0.411631] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.411688] ehci-pci: EHCI PCI platform driver
[    0.411743] ehci-platform: EHCI generic platform driver
[    0.411798] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.411851] ohci-pci: OHCI PCI platform driver
[    0.411907] ohci-platform: OHCI generic platform driver
[    0.411962] uhci_hcd: USB Universal Host Controller Interface driver
[    0.412024] i8042: PNP: No PS/2 controller found.
[    0.412102] mousedev: PS/2 mouse device common for all mice
[    0.412210] rtc_cmos rtc_cmos: RTC can wake from S4
[    0.412641] rtc_cmos rtc_cmos: registered as rtc0
[    0.412789] rtc_cmos rtc_cmos: setting system clock to 2021-12-10T13:32:23 UTC (1639143143)
[    0.412848] rtc_cmos rtc_cmos: alarms up to one month, y3k, 114 bytes nvram
[    0.412902] i2c_dev: i2c /dev entries driver
[    0.413208] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. Duplicate IMA measurements will not be recorded in the IMA log.
[    0.413281] device-mapper: uevent: version 1.0.3
[    0.413359] device-mapper: ioctl: 4.45.0-ioctl (2021-03-22) initialised: dm-devel at redhat.com
[    0.413431] platform eisa.0: Probing EISA bus 0
[    0.417862] platform eisa.0: EISA: Cannot allocate resource for mainboard
[    0.417915] platform eisa.0: Cannot allocate resource for EISA slot 1
[    0.417968] platform eisa.0: Cannot allocate resource for EISA slot 2
[    0.418021] platform eisa.0: Cannot allocate resource for EISA slot 3
[    0.418074] platform eisa.0: Cannot allocate resource for EISA slot 4
[    0.418127] platform eisa.0: Cannot allocate resource for EISA slot 5
[    0.418180] platform eisa.0: Cannot allocate resource for EISA slot 6
[    0.418232] platform eisa.0: Cannot allocate resource for EISA slot 7
[    0.418285] platform eisa.0: Cannot allocate resource for EISA slot 8
[    0.418338] platform eisa.0: EISA: Detected 0 cards
[    0.418607] intel_pstate: Intel P-state driver initializing
[    0.419529] intel_pstate: HWP enabled
[    0.420265] ledtrig-cpu: registered to indicate activity on CPUs
[    0.420372] intel_pmc_core INT33A1:00:  initialized
[    0.420463] drop_monitor: Initializing network drop monitor service
[    0.420579] NET: Registered PF_INET6 protocol family
[    0.478344] Freeing initrd memory: 145644K
[    0.481079] Segment Routing with IPv6
[    0.481143] In-situ OAM (IOAM) with IPv6
[    0.481207] NET: Registered PF_PACKET protocol family
[    0.481290] Key type dns_resolver registered
[    0.482179] microcode: sig=0x90672, pf=0x2, revision=0x12
[    0.482408] microcode: Microcode Update Driver: v2.2.
[    0.482634] resctrl: L2 allocation detected
[    0.482746] IPI shorthand broadcast: enabled
[    0.482800] sched_clock: Marking stable (462127661, 20503036)->(504024711, -21394014)
[    0.482999] registered taskstats version 1
[    0.483108] Loading compiled-in X.509 certificates
[    0.483452] Loaded X.509 cert 'Build time autogenerated kernel key: ced44f48dc6a4c51bb2cdde59e063110a83d4857'
[    0.483713] zswap: loaded using pool lzo/zbud
[    0.484016] Key type ._fscrypt registered
[    0.484074] Key type .fscrypt registered
[    0.484126] Key type fscrypt-provisioning registered
[    0.485066] Key type encrypted registered
[    0.485123] AppArmor: AppArmor sha1 policy hashing enabled
[    0.485178] ima: No TPM chip found, activating TPM-bypass!
[    0.485231] Loading compiled-in module X.509 certificates
[    0.485492] Loaded X.509 cert 'Build time autogenerated kernel key: ced44f48dc6a4c51bb2cdde59e063110a83d4857'
[    0.485551] ima: Allocated hash algorithm: sha1
[    0.485606] ima: No architecture policies found
[    0.485661] evm: Initialising EVM extended attributes:
[    0.485714] evm: security.selinux
[    0.485767] evm: security.SMACK64
[    0.485820] evm: security.SMACK64EXEC
[    0.485872] evm: security.SMACK64TRANSMUTE
[    0.485925] evm: security.SMACK64MMAP
[    0.485978] evm: security.apparmor
[    0.486031] evm: security.ima
[    0.486084] evm: security.capability
[    0.486137] evm: HMAC attrs: 0x1
[    0.486283] PM:   Magic number: 1:644:533
[    0.486344] tty ttyS13: hash matches
[    0.486479] RAS: Correctable Errors collector initialized.
[    0.492943] Freeing unused decrypted memory: 2036K
[    0.493172] Freeing unused kernel image (initmem) memory: 2904K
[    0.527284] Write protecting the kernel read-only data: 28672k
[    0.528403] Freeing unused kernel image (text/rodata gap) memory: 2036K
[    0.529164] Freeing unused kernel image (rodata/data gap) memory: 1820K
[    0.546030] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    0.546089] Run /init as init process
[    0.546145]   with arguments:
[    0.546146]     /init
[    0.546147]   with environment:
[    0.546148]     HOME=/
[    0.546148]     TERM=linux
[    0.546149]     BOOT_IMAGE=/boot/vmlinuz-5.15.7
[    0.591537] intel-pmt 0000:00:0a.0: Watcher not supported
[    0.591611] intel-pmt 0000:00:0a.0: Crashlog not supported
[    0.592352] Intel(R) 2.5G Ethernet Linux Driver
[    0.592412] Copyright(c) 2018 Intel Corporation.
[    0.592437] vmd 0000:00:0e.0: PCI host bridge to bus 10000:e0
[    0.592528] pci_bus 10000:e0: root bus resource [bus e0-ff]
[    0.592554] igc 0000:06:00.0: PCIe PTM not supported by PCIe bus/controller
[    0.592571] acpi PNP0C14:01: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:00)
[    0.592642] pci_bus 10000:e0: root bus resource [mem 0x92000000-0x93ffffff]
[    0.592648] acpi PNP0C14:02: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:00)
[    0.592661] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[    0.592693] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[    0.592731] pci_bus 10000:e0: root bus resource [mem 0x4002102000-0x40021fffff 64bit]
[    0.592985] vmd 0000:00:0e.0: Bound to PCI domain 10000
[    0.593935] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.594206] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[    0.594208] ahci 0000:00:17.0: version 3.0
[    0.595311] acpi PNP0C14:03: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:00)
[    0.595366] ahci 0000:00:17.0: AHCI 0001.0301 32 slots 4 ports 6 Gbps 0xf0 impl SATA mode
[    0.595394] xhci_hcd 0000:00:14.0: hcc params 0x20007fc1 hci version 0x120 quirks 0x0000000000009810
[    0.595437] ahci 0000:00:17.0: flags: 64bit ncq sntf led clo only pio slum part ems deso sadm sds 
[    0.595906] nvme 0000:02:00.0: platform quirk: setting simple suspend
[    0.596674] i2c i2c-0: 2/4 memory slots populated (from DMI)
[    0.596826] nvme nvme0: pci function 0000:02:00.0
[    0.596832] acpi PNP0C14:04: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:00)
[    0.596890] nvme 0000:03:00.0: platform quirk: setting simple suspend
[    0.596925] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.15
[    0.596926] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.596927] usb usb1: Product: xHCI Host Controller
[    0.596928] usb usb1: Manufacturer: Linux 5.15.7 xhci-hcd
[    0.596928] usb usb1: SerialNumber: 0000:00:14.0
[    0.596973] acpi PNP0C14:05: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:00)
[    0.597002] hub 1-0:1.0: USB hub found
[    0.597020] nvme nvme1: pci function 0000:03:00.0
[    0.597032] nvme 0000:04:00.0: platform quirk: setting simple suspend
[    0.597052] nvme nvme2: pci function 0000:04:00.0
[    0.597110] acpi PNP0C14:06: duplicate WMI GUID 97845ED0-4E6D-11DE-8A39-0800200C9A66 (first instance was on PNP0C14:02)
[    0.597132] hub 1-0:1.0: 16 ports detected
[    0.597162] nvme 0000:07:00.0: platform quirk: setting simple suspend
[    0.597199] acpi PNP0C14:06: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:00)
[    0.597258] nvme nvme3: pci function 0000:07:00.0
[    0.597348] i2c i2c-0: Successfully instantiated SPD at 0x51
[    0.597732] cryptd: max_cpu_qlen set to 1000
[    0.598418] i2c i2c-0: Successfully instantiated SPD at 0x53
[    0.599116] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.599169] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
[    0.599221] xhci_hcd 0000:00:14.0: Host supports USB 3.2 Enhanced SuperSpeed
[    0.599282] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.15
[    0.599334] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.599388] usb usb2: Product: xHCI Host Controller
[    0.599432] usb usb2: Manufacturer: Linux 5.15.7 xhci-hcd
[    0.599477] usb usb2: SerialNumber: 0000:00:14.0
[    0.599555] AVX2 version of gcm_enc/dec engaged.
[    0.599564] hub 2-0:1.0: USB hub found
[    0.599656] hub 2-0:1.0: 8 ports detected
[    0.599709] AES CTR mode by8 optimization enabled
[    0.603197] nvme nvme0: 16/0/0 default/read/poll queues
[    0.604508]  nvme0n1: p1 p2 p3
[    0.605319] nvme nvme3: 16/0/0 default/read/poll queues
[    0.606542]  nvme3n1: p1 p2 p3 < p5 p6 p7 > p4
[    0.607626] nvidia: loading out-of-tree module taints kernel.
[    0.607676] nvidia: module license 'NVIDIA' taints kernel.
[    0.607719] Disabling lock debugging due to kernel taint
[    0.614837] nvidia: module verification failed: signature and/or required key missing - tainting kernel
[    0.617110] nvme nvme2: 16/0/0 default/read/poll queues
[    0.618733] nvidia-nvlink: Nvlink Core is being initialized, major device number 511

[    0.619117] intel-lpss 0000:00:15.0: enabling device (0004 -> 0006)
[    0.619274] nvidia 0000:01:00.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=none:owns=io+mem
[    0.619412] idma64 idma64.0: Found Intel integrated DMA 64-bit
[    0.619519]  nvme2n1: p1 p2 p3 < p5 p6 p7 > p4
[    0.619642] nvme nvme1: 7/0/0 default/read/poll queues
[    0.622875]  nvme1n1: p1 p3 < p5 p6 p7 p8 >
[    0.639346] pps pps0: new PPS source ptp0
[    0.639418] igc 0000:06:00.0 (unnamed net_device) (uninitialized): PHC added
[    0.643104] intel-lpss 0000:00:15.1: enabling device (0004 -> 0006)
[    0.643356] idma64 idma64.1: Found Intel integrated DMA 64-bit
[    0.643407] scsi host0: ahci
[    0.643546] scsi host1: ahci
[    0.643637] scsi host2: ahci
[    0.643723] scsi host3: ahci
[    0.643812] scsi host4: ahci
[    0.643896] scsi host5: ahci
[    0.643978] scsi host6: ahci
[    0.644059] scsi host7: ahci
[    0.644127] ata1: DUMMY
[    0.644192] ata2: DUMMY
[    0.644245] ata3: DUMMY
[    0.644297] ata4: DUMMY
[    0.644352] ata5: SATA max UDMA/133 abar m2048 at 0x96102000 port 0x96102300 irq 147
[    0.644407] ata6: SATA max UDMA/133 abar m2048 at 0x96102000 port 0x96102380 irq 147
[    0.644463] ata7: SATA max UDMA/133 abar m2048 at 0x96102000 port 0x96102400 irq 147
[    0.644519] ata8: SATA max UDMA/133 abar m2048 at 0x96102000 port 0x96102480 irq 147
[    0.663147] intel-lpss 0000:00:15.2: enabling device (0004 -> 0006)
[    0.663353] idma64 idma64.2: Found Intel integrated DMA 64-bit
[    0.666949] NVRM: loading NVIDIA UNIX x86_64 Kernel Module  470.86  Tue Oct 26 21:55:45 UTC 2021
[    0.668043] nvidia-modeset: Loading NVIDIA Kernel Mode Setting Driver for UNIX platforms  470.86  Tue Oct 26 21:46:51 UTC 2021
[    0.668368] [drm] [nvidia-drm] [GPU ID 0x00000100] Loading driver
[    0.668426] [drm] Initialized nvidia-drm 0.0.0 20160202 for 0000:01:00.0 on minor 0
[    0.698480] igc 0000:06:00.0: 4.000 Gb/s available PCIe bandwidth (5.0 GT/s PCIe x1 link)
[    0.698583] igc 0000:06:00.0 eth0: MAC: 04:42:1a:2e:78:8a
[    0.705653] igc 0000:06:00.0 enp6s0: renamed from eth0
[    0.855152] usb 1-2: new high-speed USB device number 2 using xhci_hcd
[    0.961775] ata6: SATA link down (SStatus 4 SControl 300)
[    0.965514] ata8: SATA link down (SStatus 4 SControl 300)
[    0.965661] ata5: SATA link down (SStatus 4 SControl 300)
[    0.965809] ata7: SATA link down (SStatus 4 SControl 300)
[    1.139018] usb 2-8: new SuperSpeed USB device number 2 using xhci_hcd
[    1.194750] usb 2-8: New USB device found, idVendor=174c, idProduct=3074, bcdDevice= 0.01
[    1.194916] usb 2-8: New USB device strings: Mfr=2, Product=3, SerialNumber=0
[    1.195041] usb 2-8: Product: ASM107x
[    1.195184] usb 2-8: Manufacturer: ASUS TEK.
[    1.215806] hub 2-8:1.0: USB hub found
[    1.219901] hub 2-8:1.0: 4 ports detected
[    1.644915] usb 2-8.4: new SuperSpeed USB device number 3 using xhci_hcd
[    1.750044] usb 2-8.4: New USB device found, idVendor=2109, idProduct=0813, bcdDevice=90.11
[    1.750211] usb 2-8.4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    1.750364] usb 2-8.4: Product: USB3.0 Hub
[    1.750478] usb 2-8.4: Manufacturer: VIA Labs, Inc.
[    1.760720] hub 2-8.4:1.0: USB hub found
[    1.761079] hub 2-8.4:1.0: 4 ports detected
[    2.188437] usb 2-8.4.1: new SuperSpeed USB device number 4 using xhci_hcd
[    2.227152] raid6: avx512x4 gen() 68375 MB/s
[    2.295133] raid6: avx512x4 xor() 14484 MB/s
[    2.296088] usb 2-8.4.1: New USB device found, idVendor=2109, idProduct=0813, bcdDevice=90.11
[    2.296143] usb 2-8.4.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.296197] usb 2-8.4.1: Product: USB3.0 Hub
[    2.296250] usb 2-8.4.1: Manufacturer: VIA Labs, Inc.
[    2.298329] hub 2-8.4.1:1.0: USB hub found
[    2.298575] hub 2-8.4.1:1.0: 4 ports detected
[    2.363132] raid6: avx512x2 gen() 77112 MB/s
[    2.431132] raid6: avx512x2 xor() 42923 MB/s
[    2.499155] raid6: avx512x1 gen() 41437 MB/s
[    2.567144] raid6: avx512x1 xor() 42886 MB/s
[    2.609616] usb 1-2: New USB device found, idVendor=0b05, idProduct=1a16, bcdDevice= 0.03
[    2.609677] usb 1-2: New USB device strings: Mfr=3, Product=1, SerialNumber=0
[    2.609730] usb 1-2: Product: USB Audio
[    2.609783] usb 1-2: Manufacturer: Generic
[    2.635094] raid6: avx2x4   gen() 56020 MB/s
[    2.635602] hid: raw HID events driver (C) Jiri Kosina
[    2.637667] usbcore: registered new interface driver usbhid
[    2.637725] usbhid: USB HID core driver
[    2.638387] hid-generic 0003:0B05:1A16.0001: hiddev0,hidraw0: USB HID v1.11 Device [Generic USB Audio] on usb-0000:00:14.0-2/input7
[    2.703153] raid6: avx2x4   xor() 12853 MB/s
[    2.703266] usb 2-8.4.1.1: new SuperSpeed USB device number 5 using xhci_hcd
[    2.737074] usb 2-8.4.1.1: New USB device found, idVendor=0bda, idProduct=0411, bcdDevice= 1.04
[    2.737131] usb 2-8.4.1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.737185] usb 2-8.4.1.1: Product: 4-Port USB 3.0 Hub
[    2.737239] usb 2-8.4.1.1: Manufacturer: Generic
[    2.741149] hub 2-8.4.1.1:1.0: USB hub found
[    2.741923] hub 2-8.4.1.1:1.0: 4 ports detected
[    2.771144] raid6: avx2x2   gen() 61527 MB/s
[    2.839143] raid6: avx2x2   xor() 38629 MB/s
[    2.859158] usb 1-4: new full-speed USB device number 3 using xhci_hcd
[    2.907132] raid6: avx2x1   gen() 57720 MB/s
[    2.975137] raid6: avx2x1   xor() 34027 MB/s
[    3.008704] usb 1-4: config 1 has an invalid interface number: 2 but max is 1
[    3.008763] usb 1-4: config 1 has no interface number 1
[    3.009651] usb 1-4: New USB device found, idVendor=0b05, idProduct=19af, bcdDevice= 1.00
[    3.009711] usb 1-4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.009764] usb 1-4: Product: AURA LED Controller
[    3.009817] usb 1-4: Manufacturer: AsusTek Computer Inc.
[    3.009870] usb 1-4: SerialNumber: 9876543210
[    3.011397] hid-generic 0003:0B05:19AF.0002: hiddev1,hidraw1: USB HID v1.11 Device [AsusTek Computer Inc. AURA LED Controller] on usb-0000:00:14.0-4/input2
[    3.043130] raid6: sse2x4   gen() 40684 MB/s
[    3.087371] usb 2-8.4.1.1.1: new SuperSpeed USB device number 6 using xhci_hcd
[    3.111150] raid6: sse2x4   xor() 11004 MB/s
[    3.121540] usb 2-8.4.1.1.1: New USB device found, idVendor=0bda, idProduct=0411, bcdDevice= 1.04
[    3.121601] usb 2-8.4.1.1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.121656] usb 2-8.4.1.1.1: Product: 4-Port USB 3.0 Hub
[    3.121709] usb 2-8.4.1.1.1: Manufacturer: Generic
[    3.126156] hub 2-8.4.1.1.1:1.0: USB hub found
[    3.127045] hub 2-8.4.1.1.1:1.0: 4 ports detected
[    3.179151] raid6: sse2x2   gen() 44807 MB/s
[    3.243140] usb 1-10: new high-speed USB device number 4 using xhci_hcd
[    3.247135] raid6: sse2x2   xor() 27043 MB/s
[    3.315132] raid6: sse2x1   gen() 36704 MB/s
[    3.383150] raid6: sse2x1   xor() 22597 MB/s
[    3.383207] raid6: using algorithm avx512x2 gen() 77112 MB/s
[    3.383261] raid6: .... xor() 42923 MB/s, rmw enabled
[    3.383314] raid6: using avx512x2 recovery algorithm
[    3.383767] xor: automatically using best checksumming function   avx       
[    3.384169] async_tx: api initialized (async)
[    3.392786] usb 1-10: New USB device found, idVendor=174c, idProduct=2074, bcdDevice= 0.01
[    3.392843] usb 1-10: New USB device strings: Mfr=2, Product=3, SerialNumber=0
[    3.392897] usb 1-10: Product: ASM107x
[    3.392951] usb 1-10: Manufacturer: ASUS TEK.
[    3.393694] hub 1-10:1.0: USB hub found
[    3.393917] hub 1-10:1.0: 4 ports detected
[    3.399202] EXT4-fs (nvme3n1p2): mounted filesystem with ordered data mode. Opts: (null). Quota mode: none.
[    3.462231] systemd[1]: Inserted module 'autofs4'
[    3.467077] systemd[1]: systemd 245.4-4ubuntu3.13 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=hybrid)
[    3.487197] systemd[1]: Detected architecture x86-64.
[    3.520274] systemd[1]: Set hostname to <computer>.
[    3.527134] usb 1-13: new high-speed USB device number 5 using xhci_hcd
[    3.588221] systemd[1]: Unnecessary job for /sys/devices/virtual/misc/vmbus!hv_vss was removed.
[    3.588283] systemd[1]: Unnecessary job for /sys/devices/virtual/misc/vmbus!hv_fcopy was removed.
[    3.588890] systemd[1]: Created slice system-modprobe.slice.
[    3.589109] systemd[1]: Created slice system-systemd\x2dfsck.slice.
[    3.589295] systemd[1]: Created slice User and Session Slice.
[    3.589443] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[    3.589643] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[    3.589797] systemd[1]: Reached target Remote File Systems.
[    3.589933] systemd[1]: Reached target Slices.
[    3.590096] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    3.590254] systemd[1]: Listening on LVM2 poll daemon socket.
[    3.590404] systemd[1]: Listening on Syslog Socket.
[    3.590656] systemd[1]: Listening on fsck to fsckd communication Socket.
[    3.590829] systemd[1]: Listening on initctl Compatibility Named Pipe.
[    3.591025] systemd[1]: Listening on Journal Audit Socket.
[    3.591176] systemd[1]: Listening on Journal Socket (/dev/log).
[    3.591329] systemd[1]: Listening on Journal Socket.
[    3.591479] systemd[1]: Listening on udev Control Socket.
[    3.596004] systemd[1]: Listening on udev Kernel Socket.
[    3.596393] systemd[1]: Mounting Huge Pages File System...
[    3.596766] systemd[1]: Mounting POSIX Message Queue File System...
[    3.597159] systemd[1]: Mounting Kernel Debug File System...
[    3.597576] systemd[1]: Mounting Kernel Trace File System...
[    3.598178] systemd[1]: Starting Journal Service...
[    3.598583] systemd[1]: Starting Availability of block devices...
[    3.599069] systemd[1]: Starting Set the console keyboard layout...
[    3.599494] systemd[1]: Starting Create list of static device nodes for the current kernel...
[    3.599857] systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling...
[    3.600024] systemd[1]: Condition check resulted in Load Kernel Module drm being skipped.
[    3.600303] systemd[1]: Started Nameserver information manager.
[    3.600490] systemd[1]: Reached target Network (Pre).
[    3.600696] systemd[1]: Condition check resulted in Set Up Additional Binary Formats being skipped.
[    3.600762] systemd[1]: Condition check resulted in File System Check on Root Device being skipped.
[    3.601188] systemd[1]: Starting Load Kernel Modules...
[    3.601564] systemd[1]: Starting Remount Root and Kernel File Systems...
[    3.601938] systemd[1]: Starting udev Coldplug all Devices...
[    3.602287] systemd[1]: Starting Uncomplicated firewall...
[    3.602914] systemd[1]: Mounted Huge Pages File System.
[    3.603060] systemd[1]: Mounted POSIX Message Queue File System.
[    3.603201] systemd[1]: Mounted Kernel Debug File System.
[    3.603353] systemd[1]: Mounted Kernel Trace File System.
[    3.603367] EXT4-fs (nvme3n1p2): re-mounted. Opts: errors=remount-ro. Quota mode: none.
[    3.603934] systemd[1]: Finished Availability of block devices.
[    3.604291] systemd[1]: Finished Create list of static device nodes for the current kernel.
[    3.604744] systemd[1]: Finished Remount Root and Kernel File Systems.
[    3.604786] bpfilter: Loaded bpfilter_umh pid 510
[    3.604809] lp: driver loaded but no devices found
[    3.604904] Started bpfilter
[    3.605139] systemd[1]: Condition check resulted in Rebuild Hardware Database being skipped.
[    3.605217] systemd[1]: Condition check resulted in Platform Persistent Storage Archival being skipped.
[    3.605689] systemd[1]: Starting Load/Save Random Seed...
[    3.605961] ppdev: user-space parallel port driver
[    3.606160] systemd[1]: Starting Create System Users...
[    3.608062] systemd[1]: Finished Load/Save Random Seed.
[    3.608789] systemd[1]: Finished Create System Users.
[    3.609208] systemd[1]: Starting Create Static Device Nodes in /dev...
[    3.611719] nct6775: Found NCT6798D or compatible chip at 0x2e:0x290
[    3.611778] ACPI Warning: SystemIO range 0x0000000000000295-0x0000000000000296 conflicts with OpRegion 0x0000000000000290-0x0000000000000299 (\RMTW.SHWM) (20210730/utaddress-204)
[    3.611854] ACPI: OSL: Resource conflict; ACPI support missing from driver?
[    3.612205] systemd[1]: Finished Create Static Device Nodes in /dev.
[    3.612551] systemd[1]: Finished Load Kernel Modules.
[    3.612979] systemd[1]: Mounting FUSE Control File System...
[    3.613418] systemd[1]: Mounting Kernel Configuration File System...
[    3.613897] systemd[1]: Starting Apply Kernel Variables...
[    3.614406] systemd[1]: Starting udev Kernel Device Manager...
[    3.614847] systemd[1]: Mounted FUSE Control File System.
[    3.615024] systemd[1]: Mounted Kernel Configuration File System.
[    3.617014] systemd[1]: Finished Apply Kernel Variables.
[    3.618416] systemd[1]: Finished Set the console keyboard layout.
[    3.622215] systemd[1]: Started Journal Service.
[    3.623980] systemd-journald[486]: Received client request to flush runtime journal.
[    3.651874] nvidia_uvm: module uses symbols from proprietary module nvidia, inheriting taint.
[    3.652894] nvidia-uvm: Loaded the UVM driver, major device number 508.
[    3.675408] usb 1-13: New USB device found, idVendor=058f, idProduct=6254, bcdDevice= 1.00
[    3.675412] usb 1-13: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    3.686052] hub 1-13:1.0: USB hub found
[    3.686102] hub 1-13:1.0: 4 ports detected
[    3.698604] iTCO_vendor_support: vendor-support=0
[    3.705976] iTCO_wdt iTCO_wdt: Found a Intel PCH TCO device (Version=6, TCOBASE=0x0400)
[    3.708819] iTCO_wdt iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[    3.710513] ee1004 0-0051: 512 byte EE1004-compliant SPD EEPROM, read-only
[    3.710700] ee1004 0-0053: 512 byte EE1004-compliant SPD EEPROM, read-only
[    3.726276] asus_wmi: ASUS WMI generic driver loaded
[    3.736946] snd_hda_intel 0000:00:1f.3: Applying patch firmware 'hda-jack-retask.fw'
[    3.737539] snd_hda_intel 0000:01:00.1: Disabling MSI
[    3.737545] snd_hda_intel 0000:01:00.1: Handle vga_switcheroo audio client
[    3.737550] snd_hda_intel 0000:01:00.1: Applying patch firmware 'hda-jack-retask.fw'
[    3.759540] mc: Linux media interface: v0.10
[    3.760004] asus_wmi: SFUN value: 0x1
[    3.760006] eeepc-wmi eeepc-wmi: Detected ATK, not ASUSWMI, use DSTS
[    3.760066] asus_wmi: SFUN value: 0x1
[    3.760069] asus-nb-wmi asus-nb-wmi: Detected ATK, not ASUSWMI, use DSTS
[    3.760071] asus-nb-wmi asus-nb-wmi: Detected ATK, enable event queue
[    3.760076] asus_wmi: Failed to get WMI notify code: AE_NOT_FOUND
[    3.760077] asus_wmi: Failed to get event during flush: -5
[    3.761623] input: Eee PC WMI hotkeys as /devices/platform/eeepc-wmi/input/input3
[    3.761663] input: Asus WMI hotkeys as /devices/platform/asus-nb-wmi/input/input4
[    3.764208] RAPL PMU: API unit is 2^-32 Joules, 2 fixed counters, 655360 ms ovfl timer
[    3.764210] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    3.764211] RAPL PMU: hw unit of domain package 2^-14 Joules
[    3.769283] Adding 4193276k swap on /dev/nvme1n1p8.  Priority:-2 extents:1 across:4193276k SSFS
[    3.769446] EXT4-fs (nvme0n1p1): mounted filesystem with ordered data mode. Opts: (null). Quota mode: none.
[    3.771104] usb 1-10.4: new high-speed USB device number 6 using xhci_hcd
[    3.776267] EXT4-fs (nvme0n1p2): mounted filesystem with ordered data mode. Opts: (null). Quota mode: none.
[    3.799984] EXT4-fs (nvme3n1p6): mounted filesystem with ordered data mode. Opts: (null). Quota mode: none.
[    3.800106] EXT4-fs (nvme2n1p5): mounted filesystem with ordered data mode. Opts: (null). Quota mode: none.
[    3.801062] EXT4-fs (nvme2n1p6): mounted filesystem with ordered data mode. Opts: (null). Quota mode: none.
[    3.806867] EXT4-fs (nvme1n1p5): mounted filesystem with ordered data mode. Opts: (null). Quota mode: none.
[    3.809852] EXT4-fs (nvme1n1p6): mounted filesystem with ordered data mode. Opts: (null). Quota mode: none.
[    3.817571] audit: type=1400 audit(1639143146.899:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="ippusbxd" pid=833 comm="apparmor_parser"
[    3.818121] audit: type=1400 audit(1639143146.899:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="lsb_release" pid=829 comm="apparmor_parser"
[    3.818511] audit: type=1400 audit(1639143146.899:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="nvidia_modprobe" pid=827 comm="apparmor_parser"
[    3.818514] audit: type=1400 audit(1639143146.899:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="nvidia_modprobe//kmod" pid=827 comm="apparmor_parser"
[    3.818946] audit: type=1400 audit(1639143146.899:6): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/sbin/cups-browsed" pid=831 comm="apparmor_parser"
[    3.818999] audit: type=1400 audit(1639143146.899:7): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/bin/man" pid=824 comm="apparmor_parser"
[    3.819002] audit: type=1400 audit(1639143146.899:8): apparmor="STATUS" operation="profile_load" profile="unconfined" name="man_filter" pid=824 comm="apparmor_parser"
[    3.819004] audit: type=1400 audit(1639143146.899:9): apparmor="STATUS" operation="profile_load" profile="unconfined" name="man_groff" pid=824 comm="apparmor_parser"
[    3.821081] audit: type=1400 audit(1639143146.903:10): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/sbin/tcpdump" pid=835 comm="apparmor_parser"
[    3.855333] intel_tcc_cooling: Programmable TCC Offset detected
[    3.858086] intel_rapl_msr: PL4 support detected.
[    3.858108] intel_rapl_common: Found RAPL domain package
[    3.858110] intel_rapl_common: Found RAPL domain core
[    3.896643] usb 1-10.4: New USB device found, idVendor=2109, idProduct=2813, bcdDevice=90.11
[    3.896645] usb 1-10.4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.896646] usb 1-10.4: Product: USB2.0 Hub
[    3.896647] usb 1-10.4: Manufacturer: VIA Labs, Inc.
[    3.899190] hub 1-10.4:1.0: USB hub found
[    3.899339] hub 1-10.4:1.0: 4 ports detected
[    4.028407] vboxdrv: Found 16 processor cores
[    4.047318] vboxdrv: TSC mode is Invariant, tentative frequency 3187199970 Hz
[    4.047319] vboxdrv: Successfully loaded version 6.1.30 r148432 (interface 0x00320000)
[    4.211096] usb 1-10.4.1: new high-speed USB device number 7 using xhci_hcd
[    4.267457] VBoxNetFlt: Successfully started.
[    4.268409] VBoxNetAdp: Successfully started.
[    4.342118] usb 1-10.4.1: New USB device found, idVendor=2109, idProduct=2813, bcdDevice=90.11
[    4.342120] usb 1-10.4.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    4.342121] usb 1-10.4.1: Product: USB2.0 Hub
[    4.342121] usb 1-10.4.1: Manufacturer: VIA Labs, Inc.
[    4.447680] hub 1-10.4.1:1.0: USB hub found
[    4.448438] hub 1-10.4.1:1.0: 4 ports detected
[    4.743320] snd_hda_intel 0000:00:1f.3: azx_get_response timeout, switching to polling mode: last cmd=0x000f0000
[    4.767136] usb 1-10.4.1.1: new high-speed USB device number 8 using xhci_hcd
[    4.892223] usb 1-10.4.1.1: New USB device found, idVendor=0bda, idProduct=5411, bcdDevice= 1.04
[    4.892226] usb 1-10.4.1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    4.892227] usb 1-10.4.1.1: Product: 4-Port USB 2.0 Hub
[    4.892228] usb 1-10.4.1.1: Manufacturer: Generic
[    4.945047] hub 1-10.4.1.1:1.0: USB hub found
[    4.945829] hub 1-10.4.1.1:1.0: 4 ports detected
[    5.235097] usb 1-10.4.1.1.1: new high-speed USB device number 9 using xhci_hcd
[    5.348224] usb 1-10.4.1.1.1: New USB device found, idVendor=0bda, idProduct=5411, bcdDevice= 1.04
[    5.348226] usb 1-10.4.1.1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    5.348227] usb 1-10.4.1.1.1: Product: 4-Port USB 2.0 Hub
[    5.348228] usb 1-10.4.1.1.1: Manufacturer: Generic
[    5.442682] hub 1-10.4.1.1.1:1.0: USB hub found
[    5.443303] hub 1-10.4.1.1.1:1.0: 4 ports detected
[    5.523323] usb 1-10.4.1.1.4: new full-speed USB device number 10 using xhci_hcd
[    5.625887] usb 1-10.4.1.1.4: New USB device found, idVendor=0dc6, idProduct=5000, bcdDevice= 1.00
[    5.625889] usb 1-10.4.1.1.4: New USB device strings: Mfr=0, Product=3, SerialNumber=0
[    5.625890] usb 1-10.4.1.1.4: Product: Generic USB Hub
[    5.735288] usb 1-10.4.1.1.1.4: new low-speed USB device number 11 using xhci_hcd
[    5.755144] snd_hda_intel 0000:00:1f.3: No response from codec, disabling MSI: last cmd=0x000f0000
[    5.777177] hub 1-10.4.1.1.4:1.0: USB hub found
[    5.777529] hub 1-10.4.1.1.4:1.0: 3 ports detected
[    5.868604] usb 1-10.4.1.1.1.4: New USB device found, idVendor=046d, idProduct=c215, bcdDevice= 2.04
[    5.868606] usb 1-10.4.1.1.1.4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    5.868607] usb 1-10.4.1.1.1.4: Product: Logitech Extreme 3D
[    5.868608] usb 1-10.4.1.1.1.4: Manufacturer: Logitech
[    5.992840] input: Logitech Logitech Extreme 3D as /devices/pci0000:00/0000:00:14.0/usb1/1-10/1-10.4/1-10.4.1/1-10.4.1.1/1-10.4.1.1.1/1-10.4.1.1.1.4/1-10.4.1.1.1.4:1.0/0003:046D:C215.0003/input/input5
[    5.992869] logitech 0003:046D:C215.0003: input,hidraw2: USB HID v1.10 Joystick [Logitech Logitech Extreme 3D] on usb-0000:00:14.0-10.4.1.1.1.4/input0
[    6.067135] usb 1-10.4.1.1.4.3: new full-speed USB device number 12 using xhci_hcd
[    6.077737] igc 0000:06:00.0 enp6s0: NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
[    6.170323] usb 1-10.4.1.1.4.3: config 1 has an invalid interface number: 1 but max is 0
[    6.170325] usb 1-10.4.1.1.4.3: config 1 has 2 interfaces, different from the descriptor's value: 1
[    6.171447] usb 1-10.4.1.1.4.3: New USB device found, idVendor=0dc6, idProduct=5300, bcdDevice= 1.00
[    6.171449] usb 1-10.4.1.1.4.3: New USB device strings: Mfr=0, Product=2, SerialNumber=0
[    6.171449] usb 1-10.4.1.1.4.3: Product: USB Keyboard + 2P Hub
[    6.282544] input: USB Keyboard + 2P Hub as /devices/pci0000:00/0000:00:14.0/usb1/1-10/1-10.4/1-10.4.1/1-10.4.1.1/1-10.4.1.1.4/1-10.4.1.1.4.3/1-10.4.1.1.4.3:1.0/0003:0DC6:5300.0004/input/input6
[    6.339559] hid-generic 0003:0DC6:5300.0004: input,hidraw3: USB HID v1.10 Keyboard [USB Keyboard + 2P Hub] on usb-0000:00:14.0-10.4.1.1.4.3/input0
[    6.341621] input: USB Keyboard + 2P Hub System Control as /devices/pci0000:00/0000:00:14.0/usb1/1-10/1-10.4/1-10.4.1/1-10.4.1.1/1-10.4.1.1.4/1-10.4.1.1.4.3/1-10.4.1.1.4.3:1.1/0003:0DC6:5300.0005/input/input7
[    6.399257] input: USB Keyboard + 2P Hub Consumer Control as /devices/pci0000:00/0000:00:14.0/usb1/1-10/1-10.4/1-10.4.1/1-10.4.1.1/1-10.4.1.1.4/1-10.4.1.1.4.3/1-10.4.1.1.4.3:1.1/0003:0DC6:5300.0005/input/input8
[    6.399417] hid-generic 0003:0DC6:5300.0005: input,hidraw4: USB HID v1.10 Device [USB Keyboard + 2P Hub] on usb-0000:00:14.0-10.4.1.1.4.3/input1
[    6.555094] usb 1-10.4.1.1.3: new full-speed USB device number 13 using xhci_hcd
[    6.659740] usb 1-10.4.1.1.3: New USB device found, idVendor=1532, idProduct=0101, bcdDevice=21.00
[    6.659742] usb 1-10.4.1.1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    6.659742] usb 1-10.4.1.1.3: Product: Razer Copperhead Laser Mouse
[    6.659743] usb 1-10.4.1.1.3: Manufacturer: Razer
[    6.715732] input: Razer Razer Copperhead Laser Mouse as /devices/pci0000:00/0000:00:14.0/usb1/1-10/1-10.4/1-10.4.1/1-10.4.1.1/1-10.4.1.1.3/1-10.4.1.1.3:1.0/0003:1532:0101.0006/input/input9
[    6.715941] hid-generic 0003:1532:0101.0006: input,hidraw5: USB HID v1.00 Mouse [Razer Razer Copperhead Laser Mouse] on usb-0000:00:14.0-10.4.1.1.3/input0
[    6.717334] input: Razer Razer Copperhead Laser Mouse as /devices/pci0000:00/0000:00:14.0/usb1/1-10/1-10.4/1-10.4.1/1-10.4.1.1/1-10.4.1.1.3/1-10.4.1.1.3:1.1/0003:1532:0101.0007/input/input10
[    6.759101] snd_hda_intel 0000:00:1f.3: Codec #0 probe error; disabling it...
[    6.775245] hid-generic 0003:1532:0101.0007: input,hidraw6: USB HID v0.01 Keyboard [Razer Razer Copperhead Laser Mouse] on usb-0000:00:14.0-10.4.1.1.3/input1
[    7.767140] snd_hda_intel 0000:00:1f.3: azx_get_response timeout, switching to single_cmd mode: last cmd=0x000f0000
[    7.767344] azx_single_wait_for_response: 17 callbacks suppressed
[    7.767653] hdaudio hdaudioC0D0: no AFG or MFG node found
[    7.767708] snd_hda_intel 0000:00:1f.3: no codecs initialized
[    8.040536] usbcore: registered new interface driver snd-usb-audio
[    8.158065] ACPI Warning: \_SB.PC00.PEG1.PEGP._DSM: Argument #4 type mismatch - Found [Buffer], ACPI requires [Package] (20210730/nsarguments-61)
[    8.345742] ACPI BIOS Error (bug): Failure creating named object [\_SB.PC00.PEG1.PEGP._DSM.USRG], AE_ALREADY_EXISTS (20210730/dsfield-184)
[    8.345746] ACPI Error: AE_ALREADY_EXISTS, CreateBufferField failure (20210730/dswload2-477)

[    8.345748] No Local Variables are initialized for Method [_DSM]

[    8.345749] Initialized Arguments for Method [_DSM]:  (4 arguments defined for method invocation)
[    8.345749]   Arg0:   0000000040eb9ac6 <Obj>           Buffer(16) 75 0B A5 D4 C7 65 F7 46
[    8.345753]   Arg1:   0000000065a19079 <Obj>           Integer 0000000000000102
[    8.345755]   Arg2:   00000000da7ca43e <Obj>           Integer 0000000000000010
[    8.345756]   Arg3:   000000009284f96b <Obj>           Buffer(4) 00 10 52 44

[    8.345758] ACPI Error: Aborting method \_SB.PC00.PEG1.PEGP._DSM due to previous error (AE_ALREADY_EXISTS) (20210730/psparse-529)
[    8.345877] ACPI BIOS Error (bug): Failure creating named object [\_SB.PC00.PEG1.PEGP._DSM.USRG], AE_ALREADY_EXISTS (20210730/dsfield-184)
[    8.345879] ACPI Error: AE_ALREADY_EXISTS, CreateBufferField failure (20210730/dswload2-477)

[    8.345880] No Local Variables are initialized for Method [_DSM]

[    8.345881] Initialized Arguments for Method [_DSM]:  (4 arguments defined for method invocation)
[    8.345881]   Arg0:   000000009284f96b <Obj>           Buffer(16) 75 0B A5 D4 C7 65 F7 46
[    8.345884]   Arg1:   00000000da7ca43e <Obj>           Integer 0000000000000102
[    8.345885]   Arg2:   0000000065a19079 <Obj>           Integer 0000000000000010
[    8.345886]   Arg3:   0000000040eb9ac6 <Obj>           Buffer(4) 00 20 52 44

[    8.345888] ACPI Error: Aborting method \_SB.PC00.PEG1.PEGP._DSM due to previous error (AE_ALREADY_EXISTS) (20210730/psparse-529)
[    8.346006] ACPI BIOS Error (bug): Failure creating named object [\_SB.PC00.PEG1.PEGP._DSM.USRG], AE_ALREADY_EXISTS (20210730/dsfield-184)
[    8.346007] ACPI Error: AE_ALREADY_EXISTS, CreateBufferField failure (20210730/dswload2-477)

[    8.346009] No Local Variables are initialized for Method [_DSM]

[    8.346009] Initialized Arguments for Method [_DSM]:  (4 arguments defined for method invocation)
[    8.346010]   Arg0:   0000000040eb9ac6 <Obj>           Buffer(16) 75 0B A5 D4 C7 65 F7 46
[    8.346012]   Arg1:   0000000065a19079 <Obj>           Integer 0000000000000102
[    8.346014]   Arg2:   00000000da7ca43e <Obj>           Integer 0000000000000010
[    8.346015]   Arg3:   000000009284f96b <Obj>           Buffer(4) 00 30 52 44

[    8.346017] ACPI Error: Aborting method \_SB.PC00.PEG1.PEGP._DSM due to previous error (AE_ALREADY_EXISTS) (20210730/psparse-529)
[    8.346134] ACPI BIOS Error (bug): Failure creating named object [\_SB.PC00.PEG1.PEGP._DSM.USRG], AE_ALREADY_EXISTS (20210730/dsfield-184)
[    8.346135] ACPI Error: AE_ALREADY_EXISTS, CreateBufferField failure (20210730/dswload2-477)

[    8.346137] No Local Variables are initialized for Method [_DSM]

[    8.346137] Initialized Arguments for Method [_DSM]:  (4 arguments defined for method invocation)
[    8.346137]   Arg0:   000000009284f96b <Obj>           Buffer(16) 75 0B A5 D4 C7 65 F7 46
[    8.346140]   Arg1:   00000000da7ca43e <Obj>           Integer 0000000000000102
[    8.346141]   Arg2:   0000000065a19079 <Obj>           Integer 0000000000000010
[    8.346142]   Arg3:   0000000040eb9ac6 <Obj>           Buffer(4) 00 40 52 44

[    8.346144] ACPI Error: Aborting method \_SB.PC00.PEG1.PEGP._DSM due to previous error (AE_ALREADY_EXISTS) (20210730/psparse-529)
[    8.346261] ACPI BIOS Error (bug): Failure creating named object [\_SB.PC00.PEG1.PEGP._DSM.USRG], AE_ALREADY_EXISTS (20210730/dsfield-184)
[    8.346263] ACPI Error: AE_ALREADY_EXISTS, CreateBufferField failure (20210730/dswload2-477)

[    8.346264] No Local Variables are initialized for Method [_DSM]

[    8.346265] Initialized Arguments for Method [_DSM]:  (4 arguments defined for method invocation)
[    8.346265]   Arg0:   0000000040eb9ac6 <Obj>           Buffer(16) 75 0B A5 D4 C7 65 F7 46
[    8.346267]   Arg1:   0000000065a19079 <Obj>           Integer 0000000000000102
[    8.346268]   Arg2:   00000000da7ca43e <Obj>           Integer 0000000000000010
[    8.346270]   Arg3:   000000009284f96b <Obj>           Buffer(4) 00 50 52 44

[    8.346272] ACPI Error: Aborting method \_SB.PC00.PEG1.PEGP._DSM due to previous error (AE_ALREADY_EXISTS) (20210730/psparse-529)
[    8.346389] ACPI BIOS Error (bug): Failure creating named object [\_SB.PC00.PEG1.PEGP._DSM.USRG], AE_ALREADY_EXISTS (20210730/dsfield-184)
[    8.346390] ACPI Error: AE_ALREADY_EXISTS, CreateBufferField failure (20210730/dswload2-477)

[    8.346391] No Local Variables are initialized for Method [_DSM]

[    8.346392] Initialized Arguments for Method [_DSM]:  (4 arguments defined for method invocation)
[    8.346392]   Arg0:   000000009284f96b <Obj>           Buffer(16) 75 0B A5 D4 C7 65 F7 46
[    8.346395]   Arg1:   00000000da7ca43e <Obj>           Integer 0000000000000102
[    8.346396]   Arg2:   0000000065a19079 <Obj>           Integer 0000000000000010
[    8.346397]   Arg3:   0000000040eb9ac6 <Obj>           Buffer(4) 00 60 52 44

[    8.346399] ACPI Error: Aborting method \_SB.PC00.PEG1.PEGP._DSM due to previous error (AE_ALREADY_EXISTS) (20210730/psparse-529)
[    8.346516] ACPI BIOS Error (bug): Failure creating named object [\_SB.PC00.PEG1.PEGP._DSM.USRG], AE_ALREADY_EXISTS (20210730/dsfield-184)
[    8.346517] ACPI Error: AE_ALREADY_EXISTS, CreateBufferField failure (20210730/dswload2-477)

[    8.346519] No Local Variables are initialized for Method [_DSM]

[    8.346519] Initialized Arguments for Method [_DSM]:  (4 arguments defined for method invocation)
[    8.346520]   Arg0:   0000000040eb9ac6 <Obj>           Buffer(16) 75 0B A5 D4 C7 65 F7 46
[    8.346522]   Arg1:   0000000065a19079 <Obj>           Integer 0000000000000102
[    8.346523]   Arg2:   00000000da7ca43e <Obj>           Integer 0000000000000010
[    8.346524]   Arg3:   000000009284f96b <Obj>           Buffer(4) 00 70 52 44

[    8.346527] ACPI Error: Aborting method \_SB.PC00.PEG1.PEGP._DSM due to previous error (AE_ALREADY_EXISTS) (20210730/psparse-529)
[    8.346643] ACPI BIOS Error (bug): Failure creating named object [\_SB.PC00.PEG1.PEGP._DSM.USRG], AE_ALREADY_EXISTS (20210730/dsfield-184)
[    8.346644] ACPI Error: AE_ALREADY_EXISTS, CreateBufferField failure (20210730/dswload2-477)

[    8.346646] No Local Variables are initialized for Method [_DSM]

[    8.346646] Initialized Arguments for Method [_DSM]:  (4 arguments defined for method invocation)
[    8.346647]   Arg0:   000000009284f96b <Obj>           Buffer(16) 75 0B A5 D4 C7 65 F7 46
[    8.346649]   Arg1:   00000000da7ca43e <Obj>           Integer 0000000000000102
[    8.346650]   Arg2:   0000000065a19079 <Obj>           Integer 0000000000000010
[    8.346651]   Arg3:   0000000040eb9ac6 <Obj>           Buffer(4) 00 80 52 44

[    8.346654] ACPI Error: Aborting method \_SB.PC00.PEG1.PEGP._DSM due to previous error (AE_ALREADY_EXISTS) (20210730/psparse-529)
[    8.346770] ACPI BIOS Error (bug): Failure creating named object [\_SB.PC00.PEG1.PEGP._DSM.USRG], AE_ALREADY_EXISTS (20210730/dsfield-184)
[    8.346772] ACPI Error: AE_ALREADY_EXISTS, CreateBufferField failure (20210730/dswload2-477)

[    8.346773] No Local Variables are initialized for Method [_DSM]

[    8.346773] Initialized Arguments for Method [_DSM]:  (4 arguments defined for method invocation)
[    8.346774]   Arg0:   0000000040eb9ac6 <Obj>           Buffer(16) 75 0B A5 D4 C7 65 F7 46
[    8.346776]   Arg1:   0000000065a19079 <Obj>           Integer 0000000000000102
[    8.346777]   Arg2:   00000000da7ca43e <Obj>           Integer 0000000000000010
[    8.346779]   Arg3:   000000009284f96b <Obj>           Buffer(4) 00 90 52 44

[    8.346781] ACPI Error: Aborting method \_SB.PC00.PEG1.PEGP._DSM due to previous error (AE_ALREADY_EXISTS) (20210730/psparse-529)
[    8.346898] ACPI BIOS Error (bug): Failure creating named object [\_SB.PC00.PEG1.PEGP._DSM.USRG], AE_ALREADY_EXISTS (20210730/dsfield-184)
[    8.346899] ACPI Error: AE_ALREADY_EXISTS, CreateBufferField failure (20210730/dswload2-477)

[    8.346901] No Local Variables are initialized for Method [_DSM]

[    8.346901] Initialized Arguments for Method [_DSM]:  (4 arguments defined for method invocation)
[    8.346902]   Arg0:   000000009284f96b <Obj>           Buffer(16) 75 0B A5 D4 C7 65 F7 46
[    8.346904]   Arg1:   00000000da7ca43e <Obj>           Integer 0000000000000102
[    8.346905]   Arg2:   0000000065a19079 <Obj>           Integer 0000000000000010
[    8.346906]   Arg3:   0000000040eb9ac6 <Obj>           Buffer(4) 00 A0 52 44

[    8.346908] ACPI Error: Aborting method \_SB.PC00.PEG1.PEGP._DSM due to previous error (AE_ALREADY_EXISTS) (20210730/psparse-529)
[    8.347025] ACPI BIOS Error (bug): Failure creating named object [\_SB.PC00.PEG1.PEGP._DSM.USRG], AE_ALREADY_EXISTS (20210730/dsfield-184)
[    8.347027] ACPI Error: AE_ALREADY_EXISTS, CreateBufferField failure (20210730/dswload2-477)

[    8.347028] No Local Variables are initialized for Method [_DSM]

[    8.347029] Initialized Arguments for Method [_DSM]:  (4 arguments defined for method invocation)
[    8.347029]   Arg0:   0000000040eb9ac6 <Obj>           Buffer(16) 75 0B A5 D4 C7 65 F7 46
[    8.347031]   Arg1:   0000000065a19079 <Obj>           Integer 0000000000000102
[    8.347032]   Arg2:   00000000da7ca43e <Obj>           Integer 0000000000000010
[    8.347034]   Arg3:   000000009284f96b <Obj>           Buffer(4) 00 B0 52 44

[    8.347036] ACPI Error: Aborting method \_SB.PC00.PEG1.PEGP._DSM due to previous error (AE_ALREADY_EXISTS) (20210730/psparse-529)
[    8.347162] ACPI BIOS Error (bug): Failure creating named object [\_SB.PC00.PEG1.PEGP._DSM.USRG], AE_ALREADY_EXISTS (20210730/dsfield-184)
[    8.347163] ACPI Error: AE_ALREADY_EXISTS, CreateBufferField failure (20210730/dswload2-477)

[    8.347165] No Local Variables are initialized for Method [_DSM]

[    8.347165] Initialized Arguments for Method [_DSM]:  (4 arguments defined for method invocation)
[    8.347166]   Arg0:   000000009284f96b <Obj>           Buffer(16) 75 0B A5 D4 C7 65 F7 46
[    8.347170]   Arg1:   00000000da7ca43e <Obj>           Integer 0000000000000102
[    8.347171]   Arg2:   0000000065a19079 <Obj>           Integer 0000000000000010
[    8.347172]   Arg3:   0000000040eb9ac6 <Obj>           Buffer(4) 00 C0 52 44

[    8.347174] ACPI Error: Aborting method \_SB.PC00.PEG1.PEGP._DSM due to previous error (AE_ALREADY_EXISTS) (20210730/psparse-529)
[    8.347321] ACPI BIOS Error (bug): Failure creating named object [\_SB.PC00.PEG1.PEGP._DSM.USRG], AE_ALREADY_EXISTS (20210730/dsfield-184)
[    8.347324] ACPI Error: AE_ALREADY_EXISTS, CreateBufferField failure (20210730/dswload2-477)

[    8.347326] No Local Variables are initialized for Method [_DSM]

[    8.347327] Initialized Arguments for Method [_DSM]:  (4 arguments defined for method invocation)
[    8.347327]   Arg0:   0000000040eb9ac6 <Obj>           Buffer(16) 75 0B A5 D4 C7 65 F7 46
[    8.347330]   Arg1:   0000000065a19079 <Obj>           Integer 0000000000000102
[    8.347332]   Arg2:   00000000da7ca43e <Obj>           Integer 0000000000000010
[    8.347333]   Arg3:   000000009284f96b <Obj>           Buffer(4) 00 D0 52 44

[    8.347336] ACPI Error: Aborting method \_SB.PC00.PEG1.PEGP._DSM due to previous error (AE_ALREADY_EXISTS) (20210730/psparse-529)
[    8.347462] ACPI BIOS Error (bug): Failure creating named object [\_SB.PC00.PEG1.PEGP._DSM.USRG], AE_ALREADY_EXISTS (20210730/dsfield-184)
[    8.347463] ACPI Error: AE_ALREADY_EXISTS, CreateBufferField failure (20210730/dswload2-477)

[    8.347465] No Local Variables are initialized for Method [_DSM]

[    8.347465] Initialized Arguments for Method [_DSM]:  (4 arguments defined for method invocation)
[    8.347466]   Arg0:   00000000ab3473d4 <Obj>           Buffer(16) 75 0B A5 D4 C7 65 F7 46
[    8.347468]   Arg1:   000000001a905805 <Obj>           Integer 0000000000000102
[    8.347469]   Arg2:   00000000e53186c0 <Obj>           Integer 0000000000000010
[    8.347471]   Arg3:   00000000582e50dd <Obj>           Buffer(4) 00 E0 52 44

[    8.347473] ACPI Error: Aborting method \_SB.PC00.PEG1.PEGP._DSM due to previous error (AE_ALREADY_EXISTS) (20210730/psparse-529)
[    8.347591] ACPI BIOS Error (bug): Failure creating named object [\_SB.PC00.PEG1.PEGP._DSM.USRG], AE_ALREADY_EXISTS (20210730/dsfield-184)
[    8.347593] ACPI Error: AE_ALREADY_EXISTS, CreateBufferField failure (20210730/dswload2-477)

[    8.347594] No Local Variables are initialized for Method [_DSM]

[    8.347595] Initialized Arguments for Method [_DSM]:  (4 arguments defined for method invocation)
[    8.347595]   Arg0:   00000000582e50dd <Obj>           Buffer(16) 75 0B A5 D4 C7 65 F7 46
[    8.347598]   Arg1:   00000000e53186c0 <Obj>           Integer 0000000000000102
[    8.347599]   Arg2:   000000001a905805 <Obj>           Integer 0000000000000010
[    8.347600]   Arg3:   00000000ab3473d4 <Obj>           Buffer(4) 00 F0 52 44

[    8.347602] ACPI Error: Aborting method \_SB.PC00.PEG1.PEGP._DSM due to previous error (AE_ALREADY_EXISTS) (20210730/psparse-529)
[    8.539821] [UFW BLOCK] IN= OUT=enp6s0 SRC=192.168.0.40 DST=192.168.0.1 LEN=84 TOS=0x00 PREC=0x00 TTL=64 ID=12297 DF PROTO=ICMP TYPE=8 CODE=0 ID=1 SEQ=1 
[    8.911629] ACPI BIOS Error (bug): Failure creating named object [\_SB.PC00.PEG1.PEGP._DSM.USRG], AE_ALREADY_EXISTS (20210730/dsfield-184)
[    8.911650] ACPI Error: AE_ALREADY_EXISTS, CreateBufferField failure (20210730/dswload2-477)

[    8.911663] No Local Variables are initialized for Method [_DSM]

[    8.911668] Initialized Arguments for Method [_DSM]:  (4 arguments defined for method invocation)
[    8.911670]   Arg0:   000000001a905805 <Obj>           Buffer(16) 75 0B A5 D4 C7 65 F7 46
[    8.911690]   Arg1:   00000000ab3473d4 <Obj>           Integer 0000000000000102
[    8.911698]   Arg2:   0000000051a83ebb <Obj>           Integer 0000000000000010
[    8.911706]   Arg3:   000000002b0c866d <Obj>           Buffer(4) 00 00 4B 56

[    8.911721] ACPI Error: Aborting method \_SB.PC00.PEG1.PEGP._DSM due to previous error (AE_ALREADY_EXISTS) (20210730/psparse-529)
[    8.912824] ACPI BIOS Error (bug): Failure creating named object [\_SB.PC00.PEG1.PEGP._DSM.USRG], AE_ALREADY_EXISTS (20210730/dsfield-184)
[    8.912841] ACPI Error: AE_ALREADY_EXISTS, CreateBufferField failure (20210730/dswload2-477)

[    8.912857] No Local Variables are initialized for Method [_DSM]

[    8.912864] Initialized Arguments for Method [_DSM]:  (4 arguments defined for method invocation)
[    8.912867]   Arg0:   000000002b0c866d <Obj>           Buffer(16) 75 0B A5 D4 C7 65 F7 46
[    8.912896]   Arg1:   0000000051a83ebb <Obj>           Integer 0000000000000102
[    8.912909]   Arg2:   00000000ab3473d4 <Obj>           Integer 0000000000000010
[    8.912922]   Arg3:   000000001a905805 <Obj>           Buffer(4) 00 00 50 4F

[    8.912947] ACPI Error: Aborting method \_SB.PC00.PEG1.PEGP._DSM due to previous error (AE_ALREADY_EXISTS) (20210730/psparse-529)
-------------- next part --------------
[    0.000000] Linux version 5.15.7 (root at computer) (gcc (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0, GNU ld (GNU Binutils for Ubuntu) 2.34) #1 SMP Fri Dec 10 13:41:46 CET 2021
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-5.15.7 root=UUID=f1d17af1-b114-4204-be05-fb71851a14ff ro noresume
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Hygon HygonGenuine
[    0.000000]   Centaur CentaurHauls
[    0.000000]   zhaoxin   Shanghai  
[    0.000000] x86/split lock detection: #AC: crashing the kernel on kernel split_locks and warning on user-space split_locks
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x020: 'AVX-512 opmask'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x040: 'AVX-512 Hi256'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x080: 'AVX-512 ZMM_Hi256'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: xstate_offset[5]:  832, xstate_sizes[5]:   64
[    0.000000] x86/fpu: xstate_offset[6]:  896, xstate_sizes[6]:  512
[    0.000000] x86/fpu: xstate_offset[7]: 1408, xstate_sizes[7]: 1024
[    0.000000] x86/fpu: xstate_offset[9]: 2432, xstate_sizes[9]:    8
[    0.000000] x86/fpu: Enabled xstate features 0x2e7, context size is 2440 bytes, using 'compacted' format.
[    0.000000] signal: max sigframe size: 3632
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009dbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009dc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000063e45fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000063e46000-0x0000000063e46fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000063e47000-0x0000000063e9bfff] usable
[    0.000000] BIOS-e820: [mem 0x0000000063e9c000-0x0000000063e9cfff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000063e9d000-0x000000007407dfff] usable
[    0.000000] BIOS-e820: [mem 0x000000007407e000-0x0000000077d7dfff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000077d7e000-0x0000000078140fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x0000000078141000-0x000000007871efff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000007871f000-0x0000000079ffefff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000079fff000-0x0000000079ffffff] usable
[    0.000000] BIOS-e820: [mem 0x000000007a000000-0x000000007dffffff] reserved
[    0.000000] BIOS-e820: [mem 0x000000007ee00000-0x000000007fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000c0000000-0x00000000cfffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed20000-0x00000000fed7ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000087fffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 3.4.0 present.
[    0.000000] DMI: ASUS System Product Name/ROG STRIX Z690-A GAMING WIFI D4, BIOS 0707 11/10/2021
[    0.000000] tsc: Detected 3200.000 MHz processor
[    0.000000] tsc: Detected 3187.200 MHz TSC
[    0.000267] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000269] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000272] last_pfn = 0x880000 max_arch_pfn = 0x400000000
[    0.000367] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.001275] total RAM covered: 63488M
[    0.001329] Found optimal setting for mtrr clean up
[    0.001329]  gran_size: 64K 	chunk_size: 64K 	num_reg: 5  	lose cover RAM: 0G
[    0.001579] e820: update [mem 0x80000000-0xffffffff] usable ==> reserved
[    0.001581] last_pfn = 0x7a000 max_arch_pfn = 0x400000000
[    0.004489] found SMP MP-table at [mem 0x000fcf30-0x000fcf3f]
[    0.004494] Using GB pages for direct mapping
[    0.004636] RAMDISK: [mem 0x26377000-0x2f1b2fff]
[    0.004638] ACPI: Early table checksum verification disabled
[    0.004639] ACPI: RSDP 0x00000000000F05B0 000024 (v02 ALASKA)
[    0.004642] ACPI: XSDT 0x000000007813F728 00010C (v01 ALASKA A M I    01072009 AMI  01000013)
[    0.004645] ACPI: FACP 0x000000007813D000 000114 (v06 ALASKA A M I    01072009 AMI  01000013)
[    0.004647] ACPI: DSDT 0x00000000780C8000 074735 (v02 ALASKA A M I    01072009 INTL 20200717)
[    0.004649] ACPI: FACS 0x000000007871E000 000040
[    0.004651] ACPI: MCFG 0x000000007813E000 00003C (v01 ALASKA A M I    01072009 MSFT 00000097)
[    0.004652] ACPI: FIDT 0x00000000780C7000 00009C (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.004654] ACPI: WSMT 0x00000000780AF000 000028 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.004656] ACPI: SSDT 0x00000000780C5000 00038C (v02 PmaxDv Pmax_Dev 00000001 INTL 20200717)
[    0.004657] ACPI: SSDT 0x00000000780BF000 005D01 (v02 CpuRef CpuSsdt  00003000 INTL 20200717)
[    0.004659] ACPI: SSDT 0x00000000780BC000 002A95 (v02 SaSsdt SaSsdt   00003000 INTL 20200717)
[    0.004661] ACPI: SSDT 0x00000000780B8000 003316 (v02 INTEL  IgfxSsdt 00003000 INTL 20200717)
[    0.004662] ACPI: HPET 0x00000000780B7000 000038 (v01 ALASKA A M I    01072009 AMI  01000013)
[    0.004664] ACPI: APIC 0x00000000780B6000 0001DC (v05 ALASKA A M I    01072009 AMI  01000013)
[    0.004666] ACPI: MCFG 0x00000000780B5000 00003C (v01 ALASKA A M I    01072009 AMI  01000013)
[    0.004667] ACPI: SSDT 0x00000000780B3000 001F1A (v02 ALASKA Ther_Rvp 00001000 INTL 20200717)
[    0.004669] ACPI: NHLT 0x00000000780B1000 00002D (v00 ALASKA A M I    01072009 AMI  01000013)
[    0.004670] ACPI: LPIT 0x00000000780B0000 0000CC (v01 ALASKA A M I    01072009 AMI  01000013)
[    0.004672] ACPI: SSDT 0x00000000780AC000 002357 (v02 ALASKA TbtTypeC 00000000 INTL 20200717)
[    0.004674] ACPI: SSDT 0x00000000780A9000 002A83 (v02 ALASKA PtidDevc 00001000 INTL 20200717)
[    0.004675] ACPI: DBGP 0x00000000780A8000 000034 (v01 ALASKA A M I    01072009 AMI  01000013)
[    0.004677] ACPI: DBG2 0x00000000780A7000 000054 (v00 ALASKA A M I    01072009 AMI  01000013)
[    0.004678] ACPI: SSDT 0x00000000780A6000 000C1F (v02 ALASKA UsbCTabl 00001000 INTL 20200717)
[    0.004680] ACPI: DMAR 0x00000000780A5000 000050 (v02 INTEL  EDK2     00000002      01000013)
[    0.004682] ACPI: SSDT 0x00000000780A3000 001E67 (v02 INTEL  xh_adls3 00000000 INTL 20200717)
[    0.004683] ACPI: SSDT 0x000000007809F000 003AEA (v02 SocGpe SocGpe   00003000 INTL 20200717)
[    0.004685] ACPI: SSDT 0x000000007809C000 002B2A (v02 SocCmn SocCmn   00003000 INTL 20200717)
[    0.004687] ACPI: SSDT 0x000000007809B000 000144 (v02 Intel  ADebTabl 00001000 INTL 20200717)
[    0.004688] ACPI: UEFI 0x00000000782DE000 00063A (v01 INTEL  RstVmdE  00000000 INTL 00000000)
[    0.004690] ACPI: UEFI 0x00000000782DD000 00005C (v01 INTEL  RstVmdV  00000000 INTL 00000000)
[    0.004692] ACPI: WPBT 0x0000000077F6D000 000040 (v01 ALASKA A M I    00000001 ASUS 00000001)
[    0.004693] ACPI: PHAT 0x0000000077F6C000 0005ED (v00 ALASKA A M I    00000005 MSFT 0100000D)
[    0.004695] ACPI: FPDT 0x0000000077F6B000 000044 (v01 ALASKA A M I    01072009 AMI  01000013)
[    0.004696] ACPI: Reserving FACP table memory at [mem 0x7813d000-0x7813d113]
[    0.004697] ACPI: Reserving DSDT table memory at [mem 0x780c8000-0x7813c734]
[    0.004698] ACPI: Reserving FACS table memory at [mem 0x7871e000-0x7871e03f]
[    0.004698] ACPI: Reserving MCFG table memory at [mem 0x7813e000-0x7813e03b]
[    0.004699] ACPI: Reserving FIDT table memory at [mem 0x780c7000-0x780c709b]
[    0.004699] ACPI: Reserving WSMT table memory at [mem 0x780af000-0x780af027]
[    0.004700] ACPI: Reserving SSDT table memory at [mem 0x780c5000-0x780c538b]
[    0.004701] ACPI: Reserving SSDT table memory at [mem 0x780bf000-0x780c4d00]
[    0.004701] ACPI: Reserving SSDT table memory at [mem 0x780bc000-0x780bea94]
[    0.004702] ACPI: Reserving SSDT table memory at [mem 0x780b8000-0x780bb315]
[    0.004702] ACPI: Reserving HPET table memory at [mem 0x780b7000-0x780b7037]
[    0.004703] ACPI: Reserving APIC table memory at [mem 0x780b6000-0x780b61db]
[    0.004703] ACPI: Reserving MCFG table memory at [mem 0x780b5000-0x780b503b]
[    0.004704] ACPI: Reserving SSDT table memory at [mem 0x780b3000-0x780b4f19]
[    0.004704] ACPI: Reserving NHLT table memory at [mem 0x780b1000-0x780b102c]
[    0.004705] ACPI: Reserving LPIT table memory at [mem 0x780b0000-0x780b00cb]
[    0.004706] ACPI: Reserving SSDT table memory at [mem 0x780ac000-0x780ae356]
[    0.004706] ACPI: Reserving SSDT table memory at [mem 0x780a9000-0x780aba82]
[    0.004707] ACPI: Reserving DBGP table memory at [mem 0x780a8000-0x780a8033]
[    0.004707] ACPI: Reserving DBG2 table memory at [mem 0x780a7000-0x780a7053]
[    0.004708] ACPI: Reserving SSDT table memory at [mem 0x780a6000-0x780a6c1e]
[    0.004708] ACPI: Reserving DMAR table memory at [mem 0x780a5000-0x780a504f]
[    0.004709] ACPI: Reserving SSDT table memory at [mem 0x780a3000-0x780a4e66]
[    0.004709] ACPI: Reserving SSDT table memory at [mem 0x7809f000-0x780a2ae9]
[    0.004710] ACPI: Reserving SSDT table memory at [mem 0x7809c000-0x7809eb29]
[    0.004711] ACPI: Reserving SSDT table memory at [mem 0x7809b000-0x7809b143]
[    0.004711] ACPI: Reserving UEFI table memory at [mem 0x782de000-0x782de639]
[    0.004712] ACPI: Reserving UEFI table memory at [mem 0x782dd000-0x782dd05b]
[    0.004712] ACPI: Reserving WPBT table memory at [mem 0x77f6d000-0x77f6d03f]
[    0.004713] ACPI: Reserving PHAT table memory at [mem 0x77f6c000-0x77f6c5ec]
[    0.004714] ACPI: Reserving FPDT table memory at [mem 0x77f6b000-0x77f6b043]
[    0.004834] No NUMA configuration found
[    0.004834] Faking a node at [mem 0x0000000000000000-0x000000087fffffff]
[    0.004838] NODE_DATA(0) allocated [mem 0x87ffd6000-0x87fffffff]
[    0.004969] Zone ranges:
[    0.004969]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.004970]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.004971]   Normal   [mem 0x0000000100000000-0x000000087fffffff]
[    0.004972]   Device   empty
[    0.004972] Movable zone start for each node
[    0.004973] Early memory node ranges
[    0.004974]   node   0: [mem 0x0000000000001000-0x000000000009cfff]
[    0.004974]   node   0: [mem 0x0000000000100000-0x0000000063e45fff]
[    0.004975]   node   0: [mem 0x0000000063e47000-0x0000000063e9bfff]
[    0.004975]   node   0: [mem 0x0000000063e9d000-0x000000007407dfff]
[    0.004976]   node   0: [mem 0x0000000079fff000-0x0000000079ffffff]
[    0.004976]   node   0: [mem 0x0000000100000000-0x000000087fffffff]
[    0.004978] Initmem setup node 0 [mem 0x0000000000001000-0x000000087fffffff]
[    0.004979] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.004990] On node 0, zone DMA: 99 pages in unavailable ranges
[    0.006199] On node 0, zone DMA32: 1 pages in unavailable ranges
[    0.006396] On node 0, zone DMA32: 1 pages in unavailable ranges
[    0.006489] On node 0, zone DMA32: 24449 pages in unavailable ranges
[    0.030139] On node 0, zone Normal: 24576 pages in unavailable ranges
[    0.030405] ACPI: PM-Timer IO Port: 0x1808
[    0.030409] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.030410] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.030410] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.030410] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.030411] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.030411] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.030412] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.030412] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.030413] ACPI: LAPIC_NMI (acpi_id[0x09] high edge lint[0x1])
[    0.030413] ACPI: LAPIC_NMI (acpi_id[0x0a] high edge lint[0x1])
[    0.030413] ACPI: LAPIC_NMI (acpi_id[0x0b] high edge lint[0x1])
[    0.030414] ACPI: LAPIC_NMI (acpi_id[0x0c] high edge lint[0x1])
[    0.030414] ACPI: LAPIC_NMI (acpi_id[0x0d] high edge lint[0x1])
[    0.030415] ACPI: LAPIC_NMI (acpi_id[0x0e] high edge lint[0x1])
[    0.030415] ACPI: LAPIC_NMI (acpi_id[0x0f] high edge lint[0x1])
[    0.030415] ACPI: LAPIC_NMI (acpi_id[0x10] high edge lint[0x1])
[    0.030416] ACPI: LAPIC_NMI (acpi_id[0x11] high edge lint[0x1])
[    0.030416] ACPI: LAPIC_NMI (acpi_id[0x12] high edge lint[0x1])
[    0.030417] ACPI: LAPIC_NMI (acpi_id[0x13] high edge lint[0x1])
[    0.030417] ACPI: LAPIC_NMI (acpi_id[0x14] high edge lint[0x1])
[    0.030417] ACPI: LAPIC_NMI (acpi_id[0x15] high edge lint[0x1])
[    0.030418] ACPI: LAPIC_NMI (acpi_id[0x16] high edge lint[0x1])
[    0.030418] ACPI: LAPIC_NMI (acpi_id[0x17] high edge lint[0x1])
[    0.030419] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.030441] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
[    0.030442] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.030443] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.030445] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.030446] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.030447] TSC deadline timer available
[    0.030448] smpboot: Allowing 16 CPUs, 0 hotplug CPUs
[    0.030457] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.030459] PM: hibernation: Registered nosave memory: [mem 0x0009d000-0x0009dfff]
[    0.030459] PM: hibernation: Registered nosave memory: [mem 0x0009e000-0x0009ffff]
[    0.030459] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000dffff]
[    0.030460] PM: hibernation: Registered nosave memory: [mem 0x000e0000-0x000fffff]
[    0.030461] PM: hibernation: Registered nosave memory: [mem 0x63e46000-0x63e46fff]
[    0.030461] PM: hibernation: Registered nosave memory: [mem 0x63e9c000-0x63e9cfff]
[    0.030462] PM: hibernation: Registered nosave memory: [mem 0x7407e000-0x77d7dfff]
[    0.030463] PM: hibernation: Registered nosave memory: [mem 0x77d7e000-0x78140fff]
[    0.030463] PM: hibernation: Registered nosave memory: [mem 0x78141000-0x7871efff]
[    0.030464] PM: hibernation: Registered nosave memory: [mem 0x7871f000-0x79ffefff]
[    0.030464] PM: hibernation: Registered nosave memory: [mem 0x7a000000-0x7dffffff]
[    0.030465] PM: hibernation: Registered nosave memory: [mem 0x7e000000-0x7edfffff]
[    0.030465] PM: hibernation: Registered nosave memory: [mem 0x7ee00000-0x7fffffff]
[    0.030466] PM: hibernation: Registered nosave memory: [mem 0x80000000-0xbfffffff]
[    0.030466] PM: hibernation: Registered nosave memory: [mem 0xc0000000-0xcfffffff]
[    0.030466] PM: hibernation: Registered nosave memory: [mem 0xd0000000-0xfdffffff]
[    0.030467] PM: hibernation: Registered nosave memory: [mem 0xfe000000-0xfe010fff]
[    0.030467] PM: hibernation: Registered nosave memory: [mem 0xfe011000-0xfebfffff]
[    0.030468] PM: hibernation: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
[    0.030468] PM: hibernation: Registered nosave memory: [mem 0xfec01000-0xfecfffff]
[    0.030468] PM: hibernation: Registered nosave memory: [mem 0xfed00000-0xfed00fff]
[    0.030469] PM: hibernation: Registered nosave memory: [mem 0xfed01000-0xfed1ffff]
[    0.030469] PM: hibernation: Registered nosave memory: [mem 0xfed20000-0xfed7ffff]
[    0.030470] PM: hibernation: Registered nosave memory: [mem 0xfed80000-0xfedfffff]
[    0.030470] PM: hibernation: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
[    0.030470] PM: hibernation: Registered nosave memory: [mem 0xfee01000-0xfeffffff]
[    0.030471] PM: hibernation: Registered nosave memory: [mem 0xff000000-0xffffffff]
[    0.030472] [mem 0x80000000-0xbfffffff] available for PCI devices
[    0.030472] Booting paravirtualized kernel on bare hardware
[    0.030473] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.030476] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:16 nr_cpu_ids:16 nr_node_ids:1
[    0.030756] percpu: Embedded 61 pages/cpu s212992 r8192 d28672 u262144
[    0.030759] pcpu-alloc: s212992 r8192 d28672 u262144 alloc=1*2097152
[    0.030760] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 12 13 14 15 
[    0.030775] Built 1 zonelists, mobility grouping on.  Total pages: 8209019
[    0.030776] Policy zone: Normal
[    0.030777] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-5.15.7 root=UUID=f1d17af1-b114-4204-be05-fb71851a14ff ro noresume
[    0.030805] Unknown kernel command line parameters "BOOT_IMAGE=/boot/vmlinuz-5.15.7", will be passed to user space.
[    0.032076] Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes, linear)
[    0.032747] Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
[    0.032809] mem auto-init: stack:off, heap alloc:on, heap free:off
[    0.069972] Memory: 32526476K/33357924K available (14345K kernel code, 3533K rwdata, 10468K rodata, 2904K init, 5704K bss, 831188K reserved, 0K cma-reserved)
[    0.069974] random: get_random_u64 called from __kmem_cache_create+0x2d/0x450 with crng_init=0
[    0.070049] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=16, Nodes=1
[    0.070055] ftrace: allocating 49244 entries in 193 pages
[    0.076638] ftrace: allocated 193 pages with 3 groups
[    0.076693] rcu: Hierarchical RCU implementation.
[    0.076694] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=16.
[    0.076695] 	Rude variant of Tasks RCU enabled.
[    0.076695] 	Tracing variant of Tasks RCU enabled.
[    0.076696] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.076696] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=16
[    0.078280] NR_IRQS: 524544, nr_irqs: 2184, preallocated irqs: 16
[    0.078539] random: crng done (trusting CPU's manufacturer)
[    0.081930] Console: colour VGA+ 80x25
[    0.095089] printk: console [tty0] enabled
[    0.095150] ACPI: Core revision 20210730
[    0.095398] hpet: HPET dysfunctional in PC10. Force disabled.
[    0.095455] APIC: Switch to symmetric I/O mode setup
[    0.095508] DMAR: Host address width 39
[    0.095561] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.095616] DMAR: dmar0: reg_base_addr fed91000 ver 5:0 cap d2008c40660462 ecap f050da
[    0.095672] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 0
[    0.095725] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    0.095778] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
[    0.096551] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    0.096605] x2apic enabled
[    0.096663] Switched APIC routing to cluster x2apic.
[    0.098876] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x2df10e7656b, max_idle_ns: 440795364873 ns
[    0.098938] Calibrating delay loop (skipped), value calculated using timer frequency.. 6374.40 BogoMIPS (lpj=12748800)
[    0.098996] pid_max: default: 32768 minimum: 301
[    0.099064] LSM: Security Framework initializing
[    0.099128] Yama: becoming mindful.
[    0.099190] AppArmor: AppArmor initialized
[    0.099288] Mount-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.099369] Mountpoint-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.099557] x86/tme: not enabled by BIOS
[    0.099617] CPU0: Thermal monitoring enabled (TM1)
[    0.099670] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.099811] process: using mwait in idle threads
[    0.099869] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.099922] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.099976] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.100032] Spectre V2 : Mitigation: Enhanced IBRS
[    0.100084] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.100138] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.100194] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl and seccomp
[    0.102556] Freeing SMP alternatives memory: 40K
[    0.102937] smpboot: Estimated ratio of average max frequency by base frequency (times 1024): 1760
[    0.102937] smpboot: CPU0: 12th Gen Intel(R) Core(TM) i9-12900K (family: 0x6, model: 0x97, stepping: 0x2)
[    0.102937] Performance Events: XSAVE Architectural LBR, PEBS fmt4+-baseline,  AnyThread deprecated, Alderlake Hybrid events, 32-deep LBR, full-width counters, 
[    0.102937] ------------[ cut here ]------------
[    0.102937] hw perf events fixed 5 > max(4), clipping!
[    0.102937] WARNING: CPU: 0 PID: 1 at arch/x86/events/intel/core.c:5411 intel_pmu_check_num_counters+0x68/0x82
[    0.102937] Modules linked in:
[    0.102937] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.15.7 #1
[    0.102937] Hardware name: ASUS System Product Name/ROG STRIX Z690-A GAMING WIFI D4, BIOS 0707 11/10/2021
[    0.102937] RIP: 0010:intel_pmu_check_num_counters+0x68/0x82
[    0.102937] Code: 8b 0e b8 01 00 00 00 48 d3 e0 48 ff c8 48 89 03 41 8b 75 00 83 fe 04 7e 1b ba 04 00 00 00 48 c7 c7 d0 54 99 85 e8 e9 76 00 00 <0f> 0b 41 c7 45 00 04 00 00 00 49 c1 e4 20 4c 09 23 5b 41 5c 41 5d
[    0.102937] RSP: 0000:ffffba41c0063d70 EFLAGS: 00010282
[    0.102937] RAX: 000000000000002a RBX: ffff8e3e40268d80 RCX: c0000000ffffdfff
[    0.102937] RDX: ffffba41c0063b68 RSI: 00000000ffffdfff RDI: ffffba41c0063bb8
[    0.102937] RBP: ffffba41c0063d90 R08: 0000000000000000 R09: ffffba41c0063b60
[    0.102937] R10: 0000000000000001 R11: 0000000000000001 R12: 000000000000000f
[    0.102937] R13: ffff8e3e40268d90 R14: ffff8e3e40268d8c R15: ffffffff868755f8
[    0.102937] FS:  0000000000000000(0000) GS:ffff8e459fa00000(0000) knlGS:0000000000000000
[    0.102937] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.102938] CR2: ffff8e426b401000 CR3: 000000052a810001 CR4: 0000000000770ef0
[    0.102991] PKRU: 55555554
[    0.103044] Call Trace:
[    0.103097]  <TASK>
[    0.103150]  intel_pmu_init+0x1afd/0x1b6b
[    0.103204]  ? map_vsyscall+0x81/0x81
[    0.103258]  init_hw_perf_events+0x46/0x607
[    0.103312]  ? map_vsyscall+0x81/0x81
[    0.103365]  do_one_initcall+0x46/0x1d0
[    0.103419]  ? wake_up_process+0x15/0x20
[    0.103473]  kernel_init_freeable+0x124/0x25e
[    0.103527]  ? rest_init+0xd0/0xd0
[    0.103580]  kernel_init+0x1a/0x120
[    0.103634]  ret_from_fork+0x1f/0x30
[    0.103688]  </TASK>
[    0.103744] ---[ end trace 2df2b59caa15cafd ]---
[    0.103798] Intel PMU driver.
[    0.103871] Broken PMU hardware detected, using software events only.
[    0.103928] Failed to access perfctr msr (MSR 18e is ffffffffffffffff)
[    0.103995] rcu: Hierarchical SRCU implementation.
[    0.104228] NMI watchdog: Perf NMI watchdog permanently disabled
[    0.104336] smp: Bringing up secondary CPUs ...
[    0.104424] x86: Booting SMP configuration:
[    0.104480] .... node  #0, CPUs:        #1
[    0.024445] Broken PMU hardware detected, using software events only.
[    0.024445] Failed to access perfctr msr (MSR 18e is ffffffffffffffff)
[    0.106346]   #2
[    0.024445] Broken PMU hardware detected, using software events only.
[    0.024445] Failed to access perfctr msr (MSR 18e is ffffffffffffffff)
[    0.108300]   #3
[    0.024445] Broken PMU hardware detected, using software events only.
[    0.024445] Failed to access perfctr msr (MSR 18e is ffffffffffffffff)
[    0.108831]   #4
[    0.024445] Broken PMU hardware detected, using software events only.
[    0.024445] Failed to access perfctr msr (MSR 18e is ffffffffffffffff)
[    0.112083]   #5
[    0.024445] Broken PMU hardware detected, using software events only.
[    0.024445] Failed to access perfctr msr (MSR 18e is ffffffffffffffff)
[    0.112752]   #6
[    0.024445] Broken PMU hardware detected, using software events only.
[    0.024445] Failed to access perfctr msr (MSR 18e is ffffffffffffffff)
[    0.115764]   #7
[    0.024445] Broken PMU hardware detected, using software events only.
[    0.024445] Failed to access perfctr msr (MSR 18e is ffffffffffffffff)
[    0.116731]   #8
[    0.024445] Broken PMU hardware detected, using software events only.
[    0.024445] Failed to access perfctr msr (MSR 18e is ffffffffffffffff)
[    0.119395]   #9
[    0.024445] Broken PMU hardware detected, using software events only.
[    0.024445] Failed to access perfctr msr (MSR 18e is ffffffffffffffff)
[    0.120703]  #10
[    0.024445] Broken PMU hardware detected, using software events only.
[    0.024445] Failed to access perfctr msr (MSR 18e is ffffffffffffffff)
[    0.123006]  #11
[    0.024445] Broken PMU hardware detected, using software events only.
[    0.024445] Failed to access perfctr msr (MSR 18e is ffffffffffffffff)
[    0.124700]  #12
[    0.024445] Broken PMU hardware detected, using software events only.
[    0.024445] Failed to access perfctr msr (MSR 18e is ffffffffffffffff)
[    0.124759]  #13
[    0.024445] Broken PMU hardware detected, using software events only.
[    0.024445] Failed to access perfctr msr (MSR 18e is ffffffffffffffff)
[    0.128405]  #14
[    0.024445] Broken PMU hardware detected, using software events only.
[    0.024445] Failed to access perfctr msr (MSR 18e is ffffffffffffffff)
[    0.128802]  #15
[    0.024445] Broken PMU hardware detected, using software events only.
[    0.024445] Failed to access perfctr msr (MSR 18e is ffffffffffffffff)
[    0.132097] smp: Brought up 1 node, 16 CPUs
[    0.132097] smpboot: Max logical packages: 1
[    0.132097] smpboot: Total of 16 processors activated (101990.40 BogoMIPS)
[    0.135349] devtmpfs: initialized
[    0.135349] x86/mm: Memory block size: 128MB
[    0.135700] ACPI: PM: Registering ACPI NVS region [mem 0x78141000-0x7871efff] (6152192 bytes)
[    0.135700] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.135700] futex hash table entries: 4096 (order: 6, 262144 bytes, linear)
[    0.135700] pinctrl core: initialized pinctrl subsystem
[    0.135700] PM: RTC time: 13:01:25, date: 2021-12-10
[    0.135700] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.135724] DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic allocations
[    0.135936] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.136150] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.136211] audit: initializing netlink subsys (disabled)
[    0.136266] audit: type=2000 audit(1639141285.036:1): state=initialized audit_enabled=0 res=1
[    0.136266] thermal_sys: Registered thermal governor 'fair_share'
[    0.136266] thermal_sys: Registered thermal governor 'bang_bang'
[    0.136266] thermal_sys: Registered thermal governor 'step_wise'
[    0.136266] thermal_sys: Registered thermal governor 'user_space'
[    0.136266] thermal_sys: Registered thermal governor 'power_allocator'
[    0.136266] EISA bus registered
[    0.136266] cpuidle: using governor ladder
[    0.136266] cpuidle: using governor menu
[    0.136266] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    0.136266] ACPI: bus type PCI registered
[    0.136266] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.136266] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xc0000000-0xcfffffff] (base 0xc0000000)
[    0.136266] PCI: MMCONFIG at [mem 0xc0000000-0xcfffffff] reserved in E820
[    0.136266] PCI: Using configuration type 1 for base access
[    0.136266] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.139266] Kprobes globally optimized
[    0.139324] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.139324] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.139324] ACPI: Added _OSI(Module Device)
[    0.139324] ACPI: Added _OSI(Processor Device)
[    0.139324] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.139324] ACPI: Added _OSI(Processor Aggregator Device)
[    0.139324] ACPI: Added _OSI(Linux-Dell-Video)
[    0.139324] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.139324] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.193068] ACPI: 13 ACPI AML tables successfully acquired and loaded
[    0.199787] ACPI: Dynamic OEM Table Load:
[    0.199848] ACPI: SSDT 0xFFFF8E3E402AFE00 0001AB (v02 PmRef  Cpu0Psd  00003000 INTL 20200717)
[    0.200421] ACPI: \_SB_.PR00: _OSC native thermal LVT Acked
[    0.201490] ACPI: Dynamic OEM Table Load:
[    0.201550] ACPI: SSDT 0xFFFF8E3E410BC400 000394 (v02 PmRef  Cpu0Cst  00003001 INTL 20200717)
[    0.202247] ACPI: Dynamic OEM Table Load:
[    0.202306] ACPI: SSDT 0xFFFF8E3E41106800 000647 (v02 PmRef  Cpu0Ist  00003000 INTL 20200717)
[    0.203069] ACPI: Dynamic OEM Table Load:
[    0.203128] ACPI: SSDT 0xFFFF8E3E41105800 00044D (v02 PmRef  Cpu0Hwp  00003000 INTL 20200717)
[    0.204038] ACPI: Dynamic OEM Table Load:
[    0.204099] ACPI: SSDT 0xFFFF8E3E41F2A000 001BAF (v02 PmRef  ApIst    00003000 INTL 20200717)
[    0.205200] ACPI: Dynamic OEM Table Load:
[    0.205260] ACPI: SSDT 0xFFFF8E3E41F2E000 001038 (v02 PmRef  ApHwp    00003000 INTL 20200717)
[    0.206243] ACPI: Dynamic OEM Table Load:
[    0.206303] ACPI: SSDT 0xFFFF8E3E41F34000 001349 (v02 PmRef  ApPsd    00003000 INTL 20200717)
[    0.207292] ACPI: Dynamic OEM Table Load:
[    0.207351] ACPI: SSDT 0xFFFF8E3E4007B000 000FBB (v02 PmRef  ApCst    00003000 INTL 20200717)
[    0.211713] ACPI: EC: EC started
[    0.211769] ACPI: EC: interrupt blocked
[    0.211828] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.211881] ACPI: \_SB_.PC00.LPCB.EC0_: Boot DSDT EC used to handle transactions
[    0.211936] ACPI: Interpreter enabled
[    0.212018] ACPI: PM: (supports S0 S3 S4 S5)
[    0.212075] ACPI: Using IOAPIC for interrupt routing
[    0.212153] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.212990] ACPI: Enabled 6 GPEs in block 00 to 7F
[    0.223299] ACPI: PM: Power Resource [BTRT]
[    0.226179] ACPI: PM: Power Resource [WRST]
[    0.230360] ACPI: PM: Power Resource [FN00]
[    0.230447] ACPI: PM: Power Resource [FN01]
[    0.230533] ACPI: PM: Power Resource [FN02]
[    0.230616] ACPI: PM: Power Resource [FN03]
[    0.230700] ACPI: PM: Power Resource [FN04]
[    0.231077] ACPI: PM: Power Resource [PIN]
[    0.231401] ACPI: PCI Root Bridge [PC00] (domain 0000 [bus 00-e0])
[    0.231461] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    0.231690] acpi PNP0A08:00: _OSC: platform does not support [PCIeHotplug SHPCHotplug PME]
[    0.231913] acpi PNP0A08:00: _OSC: OS now controls [AER PCIeCapability LTR]
[    0.231970] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
[    0.232585] PCI host bridge to bus 0000:00
[    0.232652] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.232706] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.232759] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.232813] pci_bus 0000:00: root bus resource [mem 0x80000000-0xbfffffff window]
[    0.232868] pci_bus 0000:00: root bus resource [mem 0x4000000000-0x7fffffffff window]
[    0.232923] pci_bus 0000:00: root bus resource [bus 00-e0]
[    0.233096] pci 0000:00:00.0: [8086:4660] type 00 class 0x060000
[    0.235139] pci 0000:00:01.0: [8086:460d] type 01 class 0x060400
[    0.235238] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.235310] pci 0000:00:01.0: PTM enabled (root), 4ns granularity
[    0.235740] pci 0000:00:06.0: [8086:464d] type 01 class 0x060400
[    0.235837] pci 0000:00:06.0: PME# supported from D0 D3hot D3cold
[    0.235908] pci 0000:00:06.0: PTM enabled (root), 4ns granularity
[    0.236277] pci 0000:00:0a.0: [8086:467d] type 00 class 0x118000
[    0.236339] pci 0000:00:0a.0: reg 0x10: [mem 0x4002210000-0x4002217fff 64bit]
[    0.236405] pci 0000:00:0a.0: enabling Extended Tags
[    0.236679] pci 0000:00:0e.0: [8086:467f] type 00 class 0x010400
[    0.236743] pci 0000:00:0e.0: reg 0x10: [mem 0x4000000000-0x4001ffffff 64bit]
[    0.236813] pci 0000:00:0e.0: reg 0x18: [mem 0x92000000-0x93ffffff]
[    0.236878] pci 0000:00:0e.0: reg 0x20: [mem 0x4002100000-0x40021fffff 64bit]
[    0.237161] pci 0000:00:14.0: [8086:7ae0] type 00 class 0x0c0330
[    0.237229] pci 0000:00:14.0: reg 0x10: [mem 0x4002200000-0x400220ffff 64bit]
[    0.237348] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.237579] pci 0000:00:14.2: [8086:7aa7] type 00 class 0x050000
[    0.237651] pci 0000:00:14.2: reg 0x10: [mem 0x400221c000-0x400221ffff 64bit]
[    0.237718] pci 0000:00:14.2: reg 0x18: [mem 0x4002225000-0x4002225fff 64bit]
[    0.238116] pci 0000:00:15.0: [8086:7acc] type 00 class 0x0c8000
[    0.238236] pci 0000:00:15.0: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
[    0.238713] pci 0000:00:15.1: [8086:7acd] type 00 class 0x0c8000
[    0.238826] pci 0000:00:15.1: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
[    0.239306] pci 0000:00:15.2: [8086:7ace] type 00 class 0x0c8000
[    0.239422] pci 0000:00:15.2: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
[    0.239826] pci 0000:00:16.0: [8086:7ae8] type 00 class 0x078000
[    0.239900] pci 0000:00:16.0: reg 0x10: [mem 0x4002221000-0x4002221fff 64bit]
[    0.240039] pci 0000:00:16.0: PME# supported from D3hot
[    0.240464] pci 0000:00:17.0: [8086:7ae2] type 00 class 0x010601
[    0.240529] pci 0000:00:17.0: reg 0x10: [mem 0x96100000-0x96101fff]
[    0.240590] pci 0000:00:17.0: reg 0x14: [mem 0x96103000-0x961030ff]
[    0.240650] pci 0000:00:17.0: reg 0x18: [io  0x5050-0x5057]
[    0.240711] pci 0000:00:17.0: reg 0x1c: [io  0x5040-0x5043]
[    0.240772] pci 0000:00:17.0: reg 0x20: [io  0x5020-0x503f]
[    0.240833] pci 0000:00:17.0: reg 0x24: [mem 0x96102000-0x961027ff]
[    0.240924] pci 0000:00:17.0: PME# supported from D3hot
[    0.241246] pci 0000:00:1a.0: [8086:7ac8] type 01 class 0x060400
[    0.241400] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    0.241495] pci 0000:00:1a.0: PTM enabled (root), 4ns granularity
[    0.241933] pci 0000:00:1b.0: [8086:7ac4] type 01 class 0x060400
[    0.242087] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.242182] pci 0000:00:1b.0: PTM enabled (root), 4ns granularity
[    0.242613] pci 0000:00:1c.0: [8086:7ab8] type 01 class 0x060400
[    0.242741] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.243174] pci 0000:00:1c.3: [8086:7abb] type 01 class 0x060400
[    0.243321] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
[    0.243410] pci 0000:00:1c.3: PTM enabled (root), 4ns granularity
[    0.243838] pci 0000:00:1c.4: [8086:7abc] type 01 class 0x060400
[    0.243985] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.244073] pci 0000:00:1c.4: PTM enabled (root), 4ns granularity
[    0.244499] pci 0000:00:1f.0: [8086:7a84] type 00 class 0x060100
[    0.244876] pci 0000:00:1f.3: [8086:7ad0] type 00 class 0x040300
[    0.244972] pci 0000:00:1f.3: reg 0x10: [mem 0x4002218000-0x400221bfff 64bit]
[    0.245090] pci 0000:00:1f.3: reg 0x20: [mem 0x4002000000-0x40020fffff 64bit]
[    0.245245] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    0.245684] pci 0000:00:1f.4: [8086:7aa3] type 00 class 0x0c0500
[    0.245759] pci 0000:00:1f.4: reg 0x10: [mem 0x4002220000-0x40022200ff 64bit]
[    0.245838] pci 0000:00:1f.4: reg 0x20: [io  0xefa0-0xefbf]
[    0.246082] pci 0000:00:1f.5: [8086:7aa4] type 00 class 0x0c8000
[    0.246151] pci 0000:00:1f.5: reg 0x10: [mem 0xfe010000-0xfe010fff]
[    0.246370] pci 0000:01:00.0: [10de:2204] type 00 class 0x030000
[    0.246434] pci 0000:01:00.0: reg 0x10: [mem 0x94000000-0x94ffffff]
[    0.246492] pci 0000:01:00.0: reg 0x14: [mem 0x80000000-0x8fffffff 64bit pref]
[    0.246552] pci 0000:01:00.0: reg 0x1c: [mem 0x90000000-0x91ffffff 64bit pref]
[    0.246609] pci 0000:01:00.0: reg 0x24: [io  0x4000-0x407f]
[    0.246665] pci 0000:01:00.0: reg 0x30: [mem 0x95000000-0x9507ffff pref]
[    0.246751] pci 0000:01:00.0: PME# supported from D0 D3hot
[    0.246946] pci 0000:01:00.1: [10de:1aef] type 00 class 0x040300
[    0.247009] pci 0000:01:00.1: reg 0x10: [mem 0x95080000-0x95083fff]
[    0.247135] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.247192] pci 0000:00:01.0:   bridge window [io  0x4000-0x4fff]
[    0.247246] pci 0000:00:01.0:   bridge window [mem 0x94000000-0x950fffff]
[    0.247301] pci 0000:00:01.0:   bridge window [mem 0x80000000-0x91ffffff 64bit pref]
[    0.247380] pci 0000:02:00.0: [8086:2700] type 00 class 0x010802
[    0.247446] pci 0000:02:00.0: reg 0x10: [mem 0x96010000-0x96013fff 64bit]
[    0.247531] pci 0000:02:00.0: reg 0x30: [mem 0x96000000-0x9600ffff pref]
[    0.247591] pci 0000:02:00.0: enabling Extended Tags
[    0.247720] pci 0000:00:06.0: PCI bridge to [bus 02]
[    0.247778] pci 0000:00:06.0:   bridge window [mem 0x96000000-0x960fffff]
[    0.247882] pci 0000:03:00.0: [144d:a804] type 00 class 0x010802
[    0.247955] pci 0000:03:00.0: reg 0x10: [mem 0x95f00000-0x95f03fff 64bit]
[    0.248227] pci 0000:00:1a.0: PCI bridge to [bus 03]
[    0.248285] pci 0000:00:1a.0:   bridge window [mem 0x95f00000-0x95ffffff]
[    0.248393] pci 0000:04:00.0: [15b7:5011] type 00 class 0x010802
[    0.248465] pci 0000:04:00.0: reg 0x10: [mem 0x95e00000-0x95e03fff 64bit]
[    0.248734] pci 0000:00:1b.0: PCI bridge to [bus 04]
[    0.248793] pci 0000:00:1b.0:   bridge window [mem 0x95e00000-0x95efffff]
[    0.248878] pci 0000:00:1c.0: PCI bridge to [bus 05]
[    0.248933] pci 0000:00:1c.0:   bridge window [io  0x3000-0x3fff]
[    0.248987] pci 0000:00:1c.0:   bridge window [mem 0x95100000-0x95afffff]
[    0.249107] pci 0000:06:00.0: [8086:15f3] type 00 class 0x020000
[    0.249181] pci 0000:06:00.0: reg 0x10: [mem 0x95b00000-0x95bfffff]
[    0.249267] pci 0000:06:00.0: reg 0x1c: [mem 0x95c00000-0x95c03fff]
[    0.249451] pci 0000:06:00.0: PME# supported from D0 D3hot D3cold
[    0.249616] pci 0000:00:1c.3: PCI bridge to [bus 06]
[    0.249674] pci 0000:00:1c.3:   bridge window [mem 0x95b00000-0x95cfffff]
[    0.249779] pci 0000:07:00.0: [8086:2700] type 00 class 0x010802
[    0.249850] pci 0000:07:00.0: reg 0x10: [mem 0x95d10000-0x95d13fff 64bit]
[    0.249941] pci 0000:07:00.0: reg 0x30: [mem 0x95d00000-0x95d0ffff pref]
[    0.250000] pci 0000:07:00.0: enabling Extended Tags
[    0.250204] pci 0000:00:1c.4: PCI bridge to [bus 07]
[    0.250260] pci 0000:00:1c.4:   bridge window [mem 0x95d00000-0x95dfffff]
[    0.250921] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    0.250996] ACPI: PCI: Interrupt link LNKB configured for IRQ 1
[    0.251111] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    0.251225] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    0.251340] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    0.251453] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    0.251567] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[    0.251682] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    0.257335] ACPI: EC: interrupt unblocked
[    0.257388] ACPI: EC: event unblocked
[    0.257462] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.257515] ACPI: EC: GPE=0x7
[    0.257569] ACPI: \_SB_.PC00.LPCB.EC0_: Boot DSDT EC initialization complete
[    0.257622] ACPI: \_SB_.PC00.LPCB.EC0_: EC: Used to handle transactions and events
[    0.257707] iommu: Default domain type: Translated 
[    0.257707] iommu: DMA domain TLB invalidation policy: lazy mode 
[    0.257707] pci 0000:01:00.0: vgaarb: setting as boot VGA device
[    0.257707] pci 0000:01:00.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.257707] pci 0000:01:00.0: vgaarb: bridge control possible
[    0.257707] vgaarb: loaded
[    0.257707] SCSI subsystem initialized
[    0.257707] libata version 3.00 loaded.
[    0.257707] ACPI: bus type USB registered
[    0.257707] usbcore: registered new interface driver usbfs
[    0.257707] usbcore: registered new interface driver hub
[    0.257707] usbcore: registered new device driver usb
[    0.257707] pps_core: LinuxPPS API ver. 1 registered
[    0.257707] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.257707] PTP clock support registered
[    0.257707] EDAC MC: Ver: 3.0.0
[    0.257707] NetLabel: Initializing
[    0.257707] NetLabel:  domain hash size = 128
[    0.258938] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.258995] NetLabel:  unlabeled traffic allowed by default
[    0.259051] PCI: Using ACPI for IRQ routing
[    0.267104] PCI: pci_cache_line_size set to 64 bytes
[    0.267191] pci 0000:00:1f.5: can't claim BAR 0 [mem 0xfe010000-0xfe010fff]: no compatible bridge window
[    0.267323] e820: reserve RAM buffer [mem 0x0009dc00-0x0009ffff]
[    0.267324] e820: reserve RAM buffer [mem 0x63e46000-0x63ffffff]
[    0.267325] e820: reserve RAM buffer [mem 0x63e9c000-0x63ffffff]
[    0.267325] e820: reserve RAM buffer [mem 0x7407e000-0x77ffffff]
[    0.267326] e820: reserve RAM buffer [mem 0x7a000000-0x7bffffff]
[    0.267327] clocksource: Switched to clocksource tsc-early
[    0.270259] VFS: Disk quotas dquot_6.6.0
[    0.270321] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.270408] AppArmor: AppArmor Filesystem Enabled
[    0.270478] pnp: PnP ACPI init
[    0.270627] system 00:00: [io  0x0290-0x029f] has been reserved
[    0.270752] system 00:01: [io  0x0680-0x069f] has been reserved
[    0.270810] system 00:01: [io  0x164e-0x164f] has been reserved
[    0.270924] system 00:02: [io  0x1854-0x1857] has been reserved
[    0.271317] system 00:03: [mem 0xfedc0000-0xfedc7fff] has been reserved
[    0.271373] system 00:03: [mem 0xfeda0000-0xfeda0fff] has been reserved
[    0.271426] system 00:03: [mem 0xfeda1000-0xfeda1fff] has been reserved
[    0.271479] system 00:03: [mem 0xc0000000-0xcfffffff] has been reserved
[    0.271532] system 00:03: [mem 0xfed20000-0xfed7ffff] has been reserved
[    0.271585] system 00:03: [mem 0xfed90000-0xfed93fff] could not be reserved
[    0.271638] system 00:03: [mem 0xfed45000-0xfed8ffff] could not be reserved
[    0.271691] system 00:03: [mem 0xfee00000-0xfeefffff] could not be reserved
[    0.272216] system 00:04: [io  0x2000-0x20fe] has been reserved
[    0.272735] pnp: PnP ACPI: found 6 devices
[    0.277635] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.277718] NET: Registered PF_INET protocol family
[    0.277885] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.278611] tcp_listen_portaddr_hash hash table entries: 16384 (order: 6, 262144 bytes, linear)
[    0.278785] TCP established hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.278990] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, linear)
[    0.279075] TCP: Hash tables configured (established 262144 bind 65536)
[    0.279200] MPTCP token hash table entries: 32768 (order: 7, 786432 bytes, linear)
[    0.279310] UDP hash table entries: 16384 (order: 7, 524288 bytes, linear)
[    0.279409] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes, linear)
[    0.283890] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.283950] NET: Registered PF_XDP protocol family
[    0.284007] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 05] add_size 200000 add_align 100000
[    0.284067] pci 0000:00:1c.0: BAR 15: assigned [mem 0x4002300000-0x40024fffff 64bit pref]
[    0.284122] pci 0000:00:15.0: BAR 0: assigned [mem 0x4002222000-0x4002222fff 64bit]
[    0.284226] pci 0000:00:15.1: BAR 0: assigned [mem 0x4002223000-0x4002223fff 64bit]
[    0.284333] pci 0000:00:15.2: BAR 0: assigned [mem 0x4002224000-0x4002224fff 64bit]
[    0.284439] pci 0000:00:1f.5: BAR 0: assigned [mem 0x96104000-0x96104fff]
[    0.284500] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.284554] pci 0000:00:01.0:   bridge window [io  0x4000-0x4fff]
[    0.284608] pci 0000:00:01.0:   bridge window [mem 0x94000000-0x950fffff]
[    0.284662] pci 0000:00:01.0:   bridge window [mem 0x80000000-0x91ffffff 64bit pref]
[    0.284718] pci 0000:00:06.0: PCI bridge to [bus 02]
[    0.284772] pci 0000:00:06.0:   bridge window [mem 0x96000000-0x960fffff]
[    0.284827] pci 0000:00:1a.0: PCI bridge to [bus 03]
[    0.284882] pci 0000:00:1a.0:   bridge window [mem 0x95f00000-0x95ffffff]
[    0.284940] pci 0000:00:1b.0: PCI bridge to [bus 04]
[    0.284996] pci 0000:00:1b.0:   bridge window [mem 0x95e00000-0x95efffff]
[    0.285054] pci 0000:00:1c.0: PCI bridge to [bus 05]
[    0.285108] pci 0000:00:1c.0:   bridge window [io  0x3000-0x3fff]
[    0.285163] pci 0000:00:1c.0:   bridge window [mem 0x95100000-0x95afffff]
[    0.285218] pci 0000:00:1c.0:   bridge window [mem 0x4002300000-0x40024fffff 64bit pref]
[    0.285276] pci 0000:00:1c.3: PCI bridge to [bus 06]
[    0.285332] pci 0000:00:1c.3:   bridge window [mem 0x95b00000-0x95cfffff]
[    0.285390] pci 0000:00:1c.4: PCI bridge to [bus 07]
[    0.285446] pci 0000:00:1c.4:   bridge window [mem 0x95d00000-0x95dfffff]
[    0.285504] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.285558] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.285610] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.285663] pci_bus 0000:00: resource 7 [mem 0x80000000-0xbfffffff window]
[    0.285716] pci_bus 0000:00: resource 8 [mem 0x4000000000-0x7fffffffff window]
[    0.285772] pci_bus 0000:01: resource 0 [io  0x4000-0x4fff]
[    0.285825] pci_bus 0000:01: resource 1 [mem 0x94000000-0x950fffff]
[    0.285878] pci_bus 0000:01: resource 2 [mem 0x80000000-0x91ffffff 64bit pref]
[    0.285932] pci_bus 0000:02: resource 1 [mem 0x96000000-0x960fffff]
[    0.285986] pci_bus 0000:03: resource 1 [mem 0x95f00000-0x95ffffff]
[    0.286038] pci_bus 0000:04: resource 1 [mem 0x95e00000-0x95efffff]
[    0.286091] pci_bus 0000:05: resource 0 [io  0x3000-0x3fff]
[    0.286144] pci_bus 0000:05: resource 1 [mem 0x95100000-0x95afffff]
[    0.286197] pci_bus 0000:05: resource 2 [mem 0x4002300000-0x40024fffff 64bit pref]
[    0.286252] pci_bus 0000:06: resource 1 [mem 0x95b00000-0x95cfffff]
[    0.286305] pci_bus 0000:07: resource 1 [mem 0x95d00000-0x95dfffff]
[    0.371116] pci 0000:00:14.0: quirk_usb_early_handoff+0x0/0x620 took 82698 usecs
[    0.371252] pci 0000:01:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.371317] pci 0000:01:00.1: D0 power state depends on 0000:01:00.0
[    0.371391] PCI: CLS 64 bytes, default 64
[    0.371469] DMAR: No RMRR found
[    0.371485] Trying to unpack rootfs image as initramfs...
[    0.371525] DMAR: No ATSR found
[    0.371526] DMAR: No SATC found
[    0.371527] DMAR: dmar0: Using Queued invalidation
[    0.371757] pci 0000:00:00.0: Adding to iommu group 0
[    0.371818] pci 0000:00:01.0: Adding to iommu group 1
[    0.371874] pci 0000:00:06.0: Adding to iommu group 2
[    0.371929] pci 0000:00:0a.0: Adding to iommu group 3
[    0.371986] pci 0000:00:0e.0: Adding to iommu group 4
[    0.372044] pci 0000:00:14.0: Adding to iommu group 5
[    0.372100] pci 0000:00:14.2: Adding to iommu group 5
[    0.372159] pci 0000:00:15.0: Adding to iommu group 6
[    0.372228] pci 0000:00:15.1: Adding to iommu group 6
[    0.372283] pci 0000:00:15.2: Adding to iommu group 6
[    0.372341] pci 0000:00:16.0: Adding to iommu group 7
[    0.372396] pci 0000:00:17.0: Adding to iommu group 8
[    0.372453] pci 0000:00:1a.0: Adding to iommu group 9
[    0.372509] pci 0000:00:1b.0: Adding to iommu group 10
[    0.372570] pci 0000:00:1c.0: Adding to iommu group 11
[    0.372627] pci 0000:00:1c.3: Adding to iommu group 12
[    0.372684] pci 0000:00:1c.4: Adding to iommu group 13
[    0.372745] pci 0000:00:1f.0: Adding to iommu group 14
[    0.372816] pci 0000:00:1f.3: Adding to iommu group 14
[    0.372872] pci 0000:00:1f.4: Adding to iommu group 14
[    0.372927] pci 0000:00:1f.5: Adding to iommu group 14
[    0.372986] pci 0000:01:00.0: Adding to iommu group 15
[    0.373043] pci 0000:01:00.1: Adding to iommu group 15
[    0.373099] pci 0000:02:00.0: Adding to iommu group 16
[    0.373156] pci 0000:03:00.0: Adding to iommu group 17
[    0.373214] pci 0000:04:00.0: Adding to iommu group 18
[    0.373271] pci 0000:06:00.0: Adding to iommu group 19
[    0.373327] pci 0000:07:00.0: Adding to iommu group 20
[    0.374384] DMAR: Intel(R) Virtualization Technology for Directed I/O
[    0.374442] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.374495] software IO TLB: mapped [mem 0x000000007007e000-0x000000007407e000] (64MB)
[    0.374606] resource sanity check: requesting [mem 0xfedc0000-0xfedcdfff], which spans more than pnp 00:03 [mem 0xfedc0000-0xfedc7fff]
[    0.374668] caller tgl_uncore_imc_freerunning_init_box+0xab/0xd0 mapping multiple BARs
[    0.374776] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2df10e7656b, max_idle_ns: 440795364873 ns
[    0.374849] clocksource: Switched to clocksource tsc
[    0.374922] platform rtc_cmos: registered platform RTC device (no PNP device found)
[    0.376716] Initialise system trusted keyrings
[    0.376779] Key type blacklist registered
[    0.376844] workingset: timestamp_bits=36 max_order=23 bucket_order=0
[    0.377261] zbud: loaded
[    0.377403] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.377501] fuse: init (API version 7.34)
[    0.377610] integrity: Platform Keyring initialized
[    0.381554] Key type asymmetric registered
[    0.381611] Asymmetric key parser 'x509' registered
[    0.381671] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 243)
[    0.381750] io scheduler mq-deadline registered
[    0.382010] pcieport 0000:00:01.0: AER: enabled with IRQ 121
[    0.382082] pcieport 0000:00:01.0: DPC: enabled with IRQ 121
[    0.382143] pcieport 0000:00:01.0: DPC: error containment capabilities: Int Msg #0, RPExt+ PoisonedTLP+ SwTrigger+ RP PIO Log 4, DL_ActiveErr+
[    0.382314] pcieport 0000:00:06.0: AER: enabled with IRQ 122
[    0.382381] pcieport 0000:00:06.0: DPC: enabled with IRQ 122
[    0.382446] pcieport 0000:00:06.0: DPC: error containment capabilities: Int Msg #0, RPExt+ PoisonedTLP+ SwTrigger+ RP PIO Log 4, DL_ActiveErr+
[    0.382648] pcieport 0000:00:1a.0: AER: enabled with IRQ 123
[    0.382720] pcieport 0000:00:1a.0: DPC: enabled with IRQ 123
[    0.382776] pcieport 0000:00:1a.0: DPC: error containment capabilities: Int Msg #0, RPExt+ PoisonedTLP+ SwTrigger+ RP PIO Log 4, DL_ActiveErr+
[    0.383008] pcieport 0000:00:1b.0: AER: enabled with IRQ 124
[    0.383080] pcieport 0000:00:1b.0: DPC: enabled with IRQ 124
[    0.383136] pcieport 0000:00:1b.0: DPC: error containment capabilities: Int Msg #0, RPExt+ PoisonedTLP+ SwTrigger+ RP PIO Log 4, DL_ActiveErr+
[    0.383421] pcieport 0000:00:1c.3: AER: enabled with IRQ 126
[    0.383493] pcieport 0000:00:1c.3: DPC: enabled with IRQ 126
[    0.383549] pcieport 0000:00:1c.3: DPC: error containment capabilities: Int Msg #0, RPExt+ PoisonedTLP+ SwTrigger+ RP PIO Log 4, DL_ActiveErr+
[    0.383774] pcieport 0000:00:1c.4: AER: enabled with IRQ 127
[    0.383846] pcieport 0000:00:1c.4: DPC: enabled with IRQ 127
[    0.383902] pcieport 0000:00:1c.4: DPC: error containment capabilities: Int Msg #0, RPExt+ PoisonedTLP+ SwTrigger+ RP PIO Log 4, DL_ActiveErr+
[    0.384032] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    0.384224] Monitor-Mwait will be used to enter C-1 state
[    0.384226] Monitor-Mwait will be used to enter C-2 state
[    0.384227] Monitor-Mwait will be used to enter C-3 state
[    0.384228] ACPI: \_SB_.PR00: Found 3 idle states
[    0.384549] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input0
[    0.384619] ACPI: button: Sleep Button [SLPB]
[    0.384697] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
[    0.384769] ACPI: button: Power Button [PWRB]
[    0.384848] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
[    0.384928] ACPI: button: Power Button [PWRF]
[    0.385114] smpboot: Estimated ratio of average max frequency by base frequency (times 1024): 1760
[    0.386376] thermal LNXTHERM:00: registered as thermal_zone0
[    0.386433] ACPI: thermal: Thermal Zone [TZ00] (28 C)
[    0.386560] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.407360] serial8250: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    0.407918] hpet_acpi_add: no address or irqs in _CRS
[    0.407993] Linux agpgart interface v0.103
[    0.410430] loop: module loaded
[    0.410573] libphy: Fixed MDIO Bus: probed
[    0.410631] tun: Universal TUN/TAP device driver, 1.6
[    0.410691] PPP generic driver version 2.4.2
[    0.410774] VFIO - User Level meta-driver version: 0.3
[    0.410885] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.410944] ehci-pci: EHCI PCI platform driver
[    0.411000] ehci-platform: EHCI generic platform driver
[    0.411057] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.411110] ohci-pci: OHCI PCI platform driver
[    0.411165] ohci-platform: OHCI generic platform driver
[    0.411220] uhci_hcd: USB Universal Host Controller Interface driver
[    0.411283] i8042: PNP: No PS/2 controller found.
[    0.411363] mousedev: PS/2 mouse device common for all mice
[    0.411471] rtc_cmos rtc_cmos: RTC can wake from S4
[    0.411903] rtc_cmos rtc_cmos: registered as rtc0
[    0.412052] rtc_cmos rtc_cmos: setting system clock to 2021-12-10T13:01:25 UTC (1639141285)
[    0.412112] rtc_cmos rtc_cmos: alarms up to one month, y3k, 114 bytes nvram
[    0.412167] i2c_dev: i2c /dev entries driver
[    0.417308] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. Duplicate IMA measurements will not be recorded in the IMA log.
[    0.417379] device-mapper: uevent: version 1.0.3
[    0.417462] device-mapper: ioctl: 4.45.0-ioctl (2021-03-22) initialised: dm-devel at redhat.com
[    0.417526] platform eisa.0: Probing EISA bus 0
[    0.417579] platform eisa.0: EISA: Cannot allocate resource for mainboard
[    0.417632] platform eisa.0: Cannot allocate resource for EISA slot 1
[    0.417685] platform eisa.0: Cannot allocate resource for EISA slot 2
[    0.417738] platform eisa.0: Cannot allocate resource for EISA slot 3
[    0.417790] platform eisa.0: Cannot allocate resource for EISA slot 4
[    0.417843] platform eisa.0: Cannot allocate resource for EISA slot 5
[    0.417896] platform eisa.0: Cannot allocate resource for EISA slot 6
[    0.417949] platform eisa.0: Cannot allocate resource for EISA slot 7
[    0.418002] platform eisa.0: Cannot allocate resource for EISA slot 8
[    0.418055] platform eisa.0: EISA: Detected 0 cards
[    0.418368] intel_pstate: Intel P-state driver initializing
[    0.419343] intel_pstate: HWP enabled
[    0.419444] ledtrig-cpu: registered to indicate activity on CPUs
[    0.419545] intel_pmc_core INT33A1:00:  initialized
[    0.419647] drop_monitor: Initializing network drop monitor service
[    0.419763] NET: Registered PF_INET6 protocol family
[    0.477653] Freeing initrd memory: 145648K
[    0.480033] Segment Routing with IPv6
[    0.480094] In-situ OAM (IOAM) with IPv6
[    0.480157] NET: Registered PF_PACKET protocol family
[    0.480263] Key type dns_resolver registered
[    0.481182] microcode: sig=0x90672, pf=0x2, revision=0x12
[    0.481485] microcode: Microcode Update Driver: v2.2.
[    0.481754] resctrl: L2 allocation detected
[    0.481864] IPI shorthand broadcast: enabled
[    0.481920] sched_clock: Marking stable (461305239, 20445792)->(503906006, -22154975)
[    0.482120] registered taskstats version 1
[    0.482380] Loading compiled-in X.509 certificates
[    0.482702] Loaded X.509 cert 'Build time autogenerated kernel key: ced44f48dc6a4c51bb2cdde59e063110a83d4857'
[    0.482930] zswap: loaded using pool lzo/zbud
[    0.483313] Key type ._fscrypt registered
[    0.483370] Key type .fscrypt registered
[    0.483423] Key type fscrypt-provisioning registered
[    0.484315] Key type encrypted registered
[    0.484373] AppArmor: AppArmor sha1 policy hashing enabled
[    0.484427] ima: No TPM chip found, activating TPM-bypass!
[    0.484480] Loading compiled-in module X.509 certificates
[    0.484739] Loaded X.509 cert 'Build time autogenerated kernel key: ced44f48dc6a4c51bb2cdde59e063110a83d4857'
[    0.484800] ima: Allocated hash algorithm: sha1
[    0.484855] ima: No architecture policies found
[    0.484910] evm: Initialising EVM extended attributes:
[    0.484963] evm: security.selinux
[    0.485016] evm: security.SMACK64
[    0.485069] evm: security.SMACK64EXEC
[    0.485122] evm: security.SMACK64TRANSMUTE
[    0.485174] evm: security.SMACK64MMAP
[    0.485227] evm: security.apparmor
[    0.485280] evm: security.ima
[    0.485333] evm: security.capability
[    0.485386] evm: HMAC attrs: 0x1
[    0.485531] PM:   Magic number: 1:129:28
[    0.485635] memory memory68: hash matches
[    0.485731] RAS: Correctable Errors collector initialized.
[    0.492150] Freeing unused decrypted memory: 2036K
[    0.492373] Freeing unused kernel image (initmem) memory: 2904K
[    0.527101] Write protecting the kernel read-only data: 28672k
[    0.528394] Freeing unused kernel image (text/rodata gap) memory: 2036K
[    0.529193] Freeing unused kernel image (rodata/data gap) memory: 1820K
[    0.545127] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    0.545187] Run /init as init process
[    0.545242]   with arguments:
[    0.545243]     /init
[    0.545243]   with environment:
[    0.545244]     HOME=/
[    0.545244]     TERM=linux
[    0.545245]     BOOT_IMAGE=/boot/vmlinuz-5.15.7
[    0.586453] intel-pmt 0000:00:0a.0: Watcher not supported
[    0.586521] intel-pmt 0000:00:0a.0: Crashlog not supported
[    0.586692] acpi PNP0C14:01: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:00)
[    0.586842] vmd 0000:00:0e.0: PCI host bridge to bus 10000:e0
[    0.586893] acpi PNP0C14:02: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:00)
[    0.586905] pci_bus 10000:e0: root bus resource [bus e0-ff]
[    0.587051] pci_bus 10000:e0: root bus resource [mem 0x92000000-0x93ffffff]
[    0.587097] acpi PNP0C14:03: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:00)
[    0.587112] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.587116] pci_bus 10000:e0: root bus resource [mem 0x4002102000-0x40021fffff 64bit]
[    0.587116] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[    0.587121] vmd 0000:00:0e.0: Bound to PCI domain 10000
[    0.587214] acpi PNP0C14:04: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:00)
[    0.587517] acpi PNP0C14:05: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:00)
[    0.587610] acpi PNP0C14:06: duplicate WMI GUID 97845ED0-4E6D-11DE-8A39-0800200C9A66 (first instance was on PNP0C14:02)
[    0.587646] ahci 0000:00:17.0: version 3.0
[    0.587671] acpi PNP0C14:06: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:00)
[    0.587859] ahci 0000:00:17.0: AHCI 0001.0301 32 slots 4 ports 6 Gbps 0xf0 impl SATA mode
[    0.587915] ahci 0000:00:17.0: flags: 64bit ncq sntf led clo only pio slum part ems deso sadm sds 
[    0.587995] Intel(R) 2.5G Ethernet Linux Driver
[    0.588040] Copyright(c) 2018 Intel Corporation.
[    0.588210] nvme 0000:02:00.0: platform quirk: setting simple suspend
[    0.588214] igc 0000:06:00.0: PTM enabled, 4ns granularity
[    0.588282] nvme nvme0: pci function 0000:02:00.0
[    0.588361] xhci_hcd 0000:00:14.0: hcc params 0x20007fc1 hci version 0x120 quirks 0x0000000000009810
[    0.588378] nvme 0000:03:00.0: platform quirk: setting simple suspend
[    0.588487] nvme nvme1: pci function 0000:03:00.0
[    0.588541] nvme 0000:04:00.0: platform quirk: setting simple suspend
[    0.588595] nvme nvme2: pci function 0000:04:00.0
[    0.588598] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.15
[    0.588642] nvme 0000:07:00.0: platform quirk: setting simple suspend
[    0.588685] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.588747] nvme nvme3: pci function 0000:07:00.0
[    0.588790] usb usb1: Product: xHCI Host Controller
[    0.588884] usb usb1: Manufacturer: Linux 5.15.7 xhci-hcd
[    0.588931] usb usb1: SerialNumber: 0000:00:14.0
[    0.589043] hub 1-0:1.0: USB hub found
[    0.589102] hub 1-0:1.0: 16 ports detected
[    0.590259] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[    0.590335] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[    0.591535] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.591582] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
[    0.591635] xhci_hcd 0000:00:14.0: Host supports USB 3.2 Enhanced SuperSpeed
[    0.591701] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.15
[    0.591755] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.591811] usb usb2: Product: xHCI Host Controller
[    0.591854] usb usb2: Manufacturer: Linux 5.15.7 xhci-hcd
[    0.591896] usb usb2: SerialNumber: 0000:00:14.0
[    0.591990] hub 2-0:1.0: USB hub found
[    0.592043] i2c i2c-0: 2/4 memory slots populated (from DMI)
[    0.592053] hub 2-0:1.0: 8 ports detected
[    0.592202] cryptd: max_cpu_qlen set to 1000
[    0.592703] i2c i2c-0: Successfully instantiated SPD at 0x51
[    0.594463] i2c i2c-0: Successfully instantiated SPD at 0x53
[    0.594731] AVX2 version of gcm_enc/dec engaged.
[    0.594795] AES CTR mode by8 optimization enabled
[    0.595003] nvme nvme3: 16/0/0 default/read/poll queues
[    0.595823] nvme nvme0: 16/0/0 default/read/poll queues
[    0.596376]  nvme3n1: p1 p2 p3 < p5 p6 p7 > p4
[    0.597092]  nvme0n1: p1 p2 p3
[    0.601873] nvidia: loading out-of-tree module taints kernel.
[    0.601921] nvidia: module license 'NVIDIA' taints kernel.
[    0.601963] Disabling lock debugging due to kernel taint
[    0.606950] intel-lpss 0000:00:15.0: enabling device (0004 -> 0006)
[    0.607292] idma64 idma64.0: Found Intel integrated DMA 64-bit
[    0.607701] nvme nvme2: 16/0/0 default/read/poll queues
[    0.608438] nvidia: module verification failed: signature and/or required key missing - tainting kernel
[    0.610275]  nvme2n1: p1 p2 p3 < p5 p6 p7 > p4
[    0.610934] nvme nvme1: 7/0/0 default/read/poll queues
[    0.611958] nvidia-nvlink: Nvlink Core is being initialized, major device number 511

[    0.612420] nvidia 0000:01:00.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=none:owns=io+mem
[    0.614132]  nvme1n1: p1 p3 < p5 p6 p7 p8 >
[    0.630948] intel-lpss 0000:00:15.1: enabling device (0004 -> 0006)
[    0.631198] idma64 idma64.1: Found Intel integrated DMA 64-bit
[    0.631262] scsi host0: ahci
[    0.631377] scsi host1: ahci
[    0.631461] scsi host2: ahci
[    0.631547] scsi host3: ahci
[    0.631629] scsi host4: ahci
[    0.631710] scsi host5: ahci
[    0.631793] scsi host6: ahci
[    0.631876] scsi host7: ahci
[    0.631943] ata1: DUMMY
[    0.632008] ata2: DUMMY
[    0.632061] ata3: DUMMY
[    0.632114] ata4: DUMMY
[    0.632168] ata5: SATA max UDMA/133 abar m2048 at 0x96102000 port 0x96102300 irq 147
[    0.632222] ata6: SATA max UDMA/133 abar m2048 at 0x96102000 port 0x96102380 irq 147
[    0.635182] pps pps0: new PPS source ptp0
[    0.636652] ata7: SATA max UDMA/133 abar m2048 at 0x96102000 port 0x96102400 irq 147
[    0.636715] igc 0000:06:00.0 (unnamed net_device) (uninitialized): PHC added
[    0.636760] ata8: SATA max UDMA/133 abar m2048 at 0x96102000 port 0x96102480 irq 147
[    0.654991] intel-lpss 0000:00:15.2: enabling device (0004 -> 0006)
[    0.655231] idma64 idma64.2: Found Intel integrated DMA 64-bit
[    0.659010] NVRM: loading NVIDIA UNIX x86_64 Kernel Module  470.86  Tue Oct 26 21:55:45 UTC 2021
[    0.695211] nvidia-modeset: Loading NVIDIA Kernel Mode Setting Driver for UNIX platforms  470.86  Tue Oct 26 21:46:51 UTC 2021
[    0.696109] [drm] [nvidia-drm] [GPU ID 0x00000100] Loading driver
[    0.696187] [drm] Initialized nvidia-drm 0.0.0 20160202 for 0000:01:00.0 on minor 0
[    0.696463] igc 0000:06:00.0: 4.000 Gb/s available PCIe bandwidth (5.0 GT/s PCIe x1 link)
[    0.696572] igc 0000:06:00.0 eth0: MAC: 04:42:1a:2e:78:8a
[    0.698385] igc 0000:06:00.0 enp6s0: renamed from eth0
[    0.850985] usb 1-2: new high-speed USB device number 2 using xhci_hcd
[    0.953361] ata5: SATA link down (SStatus 4 SControl 300)
[    0.953546] ata7: SATA link down (SStatus 4 SControl 300)
[    0.953698] ata8: SATA link down (SStatus 4 SControl 300)
[    0.953852] ata6: SATA link down (SStatus 4 SControl 300)
[    1.130870] usb 2-8: new SuperSpeed USB device number 2 using xhci_hcd
[    1.187202] usb 2-8: New USB device found, idVendor=174c, idProduct=3074, bcdDevice= 0.01
[    1.187371] usb 2-8: New USB device strings: Mfr=2, Product=3, SerialNumber=0
[    1.187494] usb 2-8: Product: ASM107x
[    1.187608] usb 2-8: Manufacturer: ASUS TEK.
[    1.208008] hub 2-8:1.0: USB hub found
[    1.212083] hub 2-8:1.0: 4 ports detected
[    1.636666] usb 2-8.4: new SuperSpeed USB device number 3 using xhci_hcd
[    1.741759] usb 2-8.4: New USB device found, idVendor=2109, idProduct=0813, bcdDevice=90.11
[    1.741928] usb 2-8.4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    1.742086] usb 2-8.4: Product: USB3.0 Hub
[    1.742203] usb 2-8.4: Manufacturer: VIA Labs, Inc.
[    1.752224] hub 2-8.4:1.0: USB hub found
[    1.752529] hub 2-8.4:1.0: 4 ports detected
[    2.184294] usb 2-8.4.1: new SuperSpeed USB device number 4 using xhci_hcd
[    2.222984] raid6: avx512x4 gen() 68835 MB/s
[    2.287938] usb 2-8.4.1: New USB device found, idVendor=2109, idProduct=0813, bcdDevice=90.11
[    2.287998] usb 2-8.4.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.288052] usb 2-8.4.1: Product: USB3.0 Hub
[    2.288105] usb 2-8.4.1: Manufacturer: VIA Labs, Inc.
[    2.290141] hub 2-8.4.1:1.0: USB hub found
[    2.290394] hub 2-8.4.1:1.0: 4 ports detected
[    2.290979] raid6: avx512x4 xor() 14229 MB/s
[    2.358982] raid6: avx512x2 gen() 75851 MB/s
[    2.426937] raid6: avx512x2 xor() 42887 MB/s
[    2.494984] raid6: avx512x1 gen() 41470 MB/s
[    2.562981] raid6: avx512x1 xor() 42797 MB/s
[    2.605570] usb 1-2: New USB device found, idVendor=0b05, idProduct=1a16, bcdDevice= 0.03
[    2.605629] usb 1-2: New USB device strings: Mfr=3, Product=1, SerialNumber=0
[    2.605682] usb 1-2: Product: USB Audio
[    2.605735] usb 1-2: Manufacturer: Generic
[    2.630938] raid6: avx2x4   gen() 55699 MB/s
[    2.631101] hid: raw HID events driver (C) Jiri Kosina
[    2.633252] usbcore: registered new interface driver usbhid
[    2.633310] usbhid: USB HID core driver
[    2.633971] hid-generic 0003:0B05:1A16.0001: hiddev0,hidraw0: USB HID v1.11 Device [Generic USB Audio] on usb-0000:00:14.0-2/input7
[    2.683191] usb 2-8.4.1.1: new SuperSpeed USB device number 5 using xhci_hcd
[    2.698984] raid6: avx2x4   xor() 12935 MB/s
[    2.713534] usb 2-8.4.1.1: New USB device found, idVendor=0bda, idProduct=0411, bcdDevice= 1.04
[    2.713595] usb 2-8.4.1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.713648] usb 2-8.4.1.1: Product: 4-Port USB 3.0 Hub
[    2.713701] usb 2-8.4.1.1: Manufacturer: Generic
[    2.717681] hub 2-8.4.1.1:1.0: USB hub found
[    2.718471] hub 2-8.4.1.1:1.0: 4 ports detected
[    2.766978] raid6: avx2x2   gen() 60595 MB/s
[    2.834978] raid6: avx2x2   xor() 37789 MB/s
[    2.842990] usb 1-4: new full-speed USB device number 3 using xhci_hcd
[    2.902982] raid6: avx2x1   gen() 57807 MB/s
[    2.970980] raid6: avx2x1   xor() 33895 MB/s
[    3.000584] usb 1-4: config 1 has an invalid interface number: 2 but max is 1
[    3.000642] usb 1-4: config 1 has no interface number 1
[    3.001613] usb 1-4: New USB device found, idVendor=0b05, idProduct=19af, bcdDevice= 1.00
[    3.001674] usb 1-4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.001727] usb 1-4: Product: AURA LED Controller
[    3.001780] usb 1-4: Manufacturer: AsusTek Computer Inc.
[    3.001833] usb 1-4: SerialNumber: 9876543210
[    3.003327] hid-generic 0003:0B05:19AF.0002: hiddev1,hidraw1: USB HID v1.11 Device [AsusTek Computer Inc. AURA LED Controller] on usb-0000:00:14.0-4/input2
[    3.038938] raid6: sse2x4   gen() 40470 MB/s
[    3.087189] usb 2-8.4.1.1.1: new SuperSpeed USB device number 6 using xhci_hcd
[    3.106982] raid6: sse2x4   xor() 10790 MB/s
[    3.117434] usb 2-8.4.1.1.1: New USB device found, idVendor=0bda, idProduct=0411, bcdDevice= 1.04
[    3.117495] usb 2-8.4.1.1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.117550] usb 2-8.4.1.1.1: Product: 4-Port USB 3.0 Hub
[    3.117603] usb 2-8.4.1.1.1: Manufacturer: Generic
[    3.121978] hub 2-8.4.1.1.1:1.0: USB hub found
[    3.122866] hub 2-8.4.1.1.1:1.0: 4 ports detected
[    3.174981] raid6: sse2x2   gen() 45156 MB/s
[    3.242983] raid6: sse2x2   xor() 26887 MB/s
[    3.242989] usb 1-10: new high-speed USB device number 4 using xhci_hcd
[    3.310982] raid6: sse2x1   gen() 36687 MB/s
[    3.378981] raid6: sse2x1   xor() 22463 MB/s
[    3.379038] raid6: using algorithm avx512x2 gen() 75851 MB/s
[    3.379091] raid6: .... xor() 42887 MB/s, rmw enabled
[    3.379144] raid6: using avx512x2 recovery algorithm
[    3.379593] xor: automatically using best checksumming function   avx       
[    3.379999] async_tx: api initialized (async)
[    3.395142] EXT4-fs (nvme3n1p2): mounted filesystem with ordered data mode. Opts: (null). Quota mode: none.
[    3.400618] usb 1-10: New USB device found, idVendor=174c, idProduct=2074, bcdDevice= 0.01
[    3.400674] usb 1-10: New USB device strings: Mfr=2, Product=3, SerialNumber=0
[    3.400728] usb 1-10: Product: ASM107x
[    3.400781] usb 1-10: Manufacturer: ASUS TEK.
[    3.401524] hub 1-10:1.0: USB hub found
[    3.401751] hub 1-10:1.0: 4 ports detected
[    3.454521] systemd[1]: Inserted module 'autofs4'
[    3.459273] systemd[1]: systemd 245.4-4ubuntu3.13 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=hybrid)
[    3.483105] systemd[1]: Detected architecture x86-64.
[    3.528258] systemd[1]: Set hostname to <computer>.
[    3.531054] usb 1-13: new high-speed USB device number 5 using xhci_hcd
[    3.598062] systemd[1]: Unnecessary job for /sys/devices/virtual/misc/vmbus!hv_vss was removed.
[    3.598126] systemd[1]: Unnecessary job for /sys/devices/virtual/misc/vmbus!hv_fcopy was removed.
[    3.598531] systemd[1]: Created slice system-modprobe.slice.
[    3.598765] systemd[1]: Created slice system-systemd\x2dfsck.slice.
[    3.598974] systemd[1]: Created slice User and Session Slice.
[    3.599139] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[    3.599337] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[    3.599508] systemd[1]: Reached target Remote File Systems.
[    3.599642] systemd[1]: Reached target Slices.
[    3.599806] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    3.599977] systemd[1]: Listening on LVM2 poll daemon socket.
[    3.600139] systemd[1]: Listening on Syslog Socket.
[    3.600392] systemd[1]: Listening on fsck to fsckd communication Socket.
[    3.600564] systemd[1]: Listening on initctl Compatibility Named Pipe.
[    3.600758] systemd[1]: Listening on Journal Audit Socket.
[    3.605295] systemd[1]: Listening on Journal Socket (/dev/log).
[    3.605464] systemd[1]: Listening on Journal Socket.
[    3.605612] systemd[1]: Listening on udev Control Socket.
[    3.605769] systemd[1]: Listening on udev Kernel Socket.
[    3.606160] systemd[1]: Mounting Huge Pages File System...
[    3.606532] systemd[1]: Mounting POSIX Message Queue File System...
[    3.606925] systemd[1]: Mounting Kernel Debug File System...
[    3.607362] systemd[1]: Mounting Kernel Trace File System...
[    3.608056] systemd[1]: Starting Journal Service...
[    3.608474] systemd[1]: Starting Availability of block devices...
[    3.608994] systemd[1]: Starting Set the console keyboard layout...
[    3.609389] systemd[1]: Starting Create list of static device nodes for the current kernel...
[    3.609755] systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling...
[    3.609921] systemd[1]: Condition check resulted in Load Kernel Module drm being skipped.
[    3.610211] systemd[1]: Started Nameserver information manager.
[    3.610398] systemd[1]: Reached target Network (Pre).
[    3.610592] systemd[1]: Condition check resulted in Set Up Additional Binary Formats being skipped.
[    3.610674] systemd[1]: Condition check resulted in File System Check on Root Device being skipped.
[    3.611099] systemd[1]: Starting Load Kernel Modules...
[    3.611460] systemd[1]: Starting Remount Root and Kernel File Systems...
[    3.611812] systemd[1]: Starting udev Coldplug all Devices...
[    3.612145] systemd[1]: Starting Uncomplicated firewall...
[    3.612675] systemd[1]: Mounted Huge Pages File System.
[    3.612831] systemd[1]: Mounted POSIX Message Queue File System.
[    3.612967] systemd[1]: Mounted Kernel Debug File System.
[    3.613130] systemd[1]: Mounted Kernel Trace File System.
[    3.613172] EXT4-fs (nvme3n1p2): re-mounted. Opts: errors=remount-ro. Quota mode: none.
[    3.613685] systemd[1]: Finished Availability of block devices.
[    3.614000] systemd[1]: Finished Create list of static device nodes for the current kernel.
[    3.614514] systemd[1]: Finished Remount Root and Kernel File Systems.
[    3.614560] bpfilter: Loaded bpfilter_umh pid 504
[    3.614649] Started bpfilter
[    3.614854] systemd[1]: Condition check resulted in Rebuild Hardware Database being skipped.
[    3.614903] lp: driver loaded but no devices found
[    3.614933] systemd[1]: Condition check resulted in Platform Persistent Storage Archival being skipped.
[    3.615322] systemd[1]: Starting Load/Save Random Seed...
[    3.615829] systemd[1]: Starting Create System Users...
[    3.615922] ppdev: user-space parallel port driver
[    3.617692] systemd[1]: Finished Load/Save Random Seed.
[    3.618456] systemd[1]: Finished Create System Users.
[    3.618873] systemd[1]: Starting Create Static Device Nodes in /dev...
[    3.619534] nct6775: Found NCT6798D or compatible chip at 0x2e:0x290
[    3.619591] ACPI Warning: SystemIO range 0x0000000000000295-0x0000000000000296 conflicts with OpRegion 0x0000000000000290-0x0000000000000299 (\RMTW.SHWM) (20210730/utaddress-204)
[    3.619663] ACPI: OSL: Resource conflict; ACPI support missing from driver?
[    3.620039] systemd[1]: Finished Load Kernel Modules.
[    3.620509] systemd[1]: Mounting FUSE Control File System...
[    3.621026] systemd[1]: Mounting Kernel Configuration File System...
[    3.621434] systemd[1]: Starting Apply Kernel Variables...
[    3.622098] systemd[1]: Finished Create Static Device Nodes in /dev.
[    3.622287] systemd[1]: Mounted FUSE Control File System.
[    3.622454] systemd[1]: Mounted Kernel Configuration File System.
[    3.622891] systemd[1]: Starting udev Kernel Device Manager...
[    3.624356] systemd[1]: Finished Apply Kernel Variables.
[    3.627913] systemd[1]: Finished Set the console keyboard layout.
[    3.632144] systemd[1]: Started Journal Service.
[    3.633964] systemd-journald[481]: Received client request to flush runtime journal.
[    3.662259] nvidia_uvm: module uses symbols from proprietary module nvidia, inheriting taint.
[    3.667680] nvidia-uvm: Loaded the UVM driver, major device number 508.
[    3.683123] usb 1-13: New USB device found, idVendor=058f, idProduct=6254, bcdDevice= 1.00
[    3.683126] usb 1-13: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    3.697644] hub 1-13:1.0: USB hub found
[    3.697699] hub 1-13:1.0: 4 ports detected
[    3.758588] iTCO_vendor_support: vendor-support=0
[    3.762284] ee1004 0-0051: 512 byte EE1004-compliant SPD EEPROM, read-only
[    3.762483] ee1004 0-0053: 512 byte EE1004-compliant SPD EEPROM, read-only
[    3.762492] asus_wmi: ASUS WMI generic driver loaded
[    3.763421] iTCO_wdt iTCO_wdt: Found a Intel PCH TCO device (Version=6, TCOBASE=0x0400)
[    3.764297] iTCO_wdt iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[    3.764349] asus_wmi: SFUN value: 0x1
[    3.764351] asus-nb-wmi asus-nb-wmi: Detected ATK, not ASUSWMI, use DSTS
[    3.764353] asus-nb-wmi asus-nb-wmi: Detected ATK, enable event queue
[    3.764354] asus_wmi: Failed to get WMI notify code: AE_NOT_FOUND
[    3.764354] asus_wmi: Failed to get event during flush: -5
[    3.764946] asus_wmi: SFUN value: 0x1
[    3.764948] eeepc-wmi eeepc-wmi: Detected ATK, not ASUSWMI, use DSTS
[    3.766046] input: Asus WMI hotkeys as /devices/platform/asus-nb-wmi/input/input3
[    3.766175] input: Eee PC WMI hotkeys as /devices/platform/eeepc-wmi/input/input4
[    3.778641] Adding 4193276k swap on /dev/nvme1n1p8.  Priority:-2 extents:1 across:4193276k SSFS
[    3.778946] usb 1-10.4: new high-speed USB device number 6 using xhci_hcd
[    3.779694] EXT4-fs (nvme0n1p2): mounted filesystem with ordered data mode. Opts: (null). Quota mode: none.
[    3.799437] EXT4-fs (nvme0n1p1): mounted filesystem with ordered data mode. Opts: (null). Quota mode: none.
[    3.801577] EXT4-fs (nvme3n1p6): mounted filesystem with ordered data mode. Opts: (null). Quota mode: none.
[    3.803382] EXT4-fs (nvme1n1p6): mounted filesystem with ordered data mode. Opts: (null). Quota mode: none.
[    3.805194] EXT4-fs (nvme1n1p5): mounted filesystem with ordered data mode. Opts: (null). Quota mode: none.
[    3.813263] EXT4-fs (nvme2n1p5): mounted filesystem with ordered data mode. Opts: (null). Quota mode: none.
[    3.815355] EXT4-fs (nvme2n1p6): mounted filesystem with ordered data mode. Opts: (null). Quota mode: none.
[    3.821707] audit: type=1400 audit(1639141288.903:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="ippusbxd" pid=816 comm="apparmor_parser"
[    3.821713] audit: type=1400 audit(1639141288.903:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="lsb_release" pid=812 comm="apparmor_parser"
[    3.822282] audit: type=1400 audit(1639141288.903:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/bin/man" pid=807 comm="apparmor_parser"
[    3.822283] audit: type=1400 audit(1639141288.903:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="man_filter" pid=807 comm="apparmor_parser"
[    3.822286] audit: type=1400 audit(1639141288.903:6): apparmor="STATUS" operation="profile_load" profile="unconfined" name="man_groff" pid=807 comm="apparmor_parser"
[    3.822305] audit: type=1400 audit(1639141288.903:7): apparmor="STATUS" operation="profile_load" profile="unconfined" name="nvidia_modprobe" pid=810 comm="apparmor_parser"
[    3.822308] audit: type=1400 audit(1639141288.903:8): apparmor="STATUS" operation="profile_load" profile="unconfined" name="nvidia_modprobe//kmod" pid=810 comm="apparmor_parser"
[    3.822376] audit: type=1400 audit(1639141288.903:9): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/sbin/cups-browsed" pid=814 comm="apparmor_parser"
[    3.823546] audit: type=1400 audit(1639141288.907:10): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/lightdm/lightdm-guest-session" pid=811 comm="apparmor_parser"
[    3.825298] mc: Linux media interface: v0.10
[    3.825521] snd_hda_intel 0000:00:1f.3: Applying patch firmware 'hda-jack-retask.fw'
[    3.825678] snd_hda_intel 0000:01:00.1: Disabling MSI
[    3.825683] snd_hda_intel 0000:01:00.1: Handle vga_switcheroo audio client
[    3.825700] RAPL PMU: API unit is 2^-32 Joules, 2 fixed counters, 655360 ms ovfl timer
[    3.825702] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    3.825702] RAPL PMU: hw unit of domain package 2^-14 Joules
[    3.825850] snd_hda_intel 0000:01:00.1: Applying patch firmware 'hda-jack-retask.fw'
[    3.896547] usb 1-10.4: New USB device found, idVendor=2109, idProduct=2813, bcdDevice=90.11
[    3.896549] usb 1-10.4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.896550] usb 1-10.4: Product: USB2.0 Hub
[    3.896551] usb 1-10.4: Manufacturer: VIA Labs, Inc.
[    3.897468] hub 1-10.4:1.0: USB hub found
[    3.897634] hub 1-10.4:1.0: 4 ports detected
[    3.947597] intel_tcc_cooling: Programmable TCC Offset detected
[    3.949825] intel_rapl_msr: PL4 support detected.
[    3.949838] intel_rapl_common: Found RAPL domain package
[    3.949840] intel_rapl_common: Found RAPL domain core
[    4.206956] usb 1-10.4.1: new high-speed USB device number 7 using xhci_hcd
[    4.320569] usb 1-10.4.1: New USB device found, idVendor=2109, idProduct=2813, bcdDevice=90.11
[    4.320573] usb 1-10.4.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    4.320574] usb 1-10.4.1: Product: USB2.0 Hub
[    4.320575] usb 1-10.4.1: Manufacturer: VIA Labs, Inc.
[    4.322405] hub 1-10.4.1:1.0: USB hub found
[    4.322561] hub 1-10.4.1:1.0: 4 ports detected
[    4.630957] usb 1-10.4.1.1: new high-speed USB device number 8 using xhci_hcd
[    4.760900] usb 1-10.4.1.1: New USB device found, idVendor=0bda, idProduct=5411, bcdDevice= 1.04
[    4.760904] usb 1-10.4.1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    4.760905] usb 1-10.4.1.1: Product: 4-Port USB 2.0 Hub
[    4.760906] usb 1-10.4.1.1: Manufacturer: Generic
[    4.834947] snd_hda_intel 0000:00:1f.3: azx_get_response timeout, switching to polling mode: last cmd=0x000f0000
[    4.843618] hub 1-10.4.1.1:1.0: USB hub found
[    4.844209] hub 1-10.4.1.1:1.0: 4 ports detected
[    5.130953] usb 1-10.4.1.1.1: new high-speed USB device number 9 using xhci_hcd
[    5.244983] usb 1-10.4.1.1.1: New USB device found, idVendor=0bda, idProduct=5411, bcdDevice= 1.04
[    5.244987] usb 1-10.4.1.1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    5.244989] usb 1-10.4.1.1.1: Product: 4-Port USB 2.0 Hub
[    5.244990] usb 1-10.4.1.1.1: Manufacturer: Generic
[    5.342112] hub 1-10.4.1.1.1:1.0: USB hub found
[    5.342654] hub 1-10.4.1.1.1:1.0: 4 ports detected
[    5.422949] usb 1-10.4.1.1.4: new full-speed USB device number 10 using xhci_hcd
[    5.529072] usb 1-10.4.1.1.4: New USB device found, idVendor=0dc6, idProduct=5000, bcdDevice= 1.00
[    5.529076] usb 1-10.4.1.1.4: New USB device strings: Mfr=0, Product=3, SerialNumber=0
[    5.529077] usb 1-10.4.1.1.4: Product: Generic USB Hub
[    5.630951] usb 1-10.4.1.1.1.4: new low-speed USB device number 11 using xhci_hcd
[    5.673245] hub 1-10.4.1.1.4:1.0: USB hub found
[    5.673612] hub 1-10.4.1.1.4:1.0: 3 ports detected
[    5.761151] usb 1-10.4.1.1.1.4: New USB device found, idVendor=046d, idProduct=c215, bcdDevice= 2.04
[    5.761156] usb 1-10.4.1.1.1.4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    5.761157] usb 1-10.4.1.1.1.4: Product: Logitech Extreme 3D
[    5.761158] usb 1-10.4.1.1.1.4: Manufacturer: Logitech
[    5.846954] snd_hda_intel 0000:00:1f.3: No response from codec, disabling MSI: last cmd=0x000f0000
[    5.906487] input: Logitech Logitech Extreme 3D as /devices/pci0000:00/0000:00:14.0/usb1/1-10/1-10.4/1-10.4.1/1-10.4.1.1/1-10.4.1.1.1/1-10.4.1.1.1.4/1-10.4.1.1.1.4:1.0/0003:046D:C215.0003/input/input5
[    5.906544] logitech 0003:046D:C215.0003: input,hidraw2: USB HID v1.10 Joystick [Logitech Logitech Extreme 3D] on usb-0000:00:14.0-10.4.1.1.1.4/input0
[    5.958945] usb 1-10.4.1.1.4.3: new full-speed USB device number 12 using xhci_hcd
[    6.064857] usb 1-10.4.1.1.4.3: config 1 has an invalid interface number: 1 but max is 0
[    6.064859] usb 1-10.4.1.1.4.3: config 1 has 2 interfaces, different from the descriptor's value: 1
[    6.065843] usb 1-10.4.1.1.4.3: New USB device found, idVendor=0dc6, idProduct=5300, bcdDevice= 1.00
[    6.065844] usb 1-10.4.1.1.4.3: New USB device strings: Mfr=0, Product=2, SerialNumber=0
[    6.065845] usb 1-10.4.1.1.4.3: Product: USB Keyboard + 2P Hub
[    6.180573] input: USB Keyboard + 2P Hub as /devices/pci0000:00/0000:00:14.0/usb1/1-10/1-10.4/1-10.4.1/1-10.4.1.1/1-10.4.1.1.4/1-10.4.1.1.4.3/1-10.4.1.1.4.3:1.0/0003:0DC6:5300.0004/input/input6
[    6.239103] hid-generic 0003:0DC6:5300.0004: input,hidraw3: USB HID v1.10 Keyboard [USB Keyboard + 2P Hub] on usb-0000:00:14.0-10.4.1.1.4.3/input0
[    6.241048] input: USB Keyboard + 2P Hub System Control as /devices/pci0000:00/0000:00:14.0/usb1/1-10/1-10.4/1-10.4.1/1-10.4.1.1/1-10.4.1.1.4/1-10.4.1.1.4.3/1-10.4.1.1.4.3:1.1/0003:0DC6:5300.0005/input/input7
[    6.290942] usb 1-10.4.1.1.3: new full-speed USB device number 13 using xhci_hcd
[    6.298985] input: USB Keyboard + 2P Hub Consumer Control as /devices/pci0000:00/0000:00:14.0/usb1/1-10/1-10.4/1-10.4.1/1-10.4.1.1/1-10.4.1.1.4/1-10.4.1.1.4.3/1-10.4.1.1.4.3:1.1/0003:0DC6:5300.0005/input/input8
[    6.299006] hid-generic 0003:0DC6:5300.0005: input,hidraw4: USB HID v1.10 Device [USB Keyboard + 2P Hub] on usb-0000:00:14.0-10.4.1.1.4.3/input1
[    6.395735] usb 1-10.4.1.1.3: New USB device found, idVendor=1532, idProduct=0101, bcdDevice=21.00
[    6.395738] usb 1-10.4.1.1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    6.395739] usb 1-10.4.1.1.3: Product: Razer Copperhead Laser Mouse
[    6.395739] usb 1-10.4.1.1.3: Manufacturer: Razer
[    6.409496] input: Razer Razer Copperhead Laser Mouse as /devices/pci0000:00/0000:00:14.0/usb1/1-10/1-10.4/1-10.4.1/1-10.4.1.1/1-10.4.1.1.3/1-10.4.1.1.3:1.0/0003:1532:0101.0006/input/input9
[    6.409533] hid-generic 0003:1532:0101.0006: input,hidraw5: USB HID v1.00 Mouse [Razer Razer Copperhead Laser Mouse] on usb-0000:00:14.0-10.4.1.1.3/input0
[    6.410829] input: Razer Razer Copperhead Laser Mouse as /devices/pci0000:00/0000:00:14.0/usb1/1-10/1-10.4/1-10.4.1/1-10.4.1.1/1-10.4.1.1.3/1-10.4.1.1.3:1.1/0003:1532:0101.0007/input/input10
[    6.467182] hid-generic 0003:1532:0101.0007: input,hidraw6: USB HID v0.01 Keyboard [Razer Razer Copperhead Laser Mouse] on usb-0000:00:14.0-10.4.1.1.3/input1
[    6.858987] snd_hda_intel 0000:00:1f.3: Codec #0 probe error; disabling it...
[    7.505015] igc 0000:06:00.0 enp6s0: NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
[    7.874981] snd_hda_intel 0000:00:1f.3: azx_get_response timeout, switching to single_cmd mode: last cmd=0x000f0000
[    7.875187] azx_single_wait_for_response: 17 callbacks suppressed
[    7.875493] hdaudio hdaudioC0D0: no AFG or MFG node found
[    7.875535] snd_hda_intel 0000:00:1f.3: no codecs initialized
[    8.092041] usbcore: registered new interface driver snd-usb-audio
[    8.333980] vboxdrv: Found 16 processor cores
[    8.351174] vboxdrv: TSC mode is Invariant, tentative frequency 3187199515 Hz
[    8.351175] vboxdrv: Successfully loaded version 6.1.30 r148432 (interface 0x00320000)
[    8.553482] VBoxNetFlt: Successfully started.
[    8.554292] VBoxNetAdp: Successfully started.
[   14.882755] ACPI Warning: \_SB.PC00.PEG1.PEGP._DSM: Argument #4 type mismatch - Found [Buffer], ACPI requires [Package] (20210730/nsarguments-61)
[   15.068776] ACPI BIOS Error (bug): Failure creating named object [\_SB.PC00.PEG1.PEGP._DSM.USRG], AE_ALREADY_EXISTS (20210730/dsfield-184)
[   15.068781] ACPI Error: AE_ALREADY_EXISTS, CreateBufferField failure (20210730/dswload2-477)

[   15.068783] No Local Variables are initialized for Method [_DSM]

[   15.068784] Initialized Arguments for Method [_DSM]:  (4 arguments defined for method invocation)
[   15.068784]   Arg0:   0000000049c620e3 <Obj>           Buffer(16) 75 0B A5 D4 C7 65 F7 46
[   15.068788]   Arg1:   00000000bb8e1b26 <Obj>           Integer 0000000000000102
[   15.068790]   Arg2:   0000000041cd70e0 <Obj>           Integer 0000000000000010
[   15.068791]   Arg3:   00000000ac5859db <Obj>           Buffer(4) 00 10 52 44

[   15.068794] ACPI Error: Aborting method \_SB.PC00.PEG1.PEGP._DSM due to previous error (AE_ALREADY_EXISTS) (20210730/psparse-529)
[   15.068916] ACPI BIOS Error (bug): Failure creating named object [\_SB.PC00.PEG1.PEGP._DSM.USRG], AE_ALREADY_EXISTS (20210730/dsfield-184)
[   15.068917] ACPI Error: AE_ALREADY_EXISTS, CreateBufferField failure (20210730/dswload2-477)

[   15.068919] No Local Variables are initialized for Method [_DSM]

[   15.068919] Initialized Arguments for Method [_DSM]:  (4 arguments defined for method invocation)
[   15.068920]   Arg0:   00000000ac5859db <Obj>           Buffer(16) 75 0B A5 D4 C7 65 F7 46
[   15.068922]   Arg1:   0000000041cd70e0 <Obj>           Integer 0000000000000102
[   15.068924]   Arg2:   00000000bb8e1b26 <Obj>           Integer 0000000000000010
[   15.068925]   Arg3:   0000000049c620e3 <Obj>           Buffer(4) 00 20 52 44

[   15.068927] ACPI Error: Aborting method \_SB.PC00.PEG1.PEGP._DSM due to previous error (AE_ALREADY_EXISTS) (20210730/psparse-529)
[   15.069048] ACPI BIOS Error (bug): Failure creating named object [\_SB.PC00.PEG1.PEGP._DSM.USRG], AE_ALREADY_EXISTS (20210730/dsfield-184)
[   15.069050] ACPI Error: AE_ALREADY_EXISTS, CreateBufferField failure (20210730/dswload2-477)

[   15.069051] No Local Variables are initialized for Method [_DSM]

[   15.069052] Initialized Arguments for Method [_DSM]:  (4 arguments defined for method invocation)
[   15.069052]   Arg0:   0000000049c620e3 <Obj>           Buffer(16) 75 0B A5 D4 C7 65 F7 46
[   15.069055]   Arg1:   00000000bb8e1b26 <Obj>           Integer 0000000000000102
[   15.069056]   Arg2:   0000000041cd70e0 <Obj>           Integer 0000000000000010
[   15.069057]   Arg3:   00000000ac5859db <Obj>           Buffer(4) 00 30 52 44

[   15.069059] ACPI Error: Aborting method \_SB.PC00.PEG1.PEGP._DSM due to previous error (AE_ALREADY_EXISTS) (20210730/psparse-529)
[   15.069179] ACPI BIOS Error (bug): Failure creating named object [\_SB.PC00.PEG1.PEGP._DSM.USRG], AE_ALREADY_EXISTS (20210730/dsfield-184)
[   15.069181] ACPI Error: AE_ALREADY_EXISTS, CreateBufferField failure (20210730/dswload2-477)

[   15.069182] No Local Variables are initialized for Method [_DSM]

[   15.069183] Initialized Arguments for Method [_DSM]:  (4 arguments defined for method invocation)
[   15.069183]   Arg0:   00000000ac5859db <Obj>           Buffer(16) 75 0B A5 D4 C7 65 F7 46
[   15.069185]   Arg1:   0000000041cd70e0 <Obj>           Integer 0000000000000102
[   15.069187]   Arg2:   00000000bb8e1b26 <Obj>           Integer 0000000000000010
[   15.069188]   Arg3:   0000000049c620e3 <Obj>           Buffer(4) 00 40 52 44

[   15.069190] ACPI Error: Aborting method \_SB.PC00.PEG1.PEGP._DSM due to previous error (AE_ALREADY_EXISTS) (20210730/psparse-529)
[   15.069310] ACPI BIOS Error (bug): Failure creating named object [\_SB.PC00.PEG1.PEGP._DSM.USRG], AE_ALREADY_EXISTS (20210730/dsfield-184)
[   15.069312] ACPI Error: AE_ALREADY_EXISTS, CreateBufferField failure (20210730/dswload2-477)

[   15.069313] No Local Variables are initialized for Method [_DSM]

[   15.069314] Initialized Arguments for Method [_DSM]:  (4 arguments defined for method invocation)
[   15.069314]   Arg0:   0000000049c620e3 <Obj>           Buffer(16) 75 0B A5 D4 C7 65 F7 46
[   15.069316]   Arg1:   00000000bb8e1b26 <Obj>           Integer 0000000000000102
[   15.069318]   Arg2:   0000000041cd70e0 <Obj>           Integer 0000000000000010
[   15.069319]   Arg3:   00000000ac5859db <Obj>           Buffer(4) 00 50 52 44

[   15.069321] ACPI Error: Aborting method \_SB.PC00.PEG1.PEGP._DSM due to previous error (AE_ALREADY_EXISTS) (20210730/psparse-529)
[   15.069441] ACPI BIOS Error (bug): Failure creating named object [\_SB.PC00.PEG1.PEGP._DSM.USRG], AE_ALREADY_EXISTS (20210730/dsfield-184)
[   15.069443] ACPI Error: AE_ALREADY_EXISTS, CreateBufferField failure (20210730/dswload2-477)

[   15.069444] No Local Variables are initialized for Method [_DSM]

[   15.069444] Initialized Arguments for Method [_DSM]:  (4 arguments defined for method invocation)
[   15.069445]   Arg0:   00000000ac5859db <Obj>           Buffer(16) 75 0B A5 D4 C7 65 F7 46
[   15.069447]   Arg1:   0000000041cd70e0 <Obj>           Integer 0000000000000102
[   15.069449]   Arg2:   00000000bb8e1b26 <Obj>           Integer 0000000000000010
[   15.069450]   Arg3:   0000000049c620e3 <Obj>           Buffer(4) 00 60 52 44

[   15.069452] ACPI Error: Aborting method \_SB.PC00.PEG1.PEGP._DSM due to previous error (AE_ALREADY_EXISTS) (20210730/psparse-529)
[   15.069573] ACPI BIOS Error (bug): Failure creating named object [\_SB.PC00.PEG1.PEGP._DSM.USRG], AE_ALREADY_EXISTS (20210730/dsfield-184)
[   15.069574] ACPI Error: AE_ALREADY_EXISTS, CreateBufferField failure (20210730/dswload2-477)

[   15.069575] No Local Variables are initialized for Method [_DSM]

[   15.069576] Initialized Arguments for Method [_DSM]:  (4 arguments defined for method invocation)
[   15.069576]   Arg0:   0000000049c620e3 <Obj>           Buffer(16) 75 0B A5 D4 C7 65 F7 46
[   15.069579]   Arg1:   00000000bb8e1b26 <Obj>           Integer 0000000000000102
[   15.069580]   Arg2:   0000000041cd70e0 <Obj>           Integer 0000000000000010
[   15.069581]   Arg3:   00000000ac5859db <Obj>           Buffer(4) 00 70 52 44

[   15.069584] ACPI Error: Aborting method \_SB.PC00.PEG1.PEGP._DSM due to previous error (AE_ALREADY_EXISTS) (20210730/psparse-529)
[   15.069704] ACPI BIOS Error (bug): Failure creating named object [\_SB.PC00.PEG1.PEGP._DSM.USRG], AE_ALREADY_EXISTS (20210730/dsfield-184)
[   15.069705] ACPI Error: AE_ALREADY_EXISTS, CreateBufferField failure (20210730/dswload2-477)

[   15.069707] No Local Variables are initialized for Method [_DSM]

[   15.069707] Initialized Arguments for Method [_DSM]:  (4 arguments defined for method invocation)
[   15.069708]   Arg0:   00000000ac5859db <Obj>           Buffer(16) 75 0B A5 D4 C7 65 F7 46
[   15.069710]   Arg1:   0000000041cd70e0 <Obj>           Integer 0000000000000102
[   15.069711]   Arg2:   00000000bb8e1b26 <Obj>           Integer 0000000000000010
[   15.069712]   Arg3:   0000000049c620e3 <Obj>           Buffer(4) 00 80 52 44

[   15.069715] ACPI Error: Aborting method \_SB.PC00.PEG1.PEGP._DSM due to previous error (AE_ALREADY_EXISTS) (20210730/psparse-529)
[   15.069835] ACPI BIOS Error (bug): Failure creating named object [\_SB.PC00.PEG1.PEGP._DSM.USRG], AE_ALREADY_EXISTS (20210730/dsfield-184)
[   15.069836] ACPI Error: AE_ALREADY_EXISTS, CreateBufferField failure (20210730/dswload2-477)

[   15.069837] No Local Variables are initialized for Method [_DSM]

[   15.069838] Initialized Arguments for Method [_DSM]:  (4 arguments defined for method invocation)
[   15.069838]   Arg0:   0000000049c620e3 <Obj>           Buffer(16) 75 0B A5 D4 C7 65 F7 46
[   15.069841]   Arg1:   00000000bb8e1b26 <Obj>           Integer 0000000000000102
[   15.069842]   Arg2:   0000000041cd70e0 <Obj>           Integer 0000000000000010
[   15.069843]   Arg3:   00000000ac5859db <Obj>           Buffer(4) 00 90 52 44

[   15.069845] ACPI Error: Aborting method \_SB.PC00.PEG1.PEGP._DSM due to previous error (AE_ALREADY_EXISTS) (20210730/psparse-529)
[   15.069966] ACPI BIOS Error (bug): Failure creating named object [\_SB.PC00.PEG1.PEGP._DSM.USRG], AE_ALREADY_EXISTS (20210730/dsfield-184)
[   15.069967] ACPI Error: AE_ALREADY_EXISTS, CreateBufferField failure (20210730/dswload2-477)

[   15.069968] No Local Variables are initialized for Method [_DSM]

[   15.069969] Initialized Arguments for Method [_DSM]:  (4 arguments defined for method invocation)
[   15.069969]   Arg0:   00000000ac5859db <Obj>           Buffer(16) 75 0B A5 D4 C7 65 F7 46
[   15.069972]   Arg1:   0000000041cd70e0 <Obj>           Integer 0000000000000102
[   15.069973]   Arg2:   00000000bb8e1b26 <Obj>           Integer 0000000000000010
[   15.069974]   Arg3:   0000000049c620e3 <Obj>           Buffer(4) 00 A0 52 44

[   15.069976] ACPI Error: Aborting method \_SB.PC00.PEG1.PEGP._DSM due to previous error (AE_ALREADY_EXISTS) (20210730/psparse-529)
[   15.070096] ACPI BIOS Error (bug): Failure creating named object [\_SB.PC00.PEG1.PEGP._DSM.USRG], AE_ALREADY_EXISTS (20210730/dsfield-184)
[   15.070098] ACPI Error: AE_ALREADY_EXISTS, CreateBufferField failure (20210730/dswload2-477)

[   15.070099] No Local Variables are initialized for Method [_DSM]

[   15.070099] Initialized Arguments for Method [_DSM]:  (4 arguments defined for method invocation)
[   15.070100]   Arg0:   0000000049c620e3 <Obj>           Buffer(16) 75 0B A5 D4 C7 65 F7 46
[   15.070102]   Arg1:   00000000bb8e1b26 <Obj>           Integer 0000000000000102
[   15.070103]   Arg2:   0000000041cd70e0 <Obj>           Integer 0000000000000010
[   15.070105]   Arg3:   00000000ac5859db <Obj>           Buffer(4) 00 B0 52 44

[   15.070107] ACPI Error: Aborting method \_SB.PC00.PEG1.PEGP._DSM due to previous error (AE_ALREADY_EXISTS) (20210730/psparse-529)
[   15.070228] ACPI BIOS Error (bug): Failure creating named object [\_SB.PC00.PEG1.PEGP._DSM.USRG], AE_ALREADY_EXISTS (20210730/dsfield-184)
[   15.070229] ACPI Error: AE_ALREADY_EXISTS, CreateBufferField failure (20210730/dswload2-477)

[   15.070230] No Local Variables are initialized for Method [_DSM]

[   15.070231] Initialized Arguments for Method [_DSM]:  (4 arguments defined for method invocation)
[   15.070231]   Arg0:   00000000ac5859db <Obj>           Buffer(16) 75 0B A5 D4 C7 65 F7 46
[   15.070234]   Arg1:   0000000041cd70e0 <Obj>           Integer 0000000000000102
[   15.070235]   Arg2:   00000000bb8e1b26 <Obj>           Integer 0000000000000010
[   15.070236]   Arg3:   0000000049c620e3 <Obj>           Buffer(4) 00 C0 52 44

[   15.070238] ACPI Error: Aborting method \_SB.PC00.PEG1.PEGP._DSM due to previous error (AE_ALREADY_EXISTS) (20210730/psparse-529)
[   15.070358] ACPI BIOS Error (bug): Failure creating named object [\_SB.PC00.PEG1.PEGP._DSM.USRG], AE_ALREADY_EXISTS (20210730/dsfield-184)
[   15.070360] ACPI Error: AE_ALREADY_EXISTS, CreateBufferField failure (20210730/dswload2-477)

[   15.070361] No Local Variables are initialized for Method [_DSM]

[   15.070362] Initialized Arguments for Method [_DSM]:  (4 arguments defined for method invocation)
[   15.070362]   Arg0:   0000000049c620e3 <Obj>           Buffer(16) 75 0B A5 D4 C7 65 F7 46
[   15.070364]   Arg1:   00000000bb8e1b26 <Obj>           Integer 0000000000000102
[   15.070366]   Arg2:   0000000041cd70e0 <Obj>           Integer 0000000000000010
[   15.070367]   Arg3:   00000000ac5859db <Obj>           Buffer(4) 00 D0 52 44

[   15.070369] ACPI Error: Aborting method \_SB.PC00.PEG1.PEGP._DSM due to previous error (AE_ALREADY_EXISTS) (20210730/psparse-529)
[   15.070489] ACPI BIOS Error (bug): Failure creating named object [\_SB.PC00.PEG1.PEGP._DSM.USRG], AE_ALREADY_EXISTS (20210730/dsfield-184)
[   15.070491] ACPI Error: AE_ALREADY_EXISTS, CreateBufferField failure (20210730/dswload2-477)

[   15.070492] No Local Variables are initialized for Method [_DSM]

[   15.070492] Initialized Arguments for Method [_DSM]:  (4 arguments defined for method invocation)
[   15.070493]   Arg0:   00000000ac5859db <Obj>           Buffer(16) 75 0B A5 D4 C7 65 F7 46
[   15.070495]   Arg1:   0000000041cd70e0 <Obj>           Integer 0000000000000102
[   15.070496]   Arg2:   00000000bb8e1b26 <Obj>           Integer 0000000000000010
[   15.070498]   Arg3:   0000000049c620e3 <Obj>           Buffer(4) 00 E0 52 44

[   15.070500] ACPI Error: Aborting method \_SB.PC00.PEG1.PEGP._DSM due to previous error (AE_ALREADY_EXISTS) (20210730/psparse-529)
[   15.070620] ACPI BIOS Error (bug): Failure creating named object [\_SB.PC00.PEG1.PEGP._DSM.USRG], AE_ALREADY_EXISTS (20210730/dsfield-184)
[   15.070621] ACPI Error: AE_ALREADY_EXISTS, CreateBufferField failure (20210730/dswload2-477)

[   15.070623] No Local Variables are initialized for Method [_DSM]

[   15.070623] Initialized Arguments for Method [_DSM]:  (4 arguments defined for method invocation)
[   15.070623]   Arg0:   0000000049c620e3 <Obj>           Buffer(16) 75 0B A5 D4 C7 65 F7 46
[   15.070626]   Arg1:   00000000bb8e1b26 <Obj>           Integer 0000000000000102
[   15.070627]   Arg2:   0000000041cd70e0 <Obj>           Integer 0000000000000010
[   15.070628]   Arg3:   00000000ac5859db <Obj>           Buffer(4) 00 F0 52 44

[   15.070631] ACPI Error: Aborting method \_SB.PC00.PEG1.PEGP._DSM due to previous error (AE_ALREADY_EXISTS) (20210730/psparse-529)
[   15.347783] [UFW BLOCK] IN= OUT=enp6s0 SRC=192.168.0.40 DST=192.168.0.1 LEN=84 TOS=0x00 PREC=0x00 TTL=64 ID=41864 DF PROTO=ICMP TYPE=8 CODE=0 ID=1 SEQ=1 
[   15.637910] ACPI BIOS Error (bug): Failure creating named object [\_SB.PC00.PEG1.PEGP._DSM.USRG], AE_ALREADY_EXISTS (20210730/dsfield-184)
[   15.637916] ACPI Error: AE_ALREADY_EXISTS, CreateBufferField failure (20210730/dswload2-477)

[   15.637919] No Local Variables are initialized for Method [_DSM]

[   15.637920] Initialized Arguments for Method [_DSM]:  (4 arguments defined for method invocation)
[   15.637921]   Arg0:   0000000073fd0515 <Obj>           Buffer(16) 75 0B A5 D4 C7 65 F7 46
[   15.637926]   Arg1:   0000000029ec2d43 <Obj>           Integer 0000000000000102
[   15.637928]   Arg2:   0000000042fa44b8 <Obj>           Integer 0000000000000010
[   15.637930]   Arg3:   0000000027157f14 <Obj>           Buffer(4) 00 00 4B 56

[   15.637933] ACPI Error: Aborting method \_SB.PC00.PEG1.PEGP._DSM due to previous error (AE_ALREADY_EXISTS) (20210730/psparse-529)
[   15.638115] ACPI BIOS Error (bug): Failure creating named object [\_SB.PC00.PEG1.PEGP._DSM.USRG], AE_ALREADY_EXISTS (20210730/dsfield-184)
[   15.638117] ACPI Error: AE_ALREADY_EXISTS, CreateBufferField failure (20210730/dswload2-477)

[   15.638119] No Local Variables are initialized for Method [_DSM]

[   15.638119] Initialized Arguments for Method [_DSM]:  (4 arguments defined for method invocation)
[   15.638120]   Arg0:   0000000027157f14 <Obj>           Buffer(16) 75 0B A5 D4 C7 65 F7 46
[   15.638124]   Arg1:   0000000042fa44b8 <Obj>           Integer 0000000000000102
[   15.638125]   Arg2:   0000000029ec2d43 <Obj>           Integer 0000000000000010
[   15.638127]   Arg3:   0000000073fd0515 <Obj>           Buffer(4) 00 00 50 4F

[   15.638130] ACPI Error: Aborting method \_SB.PC00.PEG1.PEGP._DSM due to previous error (AE_ALREADY_EXISTS) (20210730/psparse-529)
-------------- next part --------------
#
# Automatically generated file; DO NOT EDIT.
# Linux/x86 5.15.6 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=90400
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=23400
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23400
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_WERROR is not set
CONFIG_LOCALVERSION=""
# CONFIG_LOCALVERSION_AUTO is not set
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
# CONFIG_KERNEL_GZIP is not set
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_KERNEL_ZSTD=y
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
CONFIG_WATCH_QUEUE=y
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_USELIB=y
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
# CONFIG_NO_HZ_FULL is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
CONFIG_BPF_UNPRIV_DEFAULT_OFF=y
CONFIG_USERMODE_DRIVER=y
# CONFIG_BPF_PRELOAD is not set
CONFIG_BPF_LSM=y
# end of BPF subsystem

# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_SCHED_CORE=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
# CONFIG_IRQ_TIME_ACCOUNTING is not set
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
CONFIG_PSI=y
# CONFIG_PSI_DEFAULT_DISABLED is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
# end of RCU Subsystem

CONFIG_BUILD_BIN2C=y
# CONFIG_IKCONFIG is not set
CONFIG_IKHEADERS=m
CONFIG_LOG_BUF_SHIFT=18
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
# CONFIG_PRINTK_INDEX is not set
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
CONFIG_UCLAMP_TASK=y
CONFIG_UCLAMP_BUCKETS_COUNT=5
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_UCLAMP_TASK_GROUP=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
CONFIG_CGROUP_MISC=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_TIME_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
CONFIG_BOOT_CONFIG=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PC104=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
CONFIG_SLAB_FREELIST_HARDENED=y
CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
CONFIG_SLUB_CPU_PARTIAL=y
CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_NR_GPIO=1024
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_AUDIT_ARCH=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DYNAMIC_PHYSICAL_MASK=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
CONFIG_X86_CPU_RESCTRL=y
CONFIG_X86_EXTENDED_PLATFORM=y
CONFIG_X86_NUMACHIP=y
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
CONFIG_X86_AMD_PLATFORM_DEVICE=y
CONFIG_IOSF_MBI=y
CONFIG_IOSF_MBI_DEBUG=y
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
CONFIG_SCHED_OMIT_FRAME_POINTER=y
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
CONFIG_PARAVIRT_XXL=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
CONFIG_XEN=y
CONFIG_XEN_PV=y
CONFIG_XEN_512GB=y
CONFIG_XEN_PV_SMP=y
CONFIG_XEN_PV_DOM0=y
CONFIG_XEN_PVHVM=y
CONFIG_XEN_PVHVM_SMP=y
CONFIG_XEN_PVHVM_GUEST=y
CONFIG_XEN_SAVE_RESTORE=y
# CONFIG_XEN_DEBUG_FS is not set
CONFIG_XEN_PVH=y
CONFIG_XEN_DOM0=y
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
CONFIG_PVH=y
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
CONFIG_JAILHOUSE_GUEST=y
CONFIG_ACRN_GUEST=y
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_PROCESSOR_SELECT=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_GART_IOMMU=y
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=m
CONFIG_PERF_EVENTS_INTEL_CSTATE=m
# CONFIG_PERF_EVENTS_AMD_POWER is not set
CONFIG_PERF_EVENTS_AMD_UNCORE=m
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_I8K=m
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_AMD=y
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_AMD_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT is not set
CONFIG_NUMA=y
CONFIG_AMD_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
# CONFIG_NUMA_EMU is not set
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ARCH_MEMORY_PROBE=y
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=y
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK=y
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_UMIP=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
CONFIG_X86_SGX=y
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_MIXED=y
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
CONFIG_KEXEC_SIG=y
# CONFIG_KEXEC_SIG_FORCE is not set
CONFIG_KEXEC_BZIMAGE_VERIFY_SIG=y
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_RANDOMIZE_MEMORY=y
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
CONFIG_HOTPLUG_CPU=y
# CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
# CONFIG_LEGACY_VSYSCALL_EMULATE is not set
CONFIG_LEGACY_VSYSCALL_XONLY=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_HIBERNATION_SNAPSHOT_DEV=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
CONFIG_PM_WAKELOCKS=y
CONFIG_PM_WAKELOCKS_LIMIT=100
CONFIG_PM_WAKELOCKS_GC=y
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_PM_ADVANCED_DEBUG=y
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_DPM_WATCHDOG is not set
CONFIG_PM_TRACE=y
CONFIG_PM_TRACE_RTC=y
CONFIG_PM_CLK=y
CONFIG_PM_GENERIC_DOMAINS=y
CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
CONFIG_PM_GENERIC_DOMAINS_SLEEP=y
CONFIG_ENERGY_MODEL=y
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
CONFIG_ACPI_DEBUGGER=y
CONFIG_ACPI_DEBUGGER_USER=y
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_FPDT=y
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=m
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_PLATFORM_PROFILE=m
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
CONFIG_ACPI_BGRT=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_ACPI_NUMA=y
CONFIG_ACPI_HMAT=y
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
# CONFIG_ACPI_APEI_ERST_DEBUG is not set
CONFIG_ACPI_DPTF=y
CONFIG_DPTF_POWER=m
CONFIG_DPTF_PCH_FIVR=m
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
CONFIG_ACPI_CONFIGFS=m
CONFIG_PMIC_OPREGION=y
CONFIG_BYTCRC_PMIC_OPREGION=y
CONFIG_CHTCRC_PMIC_OPREGION=y
CONFIG_XPOWER_PMIC_OPREGION=y
CONFIG_BXT_WC_PMIC_OPREGION=y
CONFIG_CHT_WC_PMIC_OPREGION=y
CONFIG_CHT_DC_TI_PMIC_OPREGION=y
CONFIG_TPS68470_PMIC_OPREGION=y
CONFIG_ACPI_VIOT=y
CONFIG_X86_PM_TIMER=y
CONFIG_ACPI_PRMT=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL=y
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
CONFIG_X86_PCC_CPUFREQ=y
CONFIG_X86_ACPI_CPUFREQ=y
CONFIG_X86_ACPI_CPUFREQ_CPB=y
CONFIG_X86_POWERNOW_K8=y
CONFIG_X86_AMD_FREQ_SENSITIVITY=m
CONFIG_X86_SPEEDSTEP_CENTRINO=y
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
CONFIG_CPU_IDLE_GOV_MENU=y
CONFIG_CPU_IDLE_GOV_TEO=y
CONFIG_CPU_IDLE_GOV_HALTPOLL=y
CONFIG_HALTPOLL_CPUIDLE=m
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_XEN=y
CONFIG_MMCONF_FAM10H=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
CONFIG_ISA_BUS=y
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
CONFIG_X86_X32=y
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
# end of Binary Emulations

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_KVM_XFER_TO_GUEST_WORK=y
CONFIG_HAVE_KVM_PM_NOTIFIER=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
CONFIG_KVM_WERROR=y
CONFIG_KVM_INTEL=m
CONFIG_X86_SGX_KVM=y
CONFIG_KVM_AMD=m
CONFIG_KVM_AMD_SEV=y
CONFIG_KVM_XEN=y
# CONFIG_KVM_MMU_AUDIT is not set
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_ARCH_WANTS_NO_INSTR=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
# CONFIG_SECCOMP_CACHE_DEBUG is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_ISA_BUS_API=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_ARCH_HAS_CC_PLATFORM=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_HAS_ELFCORE_COMPAT=y
CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_MODVERSIONS=y
CONFIG_ASM_MODVERSIONS=y
CONFIG_MODULE_SRCVERSION_ALL=y
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
# CONFIG_MODULE_SIG_SHA256 is not set
# CONFIG_MODULE_SIG_SHA384 is not set
CONFIG_MODULE_SIG_SHA512=y
CONFIG_MODULE_SIG_HASH="sha512"
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH="/sbin/modprobe"
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_RQ_ALLOC_TIME=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=y
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
CONFIG_BLK_WBT=y
CONFIG_BLK_WBT_MQ=y
# CONFIG_BLK_CGROUP_IOLATENCY is not set
CONFIG_BLK_CGROUP_FC_APPID=y
CONFIG_BLK_CGROUP_IOCOST=y
CONFIG_BLK_CGROUP_IOPRIO=y
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_DEBUG_FS_ZONED=y
CONFIG_BLK_SED_OPAL=y
CONFIG_BLK_INLINE_ENCRYPTION=y
CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK=y

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
CONFIG_AIX_PARTITION=y
CONFIG_OSF_PARTITION=y
CONFIG_AMIGA_PARTITION=y
CONFIG_ATARI_PARTITION=y
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
CONFIG_LDM_PARTITION=y
# CONFIG_LDM_DEBUG is not set
CONFIG_SGI_PARTITION=y
CONFIG_ULTRIX_PARTITION=y
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
CONFIG_EFI_PARTITION=y
CONFIG_SYSV68_PARTITION=y
CONFIG_CMDLINE_PARTITION=y
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_MQ_RDMA=y
CONFIG_BLK_PM=y
CONFIG_BLOCK_HOLDER_DEPRECATED=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=m
CONFIG_IOSCHED_BFQ=m
CONFIG_BFQ_GROUP_IOSCHED=y
# CONFIG_BFQ_CGROUP_DEBUG is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_MHP_MEMMAP_ON_MEMORY=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=65536
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_TRANSPARENT_HUGEPAGE=y
# CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
CONFIG_CLEANCACHE=y
CONFIG_FRONTSWAP=y
# CONFIG_CMA is not set
CONFIG_MEM_SOFT_DIRTY=y
CONFIG_ZSWAP=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lzo"
CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=y
# CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT="zbud"
# CONFIG_ZSWAP_DEFAULT_ON is not set
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
CONFIG_Z3FOLD=m
CONFIG_ZSMALLOC=y
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ARCH_HAS_ZONE_DMA_SET=y
CONFIG_ZONE_DMA=y
CONFIG_ZONE_DMA32=y
CONFIG_ZONE_DEVICE=y
CONFIG_DEV_PAGEMAP_OPS=y
CONFIG_HMM_MIRROR=y
CONFIG_DEVICE_PRIVATE=y
CONFIG_VMAP_PFN=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_MAPPING_DIRTY_HELPERS=y
CONFIG_SECRETMEM=y

#
# Data Access Monitoring
#
# CONFIG_DAMON is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y
CONFIG_WANT_COMPAT_NETLINK_MESSAGES=y
CONFIG_COMPAT_NETLINK_MESSAGES=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_NET_REDIRECT=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
CONFIG_UNIX_DIAG=m
CONFIG_TLS=m
CONFIG_TLS_DEVICE=y
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=m
CONFIG_XFRM_USER=m
CONFIG_XFRM_USER_COMPAT=m
CONFIG_XFRM_INTERFACE=m
# CONFIG_XFRM_SUB_POLICY is not set
# CONFIG_XFRM_MIGRATE is not set
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_AH=m
CONFIG_XFRM_ESP=m
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
# CONFIG_NET_KEY_MIGRATE is not set
CONFIG_XFRM_ESPINTCP=y
CONFIG_SMC=m
CONFIG_SMC_DIAG=m
CONFIG_XDP_SOCKETS=y
CONFIG_XDP_SOCKETS_DIAG=m
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=m
CONFIG_NET_FOU=m
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_ESP_OFFLOAD=m
CONFIG_INET_ESPINTCP=y
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
CONFIG_INET_RAW_DIAG=m
CONFIG_INET_DIAG_DESTROY=y
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
CONFIG_TCP_CONG_NV=m
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
CONFIG_TCP_CONG_CDG=m
CONFIG_TCP_CONG_BBR=m
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_ESP_OFFLOAD=m
CONFIG_INET6_ESPINTCP=y
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
CONFIG_IPV6_ILA=m
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
CONFIG_IPV6_GRE=m
CONFIG_IPV6_FOU=m
CONFIG_IPV6_FOU_TUNNEL=m
CONFIG_IPV6_MULTIPLE_TABLES=y
CONFIG_IPV6_SUBTREES=y
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
CONFIG_IPV6_SEG6_LWTUNNEL=y
CONFIG_IPV6_SEG6_HMAC=y
CONFIG_IPV6_SEG6_BPF=y
# CONFIG_IPV6_RPL_LWTUNNEL is not set
CONFIG_IPV6_IOAM6_LWTUNNEL=y
CONFIG_NETLABEL=y
CONFIG_MPTCP=y
CONFIG_INET_MPTCP_DIAG=m
CONFIG_MPTCP_IPV6=y
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
CONFIG_NETFILTER_NETLINK_HOOK=m
CONFIG_NETFILTER_NETLINK_ACCT=m
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_SYSLOG=m
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
# CONFIG_NF_CONNTRACK_PROCFS is not set
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_CT_NETLINK_TIMEOUT=m
CONFIG_NF_CT_NETLINK_HELPER=m
CONFIG_NETFILTER_NETLINK_GLUE_CT=y
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
CONFIG_NFT_NUMGEN=m
CONFIG_NFT_CT=m
CONFIG_NFT_FLOW_OFFLOAD=m
CONFIG_NFT_COUNTER=m
CONFIG_NFT_CONNLIMIT=m
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
CONFIG_NFT_TUNNEL=m
CONFIG_NFT_OBJREF=m
CONFIG_NFT_QUEUE=m
CONFIG_NFT_QUOTA=m
CONFIG_NFT_REJECT=m
CONFIG_NFT_REJECT_INET=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
CONFIG_NFT_FIB=m
CONFIG_NFT_FIB_INET=m
CONFIG_NFT_XFRM=m
CONFIG_NFT_SOCKET=m
CONFIG_NFT_OSF=m
CONFIG_NFT_TPROXY=m
CONFIG_NFT_SYNPROXY=m
CONFIG_NF_DUP_NETDEV=m
CONFIG_NFT_DUP_NETDEV=m
CONFIG_NFT_FWD_NETDEV=m
CONFIG_NFT_FIB_NETDEV=m
CONFIG_NFT_REJECT_NETDEV=m
CONFIG_NF_FLOW_TABLE_INET=m
CONFIG_NF_FLOW_TABLE=m
CONFIG_NETFILTER_XTABLES=m
CONFIG_NETFILTER_XTABLES_COMPAT=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
CONFIG_NETFILTER_XT_TARGET_LED=m
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
# CONFIG_NETFILTER_XT_TARGET_NOTRACK is not set
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
CONFIG_NETFILTER_XT_MATCH_IPCOMP=m
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
CONFIG_NETFILTER_XT_MATCH_L2TP=m
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
CONFIG_NETFILTER_XT_MATCH_NFACCT=m
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
CONFIG_NETFILTER_XT_MATCH_TIME=m
CONFIG_NETFILTER_XT_MATCH_U32=m
# end of Core Netfilter Configuration

CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
CONFIG_IP_SET_HASH_IPMARK=m
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
CONFIG_IP_SET_HASH_IPMAC=m
CONFIG_IP_SET_HASH_MAC=m
CONFIG_IP_SET_HASH_NETPORTNET=m
CONFIG_IP_SET_HASH_NET=m
CONFIG_IP_SET_HASH_NETNET=m
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_FO=m
CONFIG_IP_VS_OVF=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
CONFIG_IP_VS_MH=m
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m
CONFIG_IP_VS_TWOS=m

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
CONFIG_NF_TABLES_IPV4=y
CONFIG_NFT_REJECT_IPV4=m
CONFIG_NFT_DUP_IPV4=m
CONFIG_NFT_FIB_IPV4=m
CONFIG_NF_TABLES_ARP=y
CONFIG_NF_FLOW_TABLE_IPV4=m
CONFIG_NF_DUP_IPV4=m
CONFIG_NF_LOG_ARP=m
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_CLUSTERIP=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
CONFIG_NF_TABLES_IPV6=y
CONFIG_NFT_REJECT_IPV6=m
CONFIG_NFT_DUP_IPV6=m
CONFIG_NFT_FIB_IPV6=m
CONFIG_NF_FLOW_TABLE_IPV6=m
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
CONFIG_IP6_NF_MATCH_SRH=m
CONFIG_IP6_NF_TARGET_HL=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m

#
# DECnet: Netfilter Configuration
#
CONFIG_DECNET_NF_GRABULATOR=m
# end of DECnet: Netfilter Configuration

CONFIG_NF_TABLES_BRIDGE=m
CONFIG_NFT_BRIDGE_META=m
CONFIG_NFT_BRIDGE_REJECT=m
CONFIG_NF_CONNTRACK_BRIDGE=m
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
CONFIG_BPFILTER=y
CONFIG_BPFILTER_UMH=m
CONFIG_IP_DCCP=m
CONFIG_INET_DCCP_DIAG=m

#
# DCCP CCIDs Configuration
#
# CONFIG_IP_DCCP_CCID2_DEBUG is not set
# CONFIG_IP_DCCP_CCID3 is not set
# end of DCCP CCIDs Configuration

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
# end of DCCP Kernel Hacking

CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
CONFIG_RDS=m
CONFIG_RDS_RDMA=m
CONFIG_RDS_TCP=m
# CONFIG_RDS_DEBUG is not set
CONFIG_TIPC=m
CONFIG_TIPC_MEDIA_IB=y
CONFIG_TIPC_MEDIA_UDP=y
CONFIG_TIPC_CRYPTO=y
CONFIG_TIPC_DIAG=m
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
CONFIG_ATM_MPOA=m
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
CONFIG_BRIDGE_MRP=y
CONFIG_BRIDGE_CFM=y
CONFIG_NET_DSA=m
CONFIG_NET_DSA_TAG_AR9331=m
CONFIG_NET_DSA_TAG_BRCM_COMMON=m
CONFIG_NET_DSA_TAG_BRCM=m
CONFIG_NET_DSA_TAG_BRCM_LEGACY=m
CONFIG_NET_DSA_TAG_BRCM_PREPEND=m
CONFIG_NET_DSA_TAG_HELLCREEK=m
CONFIG_NET_DSA_TAG_GSWIP=m
CONFIG_NET_DSA_TAG_DSA_COMMON=m
CONFIG_NET_DSA_TAG_DSA=m
CONFIG_NET_DSA_TAG_EDSA=m
CONFIG_NET_DSA_TAG_MTK=m
CONFIG_NET_DSA_TAG_KSZ=m
CONFIG_NET_DSA_TAG_RTL4_A=m
CONFIG_NET_DSA_TAG_OCELOT=m
CONFIG_NET_DSA_TAG_OCELOT_8021Q=m
CONFIG_NET_DSA_TAG_QCA=m
CONFIG_NET_DSA_TAG_LAN9303=m
CONFIG_NET_DSA_TAG_SJA1105=m
CONFIG_NET_DSA_TAG_TRAILER=m
CONFIG_NET_DSA_TAG_XRS700X=m
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
CONFIG_DECNET=m
# CONFIG_DECNET_ROUTER is not set
CONFIG_LLC=m
CONFIG_LLC2=m
CONFIG_ATALK=m
CONFIG_DEV_APPLETALK=m
CONFIG_LTPC=m
# CONFIG_IPDDP is not set
CONFIG_X25=m
CONFIG_LAPB=m
CONFIG_PHONET=m
CONFIG_6LOWPAN=m
# CONFIG_6LOWPAN_DEBUGFS is not set
CONFIG_6LOWPAN_NHC=m
CONFIG_6LOWPAN_NHC_DEST=m
CONFIG_6LOWPAN_NHC_FRAGMENT=m
CONFIG_6LOWPAN_NHC_HOP=m
CONFIG_6LOWPAN_NHC_IPV6=m
CONFIG_6LOWPAN_NHC_MOBILITY=m
CONFIG_6LOWPAN_NHC_ROUTING=m
CONFIG_6LOWPAN_NHC_UDP=m
# CONFIG_6LOWPAN_GHC_EXT_HDR_HOP is not set
# CONFIG_6LOWPAN_GHC_UDP is not set
# CONFIG_6LOWPAN_GHC_ICMPV6 is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_DEST is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_FRAG is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_ROUTE is not set
CONFIG_IEEE802154=m
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=m
CONFIG_IEEE802154_6LOWPAN=m
CONFIG_MAC802154=m
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_CBS=m
CONFIG_NET_SCH_ETF=m
CONFIG_NET_SCH_TAPRIO=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
CONFIG_NET_SCH_SKBPRIO=m
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=m
CONFIG_NET_SCH_CAKE=m
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=m
CONFIG_NET_SCH_PIE=m
CONFIG_NET_SCH_FQ_PIE=m
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_PLUG=m
CONFIG_NET_SCH_ETS=m
# CONFIG_NET_SCH_DEFAULT is not set

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
# CONFIG_CLS_U32_PERF is not set
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=m
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
CONFIG_NET_EMATCH_CANID=m
CONFIG_NET_EMATCH_IPSET=m
CONFIG_NET_EMATCH_IPT=m
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
CONFIG_NET_ACT_IPT=m
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
CONFIG_NET_ACT_MPLS=m
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
CONFIG_NET_ACT_CONNMARK=m
CONFIG_NET_ACT_CTINFO=m
CONFIG_NET_ACT_SKBMOD=m
# CONFIG_NET_ACT_IFE is not set
CONFIG_NET_ACT_TUNNEL_KEY=m
CONFIG_NET_ACT_CT=m
CONFIG_NET_ACT_GATE=m
CONFIG_NET_TC_SKB_EXT=y
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=y
CONFIG_BATMAN_ADV=m
# CONFIG_BATMAN_ADV_BATMAN_V is not set
CONFIG_BATMAN_ADV_BLA=y
CONFIG_BATMAN_ADV_DAT=y
CONFIG_BATMAN_ADV_NC=y
CONFIG_BATMAN_ADV_MCAST=y
# CONFIG_BATMAN_ADV_DEBUG is not set
# CONFIG_BATMAN_ADV_TRACING is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_OPENVSWITCH_VXLAN=m
CONFIG_OPENVSWITCH_GENEVE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_HYPERV_VSOCKETS=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=m
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=m
CONFIG_HSR=m
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
CONFIG_QRTR=m
CONFIG_QRTR_SMD=m
CONFIG_QRTR_TUN=m
CONFIG_QRTR_MHI=m
CONFIG_NET_NCSI=y
CONFIG_NCSI_OEM_CMD_GET_MAC=y
# CONFIG_NCSI_OEM_CMD_KEEP_PHY is not set
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

CONFIG_HAMRADIO=y

#
# Packet Radio protocols
#
CONFIG_AX25=m
CONFIG_AX25_DAMA_SLAVE=y
CONFIG_NETROM=m
CONFIG_ROSE=m

#
# AX.25 network device drivers
#
CONFIG_MKISS=m
CONFIG_6PACK=m
CONFIG_BPQETHER=m
CONFIG_BAYCOM_SER_FDX=m
CONFIG_BAYCOM_SER_HDX=m
CONFIG_BAYCOM_PAR=m
CONFIG_YAM=m
# end of AX.25 network device drivers

CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m
CONFIG_CAN_J1939=m
CONFIG_CAN_ISOTP=m

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=m
CONFIG_CAN_VXCAN=m
CONFIG_CAN_SLCAN=m
CONFIG_CAN_DEV=m
CONFIG_CAN_CALC_BITTIMING=y
CONFIG_CAN_JANZ_ICAN3=m
CONFIG_CAN_KVASER_PCIEFD=m
CONFIG_CAN_C_CAN=m
CONFIG_CAN_C_CAN_PLATFORM=m
CONFIG_CAN_C_CAN_PCI=m
CONFIG_CAN_CC770=m
CONFIG_CAN_CC770_ISA=m
CONFIG_CAN_CC770_PLATFORM=m
CONFIG_CAN_IFI_CANFD=m
CONFIG_CAN_M_CAN=m
CONFIG_CAN_M_CAN_PCI=m
CONFIG_CAN_M_CAN_PLATFORM=m
CONFIG_CAN_M_CAN_TCAN4X5X=m
CONFIG_CAN_PEAK_PCIEFD=m
CONFIG_CAN_SJA1000=m
CONFIG_CAN_EMS_PCI=m
CONFIG_CAN_EMS_PCMCIA=m
CONFIG_CAN_F81601=m
CONFIG_CAN_KVASER_PCI=m
CONFIG_CAN_PEAK_PCI=m
CONFIG_CAN_PEAK_PCIEC=y
CONFIG_CAN_PEAK_PCMCIA=m
CONFIG_CAN_PLX_PCI=m
CONFIG_CAN_SJA1000_ISA=m
CONFIG_CAN_SJA1000_PLATFORM=m
CONFIG_CAN_SOFTING=m
CONFIG_CAN_SOFTING_CS=m

#
# CAN SPI interfaces
#
CONFIG_CAN_HI311X=m
CONFIG_CAN_MCP251X=m
CONFIG_CAN_MCP251XFD=m
# CONFIG_CAN_MCP251XFD_SANITY is not set
# end of CAN SPI interfaces

#
# CAN USB interfaces
#
CONFIG_CAN_8DEV_USB=m
CONFIG_CAN_EMS_USB=m
CONFIG_CAN_ESD_USB2=m
CONFIG_CAN_ETAS_ES58X=m
CONFIG_CAN_GS_USB=m
CONFIG_CAN_KVASER_USB=m
CONFIG_CAN_MCBA_USB=m
CONFIG_CAN_PEAK_USB=m
CONFIG_CAN_UCAN=m
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
# end of CAN Device Drivers

CONFIG_BT=m
CONFIG_BT_BREDR=y
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
CONFIG_BT_CMTP=m
CONFIG_BT_HIDP=m
CONFIG_BT_HS=y
CONFIG_BT_LE=y
CONFIG_BT_6LOWPAN=m
CONFIG_BT_LEDS=y
CONFIG_BT_MSFTEXT=y
CONFIG_BT_AOSPEXT=y
CONFIG_BT_DEBUGFS=y
# CONFIG_BT_SELFTEST is not set

#
# Bluetooth device drivers
#
CONFIG_BT_INTEL=m
CONFIG_BT_BCM=m
CONFIG_BT_RTL=m
CONFIG_BT_QCA=m
CONFIG_BT_HCIBTUSB=m
CONFIG_BT_HCIBTUSB_AUTOSUSPEND=y
CONFIG_BT_HCIBTUSB_BCM=y
CONFIG_BT_HCIBTUSB_MTK=y
CONFIG_BT_HCIBTUSB_RTL=y
CONFIG_BT_HCIBTSDIO=m
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_SERDEV=y
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_NOKIA=m
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIUART_ATH3K=y
CONFIG_BT_HCIUART_LL=y
CONFIG_BT_HCIUART_3WIRE=y
CONFIG_BT_HCIUART_INTEL=y
CONFIG_BT_HCIUART_BCM=y
CONFIG_BT_HCIUART_RTL=y
CONFIG_BT_HCIUART_QCA=y
CONFIG_BT_HCIUART_AG6XX=y
CONFIG_BT_HCIUART_MRVL=y
CONFIG_BT_HCIBCM203X=m
CONFIG_BT_HCIBPA10X=m
CONFIG_BT_HCIBFUSB=m
CONFIG_BT_HCIDTL1=m
CONFIG_BT_HCIBT3C=m
CONFIG_BT_HCIBLUECARD=m
CONFIG_BT_HCIVHCI=m
CONFIG_BT_MRVL=m
CONFIG_BT_MRVL_SDIO=m
CONFIG_BT_ATH3K=m
CONFIG_BT_MTKSDIO=m
CONFIG_BT_MTKUART=m
CONFIG_BT_HCIRSI=m
CONFIG_BT_VIRTIO=m
# end of Bluetooth device drivers

CONFIG_AF_RXRPC=m
CONFIG_AF_RXRPC_IPV6=y
# CONFIG_AF_RXRPC_INJECT_LOSS is not set
# CONFIG_AF_RXRPC_DEBUG is not set
CONFIG_RXKAD=y
CONFIG_AF_KCM=m
CONFIG_STREAM_PARSER=y
CONFIG_MCTP=m
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WIRELESS_EXT=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_WEXT_SPY=y
CONFIG_WEXT_PRIV=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
CONFIG_CFG80211_DEBUGFS=y
CONFIG_CFG80211_CRDA_SUPPORT=y
CONFIG_CFG80211_WEXT=y
CONFIG_CFG80211_WEXT_EXPORT=y
CONFIG_LIB80211=m
CONFIG_LIB80211_CRYPT_WEP=m
CONFIG_LIB80211_CRYPT_CCMP=m
CONFIG_LIB80211_CRYPT_TKIP=m
# CONFIG_LIB80211_DEBUG is not set
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
CONFIG_MAC80211_MESH=y
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
CONFIG_MAC80211_MESSAGE_TRACING=y
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_RFKILL=y
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
CONFIG_RFKILL_GPIO=m
CONFIG_NET_9P=m
CONFIG_NET_9P_VIRTIO=m
CONFIG_NET_9P_XEN=m
CONFIG_NET_9P_RDMA=m
# CONFIG_NET_9P_DEBUG is not set
CONFIG_CAIF=m
# CONFIG_CAIF_DEBUG is not set
CONFIG_CAIF_NETDEV=m
CONFIG_CAIF_USB=m
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
CONFIG_NFC=m
CONFIG_NFC_DIGITAL=m
CONFIG_NFC_NCI=m
CONFIG_NFC_NCI_SPI=m
CONFIG_NFC_NCI_UART=m
CONFIG_NFC_HCI=m
CONFIG_NFC_SHDLC=y

#
# Near Field Communication (NFC) devices
#
CONFIG_NFC_TRF7970A=m
CONFIG_NFC_MEI_PHY=m
CONFIG_NFC_SIM=m
CONFIG_NFC_PORT100=m
CONFIG_NFC_VIRTUAL_NCI=m
CONFIG_NFC_FDP=m
CONFIG_NFC_FDP_I2C=m
CONFIG_NFC_PN544=m
CONFIG_NFC_PN544_I2C=m
CONFIG_NFC_PN544_MEI=m
CONFIG_NFC_PN533=m
CONFIG_NFC_PN533_USB=m
CONFIG_NFC_PN533_I2C=m
CONFIG_NFC_PN532_UART=m
CONFIG_NFC_MICROREAD=m
CONFIG_NFC_MICROREAD_I2C=m
CONFIG_NFC_MICROREAD_MEI=m
CONFIG_NFC_MRVL=m
CONFIG_NFC_MRVL_USB=m
CONFIG_NFC_MRVL_UART=m
CONFIG_NFC_MRVL_I2C=m
CONFIG_NFC_MRVL_SPI=m
CONFIG_NFC_ST21NFCA=m
CONFIG_NFC_ST21NFCA_I2C=m
CONFIG_NFC_ST_NCI=m
CONFIG_NFC_ST_NCI_I2C=m
CONFIG_NFC_ST_NCI_SPI=m
CONFIG_NFC_NXP_NCI=m
CONFIG_NFC_NXP_NCI_I2C=m
CONFIG_NFC_S3FWRN5=m
CONFIG_NFC_S3FWRN5_I2C=m
CONFIG_NFC_S3FWRN82_UART=m
CONFIG_NFC_ST95HF=m
# end of Near Field Communication (NFC) devices

CONFIG_PSAMPLE=m
CONFIG_NET_IFE=m
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_SOCK_VALIDATE_XMIT=y
CONFIG_NET_SELFTESTS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_PAGE_POOL=y
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
CONFIG_EISA=y
CONFIG_EISA_VLB_PRIMING=y
CONFIG_EISA_PCI_EISA=y
CONFIG_EISA_VIRTUAL_ROOT=y
CONFIG_EISA_NAMES=y
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
# CONFIG_PCIEAER_INJECT is not set
# CONFIG_PCIE_ECRC is not set
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
CONFIG_PCIE_DPC=y
CONFIG_PCIE_PTM=y
# CONFIG_PCIE_EDR is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
CONFIG_PCI_REALLOC_ENABLE_AUTO=y
CONFIG_PCI_STUB=m
CONFIG_PCI_PF_STUB=m
CONFIG_XEN_PCIDEV_FRONTEND=m
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
CONFIG_PCI_HYPERV=m
# CONFIG_PCIE_BUS_TUNE_OFF is not set
CONFIG_PCIE_BUS_DEFAULT=y
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
CONFIG_HOTPLUG_PCI_CPCI=y
CONFIG_HOTPLUG_PCI_CPCI_ZT5550=m
CONFIG_HOTPLUG_PCI_CPCI_GENERIC=m
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
CONFIG_VMD=m
CONFIG_PCI_HYPERV_INTERFACE=m

#
# DesignWare PCI Core Support
#
CONFIG_PCIE_DW=y
CONFIG_PCIE_DW_HOST=y
CONFIG_PCIE_DW_EP=y
CONFIG_PCIE_DW_PLAT=y
CONFIG_PCIE_DW_PLAT_HOST=y
CONFIG_PCIE_DW_PLAT_EP=y
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
CONFIG_PCI_ENDPOINT=y
CONFIG_PCI_ENDPOINT_CONFIGFS=y
# CONFIG_PCI_EPF_TEST is not set
CONFIG_PCI_EPF_NTB=m
# end of PCI Endpoint

#
# PCI switch controller drivers
#
CONFIG_PCI_SW_SWITCHTEC=m
# end of PCI switch controller drivers

CONFIG_CXL_BUS=m
CONFIG_CXL_MEM=m
# CONFIG_CXL_MEM_RAW_COMMANDS is not set
CONFIG_CXL_ACPI=m
CONFIG_CXL_PMEM=m
CONFIG_PCCARD=m
CONFIG_PCMCIA=m
CONFIG_PCMCIA_LOAD_CIS=y
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=m
CONFIG_YENTA_O2=y
CONFIG_YENTA_RICOH=y
CONFIG_YENTA_TI=y
CONFIG_YENTA_ENE_TUNE=y
CONFIG_YENTA_TOSHIBA=y
CONFIG_PD6729=m
CONFIG_I82092=m
CONFIG_PCCARD_NONSTATIC=y
CONFIG_RAPIDIO=y
CONFIG_RAPIDIO_TSI721=m
CONFIG_RAPIDIO_DISC_TIMEOUT=30
# CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS is not set
CONFIG_RAPIDIO_DMA_ENGINE=y
# CONFIG_RAPIDIO_DEBUG is not set
CONFIG_RAPIDIO_ENUM_BASIC=m
CONFIG_RAPIDIO_CHMAN=m
CONFIG_RAPIDIO_MPORT_CDEV=m

#
# RapidIO Switch drivers
#
CONFIG_RAPIDIO_TSI57X=m
CONFIG_RAPIDIO_CPS_XX=m
CONFIG_RAPIDIO_TSI568=m
CONFIG_RAPIDIO_CPS_GEN2=m
CONFIG_RAPIDIO_RXS_GEN3=m
# end of RapidIO Switch drivers

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
# CONFIG_STANDALONE is not set
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
CONFIG_FW_LOADER_COMPRESS=y
CONFIG_FW_CACHE=y
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_HMEM_REPORTING=y
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_SYS_HYPERVISOR=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SLIMBUS=m
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_SPMI=m
CONFIG_REGMAP_W1=m
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_SOUNDWIRE=m
CONFIG_REGMAP_SOUNDWIRE_MBQ=m
CONFIG_REGMAP_SCCB=m
CONFIG_REGMAP_I3C=m
CONFIG_REGMAP_SPI_AVMM=m
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
CONFIG_MHI_BUS=m
# CONFIG_MHI_BUS_DEBUG is not set
CONFIG_MHI_BUS_PCI_GENERIC=m
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

CONFIG_EDD=y
CONFIG_EDD_OFF=y
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=m
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_ISCSI_IBFT_FIND=y
CONFIG_ISCSI_IBFT=m
CONFIG_FW_CFG_SYSFS=m
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
CONFIG_SYSFB=y
# CONFIG_SYSFB_SIMPLEFB is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=m
# CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE is not set
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_SOFT_RESERVE=y
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER=y
CONFIG_EFI_BOOTLOADER_CONTROL=m
CONFIG_EFI_CAPSULE_LOADER=m
CONFIG_EFI_TEST=m
CONFIG_APPLE_PROPERTIES=y
CONFIG_RESET_ATTACK_MITIGATION=y
CONFIG_EFI_RCI2_TABLE=y
# CONFIG_EFI_DISABLE_PCI_DMA is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_EFI_EMBEDDED_FIRMWARE=y
CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y
CONFIG_EFI_DEV_PATH_PARSER=y
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_GNSS=m
CONFIG_GNSS_SERIAL=m
CONFIG_GNSS_MTK_SERIAL=m
CONFIG_GNSS_SIRF_SERIAL=m
CONFIG_GNSS_UBX_SERIAL=m
CONFIG_MTD=m
# CONFIG_MTD_TESTS is not set

#
# Partition parsers
#
CONFIG_MTD_AR7_PARTS=m
CONFIG_MTD_CMDLINE_PARTS=m
CONFIG_MTD_REDBOOT_PARTS=m
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
# CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
# CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=m
CONFIG_MTD_BLOCK=m
CONFIG_MTD_BLOCK_RO=m

#
# Note that in some cases UBI block is preferred. See MTD_UBI_BLOCK.
#
CONFIG_FTL=m
CONFIG_NFTL=m
CONFIG_NFTL_RW=y
CONFIG_INFTL=m
CONFIG_RFD_FTL=m
CONFIG_SSFDC=m
CONFIG_SM_FTL=m
CONFIG_MTD_OOPS=m
CONFIG_MTD_PSTORE=m
CONFIG_MTD_SWAP=m
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=m
CONFIG_MTD_JEDECPROBE=m
CONFIG_MTD_GEN_PROBE=m
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
CONFIG_MTD_CFI_INTELEXT=m
CONFIG_MTD_CFI_AMDSTD=m
CONFIG_MTD_CFI_STAA=m
CONFIG_MTD_CFI_UTIL=m
CONFIG_MTD_RAM=m
CONFIG_MTD_ROM=m
CONFIG_MTD_ABSENT=m
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
CONFIG_MTD_PHYSMAP=m
# CONFIG_MTD_PHYSMAP_COMPAT is not set
CONFIG_MTD_PHYSMAP_GPIO_ADDR=y
CONFIG_MTD_SBC_GXX=m
CONFIG_MTD_AMD76XROM=m
CONFIG_MTD_ICHXROM=m
CONFIG_MTD_ESB2ROM=m
CONFIG_MTD_CK804XROM=m
CONFIG_MTD_SCB2_FLASH=m
CONFIG_MTD_NETtel=m
CONFIG_MTD_L440GX=m
CONFIG_MTD_PCI=m
CONFIG_MTD_PCMCIA=m
# CONFIG_MTD_PCMCIA_ANONYMOUS is not set
CONFIG_MTD_INTEL_VR_NOR=m
CONFIG_MTD_PLATRAM=m
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
CONFIG_MTD_PMC551=m
# CONFIG_MTD_PMC551_BUGFIX is not set
# CONFIG_MTD_PMC551_DEBUG is not set
CONFIG_MTD_DATAFLASH=m
# CONFIG_MTD_DATAFLASH_WRITE_VERIFY is not set
CONFIG_MTD_DATAFLASH_OTP=y
CONFIG_MTD_MCHP23K256=m
CONFIG_MTD_MCHP48L640=m
CONFIG_MTD_SST25L=m
CONFIG_MTD_SLRAM=m
CONFIG_MTD_PHRAM=m
CONFIG_MTD_MTDRAM=m
CONFIG_MTDRAM_TOTAL_SIZE=4096
CONFIG_MTDRAM_ERASE_SIZE=128
CONFIG_MTD_BLOCK2MTD=m

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
# end of Self-contained MTD device drivers

#
# NAND
#
CONFIG_MTD_NAND_CORE=m
CONFIG_MTD_ONENAND=m
CONFIG_MTD_ONENAND_VERIFY_WRITE=y
CONFIG_MTD_ONENAND_GENERIC=m
# CONFIG_MTD_ONENAND_OTP is not set
CONFIG_MTD_ONENAND_2X_PROGRAM=y
CONFIG_MTD_RAW_NAND=m

#
# Raw/parallel NAND flash controllers
#
CONFIG_MTD_NAND_DENALI=m
CONFIG_MTD_NAND_DENALI_PCI=m
CONFIG_MTD_NAND_CAFE=m
CONFIG_MTD_NAND_MXIC=m
CONFIG_MTD_NAND_GPIO=m
CONFIG_MTD_NAND_PLATFORM=m
CONFIG_MTD_NAND_ARASAN=m

#
# Misc
#
CONFIG_MTD_SM_COMMON=m
CONFIG_MTD_NAND_NANDSIM=m
CONFIG_MTD_NAND_RICOH=m
CONFIG_MTD_NAND_DISKONCHIP=m
# CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADVANCED is not set
CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADDRESS=0
# CONFIG_MTD_NAND_DISKONCHIP_BBTWRITE is not set
CONFIG_MTD_SPI_NAND=m

#
# ECC engine support
#
CONFIG_MTD_NAND_ECC=y
CONFIG_MTD_NAND_ECC_SW_HAMMING=y
# CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC is not set
CONFIG_MTD_NAND_ECC_SW_BCH=y
# end of ECC engine support
# end of NAND

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=m
CONFIG_MTD_QINFO_PROBE=m
# end of LPDDR & LPDDR2 PCM memory drivers

CONFIG_MTD_SPI_NOR=m
CONFIG_MTD_SPI_NOR_USE_4K_SECTORS=y
# CONFIG_MTD_SPI_NOR_SWP_DISABLE is not set
CONFIG_MTD_SPI_NOR_SWP_DISABLE_ON_VOLATILE=y
# CONFIG_MTD_SPI_NOR_SWP_KEEP is not set
# CONFIG_SPI_INTEL_SPI_PCI is not set
# CONFIG_SPI_INTEL_SPI_PLATFORM is not set
CONFIG_MTD_UBI=m
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
CONFIG_MTD_UBI_FASTMAP=y
CONFIG_MTD_UBI_GLUEBI=m
CONFIG_MTD_UBI_BLOCK=y
CONFIG_MTD_HYPERBUS=m
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
CONFIG_PARPORT_PC_PCMCIA=m
CONFIG_PARPORT_AX88796=m
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
CONFIG_BLK_DEV_FD=m
CONFIG_CDROM=y
CONFIG_PARIDE=m

#
# Parallel IDE high-level drivers
#
CONFIG_PARIDE_PD=m
CONFIG_PARIDE_PCD=m
CONFIG_PARIDE_PF=m
CONFIG_PARIDE_PT=m
CONFIG_PARIDE_PG=m

#
# Parallel IDE protocol modules
#
CONFIG_PARIDE_ATEN=m
CONFIG_PARIDE_BPCK=m
CONFIG_PARIDE_COMM=m
CONFIG_PARIDE_DSTR=m
CONFIG_PARIDE_FIT2=m
CONFIG_PARIDE_FIT3=m
CONFIG_PARIDE_EPAT=m
CONFIG_PARIDE_EPATC8=y
CONFIG_PARIDE_EPIA=m
CONFIG_PARIDE_FRIQ=m
CONFIG_PARIDE_FRPW=m
CONFIG_PARIDE_KBIC=m
CONFIG_PARIDE_KTTI=m
CONFIG_PARIDE_ON20=m
CONFIG_PARIDE_ON26=m
CONFIG_BLK_DEV_PCIESSD_MTIP32XX=m
CONFIG_ZRAM=m
CONFIG_ZRAM_DEF_COMP_LZORLE=y
# CONFIG_ZRAM_DEF_COMP_ZSTD is not set
# CONFIG_ZRAM_DEF_COMP_LZ4 is not set
# CONFIG_ZRAM_DEF_COMP_LZO is not set
# CONFIG_ZRAM_DEF_COMP_LZ4HC is not set
# CONFIG_ZRAM_DEF_COMP_842 is not set
CONFIG_ZRAM_DEF_COMP="lzo-rle"
CONFIG_ZRAM_WRITEBACK=y
CONFIG_ZRAM_MEMORY_TRACKING=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
CONFIG_BLK_DEV_CRYPTOLOOP=m
CONFIG_BLK_DEV_DRBD=m
# CONFIG_DRBD_FAULT_INJECTION is not set
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_SX8=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=65536
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
CONFIG_ATA_OVER_ETH=m
CONFIG_XEN_BLKDEV_FRONTEND=y
CONFIG_XEN_BLKDEV_BACKEND=m
CONFIG_VIRTIO_BLK=m
CONFIG_BLK_DEV_RBD=m
CONFIG_BLK_DEV_RSXX=m
CONFIG_BLK_DEV_RNBD=y
CONFIG_BLK_DEV_RNBD_CLIENT=m
CONFIG_BLK_DEV_RNBD_SERVER=m

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
CONFIG_NVME_HWMON=y
CONFIG_NVME_FABRICS=m
CONFIG_NVME_RDMA=m
CONFIG_NVME_FC=m
CONFIG_NVME_TCP=m
CONFIG_NVME_TARGET=m
CONFIG_NVME_TARGET_PASSTHRU=y
CONFIG_NVME_TARGET_LOOP=m
CONFIG_NVME_TARGET_RDMA=m
CONFIG_NVME_TARGET_FC=m
# CONFIG_NVME_TARGET_FCLOOP is not set
CONFIG_NVME_TARGET_TCP=m
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
CONFIG_AD525X_DPOT=m
CONFIG_AD525X_DPOT_I2C=m
CONFIG_AD525X_DPOT_SPI=m
CONFIG_DUMMY_IRQ=m
CONFIG_IBM_ASM=m
CONFIG_PHANTOM=m
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
CONFIG_ICS932S401=m
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_SGI_XP=m
CONFIG_HP_ILO=m
CONFIG_SGI_GRU=m
# CONFIG_SGI_GRU_DEBUG is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
CONFIG_HMC6352=m
CONFIG_DS1682=m
CONFIG_VMWARE_BALLOON=m
CONFIG_LATTICE_ECP3_CONFIG=m
CONFIG_SRAM=y
CONFIG_DW_XDATA_PCIE=m
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_XILINX_SDFEC=m
CONFIG_MISC_RTSX=m
CONFIG_C2PORT=m
CONFIG_C2PORT_DURAMAR_2150=m

#
# EEPROM support
#
CONFIG_EEPROM_AT24=m
CONFIG_EEPROM_AT25=m
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
CONFIG_EEPROM_93XX46=m
CONFIG_EEPROM_IDT_89HPESX=m
CONFIG_EEPROM_EE1004=m
# end of EEPROM support

CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
CONFIG_TI_ST=m
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
CONFIG_INTEL_MEI_TXE=m
CONFIG_INTEL_MEI_HDCP=m
CONFIG_VMWARE_VMCI=m
CONFIG_GENWQE=m
CONFIG_GENWQE_PLATFORM_ERROR_RECOVERY=0
CONFIG_ECHO=m
CONFIG_BCM_VK=m
CONFIG_BCM_VK_TTY=y
CONFIG_MISC_ALCOR_PCI=m
CONFIG_MISC_RTSX_PCI=m
CONFIG_MISC_RTSX_USB=m
CONFIG_HABANA_AI=m
CONFIG_UACCE=m
CONFIG_PVPANIC=y
CONFIG_PVPANIC_MMIO=m
CONFIG_PVPANIC_PCI=m
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI_COMMON=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=y
CONFIG_CHR_DEV_SG=y
CONFIG_BLK_DEV_BSG=y
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
CONFIG_ISCSI_TCP=m
CONFIG_ISCSI_BOOT_SYSFS=m
CONFIG_SCSI_CXGB3_ISCSI=m
CONFIG_SCSI_CXGB4_ISCSI=m
CONFIG_SCSI_BNX2_ISCSI=m
CONFIG_SCSI_BNX2X_FCOE=m
CONFIG_BE2ISCSI=m
CONFIG_BLK_DEV_3W_XXXX_RAID=m
CONFIG_SCSI_HPSA=m
CONFIG_SCSI_3W_9XXX=m
CONFIG_SCSI_3W_SAS=m
CONFIG_SCSI_ACARD=m
CONFIG_SCSI_AHA1740=m
CONFIG_SCSI_AACRAID=m
CONFIG_SCSI_AIC7XXX=m
CONFIG_AIC7XXX_CMDS_PER_DEVICE=8
CONFIG_AIC7XXX_RESET_DELAY_MS=5000
# CONFIG_AIC7XXX_DEBUG_ENABLE is not set
CONFIG_AIC7XXX_DEBUG_MASK=0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
CONFIG_SCSI_AIC79XX=m
CONFIG_AIC79XX_CMDS_PER_DEVICE=32
CONFIG_AIC79XX_RESET_DELAY_MS=5000
# CONFIG_AIC79XX_DEBUG_ENABLE is not set
CONFIG_AIC79XX_DEBUG_MASK=0
CONFIG_AIC79XX_REG_PRETTY_PRINT=y
CONFIG_SCSI_AIC94XX=m
# CONFIG_AIC94XX_DEBUG is not set
CONFIG_SCSI_MVSAS=m
# CONFIG_SCSI_MVSAS_DEBUG is not set
# CONFIG_SCSI_MVSAS_TASKLET is not set
CONFIG_SCSI_MVUMI=m
CONFIG_SCSI_DPT_I2O=m
CONFIG_SCSI_ADVANSYS=m
CONFIG_SCSI_ARCMSR=m
CONFIG_SCSI_ESAS2R=m
CONFIG_MEGARAID_NEWGEN=y
CONFIG_MEGARAID_MM=m
CONFIG_MEGARAID_MAILBOX=m
CONFIG_MEGARAID_LEGACY=m
CONFIG_MEGARAID_SAS=m
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
CONFIG_SCSI_MPT2SAS=m
CONFIG_SCSI_MPI3MR=m
CONFIG_SCSI_SMARTPQI=m
CONFIG_SCSI_UFSHCD=m
CONFIG_SCSI_UFSHCD_PCI=m
CONFIG_SCSI_UFS_DWC_TC_PCI=m
CONFIG_SCSI_UFSHCD_PLATFORM=m
CONFIG_SCSI_UFS_CDNS_PLATFORM=m
CONFIG_SCSI_UFS_DWC_TC_PLATFORM=m
CONFIG_SCSI_UFS_BSG=y
CONFIG_SCSI_UFS_CRYPTO=y
CONFIG_SCSI_UFS_HPB=y
CONFIG_SCSI_HPTIOP=m
CONFIG_SCSI_BUSLOGIC=m
CONFIG_SCSI_FLASHPOINT=y
CONFIG_SCSI_MYRB=m
CONFIG_SCSI_MYRS=m
CONFIG_VMWARE_PVSCSI=m
CONFIG_XEN_SCSI_FRONTEND=m
CONFIG_HYPERV_STORAGE=m
CONFIG_LIBFC=m
CONFIG_LIBFCOE=m
CONFIG_FCOE=m
CONFIG_FCOE_FNIC=m
CONFIG_SCSI_SNIC=m
# CONFIG_SCSI_SNIC_DEBUG_FS is not set
CONFIG_SCSI_DMX3191D=m
CONFIG_SCSI_FDOMAIN=m
CONFIG_SCSI_FDOMAIN_PCI=m
CONFIG_SCSI_ISCI=m
CONFIG_SCSI_IPS=m
CONFIG_SCSI_INITIO=m
CONFIG_SCSI_INIA100=m
CONFIG_SCSI_PPA=m
CONFIG_SCSI_IMM=m
# CONFIG_SCSI_IZIP_EPP16 is not set
# CONFIG_SCSI_IZIP_SLOW_CTR is not set
CONFIG_SCSI_STEX=m
CONFIG_SCSI_SYM53C8XX_2=m
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
CONFIG_SCSI_SYM53C8XX_MMIO=y
CONFIG_SCSI_IPR=m
CONFIG_SCSI_IPR_TRACE=y
CONFIG_SCSI_IPR_DUMP=y
CONFIG_SCSI_QLOGIC_1280=m
CONFIG_SCSI_QLA_FC=m
CONFIG_TCM_QLA2XXX=m
# CONFIG_TCM_QLA2XXX_DEBUG is not set
CONFIG_SCSI_QLA_ISCSI=m
CONFIG_QEDI=m
CONFIG_QEDF=m
CONFIG_SCSI_LPFC=m
# CONFIG_SCSI_LPFC_DEBUG_FS is not set
CONFIG_SCSI_EFCT=m
CONFIG_SCSI_SIM710=m
CONFIG_SCSI_DC395x=m
CONFIG_SCSI_AM53C974=m
CONFIG_SCSI_WD719X=m
CONFIG_SCSI_DEBUG=m
CONFIG_SCSI_PMCRAID=m
CONFIG_SCSI_PM8001=m
CONFIG_SCSI_BFA_FC=m
CONFIG_SCSI_VIRTIO=m
CONFIG_SCSI_CHELSIO_FCOE=m
CONFIG_SCSI_LOWLEVEL_PCMCIA=y
CONFIG_PCMCIA_AHA152X=m
CONFIG_PCMCIA_FDOMAIN=m
CONFIG_PCMCIA_QLOGIC=m
CONFIG_PCMCIA_SYM53C500=m
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=m
CONFIG_SCSI_DH_HP_SW=m
CONFIG_SCSI_DH_EMC=m
CONFIG_SCSI_DH_ALUA=m
# end of SCSI device support

CONFIG_ATA=y
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
CONFIG_SATA_ZPODD=y
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=3
CONFIG_SATA_AHCI_PLATFORM=m
CONFIG_SATA_INIC162X=m
CONFIG_SATA_ACARD_AHCI=m
CONFIG_SATA_SIL24=m
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
CONFIG_PDC_ADMA=m
CONFIG_SATA_QSTOR=m
CONFIG_SATA_SX4=m
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=y
CONFIG_SATA_DWC=m
CONFIG_SATA_DWC_OLD_DMA=y
# CONFIG_SATA_DWC_DEBUG is not set
CONFIG_SATA_MV=m
CONFIG_SATA_NV=m
CONFIG_SATA_PROMISE=m
CONFIG_SATA_SIL=m
CONFIG_SATA_SIS=m
CONFIG_SATA_SVW=m
CONFIG_SATA_ULI=m
CONFIG_SATA_VIA=m
CONFIG_SATA_VITESSE=m

#
# PATA SFF controllers with BMDMA
#
CONFIG_PATA_ALI=m
CONFIG_PATA_AMD=m
CONFIG_PATA_ARTOP=m
CONFIG_PATA_ATIIXP=m
CONFIG_PATA_ATP867X=m
CONFIG_PATA_CMD64X=m
CONFIG_PATA_CYPRESS=m
CONFIG_PATA_EFAR=m
CONFIG_PATA_HPT366=m
CONFIG_PATA_HPT37X=m
CONFIG_PATA_HPT3X2N=m
CONFIG_PATA_HPT3X3=m
# CONFIG_PATA_HPT3X3_DMA is not set
CONFIG_PATA_IT8213=m
CONFIG_PATA_IT821X=m
CONFIG_PATA_JMICRON=m
CONFIG_PATA_MARVELL=m
CONFIG_PATA_NETCELL=m
CONFIG_PATA_NINJA32=m
CONFIG_PATA_NS87415=m
CONFIG_PATA_OLDPIIX=m
CONFIG_PATA_OPTIDMA=m
CONFIG_PATA_PDC2027X=m
CONFIG_PATA_PDC_OLD=m
CONFIG_PATA_RADISYS=m
CONFIG_PATA_RDC=m
CONFIG_PATA_SCH=m
CONFIG_PATA_SERVERWORKS=m
CONFIG_PATA_SIL680=m
CONFIG_PATA_SIS=y
CONFIG_PATA_TOSHIBA=m
CONFIG_PATA_TRIFLEX=m
CONFIG_PATA_VIA=m
CONFIG_PATA_WINBOND=m

#
# PIO-only SFF controllers
#
CONFIG_PATA_CMD640_PCI=m
CONFIG_PATA_MPIIX=m
CONFIG_PATA_NS87410=m
CONFIG_PATA_OPTI=m
CONFIG_PATA_PCMCIA=m
CONFIG_PATA_PLATFORM=m
CONFIG_PATA_RZ1000=m

#
# Generic fallback / legacy drivers
#
CONFIG_PATA_ACPI=m
CONFIG_ATA_GENERIC=y
CONFIG_PATA_LEGACY=m
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
CONFIG_MD_MULTIPATH=m
CONFIG_MD_FAULTY=m
CONFIG_MD_CLUSTER=m
CONFIG_BCACHE=m
# CONFIG_BCACHE_DEBUG is not set
# CONFIG_BCACHE_CLOSURES_DEBUG is not set
CONFIG_BCACHE_ASYNC_REGISTRATION=y
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=y
# CONFIG_DM_DEBUG is not set
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
CONFIG_DM_UNSTRIPED=m
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
CONFIG_DM_WRITECACHE=m
CONFIG_DM_EBS=m
CONFIG_DM_ERA=m
CONFIG_DM_CLONE=m
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
CONFIG_DM_MULTIPATH_HST=m
CONFIG_DM_MULTIPATH_IOA=m
CONFIG_DM_DELAY=m
# CONFIG_DM_DUST is not set
CONFIG_DM_INIT=y
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG=y
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG_SECONDARY_KEYRING is not set
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
CONFIG_DM_INTEGRITY=m
CONFIG_DM_ZONED=m
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
CONFIG_TCM_USER2=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_TCM_FC=m
CONFIG_ISCSI_TARGET=m
CONFIG_ISCSI_TARGET_CXGB4=m
CONFIG_SBP_TARGET=m
CONFIG_FUSION=y
CONFIG_FUSION_SPI=m
CONFIG_FUSION_FC=m
CONFIG_FUSION_SAS=m
CONFIG_FUSION_MAX_SGE=128
CONFIG_FUSION_CTL=m
CONFIG_FUSION_LAN=m
CONFIG_FUSION_LOGGING=y

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
CONFIG_FIREWIRE_NOSY=m
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=m
CONFIG_NETDEVICES=y
CONFIG_MII=m
CONFIG_NET_CORE=y
CONFIG_BONDING=m
CONFIG_DUMMY=m
CONFIG_WIREGUARD=m
# CONFIG_WIREGUARD_DEBUG is not set
CONFIG_EQUALIZER=m
CONFIG_NET_FC=y
CONFIG_IFB=m
CONFIG_NET_TEAM=m
CONFIG_NET_TEAM_MODE_BROADCAST=m
CONFIG_NET_TEAM_MODE_ROUNDROBIN=m
CONFIG_NET_TEAM_MODE_RANDOM=m
CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=m
CONFIG_NET_TEAM_MODE_LOADBALANCE=m
CONFIG_MACVLAN=m
CONFIG_MACVTAP=m
CONFIG_IPVLAN_L3S=y
CONFIG_IPVLAN=m
CONFIG_IPVTAP=m
CONFIG_VXLAN=m
CONFIG_GENEVE=m
CONFIG_BAREUDP=m
CONFIG_GTP=m
CONFIG_MACSEC=m
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_NTB_NETDEV=m
CONFIG_RIONET=m
CONFIG_RIONET_TX_SIZE=128
CONFIG_RIONET_RX_SIZE=128
CONFIG_TUN=y
CONFIG_TAP=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=m
CONFIG_VIRTIO_NET=m
CONFIG_NLMON=m
CONFIG_NET_VRF=m
CONFIG_VSOCKMON=m
CONFIG_MHI_NET=m
CONFIG_SUNGEM_PHY=m
CONFIG_ARCNET=m
CONFIG_ARCNET_1201=m
CONFIG_ARCNET_1051=m
CONFIG_ARCNET_RAW=m
CONFIG_ARCNET_CAP=m
CONFIG_ARCNET_COM90xx=m
CONFIG_ARCNET_COM90xxIO=m
CONFIG_ARCNET_RIM_I=m
CONFIG_ARCNET_COM20020=m
CONFIG_ARCNET_COM20020_PCI=m
CONFIG_ARCNET_COM20020_CS=m
CONFIG_ATM_DRIVERS=y
CONFIG_ATM_DUMMY=m
CONFIG_ATM_TCP=m
CONFIG_ATM_LANAI=m
CONFIG_ATM_ENI=m
# CONFIG_ATM_ENI_DEBUG is not set
# CONFIG_ATM_ENI_TUNE_BURST is not set
CONFIG_ATM_FIRESTREAM=m
CONFIG_ATM_ZATM=m
# CONFIG_ATM_ZATM_DEBUG is not set
CONFIG_ATM_NICSTAR=m
# CONFIG_ATM_NICSTAR_USE_SUNI is not set
# CONFIG_ATM_NICSTAR_USE_IDT77105 is not set
CONFIG_ATM_IDT77252=m
# CONFIG_ATM_IDT77252_DEBUG is not set
# CONFIG_ATM_IDT77252_RCV_ALL is not set
CONFIG_ATM_IDT77252_USE_SUNI=y
CONFIG_ATM_AMBASSADOR=m
# CONFIG_ATM_AMBASSADOR_DEBUG is not set
CONFIG_ATM_HORIZON=m
# CONFIG_ATM_HORIZON_DEBUG is not set
CONFIG_ATM_IA=m
# CONFIG_ATM_IA_DEBUG is not set
CONFIG_ATM_FORE200E=m
# CONFIG_ATM_FORE200E_USE_TASKLET is not set
CONFIG_ATM_FORE200E_TX_RETRY=16
CONFIG_ATM_FORE200E_DEBUG=0
CONFIG_ATM_HE=m
CONFIG_ATM_HE_USE_SUNI=y
CONFIG_ATM_SOLOS=m
CONFIG_CAIF_DRIVERS=y
CONFIG_CAIF_TTY=m
CONFIG_CAIF_VIRTIO=m

#
# Distributed Switch Architecture drivers
#
CONFIG_B53=m
CONFIG_B53_SPI_DRIVER=m
CONFIG_B53_MDIO_DRIVER=m
CONFIG_B53_MMAP_DRIVER=m
CONFIG_B53_SRAB_DRIVER=m
CONFIG_B53_SERDES=m
CONFIG_NET_DSA_BCM_SF2=m
# CONFIG_NET_DSA_LOOP is not set
CONFIG_NET_DSA_HIRSCHMANN_HELLCREEK=m
CONFIG_NET_DSA_LANTIQ_GSWIP=m
CONFIG_NET_DSA_MT7530=m
CONFIG_NET_DSA_MV88E6060=m
CONFIG_NET_DSA_MICROCHIP_KSZ_COMMON=m
CONFIG_NET_DSA_MICROCHIP_KSZ9477=m
CONFIG_NET_DSA_MICROCHIP_KSZ9477_I2C=m
CONFIG_NET_DSA_MICROCHIP_KSZ9477_SPI=m
CONFIG_NET_DSA_MICROCHIP_KSZ8795=m
CONFIG_NET_DSA_MICROCHIP_KSZ8795_SPI=m
CONFIG_NET_DSA_MICROCHIP_KSZ8863_SMI=m
CONFIG_NET_DSA_MV88E6XXX=m
CONFIG_NET_DSA_MV88E6XXX_PTP=y
CONFIG_NET_DSA_MSCC_SEVILLE=m
CONFIG_NET_DSA_AR9331=m
CONFIG_NET_DSA_SJA1105=m
CONFIG_NET_DSA_SJA1105_PTP=y
CONFIG_NET_DSA_SJA1105_TAS=y
CONFIG_NET_DSA_SJA1105_VL=y
CONFIG_NET_DSA_XRS700X=m
CONFIG_NET_DSA_XRS700X_I2C=m
CONFIG_NET_DSA_XRS700X_MDIO=m
CONFIG_NET_DSA_QCA8K=m
CONFIG_NET_DSA_REALTEK_SMI=m
CONFIG_NET_DSA_SMSC_LAN9303=m
CONFIG_NET_DSA_SMSC_LAN9303_I2C=m
CONFIG_NET_DSA_SMSC_LAN9303_MDIO=m
CONFIG_NET_DSA_VITESSE_VSC73XX=m
CONFIG_NET_DSA_VITESSE_VSC73XX_SPI=m
CONFIG_NET_DSA_VITESSE_VSC73XX_PLATFORM=m
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
CONFIG_MDIO=m
CONFIG_NET_VENDOR_3COM=y
CONFIG_EL3=m
CONFIG_PCMCIA_3C574=m
CONFIG_PCMCIA_3C589=m
CONFIG_VORTEX=m
CONFIG_TYPHOON=m
CONFIG_NET_VENDOR_ADAPTEC=y
CONFIG_ADAPTEC_STARFIRE=m
CONFIG_NET_VENDOR_AGERE=y
CONFIG_ET131X=m
CONFIG_NET_VENDOR_ALACRITECH=y
CONFIG_SLICOSS=m
CONFIG_NET_VENDOR_ALTEON=y
CONFIG_ACENIC=m
# CONFIG_ACENIC_OMIT_TIGON_I is not set
CONFIG_ALTERA_TSE=m
CONFIG_NET_VENDOR_AMAZON=y
CONFIG_ENA_ETHERNET=m
CONFIG_NET_VENDOR_AMD=y
CONFIG_AMD8111_ETH=m
CONFIG_PCNET32=m
CONFIG_PCMCIA_NMCLAN=m
CONFIG_AMD_XGBE=m
CONFIG_AMD_XGBE_DCB=y
CONFIG_AMD_XGBE_HAVE_ECC=y
CONFIG_NET_VENDOR_AQUANTIA=y
CONFIG_AQTION=m
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
CONFIG_ATL2=m
CONFIG_ATL1=m
CONFIG_ATL1E=m
CONFIG_ATL1C=m
CONFIG_ALX=m
CONFIG_NET_VENDOR_BROADCOM=y
CONFIG_B44=m
CONFIG_B44_PCI_AUTOSELECT=y
CONFIG_B44_PCICORE_AUTOSELECT=y
CONFIG_B44_PCI=y
CONFIG_BCMGENET=m
CONFIG_BNX2=m
CONFIG_CNIC=m
CONFIG_TIGON3=m
CONFIG_TIGON3_HWMON=y
CONFIG_BNX2X=m
CONFIG_BNX2X_SRIOV=y
CONFIG_SYSTEMPORT=m
CONFIG_BNXT=m
CONFIG_BNXT_SRIOV=y
CONFIG_BNXT_FLOWER_OFFLOAD=y
CONFIG_BNXT_DCB=y
CONFIG_BNXT_HWMON=y
CONFIG_NET_VENDOR_BROCADE=y
CONFIG_BNA=m
CONFIG_NET_VENDOR_CADENCE=y
CONFIG_MACB=m
CONFIG_MACB_USE_HWSTAMP=y
CONFIG_MACB_PCI=m
CONFIG_NET_VENDOR_CAVIUM=y
CONFIG_THUNDER_NIC_PF=m
CONFIG_THUNDER_NIC_VF=m
CONFIG_THUNDER_NIC_BGX=m
CONFIG_THUNDER_NIC_RGX=m
CONFIG_CAVIUM_PTP=m
CONFIG_LIQUIDIO=m
CONFIG_LIQUIDIO_VF=m
CONFIG_NET_VENDOR_CHELSIO=y
CONFIG_CHELSIO_T1=m
CONFIG_CHELSIO_T1_1G=y
CONFIG_CHELSIO_T3=m
CONFIG_CHELSIO_T4=m
CONFIG_CHELSIO_T4_DCB=y
CONFIG_CHELSIO_T4_FCOE=y
CONFIG_CHELSIO_T4VF=m
CONFIG_CHELSIO_LIB=m
CONFIG_CHELSIO_INLINE_CRYPTO=y
CONFIG_CHELSIO_IPSEC_INLINE=m
CONFIG_CHELSIO_TLS_DEVICE=m
CONFIG_NET_VENDOR_CIRRUS=y
CONFIG_NET_VENDOR_CISCO=y
CONFIG_ENIC=m
CONFIG_NET_VENDOR_CORTINA=y
CONFIG_CX_ECAT=m
CONFIG_DNET=m
CONFIG_NET_VENDOR_DEC=y
CONFIG_NET_TULIP=y
CONFIG_DE2104X=m
CONFIG_DE2104X_DSL=0
CONFIG_TULIP=m
# CONFIG_TULIP_MWI is not set
# CONFIG_TULIP_MMIO is not set
# CONFIG_TULIP_NAPI is not set
CONFIG_DE4X5=m
CONFIG_WINBOND_840=m
CONFIG_DM9102=m
CONFIG_ULI526X=m
CONFIG_PCMCIA_XIRCOM=m
CONFIG_NET_VENDOR_DLINK=y
CONFIG_DL2K=m
CONFIG_SUNDANCE=m
# CONFIG_SUNDANCE_MMIO is not set
CONFIG_NET_VENDOR_EMULEX=y
CONFIG_BE2NET=m
CONFIG_BE2NET_HWMON=y
CONFIG_BE2NET_BE2=y
CONFIG_BE2NET_BE3=y
CONFIG_BE2NET_LANCER=y
CONFIG_BE2NET_SKYHAWK=y
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_FUJITSU=y
CONFIG_PCMCIA_FMVJ18X=m
CONFIG_NET_VENDOR_GOOGLE=y
CONFIG_GVE=m
CONFIG_NET_VENDOR_HUAWEI=y
CONFIG_HINIC=m
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
CONFIG_E100=m
CONFIG_E1000=m
CONFIG_E1000E=m
CONFIG_E1000E_HWTS=y
CONFIG_IGB=m
CONFIG_IGB_HWMON=y
CONFIG_IGB_DCA=y
CONFIG_IGBVF=m
CONFIG_IXGB=m
CONFIG_IXGBE=m
CONFIG_IXGBE_HWMON=y
CONFIG_IXGBE_DCA=y
CONFIG_IXGBE_DCB=y
CONFIG_IXGBE_IPSEC=y
CONFIG_IXGBEVF=m
CONFIG_IXGBEVF_IPSEC=y
CONFIG_I40E=m
CONFIG_I40E_DCB=y
CONFIG_IAVF=m
CONFIG_I40EVF=m
CONFIG_ICE=m
CONFIG_FM10K=m
CONFIG_IGC=m
CONFIG_NET_VENDOR_MICROSOFT=y
CONFIG_MICROSOFT_MANA=m
CONFIG_JME=m
CONFIG_NET_VENDOR_LITEX=y
CONFIG_NET_VENDOR_MARVELL=y
CONFIG_MVMDIO=m
CONFIG_SKGE=m
# CONFIG_SKGE_DEBUG is not set
CONFIG_SKGE_GENESIS=y
CONFIG_SKY2=m
# CONFIG_SKY2_DEBUG is not set
CONFIG_PRESTERA=m
CONFIG_PRESTERA_PCI=m
CONFIG_NET_VENDOR_MELLANOX=y
CONFIG_MLX4_EN=m
CONFIG_MLX4_EN_DCB=y
CONFIG_MLX4_CORE=m
CONFIG_MLX4_DEBUG=y
CONFIG_MLX4_CORE_GEN2=y
CONFIG_MLX5_CORE=m
CONFIG_MLX5_ACCEL=y
CONFIG_MLX5_FPGA=y
CONFIG_MLX5_CORE_EN=y
CONFIG_MLX5_EN_ARFS=y
CONFIG_MLX5_EN_RXNFC=y
CONFIG_MLX5_MPFS=y
CONFIG_MLX5_ESWITCH=y
CONFIG_MLX5_BRIDGE=y
CONFIG_MLX5_CLS_ACT=y
CONFIG_MLX5_TC_CT=y
CONFIG_MLX5_TC_SAMPLE=y
CONFIG_MLX5_CORE_EN_DCB=y
CONFIG_MLX5_CORE_IPOIB=y
CONFIG_MLX5_FPGA_IPSEC=y
CONFIG_MLX5_IPSEC=y
CONFIG_MLX5_EN_IPSEC=y
CONFIG_MLX5_FPGA_TLS=y
CONFIG_MLX5_TLS=y
CONFIG_MLX5_EN_TLS=y
CONFIG_MLX5_SW_STEERING=y
CONFIG_MLX5_SF=y
CONFIG_MLX5_SF_MANAGER=y
CONFIG_MLXSW_CORE=m
CONFIG_MLXSW_CORE_HWMON=y
CONFIG_MLXSW_CORE_THERMAL=y
CONFIG_MLXSW_PCI=m
CONFIG_MLXSW_I2C=m
CONFIG_MLXSW_SPECTRUM=m
CONFIG_MLXSW_SPECTRUM_DCB=y
CONFIG_MLXSW_MINIMAL=m
CONFIG_MLXFW=m
CONFIG_NET_VENDOR_MICREL=y
CONFIG_KS8842=m
CONFIG_KS8851=m
CONFIG_KS8851_MLL=m
CONFIG_KSZ884X_PCI=m
CONFIG_NET_VENDOR_MICROCHIP=y
CONFIG_ENC28J60=m
# CONFIG_ENC28J60_WRITEVERIFY is not set
CONFIG_ENCX24J600=m
CONFIG_LAN743X=m
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_MSCC_OCELOT_SWITCH_LIB=m
CONFIG_NET_VENDOR_MYRI=y
CONFIG_MYRI10GE=m
CONFIG_MYRI10GE_DCA=y
CONFIG_FEALNX=m
CONFIG_NET_VENDOR_NATSEMI=y
CONFIG_NATSEMI=m
CONFIG_NS83820=m
CONFIG_NET_VENDOR_NETERION=y
CONFIG_S2IO=m
CONFIG_VXGE=m
# CONFIG_VXGE_DEBUG_TRACE_ALL is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NFP=m
CONFIG_NFP_APP_FLOWER=y
CONFIG_NFP_APP_ABM_NIC=y
# CONFIG_NFP_DEBUG is not set
CONFIG_NET_VENDOR_NI=y
CONFIG_NI_XGE_MANAGEMENT_ENET=m
CONFIG_NET_VENDOR_8390=y
CONFIG_PCMCIA_AXNET=m
CONFIG_NE2K_PCI=m
CONFIG_PCMCIA_PCNET=m
CONFIG_NET_VENDOR_NVIDIA=y
CONFIG_FORCEDETH=m
CONFIG_NET_VENDOR_OKI=y
CONFIG_ETHOC=m
CONFIG_NET_VENDOR_PACKET_ENGINES=y
CONFIG_HAMACHI=m
CONFIG_YELLOWFIN=m
CONFIG_NET_VENDOR_PENSANDO=y
CONFIG_IONIC=m
CONFIG_NET_VENDOR_QLOGIC=y
CONFIG_QLA3XXX=m
CONFIG_QLCNIC=m
CONFIG_QLCNIC_SRIOV=y
CONFIG_QLCNIC_DCB=y
CONFIG_QLCNIC_HWMON=y
CONFIG_NETXEN_NIC=m
CONFIG_QED=m
CONFIG_QED_LL2=y
CONFIG_QED_SRIOV=y
CONFIG_QEDE=m
CONFIG_QED_RDMA=y
CONFIG_QED_ISCSI=y
CONFIG_QED_FCOE=y
CONFIG_QED_OOO=y
CONFIG_NET_VENDOR_QUALCOMM=y
CONFIG_QCOM_EMAC=m
CONFIG_RMNET=m
CONFIG_NET_VENDOR_RDC=y
CONFIG_R6040=m
CONFIG_NET_VENDOR_REALTEK=y
CONFIG_ATP=m
CONFIG_8139CP=m
CONFIG_8139TOO=m
CONFIG_8139TOO_PIO=y
# CONFIG_8139TOO_TUNE_TWISTER is not set
CONFIG_8139TOO_8129=y
# CONFIG_8139_OLD_RX_RESET is not set
CONFIG_R8169=m
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_ROCKER=m
CONFIG_NET_VENDOR_SAMSUNG=y
CONFIG_SXGBE_ETH=m
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SOLARFLARE=y
CONFIG_SFC=m
CONFIG_SFC_MTD=y
CONFIG_SFC_MCDI_MON=y
CONFIG_SFC_SRIOV=y
CONFIG_SFC_MCDI_LOGGING=y
CONFIG_SFC_FALCON=m
CONFIG_SFC_FALCON_MTD=y
CONFIG_NET_VENDOR_SILAN=y
CONFIG_SC92031=m
CONFIG_NET_VENDOR_SIS=y
CONFIG_SIS900=m
CONFIG_SIS190=m
CONFIG_NET_VENDOR_SMSC=y
CONFIG_PCMCIA_SMC91C92=m
CONFIG_EPIC100=m
CONFIG_SMSC911X=m
CONFIG_SMSC9420=m
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
CONFIG_STMMAC_ETH=m
# CONFIG_STMMAC_SELFTESTS is not set
CONFIG_STMMAC_PLATFORM=m
CONFIG_DWMAC_GENERIC=m
CONFIG_DWMAC_INTEL=m
CONFIG_DWMAC_LOONGSON=m
CONFIG_STMMAC_PCI=m
CONFIG_NET_VENDOR_SUN=y
CONFIG_HAPPYMEAL=m
CONFIG_SUNGEM=m
CONFIG_CASSINI=m
CONFIG_NIU=m
CONFIG_NET_VENDOR_SYNOPSYS=y
CONFIG_DWC_XLGMAC=m
CONFIG_DWC_XLGMAC_PCI=m
CONFIG_NET_VENDOR_TEHUTI=y
CONFIG_TEHUTI=m
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
CONFIG_TLAN=m
CONFIG_NET_VENDOR_VIA=y
CONFIG_VIA_RHINE=m
CONFIG_VIA_RHINE_MMIO=y
CONFIG_VIA_VELOCITY=m
CONFIG_NET_VENDOR_WIZNET=y
CONFIG_WIZNET_W5100=m
CONFIG_WIZNET_W5300=m
# CONFIG_WIZNET_BUS_DIRECT is not set
# CONFIG_WIZNET_BUS_INDIRECT is not set
CONFIG_WIZNET_BUS_ANY=y
CONFIG_WIZNET_W5100_SPI=m
CONFIG_NET_VENDOR_XILINX=y
CONFIG_XILINX_EMACLITE=m
CONFIG_XILINX_AXI_EMAC=m
CONFIG_XILINX_LL_TEMAC=m
CONFIG_NET_VENDOR_XIRCOM=y
CONFIG_PCMCIA_XIRC2PS=m
CONFIG_FDDI=y
CONFIG_DEFXX=m
CONFIG_SKFP=m
# CONFIG_HIPPI is not set
CONFIG_NET_SB1000=m
CONFIG_PHYLINK=m
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
CONFIG_LED_TRIGGER_PHY=y
CONFIG_FIXED_PHY=y
CONFIG_SFP=m

#
# MII PHY device drivers
#
CONFIG_AMD_PHY=m
CONFIG_ADIN_PHY=m
CONFIG_AQUANTIA_PHY=m
CONFIG_AX88796B_PHY=m
CONFIG_BROADCOM_PHY=m
CONFIG_BCM54140_PHY=m
CONFIG_BCM7XXX_PHY=m
CONFIG_BCM84881_PHY=y
CONFIG_BCM87XX_PHY=m
CONFIG_BCM_NET_PHYLIB=m
CONFIG_CICADA_PHY=m
CONFIG_CORTINA_PHY=m
CONFIG_DAVICOM_PHY=m
CONFIG_ICPLUS_PHY=m
CONFIG_LXT_PHY=m
CONFIG_INTEL_XWAY_PHY=m
CONFIG_LSI_ET1011C_PHY=m
CONFIG_MARVELL_PHY=m
CONFIG_MARVELL_10G_PHY=m
CONFIG_MARVELL_88X2222_PHY=m
CONFIG_MAXLINEAR_GPHY=m
CONFIG_MEDIATEK_GE_PHY=m
CONFIG_MICREL_PHY=m
CONFIG_MICROCHIP_PHY=m
CONFIG_MICROCHIP_T1_PHY=m
CONFIG_MICROSEMI_PHY=m
CONFIG_MOTORCOMM_PHY=m
CONFIG_NATIONAL_PHY=m
CONFIG_NXP_C45_TJA11XX_PHY=m
CONFIG_NXP_TJA11XX_PHY=m
CONFIG_AT803X_PHY=m
CONFIG_QSEMI_PHY=m
CONFIG_REALTEK_PHY=m
CONFIG_RENESAS_PHY=m
CONFIG_ROCKCHIP_PHY=m
CONFIG_SMSC_PHY=m
CONFIG_STE10XP=m
CONFIG_TERANETICS_PHY=m
CONFIG_DP83822_PHY=m
CONFIG_DP83TC811_PHY=m
CONFIG_DP83848_PHY=m
CONFIG_DP83867_PHY=m
CONFIG_DP83869_PHY=m
CONFIG_VITESSE_PHY=m
CONFIG_XILINX_GMII2RGMII=m
CONFIG_MICREL_KS8995MA=m

#
# MCTP Device Drivers
#
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_FWNODE_MDIO=y
CONFIG_ACPI_MDIO=y
CONFIG_MDIO_DEVRES=y
CONFIG_MDIO_BITBANG=m
CONFIG_MDIO_BCM_UNIMAC=m
CONFIG_MDIO_CAVIUM=m
CONFIG_MDIO_GPIO=m
CONFIG_MDIO_I2C=m
CONFIG_MDIO_MVUSB=m
CONFIG_MDIO_MSCC_MIIM=m
CONFIG_MDIO_THUNDER=m

#
# MDIO Multiplexers
#

#
# PCS device drivers
#
CONFIG_PCS_XPCS=m
CONFIG_PCS_LYNX=m
# end of PCS device drivers

CONFIG_PLIP=m
CONFIG_PPP=y
CONFIG_PPP_BSDCOMP=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_FILTER=y
CONFIG_PPP_MPPE=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPPOATM=m
CONFIG_PPPOE=m
CONFIG_PPTP=m
CONFIG_PPPOL2TP=m
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_SLIP=m
CONFIG_SLHC=y
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
CONFIG_SLIP_MODE_SLIP6=y
CONFIG_USB_NET_DRIVERS=m
CONFIG_USB_CATC=m
CONFIG_USB_KAWETH=m
CONFIG_USB_PEGASUS=m
CONFIG_USB_RTL8150=m
CONFIG_USB_RTL8152=m
CONFIG_USB_LAN78XX=m
CONFIG_USB_USBNET=m
CONFIG_USB_NET_AX8817X=m
CONFIG_USB_NET_AX88179_178A=m
CONFIG_USB_NET_CDCETHER=m
CONFIG_USB_NET_CDC_EEM=m
CONFIG_USB_NET_CDC_NCM=m
CONFIG_USB_NET_HUAWEI_CDC_NCM=m
CONFIG_USB_NET_CDC_MBIM=m
CONFIG_USB_NET_DM9601=m
CONFIG_USB_NET_SR9700=m
CONFIG_USB_NET_SR9800=m
CONFIG_USB_NET_SMSC75XX=m
CONFIG_USB_NET_SMSC95XX=m
CONFIG_USB_NET_GL620A=m
CONFIG_USB_NET_NET1080=m
CONFIG_USB_NET_PLUSB=m
CONFIG_USB_NET_MCS7830=m
CONFIG_USB_NET_RNDIS_HOST=m
CONFIG_USB_NET_CDC_SUBSET_ENABLE=m
CONFIG_USB_NET_CDC_SUBSET=m
CONFIG_USB_ALI_M5632=y
CONFIG_USB_AN2720=y
CONFIG_USB_BELKIN=y
CONFIG_USB_ARMLINUX=y
CONFIG_USB_EPSON2888=y
CONFIG_USB_KC2190=y
CONFIG_USB_NET_ZAURUS=m
CONFIG_USB_NET_CX82310_ETH=m
CONFIG_USB_NET_KALMIA=m
CONFIG_USB_NET_QMI_WWAN=m
CONFIG_USB_HSO=m
CONFIG_USB_NET_INT51X1=m
CONFIG_USB_CDC_PHONET=m
CONFIG_USB_IPHETH=m
CONFIG_USB_SIERRA_NET=m
CONFIG_USB_VL600=m
CONFIG_USB_NET_CH9200=m
CONFIG_USB_NET_AQC111=m
CONFIG_USB_RTL8153_ECM=m
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
CONFIG_ADM8211=m
CONFIG_ATH_COMMON=m
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
CONFIG_ATH5K=m
# CONFIG_ATH5K_DEBUG is not set
# CONFIG_ATH5K_TRACER is not set
CONFIG_ATH5K_PCI=y
CONFIG_ATH9K_HW=m
CONFIG_ATH9K_COMMON=m
CONFIG_ATH9K_COMMON_DEBUG=y
CONFIG_ATH9K_BTCOEX_SUPPORT=y
CONFIG_ATH9K=m
CONFIG_ATH9K_PCI=y
CONFIG_ATH9K_AHB=y
CONFIG_ATH9K_DEBUGFS=y
CONFIG_ATH9K_STATION_STATISTICS=y
# CONFIG_ATH9K_DYNACK is not set
CONFIG_ATH9K_WOW=y
CONFIG_ATH9K_RFKILL=y
CONFIG_ATH9K_CHANNEL_CONTEXT=y
CONFIG_ATH9K_PCOEM=y
CONFIG_ATH9K_PCI_NO_EEPROM=m
CONFIG_ATH9K_HTC=m
CONFIG_ATH9K_HTC_DEBUGFS=y
CONFIG_ATH9K_HWRNG=y
CONFIG_ATH9K_COMMON_SPECTRAL=y
CONFIG_CARL9170=m
CONFIG_CARL9170_LEDS=y
# CONFIG_CARL9170_DEBUGFS is not set
CONFIG_CARL9170_WPC=y
CONFIG_CARL9170_HWRNG=y
CONFIG_ATH6KL=m
CONFIG_ATH6KL_SDIO=m
CONFIG_ATH6KL_USB=m
# CONFIG_ATH6KL_DEBUG is not set
# CONFIG_ATH6KL_TRACING is not set
CONFIG_AR5523=m
CONFIG_WIL6210=m
CONFIG_WIL6210_ISR_COR=y
CONFIG_WIL6210_TRACING=y
CONFIG_WIL6210_DEBUGFS=y
CONFIG_ATH10K=m
CONFIG_ATH10K_CE=y
CONFIG_ATH10K_PCI=m
CONFIG_ATH10K_SDIO=m
CONFIG_ATH10K_USB=m
# CONFIG_ATH10K_DEBUG is not set
CONFIG_ATH10K_DEBUGFS=y
CONFIG_ATH10K_SPECTRAL=y
CONFIG_ATH10K_TRACING=y
CONFIG_WCN36XX=m
# CONFIG_WCN36XX_DEBUGFS is not set
CONFIG_ATH11K=m
CONFIG_ATH11K_AHB=m
CONFIG_ATH11K_PCI=m
# CONFIG_ATH11K_DEBUG is not set
CONFIG_ATH11K_DEBUGFS=y
CONFIG_ATH11K_TRACING=y
CONFIG_ATH11K_SPECTRAL=y
CONFIG_WLAN_VENDOR_ATMEL=y
CONFIG_ATMEL=m
CONFIG_PCI_ATMEL=m
CONFIG_PCMCIA_ATMEL=m
CONFIG_AT76C50X_USB=m
CONFIG_WLAN_VENDOR_BROADCOM=y
CONFIG_B43=m
CONFIG_B43_BCMA=y
CONFIG_B43_SSB=y
CONFIG_B43_BUSES_BCMA_AND_SSB=y
# CONFIG_B43_BUSES_BCMA is not set
# CONFIG_B43_BUSES_SSB is not set
CONFIG_B43_PCI_AUTOSELECT=y
CONFIG_B43_PCICORE_AUTOSELECT=y
# CONFIG_B43_SDIO is not set
CONFIG_B43_BCMA_PIO=y
CONFIG_B43_PIO=y
CONFIG_B43_PHY_G=y
CONFIG_B43_PHY_N=y
CONFIG_B43_PHY_LP=y
CONFIG_B43_PHY_HT=y
CONFIG_B43_LEDS=y
CONFIG_B43_HWRNG=y
# CONFIG_B43_DEBUG is not set
CONFIG_B43LEGACY=m
CONFIG_B43LEGACY_PCI_AUTOSELECT=y
CONFIG_B43LEGACY_PCICORE_AUTOSELECT=y
CONFIG_B43LEGACY_LEDS=y
CONFIG_B43LEGACY_HWRNG=y
# CONFIG_B43LEGACY_DEBUG is not set
CONFIG_B43LEGACY_DMA=y
CONFIG_B43LEGACY_PIO=y
CONFIG_B43LEGACY_DMA_AND_PIO_MODE=y
# CONFIG_B43LEGACY_DMA_MODE is not set
# CONFIG_B43LEGACY_PIO_MODE is not set
CONFIG_BRCMUTIL=m
CONFIG_BRCMSMAC=m
CONFIG_BRCMFMAC=m
CONFIG_BRCMFMAC_PROTO_BCDC=y
CONFIG_BRCMFMAC_PROTO_MSGBUF=y
CONFIG_BRCMFMAC_SDIO=y
CONFIG_BRCMFMAC_USB=y
CONFIG_BRCMFMAC_PCIE=y
CONFIG_BRCM_TRACING=y
# CONFIG_BRCMDBG is not set
CONFIG_WLAN_VENDOR_CISCO=y
CONFIG_AIRO=m
CONFIG_AIRO_CS=m
CONFIG_WLAN_VENDOR_INTEL=y
CONFIG_IPW2100=m
CONFIG_IPW2100_MONITOR=y
# CONFIG_IPW2100_DEBUG is not set
CONFIG_IPW2200=m
CONFIG_IPW2200_MONITOR=y
CONFIG_IPW2200_RADIOTAP=y
CONFIG_IPW2200_PROMISCUOUS=y
CONFIG_IPW2200_QOS=y
# CONFIG_IPW2200_DEBUG is not set
CONFIG_LIBIPW=m
# CONFIG_LIBIPW_DEBUG is not set
CONFIG_IWLEGACY=m
CONFIG_IWL4965=m
CONFIG_IWL3945=m

#
# iwl3945 / iwl4965 Debugging Options
#
# CONFIG_IWLEGACY_DEBUG is not set
CONFIG_IWLEGACY_DEBUGFS=y
# end of iwl3945 / iwl4965 Debugging Options

CONFIG_IWLWIFI=m
CONFIG_IWLWIFI_LEDS=y
CONFIG_IWLDVM=m
CONFIG_IWLMVM=m
CONFIG_IWLWIFI_OPMODE_MODULAR=y
# CONFIG_IWLWIFI_BCAST_FILTERING is not set

#
# Debugging Options
#
# CONFIG_IWLWIFI_DEBUG is not set
CONFIG_IWLWIFI_DEBUGFS=y
CONFIG_IWLWIFI_DEVICE_TRACING=y
# end of Debugging Options

CONFIG_WLAN_VENDOR_INTERSIL=y
CONFIG_HOSTAP=m
CONFIG_HOSTAP_FIRMWARE=y
CONFIG_HOSTAP_FIRMWARE_NVRAM=y
CONFIG_HOSTAP_PLX=m
CONFIG_HOSTAP_PCI=m
CONFIG_HOSTAP_CS=m
CONFIG_HERMES=m
# CONFIG_HERMES_PRISM is not set
CONFIG_HERMES_CACHE_FW_ON_INIT=y
CONFIG_PLX_HERMES=m
CONFIG_TMD_HERMES=m
CONFIG_NORTEL_HERMES=m
CONFIG_PCMCIA_HERMES=m
CONFIG_PCMCIA_SPECTRUM=m
CONFIG_ORINOCO_USB=m
CONFIG_P54_COMMON=m
CONFIG_P54_USB=m
CONFIG_P54_PCI=m
CONFIG_P54_SPI=m
# CONFIG_P54_SPI_DEFAULT_EEPROM is not set
CONFIG_P54_LEDS=y
CONFIG_WLAN_VENDOR_MARVELL=y
CONFIG_LIBERTAS=m
CONFIG_LIBERTAS_USB=m
CONFIG_LIBERTAS_CS=m
CONFIG_LIBERTAS_SDIO=m
CONFIG_LIBERTAS_SPI=m
# CONFIG_LIBERTAS_DEBUG is not set
CONFIG_LIBERTAS_MESH=y
CONFIG_LIBERTAS_THINFIRM=m
# CONFIG_LIBERTAS_THINFIRM_DEBUG is not set
CONFIG_LIBERTAS_THINFIRM_USB=m
CONFIG_MWIFIEX=m
CONFIG_MWIFIEX_SDIO=m
CONFIG_MWIFIEX_PCIE=m
CONFIG_MWIFIEX_USB=m
CONFIG_MWL8K=m
CONFIG_WLAN_VENDOR_MEDIATEK=y
CONFIG_MT7601U=m
CONFIG_MT76_CORE=m
CONFIG_MT76_LEDS=y
CONFIG_MT76_USB=m
CONFIG_MT76_SDIO=m
CONFIG_MT76x02_LIB=m
CONFIG_MT76x02_USB=m
CONFIG_MT76_CONNAC_LIB=m
CONFIG_MT76x0_COMMON=m
CONFIG_MT76x0U=m
CONFIG_MT76x0E=m
CONFIG_MT76x2_COMMON=m
CONFIG_MT76x2E=m
CONFIG_MT76x2U=m
CONFIG_MT7603E=m
CONFIG_MT7615_COMMON=m
CONFIG_MT7615E=m
CONFIG_MT7663_USB_SDIO_COMMON=m
CONFIG_MT7663U=m
CONFIG_MT7663S=m
CONFIG_MT7915E=m
CONFIG_MT7921E=m
CONFIG_WLAN_VENDOR_MICROCHIP=y
CONFIG_WILC1000=m
CONFIG_WILC1000_SDIO=m
CONFIG_WILC1000_SPI=m
CONFIG_WILC1000_HW_OOB_INTR=y
CONFIG_WLAN_VENDOR_RALINK=y
CONFIG_RT2X00=m
CONFIG_RT2400PCI=m
CONFIG_RT2500PCI=m
CONFIG_RT61PCI=m
CONFIG_RT2800PCI=m
CONFIG_RT2800PCI_RT33XX=y
CONFIG_RT2800PCI_RT35XX=y
CONFIG_RT2800PCI_RT53XX=y
CONFIG_RT2800PCI_RT3290=y
CONFIG_RT2500USB=m
CONFIG_RT73USB=m
CONFIG_RT2800USB=m
CONFIG_RT2800USB_RT33XX=y
CONFIG_RT2800USB_RT35XX=y
CONFIG_RT2800USB_RT3573=y
CONFIG_RT2800USB_RT53XX=y
CONFIG_RT2800USB_RT55XX=y
CONFIG_RT2800USB_UNKNOWN=y
CONFIG_RT2800_LIB=m
CONFIG_RT2800_LIB_MMIO=m
CONFIG_RT2X00_LIB_MMIO=m
CONFIG_RT2X00_LIB_PCI=m
CONFIG_RT2X00_LIB_USB=m
CONFIG_RT2X00_LIB=m
CONFIG_RT2X00_LIB_FIRMWARE=y
CONFIG_RT2X00_LIB_CRYPTO=y
CONFIG_RT2X00_LIB_LEDS=y
# CONFIG_RT2X00_LIB_DEBUGFS is not set
# CONFIG_RT2X00_DEBUG is not set
CONFIG_WLAN_VENDOR_REALTEK=y
CONFIG_RTL8180=m
CONFIG_RTL8187=m
CONFIG_RTL8187_LEDS=y
CONFIG_RTL_CARDS=m
CONFIG_RTL8192CE=m
CONFIG_RTL8192SE=m
CONFIG_RTL8192DE=m
CONFIG_RTL8723AE=m
CONFIG_RTL8723BE=m
CONFIG_RTL8188EE=m
CONFIG_RTL8192EE=m
CONFIG_RTL8821AE=m
CONFIG_RTL8192CU=m
CONFIG_RTLWIFI=m
CONFIG_RTLWIFI_PCI=m
CONFIG_RTLWIFI_USB=m
# CONFIG_RTLWIFI_DEBUG is not set
CONFIG_RTL8192C_COMMON=m
CONFIG_RTL8723_COMMON=m
CONFIG_RTLBTCOEXIST=m
CONFIG_RTL8XXXU=m
CONFIG_RTL8XXXU_UNTESTED=y
CONFIG_RTW88=m
CONFIG_RTW88_CORE=m
CONFIG_RTW88_PCI=m
CONFIG_RTW88_8822B=m
CONFIG_RTW88_8822C=m
CONFIG_RTW88_8723D=m
CONFIG_RTW88_8821C=m
CONFIG_RTW88_8822BE=m
CONFIG_RTW88_8822CE=m
CONFIG_RTW88_8723DE=m
CONFIG_RTW88_8821CE=m
CONFIG_RTW88_DEBUG=y
CONFIG_RTW88_DEBUGFS=y
CONFIG_WLAN_VENDOR_RSI=y
CONFIG_RSI_91X=m
# CONFIG_RSI_DEBUGFS is not set
CONFIG_RSI_SDIO=m
CONFIG_RSI_USB=m
CONFIG_RSI_COEX=y
CONFIG_WLAN_VENDOR_ST=y
CONFIG_CW1200=m
CONFIG_CW1200_WLAN_SDIO=m
CONFIG_CW1200_WLAN_SPI=m
CONFIG_WLAN_VENDOR_TI=y
CONFIG_WL1251=m
CONFIG_WL1251_SPI=m
CONFIG_WL1251_SDIO=m
CONFIG_WL12XX=m
CONFIG_WL18XX=m
CONFIG_WLCORE=m
CONFIG_WLCORE_SDIO=m
CONFIG_WILINK_PLATFORM_DATA=y
CONFIG_WLAN_VENDOR_ZYDAS=y
CONFIG_USB_ZD1201=m
CONFIG_ZD1211RW=m
# CONFIG_ZD1211RW_DEBUG is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
CONFIG_QTNFMAC=m
CONFIG_QTNFMAC_PCIE=m
CONFIG_PCMCIA_RAYCS=m
CONFIG_PCMCIA_WL3501=m
CONFIG_MAC80211_HWSIM=m
CONFIG_USB_NET_RNDIS_WLAN=m
CONFIG_VIRT_WIFI=m
CONFIG_WAN=y
CONFIG_LANMEDIA=m
CONFIG_HDLC=m
CONFIG_HDLC_RAW=m
CONFIG_HDLC_RAW_ETH=m
CONFIG_HDLC_CISCO=m
CONFIG_HDLC_FR=m
CONFIG_HDLC_PPP=m
CONFIG_HDLC_X25=m
CONFIG_PCI200SYN=m
CONFIG_WANXL=m
CONFIG_PC300TOO=m
CONFIG_FARSYNC=m
CONFIG_LAPBETHER=m
CONFIG_IEEE802154_DRIVERS=m
CONFIG_IEEE802154_FAKELB=m
CONFIG_IEEE802154_AT86RF230=m
CONFIG_IEEE802154_AT86RF230_DEBUGFS=y
CONFIG_IEEE802154_MRF24J40=m
CONFIG_IEEE802154_CC2520=m
CONFIG_IEEE802154_ATUSB=m
CONFIG_IEEE802154_ADF7242=m
CONFIG_IEEE802154_CA8210=m
CONFIG_IEEE802154_CA8210_DEBUGFS=y
CONFIG_IEEE802154_MCR20A=m
CONFIG_IEEE802154_HWSIM=m

#
# Wireless WAN
#
CONFIG_WWAN=y
CONFIG_WWAN_HWSIM=m
CONFIG_MHI_WWAN_CTRL=m
CONFIG_MHI_WWAN_MBIM=m
CONFIG_RPMSG_WWAN_CTRL=m
CONFIG_IOSM=m
# end of Wireless WAN

CONFIG_XEN_NETDEV_FRONTEND=y
CONFIG_XEN_NETDEV_BACKEND=m
CONFIG_VMXNET3=m
CONFIG_FUJITSU_ES=m
CONFIG_USB4_NET=m
CONFIG_HYPERV_NET=m
CONFIG_NETDEVSIM=m
CONFIG_NET_FAILOVER=m
CONFIG_ISDN=y
CONFIG_ISDN_CAPI=y
CONFIG_CAPI_TRACE=y
CONFIG_ISDN_CAPI_MIDDLEWARE=y
CONFIG_MISDN=m
CONFIG_MISDN_DSP=m
CONFIG_MISDN_L1OIP=m

#
# mISDN hardware drivers
#
CONFIG_MISDN_HFCPCI=m
CONFIG_MISDN_HFCMULTI=m
CONFIG_MISDN_HFCUSB=m
CONFIG_MISDN_AVMFRITZ=m
CONFIG_MISDN_SPEEDFAX=m
CONFIG_MISDN_INFINEON=m
CONFIG_MISDN_W6692=m
CONFIG_MISDN_NETJET=m
CONFIG_MISDN_HDLC=m
CONFIG_MISDN_IPAC=m
CONFIG_MISDN_ISAR=m

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=m
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_SPARSEKMAP=m
CONFIG_INPUT_MATRIXKMAP=m

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
CONFIG_INPUT_EVBUG=m

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ADC=m
CONFIG_KEYBOARD_ADP5520=m
CONFIG_KEYBOARD_ADP5588=m
CONFIG_KEYBOARD_ADP5589=m
CONFIG_KEYBOARD_APPLESPI=m
CONFIG_KEYBOARD_ATKBD=y
CONFIG_KEYBOARD_QT1050=m
CONFIG_KEYBOARD_QT1070=m
CONFIG_KEYBOARD_QT2160=m
CONFIG_KEYBOARD_DLINK_DIR685=m
CONFIG_KEYBOARD_LKKBD=m
CONFIG_KEYBOARD_GPIO=m
CONFIG_KEYBOARD_GPIO_POLLED=m
CONFIG_KEYBOARD_TCA6416=m
CONFIG_KEYBOARD_TCA8418=m
CONFIG_KEYBOARD_MATRIX=m
CONFIG_KEYBOARD_LM8323=m
CONFIG_KEYBOARD_LM8333=m
CONFIG_KEYBOARD_MAX7359=m
CONFIG_KEYBOARD_MCS=m
CONFIG_KEYBOARD_MPR121=m
CONFIG_KEYBOARD_NEWTON=m
CONFIG_KEYBOARD_OPENCORES=m
CONFIG_KEYBOARD_SAMSUNG=m
CONFIG_KEYBOARD_STOWAWAY=m
CONFIG_KEYBOARD_SUNKBD=m
CONFIG_KEYBOARD_IQS62X=m
CONFIG_KEYBOARD_TM2_TOUCHKEY=m
CONFIG_KEYBOARD_TWL4030=m
CONFIG_KEYBOARD_XTKBD=m
CONFIG_KEYBOARD_CROS_EC=m
CONFIG_KEYBOARD_MTK_PMIC=m
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=m
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
CONFIG_MOUSE_PS2_TOUCHKIT=y
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
CONFIG_MOUSE_APPLETOUCH=m
CONFIG_MOUSE_BCM5974=m
CONFIG_MOUSE_CYAPA=m
CONFIG_MOUSE_ELAN_I2C=m
CONFIG_MOUSE_ELAN_I2C_I2C=y
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
CONFIG_MOUSE_VSXXXAA=m
CONFIG_MOUSE_GPIO=m
CONFIG_MOUSE_SYNAPTICS_I2C=m
CONFIG_MOUSE_SYNAPTICS_USB=m
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=m
CONFIG_JOYSTICK_A3D=m
CONFIG_JOYSTICK_ADC=m
CONFIG_JOYSTICK_ADI=m
CONFIG_JOYSTICK_COBRA=m
CONFIG_JOYSTICK_GF2K=m
CONFIG_JOYSTICK_GRIP=m
CONFIG_JOYSTICK_GRIP_MP=m
CONFIG_JOYSTICK_GUILLEMOT=m
CONFIG_JOYSTICK_INTERACT=m
CONFIG_JOYSTICK_SIDEWINDER=m
CONFIG_JOYSTICK_TMDC=m
CONFIG_JOYSTICK_IFORCE=m
CONFIG_JOYSTICK_IFORCE_USB=m
CONFIG_JOYSTICK_IFORCE_232=m
CONFIG_JOYSTICK_WARRIOR=m
CONFIG_JOYSTICK_MAGELLAN=m
CONFIG_JOYSTICK_SPACEORB=m
CONFIG_JOYSTICK_SPACEBALL=m
CONFIG_JOYSTICK_STINGER=m
CONFIG_JOYSTICK_TWIDJOY=m
CONFIG_JOYSTICK_ZHENHUA=m
CONFIG_JOYSTICK_DB9=m
CONFIG_JOYSTICK_GAMECON=m
CONFIG_JOYSTICK_TURBOGRAFX=m
CONFIG_JOYSTICK_AS5011=m
CONFIG_JOYSTICK_JOYDUMP=m
CONFIG_JOYSTICK_XPAD=m
CONFIG_JOYSTICK_XPAD_FF=y
CONFIG_JOYSTICK_XPAD_LEDS=y
CONFIG_JOYSTICK_WALKERA0701=m
CONFIG_JOYSTICK_PSXPAD_SPI=m
CONFIG_JOYSTICK_PSXPAD_SPI_FF=y
CONFIG_JOYSTICK_PXRC=m
CONFIG_JOYSTICK_QWIIC=m
CONFIG_JOYSTICK_FSIA6B=m
CONFIG_INPUT_TABLET=y
CONFIG_TABLET_USB_ACECAD=m
CONFIG_TABLET_USB_AIPTEK=m
CONFIG_TABLET_USB_HANWANG=m
CONFIG_TABLET_USB_KBTAB=m
CONFIG_TABLET_USB_PEGASUS=m
CONFIG_TABLET_SERIAL_WACOM4=m
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_88PM860X=m
CONFIG_TOUCHSCREEN_ADS7846=m
CONFIG_TOUCHSCREEN_AD7877=m
CONFIG_TOUCHSCREEN_AD7879=m
CONFIG_TOUCHSCREEN_AD7879_I2C=m
CONFIG_TOUCHSCREEN_AD7879_SPI=m
CONFIG_TOUCHSCREEN_ADC=m
CONFIG_TOUCHSCREEN_ATMEL_MXT=m
CONFIG_TOUCHSCREEN_ATMEL_MXT_T37=y
CONFIG_TOUCHSCREEN_AUO_PIXCIR=m
CONFIG_TOUCHSCREEN_BU21013=m
CONFIG_TOUCHSCREEN_BU21029=m
CONFIG_TOUCHSCREEN_CHIPONE_ICN8505=m
CONFIG_TOUCHSCREEN_CY8CTMA140=m
CONFIG_TOUCHSCREEN_CY8CTMG110=m
CONFIG_TOUCHSCREEN_CYTTSP_CORE=m
CONFIG_TOUCHSCREEN_CYTTSP_I2C=m
CONFIG_TOUCHSCREEN_CYTTSP_SPI=m
CONFIG_TOUCHSCREEN_CYTTSP4_CORE=m
CONFIG_TOUCHSCREEN_CYTTSP4_I2C=m
CONFIG_TOUCHSCREEN_CYTTSP4_SPI=m
CONFIG_TOUCHSCREEN_DA9034=m
CONFIG_TOUCHSCREEN_DA9052=m
CONFIG_TOUCHSCREEN_DYNAPRO=m
CONFIG_TOUCHSCREEN_HAMPSHIRE=m
CONFIG_TOUCHSCREEN_EETI=m
CONFIG_TOUCHSCREEN_EGALAX_SERIAL=m
CONFIG_TOUCHSCREEN_EXC3000=m
CONFIG_TOUCHSCREEN_FUJITSU=m
CONFIG_TOUCHSCREEN_GOODIX=m
CONFIG_TOUCHSCREEN_HIDEEP=m
CONFIG_TOUCHSCREEN_HYCON_HY46XX=m
CONFIG_TOUCHSCREEN_ILI210X=m
CONFIG_TOUCHSCREEN_ILITEK=m
CONFIG_TOUCHSCREEN_S6SY761=m
CONFIG_TOUCHSCREEN_GUNZE=m
CONFIG_TOUCHSCREEN_EKTF2127=m
CONFIG_TOUCHSCREEN_ELAN=y
CONFIG_TOUCHSCREEN_ELO=m
CONFIG_TOUCHSCREEN_WACOM_W8001=m
CONFIG_TOUCHSCREEN_WACOM_I2C=m
CONFIG_TOUCHSCREEN_MAX11801=m
CONFIG_TOUCHSCREEN_MCS5000=m
CONFIG_TOUCHSCREEN_MMS114=m
CONFIG_TOUCHSCREEN_MELFAS_MIP4=m
CONFIG_TOUCHSCREEN_MSG2638=m
CONFIG_TOUCHSCREEN_MTOUCH=m
CONFIG_TOUCHSCREEN_INEXIO=m
CONFIG_TOUCHSCREEN_MK712=m
CONFIG_TOUCHSCREEN_PENMOUNT=m
CONFIG_TOUCHSCREEN_EDT_FT5X06=m
CONFIG_TOUCHSCREEN_TOUCHRIGHT=m
CONFIG_TOUCHSCREEN_TOUCHWIN=m
CONFIG_TOUCHSCREEN_TI_AM335X_TSC=m
CONFIG_TOUCHSCREEN_UCB1400=m
CONFIG_TOUCHSCREEN_PIXCIR=m
CONFIG_TOUCHSCREEN_WDT87XX_I2C=m
CONFIG_TOUCHSCREEN_WM831X=m
CONFIG_TOUCHSCREEN_WM97XX=m
CONFIG_TOUCHSCREEN_WM9705=y
CONFIG_TOUCHSCREEN_WM9712=y
CONFIG_TOUCHSCREEN_WM9713=y
CONFIG_TOUCHSCREEN_USB_COMPOSITE=m
CONFIG_TOUCHSCREEN_MC13783=m
CONFIG_TOUCHSCREEN_USB_EGALAX=y
CONFIG_TOUCHSCREEN_USB_PANJIT=y
CONFIG_TOUCHSCREEN_USB_3M=y
CONFIG_TOUCHSCREEN_USB_ITM=y
CONFIG_TOUCHSCREEN_USB_ETURBO=y
CONFIG_TOUCHSCREEN_USB_GUNZE=y
CONFIG_TOUCHSCREEN_USB_DMC_TSC10=y
CONFIG_TOUCHSCREEN_USB_IRTOUCH=y
CONFIG_TOUCHSCREEN_USB_IDEALTEK=y
CONFIG_TOUCHSCREEN_USB_GENERAL_TOUCH=y
CONFIG_TOUCHSCREEN_USB_GOTOP=y
CONFIG_TOUCHSCREEN_USB_JASTEC=y
CONFIG_TOUCHSCREEN_USB_ELO=y
CONFIG_TOUCHSCREEN_USB_E2I=y
CONFIG_TOUCHSCREEN_USB_ZYTRONIC=y
CONFIG_TOUCHSCREEN_USB_ETT_TC45USB=y
CONFIG_TOUCHSCREEN_USB_NEXIO=y
CONFIG_TOUCHSCREEN_USB_EASYTOUCH=y
CONFIG_TOUCHSCREEN_TOUCHIT213=m
CONFIG_TOUCHSCREEN_TSC_SERIO=m
CONFIG_TOUCHSCREEN_TSC200X_CORE=m
CONFIG_TOUCHSCREEN_TSC2004=m
CONFIG_TOUCHSCREEN_TSC2005=m
CONFIG_TOUCHSCREEN_TSC2007=m
CONFIG_TOUCHSCREEN_TSC2007_IIO=y
CONFIG_TOUCHSCREEN_PCAP=m
CONFIG_TOUCHSCREEN_RM_TS=m
CONFIG_TOUCHSCREEN_SILEAD=m
CONFIG_TOUCHSCREEN_SIS_I2C=m
CONFIG_TOUCHSCREEN_ST1232=m
CONFIG_TOUCHSCREEN_STMFTS=m
CONFIG_TOUCHSCREEN_SUR40=m
CONFIG_TOUCHSCREEN_SURFACE3_SPI=m
CONFIG_TOUCHSCREEN_SX8654=m
CONFIG_TOUCHSCREEN_TPS6507X=m
CONFIG_TOUCHSCREEN_ZET6223=m
CONFIG_TOUCHSCREEN_ZFORCE=m
CONFIG_TOUCHSCREEN_ROHM_BU21023=m
CONFIG_TOUCHSCREEN_IQS5XX=m
CONFIG_TOUCHSCREEN_ZINITIX=m
CONFIG_INPUT_MISC=y
CONFIG_INPUT_88PM860X_ONKEY=m
CONFIG_INPUT_88PM80X_ONKEY=m
CONFIG_INPUT_AD714X=m
CONFIG_INPUT_AD714X_I2C=m
CONFIG_INPUT_AD714X_SPI=m
CONFIG_INPUT_ARIZONA_HAPTICS=m
CONFIG_INPUT_ATC260X_ONKEY=m
CONFIG_INPUT_BMA150=m
CONFIG_INPUT_E3X0_BUTTON=m
CONFIG_INPUT_PCSPKR=m
CONFIG_INPUT_MAX77693_HAPTIC=m
CONFIG_INPUT_MAX8925_ONKEY=m
CONFIG_INPUT_MAX8997_HAPTIC=m
CONFIG_INPUT_MC13783_PWRBUTTON=m
CONFIG_INPUT_MMA8450=m
CONFIG_INPUT_APANEL=m
CONFIG_INPUT_GPIO_BEEPER=m
CONFIG_INPUT_GPIO_DECODER=m
CONFIG_INPUT_GPIO_VIBRA=m
CONFIG_INPUT_ATLAS_BTNS=m
CONFIG_INPUT_ATI_REMOTE2=m
CONFIG_INPUT_KEYSPAN_REMOTE=m
CONFIG_INPUT_KXTJ9=m
CONFIG_INPUT_POWERMATE=m
CONFIG_INPUT_YEALINK=m
CONFIG_INPUT_CM109=m
CONFIG_INPUT_REGULATOR_HAPTIC=m
CONFIG_INPUT_RETU_PWRBUTTON=m
CONFIG_INPUT_AXP20X_PEK=m
CONFIG_INPUT_TWL4030_PWRBUTTON=m
CONFIG_INPUT_TWL4030_VIBRA=m
CONFIG_INPUT_TWL6040_VIBRA=m
CONFIG_INPUT_UINPUT=y
CONFIG_INPUT_PALMAS_PWRBUTTON=m
CONFIG_INPUT_PCF50633_PMU=m
CONFIG_INPUT_PCF8574=m
CONFIG_INPUT_PWM_BEEPER=m
CONFIG_INPUT_PWM_VIBRA=m
CONFIG_INPUT_GPIO_ROTARY_ENCODER=m
CONFIG_INPUT_DA7280_HAPTICS=m
CONFIG_INPUT_DA9052_ONKEY=m
CONFIG_INPUT_DA9055_ONKEY=m
CONFIG_INPUT_DA9063_ONKEY=m
CONFIG_INPUT_WM831X_ON=m
CONFIG_INPUT_PCAP=m
CONFIG_INPUT_ADXL34X=m
CONFIG_INPUT_ADXL34X_I2C=m
CONFIG_INPUT_ADXL34X_SPI=m
CONFIG_INPUT_IMS_PCU=m
CONFIG_INPUT_IQS269A=m
CONFIG_INPUT_IQS626A=m
CONFIG_INPUT_CMA3000=m
CONFIG_INPUT_CMA3000_I2C=m
CONFIG_INPUT_XEN_KBDDEV_FRONTEND=m
CONFIG_INPUT_IDEAPAD_SLIDEBAR=m
CONFIG_INPUT_SOC_BUTTON_ARRAY=m
CONFIG_INPUT_DRV260X_HAPTICS=m
CONFIG_INPUT_DRV2665_HAPTICS=m
CONFIG_INPUT_DRV2667_HAPTICS=m
CONFIG_INPUT_RAVE_SP_PWRBUTTON=m
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SPI=m
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
CONFIG_RMI4_F3A=y
CONFIG_RMI4_F54=y
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=m
CONFIG_SERIO_CT82C710=m
CONFIG_SERIO_PARKBD=m
CONFIG_SERIO_PCIPS2=m
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
CONFIG_SERIO_PS2MULT=m
CONFIG_SERIO_ARC_PS2=m
CONFIG_HYPERV_KEYBOARD=m
CONFIG_SERIO_GPIO_PS2=m
CONFIG_USERIO=m
CONFIG_GAMEPORT=m
CONFIG_GAMEPORT_NS558=m
CONFIG_GAMEPORT_L4=m
CONFIG_GAMEPORT_EMU10K1=m
CONFIG_GAMEPORT_FM801=m
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=0
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
CONFIG_SERIAL_8250_16550A_VARIANTS=y
CONFIG_SERIAL_8250_FINTEK=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=m
CONFIG_SERIAL_8250_CS=m
CONFIG_SERIAL_8250_MEN_MCB=m
CONFIG_SERIAL_8250_NR_UARTS=48
CONFIG_SERIAL_8250_RUNTIME_UARTS=32
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=m
CONFIG_SERIAL_8250_RT288X=y
CONFIG_SERIAL_8250_LPSS=m
CONFIG_SERIAL_8250_MID=m

#
# Non-8250 serial port support
#
CONFIG_SERIAL_KGDB_NMI=y
CONFIG_SERIAL_MAX3100=m
CONFIG_SERIAL_MAX310X=y
CONFIG_SERIAL_UARTLITE=m
CONFIG_SERIAL_UARTLITE_NR_UARTS=1
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_CONSOLE_POLL=y
CONFIG_SERIAL_JSM=m
CONFIG_SERIAL_LANTIQ=m
CONFIG_SERIAL_SCCNXP=y
CONFIG_SERIAL_SCCNXP_CONSOLE=y
CONFIG_SERIAL_SC16IS7XX_CORE=m
CONFIG_SERIAL_SC16IS7XX=m
CONFIG_SERIAL_SC16IS7XX_I2C=y
CONFIG_SERIAL_SC16IS7XX_SPI=y
CONFIG_SERIAL_BCM63XX=m
CONFIG_SERIAL_ALTERA_JTAGUART=m
CONFIG_SERIAL_ALTERA_UART=m
CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
CONFIG_SERIAL_RP2=m
CONFIG_SERIAL_RP2_NR_UARTS=32
CONFIG_SERIAL_FSL_LPUART=m
CONFIG_SERIAL_FSL_LINFLEXUART=m
CONFIG_SERIAL_MEN_Z135=m
CONFIG_SERIAL_SPRD=m
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
CONFIG_MOXA_INTELLIO=m
CONFIG_MOXA_SMARTIO=m
CONFIG_SYNCLINK_GT=m
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
CONFIG_NOZOMI=m
CONFIG_NULL_TTY=m
CONFIG_HVC_DRIVER=y
CONFIG_HVC_IRQ=y
CONFIG_HVC_XEN=y
CONFIG_HVC_XEN_FRONTEND=y
CONFIG_SERIAL_DEV_BUS=y
CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
CONFIG_TTY_PRINTK=y
CONFIG_TTY_PRINTK_LEVEL=6
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_VIRTIO_CONSOLE=y
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
CONFIG_HW_RANDOM_BA431=m
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=m
CONFIG_HW_RANDOM_XIPHERA=m
CONFIG_APPLICOM=m

#
# PCMCIA character devices
#
CONFIG_SYNCLINK_CS=m
CONFIG_CARDMAN_4000=m
CONFIG_CARDMAN_4040=m
CONFIG_SCR24X=m
CONFIG_IPWIRELESS=m
# end of PCMCIA character devices

CONFIG_MWAVE=m
CONFIG_DEVMEM=y
CONFIG_NVRAM=m
CONFIG_DEVPORT=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
CONFIG_HPET_MMAP_DEFAULT=y
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
CONFIG_TCG_TIS_SPI=m
CONFIG_TCG_TIS_SPI_CR50=y
CONFIG_TCG_TIS_I2C_CR50=m
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
CONFIG_TCG_XEN=m
CONFIG_TCG_CRB=y
CONFIG_TCG_VTPM_PROXY=m
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
CONFIG_TCG_TIS_ST33ZP24_SPI=m
CONFIG_TELCLOCK=m
CONFIG_XILLYBUS_CLASS=m
CONFIG_XILLYBUS=m
CONFIG_XILLYBUS_PCIE=m
CONFIG_XILLYUSB=m
CONFIG_RANDOM_TRUST_CPU=y
CONFIG_RANDOM_TRUST_BOOTLOADER=y
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_MUX_GPIO=m
CONFIG_I2C_MUX_LTC4306=m
CONFIG_I2C_MUX_PCA9541=m
CONFIG_I2C_MUX_PCA954x=m
CONFIG_I2C_MUX_REG=m
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
CONFIG_I2C_ALI1535=m
CONFIG_I2C_ALI1563=m
CONFIG_I2C_ALI15X3=m
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD756_S4882=m
CONFIG_I2C_AMD8111=m
CONFIG_I2C_AMD_MP2=m
CONFIG_I2C_I801=m
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_CHT_WC=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
CONFIG_I2C_NVIDIA_GPU=m
CONFIG_I2C_SIS5595=m
CONFIG_I2C_SIS630=m
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=m
CONFIG_I2C_DESIGNWARE_CORE=y
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=y
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
CONFIG_I2C_DESIGNWARE_PCI=m
# CONFIG_I2C_EMEV2 is not set
CONFIG_I2C_GPIO=m
# CONFIG_I2C_GPIO_FAULT_INJECTOR is not set
CONFIG_I2C_KEMPLD=m
CONFIG_I2C_OCORES=m
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
CONFIG_I2C_XILINX=m

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=m
CONFIG_I2C_DLN2=m
CONFIG_I2C_CP2615=m
CONFIG_I2C_PARPORT=m
CONFIG_I2C_ROBOTFUZZ_OSIF=m
CONFIG_I2C_TAOS_EVM=m
CONFIG_I2C_TINY_USB=m
CONFIG_I2C_VIPERBOARD=m

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
CONFIG_I2C_CROS_EC_TUNNEL=m
CONFIG_I2C_VIRTIO=m
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

CONFIG_I3C=m
CONFIG_CDNS_I3C_MASTER=m
CONFIG_DW_I3C_MASTER=m
CONFIG_SVC_I3C_MASTER=m
CONFIG_MIPI_I3C_HCI=m
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
CONFIG_SPI_MEM=y

#
# SPI Master Controller Drivers
#
CONFIG_SPI_ALTERA=m
CONFIG_SPI_ALTERA_CORE=m
CONFIG_SPI_ALTERA_DFL=m
CONFIG_SPI_AXI_SPI_ENGINE=m
CONFIG_SPI_BITBANG=m
CONFIG_SPI_BUTTERFLY=m
CONFIG_SPI_CADENCE=m
CONFIG_SPI_DESIGNWARE=m
CONFIG_SPI_DW_DMA=y
CONFIG_SPI_DW_PCI=m
CONFIG_SPI_DW_MMIO=m
CONFIG_SPI_DLN2=m
CONFIG_SPI_NXP_FLEXSPI=m
CONFIG_SPI_GPIO=m
CONFIG_SPI_LM70_LLP=m
CONFIG_SPI_LANTIQ_SSC=m
CONFIG_SPI_OC_TINY=m
CONFIG_SPI_PXA2XX=m
CONFIG_SPI_PXA2XX_PCI=m
# CONFIG_SPI_ROCKCHIP is not set
CONFIG_SPI_SC18IS602=m
CONFIG_SPI_SIFIVE=m
CONFIG_SPI_MXIC=m
CONFIG_SPI_XCOMM=m
# CONFIG_SPI_XILINX is not set
CONFIG_SPI_ZYNQMP_GQSPI=m
CONFIG_SPI_AMD=m

#
# SPI Multiplexer support
#
CONFIG_SPI_MUX=m

#
# SPI Protocol Masters
#
CONFIG_SPI_SPIDEV=m
CONFIG_SPI_LOOPBACK_TEST=m
CONFIG_SPI_TLE62X0=m
CONFIG_SPI_SLAVE=y
CONFIG_SPI_SLAVE_TIME=m
CONFIG_SPI_SLAVE_SYSTEM_CONTROL=m
CONFIG_SPI_DYNAMIC=y
CONFIG_SPMI=m
CONFIG_SPMI_HISI3670=m
CONFIG_HSI=m
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
CONFIG_HSI_CHAR=m
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_PTP_1588_CLOCK_OPTIONAL=y
CONFIG_DP83640_PHY=m
CONFIG_PTP_1588_CLOCK_INES=m
CONFIG_PTP_1588_CLOCK_KVM=m
CONFIG_PTP_1588_CLOCK_IDT82P33=m
CONFIG_PTP_1588_CLOCK_IDTCM=m
CONFIG_PTP_1588_CLOCK_VMW=m
CONFIG_PTP_1588_CLOCK_OCP=m
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AMD=y
CONFIG_PINCTRL_DA9062=m
CONFIG_PINCTRL_MCP23S08_I2C=m
CONFIG_PINCTRL_MCP23S08_SPI=m
CONFIG_PINCTRL_MCP23S08=m
CONFIG_PINCTRL_SX150X=y
CONFIG_PINCTRL_BAYTRAIL=y
CONFIG_PINCTRL_CHERRYVIEW=y
CONFIG_PINCTRL_LYNXPOINT=m
CONFIG_PINCTRL_INTEL=y
CONFIG_PINCTRL_ALDERLAKE=m
CONFIG_PINCTRL_BROXTON=m
CONFIG_PINCTRL_CANNONLAKE=m
CONFIG_PINCTRL_CEDARFORK=m
CONFIG_PINCTRL_DENVERTON=m
CONFIG_PINCTRL_ELKHARTLAKE=m
CONFIG_PINCTRL_EMMITSBURG=m
CONFIG_PINCTRL_GEMINILAKE=m
CONFIG_PINCTRL_ICELAKE=m
CONFIG_PINCTRL_JASPERLAKE=m
CONFIG_PINCTRL_LAKEFIELD=m
CONFIG_PINCTRL_LEWISBURG=m
CONFIG_PINCTRL_SUNRISEPOINT=m
CONFIG_PINCTRL_TIGERLAKE=m

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_PINCTRL_MADERA=m
CONFIG_PINCTRL_CS47L15=y
CONFIG_PINCTRL_CS47L35=y
CONFIG_PINCTRL_CS47L85=y
CONFIG_PINCTRL_CS47L90=y
CONFIG_PINCTRL_CS47L92=y
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_CDEV=y
# CONFIG_GPIO_CDEV_V1 is not set
CONFIG_GPIO_GENERIC=m
CONFIG_GPIO_MAX730X=m

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_AMDPT=m
CONFIG_GPIO_DWAPB=m
CONFIG_GPIO_EXAR=m
CONFIG_GPIO_GENERIC_PLATFORM=m
CONFIG_GPIO_ICH=m
CONFIG_GPIO_MB86S7X=m
CONFIG_GPIO_MENZ127=m
CONFIG_GPIO_SIOX=m
CONFIG_GPIO_VX855=m
CONFIG_GPIO_AMD_FCH=m
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_104_DIO_48E=m
CONFIG_GPIO_104_IDIO_16=m
CONFIG_GPIO_104_IDI_48=m
CONFIG_GPIO_F7188X=m
CONFIG_GPIO_GPIO_MM=m
CONFIG_GPIO_IT87=m
CONFIG_GPIO_SCH=m
CONFIG_GPIO_SCH311X=m
CONFIG_GPIO_WINBOND=m
CONFIG_GPIO_WS16C48=m
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=m
CONFIG_GPIO_MAX7300=m
CONFIG_GPIO_MAX732X=m
CONFIG_GPIO_PCA953X=m
CONFIG_GPIO_PCA953X_IRQ=y
CONFIG_GPIO_PCA9570=m
CONFIG_GPIO_PCF857X=m
CONFIG_GPIO_TPIC2810=m
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_ADP5520=m
CONFIG_GPIO_ARIZONA=m
CONFIG_GPIO_BD9571MWV=m
CONFIG_GPIO_CRYSTAL_COVE=y
CONFIG_GPIO_DA9052=m
CONFIG_GPIO_DA9055=m
CONFIG_GPIO_DLN2=m
CONFIG_GPIO_JANZ_TTL=m
CONFIG_GPIO_KEMPLD=m
CONFIG_GPIO_LP3943=m
CONFIG_GPIO_LP873X=m
CONFIG_GPIO_MADERA=m
CONFIG_GPIO_PALMAS=y
CONFIG_GPIO_RC5T583=y
CONFIG_GPIO_TPS65086=m
CONFIG_GPIO_TPS6586X=y
CONFIG_GPIO_TPS65910=y
CONFIG_GPIO_TPS65912=m
CONFIG_GPIO_TPS68470=y
CONFIG_GPIO_TQMX86=m
CONFIG_GPIO_TWL4030=m
CONFIG_GPIO_TWL6040=m
CONFIG_GPIO_UCB1400=m
CONFIG_GPIO_WHISKEY_COVE=m
CONFIG_GPIO_WM831X=m
CONFIG_GPIO_WM8350=m
CONFIG_GPIO_WM8994=m
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
CONFIG_GPIO_AMD8111=m
CONFIG_GPIO_ML_IOH=m
CONFIG_GPIO_PCI_IDIO_16=m
CONFIG_GPIO_PCIE_IDIO_24=m
CONFIG_GPIO_RDC321X=m
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
CONFIG_GPIO_MAX3191X=m
CONFIG_GPIO_MAX7301=m
CONFIG_GPIO_MC33880=m
CONFIG_GPIO_PISOSR=m
CONFIG_GPIO_XRA1403=m
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
CONFIG_GPIO_VIPERBOARD=m
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
CONFIG_GPIO_AGGREGATOR=m
# CONFIG_GPIO_MOCKUP is not set
CONFIG_GPIO_VIRTIO=m
# end of Virtual GPIO drivers

CONFIG_W1=m
CONFIG_W1_CON=y

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_MATROX=m
CONFIG_W1_MASTER_DS2490=m
CONFIG_W1_MASTER_DS2482=m
CONFIG_W1_MASTER_DS1WM=m
CONFIG_W1_MASTER_GPIO=m
CONFIG_W1_MASTER_SGI=m
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=m
CONFIG_W1_SLAVE_SMEM=m
CONFIG_W1_SLAVE_DS2405=m
CONFIG_W1_SLAVE_DS2408=m
CONFIG_W1_SLAVE_DS2408_READBACK=y
CONFIG_W1_SLAVE_DS2413=m
CONFIG_W1_SLAVE_DS2406=m
CONFIG_W1_SLAVE_DS2423=m
CONFIG_W1_SLAVE_DS2805=m
CONFIG_W1_SLAVE_DS2430=m
CONFIG_W1_SLAVE_DS2431=m
CONFIG_W1_SLAVE_DS2433=m
# CONFIG_W1_SLAVE_DS2433_CRC is not set
CONFIG_W1_SLAVE_DS2438=m
CONFIG_W1_SLAVE_DS250X=m
CONFIG_W1_SLAVE_DS2780=m
CONFIG_W1_SLAVE_DS2781=m
CONFIG_W1_SLAVE_DS28E04=m
CONFIG_W1_SLAVE_DS28E17=m
# end of 1-wire Slaves

CONFIG_POWER_RESET=y
CONFIG_POWER_RESET_ATC260X=m
CONFIG_POWER_RESET_MT6323=y
CONFIG_POWER_RESET_RESTART=y
CONFIG_POWER_RESET_TPS65086=y
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
CONFIG_PDA_POWER=m
CONFIG_GENERIC_ADC_BATTERY=m
CONFIG_MAX8925_POWER=m
CONFIG_WM831X_BACKUP=m
CONFIG_WM831X_POWER=m
CONFIG_WM8350_POWER=m
CONFIG_TEST_POWER=m
CONFIG_BATTERY_88PM860X=m
CONFIG_CHARGER_ADP5061=m
CONFIG_BATTERY_CW2015=m
CONFIG_BATTERY_DS2760=m
CONFIG_BATTERY_DS2780=m
CONFIG_BATTERY_DS2781=m
CONFIG_BATTERY_DS2782=m
CONFIG_BATTERY_SBS=m
CONFIG_CHARGER_SBS=m
CONFIG_MANAGER_SBS=m
CONFIG_BATTERY_BQ27XXX=m
CONFIG_BATTERY_BQ27XXX_I2C=m
CONFIG_BATTERY_BQ27XXX_HDQ=m
# CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM is not set
CONFIG_BATTERY_DA9030=m
CONFIG_BATTERY_DA9052=m
CONFIG_CHARGER_DA9150=m
CONFIG_BATTERY_DA9150=m
CONFIG_CHARGER_AXP20X=m
CONFIG_BATTERY_AXP20X=m
CONFIG_AXP20X_POWER=m
CONFIG_AXP288_CHARGER=m
CONFIG_AXP288_FUEL_GAUGE=m
CONFIG_BATTERY_MAX17040=m
CONFIG_BATTERY_MAX17042=m
CONFIG_BATTERY_MAX1721X=m
CONFIG_BATTERY_TWL4030_MADC=m
CONFIG_CHARGER_88PM860X=m
CONFIG_CHARGER_PCF50633=m
CONFIG_BATTERY_RX51=m
CONFIG_CHARGER_ISP1704=m
CONFIG_CHARGER_MAX8903=m
CONFIG_CHARGER_TWL4030=m
CONFIG_CHARGER_LP8727=m
CONFIG_CHARGER_LP8788=m
CONFIG_CHARGER_GPIO=m
CONFIG_CHARGER_MANAGER=y
CONFIG_CHARGER_LT3651=m
CONFIG_CHARGER_LTC4162L=m
CONFIG_CHARGER_MAX14577=m
CONFIG_CHARGER_MAX77693=m
CONFIG_CHARGER_MAX8997=m
CONFIG_CHARGER_MAX8998=m
CONFIG_CHARGER_MP2629=m
CONFIG_CHARGER_MT6360=m
CONFIG_CHARGER_BQ2415X=m
CONFIG_CHARGER_BQ24190=m
CONFIG_CHARGER_BQ24257=m
CONFIG_CHARGER_BQ24735=m
CONFIG_CHARGER_BQ2515X=m
CONFIG_CHARGER_BQ25890=m
CONFIG_CHARGER_BQ25980=m
CONFIG_CHARGER_BQ256XX=m
CONFIG_CHARGER_SMB347=m
CONFIG_CHARGER_TPS65090=m
CONFIG_BATTERY_GAUGE_LTC2941=m
CONFIG_BATTERY_GOLDFISH=m
CONFIG_BATTERY_RT5033=m
CONFIG_CHARGER_RT9455=m
CONFIG_CHARGER_CROS_USBPD=m
CONFIG_CHARGER_CROS_PCHG=m
CONFIG_CHARGER_BD99954=m
CONFIG_CHARGER_WILCO=m
CONFIG_BATTERY_SURFACE=m
CONFIG_CHARGER_SURFACE=m
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
CONFIG_SENSORS_AD7314=m
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
CONFIG_SENSORS_ADM1177=m
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
CONFIG_SENSORS_ADT7310=m
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
CONFIG_SENSORS_AHT10=m
CONFIG_SENSORS_AQUACOMPUTER_D5NEXT=m
CONFIG_SENSORS_AS370=m
CONFIG_SENSORS_ASC7621=m
CONFIG_SENSORS_AXI_FAN_CONTROL=m
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
CONFIG_SENSORS_ASPEED=m
CONFIG_SENSORS_ATXP1=m
CONFIG_SENSORS_CORSAIR_CPRO=m
CONFIG_SENSORS_CORSAIR_PSU=m
CONFIG_SENSORS_DRIVETEMP=m
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=m
CONFIG_SENSORS_DA9052_ADC=m
CONFIG_SENSORS_DA9055=m
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_MC13783_ADC=m
CONFIG_SENSORS_FSCHMD=m
CONFIG_SENSORS_FTSTEUTATES=m
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
CONFIG_SENSORS_G762=m
CONFIG_SENSORS_HIH6130=m
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
CONFIG_SENSORS_IIO_HWMON=m
CONFIG_SENSORS_I5500=m
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
CONFIG_SENSORS_POWR1220=m
CONFIG_SENSORS_LINEAGE=m
CONFIG_SENSORS_LTC2945=m
CONFIG_SENSORS_LTC2947=m
CONFIG_SENSORS_LTC2947_I2C=m
CONFIG_SENSORS_LTC2947_SPI=m
CONFIG_SENSORS_LTC2990=m
CONFIG_SENSORS_LTC2992=m
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
CONFIG_SENSORS_LTC4222=m
CONFIG_SENSORS_LTC4245=m
CONFIG_SENSORS_LTC4260=m
CONFIG_SENSORS_LTC4261=m
CONFIG_SENSORS_MAX1111=m
CONFIG_SENSORS_MAX127=m
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
CONFIG_SENSORS_MAX31722=m
CONFIG_SENSORS_MAX31730=m
CONFIG_SENSORS_MAX6621=m
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
CONFIG_SENSORS_MAX31790=m
CONFIG_SENSORS_MCP3021=m
CONFIG_SENSORS_MLXREG_FAN=m
CONFIG_SENSORS_TC654=m
CONFIG_SENSORS_TPS23861=m
CONFIG_SENSORS_MENF21BMC_HWMON=m
CONFIG_SENSORS_MR75203=m
CONFIG_SENSORS_ADCXX=m
CONFIG_SENSORS_LM63=m
CONFIG_SENSORS_LM70=m
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_NTC_THERMISTOR=m
CONFIG_SENSORS_NCT6683=m
CONFIG_SENSORS_NCT6775=m
CONFIG_SENSORS_NCT7802=m
CONFIG_SENSORS_NCT7904=m
CONFIG_SENSORS_NPCM7XX=m
CONFIG_SENSORS_NZXT_KRAKEN2=m
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
CONFIG_SENSORS_ADM1266=m
CONFIG_SENSORS_ADM1275=m
CONFIG_SENSORS_BEL_PFE=m
CONFIG_SENSORS_BPA_RS600=m
CONFIG_SENSORS_FSP_3Y=m
CONFIG_SENSORS_IBM_CFFPS=m
CONFIG_SENSORS_DPS920AB=m
CONFIG_SENSORS_INSPUR_IPSPS=m
CONFIG_SENSORS_IR35221=m
CONFIG_SENSORS_IR36021=m
CONFIG_SENSORS_IR38064=m
CONFIG_SENSORS_IRPS5401=m
CONFIG_SENSORS_ISL68137=m
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
CONFIG_SENSORS_LTC2978_REGULATOR=y
CONFIG_SENSORS_LTC3815=m
CONFIG_SENSORS_MAX15301=m
CONFIG_SENSORS_MAX16064=m
CONFIG_SENSORS_MAX16601=m
CONFIG_SENSORS_MAX20730=m
CONFIG_SENSORS_MAX20751=m
CONFIG_SENSORS_MAX31785=m
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
CONFIG_SENSORS_MP2888=m
CONFIG_SENSORS_MP2975=m
CONFIG_SENSORS_PIM4328=m
CONFIG_SENSORS_PM6764TR=m
CONFIG_SENSORS_PXE1610=m
CONFIG_SENSORS_Q54SJ108A2=m
CONFIG_SENSORS_STPDDC60=m
CONFIG_SENSORS_TPS40422=m
CONFIG_SENSORS_TPS53679=m
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
CONFIG_SENSORS_XDPE122=m
CONFIG_SENSORS_ZL6100=m
CONFIG_SENSORS_SBTSI=m
CONFIG_SENSORS_SBRMI=m
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
CONFIG_SENSORS_SHT3x=m
CONFIG_SENSORS_SHT4x=m
CONFIG_SENSORS_SHTC1=m
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
CONFIG_SENSORS_EMC2103=m
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
CONFIG_SENSORS_STTS751=m
CONFIG_SENSORS_SMM665=m
CONFIG_SENSORS_ADC128D818=m
CONFIG_SENSORS_ADS7828=m
CONFIG_SENSORS_ADS7871=m
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
CONFIG_SENSORS_INA3221=m
CONFIG_SENSORS_TC74=m
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
CONFIG_SENSORS_TMP103=m
CONFIG_SENSORS_TMP108=m
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
CONFIG_SENSORS_TMP513=m
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
CONFIG_SENSORS_W83773G=m
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
CONFIG_SENSORS_WM831X=m
CONFIG_SENSORS_WM8350=m
CONFIG_SENSORS_XGENE=m
CONFIG_SENSORS_INTEL_M10_BMC_HWMON=m

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
CONFIG_THERMAL=y
CONFIG_THERMAL_NETLINK=y
CONFIG_THERMAL_STATISTICS=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
CONFIG_DEVFREQ_THERMAL=y
CONFIG_THERMAL_EMULATION=y

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_X86_PKG_TEMP_THERMAL=m
CONFIG_INTEL_SOC_DTS_IOSF_CORE=m
CONFIG_INTEL_SOC_DTS_THERMAL=m

#
# ACPI INT340X thermal drivers
#
CONFIG_INT340X_THERMAL=m
CONFIG_ACPI_THERMAL_REL=m
CONFIG_INT3406_THERMAL=m
CONFIG_PROC_THERMAL_MMIO_RAPL=m
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_BXT_PMIC_THERMAL=m
CONFIG_INTEL_PCH_THERMAL=m
CONFIG_INTEL_TCC_COOLING=m
CONFIG_INTEL_MENLOW=m
# end of Intel thermal drivers

CONFIG_GENERIC_ADC_THERMAL=m
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y
# CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set

#
# Watchdog Pretimeout Governors
#
CONFIG_WATCHDOG_PRETIMEOUT_GOV=y
CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL=m
CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP=y
CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC=m
CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP=y
# CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_SOFT_WATCHDOG_PRETIMEOUT=y
CONFIG_DA9052_WATCHDOG=m
CONFIG_DA9055_WATCHDOG=m
CONFIG_DA9063_WATCHDOG=m
CONFIG_DA9062_WATCHDOG=m
CONFIG_MENF21BMC_WATCHDOG=m
CONFIG_MENZ069_WATCHDOG=m
CONFIG_WDAT_WDT=m
CONFIG_WM831X_WATCHDOG=m
CONFIG_WM8350_WATCHDOG=m
CONFIG_XILINX_WATCHDOG=m
CONFIG_ZIIRAVE_WATCHDOG=m
CONFIG_RAVE_SP_WATCHDOG=m
CONFIG_MLX_WDT=m
CONFIG_CADENCE_WATCHDOG=m
CONFIG_DW_WATCHDOG=m
CONFIG_TWL4030_WATCHDOG=m
CONFIG_MAX63XX_WATCHDOG=m
CONFIG_RETU_WATCHDOG=m
CONFIG_ACQUIRE_WDT=m
CONFIG_ADVANTECH_WDT=m
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
CONFIG_EBC_C384_WDT=m
CONFIG_F71808E_WDT=m
CONFIG_SP5100_TCO=m
CONFIG_SBC_FITPC2_WATCHDOG=m
CONFIG_EUROTECH_WDT=m
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
CONFIG_WAFER_WDT=m
CONFIG_I6300ESB_WDT=m
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=m
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
CONFIG_KEMPLD_WDT=m
CONFIG_SC1200_WDT=m
CONFIG_PC87413_WDT=m
CONFIG_NV_TCO=m
CONFIG_60XX_WDT=m
CONFIG_CPU5_WDT=m
CONFIG_SMSC_SCH311X_WDT=m
CONFIG_SMSC37B787_WDT=m
CONFIG_TQMX86_WDT=m
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
CONFIG_SBC_EPX_C3_WATCHDOG=m
CONFIG_INTEL_MEI_WDT=m
CONFIG_NI903X_WDT=m
CONFIG_NIC7018_WDT=m
CONFIG_MEN_A21_WDT=m
CONFIG_XEN_WDT=m

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
CONFIG_USBPCWATCHDOG=m
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=m
CONFIG_SSB_SPROM=y
CONFIG_SSB_BLOCKIO=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_B43_PCI_BRIDGE=y
CONFIG_SSB_PCMCIAHOST_POSSIBLE=y
# CONFIG_SSB_PCMCIAHOST is not set
CONFIG_SSB_SDIOHOST_POSSIBLE=y
CONFIG_SSB_SDIOHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
CONFIG_SSB_DRIVER_PCICORE=y
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_BLOCKIO=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
CONFIG_BCMA_HOST_SOC=y
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_SFLASH=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_AS3711=y
CONFIG_PMIC_ADP5520=y
CONFIG_MFD_AAT2870_CORE=y
CONFIG_MFD_BCM590XX=m
CONFIG_MFD_BD9571MWV=m
CONFIG_MFD_AXP20X=m
CONFIG_MFD_AXP20X_I2C=m
CONFIG_MFD_CROS_EC_DEV=m
CONFIG_MFD_MADERA=m
CONFIG_MFD_MADERA_I2C=m
CONFIG_MFD_MADERA_SPI=m
CONFIG_MFD_CS47L15=y
CONFIG_MFD_CS47L35=y
CONFIG_MFD_CS47L85=y
CONFIG_MFD_CS47L90=y
CONFIG_MFD_CS47L92=y
CONFIG_PMIC_DA903X=y
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_SPI=y
CONFIG_MFD_DA9052_I2C=y
CONFIG_MFD_DA9055=y
CONFIG_MFD_DA9062=m
CONFIG_MFD_DA9063=y
CONFIG_MFD_DA9150=m
CONFIG_MFD_DLN2=m
CONFIG_MFD_MC13XXX=m
CONFIG_MFD_MC13XXX_SPI=m
CONFIG_MFD_MC13XXX_I2C=m
CONFIG_MFD_MP2629=m
CONFIG_HTC_PASIC3=m
CONFIG_HTC_I2CPLD=y
CONFIG_MFD_INTEL_QUARK_I2C_GPIO=m
CONFIG_LPC_ICH=m
CONFIG_LPC_SCH=m
CONFIG_INTEL_SOC_PMIC=y
CONFIG_INTEL_SOC_PMIC_BXTWC=m
CONFIG_INTEL_SOC_PMIC_CHTWC=y
CONFIG_INTEL_SOC_PMIC_CHTDC_TI=m
CONFIG_INTEL_SOC_PMIC_MRFLD=m
CONFIG_MFD_INTEL_LPSS=m
CONFIG_MFD_INTEL_LPSS_ACPI=m
CONFIG_MFD_INTEL_LPSS_PCI=m
CONFIG_MFD_INTEL_PMC_BXT=m
CONFIG_MFD_INTEL_PMT=m
CONFIG_MFD_IQS62X=m
CONFIG_MFD_JANZ_CMODIO=m
CONFIG_MFD_KEMPLD=m
CONFIG_MFD_88PM800=m
CONFIG_MFD_88PM805=m
CONFIG_MFD_88PM860X=y
CONFIG_MFD_MAX14577=y
CONFIG_MFD_MAX77693=y
CONFIG_MFD_MAX77843=y
CONFIG_MFD_MAX8907=m
CONFIG_MFD_MAX8925=y
CONFIG_MFD_MAX8997=y
CONFIG_MFD_MAX8998=y
CONFIG_MFD_MT6360=m
CONFIG_MFD_MT6397=m
CONFIG_MFD_MENF21BMC=m
CONFIG_EZX_PCAP=y
CONFIG_MFD_VIPERBOARD=m
CONFIG_MFD_RETU=m
CONFIG_MFD_PCF50633=m
CONFIG_PCF50633_ADC=m
CONFIG_PCF50633_GPIO=m
CONFIG_UCB1400_CORE=m
CONFIG_MFD_RDC321X=m
CONFIG_MFD_RT4831=m
CONFIG_MFD_RT5033=m
CONFIG_MFD_RC5T583=y
CONFIG_MFD_SI476X_CORE=m
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
CONFIG_MFD_SKY81452=m
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=m
CONFIG_MFD_LP3943=m
CONFIG_MFD_LP8788=y
CONFIG_MFD_TI_LMU=m
CONFIG_MFD_PALMAS=y
CONFIG_TPS6105X=m
CONFIG_TPS65010=m
CONFIG_TPS6507X=m
CONFIG_MFD_TPS65086=m
CONFIG_MFD_TPS65090=y
CONFIG_MFD_TI_LP873X=m
CONFIG_MFD_TPS6586X=y
CONFIG_MFD_TPS65910=y
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
CONFIG_MFD_TPS65912_SPI=y
CONFIG_MFD_TPS80031=y
CONFIG_TWL4030_CORE=y
CONFIG_MFD_TWL4030_AUDIO=y
CONFIG_TWL6040_CORE=y
CONFIG_MFD_WL1273_CORE=m
CONFIG_MFD_LM3533=m
CONFIG_MFD_TQMX86=m
CONFIG_MFD_VX855=m
CONFIG_MFD_ARIZONA=m
CONFIG_MFD_ARIZONA_I2C=m
CONFIG_MFD_ARIZONA_SPI=m
CONFIG_MFD_CS47L24=y
CONFIG_MFD_WM5102=y
CONFIG_MFD_WM5110=y
CONFIG_MFD_WM8997=y
CONFIG_MFD_WM8998=y
CONFIG_MFD_WM8400=y
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
CONFIG_MFD_WM831X_SPI=y
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
CONFIG_MFD_WM8994=m
CONFIG_MFD_WCD934X=m
CONFIG_MFD_ATC260X=m
CONFIG_MFD_ATC260X_I2C=m
CONFIG_RAVE_SP_CORE=m
CONFIG_MFD_INTEL_M10_BMC=m
# end of Multifunction device drivers

CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=m
CONFIG_REGULATOR_VIRTUAL_CONSUMER=m
CONFIG_REGULATOR_USERSPACE_CONSUMER=m
CONFIG_REGULATOR_88PG86X=m
CONFIG_REGULATOR_88PM800=m
CONFIG_REGULATOR_88PM8607=m
CONFIG_REGULATOR_ACT8865=m
CONFIG_REGULATOR_AD5398=m
CONFIG_REGULATOR_AAT2870=m
CONFIG_REGULATOR_ARIZONA_LDO1=m
CONFIG_REGULATOR_ARIZONA_MICSUPP=m
CONFIG_REGULATOR_AS3711=m
CONFIG_REGULATOR_ATC260X=m
CONFIG_REGULATOR_AXP20X=m
CONFIG_REGULATOR_BCM590XX=m
CONFIG_REGULATOR_BD9571MWV=m
CONFIG_REGULATOR_DA903X=m
CONFIG_REGULATOR_DA9052=m
CONFIG_REGULATOR_DA9055=m
CONFIG_REGULATOR_DA9062=m
CONFIG_REGULATOR_DA9210=m
CONFIG_REGULATOR_DA9211=m
CONFIG_REGULATOR_FAN53555=m
CONFIG_REGULATOR_GPIO=m
CONFIG_REGULATOR_ISL9305=m
CONFIG_REGULATOR_ISL6271A=m
CONFIG_REGULATOR_LM363X=m
CONFIG_REGULATOR_LP3971=m
CONFIG_REGULATOR_LP3972=m
CONFIG_REGULATOR_LP872X=m
CONFIG_REGULATOR_LP8755=m
CONFIG_REGULATOR_LP8788=m
CONFIG_REGULATOR_LTC3589=m
CONFIG_REGULATOR_LTC3676=m
CONFIG_REGULATOR_MAX14577=m
CONFIG_REGULATOR_MAX1586=m
CONFIG_REGULATOR_MAX8649=m
CONFIG_REGULATOR_MAX8660=m
CONFIG_REGULATOR_MAX8893=m
CONFIG_REGULATOR_MAX8907=m
CONFIG_REGULATOR_MAX8925=m
CONFIG_REGULATOR_MAX8952=m
CONFIG_REGULATOR_MAX8997=m
CONFIG_REGULATOR_MAX8998=m
CONFIG_REGULATOR_MAX77693=m
CONFIG_REGULATOR_MAX77826=m
CONFIG_REGULATOR_MC13XXX_CORE=m
CONFIG_REGULATOR_MC13783=m
CONFIG_REGULATOR_MC13892=m
CONFIG_REGULATOR_MP8859=m
CONFIG_REGULATOR_MT6311=m
CONFIG_REGULATOR_MT6315=m
CONFIG_REGULATOR_MT6323=m
CONFIG_REGULATOR_MT6358=m
CONFIG_REGULATOR_MT6359=m
CONFIG_REGULATOR_MT6360=m
CONFIG_REGULATOR_MT6397=m
CONFIG_REGULATOR_PALMAS=m
CONFIG_REGULATOR_PCA9450=m
CONFIG_REGULATOR_PCAP=m
CONFIG_REGULATOR_PCF50633=m
CONFIG_REGULATOR_PV88060=m
CONFIG_REGULATOR_PV88080=m
CONFIG_REGULATOR_PV88090=m
CONFIG_REGULATOR_PWM=m
CONFIG_REGULATOR_QCOM_SPMI=m
CONFIG_REGULATOR_QCOM_USB_VBUS=m
CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY=m
CONFIG_REGULATOR_RC5T583=m
CONFIG_REGULATOR_RT4801=m
CONFIG_REGULATOR_RT4831=m
CONFIG_REGULATOR_RT5033=m
CONFIG_REGULATOR_RT6160=m
CONFIG_REGULATOR_RT6245=m
CONFIG_REGULATOR_RTQ2134=m
CONFIG_REGULATOR_RTMV20=m
CONFIG_REGULATOR_RTQ6752=m
CONFIG_REGULATOR_SKY81452=m
CONFIG_REGULATOR_SLG51000=m
CONFIG_REGULATOR_TPS51632=m
CONFIG_REGULATOR_TPS6105X=m
CONFIG_REGULATOR_TPS62360=m
CONFIG_REGULATOR_TPS65023=m
CONFIG_REGULATOR_TPS6507X=m
CONFIG_REGULATOR_TPS65086=m
CONFIG_REGULATOR_TPS65090=m
CONFIG_REGULATOR_TPS65132=m
CONFIG_REGULATOR_TPS6524X=m
CONFIG_REGULATOR_TPS6586X=m
CONFIG_REGULATOR_TPS65910=m
CONFIG_REGULATOR_TPS65912=m
CONFIG_REGULATOR_TPS80031=m
CONFIG_REGULATOR_TWL4030=m
CONFIG_REGULATOR_WM831X=m
CONFIG_REGULATOR_WM8350=m
CONFIG_REGULATOR_WM8400=m
CONFIG_REGULATOR_WM8994=m
CONFIG_REGULATOR_QCOM_LABIBB=m
CONFIG_RC_CORE=m
CONFIG_RC_MAP=m
CONFIG_LIRC=y
CONFIG_RC_DECODERS=y
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_SONY_DECODER=m
CONFIG_IR_SANYO_DECODER=m
CONFIG_IR_SHARP_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
CONFIG_IR_XMP_DECODER=m
CONFIG_IR_IMON_DECODER=m
CONFIG_IR_RCMM_DECODER=m
CONFIG_RC_DEVICES=y
CONFIG_RC_ATI_REMOTE=m
CONFIG_IR_ENE=m
CONFIG_IR_IMON=m
CONFIG_IR_IMON_RAW=m
CONFIG_IR_MCEUSB=m
CONFIG_IR_ITE_CIR=m
CONFIG_IR_FINTEK=m
CONFIG_IR_NUVOTON=m
CONFIG_IR_REDRAT3=m
CONFIG_IR_STREAMZAP=m
CONFIG_IR_WINBOND_CIR=m
CONFIG_IR_IGORPLUGUSB=m
CONFIG_IR_IGUANA=m
CONFIG_IR_TTUSBIR=m
CONFIG_RC_LOOPBACK=m
CONFIG_IR_SERIAL=m
CONFIG_IR_SERIAL_TRANSMITTER=y
CONFIG_IR_SIR=m
CONFIG_RC_XBOX_DVD=m
CONFIG_IR_TOY=m
CONFIG_CEC_CORE=m
CONFIG_CEC_NOTIFIER=y
CONFIG_MEDIA_CEC_RC=y
CONFIG_MEDIA_CEC_SUPPORT=y
CONFIG_CEC_CH7322=m
CONFIG_CEC_CROS_EC=m
CONFIG_CEC_SECO=m
CONFIG_CEC_SECO_RC=y
CONFIG_USB_PULSE8_CEC=m
CONFIG_USB_RAINSHADOW_CEC=m
CONFIG_MEDIA_SUPPORT=m
CONFIG_MEDIA_SUPPORT_FILTER=y
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y

#
# Media device types
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_PLATFORM_SUPPORT=y
CONFIG_MEDIA_TEST_SUPPORT=y
# end of Media device types

CONFIG_VIDEO_DEV=m
CONFIG_MEDIA_CONTROLLER=y
CONFIG_DVB_CORE=m

#
# Video4Linux options
#
CONFIG_VIDEO_V4L2=m
CONFIG_VIDEO_V4L2_I2C=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_VIDEO_TUNER=m
CONFIG_V4L2_MEM2MEM_DEV=m
CONFIG_V4L2_FLASH_LED_CLASS=m
CONFIG_V4L2_FWNODE=m
CONFIG_V4L2_ASYNC=m
CONFIG_VIDEOBUF_GEN=m
CONFIG_VIDEOBUF_DMA_SG=m
CONFIG_VIDEOBUF_VMALLOC=m
# end of Video4Linux options

#
# Media controller options
#
CONFIG_MEDIA_CONTROLLER_DVB=y
CONFIG_MEDIA_CONTROLLER_REQUEST_API=y

#
# Please notice that the enabled Media controller Request API is EXPERIMENTAL
#
# end of Media controller options

#
# Digital TV options
#
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_DVB_MAX_ADAPTERS=8
CONFIG_DVB_DYNAMIC_MINORS=y
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set
# end of Digital TV options

#
# Media drivers
#

#
# Drivers filtered as selected at 'Filter media drivers'
#
CONFIG_MEDIA_USB_SUPPORT=y

#
# Webcam devices
#
CONFIG_USB_VIDEO_CLASS=m
CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV=y
CONFIG_USB_GSPCA=m
CONFIG_USB_M5602=m
CONFIG_USB_STV06XX=m
CONFIG_USB_GL860=m
CONFIG_USB_GSPCA_BENQ=m
CONFIG_USB_GSPCA_CONEX=m
CONFIG_USB_GSPCA_CPIA1=m
CONFIG_USB_GSPCA_DTCS033=m
CONFIG_USB_GSPCA_ETOMS=m
CONFIG_USB_GSPCA_FINEPIX=m
CONFIG_USB_GSPCA_JEILINJ=m
CONFIG_USB_GSPCA_JL2005BCD=m
CONFIG_USB_GSPCA_KINECT=m
CONFIG_USB_GSPCA_KONICA=m
CONFIG_USB_GSPCA_MARS=m
CONFIG_USB_GSPCA_MR97310A=m
CONFIG_USB_GSPCA_NW80X=m
CONFIG_USB_GSPCA_OV519=m
CONFIG_USB_GSPCA_OV534=m
CONFIG_USB_GSPCA_OV534_9=m
CONFIG_USB_GSPCA_PAC207=m
CONFIG_USB_GSPCA_PAC7302=m
CONFIG_USB_GSPCA_PAC7311=m
CONFIG_USB_GSPCA_SE401=m
CONFIG_USB_GSPCA_SN9C2028=m
CONFIG_USB_GSPCA_SN9C20X=m
CONFIG_USB_GSPCA_SONIXB=m
CONFIG_USB_GSPCA_SONIXJ=m
CONFIG_USB_GSPCA_SPCA500=m
CONFIG_USB_GSPCA_SPCA501=m
CONFIG_USB_GSPCA_SPCA505=m
CONFIG_USB_GSPCA_SPCA506=m
CONFIG_USB_GSPCA_SPCA508=m
CONFIG_USB_GSPCA_SPCA561=m
CONFIG_USB_GSPCA_SPCA1528=m
CONFIG_USB_GSPCA_SQ905=m
CONFIG_USB_GSPCA_SQ905C=m
CONFIG_USB_GSPCA_SQ930X=m
CONFIG_USB_GSPCA_STK014=m
CONFIG_USB_GSPCA_STK1135=m
CONFIG_USB_GSPCA_STV0680=m
CONFIG_USB_GSPCA_SUNPLUS=m
CONFIG_USB_GSPCA_T613=m
CONFIG_USB_GSPCA_TOPRO=m
CONFIG_USB_GSPCA_TOUPTEK=m
CONFIG_USB_GSPCA_TV8532=m
CONFIG_USB_GSPCA_VC032X=m
CONFIG_USB_GSPCA_VICAM=m
CONFIG_USB_GSPCA_XIRLINK_CIT=m
CONFIG_USB_GSPCA_ZC3XX=m
CONFIG_USB_PWC=m
# CONFIG_USB_PWC_DEBUG is not set
CONFIG_USB_PWC_INPUT_EVDEV=y
CONFIG_VIDEO_CPIA2=m
CONFIG_USB_ZR364XX=m
CONFIG_USB_STKWEBCAM=m
CONFIG_USB_S2255=m
CONFIG_VIDEO_USBTV=m

#
# Analog TV USB devices
#
CONFIG_VIDEO_PVRUSB2=m
CONFIG_VIDEO_PVRUSB2_SYSFS=y
CONFIG_VIDEO_PVRUSB2_DVB=y
# CONFIG_VIDEO_PVRUSB2_DEBUGIFC is not set
CONFIG_VIDEO_HDPVR=m
CONFIG_VIDEO_STK1160_COMMON=m
CONFIG_VIDEO_STK1160=m
CONFIG_VIDEO_GO7007=m
CONFIG_VIDEO_GO7007_USB=m
CONFIG_VIDEO_GO7007_LOADER=m
CONFIG_VIDEO_GO7007_USB_S2250_BOARD=m

#
# Analog/digital TV USB devices
#
CONFIG_VIDEO_AU0828=m
CONFIG_VIDEO_AU0828_V4L2=y
CONFIG_VIDEO_AU0828_RC=y
CONFIG_VIDEO_CX231XX=m
CONFIG_VIDEO_CX231XX_RC=y
CONFIG_VIDEO_CX231XX_ALSA=m
CONFIG_VIDEO_CX231XX_DVB=m
CONFIG_VIDEO_TM6000=m
CONFIG_VIDEO_TM6000_ALSA=m
CONFIG_VIDEO_TM6000_DVB=m

#
# Digital TV USB devices
#
CONFIG_DVB_USB=m
# CONFIG_DVB_USB_DEBUG is not set
CONFIG_DVB_USB_DIB3000MC=m
CONFIG_DVB_USB_A800=m
CONFIG_DVB_USB_DIBUSB_MB=m
# CONFIG_DVB_USB_DIBUSB_MB_FAULTY is not set
CONFIG_DVB_USB_DIBUSB_MC=m
CONFIG_DVB_USB_DIB0700=m
CONFIG_DVB_USB_UMT_010=m
CONFIG_DVB_USB_CXUSB=m
CONFIG_DVB_USB_CXUSB_ANALOG=y
CONFIG_DVB_USB_M920X=m
CONFIG_DVB_USB_DIGITV=m
CONFIG_DVB_USB_VP7045=m
CONFIG_DVB_USB_VP702X=m
CONFIG_DVB_USB_GP8PSK=m
CONFIG_DVB_USB_NOVA_T_USB2=m
CONFIG_DVB_USB_TTUSB2=m
CONFIG_DVB_USB_DTT200U=m
CONFIG_DVB_USB_OPERA1=m
CONFIG_DVB_USB_AF9005=m
CONFIG_DVB_USB_AF9005_REMOTE=m
CONFIG_DVB_USB_PCTV452E=m
CONFIG_DVB_USB_DW2102=m
CONFIG_DVB_USB_CINERGY_T2=m
CONFIG_DVB_USB_DTV5100=m
CONFIG_DVB_USB_AZ6027=m
CONFIG_DVB_USB_TECHNISAT_USB2=m
CONFIG_DVB_USB_V2=m
CONFIG_DVB_USB_AF9015=m
CONFIG_DVB_USB_AF9035=m
CONFIG_DVB_USB_ANYSEE=m
CONFIG_DVB_USB_AU6610=m
CONFIG_DVB_USB_AZ6007=m
CONFIG_DVB_USB_CE6230=m
CONFIG_DVB_USB_EC168=m
CONFIG_DVB_USB_GL861=m
CONFIG_DVB_USB_LME2510=m
CONFIG_DVB_USB_MXL111SF=m
CONFIG_DVB_USB_RTL28XXU=m
CONFIG_DVB_USB_DVBSKY=m
CONFIG_DVB_USB_ZD1301=m
CONFIG_DVB_TTUSB_BUDGET=m
CONFIG_DVB_TTUSB_DEC=m
CONFIG_SMS_USB_DRV=m
CONFIG_DVB_B2C2_FLEXCOP_USB=m
# CONFIG_DVB_B2C2_FLEXCOP_USB_DEBUG is not set
CONFIG_DVB_AS102=m

#
# Webcam, TV (analog/digital) USB devices
#
CONFIG_VIDEO_EM28XX=m
CONFIG_VIDEO_EM28XX_V4L2=m
CONFIG_VIDEO_EM28XX_ALSA=m
CONFIG_VIDEO_EM28XX_DVB=m
CONFIG_VIDEO_EM28XX_RC=m

#
# Software defined radio USB devices
#
CONFIG_USB_AIRSPY=m
CONFIG_USB_HACKRF=m
CONFIG_USB_MSI2500=m
CONFIG_MEDIA_PCI_SUPPORT=y

#
# Media capture support
#
CONFIG_VIDEO_MEYE=m
CONFIG_VIDEO_SOLO6X10=m
CONFIG_VIDEO_TW5864=m
CONFIG_VIDEO_TW68=m
CONFIG_VIDEO_TW686X=m

#
# Media capture/analog TV support
#
CONFIG_VIDEO_IVTV=m
CONFIG_VIDEO_IVTV_ALSA=m
CONFIG_VIDEO_FB_IVTV=m
CONFIG_VIDEO_FB_IVTV_FORCE_PAT=y
CONFIG_VIDEO_HEXIUM_GEMINI=m
CONFIG_VIDEO_HEXIUM_ORION=m
CONFIG_VIDEO_MXB=m
CONFIG_VIDEO_DT3155=m

#
# Media capture/analog/hybrid TV support
#
CONFIG_VIDEO_CX18=m
CONFIG_VIDEO_CX18_ALSA=m
CONFIG_VIDEO_CX23885=m
CONFIG_MEDIA_ALTERA_CI=m
CONFIG_VIDEO_CX25821=m
CONFIG_VIDEO_CX25821_ALSA=m
CONFIG_VIDEO_CX88=m
CONFIG_VIDEO_CX88_ALSA=m
CONFIG_VIDEO_CX88_BLACKBIRD=m
CONFIG_VIDEO_CX88_DVB=m
CONFIG_VIDEO_CX88_ENABLE_VP3054=y
CONFIG_VIDEO_CX88_VP3054=m
CONFIG_VIDEO_CX88_MPEG=m
CONFIG_VIDEO_BT848=m
CONFIG_DVB_BT8XX=m
CONFIG_VIDEO_SAA7134=m
CONFIG_VIDEO_SAA7134_ALSA=m
CONFIG_VIDEO_SAA7134_RC=y
CONFIG_VIDEO_SAA7134_DVB=m
CONFIG_VIDEO_SAA7134_GO7007=m
CONFIG_VIDEO_SAA7164=m
CONFIG_VIDEO_COBALT=m

#
# Media digital TV PCI Adapters
#
CONFIG_DVB_BUDGET_CORE=m
CONFIG_DVB_BUDGET=m
CONFIG_DVB_BUDGET_CI=m
CONFIG_DVB_BUDGET_AV=m
CONFIG_DVB_B2C2_FLEXCOP_PCI=m
# CONFIG_DVB_B2C2_FLEXCOP_PCI_DEBUG is not set
CONFIG_DVB_PLUTO2=m
CONFIG_DVB_DM1105=m
CONFIG_DVB_PT1=m
CONFIG_DVB_PT3=m
CONFIG_MANTIS_CORE=m
CONFIG_DVB_MANTIS=m
CONFIG_DVB_HOPPER=m
CONFIG_DVB_NGENE=m
CONFIG_DVB_DDBRIDGE=m
# CONFIG_DVB_DDBRIDGE_MSIENABLE is not set
CONFIG_DVB_SMIPCIE=m
CONFIG_DVB_NETUP_UNIDVB=m
CONFIG_VIDEO_IPU3_CIO2=m
CONFIG_CIO2_BRIDGE=y
# CONFIG_VIDEO_PCI_SKELETON is not set
CONFIG_RADIO_ADAPTERS=y
CONFIG_RADIO_TEA575X=m
CONFIG_RADIO_SI470X=m
CONFIG_USB_SI470X=m
CONFIG_I2C_SI470X=m
CONFIG_RADIO_SI4713=m
CONFIG_USB_SI4713=m
CONFIG_PLATFORM_SI4713=m
CONFIG_I2C_SI4713=m
CONFIG_RADIO_SI476X=m
CONFIG_USB_MR800=m
CONFIG_USB_DSBR=m
CONFIG_RADIO_MAXIRADIO=m
CONFIG_RADIO_SHARK=m
CONFIG_RADIO_SHARK2=m
CONFIG_USB_KEENE=m
CONFIG_USB_RAREMONO=m
CONFIG_USB_MA901=m
CONFIG_RADIO_TEA5764=m
CONFIG_RADIO_SAA7706H=m
CONFIG_RADIO_TEF6862=m
CONFIG_RADIO_WL1273=m
CONFIG_RADIO_WL128X=m
CONFIG_MEDIA_COMMON_OPTIONS=y

#
# common driver options
#
CONFIG_VIDEO_CX2341X=m
CONFIG_VIDEO_TVEEPROM=m
CONFIG_TTPCI_EEPROM=m
CONFIG_CYPRESS_FIRMWARE=m
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_DMA_CONTIG=m
CONFIG_VIDEOBUF2_VMALLOC=m
CONFIG_VIDEOBUF2_DMA_SG=m
CONFIG_VIDEOBUF2_DVB=m
CONFIG_DVB_B2C2_FLEXCOP=m
CONFIG_VIDEO_SAA7146=m
CONFIG_VIDEO_SAA7146_VV=m
CONFIG_SMS_SIANO_MDTV=m
CONFIG_SMS_SIANO_RC=y
CONFIG_SMS_SIANO_DEBUGFS=y
CONFIG_VIDEO_V4L2_TPG=m
CONFIG_V4L_PLATFORM_DRIVERS=y
CONFIG_VIDEO_CAFE_CCIC=m
CONFIG_VIDEO_VIA_CAMERA=m
CONFIG_VIDEO_CADENCE=y
CONFIG_VIDEO_CADENCE_CSI2RX=m
CONFIG_VIDEO_CADENCE_CSI2TX=m
CONFIG_VIDEO_ASPEED=m
CONFIG_V4L_MEM2MEM_DRIVERS=y
CONFIG_VIDEO_MEM2MEM_DEINTERLACE=m
CONFIG_DVB_PLATFORM_DRIVERS=y
CONFIG_SDR_PLATFORM_DRIVERS=y

#
# MMC/SDIO DVB adapters
#
CONFIG_SMS_SDIO_DRV=m
CONFIG_V4L_TEST_DRIVERS=y
CONFIG_VIDEO_VIMC=m
CONFIG_VIDEO_VIVID=m
CONFIG_VIDEO_VIVID_CEC=y
CONFIG_VIDEO_VIVID_MAX_DEVS=64
CONFIG_VIDEO_VIM2M=m
CONFIG_VIDEO_VICODEC=m
# CONFIG_DVB_TEST_DRIVERS is not set

#
# FireWire (IEEE 1394) Adapters
#
CONFIG_DVB_FIREDTV=m
CONFIG_DVB_FIREDTV_INPUT=y
# end of Media drivers

#
# Media ancillary drivers
#
CONFIG_MEDIA_ATTACH=y

#
# IR I2C driver auto-selected by 'Autoselect ancillary drivers'
#
CONFIG_VIDEO_IR_I2C=m

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_TVAUDIO=m
CONFIG_VIDEO_TDA7432=m
CONFIG_VIDEO_TDA9840=m
CONFIG_VIDEO_TDA1997X=m
CONFIG_VIDEO_TEA6415C=m
CONFIG_VIDEO_TEA6420=m
CONFIG_VIDEO_MSP3400=m
CONFIG_VIDEO_CS3308=m
CONFIG_VIDEO_CS5345=m
CONFIG_VIDEO_CS53L32A=m
CONFIG_VIDEO_TLV320AIC23B=m
CONFIG_VIDEO_UDA1342=m
CONFIG_VIDEO_WM8775=m
CONFIG_VIDEO_WM8739=m
CONFIG_VIDEO_VP27SMPX=m
CONFIG_VIDEO_SONY_BTF_MPX=m
# end of Audio decoders, processors and mixers

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=m
# end of RDS decoders

#
# Video decoders
#
CONFIG_VIDEO_ADV7180=m
CONFIG_VIDEO_ADV7183=m
CONFIG_VIDEO_ADV7604=m
CONFIG_VIDEO_ADV7604_CEC=y
CONFIG_VIDEO_ADV7842=m
CONFIG_VIDEO_ADV7842_CEC=y
CONFIG_VIDEO_BT819=m
CONFIG_VIDEO_BT856=m
CONFIG_VIDEO_BT866=m
CONFIG_VIDEO_KS0127=m
CONFIG_VIDEO_ML86V7667=m
CONFIG_VIDEO_SAA7110=m
CONFIG_VIDEO_SAA711X=m
CONFIG_VIDEO_TC358743=m
CONFIG_VIDEO_TC358743_CEC=y
CONFIG_VIDEO_TVP514X=m
CONFIG_VIDEO_TVP5150=m
CONFIG_VIDEO_TVP7002=m
CONFIG_VIDEO_TW2804=m
CONFIG_VIDEO_TW9903=m
CONFIG_VIDEO_TW9906=m
CONFIG_VIDEO_TW9910=m
CONFIG_VIDEO_VPX3220=m

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=m
CONFIG_VIDEO_CX25840=m
# end of Video decoders

#
# Video encoders
#
CONFIG_VIDEO_SAA7127=m
CONFIG_VIDEO_SAA7185=m
CONFIG_VIDEO_ADV7170=m
CONFIG_VIDEO_ADV7175=m
CONFIG_VIDEO_ADV7343=m
CONFIG_VIDEO_ADV7393=m
CONFIG_VIDEO_ADV7511=m
CONFIG_VIDEO_ADV7511_CEC=y
CONFIG_VIDEO_AD9389B=m
CONFIG_VIDEO_AK881X=m
CONFIG_VIDEO_THS8200=m
# end of Video encoders

#
# Video improvement chips
#
CONFIG_VIDEO_UPD64031A=m
CONFIG_VIDEO_UPD64083=m
# end of Video improvement chips

#
# Audio/Video compression chips
#
CONFIG_VIDEO_SAA6752HS=m
# end of Audio/Video compression chips

#
# SDR tuner chips
#
CONFIG_SDR_MAX2175=m
# end of SDR tuner chips

#
# Miscellaneous helper chips
#
CONFIG_VIDEO_THS7303=m
CONFIG_VIDEO_M52790=m
CONFIG_VIDEO_I2C=m
CONFIG_VIDEO_ST_MIPID02=m
# end of Miscellaneous helper chips

#
# Camera sensor devices
#
CONFIG_VIDEO_APTINA_PLL=m
CONFIG_VIDEO_CCS_PLL=m
CONFIG_VIDEO_HI556=m
CONFIG_VIDEO_IMX208=m
CONFIG_VIDEO_IMX214=m
CONFIG_VIDEO_IMX219=m
CONFIG_VIDEO_IMX258=m
CONFIG_VIDEO_IMX274=m
CONFIG_VIDEO_IMX290=m
CONFIG_VIDEO_IMX319=m
CONFIG_VIDEO_IMX355=m
CONFIG_VIDEO_OV02A10=m
CONFIG_VIDEO_OV2640=m
CONFIG_VIDEO_OV2659=m
CONFIG_VIDEO_OV2680=m
CONFIG_VIDEO_OV2685=m
CONFIG_VIDEO_OV2740=m
CONFIG_VIDEO_OV5647=m
CONFIG_VIDEO_OV5648=m
CONFIG_VIDEO_OV6650=m
CONFIG_VIDEO_OV5670=m
CONFIG_VIDEO_OV5675=m
CONFIG_VIDEO_OV5695=m
CONFIG_VIDEO_OV7251=m
CONFIG_VIDEO_OV772X=m
CONFIG_VIDEO_OV7640=m
CONFIG_VIDEO_OV7670=m
CONFIG_VIDEO_OV7740=m
CONFIG_VIDEO_OV8856=m
CONFIG_VIDEO_OV8865=m
CONFIG_VIDEO_OV9640=m
CONFIG_VIDEO_OV9650=m
CONFIG_VIDEO_OV9734=m
CONFIG_VIDEO_OV13858=m
CONFIG_VIDEO_VS6624=m
CONFIG_VIDEO_MT9M001=m
CONFIG_VIDEO_MT9M032=m
CONFIG_VIDEO_MT9M111=m
CONFIG_VIDEO_MT9P031=m
CONFIG_VIDEO_MT9T001=m
CONFIG_VIDEO_MT9T112=m
CONFIG_VIDEO_MT9V011=m
CONFIG_VIDEO_MT9V032=m
CONFIG_VIDEO_MT9V111=m
CONFIG_VIDEO_SR030PC30=m
CONFIG_VIDEO_NOON010PC30=m
CONFIG_VIDEO_M5MOLS=m
CONFIG_VIDEO_MAX9271_LIB=m
CONFIG_VIDEO_RDACM20=m
CONFIG_VIDEO_RDACM21=m
CONFIG_VIDEO_RJ54N1=m
CONFIG_VIDEO_S5K6AA=m
CONFIG_VIDEO_S5K6A3=m
CONFIG_VIDEO_S5K4ECGX=m
CONFIG_VIDEO_S5K5BAF=m
CONFIG_VIDEO_CCS=m
CONFIG_VIDEO_ET8EK8=m
CONFIG_VIDEO_S5C73M3=m
# end of Camera sensor devices

#
# Lens drivers
#
CONFIG_VIDEO_AD5820=m
CONFIG_VIDEO_AK7375=m
CONFIG_VIDEO_DW9714=m
CONFIG_VIDEO_DW9768=m
CONFIG_VIDEO_DW9807_VCM=m
# end of Lens drivers

#
# Flash devices
#
CONFIG_VIDEO_ADP1653=m
CONFIG_VIDEO_LM3560=m
CONFIG_VIDEO_LM3646=m
# end of Flash devices

#
# SPI helper chips
#
CONFIG_VIDEO_GS1662=m
# end of SPI helper chips

#
# Media SPI Adapters
#
CONFIG_CXD2880_SPI_DRV=m
# end of Media SPI Adapters

CONFIG_MEDIA_TUNER=m

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA18250=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
CONFIG_MEDIA_TUNER_MSI001=m
CONFIG_MEDIA_TUNER_MT20XX=m
CONFIG_MEDIA_TUNER_MT2060=m
CONFIG_MEDIA_TUNER_MT2063=m
CONFIG_MEDIA_TUNER_MT2266=m
CONFIG_MEDIA_TUNER_MT2131=m
CONFIG_MEDIA_TUNER_QT1010=m
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC5000=m
CONFIG_MEDIA_TUNER_XC4000=m
CONFIG_MEDIA_TUNER_MXL5005S=m
CONFIG_MEDIA_TUNER_MXL5007T=m
CONFIG_MEDIA_TUNER_MC44S803=m
CONFIG_MEDIA_TUNER_MAX2165=m
CONFIG_MEDIA_TUNER_TDA18218=m
CONFIG_MEDIA_TUNER_FC0011=m
CONFIG_MEDIA_TUNER_FC0012=m
CONFIG_MEDIA_TUNER_FC0013=m
CONFIG_MEDIA_TUNER_TDA18212=m
CONFIG_MEDIA_TUNER_E4000=m
CONFIG_MEDIA_TUNER_FC2580=m
CONFIG_MEDIA_TUNER_M88RS6000T=m
CONFIG_MEDIA_TUNER_TUA9001=m
CONFIG_MEDIA_TUNER_SI2157=m
CONFIG_MEDIA_TUNER_IT913X=m
CONFIG_MEDIA_TUNER_R820T=m
CONFIG_MEDIA_TUNER_MXL301RF=m
CONFIG_MEDIA_TUNER_QM1D1C0042=m
CONFIG_MEDIA_TUNER_QM1D1B0004=m
# end of Customize TV tuners

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_STB0899=m
CONFIG_DVB_STB6100=m
CONFIG_DVB_STV090x=m
CONFIG_DVB_STV0910=m
CONFIG_DVB_STV6110x=m
CONFIG_DVB_STV6111=m
CONFIG_DVB_MXL5XX=m
CONFIG_DVB_M88DS3103=m

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=m
CONFIG_DVB_TDA18271C2DD=m
CONFIG_DVB_SI2165=m
CONFIG_DVB_MN88472=m
CONFIG_DVB_MN88473=m

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=m
CONFIG_DVB_CX24123=m
CONFIG_DVB_MT312=m
CONFIG_DVB_ZL10036=m
CONFIG_DVB_ZL10039=m
CONFIG_DVB_S5H1420=m
CONFIG_DVB_STV0288=m
CONFIG_DVB_STB6000=m
CONFIG_DVB_STV0299=m
CONFIG_DVB_STV6110=m
CONFIG_DVB_STV0900=m
CONFIG_DVB_TDA8083=m
CONFIG_DVB_TDA10086=m
CONFIG_DVB_TDA8261=m
CONFIG_DVB_VES1X93=m
CONFIG_DVB_TUNER_ITD1000=m
CONFIG_DVB_TUNER_CX24113=m
CONFIG_DVB_TDA826X=m
CONFIG_DVB_TUA6100=m
CONFIG_DVB_CX24116=m
CONFIG_DVB_CX24117=m
CONFIG_DVB_CX24120=m
CONFIG_DVB_SI21XX=m
CONFIG_DVB_TS2020=m
CONFIG_DVB_DS3000=m
CONFIG_DVB_MB86A16=m
CONFIG_DVB_TDA10071=m

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_SP887X=m
CONFIG_DVB_CX22700=m
CONFIG_DVB_CX22702=m
CONFIG_DVB_S5H1432=m
CONFIG_DVB_DRXD=m
CONFIG_DVB_L64781=m
CONFIG_DVB_TDA1004X=m
CONFIG_DVB_NXT6000=m
CONFIG_DVB_MT352=m
CONFIG_DVB_ZL10353=m
CONFIG_DVB_DIB3000MB=m
CONFIG_DVB_DIB3000MC=m
CONFIG_DVB_DIB7000M=m
CONFIG_DVB_DIB7000P=m
CONFIG_DVB_DIB9000=m
CONFIG_DVB_TDA10048=m
CONFIG_DVB_AF9013=m
CONFIG_DVB_EC100=m
CONFIG_DVB_STV0367=m
CONFIG_DVB_CXD2820R=m
CONFIG_DVB_CXD2841ER=m
CONFIG_DVB_RTL2830=m
CONFIG_DVB_RTL2832=m
CONFIG_DVB_RTL2832_SDR=m
CONFIG_DVB_SI2168=m
CONFIG_DVB_AS102_FE=m
CONFIG_DVB_ZD1301_DEMOD=m
CONFIG_DVB_GP8PSK_FE=m
CONFIG_DVB_CXD2880=m

#
# DVB-C (cable) frontends
#
CONFIG_DVB_VES1820=m
CONFIG_DVB_TDA10021=m
CONFIG_DVB_TDA10023=m
CONFIG_DVB_STV0297=m

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_NXT200X=m
CONFIG_DVB_OR51211=m
CONFIG_DVB_OR51132=m
CONFIG_DVB_BCM3510=m
CONFIG_DVB_LGDT330X=m
CONFIG_DVB_LGDT3305=m
CONFIG_DVB_LGDT3306A=m
CONFIG_DVB_LG2160=m
CONFIG_DVB_S5H1409=m
CONFIG_DVB_AU8522=m
CONFIG_DVB_AU8522_DTV=m
CONFIG_DVB_AU8522_V4L=m
CONFIG_DVB_S5H1411=m
CONFIG_DVB_MXL692=m

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_S921=m
CONFIG_DVB_DIB8000=m
CONFIG_DVB_MB86A20S=m

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_TC90522=m
CONFIG_DVB_MN88443X=m

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=m
CONFIG_DVB_TUNER_DIB0070=m
CONFIG_DVB_TUNER_DIB0090=m

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=m
CONFIG_DVB_LNBH25=m
CONFIG_DVB_LNBH29=m
CONFIG_DVB_LNBP21=m
CONFIG_DVB_LNBP22=m
CONFIG_DVB_ISL6405=m
CONFIG_DVB_ISL6421=m
CONFIG_DVB_ISL6423=m
CONFIG_DVB_A8293=m
CONFIG_DVB_LGS8GL5=m
CONFIG_DVB_LGS8GXX=m
CONFIG_DVB_ATBM8830=m
CONFIG_DVB_TDA665x=m
CONFIG_DVB_IX2505V=m
CONFIG_DVB_M88RS2000=m
CONFIG_DVB_AF9033=m
CONFIG_DVB_HORUS3A=m
CONFIG_DVB_ASCOT2E=m
CONFIG_DVB_HELENE=m

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=m
CONFIG_DVB_SP2=m
# end of Customise DVB Frontends

#
# Tools to develop new frontends
#
CONFIG_DVB_DUMMY_FE=m
# end of Media ancillary drivers

#
# Graphics support
#
CONFIG_AGP=y
CONFIG_AGP_AMD64=y
CONFIG_AGP_INTEL=y
CONFIG_AGP_SIS=m
CONFIG_AGP_VIA=y
CONFIG_INTEL_GTT=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DBI=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DEBUG_SELFTEST is not set
CONFIG_DRM_KMS_HELPER=m
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
CONFIG_DRM_DP_CEC=y
CONFIG_DRM_TTM=m
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_CMA_HELPER=y
CONFIG_DRM_KMS_CMA_HELPER=y
CONFIG_DRM_GEM_SHMEM_HELPER=y
CONFIG_DRM_SCHED=m

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
CONFIG_DRM_I2C_NXP_TDA998X=m
CONFIG_DRM_I2C_NXP_TDA9950=m
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

CONFIG_DRM_RADEON=m
# CONFIG_DRM_RADEON_USERPTR is not set
CONFIG_DRM_AMDGPU=m
CONFIG_DRM_AMDGPU_SI=y
CONFIG_DRM_AMDGPU_CIK=y
CONFIG_DRM_AMDGPU_USERPTR=y

#
# ACP (Audio CoProcessor) Configuration
#
CONFIG_DRM_AMD_ACP=y
# end of ACP (Audio CoProcessor) Configuration

#
# Display Engine Configuration
#
CONFIG_DRM_AMD_DC=y
CONFIG_DRM_AMD_DC_DCN=y
CONFIG_DRM_AMD_DC_HDCP=y
CONFIG_DRM_AMD_DC_SI=y
# CONFIG_DEBUG_KERNEL_DC is not set
CONFIG_DRM_AMD_SECURE_DISPLAY=y
# end of Display Engine Configuration

CONFIG_HSA_AMD=y
CONFIG_HSA_AMD_SVM=y
CONFIG_DRM_NOUVEAU=m
# CONFIG_NOUVEAU_LEGACY_CTX_SUPPORT is not set
CONFIG_NOUVEAU_DEBUG=5
CONFIG_NOUVEAU_DEBUG_DEFAULT=3
# CONFIG_NOUVEAU_DEBUG_MMU is not set
# CONFIG_NOUVEAU_DEBUG_PUSH is not set
CONFIG_DRM_NOUVEAU_BACKLIGHT=y
# CONFIG_DRM_NOUVEAU_SVM is not set
CONFIG_DRM_I915=m
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
CONFIG_DRM_I915_GVT=y
CONFIG_DRM_I915_GVT_KVMGT=m

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
# CONFIG_DRM_I915_DEBUG is not set
# CONFIG_DRM_I915_DEBUG_MMIO is not set
# CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
# CONFIG_DRM_I915_DEBUG_GUC is not set
# CONFIG_DRM_I915_SELFTEST is not set
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
# CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
# end of drm/i915 Debugging

#
# drm/i915 Profile Guided Optimisation
#
CONFIG_DRM_I915_REQUEST_TIMEOUT=20000
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# end of drm/i915 Profile Guided Optimisation

CONFIG_DRM_VGEM=m
CONFIG_DRM_VKMS=m
CONFIG_DRM_VMWGFX=m
CONFIG_DRM_VMWGFX_FBCON=y
# CONFIG_DRM_VMWGFX_MKSSTATS is not set
CONFIG_DRM_GMA500=m
CONFIG_DRM_UDL=m
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
CONFIG_DRM_QXL=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN=m
CONFIG_DRM_PANEL_WIDECHIPS_WS2401=m
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
CONFIG_DRM_ANALOGIX_ANX78XX=m
CONFIG_DRM_ANALOGIX_DP=m
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_BOCHS=m
CONFIG_DRM_CIRRUS_QEMU=m
CONFIG_DRM_GM12U320=m
CONFIG_DRM_SIMPLEDRM=m
CONFIG_TINYDRM_HX8357D=m
CONFIG_TINYDRM_ILI9225=m
CONFIG_TINYDRM_ILI9341=m
CONFIG_TINYDRM_ILI9486=m
CONFIG_TINYDRM_MI0283QT=m
CONFIG_TINYDRM_REPAPER=m
CONFIG_TINYDRM_ST7586=m
CONFIG_TINYDRM_ST7735R=m
CONFIG_DRM_XEN=y
CONFIG_DRM_XEN_FRONTEND=m
CONFIG_DRM_VBOXVIDEO=m
CONFIG_DRM_GUD=m
CONFIG_DRM_HYPERV=m
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
CONFIG_FIRMWARE_EDID=y
CONFIG_FB_DDC=m
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_HECUBA=m
CONFIG_FB_SVGALIB=m
CONFIG_FB_BACKLIGHT=m
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
CONFIG_FB_CIRRUS=m
CONFIG_FB_PM2=m
CONFIG_FB_PM2_FIFO_DISCONNECT=y
CONFIG_FB_CYBER2000=m
CONFIG_FB_CYBER2000_DDC=y
CONFIG_FB_ARC=m
CONFIG_FB_ASILIANT=y
CONFIG_FB_IMSTT=y
CONFIG_FB_VGA16=m
CONFIG_FB_UVESA=m
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
CONFIG_FB_N411=m
CONFIG_FB_HGA=m
CONFIG_FB_OPENCORES=m
CONFIG_FB_S1D13XXX=m
CONFIG_FB_NVIDIA=m
CONFIG_FB_NVIDIA_I2C=y
# CONFIG_FB_NVIDIA_DEBUG is not set
CONFIG_FB_NVIDIA_BACKLIGHT=y
CONFIG_FB_RIVA=m
CONFIG_FB_RIVA_I2C=y
# CONFIG_FB_RIVA_DEBUG is not set
CONFIG_FB_RIVA_BACKLIGHT=y
CONFIG_FB_I740=m
CONFIG_FB_LE80578=m
CONFIG_FB_CARILLO_RANCH=m
CONFIG_FB_INTEL=m
# CONFIG_FB_INTEL_DEBUG is not set
CONFIG_FB_INTEL_I2C=y
CONFIG_FB_MATROX=m
CONFIG_FB_MATROX_MILLENIUM=y
CONFIG_FB_MATROX_MYSTIQUE=y
CONFIG_FB_MATROX_G=y
CONFIG_FB_MATROX_I2C=m
CONFIG_FB_MATROX_MAVEN=m
CONFIG_FB_RADEON=m
CONFIG_FB_RADEON_I2C=y
CONFIG_FB_RADEON_BACKLIGHT=y
# CONFIG_FB_RADEON_DEBUG is not set
CONFIG_FB_ATY128=m
CONFIG_FB_ATY128_BACKLIGHT=y
CONFIG_FB_ATY=m
CONFIG_FB_ATY_CT=y
# CONFIG_FB_ATY_GENERIC_LCD is not set
CONFIG_FB_ATY_GX=y
CONFIG_FB_ATY_BACKLIGHT=y
CONFIG_FB_S3=m
CONFIG_FB_S3_DDC=y
CONFIG_FB_SAVAGE=m
CONFIG_FB_SAVAGE_I2C=y
# CONFIG_FB_SAVAGE_ACCEL is not set
CONFIG_FB_SIS=m
CONFIG_FB_SIS_300=y
CONFIG_FB_SIS_315=y
CONFIG_FB_VIA=m
# CONFIG_FB_VIA_DIRECT_PROCFS is not set
CONFIG_FB_VIA_X_COMPATIBILITY=y
CONFIG_FB_NEOMAGIC=m
CONFIG_FB_KYRO=m
CONFIG_FB_3DFX=m
# CONFIG_FB_3DFX_ACCEL is not set
# CONFIG_FB_3DFX_I2C is not set
CONFIG_FB_VOODOO1=m
CONFIG_FB_VT8623=m
CONFIG_FB_TRIDENT=m
CONFIG_FB_ARK=m
CONFIG_FB_PM3=m
CONFIG_FB_CARMINE=m
CONFIG_FB_CARMINE_DRAM_EVAL=y
# CONFIG_CARMINE_DRAM_CUSTOM is not set
CONFIG_FB_SM501=m
CONFIG_FB_SMSCUFX=m
CONFIG_FB_UDL=m
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
CONFIG_XEN_FBDEV_FRONTEND=m
CONFIG_FB_METRONOME=m
CONFIG_FB_MB862XX=m
CONFIG_FB_MB862XX_PCI_GDC=y
CONFIG_FB_MB862XX_I2C=y
CONFIG_FB_HYPERV=m
CONFIG_FB_SIMPLE=m
CONFIG_FB_SSD1307=m
CONFIG_FB_SM712=m
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
CONFIG_LCD_L4F00242T03=m
CONFIG_LCD_LMS283GF05=m
CONFIG_LCD_LTV350QV=m
CONFIG_LCD_ILI922X=m
CONFIG_LCD_ILI9320=m
CONFIG_LCD_TDO24M=m
CONFIG_LCD_VGG2432A4=m
CONFIG_LCD_PLATFORM=m
CONFIG_LCD_AMS369FG06=m
CONFIG_LCD_LMS501KF03=m
CONFIG_LCD_HX8357=m
CONFIG_LCD_OTM3225A=m
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_KTD253=m
CONFIG_BACKLIGHT_LM3533=m
CONFIG_BACKLIGHT_CARILLO_RANCH=m
CONFIG_BACKLIGHT_PWM=m
CONFIG_BACKLIGHT_DA903X=m
CONFIG_BACKLIGHT_DA9052=m
CONFIG_BACKLIGHT_MAX8925=m
CONFIG_BACKLIGHT_APPLE=m
CONFIG_BACKLIGHT_QCOM_WLED=m
CONFIG_BACKLIGHT_RT4831=m
CONFIG_BACKLIGHT_SAHARA=m
CONFIG_BACKLIGHT_WM831X=m
CONFIG_BACKLIGHT_ADP5520=m
CONFIG_BACKLIGHT_ADP8860=m
CONFIG_BACKLIGHT_ADP8870=m
CONFIG_BACKLIGHT_88PM860X=m
CONFIG_BACKLIGHT_PCF50633=m
CONFIG_BACKLIGHT_AAT2870=m
CONFIG_BACKLIGHT_LM3630A=m
CONFIG_BACKLIGHT_LM3639=m
CONFIG_BACKLIGHT_LP855X=m
CONFIG_BACKLIGHT_LP8788=m
CONFIG_BACKLIGHT_PANDORA=m
CONFIG_BACKLIGHT_SKY81452=m
CONFIG_BACKLIGHT_AS3711=m
CONFIG_BACKLIGHT_GPIO=m
CONFIG_BACKLIGHT_LV5207LP=m
CONFIG_BACKLIGHT_BD6107=m
CONFIG_BACKLIGHT_ARCXCNN=m
CONFIG_BACKLIGHT_RAVE_SP=m
# end of Backlight & LCD device support

CONFIG_VGASTATE=m
CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER=y
# end of Console display driver support

# CONFIG_LOGO is not set
# end of Graphics support

CONFIG_SOUND=m
CONFIG_SOUND_OSS_CORE=y
# CONFIG_SOUND_OSS_CORE_PRECLAIM is not set
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_PCM_ELD=y
CONFIG_SND_PCM_IEC958=y
CONFIG_SND_DMAENGINE_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_SEQ_DEVICE=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_COMPRESS_OFFLOAD=m
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
# CONFIG_SND_PCM_OSS is not set
CONFIG_SND_PCM_TIMER=y
CONFIG_SND_HRTIMER=m
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
CONFIG_SND_SUPPORT_OLD_API=y
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_CTL_LED=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
# CONFIG_SND_SEQUENCER_OSS is not set
CONFIG_SND_SEQ_HRTIMER_DEFAULT=y
CONFIG_SND_SEQ_MIDI_EVENT=m
CONFIG_SND_SEQ_MIDI=m
CONFIG_SND_SEQ_MIDI_EMUL=m
CONFIG_SND_SEQ_VIRMIDI=m
CONFIG_SND_MPU401_UART=m
CONFIG_SND_OPL3_LIB=m
CONFIG_SND_OPL3_LIB_SEQ=m
CONFIG_SND_VX_LIB=m
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_DRIVERS=y
CONFIG_SND_PCSP=m
CONFIG_SND_DUMMY=m
CONFIG_SND_ALOOP=m
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=m
CONFIG_SND_MTS64=m
CONFIG_SND_SERIAL_U16550=m
CONFIG_SND_MPU401=m
CONFIG_SND_PORTMAN2X4=m
CONFIG_SND_AC97_POWER_SAVE=y
CONFIG_SND_AC97_POWER_SAVE_DEFAULT=0
CONFIG_SND_SB_COMMON=m
CONFIG_SND_PCI=y
CONFIG_SND_AD1889=m
CONFIG_SND_ALS300=m
CONFIG_SND_ALS4000=m
CONFIG_SND_ALI5451=m
CONFIG_SND_ASIHPI=m
CONFIG_SND_ATIIXP=m
CONFIG_SND_ATIIXP_MODEM=m
CONFIG_SND_AU8810=m
CONFIG_SND_AU8820=m
CONFIG_SND_AU8830=m
CONFIG_SND_AW2=m
CONFIG_SND_AZT3328=m
CONFIG_SND_BT87X=m
# CONFIG_SND_BT87X_OVERCLOCK is not set
CONFIG_SND_CA0106=m
CONFIG_SND_CMIPCI=m
CONFIG_SND_OXYGEN_LIB=m
CONFIG_SND_OXYGEN=m
CONFIG_SND_CS4281=m
CONFIG_SND_CS46XX=m
CONFIG_SND_CS46XX_NEW_DSP=y
CONFIG_SND_CTXFI=m
CONFIG_SND_DARLA20=m
CONFIG_SND_GINA20=m
CONFIG_SND_LAYLA20=m
CONFIG_SND_DARLA24=m
CONFIG_SND_GINA24=m
CONFIG_SND_LAYLA24=m
CONFIG_SND_MONA=m
CONFIG_SND_MIA=m
CONFIG_SND_ECHO3G=m
CONFIG_SND_INDIGO=m
CONFIG_SND_INDIGOIO=m
CONFIG_SND_INDIGODJ=m
CONFIG_SND_INDIGOIOX=m
CONFIG_SND_INDIGODJX=m
CONFIG_SND_EMU10K1=m
CONFIG_SND_EMU10K1_SEQ=m
CONFIG_SND_EMU10K1X=m
CONFIG_SND_ENS1370=m
CONFIG_SND_ENS1371=m
CONFIG_SND_ES1938=m
CONFIG_SND_ES1968=m
CONFIG_SND_ES1968_INPUT=y
CONFIG_SND_ES1968_RADIO=y
CONFIG_SND_FM801=m
CONFIG_SND_FM801_TEA575X_BOOL=y
CONFIG_SND_HDSP=m
CONFIG_SND_HDSPM=m
CONFIG_SND_ICE1712=m
CONFIG_SND_ICE1724=m
CONFIG_SND_INTEL8X0=m
CONFIG_SND_INTEL8X0M=m
CONFIG_SND_KORG1212=m
CONFIG_SND_LOLA=m
CONFIG_SND_LX6464ES=m
CONFIG_SND_MAESTRO3=m
CONFIG_SND_MAESTRO3_INPUT=y
CONFIG_SND_MIXART=m
CONFIG_SND_NM256=m
CONFIG_SND_PCXHR=m
CONFIG_SND_RIPTIDE=m
CONFIG_SND_RME32=m
CONFIG_SND_RME96=m
CONFIG_SND_RME9652=m
CONFIG_SND_SONICVIBES=m
CONFIG_SND_TRIDENT=m
CONFIG_SND_VIA82XX=m
CONFIG_SND_VIA82XX_MODEM=m
CONFIG_SND_VIRTUOSO=m
CONFIG_SND_VX222=m
CONFIG_SND_YMFPCI=m

#
# HD-Audio
#
CONFIG_SND_HDA=m
CONFIG_SND_HDA_GENERIC_LEDS=y
CONFIG_SND_HDA_INTEL=m
CONFIG_SND_HDA_HWDEP=y
CONFIG_SND_HDA_RECONFIG=y
CONFIG_SND_HDA_INPUT_BEEP=y
CONFIG_SND_HDA_INPUT_BEEP_MODE=0
CONFIG_SND_HDA_PATCH_LOADER=y
CONFIG_SND_HDA_CODEC_REALTEK=m
CONFIG_SND_HDA_CODEC_ANALOG=m
CONFIG_SND_HDA_CODEC_SIGMATEL=m
CONFIG_SND_HDA_CODEC_VIA=m
CONFIG_SND_HDA_CODEC_HDMI=m
CONFIG_SND_HDA_CODEC_CIRRUS=m
CONFIG_SND_HDA_CODEC_CS8409=m
CONFIG_SND_HDA_CODEC_CONEXANT=m
CONFIG_SND_HDA_CODEC_CA0110=m
CONFIG_SND_HDA_CODEC_CA0132=m
CONFIG_SND_HDA_CODEC_CA0132_DSP=y
CONFIG_SND_HDA_CODEC_CMEDIA=m
CONFIG_SND_HDA_CODEC_SI3054=m
CONFIG_SND_HDA_GENERIC=m
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=1
# CONFIG_SND_HDA_INTEL_HDMI_SILENT_STREAM is not set
# end of HD-Audio

CONFIG_SND_HDA_CORE=m
CONFIG_SND_HDA_DSP_LOADER=y
CONFIG_SND_HDA_COMPONENT=y
CONFIG_SND_HDA_I915=y
CONFIG_SND_HDA_EXT_CORE=m
CONFIG_SND_HDA_PREALLOC_SIZE=0
CONFIG_SND_INTEL_NHLT=y
CONFIG_SND_INTEL_DSP_CONFIG=m
CONFIG_SND_INTEL_SOUNDWIRE_ACPI=m
CONFIG_SND_INTEL_BYT_PREFER_SOF=y
CONFIG_SND_SPI=y
CONFIG_SND_USB=y
CONFIG_SND_USB_AUDIO=m
CONFIG_SND_USB_AUDIO_USE_MEDIA_CONTROLLER=y
CONFIG_SND_USB_UA101=m
CONFIG_SND_USB_USX2Y=m
CONFIG_SND_USB_CAIAQ=m
CONFIG_SND_USB_CAIAQ_INPUT=y
CONFIG_SND_USB_US122L=m
CONFIG_SND_USB_6FIRE=m
CONFIG_SND_USB_HIFACE=m
CONFIG_SND_BCD2000=m
CONFIG_SND_USB_LINE6=m
CONFIG_SND_USB_POD=m
CONFIG_SND_USB_PODHD=m
CONFIG_SND_USB_TONEPORT=m
CONFIG_SND_USB_VARIAX=m
CONFIG_SND_FIREWIRE=y
CONFIG_SND_FIREWIRE_LIB=m
CONFIG_SND_DICE=m
CONFIG_SND_OXFW=m
CONFIG_SND_ISIGHT=m
CONFIG_SND_FIREWORKS=m
CONFIG_SND_BEBOB=m
CONFIG_SND_FIREWIRE_DIGI00X=m
CONFIG_SND_FIREWIRE_TASCAM=m
CONFIG_SND_FIREWIRE_MOTU=m
CONFIG_SND_FIREFACE=m
CONFIG_SND_PCMCIA=y
CONFIG_SND_VXPOCKET=m
CONFIG_SND_PDAUDIOCF=m
CONFIG_SND_SOC=m
CONFIG_SND_SOC_AC97_BUS=y
CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
CONFIG_SND_SOC_COMPRESS=y
CONFIG_SND_SOC_TOPOLOGY=y
CONFIG_SND_SOC_ACPI=m
CONFIG_SND_SOC_ADI=m
CONFIG_SND_SOC_ADI_AXI_I2S=m
CONFIG_SND_SOC_ADI_AXI_SPDIF=m
CONFIG_SND_SOC_AMD_ACP=m
CONFIG_SND_SOC_AMD_CZ_DA7219MX98357_MACH=m
CONFIG_SND_SOC_AMD_CZ_RT5645_MACH=m
CONFIG_SND_SOC_AMD_ACP3x=m
CONFIG_SND_SOC_AMD_RV_RT5682_MACH=m
CONFIG_SND_SOC_AMD_RENOIR=m
CONFIG_SND_SOC_AMD_RENOIR_MACH=m
CONFIG_SND_SOC_AMD_ACP5x=m
CONFIG_SND_ATMEL_SOC=m
CONFIG_SND_BCM63XX_I2S_WHISTLER=m
CONFIG_SND_DESIGNWARE_I2S=m
CONFIG_SND_DESIGNWARE_PCM=y

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
CONFIG_SND_SOC_FSL_ASRC=m
CONFIG_SND_SOC_FSL_SAI=m
CONFIG_SND_SOC_FSL_MQS=m
CONFIG_SND_SOC_FSL_AUDMIX=m
CONFIG_SND_SOC_FSL_SSI=m
CONFIG_SND_SOC_FSL_SPDIF=m
CONFIG_SND_SOC_FSL_ESAI=m
CONFIG_SND_SOC_FSL_MICFIL=m
CONFIG_SND_SOC_FSL_EASRC=m
CONFIG_SND_SOC_FSL_XCVR=m
CONFIG_SND_SOC_FSL_RPMSG=m
CONFIG_SND_SOC_IMX_AUDMUX=m
# end of SoC Audio for Freescale CPUs

CONFIG_SND_I2S_HI6210_I2S=m
CONFIG_SND_SOC_IMG=y
CONFIG_SND_SOC_IMG_I2S_IN=m
CONFIG_SND_SOC_IMG_I2S_OUT=m
CONFIG_SND_SOC_IMG_PARALLEL_OUT=m
CONFIG_SND_SOC_IMG_SPDIF_IN=m
CONFIG_SND_SOC_IMG_SPDIF_OUT=m
CONFIG_SND_SOC_IMG_PISTACHIO_INTERNAL_DAC=m
CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=y
CONFIG_SND_SOC_INTEL_SST=m
CONFIG_SND_SOC_INTEL_CATPT=m
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM=m
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_PCI=m
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI=m
# CONFIG_SND_SOC_INTEL_SKYLAKE is not set
CONFIG_SND_SOC_INTEL_SKL=m
CONFIG_SND_SOC_INTEL_APL=m
CONFIG_SND_SOC_INTEL_KBL=m
CONFIG_SND_SOC_INTEL_GLK=m
# CONFIG_SND_SOC_INTEL_CNL is not set
# CONFIG_SND_SOC_INTEL_CFL is not set
# CONFIG_SND_SOC_INTEL_CML_H is not set
# CONFIG_SND_SOC_INTEL_CML_LP is not set
CONFIG_SND_SOC_INTEL_SKYLAKE_FAMILY=m
CONFIG_SND_SOC_INTEL_SKYLAKE_SSP_CLK=m
CONFIG_SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC=y
CONFIG_SND_SOC_INTEL_SKYLAKE_COMMON=m
CONFIG_SND_SOC_ACPI_INTEL_MATCH=m
CONFIG_SND_SOC_INTEL_MACH=y
CONFIG_SND_SOC_INTEL_USER_FRIENDLY_LONG_NAMES=y
CONFIG_SND_SOC_INTEL_HDA_DSP_COMMON=m
CONFIG_SND_SOC_INTEL_SOF_MAXIM_COMMON=m
CONFIG_SND_SOC_INTEL_HASWELL_MACH=m
CONFIG_SND_SOC_INTEL_BDW_RT5650_MACH=m
CONFIG_SND_SOC_INTEL_BDW_RT5677_MACH=m
CONFIG_SND_SOC_INTEL_BROADWELL_MACH=m
CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH=m
CONFIG_SND_SOC_INTEL_BYTCR_RT5651_MACH=m
CONFIG_SND_SOC_INTEL_BYTCR_WM5102_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_RT5672_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_RT5645_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_NAU8824_MACH=m
CONFIG_SND_SOC_INTEL_BYT_CHT_CX2072X_MACH=m
CONFIG_SND_SOC_INTEL_BYT_CHT_DA7213_MACH=m
CONFIG_SND_SOC_INTEL_BYT_CHT_ES8316_MACH=m
# CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH is not set
CONFIG_SND_SOC_INTEL_SKL_RT286_MACH=m
CONFIG_SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH=m
CONFIG_SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH=m
CONFIG_SND_SOC_INTEL_DA7219_MAX98357A_GENERIC=m
CONFIG_SND_SOC_INTEL_BXT_DA7219_MAX98357A_COMMON=m
CONFIG_SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH=m
CONFIG_SND_SOC_INTEL_BXT_RT298_MACH=m
CONFIG_SND_SOC_INTEL_SOF_WM8804_MACH=m
CONFIG_SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH=m
CONFIG_SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH=m
CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98357A_MACH=m
CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98927_MACH=m
CONFIG_SND_SOC_INTEL_KBL_RT5660_MACH=m
CONFIG_SND_SOC_INTEL_GLK_DA7219_MAX98357A_MACH=m
CONFIG_SND_SOC_INTEL_GLK_RT5682_MAX98357A_MACH=m
CONFIG_SND_SOC_INTEL_SKL_HDA_DSP_GENERIC_MACH=m
CONFIG_SND_SOC_INTEL_SOF_RT5682_MACH=m
CONFIG_SND_SOC_INTEL_SOF_CS42L42_MACH=m
CONFIG_SND_SOC_INTEL_SOF_PCM512x_MACH=m
CONFIG_SND_SOC_INTEL_CML_LP_DA7219_MAX98357A_MACH=m
CONFIG_SND_SOC_INTEL_SOF_CML_RT1011_RT5682_MACH=m
CONFIG_SND_SOC_INTEL_SOF_DA7219_MAX98373_MACH=m
CONFIG_SND_SOC_INTEL_EHL_RT5660_MACH=m
CONFIG_SND_SOC_INTEL_SOUNDWIRE_SOF_MACH=m
CONFIG_SND_SOC_MTK_BTCVSD=m
CONFIG_SND_SOC_SOF_TOPLEVEL=y
CONFIG_SND_SOC_SOF_PCI_DEV=m
CONFIG_SND_SOC_SOF_PCI=m
CONFIG_SND_SOC_SOF_ACPI=m
CONFIG_SND_SOC_SOF_ACPI_DEV=m
# CONFIG_SND_SOC_SOF_DEBUG_PROBES is not set
# CONFIG_SND_SOC_SOF_DEVELOPER_SUPPORT is not set
CONFIG_SND_SOC_SOF=m
CONFIG_SND_SOC_SOF_PROBE_WORK_QUEUE=y
CONFIG_SND_SOC_SOF_INTEL_TOPLEVEL=y
CONFIG_SND_SOC_SOF_INTEL_HIFI_EP_IPC=m
CONFIG_SND_SOC_SOF_INTEL_ATOM_HIFI_EP=m
CONFIG_SND_SOC_SOF_INTEL_COMMON=m
CONFIG_SND_SOC_SOF_BAYTRAIL=m
CONFIG_SND_SOC_SOF_BROADWELL=m
CONFIG_SND_SOC_SOF_MERRIFIELD=m
CONFIG_SND_SOC_SOF_INTEL_APL=m
CONFIG_SND_SOC_SOF_APOLLOLAKE=m
CONFIG_SND_SOC_SOF_GEMINILAKE=m
CONFIG_SND_SOC_SOF_INTEL_CNL=m
CONFIG_SND_SOC_SOF_CANNONLAKE=m
CONFIG_SND_SOC_SOF_COFFEELAKE=m
CONFIG_SND_SOC_SOF_COMETLAKE=m
CONFIG_SND_SOC_SOF_INTEL_ICL=m
CONFIG_SND_SOC_SOF_ICELAKE=m
CONFIG_SND_SOC_SOF_JASPERLAKE=m
CONFIG_SND_SOC_SOF_INTEL_TGL=m
CONFIG_SND_SOC_SOF_TIGERLAKE=m
CONFIG_SND_SOC_SOF_ELKHARTLAKE=m
CONFIG_SND_SOC_SOF_ALDERLAKE=m
CONFIG_SND_SOC_SOF_HDA_COMMON=m
CONFIG_SND_SOC_SOF_HDA_LINK=y
CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC=y
CONFIG_SND_SOC_SOF_HDA_LINK_BASELINE=m
CONFIG_SND_SOC_SOF_HDA=m
CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE_LINK_BASELINE=m
CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE=m
CONFIG_SND_SOC_SOF_XTENSA=m

#
# STMicroelectronics STM32 SOC audio support
#
# end of STMicroelectronics STM32 SOC audio support

CONFIG_SND_SOC_XILINX_I2S=m
CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER=m
CONFIG_SND_SOC_XILINX_SPDIF=m
CONFIG_SND_SOC_XTFPGA_I2S=m
CONFIG_SND_SOC_I2C_AND_SPI=m

#
# CODEC drivers
#
CONFIG_SND_SOC_ARIZONA=m
CONFIG_SND_SOC_WM_ADSP=m
CONFIG_SND_SOC_AC97_CODEC=m
CONFIG_SND_SOC_ADAU_UTILS=m
CONFIG_SND_SOC_ADAU1372=m
CONFIG_SND_SOC_ADAU1372_I2C=m
CONFIG_SND_SOC_ADAU1372_SPI=m
CONFIG_SND_SOC_ADAU1701=m
CONFIG_SND_SOC_ADAU17X1=m
CONFIG_SND_SOC_ADAU1761=m
CONFIG_SND_SOC_ADAU1761_I2C=m
CONFIG_SND_SOC_ADAU1761_SPI=m
CONFIG_SND_SOC_ADAU7002=m
CONFIG_SND_SOC_ADAU7118=m
CONFIG_SND_SOC_ADAU7118_HW=m
CONFIG_SND_SOC_ADAU7118_I2C=m
CONFIG_SND_SOC_AK4104=m
CONFIG_SND_SOC_AK4118=m
CONFIG_SND_SOC_AK4458=m
CONFIG_SND_SOC_AK4554=m
CONFIG_SND_SOC_AK4613=m
CONFIG_SND_SOC_AK4642=m
CONFIG_SND_SOC_AK5386=m
CONFIG_SND_SOC_AK5558=m
CONFIG_SND_SOC_ALC5623=m
CONFIG_SND_SOC_BD28623=m
CONFIG_SND_SOC_BT_SCO=m
CONFIG_SND_SOC_CROS_EC_CODEC=m
CONFIG_SND_SOC_CS35L32=m
CONFIG_SND_SOC_CS35L33=m
CONFIG_SND_SOC_CS35L34=m
CONFIG_SND_SOC_CS35L35=m
CONFIG_SND_SOC_CS35L36=m
CONFIG_SND_SOC_CS42L42=m
CONFIG_SND_SOC_CS42L51=m
CONFIG_SND_SOC_CS42L51_I2C=m
CONFIG_SND_SOC_CS42L52=m
CONFIG_SND_SOC_CS42L56=m
CONFIG_SND_SOC_CS42L73=m
CONFIG_SND_SOC_CS4234=m
CONFIG_SND_SOC_CS4265=m
CONFIG_SND_SOC_CS4270=m
CONFIG_SND_SOC_CS4271=m
CONFIG_SND_SOC_CS4271_I2C=m
CONFIG_SND_SOC_CS4271_SPI=m
CONFIG_SND_SOC_CS42XX8=m
CONFIG_SND_SOC_CS42XX8_I2C=m
CONFIG_SND_SOC_CS43130=m
CONFIG_SND_SOC_CS4341=m
CONFIG_SND_SOC_CS4349=m
CONFIG_SND_SOC_CS53L30=m
CONFIG_SND_SOC_CX2072X=m
CONFIG_SND_SOC_DA7213=m
CONFIG_SND_SOC_DA7219=m
CONFIG_SND_SOC_DMIC=m
CONFIG_SND_SOC_HDMI_CODEC=m
CONFIG_SND_SOC_ES7134=m
CONFIG_SND_SOC_ES7241=m
CONFIG_SND_SOC_ES8316=m
CONFIG_SND_SOC_ES8328=m
CONFIG_SND_SOC_ES8328_I2C=m
CONFIG_SND_SOC_ES8328_SPI=m
CONFIG_SND_SOC_GTM601=m
CONFIG_SND_SOC_HDAC_HDMI=m
CONFIG_SND_SOC_HDAC_HDA=m
CONFIG_SND_SOC_ICS43432=m
CONFIG_SND_SOC_INNO_RK3036=m
CONFIG_SND_SOC_MAX98088=m
CONFIG_SND_SOC_MAX98090=m
CONFIG_SND_SOC_MAX98357A=m
CONFIG_SND_SOC_MAX98504=m
CONFIG_SND_SOC_MAX9867=m
CONFIG_SND_SOC_MAX98927=m
CONFIG_SND_SOC_MAX98373=m
CONFIG_SND_SOC_MAX98373_I2C=m
CONFIG_SND_SOC_MAX98373_SDW=m
CONFIG_SND_SOC_MAX98390=m
CONFIG_SND_SOC_MAX9860=m
CONFIG_SND_SOC_MSM8916_WCD_ANALOG=m
CONFIG_SND_SOC_MSM8916_WCD_DIGITAL=m
CONFIG_SND_SOC_PCM1681=m
CONFIG_SND_SOC_PCM1789=m
CONFIG_SND_SOC_PCM1789_I2C=m
CONFIG_SND_SOC_PCM179X=m
CONFIG_SND_SOC_PCM179X_I2C=m
CONFIG_SND_SOC_PCM179X_SPI=m
CONFIG_SND_SOC_PCM186X=m
CONFIG_SND_SOC_PCM186X_I2C=m
CONFIG_SND_SOC_PCM186X_SPI=m
CONFIG_SND_SOC_PCM3060=m
CONFIG_SND_SOC_PCM3060_I2C=m
CONFIG_SND_SOC_PCM3060_SPI=m
CONFIG_SND_SOC_PCM3168A=m
CONFIG_SND_SOC_PCM3168A_I2C=m
CONFIG_SND_SOC_PCM3168A_SPI=m
CONFIG_SND_SOC_PCM5102A=m
CONFIG_SND_SOC_PCM512x=m
CONFIG_SND_SOC_PCM512x_I2C=m
CONFIG_SND_SOC_PCM512x_SPI=m
CONFIG_SND_SOC_RK3328=m
CONFIG_SND_SOC_RL6231=m
CONFIG_SND_SOC_RL6347A=m
CONFIG_SND_SOC_RT286=m
CONFIG_SND_SOC_RT298=m
CONFIG_SND_SOC_RT1011=m
CONFIG_SND_SOC_RT1015=m
CONFIG_SND_SOC_RT1015P=m
CONFIG_SND_SOC_RT1308=m
CONFIG_SND_SOC_RT1308_SDW=m
CONFIG_SND_SOC_RT1316_SDW=m
CONFIG_SND_SOC_RT5514=m
CONFIG_SND_SOC_RT5514_SPI=m
CONFIG_SND_SOC_RT5616=m
CONFIG_SND_SOC_RT5631=m
CONFIG_SND_SOC_RT5640=m
CONFIG_SND_SOC_RT5645=m
CONFIG_SND_SOC_RT5651=m
CONFIG_SND_SOC_RT5659=m
CONFIG_SND_SOC_RT5660=m
CONFIG_SND_SOC_RT5663=m
CONFIG_SND_SOC_RT5670=m
CONFIG_SND_SOC_RT5677=m
CONFIG_SND_SOC_RT5677_SPI=m
CONFIG_SND_SOC_RT5682=m
CONFIG_SND_SOC_RT5682_I2C=m
CONFIG_SND_SOC_RT5682_SDW=m
CONFIG_SND_SOC_RT700=m
CONFIG_SND_SOC_RT700_SDW=m
CONFIG_SND_SOC_RT711=m
CONFIG_SND_SOC_RT711_SDW=m
CONFIG_SND_SOC_RT711_SDCA_SDW=m
CONFIG_SND_SOC_RT715=m
CONFIG_SND_SOC_RT715_SDW=m
CONFIG_SND_SOC_RT715_SDCA_SDW=m
CONFIG_SND_SOC_SDW_MOCKUP=m
CONFIG_SND_SOC_SGTL5000=m
CONFIG_SND_SOC_SI476X=m
CONFIG_SND_SOC_SIGMADSP=m
CONFIG_SND_SOC_SIGMADSP_I2C=m
CONFIG_SND_SOC_SIGMADSP_REGMAP=m
CONFIG_SND_SOC_SIMPLE_AMPLIFIER=m
CONFIG_SND_SOC_SIMPLE_MUX=m
CONFIG_SND_SOC_SPDIF=m
CONFIG_SND_SOC_SSM2305=m
CONFIG_SND_SOC_SSM2518=m
CONFIG_SND_SOC_SSM2602=m
CONFIG_SND_SOC_SSM2602_SPI=m
CONFIG_SND_SOC_SSM2602_I2C=m
CONFIG_SND_SOC_SSM4567=m
CONFIG_SND_SOC_STA32X=m
CONFIG_SND_SOC_STA350=m
CONFIG_SND_SOC_STI_SAS=m
CONFIG_SND_SOC_TAS2552=m
CONFIG_SND_SOC_TAS2562=m
CONFIG_SND_SOC_TAS2764=m
CONFIG_SND_SOC_TAS2770=m
CONFIG_SND_SOC_TAS5086=m
CONFIG_SND_SOC_TAS571X=m
CONFIG_SND_SOC_TAS5720=m
CONFIG_SND_SOC_TAS6424=m
CONFIG_SND_SOC_TDA7419=m
CONFIG_SND_SOC_TFA9879=m
CONFIG_SND_SOC_TFA989X=m
CONFIG_SND_SOC_TLV320AIC23=m
CONFIG_SND_SOC_TLV320AIC23_I2C=m
CONFIG_SND_SOC_TLV320AIC23_SPI=m
CONFIG_SND_SOC_TLV320AIC31XX=m
CONFIG_SND_SOC_TLV320AIC32X4=m
CONFIG_SND_SOC_TLV320AIC32X4_I2C=m
CONFIG_SND_SOC_TLV320AIC32X4_SPI=m
CONFIG_SND_SOC_TLV320AIC3X=m
CONFIG_SND_SOC_TLV320AIC3X_I2C=m
CONFIG_SND_SOC_TLV320AIC3X_SPI=m
CONFIG_SND_SOC_TLV320ADCX140=m
CONFIG_SND_SOC_TS3A227E=m
CONFIG_SND_SOC_TSCS42XX=m
CONFIG_SND_SOC_TSCS454=m
CONFIG_SND_SOC_UDA1334=m
CONFIG_SND_SOC_WCD9335=m
CONFIG_SND_SOC_WCD_MBHC=m
CONFIG_SND_SOC_WCD934X=m
CONFIG_SND_SOC_WCD938X=m
CONFIG_SND_SOC_WCD938X_SDW=m
CONFIG_SND_SOC_WM5102=m
CONFIG_SND_SOC_WM8510=m
CONFIG_SND_SOC_WM8523=m
CONFIG_SND_SOC_WM8524=m
CONFIG_SND_SOC_WM8580=m
CONFIG_SND_SOC_WM8711=m
CONFIG_SND_SOC_WM8728=m
CONFIG_SND_SOC_WM8731=m
CONFIG_SND_SOC_WM8737=m
CONFIG_SND_SOC_WM8741=m
CONFIG_SND_SOC_WM8750=m
CONFIG_SND_SOC_WM8753=m
CONFIG_SND_SOC_WM8770=m
CONFIG_SND_SOC_WM8776=m
CONFIG_SND_SOC_WM8782=m
CONFIG_SND_SOC_WM8804=m
CONFIG_SND_SOC_WM8804_I2C=m
CONFIG_SND_SOC_WM8804_SPI=m
CONFIG_SND_SOC_WM8903=m
CONFIG_SND_SOC_WM8904=m
CONFIG_SND_SOC_WM8960=m
CONFIG_SND_SOC_WM8962=m
CONFIG_SND_SOC_WM8974=m
CONFIG_SND_SOC_WM8978=m
CONFIG_SND_SOC_WM8985=m
CONFIG_SND_SOC_WSA881X=m
CONFIG_SND_SOC_ZL38060=m
CONFIG_SND_SOC_MAX9759=m
CONFIG_SND_SOC_MT6351=m
CONFIG_SND_SOC_MT6358=m
CONFIG_SND_SOC_MT6660=m
CONFIG_SND_SOC_NAU8315=m
CONFIG_SND_SOC_NAU8540=m
CONFIG_SND_SOC_NAU8810=m
CONFIG_SND_SOC_NAU8822=m
CONFIG_SND_SOC_NAU8824=m
CONFIG_SND_SOC_NAU8825=m
CONFIG_SND_SOC_TPA6130A2=m
CONFIG_SND_SOC_LPASS_WSA_MACRO=m
CONFIG_SND_SOC_LPASS_VA_MACRO=m
CONFIG_SND_SOC_LPASS_RX_MACRO=m
CONFIG_SND_SOC_LPASS_TX_MACRO=m
# end of CODEC drivers

CONFIG_SND_SIMPLE_CARD_UTILS=m
CONFIG_SND_SIMPLE_CARD=m
CONFIG_SND_X86=y
CONFIG_HDMI_LPE_AUDIO=m
CONFIG_SND_SYNTH_EMUX=m
CONFIG_SND_XEN_FRONTEND=m
CONFIG_SND_VIRTIO=m
CONFIG_AC97_BUS=m

#
# HID support
#
CONFIG_HID=m
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=m

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
CONFIG_HID_ACCUTOUCH=m
CONFIG_HID_ACRUX=m
CONFIG_HID_ACRUX_FF=y
CONFIG_HID_APPLE=m
CONFIG_HID_APPLEIR=m
CONFIG_HID_ASUS=m
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=m
CONFIG_HID_BETOP_FF=m
CONFIG_HID_BIGBEN_FF=m
CONFIG_HID_CHERRY=m
CONFIG_HID_CHICONY=m
CONFIG_HID_CORSAIR=m
CONFIG_HID_COUGAR=m
CONFIG_HID_MACALLY=m
CONFIG_HID_PRODIKEYS=m
CONFIG_HID_CMEDIA=m
CONFIG_HID_CP2112=m
CONFIG_HID_CREATIVE_SB0540=m
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
CONFIG_DRAGONRISE_FF=y
CONFIG_HID_EMS_FF=m
CONFIG_HID_ELAN=m
CONFIG_HID_ELECOM=m
CONFIG_HID_ELO=m
CONFIG_HID_EZKEY=m
CONFIG_HID_FT260=m
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
CONFIG_HID_GLORIOUS=m
CONFIG_HID_HOLTEK=m
CONFIG_HOLTEK_FF=y
CONFIG_HID_GOOGLE_HAMMER=m
CONFIG_HID_VIVALDI=m
CONFIG_HID_GT683R=m
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
CONFIG_HID_UCLOGIC=m
CONFIG_HID_WALTOP=m
CONFIG_HID_VIEWSONIC=m
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
CONFIG_HID_JABRA=m
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
CONFIG_HID_LOGITECH=m
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
CONFIG_LOGITECH_FF=y
CONFIG_LOGIRUMBLEPAD2_FF=y
CONFIG_LOGIG940_FF=y
CONFIG_LOGIWHEELS_FF=y
CONFIG_HID_MAGICMOUSE=m
CONFIG_HID_MALTRON=m
CONFIG_HID_MAYFLASH=m
CONFIG_HID_REDRAGON=m
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
CONFIG_HID_NTI=m
CONFIG_HID_NTRIG=m
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
CONFIG_PANTHERLORD_FF=y
CONFIG_HID_PENMOUNT=m
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=m
CONFIG_HID_PLAYSTATION=m
CONFIG_PLAYSTATION_FF=y
CONFIG_HID_PRIMAX=m
CONFIG_HID_RETRODE=m
CONFIG_HID_ROCCAT=m
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
CONFIG_HID_SEMITEK=m
CONFIG_HID_SONY=m
CONFIG_SONY_FF=y
CONFIG_HID_SPEEDLINK=m
CONFIG_HID_STEAM=m
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
CONFIG_GREENASIA_FF=y
CONFIG_HID_HYPERV_MOUSE=m
CONFIG_HID_SMARTJOYPLUS=m
CONFIG_SMARTJOYPLUS_FF=y
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
CONFIG_THRUSTMASTER_FF=y
CONFIG_HID_UDRAW_PS3=m
CONFIG_HID_U2FZERO=m
CONFIG_HID_WACOM=m
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
CONFIG_ZEROPLUS_FF=y
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=m
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
CONFIG_HID_MCP2221=m
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=m
CONFIG_HID_PID=y
CONFIG_USB_HIDDEV=y

#
# USB HID Boot Protocol drivers
#
CONFIG_USB_KBD=m
CONFIG_USB_MOUSE=m
# end of USB HID Boot Protocol drivers
# end of USB HID support

#
# I2C HID support
#
CONFIG_I2C_HID_ACPI=m
# end of I2C HID support

CONFIG_I2C_HID_CORE=m

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=m
CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER=m
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
CONFIG_AMD_SFH_HID=m
# end of AMD SFH HID Support

#
# Surface System Aggregator Module HID support
#
CONFIG_SURFACE_HID=m
CONFIG_SURFACE_KBD=m
# end of Surface System Aggregator Module HID support

CONFIG_SURFACE_HID_CORE=m
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_LED_TRIG=y
CONFIG_USB_ULPI_BUS=m
CONFIG_USB_CONN_GPIO=m
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_FEW_INIT_RETRIES is not set
CONFIG_USB_DYNAMIC_MINORS=y
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
# CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=m
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=m

#
# USB Host Controller Drivers
#
CONFIG_USB_C67X00_HCD=m
CONFIG_USB_XHCI_HCD=y
CONFIG_USB_XHCI_DBGCAP=y
CONFIG_USB_XHCI_PCI=m
CONFIG_USB_XHCI_PCI_RENESAS=m
CONFIG_USB_XHCI_PLATFORM=m
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
CONFIG_USB_EHCI_FSL=m
CONFIG_USB_EHCI_HCD_PLATFORM=y
CONFIG_USB_OXU210HP_HCD=m
CONFIG_USB_ISP116X_HCD=m
CONFIG_USB_FOTG210_HCD=m
CONFIG_USB_MAX3421_HCD=m
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
CONFIG_USB_OHCI_HCD_PLATFORM=y
CONFIG_USB_UHCI_HCD=y
CONFIG_USB_U132_HCD=m
CONFIG_USB_SL811_HCD=m
CONFIG_USB_SL811_HCD_ISO=y
CONFIG_USB_SL811_CS=m
CONFIG_USB_R8A66597_HCD=m
CONFIG_USB_HCD_BCMA=m
CONFIG_USB_HCD_SSB=m
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_WDM=m
CONFIG_USB_TMC=m

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_REALTEK=m
CONFIG_REALTEK_AUTOPM=y
CONFIG_USB_STORAGE_DATAFAB=m
CONFIG_USB_STORAGE_FREECOM=m
CONFIG_USB_STORAGE_ISD200=m
CONFIG_USB_STORAGE_USBAT=m
CONFIG_USB_STORAGE_SDDR09=m
CONFIG_USB_STORAGE_SDDR55=m
CONFIG_USB_STORAGE_JUMPSHOT=m
CONFIG_USB_STORAGE_ALAUDA=m
CONFIG_USB_STORAGE_ONETOUCH=m
CONFIG_USB_STORAGE_KARMA=m
CONFIG_USB_STORAGE_CYPRESS_ATACB=m
CONFIG_USB_STORAGE_ENE_UB6250=m
CONFIG_USB_UAS=m

#
# USB Imaging devices
#
CONFIG_USB_MDC800=m
CONFIG_USB_MICROTEK=m
CONFIG_USBIP_CORE=m
CONFIG_USBIP_VHCI_HCD=m
CONFIG_USBIP_VHCI_HC_PORTS=8
CONFIG_USBIP_VHCI_NR_HCS=1
CONFIG_USBIP_HOST=m
CONFIG_USBIP_VUDC=m
# CONFIG_USBIP_DEBUG is not set
CONFIG_USB_CDNS_SUPPORT=m
CONFIG_USB_CDNS_HOST=y
CONFIG_USB_CDNS3=m
CONFIG_USB_CDNS3_GADGET=y
CONFIG_USB_CDNS3_HOST=y
CONFIG_USB_CDNS3_PCI_WRAP=m
CONFIG_USB_CDNSP_PCI=m
CONFIG_USB_CDNSP_GADGET=y
CONFIG_USB_CDNSP_HOST=y
CONFIG_USB_MUSB_HDRC=m
# CONFIG_USB_MUSB_HOST is not set
# CONFIG_USB_MUSB_GADGET is not set
CONFIG_USB_MUSB_DUAL_ROLE=y

#
# Platform Glue Layer
#

#
# MUSB DMA mode
#
CONFIG_MUSB_PIO_ONLY=y
CONFIG_USB_DWC3=m
CONFIG_USB_DWC3_ULPI=y
# CONFIG_USB_DWC3_HOST is not set
# CONFIG_USB_DWC3_GADGET is not set
CONFIG_USB_DWC3_DUAL_ROLE=y

#
# Platform Glue Driver Support
#
CONFIG_USB_DWC3_PCI=m
CONFIG_USB_DWC3_HAPS=m
CONFIG_USB_DWC2=y
CONFIG_USB_DWC2_HOST=y

#
# Gadget/Dual-role mode requires USB Gadget support to be enabled
#
CONFIG_USB_DWC2_PCI=m
# CONFIG_USB_DWC2_DEBUG is not set
# CONFIG_USB_DWC2_TRACK_MISSED_SOFS is not set
CONFIG_USB_CHIPIDEA=m
CONFIG_USB_CHIPIDEA_UDC=y
CONFIG_USB_CHIPIDEA_HOST=y
CONFIG_USB_CHIPIDEA_PCI=m
CONFIG_USB_CHIPIDEA_MSM=m
CONFIG_USB_CHIPIDEA_GENERIC=m
CONFIG_USB_ISP1760=m
CONFIG_USB_ISP1760_HCD=y
CONFIG_USB_ISP1761_UDC=y
# CONFIG_USB_ISP1760_HOST_ROLE is not set
# CONFIG_USB_ISP1760_GADGET_ROLE is not set
CONFIG_USB_ISP1760_DUAL_ROLE=y

#
# USB port drivers
#
CONFIG_USB_USS720=m
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
CONFIG_USB_SERIAL_SIMPLE=m
CONFIG_USB_SERIAL_AIRCABLE=m
CONFIG_USB_SERIAL_ARK3116=m
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_CH341=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_CP210X=m
CONFIG_USB_SERIAL_CYPRESS_M8=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_EDGEPORT_TI=m
CONFIG_USB_SERIAL_F81232=m
CONFIG_USB_SERIAL_F8153X=m
CONFIG_USB_SERIAL_GARMIN=m
CONFIG_USB_SERIAL_IPW=m
CONFIG_USB_SERIAL_IUU=m
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m
CONFIG_USB_SERIAL_MCT_U232=m
CONFIG_USB_SERIAL_METRO=m
CONFIG_USB_SERIAL_MOS7720=m
CONFIG_USB_SERIAL_MOS7715_PARPORT=y
CONFIG_USB_SERIAL_MOS7840=m
CONFIG_USB_SERIAL_MXUPORT=m
CONFIG_USB_SERIAL_NAVMAN=m
CONFIG_USB_SERIAL_PL2303=m
CONFIG_USB_SERIAL_OTI6858=m
CONFIG_USB_SERIAL_QCAUX=m
CONFIG_USB_SERIAL_QUALCOMM=m
CONFIG_USB_SERIAL_SPCP8X5=m
CONFIG_USB_SERIAL_SAFE=m
# CONFIG_USB_SERIAL_SAFE_PADDED is not set
CONFIG_USB_SERIAL_SIERRAWIRELESS=m
CONFIG_USB_SERIAL_SYMBOL=m
CONFIG_USB_SERIAL_TI=m
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_WWAN=m
CONFIG_USB_SERIAL_OPTION=m
CONFIG_USB_SERIAL_OMNINET=m
CONFIG_USB_SERIAL_OPTICON=m
CONFIG_USB_SERIAL_XSENS_MT=m
CONFIG_USB_SERIAL_WISHBONE=m
CONFIG_USB_SERIAL_SSU100=m
CONFIG_USB_SERIAL_QT2=m
CONFIG_USB_SERIAL_UPD78F0730=m
CONFIG_USB_SERIAL_XR=m
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=m
CONFIG_USB_EMI26=m
CONFIG_USB_ADUTUX=m
CONFIG_USB_SEVSEG=m
CONFIG_USB_LEGOTOWER=m
CONFIG_USB_LCD=m
CONFIG_USB_CYPRESS_CY7C63=m
CONFIG_USB_CYTHERM=m
CONFIG_USB_IDMOUSE=m
CONFIG_USB_FTDI_ELAN=m
CONFIG_USB_APPLEDISPLAY=m
CONFIG_APPLE_MFI_FASTCHARGE=m
CONFIG_USB_SISUSBVGA=m
CONFIG_USB_LD=m
CONFIG_USB_TRANCEVIBRATOR=m
CONFIG_USB_IOWARRIOR=m
CONFIG_USB_TEST=m
CONFIG_USB_EHSET_TEST_FIXTURE=m
CONFIG_USB_ISIGHTFW=m
CONFIG_USB_YUREX=m
CONFIG_USB_EZUSB_FX2=m
CONFIG_USB_HUB_USB251XB=m
CONFIG_USB_HSIC_USB3503=m
CONFIG_USB_HSIC_USB4604=m
CONFIG_USB_LINK_LAYER_TEST=m
CONFIG_USB_CHAOSKEY=m
CONFIG_USB_ATM=m
CONFIG_USB_SPEEDTOUCH=m
CONFIG_USB_CXACRU=m
CONFIG_USB_UEAGLEATM=m
CONFIG_USB_XUSBATM=m

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
CONFIG_NOP_USB_XCEIV=m
CONFIG_USB_GPIO_VBUS=m
CONFIG_TAHVO_USB=m
CONFIG_TAHVO_USB_HOST_BY_DEFAULT=y
CONFIG_USB_ISP1301=m
# end of USB Physical Layer drivers

CONFIG_USB_GADGET=m
# CONFIG_USB_GADGET_DEBUG is not set
# CONFIG_USB_GADGET_DEBUG_FILES is not set
# CONFIG_USB_GADGET_DEBUG_FS is not set
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2
CONFIG_U_SERIAL_CONSOLE=y

#
# USB Peripheral Controller
#
CONFIG_USB_FOTG210_UDC=m
CONFIG_USB_GR_UDC=m
CONFIG_USB_R8A66597=m
CONFIG_USB_PXA27X=m
CONFIG_USB_MV_UDC=m
CONFIG_USB_MV_U3D=m
CONFIG_USB_SNP_CORE=m
# CONFIG_USB_M66592 is not set
CONFIG_USB_BDC_UDC=m
CONFIG_USB_AMD5536UDC=m
CONFIG_USB_NET2272=m
CONFIG_USB_NET2272_DMA=y
CONFIG_USB_NET2280=m
CONFIG_USB_GOKU=m
CONFIG_USB_EG20T=m
CONFIG_USB_MAX3420_UDC=m
# CONFIG_USB_DUMMY_HCD is not set
# end of USB Peripheral Controller

CONFIG_USB_LIBCOMPOSITE=m
CONFIG_USB_F_ACM=m
CONFIG_USB_F_SS_LB=m
CONFIG_USB_U_SERIAL=m
CONFIG_USB_U_ETHER=m
CONFIG_USB_U_AUDIO=m
CONFIG_USB_F_SERIAL=m
CONFIG_USB_F_OBEX=m
CONFIG_USB_F_NCM=m
CONFIG_USB_F_ECM=m
CONFIG_USB_F_PHONET=m
CONFIG_USB_F_EEM=m
CONFIG_USB_F_SUBSET=m
CONFIG_USB_F_RNDIS=m
CONFIG_USB_F_MASS_STORAGE=m
CONFIG_USB_F_FS=m
CONFIG_USB_F_UAC1=m
CONFIG_USB_F_UAC1_LEGACY=m
CONFIG_USB_F_UAC2=m
CONFIG_USB_F_UVC=m
CONFIG_USB_F_MIDI=m
CONFIG_USB_F_HID=m
CONFIG_USB_F_PRINTER=m
CONFIG_USB_F_TCM=m
CONFIG_USB_CONFIGFS=m
CONFIG_USB_CONFIGFS_SERIAL=y
CONFIG_USB_CONFIGFS_ACM=y
CONFIG_USB_CONFIGFS_OBEX=y
CONFIG_USB_CONFIGFS_NCM=y
CONFIG_USB_CONFIGFS_ECM=y
CONFIG_USB_CONFIGFS_ECM_SUBSET=y
CONFIG_USB_CONFIGFS_RNDIS=y
CONFIG_USB_CONFIGFS_EEM=y
CONFIG_USB_CONFIGFS_PHONET=y
CONFIG_USB_CONFIGFS_MASS_STORAGE=y
CONFIG_USB_CONFIGFS_F_LB_SS=y
CONFIG_USB_CONFIGFS_F_FS=y
CONFIG_USB_CONFIGFS_F_UAC1=y
CONFIG_USB_CONFIGFS_F_UAC1_LEGACY=y
CONFIG_USB_CONFIGFS_F_UAC2=y
CONFIG_USB_CONFIGFS_F_MIDI=y
CONFIG_USB_CONFIGFS_F_HID=y
CONFIG_USB_CONFIGFS_F_UVC=y
CONFIG_USB_CONFIGFS_F_PRINTER=y
CONFIG_USB_CONFIGFS_F_TCM=y

#
# USB Gadget precomposed configurations
#
CONFIG_USB_ZERO=m
CONFIG_USB_AUDIO=m
CONFIG_GADGET_UAC1=y
# CONFIG_GADGET_UAC1_LEGACY is not set
CONFIG_USB_ETH=m
CONFIG_USB_ETH_RNDIS=y
CONFIG_USB_ETH_EEM=y
CONFIG_USB_G_NCM=m
CONFIG_USB_GADGETFS=m
CONFIG_USB_FUNCTIONFS=m
CONFIG_USB_FUNCTIONFS_ETH=y
CONFIG_USB_FUNCTIONFS_RNDIS=y
CONFIG_USB_FUNCTIONFS_GENERIC=y
CONFIG_USB_MASS_STORAGE=m
CONFIG_USB_GADGET_TARGET=m
CONFIG_USB_G_SERIAL=m
CONFIG_USB_MIDI_GADGET=m
CONFIG_USB_G_PRINTER=m
CONFIG_USB_CDC_COMPOSITE=m
CONFIG_USB_G_NOKIA=m
CONFIG_USB_G_ACM_MS=m
# CONFIG_USB_G_MULTI is not set
CONFIG_USB_G_HID=m
CONFIG_USB_G_DBGP=m
# CONFIG_USB_G_DBGP_PRINTK is not set
CONFIG_USB_G_DBGP_SERIAL=y
CONFIG_USB_G_WEBCAM=m
CONFIG_USB_RAW_GADGET=m
# end of USB Gadget precomposed configurations

CONFIG_TYPEC=m
CONFIG_TYPEC_TCPM=m
CONFIG_TYPEC_TCPCI=m
CONFIG_TYPEC_RT1711H=m
CONFIG_TYPEC_MT6360=m
CONFIG_TYPEC_TCPCI_MAXIM=m
CONFIG_TYPEC_FUSB302=m
# CONFIG_TYPEC_WCOVE is not set
CONFIG_TYPEC_UCSI=m
CONFIG_UCSI_CCG=m
CONFIG_UCSI_ACPI=m
CONFIG_TYPEC_TPS6598X=m
CONFIG_TYPEC_HD3SS3220=m
CONFIG_TYPEC_STUSB160X=m

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
CONFIG_TYPEC_MUX_PI3USB30532=m
CONFIG_TYPEC_MUX_INTEL_PMC=m
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
CONFIG_TYPEC_DP_ALTMODE=m
CONFIG_TYPEC_NVIDIA_ALTMODE=m
# end of USB Type-C Alternate Mode drivers

CONFIG_USB_ROLE_SWITCH=y
CONFIG_USB_ROLES_INTEL_XHCI=m
CONFIG_MMC=y
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set
CONFIG_MMC_CRYPTO=y

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
CONFIG_MMC_SDHCI_F_SDH30=m
CONFIG_MMC_WBSD=m
CONFIG_MMC_ALCOR=m
CONFIG_MMC_TIFM_SD=m
CONFIG_MMC_SPI=m
CONFIG_MMC_SDRICOH_CS=m
CONFIG_MMC_CB710=m
CONFIG_MMC_VIA_SDMMC=m
CONFIG_MMC_VUB300=m
CONFIG_MMC_USHC=m
CONFIG_MMC_USDHI6ROL0=m
CONFIG_MMC_REALTEK_PCI=m
CONFIG_MMC_REALTEK_USB=m
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_HSQ is not set
CONFIG_MMC_TOSHIBA_PCI=m
CONFIG_MMC_MTK=m
CONFIG_MMC_SDHCI_XENON=m
CONFIG_MEMSTICK=m
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
CONFIG_MSPRO_BLOCK=m
CONFIG_MS_BLOCK=m

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=m
CONFIG_MEMSTICK_JMICRON_38X=m
CONFIG_MEMSTICK_R592=m
CONFIG_MEMSTICK_REALTEK_PCI=m
CONFIG_MEMSTICK_REALTEK_USB=m
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=m
CONFIG_LEDS_CLASS_MULTICOLOR=m
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
CONFIG_LEDS_88PM860X=m
CONFIG_LEDS_APU=m
CONFIG_LEDS_LM3530=m
CONFIG_LEDS_LM3532=m
CONFIG_LEDS_LM3533=m
CONFIG_LEDS_LM3642=m
CONFIG_LEDS_MT6323=m
CONFIG_LEDS_PCA9532=m
CONFIG_LEDS_PCA9532_GPIO=y
CONFIG_LEDS_GPIO=m
CONFIG_LEDS_LP3944=m
CONFIG_LEDS_LP3952=m
CONFIG_LEDS_LP50XX=m
CONFIG_LEDS_LP8788=m
CONFIG_LEDS_CLEVO_MAIL=m
CONFIG_LEDS_PCA955X=m
CONFIG_LEDS_PCA955X_GPIO=y
CONFIG_LEDS_PCA963X=m
CONFIG_LEDS_WM831X_STATUS=m
CONFIG_LEDS_WM8350=m
CONFIG_LEDS_DA903X=m
CONFIG_LEDS_DA9052=m
CONFIG_LEDS_DAC124S085=m
CONFIG_LEDS_PWM=m
CONFIG_LEDS_REGULATOR=m
CONFIG_LEDS_BD2802=m
CONFIG_LEDS_INTEL_SS4200=m
CONFIG_LEDS_LT3593=m
CONFIG_LEDS_ADP5520=m
CONFIG_LEDS_MC13783=m
CONFIG_LEDS_TCA6507=m
CONFIG_LEDS_TLC591XX=m
CONFIG_LEDS_MAX8997=m
CONFIG_LEDS_LM355x=m
CONFIG_LEDS_MENF21BMC=m

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_MLXCPLD=m
CONFIG_LEDS_MLXREG=m
CONFIG_LEDS_USER=m
CONFIG_LEDS_NIC78BX=m
CONFIG_LEDS_TI_LMU_COMMON=m
CONFIG_LEDS_LM36274=m
CONFIG_LEDS_TPS6105X=m

#
# Flash and Torch LED drivers
#
CONFIG_LEDS_AS3645A=m
CONFIG_LEDS_LM3601X=m
CONFIG_LEDS_RT8515=m
CONFIG_LEDS_SGM3140=m

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
CONFIG_LEDS_TRIGGER_DISK=y
CONFIG_LEDS_TRIGGER_MTD=y
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
CONFIG_LEDS_TRIGGER_CPU=y
CONFIG_LEDS_TRIGGER_ACTIVITY=m
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
CONFIG_LEDS_TRIGGER_PANIC=y
CONFIG_LEDS_TRIGGER_NETDEV=m
CONFIG_LEDS_TRIGGER_PATTERN=m
CONFIG_LEDS_TRIGGER_AUDIO=m
CONFIG_LEDS_TRIGGER_TTY=m
# CONFIG_ACCESSIBILITY is not set
CONFIG_INFINIBAND=m
CONFIG_INFINIBAND_USER_MAD=m
CONFIG_INFINIBAND_USER_ACCESS=m
CONFIG_INFINIBAND_USER_MEM=y
CONFIG_INFINIBAND_ON_DEMAND_PAGING=y
CONFIG_INFINIBAND_ADDR_TRANS=y
CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS=y
CONFIG_INFINIBAND_VIRT_DMA=y
CONFIG_INFINIBAND_MTHCA=m
# CONFIG_INFINIBAND_MTHCA_DEBUG is not set
CONFIG_INFINIBAND_QIB=m
CONFIG_INFINIBAND_QIB_DCA=y
CONFIG_INFINIBAND_CXGB4=m
CONFIG_INFINIBAND_EFA=m
CONFIG_INFINIBAND_IRDMA=m
CONFIG_MLX4_INFINIBAND=m
CONFIG_MLX5_INFINIBAND=m
CONFIG_INFINIBAND_OCRDMA=m
CONFIG_INFINIBAND_VMWARE_PVRDMA=m
CONFIG_INFINIBAND_USNIC=m
CONFIG_INFINIBAND_BNXT_RE=m
CONFIG_INFINIBAND_HFI1=m
# CONFIG_HFI1_DEBUG_SDMA_ORDER is not set
# CONFIG_SDMA_VERBOSITY is not set
CONFIG_INFINIBAND_QEDR=m
CONFIG_INFINIBAND_RDMAVT=m
CONFIG_RDMA_RXE=m
CONFIG_RDMA_SIW=m
CONFIG_INFINIBAND_IPOIB=m
CONFIG_INFINIBAND_IPOIB_CM=y
# CONFIG_INFINIBAND_IPOIB_DEBUG is not set
CONFIG_INFINIBAND_SRP=m
CONFIG_INFINIBAND_SRPT=m
CONFIG_INFINIBAND_ISER=m
CONFIG_INFINIBAND_ISERT=m
CONFIG_INFINIBAND_RTRS=m
CONFIG_INFINIBAND_RTRS_CLIENT=m
CONFIG_INFINIBAND_RTRS_SERVER=m
CONFIG_INFINIBAND_OPA_VNIC=m
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
# CONFIG_EDAC_LEGACY_SYSFS is not set
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_DECODE_MCE=m
CONFIG_EDAC_GHES=y
CONFIG_EDAC_AMD64=m
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5000=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
CONFIG_EDAC_I10NM=m
CONFIG_EDAC_PND2=m
CONFIG_EDAC_IGEN6=m
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
CONFIG_RTC_SYSTOHC=y
CONFIG_RTC_SYSTOHC_DEVICE="rtc0"
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
CONFIG_RTC_DRV_88PM860X=m
CONFIG_RTC_DRV_88PM80X=m
CONFIG_RTC_DRV_ABB5ZES3=m
CONFIG_RTC_DRV_ABEOZ9=m
CONFIG_RTC_DRV_ABX80X=m
CONFIG_RTC_DRV_DS1307=m
CONFIG_RTC_DRV_DS1307_CENTURY=y
CONFIG_RTC_DRV_DS1374=m
CONFIG_RTC_DRV_DS1374_WDT=y
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_LP8788=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_MAX8907=m
CONFIG_RTC_DRV_MAX8925=m
CONFIG_RTC_DRV_MAX8998=m
CONFIG_RTC_DRV_MAX8997=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
CONFIG_RTC_DRV_PCF85063=m
CONFIG_RTC_DRV_PCF85363=m
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
CONFIG_RTC_DRV_PALMAS=m
CONFIG_RTC_DRV_TPS6586X=m
CONFIG_RTC_DRV_TPS65910=m
CONFIG_RTC_DRV_TPS80031=m
CONFIG_RTC_DRV_RC5T583=m
CONFIG_RTC_DRV_S35390A=m
CONFIG_RTC_DRV_FM3130=m
CONFIG_RTC_DRV_RX8010=m
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
CONFIG_RTC_DRV_RV3028=m
CONFIG_RTC_DRV_RV3032=m
CONFIG_RTC_DRV_RV8803=m
CONFIG_RTC_DRV_SD3078=m

#
# SPI RTC drivers
#
CONFIG_RTC_DRV_M41T93=m
CONFIG_RTC_DRV_M41T94=m
CONFIG_RTC_DRV_DS1302=m
CONFIG_RTC_DRV_DS1305=m
CONFIG_RTC_DRV_DS1343=m
CONFIG_RTC_DRV_DS1347=m
CONFIG_RTC_DRV_DS1390=m
CONFIG_RTC_DRV_MAX6916=m
CONFIG_RTC_DRV_R9701=m
CONFIG_RTC_DRV_RX4581=m
CONFIG_RTC_DRV_RS5C348=m
CONFIG_RTC_DRV_MAX6902=m
CONFIG_RTC_DRV_PCF2123=m
CONFIG_RTC_DRV_MCP795=m
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
CONFIG_RTC_DRV_PCF2127=m
CONFIG_RTC_DRV_RV3029C2=m
CONFIG_RTC_DRV_RV3029_HWMON=y
CONFIG_RTC_DRV_RX6110=m

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
CONFIG_RTC_DRV_DS1685_FAMILY=m
CONFIG_RTC_DRV_DS1685=y
# CONFIG_RTC_DRV_DS1689 is not set
# CONFIG_RTC_DRV_DS17285 is not set
# CONFIG_RTC_DRV_DS17485 is not set
# CONFIG_RTC_DRV_DS17885 is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_DA9052=m
CONFIG_RTC_DRV_DA9055=m
CONFIG_RTC_DRV_DA9063=m
CONFIG_RTC_DRV_STK17TA8=m
CONFIG_RTC_DRV_M48T86=m
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m
CONFIG_RTC_DRV_V3020=m
CONFIG_RTC_DRV_WM831X=m
CONFIG_RTC_DRV_WM8350=m
CONFIG_RTC_DRV_PCF50633=m
CONFIG_RTC_DRV_CROS_EC=m

#
# on-CPU RTC drivers
#
CONFIG_RTC_DRV_FTRTC010=m
CONFIG_RTC_DRV_PCAP=m
CONFIG_RTC_DRV_MC13XXX=m
CONFIG_RTC_DRV_MT6397=m

#
# HID Sensor RTC drivers
#
CONFIG_RTC_DRV_HID_SENSOR_TIME=m
CONFIG_RTC_DRV_GOLDFISH=m
CONFIG_RTC_DRV_WILCO_EC=m
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
CONFIG_ALTERA_MSGDMA=m
CONFIG_INTEL_IDMA64=m
CONFIG_INTEL_IDXD_BUS=m
CONFIG_INTEL_IDXD=m
# CONFIG_INTEL_IDXD_COMPAT is not set
CONFIG_INTEL_IDXD_SVM=y
CONFIG_INTEL_IDXD_PERFMON=y
CONFIG_INTEL_IOATDMA=m
CONFIG_PLX_DMA=m
CONFIG_AMD_PTDMA=m
CONFIG_QCOM_HIDMA_MGMT=m
CONFIG_QCOM_HIDMA=m
CONFIG_DW_DMAC_CORE=m
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=m
CONFIG_DW_EDMA=m
CONFIG_DW_EDMA_PCIE=m
CONFIG_HSU_DMA=m
CONFIG_SF_PDMA=m
CONFIG_INTEL_LDMA=y

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
# CONFIG_DMATEST is not set
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
CONFIG_UDMABUF=y
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
CONFIG_DMABUF_HEAPS=y
# CONFIG_DMABUF_SYSFS_STATS is not set
CONFIG_DMABUF_HEAPS_SYSTEM=y
# end of DMABUF options

CONFIG_DCA=m
CONFIG_AUXDISPLAY=y
CONFIG_CHARLCD=m
CONFIG_HD44780_COMMON=m
CONFIG_HD44780=m
CONFIG_KS0108=m
CONFIG_KS0108_PORT=0x378
CONFIG_KS0108_DELAY=2
CONFIG_CFAG12864B=m
CONFIG_CFAG12864B_RATE=20
CONFIG_IMG_ASCII_LCD=m
CONFIG_LCD2S=m
CONFIG_PARPORT_PANEL=m
CONFIG_PANEL_PARPORT=0
CONFIG_PANEL_PROFILE=5
# CONFIG_PANEL_CHANGE_MESSAGE is not set
# CONFIG_CHARLCD_BL_OFF is not set
# CONFIG_CHARLCD_BL_ON is not set
CONFIG_CHARLCD_BL_FLASH=y
CONFIG_PANEL=m
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
CONFIG_UIO_DMEM_GENIRQ=m
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
CONFIG_UIO_NETX=m
CONFIG_UIO_PRUSS=m
CONFIG_UIO_MF624=m
CONFIG_UIO_HV_GENERIC=m
CONFIG_UIO_DFL=m
CONFIG_VFIO=y
CONFIG_VFIO_IOMMU_TYPE1=y
CONFIG_VFIO_VIRQFD=y
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI_CORE=y
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI=y
CONFIG_VFIO_PCI_VGA=y
CONFIG_VFIO_PCI_IGD=y
CONFIG_VFIO_MDEV=m
CONFIG_IRQ_BYPASS_MANAGER=y
CONFIG_VIRT_DRIVERS=y
CONFIG_VBOXGUEST=m
CONFIG_NITRO_ENCLAVES=m
CONFIG_ACRN_HSM=m
CONFIG_VIRTIO=y
CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS=y
CONFIG_VIRTIO_PCI_LIB=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
CONFIG_VIRTIO_VDPA=m
CONFIG_VIRTIO_PMEM=m
CONFIG_VIRTIO_BALLOON=y
CONFIG_VIRTIO_MEM=m
CONFIG_VIRTIO_INPUT=m
CONFIG_VIRTIO_MMIO=y
CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=y
CONFIG_VIRTIO_DMA_SHARED_BUFFER=m
CONFIG_VDPA=m
CONFIG_VDPA_SIM=m
CONFIG_VDPA_SIM_NET=m
CONFIG_VDPA_SIM_BLOCK=m
CONFIG_VDPA_USER=m
CONFIG_IFCVF=m
CONFIG_MLX5_VDPA=y
CONFIG_MLX5_VDPA_NET=m
CONFIG_VP_VDPA=m
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST_RING=m
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
CONFIG_VHOST_SCSI=m
CONFIG_VHOST_VSOCK=m
CONFIG_VHOST_VDPA=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=m
CONFIG_HYPERV_TIMER=y
CONFIG_HYPERV_UTILS=m
CONFIG_HYPERV_BALLOON=m
# end of Microsoft Hyper-V guest support

#
# Xen driver support
#
CONFIG_XEN_BALLOON=y
CONFIG_XEN_BALLOON_MEMORY_HOTPLUG=y
CONFIG_XEN_MEMORY_HOTPLUG_LIMIT=512
CONFIG_XEN_SCRUB_PAGES_DEFAULT=y
CONFIG_XEN_DEV_EVTCHN=m
CONFIG_XEN_BACKEND=y
CONFIG_XENFS=m
CONFIG_XEN_COMPAT_XENFS=y
CONFIG_XEN_SYS_HYPERVISOR=y
CONFIG_XEN_XENBUS_FRONTEND=y
CONFIG_XEN_GNTDEV=m
CONFIG_XEN_GNTDEV_DMABUF=y
CONFIG_XEN_GRANT_DEV_ALLOC=m
CONFIG_XEN_GRANT_DMA_ALLOC=y
CONFIG_SWIOTLB_XEN=y
CONFIG_XEN_PCIDEV_BACKEND=m
CONFIG_XEN_PVCALLS_FRONTEND=m
# CONFIG_XEN_PVCALLS_BACKEND is not set
CONFIG_XEN_SCSI_BACKEND=m
CONFIG_XEN_PRIVCMD=m
CONFIG_XEN_ACPI_PROCESSOR=y
CONFIG_XEN_MCE_LOG=y
CONFIG_XEN_HAVE_PVMMU=y
CONFIG_XEN_EFI=y
CONFIG_XEN_AUTO_XLATE=y
CONFIG_XEN_ACPI=y
CONFIG_XEN_SYMS=y
CONFIG_XEN_HAVE_VPMU=y
CONFIG_XEN_FRONT_PGDIR_SHBUF=m
CONFIG_XEN_UNPOPULATED_ALLOC=y
# end of Xen driver support

CONFIG_GREYBUS=m
CONFIG_GREYBUS_ES2=m
CONFIG_COMEDI=m
# CONFIG_COMEDI_DEBUG is not set
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
CONFIG_COMEDI_MISC_DRIVERS=y
CONFIG_COMEDI_BOND=m
CONFIG_COMEDI_TEST=m
CONFIG_COMEDI_PARPORT=m
CONFIG_COMEDI_ISA_DRIVERS=y
CONFIG_COMEDI_PCL711=m
CONFIG_COMEDI_PCL724=m
CONFIG_COMEDI_PCL726=m
CONFIG_COMEDI_PCL730=m
CONFIG_COMEDI_PCL812=m
CONFIG_COMEDI_PCL816=m
CONFIG_COMEDI_PCL818=m
CONFIG_COMEDI_PCM3724=m
CONFIG_COMEDI_AMPLC_DIO200_ISA=m
CONFIG_COMEDI_AMPLC_PC236_ISA=m
CONFIG_COMEDI_AMPLC_PC263_ISA=m
CONFIG_COMEDI_RTI800=m
CONFIG_COMEDI_RTI802=m
CONFIG_COMEDI_DAC02=m
CONFIG_COMEDI_DAS16M1=m
CONFIG_COMEDI_DAS08_ISA=m
CONFIG_COMEDI_DAS16=m
CONFIG_COMEDI_DAS800=m
CONFIG_COMEDI_DAS1800=m
CONFIG_COMEDI_DAS6402=m
CONFIG_COMEDI_DT2801=m
CONFIG_COMEDI_DT2811=m
CONFIG_COMEDI_DT2814=m
CONFIG_COMEDI_DT2815=m
CONFIG_COMEDI_DT2817=m
CONFIG_COMEDI_DT282X=m
CONFIG_COMEDI_DMM32AT=m
CONFIG_COMEDI_FL512=m
CONFIG_COMEDI_AIO_AIO12_8=m
CONFIG_COMEDI_AIO_IIRO_16=m
CONFIG_COMEDI_II_PCI20KC=m
CONFIG_COMEDI_C6XDIGIO=m
CONFIG_COMEDI_MPC624=m
CONFIG_COMEDI_ADQ12B=m
CONFIG_COMEDI_NI_AT_A2150=m
CONFIG_COMEDI_NI_AT_AO=m
CONFIG_COMEDI_NI_ATMIO=m
CONFIG_COMEDI_NI_ATMIO16D=m
CONFIG_COMEDI_NI_LABPC_ISA=m
CONFIG_COMEDI_PCMAD=m
CONFIG_COMEDI_PCMDA12=m
CONFIG_COMEDI_PCMMIO=m
CONFIG_COMEDI_PCMUIO=m
CONFIG_COMEDI_MULTIQ3=m
CONFIG_COMEDI_S526=m
CONFIG_COMEDI_PCI_DRIVERS=m
CONFIG_COMEDI_8255_PCI=m
CONFIG_COMEDI_ADDI_WATCHDOG=m
CONFIG_COMEDI_ADDI_APCI_1032=m
CONFIG_COMEDI_ADDI_APCI_1500=m
CONFIG_COMEDI_ADDI_APCI_1516=m
CONFIG_COMEDI_ADDI_APCI_1564=m
CONFIG_COMEDI_ADDI_APCI_16XX=m
CONFIG_COMEDI_ADDI_APCI_2032=m
CONFIG_COMEDI_ADDI_APCI_2200=m
CONFIG_COMEDI_ADDI_APCI_3120=m
CONFIG_COMEDI_ADDI_APCI_3501=m
CONFIG_COMEDI_ADDI_APCI_3XXX=m
CONFIG_COMEDI_ADL_PCI6208=m
CONFIG_COMEDI_ADL_PCI7X3X=m
CONFIG_COMEDI_ADL_PCI8164=m
CONFIG_COMEDI_ADL_PCI9111=m
CONFIG_COMEDI_ADL_PCI9118=m
CONFIG_COMEDI_ADV_PCI1710=m
CONFIG_COMEDI_ADV_PCI1720=m
CONFIG_COMEDI_ADV_PCI1723=m
CONFIG_COMEDI_ADV_PCI1724=m
CONFIG_COMEDI_ADV_PCI1760=m
CONFIG_COMEDI_ADV_PCI_DIO=m
CONFIG_COMEDI_AMPLC_DIO200_PCI=m
CONFIG_COMEDI_AMPLC_PC236_PCI=m
CONFIG_COMEDI_AMPLC_PC263_PCI=m
CONFIG_COMEDI_AMPLC_PCI224=m
CONFIG_COMEDI_AMPLC_PCI230=m
CONFIG_COMEDI_CONTEC_PCI_DIO=m
CONFIG_COMEDI_DAS08_PCI=m
CONFIG_COMEDI_DT3000=m
CONFIG_COMEDI_DYNA_PCI10XX=m
CONFIG_COMEDI_GSC_HPDI=m
CONFIG_COMEDI_MF6X4=m
CONFIG_COMEDI_ICP_MULTI=m
CONFIG_COMEDI_DAQBOARD2000=m
CONFIG_COMEDI_JR3_PCI=m
CONFIG_COMEDI_KE_COUNTER=m
CONFIG_COMEDI_CB_PCIDAS64=m
CONFIG_COMEDI_CB_PCIDAS=m
CONFIG_COMEDI_CB_PCIDDA=m
CONFIG_COMEDI_CB_PCIMDAS=m
CONFIG_COMEDI_CB_PCIMDDA=m
CONFIG_COMEDI_ME4000=m
CONFIG_COMEDI_ME_DAQ=m
CONFIG_COMEDI_NI_6527=m
CONFIG_COMEDI_NI_65XX=m
CONFIG_COMEDI_NI_660X=m
CONFIG_COMEDI_NI_670X=m
CONFIG_COMEDI_NI_LABPC_PCI=m
CONFIG_COMEDI_NI_PCIDIO=m
CONFIG_COMEDI_NI_PCIMIO=m
CONFIG_COMEDI_RTD520=m
CONFIG_COMEDI_S626=m
CONFIG_COMEDI_MITE=m
CONFIG_COMEDI_NI_TIOCMD=m
CONFIG_COMEDI_PCMCIA_DRIVERS=m
CONFIG_COMEDI_CB_DAS16_CS=m
CONFIG_COMEDI_DAS08_CS=m
CONFIG_COMEDI_NI_DAQ_700_CS=m
CONFIG_COMEDI_NI_DAQ_DIO24_CS=m
CONFIG_COMEDI_NI_LABPC_CS=m
CONFIG_COMEDI_NI_MIO_CS=m
CONFIG_COMEDI_QUATECH_DAQP_CS=m
CONFIG_COMEDI_USB_DRIVERS=m
CONFIG_COMEDI_DT9812=m
CONFIG_COMEDI_NI_USB6501=m
CONFIG_COMEDI_USBDUX=m
CONFIG_COMEDI_USBDUXFAST=m
CONFIG_COMEDI_USBDUXSIGMA=m
CONFIG_COMEDI_VMK80XX=m
CONFIG_COMEDI_8254=m
CONFIG_COMEDI_8255=m
CONFIG_COMEDI_8255_SA=m
CONFIG_COMEDI_KCOMEDILIB=m
CONFIG_COMEDI_AMPLC_DIO200=m
CONFIG_COMEDI_AMPLC_PC236=m
CONFIG_COMEDI_DAS08=m
CONFIG_COMEDI_ISADMA=m
CONFIG_COMEDI_NI_LABPC=m
CONFIG_COMEDI_NI_LABPC_ISADMA=m
CONFIG_COMEDI_NI_TIO=m
CONFIG_COMEDI_NI_ROUTING=m
CONFIG_COMEDI_TESTS=m
CONFIG_COMEDI_TESTS_EXAMPLE=m
CONFIG_COMEDI_TESTS_NI_ROUTES=m
CONFIG_STAGING=y
CONFIG_PRISM2_USB=m
CONFIG_RTL8192U=m
CONFIG_RTLLIB=m
CONFIG_RTLLIB_CRYPTO_CCMP=m
CONFIG_RTLLIB_CRYPTO_TKIP=m
CONFIG_RTLLIB_CRYPTO_WEP=m
CONFIG_RTL8192E=m
CONFIG_RTL8723BS=m
CONFIG_R8712U=m
CONFIG_R8188EU=m
CONFIG_88EU_AP_MODE=y
CONFIG_RTS5208=m
CONFIG_VT6655=m
CONFIG_VT6656=m

#
# IIO staging drivers
#

#
# Accelerometers
#
CONFIG_ADIS16203=m
CONFIG_ADIS16240=m
# end of Accelerometers

#
# Analog to digital converters
#
CONFIG_AD7816=m
CONFIG_AD7280=m
# end of Analog to digital converters

#
# Analog digital bi-direction converters
#
CONFIG_ADT7316=m
CONFIG_ADT7316_SPI=m
CONFIG_ADT7316_I2C=m
# end of Analog digital bi-direction converters

#
# Capacitance to digital converters
#
CONFIG_AD7746=m
# end of Capacitance to digital converters

#
# Direct Digital Synthesis
#
CONFIG_AD9832=m
CONFIG_AD9834=m
# end of Direct Digital Synthesis

#
# Network Analyzer, Impedance Converters
#
CONFIG_AD5933=m
# end of Network Analyzer, Impedance Converters

#
# Active energy metering IC
#
CONFIG_ADE7854=m
CONFIG_ADE7854_I2C=m
CONFIG_ADE7854_SPI=m
# end of Active energy metering IC

#
# Resolver to digital converters
#
CONFIG_AD2S1210=m
# end of Resolver to digital converters
# end of IIO staging drivers

CONFIG_FB_SM750=m
CONFIG_STAGING_MEDIA=y
CONFIG_INTEL_ATOMISP=y
CONFIG_VIDEO_ATOMISP=m
# CONFIG_VIDEO_ATOMISP_ISP2401 is not set
CONFIG_VIDEO_ATOMISP_OV2722=m
CONFIG_VIDEO_ATOMISP_GC2235=m
CONFIG_VIDEO_ATOMISP_MSRLIST_HELPER=m
CONFIG_VIDEO_ATOMISP_MT9M114=m
CONFIG_VIDEO_ATOMISP_GC0310=m
CONFIG_VIDEO_ATOMISP_OV2680=m
CONFIG_VIDEO_ATOMISP_OV5693=m
CONFIG_VIDEO_ATOMISP_LM3554=m
CONFIG_VIDEO_ZORAN=m
CONFIG_VIDEO_ZORAN_DC30=m
CONFIG_VIDEO_ZORAN_ZR36060=m
CONFIG_VIDEO_ZORAN_BUZ=m
CONFIG_VIDEO_ZORAN_DC10=m
CONFIG_VIDEO_ZORAN_LML33=m
CONFIG_VIDEO_ZORAN_LML33R10=m
CONFIG_VIDEO_ZORAN_AVS6EYES=m
CONFIG_VIDEO_IPU3_IMGU=m
CONFIG_DVB_AV7110_IR=y
CONFIG_DVB_AV7110=m
CONFIG_DVB_AV7110_OSD=y
CONFIG_DVB_BUDGET_PATCH=m
CONFIG_DVB_SP8870=m

#
# Android
#
# CONFIG_ASHMEM is not set
# end of Android

CONFIG_LTE_GDM724X=m
CONFIG_FIREWIRE_SERIAL=m
CONFIG_FWTTY_MAX_TOTAL_PORTS=64
CONFIG_FWTTY_MAX_CARD_PORTS=32
CONFIG_GS_FPGABOOT=m
CONFIG_UNISYSSPAR=y
CONFIG_UNISYS_VISORNIC=m
CONFIG_UNISYS_VISORINPUT=m
CONFIG_UNISYS_VISORHBA=m
CONFIG_FB_TFT=m
CONFIG_FB_TFT_AGM1264K_FL=m
CONFIG_FB_TFT_BD663474=m
CONFIG_FB_TFT_HX8340BN=m
CONFIG_FB_TFT_HX8347D=m
CONFIG_FB_TFT_HX8353D=m
CONFIG_FB_TFT_HX8357D=m
CONFIG_FB_TFT_ILI9163=m
CONFIG_FB_TFT_ILI9320=m
CONFIG_FB_TFT_ILI9325=m
CONFIG_FB_TFT_ILI9340=m
CONFIG_FB_TFT_ILI9341=m
CONFIG_FB_TFT_ILI9481=m
CONFIG_FB_TFT_ILI9486=m
CONFIG_FB_TFT_PCD8544=m
CONFIG_FB_TFT_RA8875=m
CONFIG_FB_TFT_S6D02A1=m
CONFIG_FB_TFT_S6D1121=m
CONFIG_FB_TFT_SEPS525=m
CONFIG_FB_TFT_SH1106=m
CONFIG_FB_TFT_SSD1289=m
CONFIG_FB_TFT_SSD1305=m
CONFIG_FB_TFT_SSD1306=m
CONFIG_FB_TFT_SSD1331=m
CONFIG_FB_TFT_SSD1351=m
CONFIG_FB_TFT_ST7735R=m
CONFIG_FB_TFT_ST7789V=m
CONFIG_FB_TFT_TINYLCD=m
CONFIG_FB_TFT_TLS8204=m
CONFIG_FB_TFT_UC1611=m
CONFIG_FB_TFT_UC1701=m
CONFIG_FB_TFT_UPD161704=m
CONFIG_FB_TFT_WATTEROTT=m
CONFIG_MOST_COMPONENTS=m
CONFIG_MOST_NET=m
CONFIG_MOST_VIDEO=m
CONFIG_MOST_I2C=m
CONFIG_KS7010=m
CONFIG_GREYBUS_AUDIO=m
CONFIG_GREYBUS_AUDIO_APB_CODEC=m
CONFIG_GREYBUS_BOOTROM=m
CONFIG_GREYBUS_FIRMWARE=m
CONFIG_GREYBUS_HID=m
CONFIG_GREYBUS_LIGHT=m
CONFIG_GREYBUS_LOG=m
CONFIG_GREYBUS_LOOPBACK=m
CONFIG_GREYBUS_POWER=m
CONFIG_GREYBUS_RAW=m
CONFIG_GREYBUS_VIBRATOR=m
CONFIG_GREYBUS_BRIDGED_PHY=m
CONFIG_GREYBUS_GPIO=m
CONFIG_GREYBUS_I2C=m
CONFIG_GREYBUS_PWM=m
CONFIG_GREYBUS_SDIO=m
CONFIG_GREYBUS_SPI=m
CONFIG_GREYBUS_UART=m
CONFIG_GREYBUS_USB=m
CONFIG_PI433=m
CONFIG_FIELDBUS_DEV=m
CONFIG_QLGE=m
CONFIG_WFX=m
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
CONFIG_HUAWEI_WMI=m
CONFIG_UV_SYSFS=m
CONFIG_MXM_WMI=m
CONFIG_PEAQ_WMI=m
CONFIG_XIAOMI_WMI=m
CONFIG_GIGABYTE_WMI=m
CONFIG_ACERHDF=m
CONFIG_ACER_WIRELESS=m
CONFIG_ACER_WMI=m
CONFIG_AMD_PMC=m
CONFIG_ADV_SWBUTTON=m
CONFIG_APPLE_GMUX=m
CONFIG_ASUS_LAPTOP=m
CONFIG_ASUS_WIRELESS=m
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
CONFIG_MERAKI_MX100=m
CONFIG_EEEPC_LAPTOP=m
CONFIG_EEEPC_WMI=m
CONFIG_X86_PLATFORM_DRIVERS_DELL=y
CONFIG_ALIENWARE_WMI=m
CONFIG_DCDBAS=m
CONFIG_DELL_LAPTOP=m
CONFIG_DELL_RBU=m
CONFIG_DELL_RBTN=m
CONFIG_DELL_SMBIOS=m
CONFIG_DELL_SMBIOS_WMI=y
CONFIG_DELL_SMBIOS_SMM=y
CONFIG_DELL_SMO8800=m
CONFIG_DELL_WMI=m
CONFIG_DELL_WMI_PRIVACY=y
CONFIG_DELL_WMI_AIO=m
CONFIG_DELL_WMI_DESCRIPTOR=m
CONFIG_DELL_WMI_LED=m
CONFIG_DELL_WMI_SYSMAN=m
CONFIG_AMILO_RFKILL=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
CONFIG_GPD_POCKET_FAN=m
CONFIG_HP_ACCEL=m
CONFIG_WIRELESS_HOTKEY=m
CONFIG_HP_WMI=m
CONFIG_IBM_RTL=m
CONFIG_IDEAPAD_LAPTOP=m
CONFIG_SENSORS_HDAPS=m
CONFIG_THINKPAD_ACPI=m
CONFIG_THINKPAD_ACPI_ALSA_SUPPORT=y
CONFIG_THINKPAD_ACPI_DEBUGFACILITIES=y
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
CONFIG_THINKPAD_LMI=m
CONFIG_X86_PLATFORM_DRIVERS_INTEL=y
CONFIG_INTEL_ATOMISP2_PDX86=y
CONFIG_INTEL_ATOMISP2_LED=m
CONFIG_INTEL_SAR_INT1092=m
CONFIG_INTEL_CHT_INT33FE=m
CONFIG_INTEL_SKL_INT3472=m
CONFIG_INTEL_PMC_CORE=y
CONFIG_INTEL_PMT_CLASS=m
CONFIG_INTEL_PMT_TELEMETRY=m
CONFIG_INTEL_PMT_CRASHLOG=m

#
# Intel Speed Select Technology interface support
#
CONFIG_INTEL_SPEED_SELECT_INTERFACE=m
# end of Intel Speed Select Technology interface support

CONFIG_INTEL_TELEMETRY=m
CONFIG_INTEL_WMI=y
CONFIG_INTEL_WMI_SBL_FW_UPDATE=m
CONFIG_INTEL_WMI_THUNDERBOLT=m
CONFIG_INTEL_HID_EVENT=m
CONFIG_INTEL_VBTN=m
CONFIG_INTEL_INT0002_VGPIO=m
CONFIG_INTEL_OAKTRAIL=m
CONFIG_INTEL_BXTWC_PMIC_TMU=m
CONFIG_INTEL_CHTDC_TI_PWRBTN=m
CONFIG_INTEL_MRFLD_PWRBTN=m
CONFIG_INTEL_PUNIT_IPC=m
CONFIG_INTEL_RST=m
CONFIG_INTEL_SMARTCONNECT=m
CONFIG_INTEL_TURBO_MAX_3=y
CONFIG_INTEL_UNCORE_FREQ_CONTROL=m
CONFIG_MSI_LAPTOP=m
CONFIG_MSI_WMI=m
CONFIG_PCENGINES_APU2=m
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_SAMSUNG_Q10=m
CONFIG_ACPI_TOSHIBA=m
CONFIG_TOSHIBA_BT_RFKILL=m
CONFIG_TOSHIBA_HAPS=m
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
CONFIG_COMPAL_LAPTOP=m
CONFIG_LG_LAPTOP=m
CONFIG_PANASONIC_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
CONFIG_SYSTEM76_ACPI=m
CONFIG_TOPSTAR_LAPTOP=m
CONFIG_I2C_MULTI_INSTANTIATE=m
CONFIG_MLX_PLATFORM=m
CONFIG_TOUCHSCREEN_DMI=y
CONFIG_FW_ATTR_CLASS=m
CONFIG_INTEL_IPS=m
CONFIG_INTEL_SCU_IPC=y
CONFIG_INTEL_SCU=y
CONFIG_INTEL_SCU_PCI=y
CONFIG_INTEL_SCU_PLATFORM=m
CONFIG_INTEL_SCU_IPC_UTIL=m
CONFIG_PMC_ATOM=y
CONFIG_CHROME_PLATFORMS=y
CONFIG_CHROMEOS_LAPTOP=m
CONFIG_CHROMEOS_PSTORE=m
CONFIG_CHROMEOS_TBMC=m
CONFIG_CROS_EC=m
CONFIG_CROS_EC_I2C=m
CONFIG_CROS_EC_ISHTP=m
CONFIG_CROS_EC_SPI=m
CONFIG_CROS_EC_LPC=m
CONFIG_CROS_EC_PROTO=y
CONFIG_CROS_KBD_LED_BACKLIGHT=m
CONFIG_CROS_EC_CHARDEV=m
CONFIG_CROS_EC_LIGHTBAR=m
CONFIG_CROS_EC_DEBUGFS=m
CONFIG_CROS_EC_SENSORHUB=m
CONFIG_CROS_EC_SYSFS=m
CONFIG_CROS_EC_TYPEC=m
CONFIG_CROS_USBPD_LOGGER=m
CONFIG_CROS_USBPD_NOTIFY=m
CONFIG_WILCO_EC=m
CONFIG_WILCO_EC_DEBUGFS=m
CONFIG_WILCO_EC_EVENTS=m
CONFIG_WILCO_EC_TELEMETRY=m
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=m
CONFIG_MLXREG_IO=m
CONFIG_SURFACE_PLATFORMS=y
CONFIG_SURFACE3_WMI=m
CONFIG_SURFACE_3_BUTTON=m
CONFIG_SURFACE_3_POWER_OPREGION=m
CONFIG_SURFACE_ACPI_NOTIFY=m
CONFIG_SURFACE_AGGREGATOR_CDEV=m
CONFIG_SURFACE_AGGREGATOR_REGISTRY=m
CONFIG_SURFACE_DTX=m
CONFIG_SURFACE_GPE=m
CONFIG_SURFACE_HOTPLUG=m
CONFIG_SURFACE_PLATFORM_PROFILE=m
CONFIG_SURFACE_PRO3_BUTTON=m
CONFIG_SURFACE_AGGREGATOR=m
CONFIG_SURFACE_AGGREGATOR_BUS=y
# CONFIG_SURFACE_AGGREGATOR_ERROR_INJECTION is not set
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
CONFIG_COMMON_CLK_WM831X=m

#
# Clock driver for ARM Reference designs
#
CONFIG_ICST=y
CONFIG_CLK_SP810=y
# end of Clock driver for ARM Reference designs

CONFIG_LMK04832=m
CONFIG_COMMON_CLK_MAX9485=m
CONFIG_COMMON_CLK_SI5341=m
CONFIG_COMMON_CLK_SI5351=m
CONFIG_COMMON_CLK_SI544=m
CONFIG_COMMON_CLK_CDCE706=m
CONFIG_COMMON_CLK_CS2000_CP=m
CONFIG_CLK_TWL6040=m
CONFIG_COMMON_CLK_PALMAS=m
CONFIG_COMMON_CLK_PWM=m
CONFIG_XILINX_VCU=m
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
CONFIG_ALTERA_MBOX=m
CONFIG_IOMMU_IOVA=y
CONFIG_IOASID=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
CONFIG_IOMMU_IO_PGTABLE=y
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
CONFIG_IOMMU_DEFAULT_DMA_LAZY=y
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_DMA=y
CONFIG_IOMMU_SVA_LIB=y
CONFIG_AMD_IOMMU=y
CONFIG_AMD_IOMMU_V2=m
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
CONFIG_INTEL_IOMMU_SVM=y
CONFIG_INTEL_IOMMU_DEFAULT_ON=y
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON=y
CONFIG_IRQ_REMAP=y
CONFIG_HYPERV_IOMMU=y
CONFIG_VIRTIO_IOMMU=y

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y
CONFIG_REMOTEPROC_CDEV=y
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=m
CONFIG_RPMSG_CHAR=m
CONFIG_RPMSG_NS=m
CONFIG_RPMSG_QCOM_GLINK=m
CONFIG_RPMSG_QCOM_GLINK_RPM=m
CONFIG_RPMSG_VIRTIO=m
# end of Rpmsg drivers

CONFIG_SOUNDWIRE=m

#
# SoundWire Devices
#
CONFIG_SOUNDWIRE_CADENCE=m
CONFIG_SOUNDWIRE_INTEL=m
CONFIG_SOUNDWIRE_QCOM=m
CONFIG_SOUNDWIRE_GENERIC_ALLOCATION=m

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# end of Enable LiteX SoC Builder specific drivers

#
# Qualcomm SoC drivers
#
CONFIG_QCOM_QMI_HELPERS=m
# end of Qualcomm SoC drivers

CONFIG_SOC_TI=y

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
CONFIG_DEVFREQ_GOV_PERFORMANCE=y
CONFIG_DEVFREQ_GOV_POWERSAVE=y
CONFIG_DEVFREQ_GOV_USERSPACE=y
CONFIG_DEVFREQ_GOV_PASSIVE=y

#
# DEVFREQ Drivers
#
CONFIG_PM_DEVFREQ_EVENT=y
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_ADC_JACK=m
CONFIG_EXTCON_AXP288=m
CONFIG_EXTCON_FSA9480=m
CONFIG_EXTCON_GPIO=m
CONFIG_EXTCON_INTEL_INT3496=m
CONFIG_EXTCON_INTEL_CHT_WC=m
CONFIG_EXTCON_INTEL_MRFLD=m
CONFIG_EXTCON_MAX14577=m
CONFIG_EXTCON_MAX3355=m
CONFIG_EXTCON_MAX77693=m
CONFIG_EXTCON_MAX77843=m
CONFIG_EXTCON_MAX8997=m
CONFIG_EXTCON_PALMAS=m
CONFIG_EXTCON_PTN5150=m
CONFIG_EXTCON_RT8973A=m
CONFIG_EXTCON_SM5502=m
CONFIG_EXTCON_USB_GPIO=m
CONFIG_EXTCON_USBC_CROS_EC=m
CONFIG_EXTCON_USBC_TUSB320=m
CONFIG_MEMORY=y
CONFIG_FPGA_DFL_EMIF=m
CONFIG_IIO=m
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=m
CONFIG_IIO_BUFFER_DMA=m
CONFIG_IIO_BUFFER_DMAENGINE=m
CONFIG_IIO_BUFFER_HW_CONSUMER=m
CONFIG_IIO_KFIFO_BUF=m
CONFIG_IIO_TRIGGERED_BUFFER=m
CONFIG_IIO_CONFIGFS=m
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
CONFIG_IIO_SW_DEVICE=m
CONFIG_IIO_SW_TRIGGER=m
CONFIG_IIO_TRIGGERED_EVENT=m

#
# Accelerometers
#
CONFIG_ADIS16201=m
CONFIG_ADIS16209=m
CONFIG_ADXL372=m
CONFIG_ADXL372_SPI=m
CONFIG_ADXL372_I2C=m
CONFIG_BMA220=m
CONFIG_BMA400=m
CONFIG_BMA400_I2C=m
CONFIG_BMA400_SPI=m
CONFIG_BMC150_ACCEL=m
CONFIG_BMC150_ACCEL_I2C=m
CONFIG_BMC150_ACCEL_SPI=m
CONFIG_BMI088_ACCEL=m
CONFIG_BMI088_ACCEL_SPI=m
CONFIG_DA280=m
CONFIG_DA311=m
CONFIG_DMARD09=m
CONFIG_DMARD10=m
CONFIG_FXLS8962AF=m
CONFIG_FXLS8962AF_I2C=m
CONFIG_FXLS8962AF_SPI=m
CONFIG_HID_SENSOR_ACCEL_3D=m
CONFIG_IIO_CROS_EC_ACCEL_LEGACY=m
CONFIG_IIO_ST_ACCEL_3AXIS=m
CONFIG_IIO_ST_ACCEL_I2C_3AXIS=m
CONFIG_IIO_ST_ACCEL_SPI_3AXIS=m
CONFIG_KXSD9=m
CONFIG_KXSD9_SPI=m
CONFIG_KXSD9_I2C=m
CONFIG_KXCJK1013=m
CONFIG_MC3230=m
CONFIG_MMA7455=m
CONFIG_MMA7455_I2C=m
CONFIG_MMA7455_SPI=m
CONFIG_MMA7660=m
CONFIG_MMA8452=m
CONFIG_MMA9551_CORE=m
CONFIG_MMA9551=m
CONFIG_MMA9553=m
CONFIG_MXC4005=m
CONFIG_MXC6255=m
CONFIG_SCA3000=m
CONFIG_SCA3300=m
CONFIG_STK8312=m
CONFIG_STK8BA50=m
# end of Accelerometers

#
# Analog to digital converters
#
CONFIG_AD_SIGMA_DELTA=m
CONFIG_AD7091R5=m
CONFIG_AD7124=m
CONFIG_AD7192=m
CONFIG_AD7266=m
CONFIG_AD7291=m
CONFIG_AD7292=m
CONFIG_AD7298=m
CONFIG_AD7476=m
CONFIG_AD7606=m
CONFIG_AD7606_IFACE_PARALLEL=m
CONFIG_AD7606_IFACE_SPI=m
CONFIG_AD7766=m
CONFIG_AD7768_1=m
CONFIG_AD7780=m
CONFIG_AD7791=m
CONFIG_AD7793=m
CONFIG_AD7887=m
CONFIG_AD7923=m
CONFIG_AD7949=m
CONFIG_AD799X=m
CONFIG_AXP20X_ADC=m
CONFIG_AXP288_ADC=m
CONFIG_CC10001_ADC=m
CONFIG_DA9150_GPADC=m
CONFIG_DLN2_ADC=m
CONFIG_HI8435=m
CONFIG_HX711=m
CONFIG_INA2XX_ADC=m
CONFIG_INTEL_MRFLD_ADC=m
CONFIG_LP8788_ADC=m
CONFIG_LTC2471=m
CONFIG_LTC2485=m
CONFIG_LTC2496=m
CONFIG_LTC2497=m
CONFIG_MAX1027=m
CONFIG_MAX11100=m
CONFIG_MAX1118=m
CONFIG_MAX1241=m
CONFIG_MAX1363=m
CONFIG_MAX9611=m
CONFIG_MCP320X=m
CONFIG_MCP3422=m
CONFIG_MCP3911=m
CONFIG_MEDIATEK_MT6360_ADC=m
CONFIG_MEN_Z188_ADC=m
CONFIG_MP2629_ADC=m
CONFIG_NAU7802=m
CONFIG_PALMAS_GPADC=m
CONFIG_QCOM_VADC_COMMON=m
CONFIG_QCOM_SPMI_IADC=m
CONFIG_QCOM_SPMI_VADC=m
CONFIG_QCOM_SPMI_ADC5=m
CONFIG_STX104=m
CONFIG_TI_ADC081C=m
CONFIG_TI_ADC0832=m
CONFIG_TI_ADC084S021=m
CONFIG_TI_ADC12138=m
CONFIG_TI_ADC108S102=m
CONFIG_TI_ADC128S052=m
CONFIG_TI_ADC161S626=m
CONFIG_TI_ADS1015=m
CONFIG_TI_ADS7950=m
CONFIG_TI_ADS131E08=m
CONFIG_TI_AM335X_ADC=m
CONFIG_TI_TLC4541=m
CONFIG_TI_TSC2046=m
CONFIG_TWL4030_MADC=m
CONFIG_TWL6030_GPADC=m
CONFIG_VIPERBOARD_ADC=m
CONFIG_XILINX_XADC=m
# end of Analog to digital converters

#
# Analog Front Ends
#
# end of Analog Front Ends

#
# Amplifiers
#
CONFIG_AD8366=m
CONFIG_HMC425=m
# end of Amplifiers

#
# Capacitance to digital converters
#
CONFIG_AD7150=m
# end of Capacitance to digital converters

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=m
CONFIG_ATLAS_EZO_SENSOR=m
CONFIG_BME680=m
CONFIG_BME680_I2C=m
CONFIG_BME680_SPI=m
CONFIG_CCS811=m
CONFIG_IAQCORE=m
CONFIG_PMS7003=m
CONFIG_SCD30_CORE=m
CONFIG_SCD30_I2C=m
CONFIG_SCD30_SERIAL=m
CONFIG_SENSIRION_SGP30=m
CONFIG_SENSIRION_SGP40=m
CONFIG_SPS30=m
CONFIG_SPS30_I2C=m
CONFIG_SPS30_SERIAL=m
CONFIG_VZ89X=m
# end of Chemical Sensors

CONFIG_IIO_CROS_EC_SENSORS_CORE=m
CONFIG_IIO_CROS_EC_SENSORS=m
CONFIG_IIO_CROS_EC_SENSORS_LID_ANGLE=m

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=m
CONFIG_HID_SENSOR_IIO_TRIGGER=m
# end of Hid Sensor IIO Common

CONFIG_IIO_MS_SENSORS_I2C=m

#
# IIO SCMI Sensors
#
# end of IIO SCMI Sensors

#
# SSP Sensor Common
#
CONFIG_IIO_SSP_SENSORS_COMMONS=m
CONFIG_IIO_SSP_SENSORHUB=m
# end of SSP Sensor Common

CONFIG_IIO_ST_SENSORS_I2C=m
CONFIG_IIO_ST_SENSORS_SPI=m
CONFIG_IIO_ST_SENSORS_CORE=m

#
# Digital to analog converters
#
CONFIG_AD5064=m
CONFIG_AD5360=m
CONFIG_AD5380=m
CONFIG_AD5421=m
CONFIG_AD5446=m
CONFIG_AD5449=m
CONFIG_AD5592R_BASE=m
CONFIG_AD5592R=m
CONFIG_AD5593R=m
CONFIG_AD5504=m
CONFIG_AD5624R_SPI=m
CONFIG_AD5686=m
CONFIG_AD5686_SPI=m
CONFIG_AD5696_I2C=m
CONFIG_AD5755=m
CONFIG_AD5758=m
CONFIG_AD5761=m
CONFIG_AD5764=m
CONFIG_AD5766=m
CONFIG_AD5770R=m
CONFIG_AD5791=m
CONFIG_AD7303=m
CONFIG_AD8801=m
CONFIG_CIO_DAC=m
CONFIG_DS4424=m
CONFIG_LTC1660=m
CONFIG_LTC2632=m
CONFIG_M62332=m
CONFIG_MAX517=m
CONFIG_MCP4725=m
CONFIG_MCP4922=m
CONFIG_TI_DAC082S085=m
CONFIG_TI_DAC5571=m
CONFIG_TI_DAC7311=m
CONFIG_TI_DAC7612=m
# end of Digital to analog converters

#
# IIO dummy driver
#
CONFIG_IIO_SIMPLE_DUMMY=m
# CONFIG_IIO_SIMPLE_DUMMY_EVENTS is not set
# CONFIG_IIO_SIMPLE_DUMMY_BUFFER is not set
# end of IIO dummy driver

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
CONFIG_AD9523=m
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
CONFIG_ADF4350=m
CONFIG_ADF4371=m
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
CONFIG_ADIS16080=m
CONFIG_ADIS16130=m
CONFIG_ADIS16136=m
CONFIG_ADIS16260=m
CONFIG_ADXRS290=m
CONFIG_ADXRS450=m
CONFIG_BMG160=m
CONFIG_BMG160_I2C=m
CONFIG_BMG160_SPI=m
CONFIG_FXAS21002C=m
CONFIG_FXAS21002C_I2C=m
CONFIG_FXAS21002C_SPI=m
CONFIG_HID_SENSOR_GYRO_3D=m
CONFIG_MPU3050=m
CONFIG_MPU3050_I2C=m
CONFIG_IIO_ST_GYRO_3AXIS=m
CONFIG_IIO_ST_GYRO_I2C_3AXIS=m
CONFIG_IIO_ST_GYRO_SPI_3AXIS=m
CONFIG_ITG3200=m
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
CONFIG_AFE4403=m
CONFIG_AFE4404=m
CONFIG_MAX30100=m
CONFIG_MAX30102=m
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
CONFIG_AM2315=m
CONFIG_DHT11=m
CONFIG_HDC100X=m
CONFIG_HDC2010=m
CONFIG_HID_SENSOR_HUMIDITY=m
CONFIG_HTS221=m
CONFIG_HTS221_I2C=m
CONFIG_HTS221_SPI=m
CONFIG_HTU21=m
CONFIG_SI7005=m
CONFIG_SI7020=m
# end of Humidity sensors

#
# Inertial measurement units
#
CONFIG_ADIS16400=m
CONFIG_ADIS16460=m
CONFIG_ADIS16475=m
CONFIG_ADIS16480=m
CONFIG_BMI160=m
CONFIG_BMI160_I2C=m
CONFIG_BMI160_SPI=m
CONFIG_FXOS8700=m
CONFIG_FXOS8700_I2C=m
CONFIG_FXOS8700_SPI=m
CONFIG_KMX61=m
CONFIG_INV_ICM42600=m
CONFIG_INV_ICM42600_I2C=m
CONFIG_INV_ICM42600_SPI=m
CONFIG_INV_MPU6050_IIO=m
CONFIG_INV_MPU6050_I2C=m
CONFIG_INV_MPU6050_SPI=m
CONFIG_IIO_ST_LSM6DSX=m
CONFIG_IIO_ST_LSM6DSX_I2C=m
CONFIG_IIO_ST_LSM6DSX_SPI=m
CONFIG_IIO_ST_LSM6DSX_I3C=m
CONFIG_IIO_ST_LSM9DS0=m
CONFIG_IIO_ST_LSM9DS0_I2C=m
CONFIG_IIO_ST_LSM9DS0_SPI=m
# end of Inertial measurement units

CONFIG_IIO_ADIS_LIB=m
CONFIG_IIO_ADIS_LIB_BUFFER=y

#
# Light sensors
#
CONFIG_ACPI_ALS=m
CONFIG_ADJD_S311=m
CONFIG_ADUX1020=m
CONFIG_AL3010=m
CONFIG_AL3320A=m
CONFIG_APDS9300=m
CONFIG_APDS9960=m
CONFIG_AS73211=m
CONFIG_BH1750=m
CONFIG_BH1780=m
CONFIG_CM32181=m
CONFIG_CM3232=m
CONFIG_CM3323=m
CONFIG_CM36651=m
CONFIG_IIO_CROS_EC_LIGHT_PROX=m
CONFIG_GP2AP002=m
CONFIG_GP2AP020A00F=m
CONFIG_IQS621_ALS=m
CONFIG_SENSORS_ISL29018=m
CONFIG_SENSORS_ISL29028=m
CONFIG_ISL29125=m
CONFIG_HID_SENSOR_ALS=m
CONFIG_HID_SENSOR_PROX=m
CONFIG_JSA1212=m
CONFIG_RPR0521=m
CONFIG_SENSORS_LM3533=m
CONFIG_LTR501=m
CONFIG_LV0104CS=m
CONFIG_MAX44000=m
CONFIG_MAX44009=m
CONFIG_NOA1305=m
CONFIG_OPT3001=m
CONFIG_PA12203001=m
CONFIG_SI1133=m
CONFIG_SI1145=m
CONFIG_STK3310=m
CONFIG_ST_UVIS25=m
CONFIG_ST_UVIS25_I2C=m
CONFIG_ST_UVIS25_SPI=m
CONFIG_TCS3414=m
CONFIG_TCS3472=m
CONFIG_SENSORS_TSL2563=m
CONFIG_TSL2583=m
CONFIG_TSL2591=m
CONFIG_TSL2772=m
CONFIG_TSL4531=m
CONFIG_US5182D=m
CONFIG_VCNL4000=m
CONFIG_VCNL4035=m
CONFIG_VEML6030=m
CONFIG_VEML6070=m
CONFIG_VL6180=m
CONFIG_ZOPT2201=m
# end of Light sensors

#
# Magnetometer sensors
#
CONFIG_AK8975=m
CONFIG_AK09911=m
CONFIG_BMC150_MAGN=m
CONFIG_BMC150_MAGN_I2C=m
CONFIG_BMC150_MAGN_SPI=m
CONFIG_MAG3110=m
CONFIG_HID_SENSOR_MAGNETOMETER_3D=m
CONFIG_MMC35240=m
CONFIG_IIO_ST_MAGN_3AXIS=m
CONFIG_IIO_ST_MAGN_I2C_3AXIS=m
CONFIG_IIO_ST_MAGN_SPI_3AXIS=m
CONFIG_SENSORS_HMC5843=m
CONFIG_SENSORS_HMC5843_I2C=m
CONFIG_SENSORS_HMC5843_SPI=m
CONFIG_SENSORS_RM3100=m
CONFIG_SENSORS_RM3100_I2C=m
CONFIG_SENSORS_RM3100_SPI=m
CONFIG_YAMAHA_YAS530=m
# end of Magnetometer sensors

#
# Multiplexers
#
# end of Multiplexers

#
# Inclinometer sensors
#
CONFIG_HID_SENSOR_INCLINOMETER_3D=m
CONFIG_HID_SENSOR_DEVICE_ROTATION=m
# end of Inclinometer sensors

#
# Triggers - standalone
#
CONFIG_IIO_HRTIMER_TRIGGER=m
CONFIG_IIO_INTERRUPT_TRIGGER=m
CONFIG_IIO_TIGHTLOOP_TRIGGER=m
CONFIG_IIO_SYSFS_TRIGGER=m
# end of Triggers - standalone

#
# Linear and angular position sensors
#
CONFIG_IQS624_POS=m
CONFIG_HID_SENSOR_CUSTOM_INTEL_HINGE=m
# end of Linear and angular position sensors

#
# Digital potentiometers
#
CONFIG_AD5110=m
CONFIG_AD5272=m
CONFIG_DS1803=m
CONFIG_MAX5432=m
CONFIG_MAX5481=m
CONFIG_MAX5487=m
CONFIG_MCP4018=m
CONFIG_MCP4131=m
CONFIG_MCP4531=m
CONFIG_MCP41010=m
CONFIG_TPL0102=m
# end of Digital potentiometers

#
# Digital potentiostats
#
CONFIG_LMP91000=m
# end of Digital potentiostats

#
# Pressure sensors
#
CONFIG_ABP060MG=m
CONFIG_BMP280=m
CONFIG_BMP280_I2C=m
CONFIG_BMP280_SPI=m
CONFIG_IIO_CROS_EC_BARO=m
CONFIG_DLHL60D=m
CONFIG_DPS310=m
CONFIG_HID_SENSOR_PRESS=m
CONFIG_HP03=m
CONFIG_ICP10100=m
CONFIG_MPL115=m
CONFIG_MPL115_I2C=m
CONFIG_MPL115_SPI=m
CONFIG_MPL3115=m
CONFIG_MS5611=m
CONFIG_MS5611_I2C=m
CONFIG_MS5611_SPI=m
CONFIG_MS5637=m
CONFIG_IIO_ST_PRESS=m
CONFIG_IIO_ST_PRESS_I2C=m
CONFIG_IIO_ST_PRESS_SPI=m
CONFIG_T5403=m
CONFIG_HP206C=m
CONFIG_ZPA2326=m
CONFIG_ZPA2326_I2C=m
CONFIG_ZPA2326_SPI=m
# end of Pressure sensors

#
# Lightning sensors
#
CONFIG_AS3935=m
# end of Lightning sensors

#
# Proximity and distance sensors
#
CONFIG_CROS_EC_MKBP_PROXIMITY=m
CONFIG_ISL29501=m
CONFIG_LIDAR_LITE_V2=m
CONFIG_MB1232=m
CONFIG_PING=m
CONFIG_RFD77402=m
CONFIG_SRF04=m
CONFIG_SX9310=m
CONFIG_SX9500=m
CONFIG_SRF08=m
CONFIG_VCNL3020=m
CONFIG_VL53L0X_I2C=m
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
CONFIG_AD2S90=m
CONFIG_AD2S1200=m
# end of Resolver to digital converters

#
# Temperature sensors
#
CONFIG_IQS620AT_TEMP=m
CONFIG_LTC2983=m
CONFIG_MAXIM_THERMOCOUPLE=m
CONFIG_HID_SENSOR_TEMP=m
CONFIG_MLX90614=m
CONFIG_MLX90632=m
CONFIG_TMP006=m
CONFIG_TMP007=m
CONFIG_TMP117=m
CONFIG_TSYS01=m
CONFIG_TSYS02D=m
CONFIG_MAX31856=m
# end of Temperature sensors

CONFIG_NTB=m
CONFIG_NTB_MSI=y
# CONFIG_NTB_AMD is not set
CONFIG_NTB_IDT=m
CONFIG_NTB_INTEL=m
CONFIG_NTB_EPF=m
CONFIG_NTB_SWITCHTEC=m
CONFIG_NTB_PINGPONG=m
CONFIG_NTB_TOOL=m
CONFIG_NTB_PERF=m
# CONFIG_NTB_MSI_TEST is not set
CONFIG_NTB_TRANSPORT=m
CONFIG_VME_BUS=y

#
# VME Bridge Drivers
#
CONFIG_VME_CA91CX42=m
CONFIG_VME_TSI148=m
CONFIG_VME_FAKE=m

#
# VME Board Drivers
#
CONFIG_VMIVME_7805=m

#
# VME Device Drivers
#
CONFIG_VME_USER=m
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
CONFIG_PWM_CRC=y
CONFIG_PWM_CROS_EC=m
CONFIG_PWM_DWC=m
CONFIG_PWM_IQS620A=m
CONFIG_PWM_LP3943=m
CONFIG_PWM_LPSS=y
CONFIG_PWM_LPSS_PCI=y
CONFIG_PWM_LPSS_PLATFORM=y
CONFIG_PWM_PCA9685=m
CONFIG_PWM_TWL=m
CONFIG_PWM_TWL_LED=m

#
# IRQ chip support
#
CONFIG_MADERA_IRQ=m
# end of IRQ chip support

CONFIG_IPACK_BUS=m
CONFIG_BOARD_TPCI200=m
CONFIG_SERIAL_IPOCTAL=m
CONFIG_RESET_CONTROLLER=y
CONFIG_RESET_TI_SYSCON=m

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_USB_LGM_PHY=m
CONFIG_PHY_CAN_TRANSCEIVER=m
CONFIG_BCM_KONA_USB2_PHY=m
CONFIG_PHY_PXA_28NM_HSIC=m
CONFIG_PHY_PXA_28NM_USB2=m
CONFIG_PHY_CPCAP_USB=m
CONFIG_PHY_QCOM_USB_HS=m
CONFIG_PHY_QCOM_USB_HSIC=m
CONFIG_PHY_SAMSUNG_USB2=m
CONFIG_PHY_TUSB1210=m
CONFIG_PHY_INTEL_LGM_EMMC=m
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
CONFIG_IDLE_INJECT=y
CONFIG_DTPM=y
CONFIG_DTPM_CPU=y
CONFIG_MCB=m
CONFIG_MCB_PCI=m
CONFIG_MCB_LPC=m

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
CONFIG_RAS_CEC=y
# CONFIG_RAS_CEC_DEBUG is not set
CONFIG_USB4=m
# CONFIG_USB4_DEBUGFS_WRITE is not set
# CONFIG_USB4_DMA_TEST is not set

#
# Android
#
CONFIG_ANDROID=y
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_LIBNVDIMM=y
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_BLK=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
CONFIG_DAX_DRIVER=y
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_HMEM=m
CONFIG_DEV_DAX_HMEM_DEVICES=y
CONFIG_DEV_DAX_KMEM=m
CONFIG_DEV_DAX_PMEM_COMPAT=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
CONFIG_NVMEM_SPMI_SDAM=m
CONFIG_RAVE_SP_EEPROM=m
CONFIG_NVMEM_RMEM=m

#
# HW tracing support
#
CONFIG_STM=m
CONFIG_STM_PROTO_BASIC=m
CONFIG_STM_PROTO_SYS_T=m
CONFIG_STM_DUMMY=m
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_STM_SOURCE_HEARTBEAT=m
CONFIG_STM_SOURCE_FTRACE=m
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
CONFIG_INTEL_TH_ACPI=m
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_STH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

CONFIG_FPGA=m
CONFIG_ALTERA_PR_IP_CORE=m
CONFIG_FPGA_MGR_ALTERA_PS_SPI=m
CONFIG_FPGA_MGR_ALTERA_CVP=m
CONFIG_FPGA_MGR_XILINX_SPI=m
CONFIG_FPGA_MGR_MACHXO2_SPI=m
CONFIG_FPGA_BRIDGE=m
CONFIG_ALTERA_FREEZE_BRIDGE=m
CONFIG_XILINX_PR_DECOUPLER=m
CONFIG_FPGA_REGION=m
CONFIG_FPGA_DFL=m
CONFIG_FPGA_DFL_FME=m
CONFIG_FPGA_DFL_FME_MGR=m
CONFIG_FPGA_DFL_FME_BRIDGE=m
CONFIG_FPGA_DFL_FME_REGION=m
CONFIG_FPGA_DFL_AFU=m
CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000=m
CONFIG_FPGA_DFL_PCI=m
CONFIG_TEE=m

#
# TEE drivers
#
CONFIG_AMDTEE=m
# end of TEE drivers

CONFIG_MULTIPLEXER=m

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=m
CONFIG_MUX_ADGS1408=m
CONFIG_MUX_GPIO=m
# end of Multiplexer drivers

CONFIG_PM_OPP=y
CONFIG_UNISYS_VISORBUS=m
CONFIG_SIOX=m
CONFIG_SIOX_BUS_GPIO=m
CONFIG_SLIMBUS=m
CONFIG_SLIM_QCOM_CTRL=m
CONFIG_INTERCONNECT=y
CONFIG_COUNTER=m
CONFIG_104_QUAD_8=m
CONFIG_INTERRUPT_CNT=m
CONFIG_INTEL_QEP=m
CONFIG_MOST=m
CONFIG_MOST_USB_HDM=m
CONFIG_MOST_CDEV=m
CONFIG_MOST_SND=m
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_VALIDATE_FS_PARSER=y
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=m
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
CONFIG_REISERFS_FS_XATTR=y
CONFIG_REISERFS_FS_POSIX_ACL=y
CONFIG_REISERFS_FS_SECURITY=y
CONFIG_JFS_FS=m
CONFIG_JFS_POSIX_ACL=y
CONFIG_JFS_SECURITY=y
# CONFIG_JFS_DEBUG is not set
CONFIG_JFS_STATISTICS=y
CONFIG_XFS_FS=m
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
# CONFIG_XFS_ONLINE_SCRUB is not set
# CONFIG_XFS_WARN is not set
# CONFIG_XFS_DEBUG is not set
CONFIG_GFS2_FS=m
CONFIG_GFS2_FS_LOCKING_DLM=y
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
CONFIG_NILFS2_FS=m
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
CONFIG_F2FS_FS_SECURITY=y
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
CONFIG_F2FS_FS_COMPRESSION=y
CONFIG_F2FS_FS_LZO=y
CONFIG_F2FS_FS_LZORLE=y
CONFIG_F2FS_FS_LZ4=y
CONFIG_F2FS_FS_LZ4HC=y
CONFIG_F2FS_FS_ZSTD=y
# CONFIG_F2FS_IOSTAT is not set
CONFIG_ZONEFS_FS=m
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
CONFIG_FS_ENCRYPTION_INLINE_CRYPT=y
CONFIG_FS_VERITY=y
# CONFIG_FS_VERITY_DEBUG is not set
CONFIG_FS_VERITY_BUILTIN_SIGNATURES=y
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
# CONFIG_PRINT_QUOTA_WARNING is not set
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=m
CONFIG_QFMT_V1=m
CONFIG_QFMT_V2=m
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=m
CONFIG_AUTOFS_FS=m
CONFIG_FUSE_FS=y
CONFIG_CUSE=m
CONFIG_VIRTIO_FS=m
CONFIG_FUSE_DAX=y
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
# CONFIG_OVERLAY_FS_INDEX is not set
CONFIG_OVERLAY_FS_XINO_AUTO=y
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=m
CONFIG_NETFS_STATS=y
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_DEBUG is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_FAT_DEFAULT_UTF8 is not set
CONFIG_EXFAT_FS=m
CONFIG_EXFAT_DEFAULT_IOCHARSET="utf8"
CONFIG_NTFS_FS=m
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set
CONFIG_NTFS3_FS=m
# CONFIG_NTFS3_64BIT_CLUSTER is not set
CONFIG_NTFS3_LZX_XPRESS=y
CONFIG_NTFS3_FS_POSIX_ACL=y
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
CONFIG_PROC_VMCORE_DEVICE_DUMP=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_PROC_CPU_RESCTRL=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
CONFIG_TMPFS_INODE64=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_HUGETLB_PAGE_FREE_VMEMMAP=y
# CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON is not set
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
CONFIG_ORANGEFS_FS=m
CONFIG_ADFS_FS=m
# CONFIG_ADFS_FS_RW is not set
CONFIG_AFFS_FS=m
CONFIG_ECRYPT_FS=y
CONFIG_ECRYPT_FS_MESSAGING=y
CONFIG_HFS_FS=m
CONFIG_HFSPLUS_FS=m
CONFIG_BEFS_FS=m
# CONFIG_BEFS_DEBUG is not set
CONFIG_BFS_FS=m
CONFIG_EFS_FS=m
CONFIG_JFFS2_FS=m
CONFIG_JFFS2_FS_DEBUG=0
CONFIG_JFFS2_FS_WRITEBUFFER=y
# CONFIG_JFFS2_FS_WBUF_VERIFY is not set
# CONFIG_JFFS2_SUMMARY is not set
CONFIG_JFFS2_FS_XATTR=y
CONFIG_JFFS2_FS_POSIX_ACL=y
CONFIG_JFFS2_FS_SECURITY=y
CONFIG_JFFS2_COMPRESSION_OPTIONS=y
CONFIG_JFFS2_ZLIB=y
CONFIG_JFFS2_LZO=y
CONFIG_JFFS2_RTIME=y
# CONFIG_JFFS2_RUBIN is not set
# CONFIG_JFFS2_CMODE_NONE is not set
# CONFIG_JFFS2_CMODE_PRIORITY is not set
# CONFIG_JFFS2_CMODE_SIZE is not set
CONFIG_JFFS2_CMODE_FAVOURLZO=y
CONFIG_UBIFS_FS=m
# CONFIG_UBIFS_FS_ADVANCED_COMPR is not set
CONFIG_UBIFS_FS_LZO=y
CONFIG_UBIFS_FS_ZLIB=y
CONFIG_UBIFS_FS_ZSTD=y
# CONFIG_UBIFS_ATIME_SUPPORT is not set
CONFIG_UBIFS_FS_XATTR=y
CONFIG_UBIFS_FS_SECURITY=y
CONFIG_UBIFS_FS_AUTHENTICATION=y
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
CONFIG_CRAMFS_MTD=y
CONFIG_SQUASHFS=y
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
CONFIG_SQUASHFS_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
CONFIG_SQUASHFS_LZ4=y
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
CONFIG_SQUASHFS_ZSTD=y
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
CONFIG_VXFS_FS=m
CONFIG_MINIX_FS=m
CONFIG_OMFS_FS=m
CONFIG_HPFS_FS=m
CONFIG_QNX4FS_FS=m
CONFIG_QNX6FS_FS=m
# CONFIG_QNX6FS_DEBUG is not set
CONFIG_ROMFS_FS=m
CONFIG_ROMFS_BACKED_BY_BLOCK=y
# CONFIG_ROMFS_BACKED_BY_MTD is not set
# CONFIG_ROMFS_BACKED_BY_BOTH is not set
CONFIG_ROMFS_ON_BLOCK=y
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
# CONFIG_PSTORE_CONSOLE is not set
# CONFIG_PSTORE_PMSG is not set
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
CONFIG_PSTORE_ZONE=m
CONFIG_PSTORE_BLK=m
CONFIG_PSTORE_BLK_BLKDEV=""
CONFIG_PSTORE_BLK_KMSG_SIZE=64
CONFIG_PSTORE_BLK_MAX_REASON=2
CONFIG_SYSV_FS=m
CONFIG_UFS_FS=m
# CONFIG_UFS_FS_WRITE is not set
# CONFIG_UFS_DEBUG is not set
CONFIG_EROFS_FS=m
# CONFIG_EROFS_FS_DEBUG is not set
CONFIG_EROFS_FS_XATTR=y
CONFIG_EROFS_FS_POSIX_ACL=y
CONFIG_EROFS_FS_SECURITY=y
CONFIG_EROFS_FS_ZIP=y
CONFIG_VBOXSF_FS=m
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=m
CONFIG_NFS_V2=m
CONFIG_NFS_V3=m
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
CONFIG_NFS_SWAP=y
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
CONFIG_NFS_V4_1_MIGRATION=y
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_NFS_FSCACHE=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
# CONFIG_NFS_V4_2_READ_PLUS is not set
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
CONFIG_NFSD_BLOCKLAYOUT=y
CONFIG_NFSD_SCSILAYOUT=y
CONFIG_NFSD_FLEXFILELAYOUT=y
CONFIG_NFSD_V4_2_INTER_SSC=y
CONFIG_NFSD_V4_SECURITY_LABEL=y
CONFIG_GRACE_PERIOD=m
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=m
CONFIG_NFS_COMMON=y
CONFIG_NFS_V4_2_SSC_HELPER=y
CONFIG_SUNRPC=m
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_SUNRPC_SWAP=y
CONFIG_RPCSEC_GSS_KRB5=m
CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES=y
CONFIG_SUNRPC_DEBUG=y
CONFIG_SUNRPC_XPRT_RDMA=m
CONFIG_CEPH_FS=m
CONFIG_CEPH_FSCACHE=y
CONFIG_CEPH_FS_POSIX_ACL=y
CONFIG_CEPH_FS_SECURITY_LABEL=y
CONFIG_CIFS=m
# CONFIG_CIFS_STATS2 is not set
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
CONFIG_CIFS_SWN_UPCALL=y
# CONFIG_CIFS_SMB_DIRECT is not set
CONFIG_CIFS_FSCACHE=y
CONFIG_SMB_SERVER=m
CONFIG_SMB_SERVER_SMBDIRECT=y
CONFIG_SMB_SERVER_CHECK_CAP_NET_ADMIN=y
CONFIG_SMB_SERVER_KERBEROS5=y
CONFIG_SMBFS_COMMON=m
CONFIG_CODA_FS=m
CONFIG_AFS_FS=m
# CONFIG_AFS_DEBUG is not set
CONFIG_AFS_FSCACHE=y
# CONFIG_AFS_DEBUG_CURSOR is not set
CONFIG_9P_FS=m
CONFIG_9P_FSCACHE=y
CONFIG_9P_FS_POSIX_ACL=y
CONFIG_9P_FS_SECURITY=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
CONFIG_DLM=m
# CONFIG_DLM_DEBUG is not set
CONFIG_UNICODE=y
# CONFIG_UNICODE_NORMALIZATION_SELFTEST is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_REQUEST_CACHE=y
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_ENCRYPTED_KEYS=y
CONFIG_KEY_DH_OPERATIONS=y
CONFIG_KEY_NOTIFICATIONS=y
CONFIG_SECURITY_DMESG_RESTRICT=y
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_SECURITY_INFINIBAND=y
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_INTEL_TXT=y
CONFIG_LSM_MMAP_MIN_ADDR=0
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
# CONFIG_HARDENED_USERCOPY_FALLBACK is not set
# CONFIG_HARDENED_USERCOPY_PAGESPAN is not set
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
# CONFIG_SECURITY_SELINUX_DISABLE is not set
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
CONFIG_SECURITY_SELINUX_SIDTAB_HASH_BITS=9
CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE=256
CONFIG_SECURITY_SMACK=y
# CONFIG_SECURITY_SMACK_BRINGUP is not set
CONFIG_SECURITY_SMACK_NETFILTER=y
CONFIG_SECURITY_SMACK_APPEND_SIGNALS=y
CONFIG_SECURITY_TOMOYO=y
CONFIG_SECURITY_TOMOYO_MAX_ACCEPT_ENTRY=2048
CONFIG_SECURITY_TOMOYO_MAX_AUDIT_LOG=1024
# CONFIG_SECURITY_TOMOYO_OMIT_USERSPACE_LOADER is not set
CONFIG_SECURITY_TOMOYO_POLICY_LOADER="/sbin/tomoyo-init"
CONFIG_SECURITY_TOMOYO_ACTIVATION_TRIGGER="/sbin/init"
# CONFIG_SECURITY_TOMOYO_INSECURE_BUILTIN_SETTING is not set
CONFIG_SECURITY_APPARMOR=y
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
# CONFIG_SECURITY_APPARMOR_DEBUG is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
CONFIG_SECURITY_SAFESETID=y
CONFIG_SECURITY_LOCKDOWN_LSM=y
CONFIG_SECURITY_LOCKDOWN_LSM_EARLY=y
CONFIG_LOCK_DOWN_KERNEL_FORCE_NONE=y
# CONFIG_LOCK_DOWN_KERNEL_FORCE_INTEGRITY is not set
# CONFIG_LOCK_DOWN_KERNEL_FORCE_CONFIDENTIALITY is not set
CONFIG_SECURITY_LANDLOCK=y
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
CONFIG_INTEGRITY_PLATFORM_KEYRING=y
CONFIG_LOAD_UEFI_KEYS=y
CONFIG_INTEGRITY_AUDIT=y
CONFIG_IMA=y
CONFIG_IMA_MEASURE_PCR_IDX=10
CONFIG_IMA_LSM_RULES=y
# CONFIG_IMA_TEMPLATE is not set
CONFIG_IMA_NG_TEMPLATE=y
# CONFIG_IMA_SIG_TEMPLATE is not set
CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
CONFIG_IMA_DEFAULT_HASH_SHA1=y
# CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
# CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
CONFIG_IMA_DEFAULT_HASH="sha1"
# CONFIG_IMA_WRITE_POLICY is not set
# CONFIG_IMA_READ_POLICY is not set
CONFIG_IMA_APPRAISE=y
# CONFIG_IMA_ARCH_POLICY is not set
# CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
CONFIG_IMA_APPRAISE_BOOTPARAM=y
CONFIG_IMA_APPRAISE_MODSIG=y
CONFIG_IMA_TRUSTED_KEYRING=y
# CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY is not set
# CONFIG_IMA_BLACKLIST_KEYRING is not set
# CONFIG_IMA_LOAD_X509 is not set
CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
# CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
# CONFIG_IMA_DISABLE_HTABLE is not set
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
CONFIG_EVM_EXTRA_SMACK_XATTRS=y
CONFIG_EVM_ADD_XATTRS=y
# CONFIG_EVM_LOAD_X509 is not set
# CONFIG_DEFAULT_SECURITY_SELINUX is not set
# CONFIG_DEFAULT_SECURITY_SMACK is not set
# CONFIG_DEFAULT_SECURITY_TOMOYO is not set
CONFIG_DEFAULT_SECURITY_APPARMOR=y
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="lockdown,yama,integrity,apparmor"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=m
CONFIG_CRYPTO_AUTHENC=m
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=m
CONFIG_CRYPTO_ENGINE=m

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
CONFIG_CRYPTO_ECDSA=m
CONFIG_CRYPTO_ECRDSA=m
CONFIG_CRYPTO_SM2=m
CONFIG_CRYPTO_CURVE25519=m
CONFIG_CRYPTO_CURVE25519_X86=m

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=m
CONFIG_CRYPTO_AEGIS128=m
CONFIG_CRYPTO_AEGIS128_AESNI_SSE2=m
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=m
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
CONFIG_CRYPTO_OFB=m
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=y
CONFIG_CRYPTO_KEYWRAP=m
CONFIG_CRYPTO_NHPOLY1305=m
CONFIG_CRYPTO_NHPOLY1305_SSE2=m
CONFIG_CRYPTO_NHPOLY1305_AVX2=m
CONFIG_CRYPTO_ADIANTUM=m
CONFIG_CRYPTO_ESSIV=m

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=y
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_XXHASH=m
CONFIG_CRYPTO_BLAKE2B=m
CONFIG_CRYPTO_BLAKE2S=m
CONFIG_CRYPTO_BLAKE2S_X86=m
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=m
CONFIG_CRYPTO_POLY1305_X86_64=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=m
CONFIG_CRYPTO_SHA256_SSSE3=m
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
CONFIG_CRYPTO_SM3=m
CONFIG_CRYPTO_STREEBOG=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=m
CONFIG_CRYPTO_AES_NI_INTEL=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_DES3_EDE_X86_64=m
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_CHACHA20_X86_64=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
CONFIG_CRYPTO_SM4=m
CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=m
CONFIG_CRYPTO_LZ4=m
CONFIG_CRYPTO_LZ4HC=m
CONFIG_CRYPTO_ZSTD=m

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=m
CONFIG_CRYPTO_USER_API_HASH=m
CONFIG_CRYPTO_USER_API_SKCIPHER=m
CONFIG_CRYPTO_USER_API_RNG=m
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=m
# CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE is not set
CONFIG_CRYPTO_STATS=y
CONFIG_CRYPTO_HASH_INFO=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
CONFIG_CRYPTO_ARCH_HAVE_LIB_BLAKE2S=m
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=m
CONFIG_CRYPTO_LIB_BLAKE2S=m
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=m
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=m
CONFIG_CRYPTO_LIB_CHACHA=m
CONFIG_CRYPTO_ARCH_HAVE_LIB_CURVE25519=m
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=m
CONFIG_CRYPTO_LIB_CURVE25519=m
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=m
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=m
CONFIG_CRYPTO_LIB_POLY1305=m
CONFIG_CRYPTO_LIB_CHACHA20POLY1305=m
CONFIG_CRYPTO_LIB_SHA256=y
CONFIG_CRYPTO_LIB_SM4=m
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=y
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
CONFIG_CRYPTO_DEV_ATMEL_I2C=m
CONFIG_CRYPTO_DEV_ATMEL_ECC=m
CONFIG_CRYPTO_DEV_ATMEL_SHA204A=m
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_CCP_DD=m
CONFIG_CRYPTO_DEV_SP_CCP=y
CONFIG_CRYPTO_DEV_CCP_CRYPTO=m
CONFIG_CRYPTO_DEV_SP_PSP=y
# CONFIG_CRYPTO_DEV_CCP_DEBUGFS is not set
CONFIG_CRYPTO_DEV_QAT=m
CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
CONFIG_CRYPTO_DEV_QAT_C3XXX=m
CONFIG_CRYPTO_DEV_QAT_C62X=m
CONFIG_CRYPTO_DEV_QAT_4XXX=m
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=m
CONFIG_CRYPTO_DEV_QAT_C62XVF=m
CONFIG_CRYPTO_DEV_NITROX=m
CONFIG_CRYPTO_DEV_NITROX_CNN55XX=m
CONFIG_CRYPTO_DEV_CHELSIO=m
CONFIG_CRYPTO_DEV_VIRTIO=m
CONFIG_CRYPTO_DEV_SAFEXCEL=m
CONFIG_CRYPTO_DEV_AMLOGIC_GXL=m
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL_DEBUG is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE=m
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS8_PRIVATE_KEY_PARSER=m
CONFIG_TPM_KEY_PARSER=m
CONFIG_PKCS7_MESSAGE_PARSER=y
CONFIG_PKCS7_TEST_KEY=m
CONFIG_SIGNED_PE_FILE_VERIFICATION=y

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_MODULE_SIG_KEY_TYPE_RSA=y
# CONFIG_MODULE_SIG_KEY_TYPE_ECDSA is not set
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=4096
CONFIG_SECONDARY_TRUSTED_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
CONFIG_SYSTEM_REVOCATION_LIST=y
CONFIG_SYSTEM_REVOCATION_KEYS=""
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
CONFIG_LINEAR_RANGES=y
CONFIG_PACKING=y
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_CORDIC=m
# CONFIG_PRIME_NUMBERS is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=m
CONFIG_CRC4=m
CONFIG_CRC7=m
CONFIG_LIBCRC32C=m
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_842_COMPRESS=m
CONFIG_842_DECOMPRESS=m
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=m
CONFIG_LZ4HC_COMPRESS=m
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=m
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_REED_SOLOMON_DEC16=y
CONFIG_BCH=m
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_BTREE=y
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
CONFIG_SWIOTLB=y
CONFIG_DMA_COHERENT_POOL=y
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_IOMMU_HELPER=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_LRU_CACHE=m
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_DIMLIB=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
CONFIG_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
# CONFIG_FONT_6x11 is not set
# CONFIG_FONT_7x14 is not set
# CONFIG_FONT_PEARL_8x8 is not set
CONFIG_FONT_ACORN_8x8=y
# CONFIG_FONT_MINI_4x6 is not set
CONFIG_FONT_6x10=y
# CONFIG_FONT_10x18 is not set
# CONFIG_FONT_SUN8x16 is not set
# CONFIG_FONT_SUN12x22 is not set
CONFIG_FONT_TER16x32=y
# CONFIG_FONT_6x8 is not set
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_SBITMAP=y
CONFIG_PARMAN=m
CONFIG_OBJAGG=m
# end of Library routines

CONFIG_PLDMFW=y
CONFIG_ASN1_ENCODER=y

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
# CONFIG_PRINTK_CALLER is not set
# CONFIG_STACKTRACE_BUILD_ID is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_INFO_REDUCED is not set
# CONFIG_DEBUG_INFO_COMPRESSED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
CONFIG_DEBUG_INFO_DWARF4=y
CONFIG_DEBUG_INFO_BTF=y
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
CONFIG_DEBUG_INFO_BTF_MODULES=y
CONFIG_GDB_SCRIPTS=y
CONFIG_FRAME_WARN=1024
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
# CONFIG_DEBUG_SECTION_MISMATCH is not set
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B is not set
CONFIG_FRAME_POINTER=y
CONFIG_STACK_VALIDATION=y
CONFIG_VMLINUX_MAP=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x01b6
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
CONFIG_KGDB=y
CONFIG_KGDB_HONOUR_BLOCKLIST=y
CONFIG_KGDB_SERIAL_CONSOLE=y
# CONFIG_KGDB_TESTS is not set
CONFIG_KGDB_LOW_LEVEL_TRAP=y
CONFIG_KGDB_KDB=y
CONFIG_KDB_DEFAULT_ENABLE=0x1
CONFIG_KDB_KEYBOARD=y
CONFIG_KDB_CONTINUE_CATASTROPHIC=0
CONFIG_ARCH_HAS_EARLY_DEBUG=y
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
# end of Generic Kernel Debugging Instruments

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
CONFIG_PAGE_POISONING=y
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
CONFIG_DEBUG_WX=y
CONFIG_GENERIC_PTDUMP=y
CONFIG_PTDUMP_CORE=y
# CONFIG_PTDUMP_DEBUGFS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
CONFIG_SCHED_STACK_END_CHECK=y
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
# CONFIG_DEBUG_MEMORY_INIT is not set
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# CONFIG_KASAN is not set
CONFIG_HAVE_ARCH_KFENCE=y
CONFIG_KFENCE=y
CONFIG_KFENCE_SAMPLE_INTERVAL=0
CONFIG_KFENCE_NUM_OBJECTS=255
# CONFIG_KFENCE_STATIC_KEYS is not set
CONFIG_KFENCE_STRESS_TEST_FAULTS=0
# end of Memory Debugging

# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Oops, Lockups and Hangs
#
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=0
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
# CONFIG_WQ_WATCHDOG is not set
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
# CONFIG_DEBUG_ATOMIC_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
# CONFIG_DEBUG_LIST is not set
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=60
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
# CONFIG_LATENCYTOP is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_OBJTOOL_MCOUNT=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
CONFIG_BOOTTIME_TRACING=y
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
CONFIG_MMIOTRACE=y
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_BPF_KPROBE_OVERRIDE=y
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_FTRACE_MCOUNT_USE_CC=y
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
CONFIG_HIST_TRIGGERS=y
CONFIG_TRACE_EVENT_INJECT=y
# CONFIG_TRACEPOINT_BENCHMARK is not set
# CONFIG_RING_BUFFER_BENCHMARK is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_RECORD_RECURSION is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
# CONFIG_MMIOTRACE_TEST is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
CONFIG_SAMPLES=y
# CONFIG_SAMPLE_AUXDISPLAY is not set
# CONFIG_SAMPLE_TRACE_EVENTS is not set
CONFIG_SAMPLE_TRACE_PRINTK=m
CONFIG_SAMPLE_FTRACE_DIRECT=m
CONFIG_SAMPLE_TRACE_ARRAY=m
# CONFIG_SAMPLE_KOBJECT is not set
# CONFIG_SAMPLE_KPROBES is not set
# CONFIG_SAMPLE_HW_BREAKPOINT is not set
# CONFIG_SAMPLE_KFIFO is not set
# CONFIG_SAMPLE_KDB is not set
# CONFIG_SAMPLE_RPMSG_CLIENT is not set
# CONFIG_SAMPLE_LIVEPATCH is not set
# CONFIG_SAMPLE_CONFIGFS is not set
# CONFIG_SAMPLE_VFIO_MDEV_MTTY is not set
# CONFIG_SAMPLE_VFIO_MDEV_MDPY is not set
# CONFIG_SAMPLE_VFIO_MDEV_MDPY_FB is not set
# CONFIG_SAMPLE_VFIO_MDEV_MBOCHS is not set
# CONFIG_SAMPLE_WATCHDOG is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
# CONFIG_X86_VERBOSE_BOOTUP is not set
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_TLBFLUSH is not set
# CONFIG_IOMMU_DEBUG is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
# CONFIG_IO_DELAY_0X80 is not set
CONFIG_IO_DELAY_0XED=y
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
CONFIG_PUNIT_ATOM_DEBUG=m
# CONFIG_UNWINDER_ORC is not set
CONFIG_UNWINDER_FRAME_POINTER=y
# CONFIG_UNWINDER_GUESS is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
CONFIG_NOTIFIER_ERROR_INJECTION=m
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
# CONFIG_FAULT_INJECTION is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_DIV64 is not set
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_STRING_SELFTEST is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_STRSCPY is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_SCANF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_OVERFLOW is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_TEST_IDA is not set
# CONFIG_TEST_PARMAN is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_BITOPS is not set
# CONFIG_TEST_VMALLOC is not set
# CONFIG_TEST_USER_COPY is not set
CONFIG_TEST_BPF=m
CONFIG_TEST_BLACKHOLE_DEV=m
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_LIVEPATCH is not set
# CONFIG_TEST_OBJAGG is not set
# CONFIG_TEST_STACKINIT is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_HMM is not set
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
# CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
CONFIG_ARCH_USE_MEMTEST=y
CONFIG_MEMTEST=y
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking
