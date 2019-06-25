From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Tue, 25 Jun 2019 13:25:00 +0300
Subject: [Intel-wired-lan] Opportunistic S0ix blocked by e1000e when
 ethernet is in use
In-Reply-To: <E8C45269-819C-41E0-A3D3-AA98710DBA4C@canonical.com>
References: <074E1145-A512-4835-9A6D-8FB6634DBD3C@canonical.com>
 <E2D5225B-D683-4895-AC4F-EE01C339262B@canonical.com>
 <95f88f45-fd6c-52e4-de8c-2db1b4c6c04e@intel.com>
 <E8C45269-819C-41E0-A3D3-AA98710DBA4C@canonical.com>
Message-ID: <dfd57ef4-08bd-53cf-1f0a-86edc5bc0a67@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 6/24/2019 18:06, Kai-Heng Feng wrote:
> at 19:56, Neftin, Sasha <sasha.neftin@intel.com> wrote:
> 
>> On 6/24/2019 10:03, Kai-Heng Feng wrote:
>>> Hi Jeffrey,
>>> at 19:08, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
>>>> Hi Jeffrey,
>>>>
>>>> There are several platforms that uses e1000e can?t enter 
>>>> Opportunistic S0ix (PC10) when the ethernet has a link partner.
>>>>
>>>> This behavior also exits in out-of-tree e1000e driver 3.4.2.1, but 
>>>> seems like 3.4.2.3 fixes the issue.
>>>>
>>>> A quick diff between the two versions shows that this code section 
>>>> may be our solution:
>>>>
>>>> ??????? /* Read from EXTCNF_CTRL in e1000_acquire_swflag_ich8lan 
>>>> function
>>>> ???????? * may occur during global reset and cause system hang.
>>>> ???????? * Configuration space access creates the needed delay.
>>>> ???????? * Write to E1000_STRAP RO register 
>>>> E1000_PCI_VENDOR_ID_REGISTER value
>>>> ???????? * insures configuration space read is done before global 
>>>> reset.
>>>> ???????? */
>>>> ??????? pci_read_config_word(hw->adapter->pdev, 
>>>> E1000_PCI_VENDOR_ID_REGISTER,
>>>> ???????????????????????????? &pci_cfg);
>>>> ??????? ew32(STRAP, pci_cfg);
>>>> ??????? e_dbg("Issuing a global reset to ich8lan\n");
>>>> ??????? ew32(CTRL, (ctrl | E1000_CTRL_RST));
>>>> ??????? /* cannot issue a flush here because it hangs the hardware */
>>>> ??????? msleep(20);
>>>>
>>>> ??????? /* Configuration space access improve HW level time sync 
>>>> mechanism.
>>>> ???????? * Write to E1000_STRAP RO register 
>>>> E1000_PCI_VENDOR_ID_REGISTER
>>>> ???????? * value to insure configuration space read is done
>>>> ???????? * before any access to mac register.
>>>> ???????? */
>>>> ??????? pci_read_config_word(hw->adapter->pdev, 
>>>> E1000_PCI_VENDOR_ID_REGISTER,
>>>> ???????????????????????????? &pci_cfg);
>>>> ??????? ew32(STRAP, pci_cfg);
>>> Turns out the "extra sauce? is not this part, it?s called ?Dynamic 
>>> LTR support?.
>>> >>
>>>> Is there any plan to support this in the upstream kernel?
>>> Is there any plan to support Dynamic LTR in upstream e1000e?
>> Dynamic LTR is not stable solution. So, we can not put this solution 
>> to upstream. I hope we will be able to fix this in HW for a future 
>> projects.
> 
> Does this mean current generation hardware won?t get the fix?
Current HW have a limitation. Please, try follow workaround on your 
platform: echo 3 > /sys/kernel/debug/pmc_core/ltr_ignore
> >> S0ix support is under discussion with our architecture. We will try
>> enable S0ix in our e1000e OOT driver as first step.
> 
> Is it possible to add Dynamic LTR as an option so users and downstream 
> distros can still benefit from it?
As I said before, this is not a stable solution. No guarantee that HW 
will work as properly.
> 
> Kai-Heng
> 
>>> Kai-Heng
>>>> Kai-Heng
>>> _______________________________________________
>>> Intel-wired-lan mailing list
>>> Intel-wired-lan at osuosl.org
>>> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
>>
>> Thanks
>> Sasha
> 
> 

