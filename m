From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Mon, 26 Oct 2015 20:50:45 +0000
Subject: [Intel-wired-lan] [PATCH net-next 0/4] Automatic adjustment of
	max frame size
In-Reply-To: <562D7A33.4020603@lab.ntt.co.jp>
References: <1445572173-15402-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
 <562B4673.7020608@gmail.com> <562D7A33.4020603@lab.ntt.co.jp>
Message-ID: <1445892645.15482.3.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2015-10-26 at 09:56 +0900, Toshiaki Makita wrote:
> On 2015/10/24 17:50, Toshiaki Makita wrote:
> > David,
> > 
> > I found my patch set is marked with Changes Requested, but I
> > haven't
> > seen any feedback.
> > 
> > Could you give me your feedback?
> 
> Somehow the mail from LD Linux CI Server did not reach netdev mailing
> list so I could not have seen it from gmail...
> 
> Toshiaki Makita
> 

the ND Linux Bot is only checking against the Intel mailing list  
intel-wired-lan at lists.osuosl.org, and isn't subscribed to netdev.

I am not sure why it failed to mail to it, unless netdev blocks non
subscribers from sending mail (it probably does)

The checkpatch output here is likely ignorable, note how it shows up as
a warning. You can fix them if you feel there is a reasonable way to
shorten the line. In this case, I probably wouldn't unless you want to
perform the VLAN and ETH_FRAME LEN calculation once somewhere else...

Generally being close to 80, (81,82 etc) is probably ok, as long as
there isn't an obvious nicer way to shorten the line.

Regards,
Jake
