From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Fri, 15 Apr 2016 11:19:13 -0700
Subject: [Intel-wired-lan] [next PATCH S35 11/14] i40e/i40evf: Refactor
 receive routine
In-Reply-To: <CAKgT0UfHqgZ=874HiTR6osxFO=y24Z6=a1Q-0E8ab+s9DFsOCw@mail.gmail.com>
References: <1460639974-2556-1-git-send-email-harshitha.ramamurthy@intel.com>
 <1460639974-2556-12-git-send-email-harshitha.ramamurthy@intel.com>
 <CAKgT0UfHqgZ=874HiTR6osxFO=y24Z6=a1Q-0E8ab+s9DFsOCw@mail.gmail.com>
Message-ID: <20160415111913.00007d33@unknown>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 15 Apr 2016 10:25:37 -0700
Alexander Duyck <alexander.duyck@gmail.com> wrote:
> If due to only the size I really think this should probably be split
> into two patches.  One for the VF and one for the PF.  That way we
> should only be looking at about 1000 lines of change per patch instead
> of 2000 which becomes a bit unwieldy.  If nothing else it makes the
> reviews easier to read as we don't end up with a novel with review
> comments scattered throughout.

Thanks for all your comments Alex, they're really useful.  I can split
the patches into (at least) two.

As far as the comments go, most seem to be tweaks/tuning, and unless I
missed it not any bugs yet (but I know the patch was huge)

So, would it be at all reasonable to proceed with the code basically
unchanged except for splitting it up, if no bugs are noticed during
review?  Then I will follow up with a cleanup series?

Thanks,
 Jesse
