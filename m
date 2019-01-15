From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Tue, 15 Jan 2019 17:43:49 +0200
Subject: [Intel-wired-lan] [RfC] fix auto-negotiation after reconnect
In-Reply-To: <23247527-7d7d-9e64-f4cf-adbf290c022d@fbihome.de>
References: <e080046a-6630-ad07-ebbb-603e820766f4@fbihome.de>
 <1546608667-25498-1-git-send-email-glogow@fbihome.de>
 <23247527-7d7d-9e64-f4cf-adbf290c022d@fbihome.de>
Message-ID: <8d6523ad-fccd-3bfa-aa8e-bc397f01c685@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 1/15/2019 17:22, Jan-Marek Glogowski wrote:
> Hi,
> 
> I still don't know how to proceed. The last statement for patch 2 is:
> 
> Am 09.01.19 um 16:07 schrieb Neftin, Sasha:
> 
>> You might try to contact your HW vendor. Probably your HW was Windows OS oriented.
>> You may ask for a FW/NVM update no ME or try to replace the HW on none ME.
> 
> So this hardware is a build-in part of laptops. I don't know if there will be Linux or Windows
> installed on them. I can't make much sense of "Probably your HW was Windows OS oriented".
> I'll talk with our hardware supplier, which can probably talk with Fujitsu, if this needs some
> firmware based fix. Should I point them to this thread and ask them to contact Intel?
> 
> As I already wrote the old hardware worked fine and also has ME enabled, which can't be completely
> disabled AFAIK.
> 
> Then there is still patch 1 and 3, which I will re-send independent of the broken 2nd patch.
> 
> Anything else that can or should be done?
> 
> Jan-Marek
> 
> 
> 
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
> 
You can make changes and resend patches 1 and 3. There is 'u8' type use 
instead of 'u16' - I not sure in benefit of it. Debug prints from patch 
3 are essential I thought.
Regard your problem. Fujitsu can contacts our customer representative.
Sasha
