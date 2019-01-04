From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri, 04 Jan 2019 15:39:30 -0800
Subject: [Intel-wired-lan] [RfC] fix auto-negotiation after reconnect
In-Reply-To: <1546608667-25498-1-git-send-email-glogow@fbihome.de>
References: <e080046a-6630-ad07-ebbb-603e820766f4@fbihome.de>
 <1546608667-25498-1-git-send-email-glogow@fbihome.de>
Message-ID: <703de2439b3f7ebc3f63e524304f92c388a91ece.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2019-01-04 at 14:31 +0100, Jan-Marek Glogowski wrote:
> This patch set is just based on a guess from the status register on a
> failing
> reconnect. It works for me (TM), but I just have two different
> notebook series
> (Fujitsu U7x7 and E7x6). And it just happens for the U7x7 with I219-
> LM, not
> the E7x6 with I219-V.
> 
> Might be this patch just adds a little bit more time for the auto-
> negotiation
> to finish and there is a better way to "wait"...
> 
> The patches were developed and tested on vanilla 4.20 from Ubuntu,
> building as
> an external module. Before submission I applied them to todays Linus
> master,
> via "git am" without any conflicts, but I didn't compile them on
> master.
> I wanted to get some featback before putting more time into them.
> 
> Thanks for any feedback.
> 

The developers I want to review and comment on the issue, as well as
the changes you have submitted are into their weekend already due to
their location.  So reviews and feedback will most likely take 48 hours
or more.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190104/b45f7ba0/attachment.asc>
