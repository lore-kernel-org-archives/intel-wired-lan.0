From: Jakub Kicinski <kuba@kernel.org>
Date: Fri, 23 Apr 2021 15:58:36 -0700
Subject: [Intel-wired-lan] [igb] netconsole triggers warning in
 netpoll_poll_dev
In-Reply-To: <20210423081944.kvvm4v7jcdyj74l3@spock.localdomain>
References: <20210406123619.rhvtr73xwwlbu2ll@spock.localdomain>
 <20210406114734.0e00cb2f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20210407060053.wyo75mqwcva6w6ci@spock.localdomain>
 <20210407083748.56b9c261@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CAKgT0UfLLQycLsAZQ98ofBGYPwejA6zHbG6QsNrU92mizS7e0g@mail.gmail.com>
 <20210407110722.1eb4ebf2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CAKgT0UcQXVOifi_2r_Y6meg_zvHDBf1me8VwA4pvEtEMzOaw2Q@mail.gmail.com>
 <20210423081944.kvvm4v7jcdyj74l3@spock.localdomain>
Message-ID: <20210423155836.25ef1e77@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 23 Apr 2021 10:19:44 +0200 Oleksandr Natalenko wrote:
> On Wed, Apr 07, 2021 at 04:06:29PM -0700, Alexander Duyck wrote:
> > On Wed, Apr 7, 2021 at 11:07 AM Jakub Kicinski <kuba@kernel.org> wrote:  
> > > Sure, that's simplest. I wasn't sure something is supposed to prevent
> > > this condition or if it's okay to cover it up.  
> > 
> > I'm pretty sure it is okay to cover it up. In this case the "budget -
> > 1" is supposed to be the upper limit on what can be reported. I think
> > it was assuming an unsigned value anyway.
> > 
> > Another alternative would be to default clean_complete to !!budget.
> > Then if budget is 0 clean_complete would always return false.  
> 
> So, among all the variants, which one to try? Or there was a separate
> patch sent to address this?

Alex's suggestion is probably best.

I'm not aware of the fix being posted. Perhaps you could take over and
post the patch if Intel doesn't chime in?
