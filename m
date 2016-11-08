From: Corinna Vinschen <vinschen@redhat.com>
Date: Tue, 8 Nov 2016 19:37:39 +0100
Subject: [Intel-wired-lan] [PATCH] igb: use igb_adapter->io_addr instead
 of e1000_hw->hw_addr
In-Reply-To: <alpine.NEB.2.20.17.1611080910530.6177@chris.i8u.org>
References: <1478588780-24480-1-git-send-email-caoj.fnst@cn.fujitsu.com>
 <20161108164214.GF31855@calimero.vinschen.de>
 <alpine.NEB.2.20.17.1611080910530.6177@chris.i8u.org>
Message-ID: <20161108183739.GA3744@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Nov  8 09:16, Hisashi T Fujinaka wrote:
> On Tue, 8 Nov 2016, Corinna Vinschen wrote:
> > On Nov  8 15:06, Cao jin wrote:
> > > When running as guest, under certain condition, it will oops as following.
> > > writel() in igb_configure_tx_ring() results in oops, because hw->hw_addr
> > > is NULL. While other register access won't oops kernel because they use
> > > wr32/rd32 which have a defense against NULL pointer.
> > > [...]
> > 
> > Incidentally we're just looking for a solution to that problem too.
> > Do three patches to fix the same problem at rougly the same time already
> > qualify as freak accident?
> > 
> > FTR, I attached my current patch, which I was planning to submit after
> > some external testing.
> > 
> > However, all three patches have one thing in common:  They workaround
> > a somewhat dubious resetting of the hardware address to NULL in case
> > reading from a register failed.
> > 
> > That makes me wonder if setting the hardware address to NULL in
> > rd32/igb_rd32 is really such a good idea.  It's performed in a function
> > which return value is *never* tested for validity in the calling
> > functions and leads to subsequent crashes since no tests for hw_addr ==
> > NULL are performed.
> > 
> > Maybe commit 22a8b2915 should be reconsidered?  Isn't there some more
> > graceful way to handle the "surprise removal"?
> 
> Answering this from my home account because, well, work is Outlook.
> 
> "Reconsidering" would be great. In fact, revert if if you'd like. I'm
> uncertain that the surprise removal code actually works the way I
> thought previously and I think I took a lot of it out of my local code.
> 
> Unfortuantely I don't have any equipment that I can use to reproduce
> surprise removal any longer so that means I wouldn't be able to test
> anything. I have to defer to you or Cao Jin.

I'm not too keen to rip out a PCIe NIC under power from my locale
desktop machine, but I think an actual surprise removal is not the
problem.

As described in my git log entry, the error condition in igb_rd32 can be
triggered during a suspend.  The HW has been put into a sleep state but
some register read requests are apparently not guarded against that
situation.  Reading a register in this state returns -1, thus a suspend
is erroneously triggering the "surprise removal" sequence.

Here's a raw idea:

- Note that device is suspended in e1000_hw struct.  Don't trigger
  error sequence in igb_rd32 if so (...and return a 0 value???)

- Otherwise assume it's actually a surprise removal.  In theory that
  should somehow trigger a device removal sequence, kind of like
  calling igb_remove, no?


Thanks,
Corinna
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20161108/13180795/attachment-0001.asc>
