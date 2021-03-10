From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Tue, 9 Mar 2021 21:12:07 -0800
Subject: [Intel-wired-lan] [RFC net-next] iavf: refactor plan proposal
In-Reply-To: <20210309141738.379feab3@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20210308162858.00004535@intel.com>
 <20210309141738.379feab3@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <20210309211207.000011df@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Jakub Kicinski wrote:

> On Mon, 8 Mar 2021 16:28:58 -0800 Jesse Brandeburg wrote:
> > Hello,
> > 
> > We plan to refactor the iavf module and would appreciate community and
> > maintainer feedback on our plans.  We want to do this to realize the
> > usefulness of the common code module for multiple drivers.  This
> > proposal aims to avoid disrupting current users.
> > 
> > The steps we plan are something like:
> > 1) Continue upstreaming of the iecm module (common module) and
> >    the initial feature set for the idpf driver[1] utilizing iecm.
> 
> Oh, that's still going? there wasn't any revision for such a long time
> I deleted my notes :-o

Argh! sorry about the delay. These proposed driver changes impacted
progress on this patch series, we should have done a better job
communicating what was going on.

> > We are looking to make sure that the mode of our refactoring will meet
> > the community's expectations. Any advice or feedback is appreciated.
> 
> Sounds like a slow, drawn out process painful to everyone involved.
> 
> The driver is upstream. My humble preference is that Intel sends small
> logical changes we can review, and preserve a meaningful git history.

We are attempting to make it as painless and quick as possible. With
that said, I see your point and am driving some internal discussions to
see what we can do differently.

The primary reason for the plan proposed is the code reuse model we've
chosen. With the change to the common module, the new iavf is
significantly different and replacing the old avf base with the new
would take many unnecessary intermediate steps that would be thrown
away at the end. The end design will use the code from the common
module with hooks to get device specific implementation where
necessary.  After putting in place the new-avf code we can update the
iavf with new functionality which is already present in the common
module.

Thanks,
 Jesse
