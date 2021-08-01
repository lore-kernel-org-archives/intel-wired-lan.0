From: Sasha Neftin <sasha.neftin@intel.com>
Date: Sun, 1 Aug 2021 07:15:41 +0300
Subject: [Intel-wired-lan] [PATCH 3/3] e1000e: Serialize TGP e1000e PM
 ops
In-Reply-To: <CAAd53p5B5f5U_J1L+SpjZ46AFEr1kMqwgqnF2dYKvDwY2x3GzA@mail.gmail.com>
References: <20210712133500.1126371-1-kai.heng.feng@canonical.com>
 <20210712133500.1126371-3-kai.heng.feng@canonical.com>
 <CAAd53p5B5f5U_J1L+SpjZ46AFEr1kMqwgqnF2dYKvDwY2x3GzA@mail.gmail.com>
Message-ID: <5be1929b-89b7-f24d-27bc-f07a59916c0b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 7/27/2021 09:53, Kai-Heng Feng wrote:
> Hi Sasha,
> 
> On Mon, Jul 12, 2021 at 9:35 PM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
>>
>> On TGL systems, PCI_COMMAND may randomly flip to 0 on system resume.
>> This is devastating to drivers that use pci_set_master(), like NVMe and
>> xHCI, to enable DMA in their resume routine, as pci_set_master() can
>> inadvertently disable PCI_COMMAND_IO and PCI_COMMAND_MEMORY, making
>> resources inaccessible.
>>
>> The issue is reproducible on all kernel releases, but the situation is
>> exacerbated by commit 6cecf02e77ab ("Revert "e1000e: disable s0ix entry
>> and exit flows for ME systems"").
>>
>> Seems like ME can do many things to other PCI devices until it's finally out of
>> ULP polling. So ensure e1000e PM ops are serialized by enforcing suspend/resume
>> order to workaround the issue.
>>
>> Of course this will make system suspend and resume a bit slower, but we
>> probably need to settle on this workaround until ME is fully supported.
>>
>> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=212039
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> 
> Series "e1000e: Add handshake with the CSME to support s0ix" doesn't
> fix the issue, so this patch is still needed.
Hello Kai-Heng,
This problem is still under investigation by the ME team. Let's wait for 
their response.
Series "e1000e: Add handshake with the CSME to support s0ix" - support 
only s0ix flow on AMT/CSME none provisioned systems and not related to 
this problem.
> 
> Kai-Heng
> 
>> ---
>>   drivers/net/ethernet/intel/e1000e/netdev.c | 14 +++++++++++++-
>>   1 file changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
>> index e63445a8ce12..0244d3dd90a3 100644
>> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
>> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
>> @@ -7319,7 +7319,8 @@ static const struct net_device_ops e1000e_netdev_ops = {
>>
>>   static void e1000e_create_device_links(struct pci_dev *pdev)
>>   {
>> -       struct pci_dev *tgp_mei_me;
>> +       struct pci_bus *bus = pdev->bus;
>> +       struct pci_dev *tgp_mei_me, *p;
>>
>>          /* Find TGP mei_me devices and make e1000e power depend on mei_me */
>>          tgp_mei_me = pci_get_device(PCI_VENDOR_ID_INTEL, 0xa0e0, NULL);
>> @@ -7335,6 +7336,17 @@ static void e1000e_create_device_links(struct pci_dev *pdev)
>>                  pci_info(pdev, "System and runtime PM depends on %s\n",
>>                           pci_name(tgp_mei_me));
>>
>> +       /* Find other devices in the SoC and make them depend on e1000e */
>> +       list_for_each_entry(p, &bus->devices, bus_list) {
>> +               if (&p->dev == &pdev->dev || &p->dev == &tgp_mei_me->dev)
>> +                       continue;
>> +
>> +               if (device_link_add(&p->dev, &pdev->dev,
>> +                                   DL_FLAG_AUTOREMOVE_SUPPLIER))
>> +                       pci_info(p, "System PM depends on %s\n",
>> +                                pci_name(pdev));
>> +       }
>> +
>>          pci_dev_put(tgp_mei_me);
>>   }
>>
>> --
>> 2.31.1
>>
sasha
