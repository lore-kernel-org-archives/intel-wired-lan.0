From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 26 Sep 2016 01:14:09 +0200
Subject: [Intel-wired-lan] [PATCH] igb: mark
	igb_rxnfc_write_vlan_prio_filter() static
In-Reply-To: <1474842217.2751.6.camel@intel.com>
References: <1474783558-7384-1-git-send-email-baoyou.xie@linaro.org>
 <1474842217.2751.6.camel@intel.com>
Message-ID: <201609260114.10052.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Monday 26 September 2016, Jeff Kirsher wrote:
> On Sun, 2016-09-25 at 14:05 +0800, Baoyou Xie wrote:
> > We get 1 warning when building kernel with W=1:
> > drivers/net/ethernet/intel/igb/igb_ethtool.c:2707:5: warning: no previous
> > prototype for 'igb_rxnfc_write_vlan_prio_filter' [-Wmissing-prototypes]
> > 
> > In fact, this function is only used in the file in which it is
> > declared and don't need a declaration, but can be made static.
> > so this patch marks this function with 'static'.
> > 
> > Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
> > ---
> >  drivers/net/ethernet/intel/igb/igb_ethtool.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> This has been fixed as well, and there is already a patch.

Baoyou,

I've seen you do this on other patches as well, please make sure
it doesn't happen again, and keep track of which patches you
have already sent out.

It can sometimes happen that a patch gets dropped by accident,
but none of the changes you sent so far are important enough
to warrant resending for the same kernel release.  If a patch
got posted multiple weeks before the merge window and still
has not made it into linux-next by the time the following
-rc2 release is out, you can resend it, but then it should
be marked in the subject line, e.g. [PATCH RESEND], and
an explanation below the '---' line why it got resent.

	Arnd
