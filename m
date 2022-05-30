From: Sven Anders <sven.anders@anduras.de>
Date: Mon, 30 May 2022 17:53:45 +0200
Subject: [Intel-wired-lan] Bonding problem on Intel X710 hardware
In-Reply-To: <a94b23d2-57a8-954f-9fae-246cf900be92@intel.com>
References: <a94b23d2-57a8-954f-9fae-246cf900be92@intel.com>
Message-ID: <8d7813a5-c344-6225-dc1a-89a92e5cddb9@anduras.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>>> Hello!
>>>
>>> This is a follow up to my question. I did not hear anything so far, but I tried
>>> to find some some information meanwhile.
>>>
>>> I've got a guess from somebody, that the error message "Error I40E_AQ_RC_EINVAL
>>> adding RX filters on PF, promiscuous mode forced on" maybe triggered, because
>>> I'm hitting a limit here.
> 
> Yes, typically this is a response from our firmware that a table is full 
> in hardware, and I'm guessing that you might be running into a filter 
> limit due to using vlans?

That's what I suspect, but I did know the hardware and firmware insufficiently
to be sure.
What I'm wondering is: Why this is only triggered if I toggle the "ntuples support"
and not earlier when setting up the interface?

>>> Data packets are only received sporadically. If I run the same test
>>> with only one slave port, it works without problems.
> 
> And there are no counters going up in ethtool -S when you receive/drop 
> packets?

I'm not sure here. I tried to inspect the counters and it seems that the counters
are going up slower in this case, but it's difficult to say, because there is
some "noise" on the line and I do not have direct access to the hardware at the
moment.


If you need any further information or tests, just contact me.

Regards
   Sven Anders

-- 
   Sven Anders                  () UTF-8 Ribbon Campaign
                                                   /\ Support plain text e-mail
   ANDURAS intranet security AG
   Messestrasse 3 - 94036 Passau - Germany
   Web: www.anduras.de - Tel: +49 (0)851-4 90 50-0 - Fax: +49 (0)851-4 90 50-55

Those who would give up essential Liberty, to purchase a little
temporary Safety, deserve neither Liberty nor Safety.
    - Benjamin Franklin
