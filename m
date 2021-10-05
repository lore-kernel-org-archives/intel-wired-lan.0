From: Sasha Neftin <sasha.neftin@intel.com>
Date: Tue, 5 Oct 2021 09:50:47 +0300
Subject: [Intel-wired-lan] Intel I350 regression 5.10 -> 5.14 ("The NVM
 Checksum Is Not Valid") [8086:1521]
In-Reply-To: <7064659e-fe97-f222-5176-844569fb5281@twofifty.com>
References: <1823864.tdWV9SEqCh@kailua>
 <20211004074814.5900791a@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <7064659e-fe97-f222-5176-844569fb5281@twofifty.com>
Message-ID: <4111f2b7-cbac-3451-593f-a154aca65263@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 10/5/2021 02:39, Hisashi T Fujinaka wrote:
> On Mon, 4 Oct 2021, Jakub Kicinski wrote:
> 
>> On Mon, 04 Oct 2021 15:06:31 +0200 Andreas K. Huettel wrote:
>>> Dear all,
>>>
>>> I hope this is the right place to ask, if not please advise me where 
>>> to go.
>>
>> Adding intel-wired-lan at lists.osuosl.org and Sasha as well.
>>
>>> I have a new Dell machine with both an Intel on-board ethernet 
>>> controller
>>> ([8086:15f9]) and an additional 2-port extension card ([8086:1521]).
>>>
>>> The second adaptor, a "DeLock PCIe 2xGBit", worked fine as far as I 
>>> could
>>> see with Linux 5.10.59, but fails to initialize with Linux 5.14.9.
>>>
>>> dilfridge ~ # lspci -nn
>>> [...]
>>> 01:00.0 Ethernet controller [0200]: Intel Corporation I350 Gigabit 
>>> Network Connection [8086:1521] (rev ff)
>>> 01:00.1 Ethernet controller [0200]: Intel Corporation I350 Gigabit 
>>> Network Connection [8086:1521] (rev ff)
>>> [...]
>>>
>>> dilfridge ~ # dmesg|grep igb
>>> [??? 2.069286] igb: Intel(R) Gigabit Ethernet Network Driver
>>> [??? 2.069288] igb: Copyright (c) 2007-2014 Intel Corporation.
>>> [??? 2.069305] igb 0000:01:00.0: can't change power state from D3cold 
>>> to D0 (config space inaccessible)
>>> [??? 2.069624] igb 0000:01:00.0 0000:01:00.0 (uninitialized): PCIe 
>>> link lost
>>> [??? 2.386659] igb 0000:01:00.0: PHY reset is blocked due to SOL/IDER 
>>> session.
>>> [??? 4.115500] igb 0000:01:00.0: The NVM Checksum Is Not Valid
>>> [??? 4.133807] igb: probe of 0000:01:00.0 failed with error -5
>>> [??? 4.133820] igb 0000:01:00.1: can't change power state from D3cold 
>>> to D0 (config space inaccessible)
>>> [??? 4.134072] igb 0000:01:00.1 0000:01:00.1 (uninitialized): PCIe 
>>> link lost
>>> [??? 4.451602] igb 0000:01:00.1: PHY reset is blocked due to SOL/IDER 
>>> session.
>>> [??? 6.180123] igb 0000:01:00.1: The NVM Checksum Is Not Valid
>>> [??? 6.188631] igb: probe of 0000:01:00.1 failed with error -5
>>>
>>> Any advice on how to proceed? Willing to test patches and provide 
>>> additional debug info.
> 
> Sorry to reply from a non-Intel account. I would suggest first
> contacting Dell, and then contacting DeLock. This sounds like an issue
> with motherboard firmware and most of what I can help with would be with
> the driver. I think the issues are probably before things get to the
> driver.
> 
Agree. The driver starts work when the PCIe link in L0. Please, check 
with Dell/DeLock what is PCIe link status and enumeration process 
finished as properly.(probably you will need PCIe sniffer)

> Todd Fujinaka <todd.fujinaka@intel.com>
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan

