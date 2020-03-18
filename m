From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Wed, 18 Mar 2020 09:32:02 +0200
Subject: [Intel-wired-lan] [Regression] "e1000e: Add support for S0ix"
 breaks s2idle on Lenovo X1 Carbon 7th
In-Reply-To: <BA29B851-8765-4F47-AC98-E2D604595EA6@canonical.com>
References: <0A7D1E37-88A4-4E5A-8522-B80A8AE679EE@canonical.com>
 <8c0032bd-15be-734b-1b52-dedba72a8da3@intel.com>
 <897C8B9E-839A-4FC1-9411-B3CB141890BC@canonical.com>
 <540fd2d3-9187-1dba-185a-58d94c4c5b69@intel.com>
 <BA29B851-8765-4F47-AC98-E2D604595EA6@canonical.com>
Message-ID: <38766b04-eec3-f4ce-5fe5-6352562b271c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 3/18/2020 05:12, Kai-Heng Feng wrote:
> Hi Vitaly,
> 
>> On Mar 17, 2020, at 22:39, Vitaly Lifshits <vitaly.lifshits@intel.com> wrote:
>>
>> On 3/17/2020 16:04, Kai-Heng Feng wrote:
>>>> On Mar 17, 2020, at 21:56, Neftin, Sasha <sasha.neftin@intel.com> wrote:
>>>>
>>>> On 3/17/2020 15:34, Kai-Heng Feng wrote:
>>>>> Hi,
>>>>> Users reported that X1 Carbon 7th can only suspend once due of "e1000e 0000:00:1f.6 enp0s31f6: Hardware Error" [1] [2].
>>>>> I managed to get one at hand and I can confirm the issue is 100% reproducible.
>>>>> The error occurs at the first e1e_rphy() in e1000_copper_link_setup_82577() [3].
>>>>> Reverting "e1000e: Add support for S0ix" makes suspend work again.
>>>>> I also tried commit e1738282f6c6 "e1000e: fix S0ix flows for cable connected case" however the issue persists.
>>>>> Kai-Heng
>>>>> [1] https://bugs.launchpad.net/bugs/1865570
>>>>> [2] https://bugs.launchpad.net/bugs/1866170
>>>>> [3] https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git/tree/drivers/net/ethernet/intel/e1000e/phy.c?h=dev-queue&id=e1738282f6c6ad0ec56a15c4d5a3b657d90e4435#n630
>>>> please, check of ME enabled on this system. try disable ME and re-run
>>> I disabled "Intel AMT", issue is still reproducible.
>>> Kai-Heng
>> Hi Kai,
>>
>> Do you work with cable connected?
> 
> No, ethernet cable is not plugged.
> 
>> If so, please try to run this command:
>> sudo echo 3 > /sys/kernel/debug/pmc_core/ltr_ignore
> 
> Same issue after doing that.
> 
> Though unlikely, can this be caused by the special design of X1 Carbon?
> To keep the laptop thin, it doesn't have a RJ45 port. Instead it has a special connecter which requires a RJ45 dongle to support ethernet.
> Maybe that's why the PHY part isn't working after suspend?
> 
Hello Kai-Heng,
Thanks for your response. I would like clarify/understand Lenovo X1 
Carbon setup:
How laptop connected to the docking station? Thunderbolt or Lenovo 
proprietary connection?
Where is LAN located (physically) in a laptop or dock?
PHY located in docking, right?

And last question: does this system supported Sx or S0ix (do you know)?
The reason I ask it due from my understanding dock always connected to 
the power and system should be Sx supported.

Therefore may be we need introduce difference behavior between Sx and 
S0ix support. (if I understand correctly, such systems as Lenovo Carbon 
X1 should be Sx support, we need ignore S0ix entry/exit in such cases - 
ACPI interface should provide us with this info)

> Kai-Heng
> 
Sasha
