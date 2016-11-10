From: Corinna Vinschen <vinschen@redhat.com>
Date: Thu, 10 Nov 2016 18:28:07 +0100
Subject: [Intel-wired-lan] [PATCH] igb: use igb_adapter->io_addr instead
 of e1000_hw->hw_addr
In-Reply-To: <alpine.NEB.2.20.17.1611100544220.6177@chris.i8u.org>
References: <1478588780-24480-1-git-send-email-caoj.fnst@cn.fujitsu.com>
 <20161108164214.GF31855@calimero.vinschen.de>
 <alpine.NEB.2.20.17.1611080910530.6177@chris.i8u.org>
 <20161108183739.GA3744@calimero.vinschen.de>
 <CAKgT0UeaoGfOOC1=h4pGk+=FDd5EqvgRGAdk1StLuiW1-M8tVA@mail.gmail.com>
 <20161110093549.GA24351@calimero.vinschen.de>
 <alpine.NEB.2.20.17.1611100544220.6177@chris.i8u.org>
Message-ID: <20161110172807.GH24351@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Nov 10 05:48, Hisashi T Fujinaka wrote:
> On Thu, 10 Nov 2016, Corinna Vinschen wrote:
> > On Nov  8 11:33, Alexander Duyck wrote:
> ...
> > > The question I would have is what is reading the device when it is in
> > > this state.  The watchdog and any other functions that would read the
> > > device should be disabled.
> > > 
> > > One possibility could be a race between a call to igb_close and the
> > > igb_suspend function.  We have seen some of those pop up recently on
> > > ixgbe and it looks like igb has the same bug.  We should probably be
> > > using the rtnl_lock to guarantee that netif_device_detach and the call
> > > to __igb_close are completed before igb_close could possibly be called
> > > by the network stack.
> > 
> > Do you have a pointer to the related ixgbe patch, by any chance?
> ...
> Here's the initial patch for igb I have, but it's on hold awaiting more
> changes in ixgbe regarding AER.

Thanks a lot!


Corinna
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20161110/29f76546/attachment.asc>
