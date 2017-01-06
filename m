From: Duyck, Alexander H <alexander.h.duyck@intel.com>
Date: Fri, 6 Jan 2017 17:10:02 +0000
Subject: [Intel-wired-lan] [next PATCH 9/9] igb: Revert "igb: Revert
 support for build_skb in igb"
In-Reply-To: <1483720797.25700.60.camel@intel.com>
References: <20170106160850.2030.39073.stgit@localhost.localdomain>
 <20170106161131.2030.4342.stgit@localhost.localdomain>
 <1483720797.25700.60.camel@intel.com>
Message-ID: <1483722600.13286.18.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2017-01-06 at 08:39 -0800, Jeff Kirsher wrote:
> On Fri, 2017-01-06 at 08:11 -0800, Alexander Duyck wrote:
> > 
> > From: Alexander Duyck <alexander.h.duyck@intel.com>
> > 
> > This reverts commit f9d40f6a9921 ("igb: Revert support for build_skb in
> > igb") and adds a few changes to update it to work with the latest version
> > of igb. We are now able to revert the removal of this due to the fact
> > that with the recent changes to the page count and the use of
> > DMA_ATTR_SKIP_CPU_SYNC we can make the pages writable so we should not be
> > invalidating the additional data added when we call build_skb.
> > 
> > Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> > ---
> > ?drivers/net/ethernet/intel/igb/igb_main.c |?? 47
> > +++++++++++++++++++++++++++++
> > ?1 file changed, 47 insertions(+)
> 
> Weird, this patch is not showing up in patchworks.  I will get this patch
> added as well to my tree and work on getting it to show up in patchworks.
> 

Maybe it is the quotes in the patch description? ?If so feel free to
replace them with some other form of punctuation if needed.

- Alex
