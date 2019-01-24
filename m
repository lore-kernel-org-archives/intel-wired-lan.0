From: Kai Heng Feng <kai.heng.feng@canonical.com>
Date: Thu, 24 Jan 2019 23:29:37 +0800
Subject: [Intel-wired-lan] [PATCH] PCI / ACPI: Don't clear pme_poll on
 device that has unreliable ACPI wake
In-Reply-To: <20190124151524.GF14636@google.com>
References: <20190122064544.27426-1-kai.heng.feng@canonical.com>
 <20190122235134.GE14636@google.com>
 <91E74111-5BB6-4604-A1D7-B537AB42C317@canonical.com>
 <20190124151524.GF14636@google.com>
Message-ID: <FFC6EC3F-3608-41FC-8B14-815D1747C4B6@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> On Jan 24, 2019, at 11:15 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> On Wed, Jan 23, 2019 at 03:17:37PM +0800, Kai Heng Feng wrote:
>>> On Jan 23, 2019, at 7:51 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>>> On Tue, Jan 22, 2019 at 02:45:44PM +0800, Kai-Heng Feng wrote:
>>>> There are some e1000e devices can only be woken up from D3 one time, by
>>>> plugging ethernet cable. Subsequent cable plugging does set PME bit
>>>> correctly, but it still doesn't get woken up.
>>>> 
>>>> Since e1000e connects to the root complex directly, we rely on ACPI to
>>>> wake it up. In this case, the GPE from _PRW only works once and stops
>>>> working after that.
>>>> 
>>>> So introduce a new PCI quirk, to avoid clearing pme_poll flag for buggy
>>>> platform firmwares that have unreliable GPE wake.
>>> 
>>> This quirk applies to all 0x15bb (E1000_DEV_ID_PCH_CNP_I219_LM7) and
>>> 0x15bd (E1000_DEV_ID_PCH_CNP_I219_LM6) devices.  The e1000e driver
>>> claims about a zillion different device IDs.
>>> 
>>> I would be surprised if these two devices are defective but all the
>>> others work correctly.  Could it be that there is a problem with the
>>> wiring on this particular motherboard or with the ACPI _PRW methods
>>> (or the way Linux interprets them) in this firmware?
>> 
>> If this is a motherboard issue or platform specific, do you prefer to use
>> DMI matches here?
> 
> I'm not sure what the problem is yet, so let's hold off on the exact
> structure of the fix.

I think DMI table can put in e1000e driver instead of PCI quirk.

> 
> If I understand correctly, e1000e wakeup works once, but doesn't work
> after that.  Your lspci (from after that first wakeup, from
> https://bugzilla.kernel.org/attachment.cgi?id=280691) shows this:
> 
>  00:14.0 XHC  XHCI USB
>    Flags: PMEClk- DSI- D1- D2- ... PME(D0-,D1-,D2-,D3hot+,D3cold+)
>    Status: D3 NoSoftRst+ PME-Enable+ DSel=0 DScale=0 PME-
>  00:1f.3 HDAS audio
>    Flags: PMEClk- DSI- D1- D2- ... PME(D0-,D1-,D2-,D3hot+,D3cold+)
>    Status: D3 NoSoftRst+ PME-Enable+ DSel=0 DScale=0 PME-
>  00:1f.6 GLAN e1000e
>    Flags: PMEClk- DSI+ D1- D2- ... PME(D0+,D1-,D2-,D3hot+,D3cold+)
>    Status: D3 NoSoftRst+ PME-Enable+ DSel=0 DScale=1 PME+
> 
> So the e1000e PME_Status bit is still set, which means it probably
> won't generate another PME interrupt, which would explain why wakeup
> doesn't work.  To test this theory, can you try this:
> 
>  - sleep
>  - wakeup via e1000e
>  # DEV=00:1f.6
>  # lspci -vvs $DEV
>  # setpci -s $DEV CAP_PM+4.W
>  # setpci -s $DEV CAP_PM+4.W=0x8100
>  - sleep
>  - attempt another wakeup via e1000e
> 
> If this second wakeup works, it would suggest that PME_Status isn't
> being cleared correctly.  I see code, e.g., in
> acpi_setup_gpe_for_wake(), that *looks* like it would arrange to clear
> it, but I'm not very familiar with it.  Maybe there's some issue with
> multiple devices sharing an "implicit notification" situation like
> this.

The PME status is being cleared correctly.

The lspci is captured after I plugged the ethernet cable second time,
i.e. PME is set but not being woken up.

Kai-Heng

> 
>> As for _PRW, it?s shared by USB controller, Audio controller and ethernet.
>> Only the ethernet (e1000e) has this issue.
>> 
>> When this issue happens, the e1000e doesn?t get woken up by ethernet cable
>> plugging, but inserting a USB device or plugging audio jack can wake up all
>> three devices. So I think Linux interprets ACPI correctly here.
>> 
>> Their _PRW here:
>> USB controller:
>>    Scope (_SB.PCI0)                       
>>    {                                      
>>        Device (XDCI)                            
>>        {                    
>>            Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
>>            {            
>>                Return (GPRW (0x6D, 0x04))
>>            } 
>> 
>> Audio controller:
>> Scope (_SB.PCI0)                                                                                           
>>    {                                                                                                          
>>        Device (HDAS)                                  
>>        {                                                                             
>>            ?         
>>            Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake                 
>>            {                                        
>>                Return (GPRW (0x6D, 0x04))           
>>            }                                  
>> 
>> Ethernet controller:
>>    Scope (_SB.PCI0)                                                                     
>>    {                                                                     
>>        Device (GLAN)                                                  
>>        {                                                                            
>>           ?
>>            Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake                 
>>            {                                        
>>                Return (GPRW (0x6D, 0x04))                       
>>            }                                                              
>>        }                                                             
>>    }  
>> 
>> 
>>> 
>>> Would you mind attaching a complete dmesg log and "sudo lspci -vvv"
>>> output to the bugzilla, please?
>> 
>> Sure.
>> 
>> Kai-Heng
>> 
>>> 
>>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>>> ---
>>>> drivers/pci/pci-acpi.c | 2 +-
>>>> drivers/pci/quirks.c   | 8 ++++++++
>>>> include/linux/pci.h    | 1 +
>>>> 3 files changed, 10 insertions(+), 1 deletion(-)
>>>> 
>>>> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
>>>> index e1949f7efd9c..184e2fc8a294 100644
>>>> --- a/drivers/pci/pci-acpi.c
>>>> +++ b/drivers/pci/pci-acpi.c
>>>> @@ -430,7 +430,7 @@ static void pci_acpi_wake_dev(struct acpi_device_wakeup_context *context)
>>>> 
>>>> 	pci_dev = to_pci_dev(context->dev);
>>>> 
>>>> -	if (pci_dev->pme_poll)
>>>> +	if (pci_dev->pme_poll && !pci_dev->unreliable_acpi_wake)
>>>> 		pci_dev->pme_poll = false;
>>>> 
>>>> 	if (pci_dev->current_state == PCI_D3cold) {
>>>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>>>> index b0a413f3f7ca..ed4863496fa8 100644
>>>> --- a/drivers/pci/quirks.c
>>>> +++ b/drivers/pci/quirks.c
>>>> @@ -4948,6 +4948,14 @@ DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_AMD, PCI_ANY_ID,
>>>> DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
>>>> 			      PCI_CLASS_MULTIMEDIA_HD_AUDIO, 8, quirk_gpu_hda);
>>>> 
>>>> +static void quirk_unreliable_acpi_wake(struct pci_dev *pdev)
>>>> +{
>>>> +	pci_info(pdev, "ACPI Wake unreliable, always poll PME\n");
>>>> +	pdev->unreliable_acpi_wake = 1;
>>>> +}
>>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x15bb, quirk_unreliable_acpi_wake);
>>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x15bd, quirk_unreliable_acpi_wake);
>>>> +
>>>> /*
>>>> * Some IDT switches incorrectly flag an ACS Source Validation error on
>>>> * completions for config read requests even though PCIe r4.0, sec
>>>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>>>> index 65f1d8c2f082..d22065c1576f 100644
>>>> --- a/include/linux/pci.h
>>>> +++ b/include/linux/pci.h
>>>> @@ -331,6 +331,7 @@ struct pci_dev {
>>>> 	unsigned int	pme_support:5;	/* Bitmask of states from which PME#
>>>> 					   can be generated */
>>>> 	unsigned int	pme_poll:1;	/* Poll device's PME status bit */
>>>> +	unsigned int	unreliable_acpi_wake:1;	/* ACPI Wake doesn't always work */
>>>> 	unsigned int	d1_support:1;	/* Low power state D1 is supported */
>>>> 	unsigned int	d2_support:1;	/* Low power state D2 is supported */
>>>> 	unsigned int	no_d1d2:1;	/* D1 and D2 are forbidden */
>>>> -- 
>>>> 2.17.1

