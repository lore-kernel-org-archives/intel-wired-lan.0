From: Jan-Marek Glogowski <glogow@fbihome.de>
Date: Fri,  4 Jan 2019 14:31:04 +0100
Subject: [Intel-wired-lan] [RfC] fix auto-negotiation after reconnect
In-Reply-To: <e080046a-6630-ad07-ebbb-603e820766f4@fbihome.de>
References: <e080046a-6630-ad07-ebbb-603e820766f4@fbihome.de>
Message-ID: <1546608667-25498-1-git-send-email-glogow@fbihome.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch set is just based on a guess from the status register on a failing
reconnect. It works for me (TM), but I just have two different notebook series
(Fujitsu U7x7 and E7x6). And it just happens for the U7x7 with I219-LM, not
the E7x6 with I219-V.

Might be this patch just adds a little bit more time for the auto-negotiation
to finish and there is a better way to "wait"...

The patches were developed and tested on vanilla 4.20 from Ubuntu, building as
an external module. Before submission I applied them to todays Linus master,
via "git am" without any conflicts, but I didn't compile them on master.
I wanted to get some featback before putting more time into them.

Thanks for any feedback.

Jan-Marek

