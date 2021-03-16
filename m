From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Tue, 16 Mar 2021 15:02:10 -0700
Subject: [Intel-wired-lan] [PATCH] iavf: fix locking of critical sections
In-Reply-To: <20210316132905.5d0f90dd@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20210316100141.53551-1-sassmann@kpanic.de>
 <20210316101443.56b87cf6@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <44b3f5f0-93f8-29e2-ab21-5fd7cc14c755@kpanic.de>
 <20210316132905.5d0f90dd@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <20210316150210.00007249@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Jakub Kicinski wrote:
> > > I personally think that the overuse of flags in Intel drivers brings
> > > nothing but trouble. At which point does it make sense to just add a
> > > lock / semaphore here rather than open code all this with no clear
> > > semantics? No code seems to just test the __IAVF_IN_CRITICAL_TASK flag,
> > > all the uses look like poor man's locking at a quick grep. What am I
> > > missing?
> > 
> > I agree with you that the locking could be done with other locking
> > mechanisms just as good. I didn't invent the current method so I'll let
> > Intel comment on that part, but I'd like to point out that what I'm
> > making use of is fixing what is currently in the driver.
> 
> Right, I should have made it clear that I don't blame you for the
> current state of things. Would you mind sending a patch on top of 
> this one to do a conversion to a semaphore? 
> 
> Intel folks any opinions?

I know Slawomir has been working closely with Stefan on figuring out
the right ways to fix this code.  Hopefully he can speak for himself,
but I know he's on Europe time.

As for conversion to mutexes I'm a big fan, and as long as we don't
have too many collisions with the RTNL lock I think it's a reasonable
improvement to do, and if Stefan doesn't want to work on it, we can
look into whether Slawomir or his team can.

