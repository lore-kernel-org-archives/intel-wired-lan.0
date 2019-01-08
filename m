From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Tue, 8 Jan 2019 11:15:05 +0100
Subject: [Intel-wired-lan] [PATCH 2/3] e1000e: ignore status during
 auto-negotiation
In-Reply-To: <a952ef24-b28b-39f4-35dd-cb6aa7ffb25f@fbihome.de>
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
Message-ID: <95d4d060-83d3-232f-5199-b2a18422f27d@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Jan-Marek,


On 01/08/19 10:59, Jan-Marek Glogowski wrote:

> Am 08.01.19 um 09:31 schrieb Neftin, Sasha:
>> On 1/7/2019 18:37, Jan-Marek Glogowski wrote:

[?]

>> Since you still read 0x40000000 value in the status register it is causing me to think that ME
>> works. Another way I think you should to go ask your vendors for last updated NVM (or with ME
>> disabled if possible) for your HW. Since I219V works as properly, I expected I219-LM without ME
>> works too.
> 
> From the logs I sent:
> 
> I217-LM: "status 0x40080083 => 1000 Mbps, Full Duplex"
> I219-V: "status 0x40080083 => 1000 Mbps, Full Duplex"
> I219-LM auto-nego ok: "status 0x80083 => 1000 Mbps, Full Duplex"
> I219-LM auto-nego broken: "status 0x40080003 => 10 Mbps, Full Duplex"
> 
> According to the BIOS both LM-variants have Intel ME disabled. If I can't trust the BIOS, is there a
> way to check this?

What does intelmetool from the coreboot project show?

    $ git clone https://review.coreboot.org/coreboot.git
    $ cd coreboot
    $ cd util/intelmetoolo
    $ make -j
    $ sudo ./intelmetool -m


Kind regards,

Paul

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 5174 bytes
Desc: S/MIME Cryptographic Signature
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190108/5ccc4c52/attachment-0001.p7s>
