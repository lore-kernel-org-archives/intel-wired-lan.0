From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Mon, 20 Dec 2021 19:56:28 +0000
Subject: [Intel-wired-lan] [PATCH net] igb: fix deadlock caused by
 taking RTNL in RPM resume path
In-Reply-To: <edb8c052-9d20-d190-54e2-ed9bb03ba204@leemhuis.info>
References: <6bb28d2f-4884-7696-0582-c26c35534bae@gmail.com>
 <edb8c052-9d20-d190-54e2-ed9bb03ba204@leemhuis.info>
Message-ID: <b4be04bbd6a20855526b961ef80669bd2647564c.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sun, 2021-12-19 at 09:31 +0100, Thorsten Leemhuis wrote:
> Hi, this is your Linux kernel regression tracker speaking.
> 
> On 29.11.21 22:14, Heiner Kallweit wrote:
> > Recent net core changes caused an issue with few Intel drivers
> > (reportedly igb), where taking RTNL in RPM resume path results in a
> > deadlock. See [0] for a bug report. I don't think the core changes
> > are wrong, but taking RTNL in RPM resume path isn't needed.
> > The Intel drivers are the only ones doing this. See [1] for a
> > discussion on the issue. Following patch changes the RPM resume
> > path
> > to not take RTNL.
> > 
> > [0] https://bugzilla.kernel.org/show_bug.cgi?id=215129
> > [1]
> > https://lore.kernel.org/netdev/20211125074949.5f897431 at kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com/t/
> > 
> > Fixes: bd869245a3dc ("net: core: try to runtime-resume detached
> > device in __dev_open")
> > Fixes: f32a21376573 ("ethtool: runtime-resume netdev parent before
> > ethtool ioctl ops")
> > Tested-by: Martin Stolpe <martin.stolpe@gmail.com>
> > Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> Long story short: what is taken this fix so long to get mainlined? It
> to
> me seems progressing unnecessary slow, especially as it's a
> regression
> that made it into v5.15 and thus for weeks now seems to bug more and
> more people.
> 
> 
> The long story, starting with the background details:
> 
> The quoted patch fixes a regression among others caused by
> f32a21376573
> ("ethtool: runtime-resume netdev parent before ethtool ioctl ops"),
> which got merged for v5.15-rc1.
> 
> The regression ("kernel hangs during power down") was afaik first
> reported on Wed, 24 Nov (IOW: nearly a month ago) and forwarded to
> the
> list shortly afterwards:
> https://bugzilla.kernel.org/show_bug.cgi?id=215129
> https://lore.kernel.org/netdev/20211124144505.31e15716 at hermes.local/
> 
> The quoted patch to fix the regression was posted on Mon, 29 Nov (thx
> Heiner for providing it!). Obviously reviewing patches can take a few
> days when they are complicated, as the other messages in this thread
> show. But according to
> https://bugzilla.kernel.org/show_bug.cgi?id=215129#c8?the patch was
> ACKed by Thu, 7 Dec. To quote: ```The patch is on its way via the
> Intel
> network driver tree:
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/tnguy/net-queue/+/refs/heads/dev-queue```
> 
> And that's where the patch afaics still is. It hasn't even reached
> linux-next yet, unless I'm missing something. A merge into mainline
> thus
> is not even in sight; this seems especially bad with the holiday
> season
> coming up, as getting the fix mainlined is a prerequisite to get it
> backported to 5.15.y, as our latest stable kernel is affected by
> this.

I've been waiting for our validation team to get to this patch to do
some additional testing. However, as you mentioned, with the holidays
coming up, it seems the tester is now out. As it looks like some in the
community have been able to do some testing on this, I'll go ahead and
send this on.

Thanks,
Tony



