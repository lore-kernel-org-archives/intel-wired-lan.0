From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 13 Oct 2015 21:48:15 +0200
Subject: [Intel-wired-lan] [PATCH] i40evf: fix 32 bit build warnings
In-Reply-To: <20151013122510.0000429f@unknown>
References: <6607276.TY67sbLLqL@wuerfel> <57023416.17EujnXPCo@wuerfel>
 <20151013122510.0000429f@unknown>
Message-ID: <8282870.qo6xugPiv7@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tuesday 13 October 2015 12:25:10 Jesse Brandeburg wrote:
> On Tue, 13 Oct 2015 13:37:04 +0200
> Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > On Monday 12 October 2015 23:18:21 you wrote:
> > > On Wed, 2015-10-07 at 22:13 +0200, Arnd Bergmann wrote:
> > > > Jesse Brandeburg fixed a bug for 32-bit systems in the i40e driver
> > > > in commit 9c70d7cebfec5 ("i40e: fix 32 bit build warnings"), but the
> > > > same code still exists in the i40evf driver and causes compilation
> > > > warnings in ARM and x86 allmodconfig:
> > > > 
> > > > drivers/net/ethernet/intel/i40evf/i40e_common.c:445:68: warning: cast
> > > > from pointer to integer of different size [-Wpointer-to-int-cast]
> > > > drivers/net/ethernet/intel/i40evf/i40e_common.c:446:71: warning: cast
> > > > from pointer to integer of different size [-Wpointer-to-int-cast]
> > > > 
> > > > This applies the same fix by removing the broken code.
> > > > 
> > > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > 
> > > Does not apply at all to my next-queue tree (dev-queue branch), my
> > > guess is that this is already fixed in one of the patches already in my
> > > queue.
> > > 
> > 
> > I still get these warnings on your branch:
> 
> Make sure you're pulling from the dev-queue branch, not the master
> branch of Jeff's next-queue repo.

Indeed, I was only looking at the branch that last got pulled into
net-next, assuming that was the one that was where the fixes for 4.3
are in. Sorry about that.

> I've made that mistake many times, and I do see that the code in
> question is not present in:
> https://git.kernel.org/cgit/linux/kernel/git/jkirsher/next-queue.git/tree/drivers/net/ethernet/intel/i40evf/i40e_common.c?h=dev-queue

Ok, I see your commit 7890f6979a8 ("i40evf: fix overlong BIT defines")
there now. Any chance to get that into mainline? The branch appears
to have a mix of new features and bug fixes, so it looks like it's
at least not destined for 4.3.

	Arnd
