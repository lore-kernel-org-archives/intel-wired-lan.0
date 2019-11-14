From: Richard Cochran <richardcochran@gmail.com>
Date: Thu, 14 Nov 2019 11:44:10 -0800
Subject: [Intel-wired-lan] [PATCH net 08/13] ptp: Introduce strict
 checking of external time stamp options.
In-Reply-To: <02874ECE860811409154E81DA85FBB589698F6E0@ORSMSX121.amr.corp.intel.com>
References: <20191114184507.18937-9-richardcochran@gmail.com>
 <02874ECE860811409154E81DA85FBB589698F6E0@ORSMSX121.amr.corp.intel.com>
Message-ID: <20191114194410.GB19147@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Nov 14, 2019 at 07:12:38PM +0000, Keller, Jacob E wrote:
> So, this patch adds the flag *and* modifies the drivers to accept it, but not actually enable strict checking?
> 
> I'd prefer if this flag got added, and the drivers were modified in separate patches to both allow the flag and to perform the strict check.. that feels like a cleaner patch boundary.
> 
> That would ofcourse break the drivers that reject the strict command until they're fixed in follow-on commands.. hmm

You are right, but if anything I'd squash the following four driver
patches into this one.  I left the series in little steps just to make
review easier.  Strictly speaking, if you were to do a git bisect from
the introduction of the "2" ioctls until here, you would find drivers'
acceptance of the new flags changing.  But it is too late to fix that,
and I doubt anyone will care.

IMHO it *is* important to have v5.4 with strict checking.

Thanks,
Richard
