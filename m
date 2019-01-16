From: Jan-Marek Glogowski <glogow@fbihome.de>
Date: Wed, 16 Jan 2019 18:33:43 +0100
Subject: [Intel-wired-lan] [RfC] fix auto-negotiation after reconnect
In-Reply-To: <8d6523ad-fccd-3bfa-aa8e-bc397f01c685@intel.com>
References: <e080046a-6630-ad07-ebbb-603e820766f4@fbihome.de>
 <1546608667-25498-1-git-send-email-glogow@fbihome.de>
 <23247527-7d7d-9e64-f4cf-adbf290c022d@fbihome.de>
 <8d6523ad-fccd-3bfa-aa8e-bc397f01c685@intel.com>
Message-ID: <56149f83-d9c8-6ab0-f74c-43de435d8cee@fbihome.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



Am 15.01.19 um 16:43 schrieb Neftin, Sasha:
> You can make changes and resend patches 1 and 3. There is 'u8' type use instead of 'u16' - I not
> sure in benefit of it. Debug prints from patch 3 are essential I thought.

Regarding the u8: after I used the the reference of &cmd->base.duplex in the
e1000e_get_speed_and_duplex_copper call, the compiler complained about duplex being u8 in the UAPI
struct, but u16 as the duplex reference parameter.

The same actually happened when I tried the &cmd->base.speed, where the UAPI is u32, but internally
e1000e uses u16 in a lot of places.

I decided to keep u16 speed and change the few u8 duplex places. Really don't care, but if you have
a preference, I'll change it before sending v2, using a temporary duplex variable.

> Regard your problem. Fujitsu can contacts our customer representative.

Already in touch with Fujitsu.

Thanks for your help!

Jan-Marek
