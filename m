From: Kai Heng Feng <kai.heng.feng@canonical.com>
Date: Tue, 2 Jul 2019 16:25:59 +0800
Subject: [Intel-wired-lan] RX CRC errors on I219-V (6) 8086:15be
In-Reply-To: <1804A45E-71B5-4C41-839C-AF0CFAD0D785@canonical.com>
References: <C4036C54-EEEB-47F3-9200-4DD1B22B4280@canonical.com>
 <3975473C-B117-4DC6-809A-6623A5A478BF@canonical.com>
 <ed4eca8e-d393-91d7-5d2f-97d42e0b75cb@intel.com>
 <1804A45E-71B5-4C41-839C-AF0CFAD0D785@canonical.com>
Message-ID: <E29A2CD2-1632-4575-9910-0808BD15F4D3@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

+linux-pci

Hi Sasha,

at 6:49 PM, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:

> at 14:26, Neftin, Sasha <sasha.neftin@intel.com> wrote:
>
>> On 6/26/2019 09:14, Kai Heng Feng wrote:
>>> Hi Sasha
>>> at 5:09 PM, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
>>>> Hi Jeffrey,
>>>>
>>>> We?ve encountered another issue, which causes multiple CRC errors and  
>>>> renders ethernet completely useless, here?s the network stats:
>>> I also tried ignore_ltr for this issue, seems like it alleviates the  
>>> symptom a bit for a while, then the network still becomes useless after  
>>> some usage.
>>> And yes, it?s also a Whiskey Lake platform. What?s the next step to  
>>> debug this problem?
>>> Kai-Heng
>> CRC errors not related to the LTR. Please, try to disable the ME on your  
>> platform. Hope you have this option in BIOS. Another way is to contact  
>> your PC vendor and ask to provide NVM without ME. Let's start debugging  
>> with these steps.
>
> According to ODM, the ME can be physically disabled by a jumper.
> But after disabling the ME the same issue can still be observed.

We?ve found that this issue doesn?t happen to SATA SSD, it only happens  
when NVMe SSD is in use.

Here are the steps:
- Disable NVMe ASPM, issue persists
- modprobe -r e1000e && modprobe e1000e, issue doesn?t happen
- Enabling NVMe ASPM, issue doesn?t happen

As long as NVMe ASPM gets enabled after e1000e gets loaded, the issue  
doesn?t happen.

Do you have any idea how those two are intertwined together?

Kai-Heng

>
> Kai-Heng
>
>>>> /sys/class/net/eno1/statistics$ grep . *
>>>> collisions:0
>>>> multicast:95
>>>> rx_bytes:1499851
>>>> rx_compressed:0
>>>> rx_crc_errors:1165
>>>> rx_dropped:0
>>>> rx_errors:2330
>>>> rx_fifo_errors:0
>>>> rx_frame_errors:0
>>>> rx_length_errors:0
>>>> rx_missed_errors:0
>>>> rx_nohandler:0
>>>> rx_over_errors:0
>>>> rx_packets:4789
>>>> tx_aborted_errors:0
>>>> tx_bytes:864312
>>>> tx_carrier_errors:0
>>>> tx_compressed:0
>>>> tx_dropped:0
>>>> tx_errors:0
>>>> tx_fifo_errors:0
>>>> tx_heartbeat_errors:0
>>>> tx_packets:7370
>>>> tx_window_errors:0
>>>>
>>>> Same behavior can be observed on both mainline kernel and on your  
>>>> dev-queue branch.
>>>> OTOH, the same issue can?t be observed on out-of-tree e1000e.
>>>>
>>>> Is there any plan to close the gap between upstream and out-of-tree  
>>>> version?
>>>>
>>>> Kai-Heng


