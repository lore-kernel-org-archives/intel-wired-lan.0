From: Jason Musgrove <j.musgrove@phoenixone.co.uk>
Date: Sat, 27 Feb 2016 20:21:57 +0000
Subject: [Intel-wired-lan] Intel 82753L loses MAC address on cold boot
Message-ID: <CAKfpcz5-1Hx8PYajC+xRAuEOZsYxFdw52kPGnYmU_8dy6mQFtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi all,

I'm hoping that this is the right list to ask for help with the above. I
have device of unknown heritage (second hand purchase) that is essentially
an based single board computer (Celeron with 915 chipset) in a network
device style chassis, with four 82753L GbE PCI-E NICs on the mainboard,
along with an Intel quad-port 10/100 (also part of the mainboard).

On each cold boot, the GbE NICs 'forget' their real MAC addresses and,
according to the e1000e driver, adopt either an unusual, but usable,
address along the lines of 00:20:00:00:10, or, worse, a blank address
00:00:00:00:00:00 and the driver rejects the card. Googling suggested a
possible EEPROM corruption, but using 'bootutil -ALL -DEFCFG' had no useful
effect.

However, if I allow the BIOS to start the Intel Boot Agent on these cards,
it successfully initialises the cards, reads back their correct MAC address
and, even if network booting is cancelled or unsuccessful, the correct MAC
address persists and the e1000e driver is happy with the cards ... until
the next cold boot, and the cards return to stated mentioned above (warm
reboots do not trigger the issue)

I've used 'ethtool -e' to dump the EEPROM contents from a card when it's
got a 'bad' (but usable) address, and from when it's been 'resurrected' by
the Boot Agent, and the outputs are identical - and the first 6 bytes in
each case carry the correct MAC address.

Has anyone encountered this kind of issue before, or any thoughts as to
what the Boot Agent does differently to the e1000e driver*?

Thanks in advance for any advice,

-Jason

*I've confirmed that this behaviour also occurs in the FreeBSD 'em' driver
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160227/1748b6e8/attachment.html>
