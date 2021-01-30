From: Jakub Kicinski <kuba@kernel.org>
Date: Fri, 29 Jan 2021 16:27:42 -0800
Subject: [Intel-wired-lan] [PATCH net-next v3 2/8] taprio: Add support
 for frame preemption offload
In-Reply-To: <878s8bs5fp.fsf@vcostago-mobl2.amr.corp.intel.com>
References: <20210122224453.4161729-1-vinicius.gomes@intel.com>
 <20210122224453.4161729-3-vinicius.gomes@intel.com>
 <20210126000924.jjkjruzmh5lgrkry@skbuf>
 <87wnvvsayz.fsf@vcostago-mobl2.amr.corp.intel.com>
 <20210129135702.0f8cf702@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <878s8bs5fp.fsf@vcostago-mobl2.amr.corp.intel.com>
Message-ID: <20210129162742.6092753b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 29 Jan 2021 15:12:58 -0800 Vinicius Costa Gomes wrote:
> Jakub Kicinski <kuba@kernel.org> writes:
> >> Good catch :-)
> >> 
> >> I wanted to have this (at least one express queue) handled in a
> >> centralized way, but perhaps this should be handled best per driver.  
> >
> > Centralized is good. Much easier than reviewing N drivers to make sure
> > they all behave the same, and right.  
> 
> The issue is that it seems that not all drivers/hw have the same
> limitation: that at least one queue needs to be configured as
> express/not preemptible.

Oh, I thought that was something driven by the standard.
For HW specific checks driver doing it is obviously fine.

> That's the point I was trying to make when I suggested for the check to
> be done per-driver, different limitations.
