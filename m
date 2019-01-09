From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Wed, 9 Jan 2019 17:07:25 +0200
Subject: [Intel-wired-lan] [PATCH 2/3] e1000e: ignore status during
 auto-negotiation
In-Reply-To: <7f05a109-a5a4-6be0-8d17-3fbf509f238f@fbihome.de>
References: <e080046a-6630-ad07-ebbb-603e820766f4@fbihome.de>
 <1546608667-25498-1-git-send-email-glogow@fbihome.de>
 <1546608667-25498-3-git-send-email-glogow@fbihome.de>
 <67d195a8-0b04-ee72-71fb-f194c009107e@intel.com>
 <880FE4A8-009D-43BE-AB18-FD237652F497@fbihome.de>
 <bef81e20-0981-354f-ac58-5a04689b2c5b@intel.com>
 <f43ff4d1-10aa-29b0-7286-32e899df0de4@fbihome.de>
 <4f26de6f-b266-0e76-c3b8-e971d021a73e@fbihome.de>
 <de4d97aa-ab86-75e6-a6f3-8da2240acf29@intel.com>
 <8b89511a-68a6-71e1-82bf-64cadfbbb0ae@fbihome.de>
 <5f209eda-ba57-4882-cebe-3f1bfbf0a317@intel.com>
 <a952ef24-b28b-39f4-35dd-cb6aa7ffb25f@fbihome.de>
 <95d4d060-83d3-232f-5199-b2a18422f27d@molgen.mpg.de>
 <7f05a109-a5a4-6be0-8d17-3fbf509f238f@fbihome.de>
Message-ID: <530d8f05-4f06-bbbc-748e-69e54eaee9c8@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 1/8/2019 13:15, Jan-Marek Glogowski wrote:
> Hi Paul,
> 
> Am 08.01.19 um 11:15 schrieb Paul Menzel:
>> On 01/08/19 10:59, Jan-Marek Glogowski wrote:
>>
>>> Am 08.01.19 um 09:31 schrieb Neftin, Sasha:
>>>> On 1/7/2019 18:37, Jan-Marek Glogowski wrote:
>>
>> [?]
>>
>>>> Since you still read 0x40000000 value in the status register it is causing me to think that ME
>>>> works. Another way I think you should to go ask your vendors for last updated NVM (or with ME
>>>> disabled if possible) for your HW. Since I219V works as properly, I expected I219-LM without ME
>>>> works too.
>>>
>>>  From the logs I sent:
>>>
>>> I217-LM: "status 0x40080083 => 1000 Mbps, Full Duplex"
>>> I219-V: "status 0x40080083 => 1000 Mbps, Full Duplex"
>>> I219-LM auto-nego ok: "status 0x80083 => 1000 Mbps, Full Duplex"
>>> I219-LM auto-nego broken: "status 0x40080003 => 10 Mbps, Full Duplex"
>>>
>>> According to the BIOS both LM-variants have Intel ME disabled. If I can't trust the BIOS, is there a
>>> way to check this?
>>
>> What does intelmetool from the coreboot project show?
>>
>>      $ git clone https://review.coreboot.org/coreboot.git
>>      $ cd coreboot
>>      $ cd util/intelmetoolo
>>      $ make -j
>>      $ sudo ./intelmetool -m
> 
> 
> me-e736.log-norm
> ----------------
> MEI found: [8086:9d3a] Sunrise Point-LP CSME HECI #1
> 
> ME Status   : 0x90000245
> ME Status 2 : 0x86110306
> 
> ME: FW Partition Table      : OK
> ME: Bringup Loader Failure  : NO
> ME: Firmware Init Complete  : YES
> ME: Manufacturing Mode      : NO
> ME: Boot Options Present    : NO
> ME: Update In Progress      : NO
> ME: Current Working State   : Normal
> ME: Current Operation State : M0 with UMA
> ME: Current Operation Mode  : Normal
> ME: Error Code              : No Error
> ME: Progress Phase          : Clean Moff->Mx wake
> ME: Power Management Event  : Pseudo-global reset
> ME: Progress Phase State    : Unknown 0x11
> 
> ME: Extend Register not valid
> 
> ME: Firmware Version 11.0.1173.0 (code) 11.0.1173.0 (recovery) 11.0.1173.0 (fitc)
> 
> ME Capability: Full Network manageability                 : OFF
> ME Capability: Regular Network manageability              : OFF
> ME Capability: Manageability                              : OFF
> ME Capability: Small business technology                  : OFF
> ME Capability: Level III manageability                    : OFF
> ME Capability: IntelR Anti-Theft (AT)                     : OFF
> ME Capability: IntelR Capability Licensing Service (CLS)  : ON
> ME Capability: IntelR Power Sharing Technology (MPC)      : OFF
> ME Capability: ICC Over Clocking                          : ON
> ME Capability: Protected Audio Video Path (PAVP)          : ON
> ME Capability: IPV6                                       : OFF
> ME Capability: KVM Remote Control (KVM)                   : OFF
> ME Capability: Outbreak Containment Heuristic (OCH)       : OFF
> ME Capability: Virtual LAN (VLAN)                         : ON
> ME Capability: TLS                                        : OFF
> ME Capability: Wireless LAN (WLAN)                        : OFF
> 
> 
> me-e754.log-norm
> ----------------
> Bad news, you have a `QM87 Express LPC Controller` so you have ME hardware on board and you can't
> control or disable it, continuing...
> 
> MEI found: [8086:8c3a] 8 Series/C220 Series Chipset Family MEI Controller #1
> 
> ME Status   : 0x1e000245
> ME Status 2 : 0x60002306
> 
> ME: FW Partition Table      : OK
> ME: Bringup Loader Failure  : NO
> ME: Firmware Init Complete  : YES
> ME: Manufacturing Mode      : NO
> ME: Boot Options Present    : NO
> ME: Update In Progress      : NO
> ME: Current Working State   : Normal
> ME: Current Operation State : M0 with UMA
> ME: Current Operation Mode  : Normal
> ME: Error Code              : No Error
> ME: Progress Phase          : Host Communication
> ME: Power Management Event  : Clean Moff->Mx wake
> ME: Progress Phase State    : Host communication established
> 
> ME: Extend SHA-256: d536aea220d776c0d26baaffc9832af56871511a7e304b37783b0fe7b8929503
> 
> ME: Firmware Version 9.0.1467.22 (code) 9.0.1467.22 (recovery) 9.0.1452.21 (fitc)
> 
> ME Capability: Full Network manageability                 : OFF
> ME Capability: Regular Network manageability              : OFF
> ME Capability: Manageability                              : ON
> ME Capability: Small business technology                  : ON
> ME Capability: Level III manageability                    : OFF
> ME Capability: IntelR Anti-Theft (AT)                     : ON
> ME Capability: IntelR Capability Licensing Service (CLS)  : ON
> ME Capability: IntelR Power Sharing Technology (MPC)      : OFF
> ME Capability: ICC Over Clocking                          : ON
> ME Capability: Protected Audio Video Path (PAVP)          : ON
> ME Capability: IPV6                                       : OFF
> ME Capability: KVM Remote Control (KVM)                   : OFF
> ME Capability: Outbreak Containment Heuristic (OCH)       : OFF
> ME Capability: Virtual LAN (VLAN)                         : ON
> ME Capability: TLS                                        : ON
> ME Capability: Wireless LAN (WLAN)                        : OFF
> 
> 
> me-u727.log-norm
> ----------------
> MEI found: [8086:9d3a] Sunrise Point-LP CSME HECI #1
> 
> ME Status   : 0xa0000245
> ME Status 2 : 0x89108106
> 
> ME: FW Partition Table      : OK
> ME: Bringup Loader Failure  : NO
> ME: Firmware Init Complete  : YES
> ME: Manufacturing Mode      : NO
> ME: Boot Options Present    : NO
> ME: Update In Progress      : NO
> ME: Current Working State   : Normal
> ME: Current Operation State : M0 with UMA
> ME: Current Operation Mode  : Normal
> ME: Error Code              : No Error
> ME: Progress Phase          : Clean Moff->Mx wake
> ME: Power Management Event  : Non-power cycle reset
> ME: Progress Phase State    : Unknown 0x10
> 
> ME: Extend Register not valid
> 
> ME: Firmware Version 11.6.3287.29 (code) 11.6.3287.29 (recovery) 11.6.3287.29 (fitc)
> 
> ME Capability: Full Network manageability                 : OFF
> ME Capability: Regular Network manageability              : OFF
> ME Capability: Manageability                              : ON
> ME Capability: Small business technology                  : ON
> ME Capability: Level III manageability                    : OFF
> ME Capability: IntelR Anti-Theft (AT)                     : OFF
> ME Capability: IntelR Capability Licensing Service (CLS)  : ON
> ME Capability: IntelR Power Sharing Technology (MPC)      : OFF
> ME Capability: ICC Over Clocking                          : OFF
> ME Capability: Protected Audio Video Path (PAVP)          : ON
> ME Capability: IPV6                                       : OFF
> ME Capability: KVM Remote Control (KVM)                   : OFF
> ME Capability: Outbreak Containment Heuristic (OCH)       : OFF
> ME Capability: Virtual LAN (VLAN)                         : ON
> ME Capability: TLS                                        : OFF
> ME Capability: Wireless LAN (WLAN)                        : OFF
> 
> 
> me-u757.log-norm
> ----------------
> MEI found: [8086:9d3a] Sunrise Point-LP CSME HECI #1
> 
> ME Status   : 0x90000245
> ME Status 2 : 0x89108106
> 
> ME: FW Partition Table      : OK
> ME: Bringup Loader Failure  : NO
> ME: Firmware Init Complete  : YES
> ME: Manufacturing Mode      : NO
> ME: Boot Options Present    : NO
> ME: Update In Progress      : NO
> ME: Current Working State   : Normal
> ME: Current Operation State : M0 with UMA
> ME: Current Operation Mode  : Normal
> ME: Error Code              : No Error
> ME: Progress Phase          : Clean Moff->Mx wake
> ME: Power Management Event  : Non-power cycle reset
> ME: Progress Phase State    : Unknown 0x10
> 
> ME: Extend Register not valid
> 
> ME: Firmware Version 11.8.3425.50 (code) 11.8.3425.50 (recovery) 11.8.3425.50 (fitc)
> 
> ME Capability: Full Network manageability                 : ON
> ME Capability: Regular Network manageability              : OFF
> ME Capability: Manageability                              : ON
> ME Capability: Small business technology                  : OFF
> ME Capability: Level III manageability                    : OFF
> ME Capability: IntelR Anti-Theft (AT)                     : OFF
> ME Capability: IntelR Capability Licensing Service (CLS)  : ON
> ME Capability: IntelR Power Sharing Technology (MPC)      : OFF
> ME Capability: ICC Over Clocking                          : OFF
> ME Capability: Protected Audio Video Path (PAVP)          : ON
> ME Capability: IPV6                                       : ON
> ME Capability: KVM Remote Control (KVM)                   : ON
> ME Capability: Outbreak Containment Heuristic (OCH)       : OFF
> ME Capability: Virtual LAN (VLAN)                         : ON
> ME Capability: TLS                                        : ON
> ME Capability: Wireless LAN (WLAN)                        : ON
> 
> 
> What do we make of this?
> 
You might try to contact your HW vendor. Probably your HW was Windows OS 
oriented.You may ask for a FW/NVM update no ME or try to replace the HW 
on none ME.
> I see same problem with both u757 and u727.
> No problem with either e736 and e754.
> 
> Jan-Marek
> 
Sasha
