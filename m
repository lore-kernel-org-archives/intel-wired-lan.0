From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 3 Dec 2020 09:41:00 -0800
Subject: [Intel-wired-lan] [PATCH net] iavf: fix double-release of
 rtnl_lock
In-Reply-To: <1867f98e7951f8d044a7dbf16fcf6a93996914f7.camel@intel.com>
References: <20201203021806.692194-1-kuba@kernel.org>
 <1867f98e7951f8d044a7dbf16fcf6a93996914f7.camel@intel.com>
Message-ID: <20201203094100.516612a1@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 3 Dec 2020 17:04:14 +0000 Nguyen, Anthony L wrote:
> On Wed, 2020-12-02 at 18:18 -0800, Jakub Kicinski wrote:
> > This code does not jump to exit on an error in iavf_lan_add_device(),
> > so the rtnl_unlock() from the normal path will follow.
> > 
> > Fixes: b66c7bc1cd4d ("iavf: Refactor init state machine")
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > ---
> >  drivers/net/ethernet/intel/iavf/iavf_main.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)  
> 
> Reviewed-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> 
> Did you want to apply this or did you want me to take it?

Please take it, I'm currently running with the assumption that you'll
take all Intel patches (minus some corner cases, maybe, like patches
which are part of some cross-tree series with dependencies).

Thanks!
