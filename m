From: Jan-Marek Glogowski <glogow@fbihome.de>
Date: Fri, 18 Jan 2019 16:32:31 +0100
Subject: [Intel-wired-lan] e1000e driver stuck at 10Mbps after
 reconnection
In-Reply-To: <e080046a-6630-ad07-ebbb-603e820766f4@fbihome.de>
References: <e080046a-6630-ad07-ebbb-603e820766f4@fbihome.de>
Message-ID: <a24aaa18-f16f-b254-9d48-9dfa8792dd5d@fbihome.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

So I've updated both my test notebooks (U757 and U727).
Both latest BIOS + a new ME (11.8.55.3510) I got from Fujitsu.
"Unconfigured" ME in the BIOS - again, just in case.

I think 1000Mbps became more stable. But then I saw 10Mbps when I first connected the port late
during boot, way after the driver is loaded. Now that seems to be the most reliable way to trigger
the bug. Most time reconnect works keeping 1000 Mbits, which is definitely an improvement.

Just tested:
* unplug
* rmmod e1000e
* modprobe e1000e
* connect
* => always 10 Mbps

Still:
* plugged
* rmmod e1000e
* modprobe e1000e
* => always 1000 Mbps

On 10 MBits I can get back to 1000 Mbits, if I just unplug for a very short time, keeping the cable
still in the port; so maybe the poll worker doesn't yet kick in to break something?

No difference between 4.15 and 5.0-rc2 vanilla, FWIW.

My broken patch still works. I sometimes get a "0x40080003" and ignore that and then react to the
correct "0x80083". Compared to my other HW the 0x40000000 is just set in the "error" case, not always.

FWIW current intelmetool -m output diff is:

@@ -1,7 +1,7 @@
 MEI found: [8086:9d3a] Sunrise Point-LP CSME HECI #1

 ME Status   : 0x90000245
-ME Status 2 : 0x89108106
+ME Status 2 : 0x89118106

 ME: FW Partition Table      : OK
 ME: Bringup Loader Failure  : NO
@@ -15,11 +15,11 @@
 ME: Error Code              : No Error
 ME: Progress Phase          : Clean Moff->Mx wake
 ME: Power Management Event  : Non-power cycle reset
-ME: Progress Phase State    : Unknown 0x10
+ME: Progress Phase State    : Unknown 0x11

 ME: Extend Register not valid

-ME: Firmware Version 11.8.3425.50 (code) 11.8.3425.50 (recovery) 11.8.3425.50 (fitc)
+ME: Firmware Version 11.8.3510.55 (code) 11.8.3510.55 (recovery) 11.8.3425.50 (fitc)

 ME Capability: Full Network manageability                 : ON
 ME Capability: Regular Network manageability              : OFF

And I tried to blacklist mei and mei_me kernel modules, not really expecting a change. Also no
difference.

I'm thinking of simply providing some kind of DMI-based-quirk to enable my special code path just
for this HW. I'm open for any additional suggestions.

Fujitsu has basically the same info and I'm waiting for an answer next week, as it's almost weekend.

I guess because of the 0x40000000 bit it's still a ME related problem.

Enough network plugging for this week. Hope I have more luck with my usb-c problem?

Jan-Marek
