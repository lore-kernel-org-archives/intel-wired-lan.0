From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Fri, 11 Sep 2020 12:00:05 -0700
Subject: [Intel-wired-lan] [RFC PATCH net-next v1 00/11] make
 drivers/net/ethernet W=1 clean
In-Reply-To: <20200911075515.6d81066b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20200911012337.14015-1-jesse.brandeburg@intel.com>
 <20200911075515.6d81066b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <20200911120005.00000178@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Jakub Kicinski wrote:

> On Thu, 10 Sep 2020 18:23:26 -0700 Jesse Brandeburg wrote:
> > Some of these patches are already sent to Intel Wired Lan, but the rest
> > of the series titled drivers/net/ethernet affects other drivers, not
> > just Intel, but they depend on the first five.
> 
> Great stuff. Much easier to apply one large series than a thousand
> small patches. I haven't read all the comment changes but FWIW:
> 
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>

Thanks!

> I feel slightly bad for saying this but I think your config did not
> include all the drivers, 'cause I'm still getting some warnings after
> patch 11. Regardless this is impressive effort, thanks!

No worries! I want to get it right, can you share your methodology?

I saw from some other message that you're doing
make CC="ccache gcc" allmodconfig
make CC="ccache gcc" -j 64 W=1 C=1

Is that the right sequence? did you start with a make mrproper as well?
I may have missed some drivers when I did this:
make allyesconfig
make menuconfig
<turn on all "Ethernet Drivers" = m manually>

but I'd like to target the actual job you're running and use that as
the short-term goal.

Also, if you have any comments about the removal of the lvalue from
some of the register read operations, I figure that is the riskiest
part of all this.
