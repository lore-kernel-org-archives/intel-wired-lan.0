From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 22 Dec 2017 22:00:00 +0000
Subject: [Intel-wired-lan] [PATCH] e1000e: Fix
 e1000_check_for_copper_link_ich8lan return value.
In-Reply-To: <441de43f-4234-7616-2879-7e2e31a8d522@intel.com>
References: <20171208114552.5f517fd3@leda>
 <20171211072640.7935-1-bpoirier@suse.com>
 <441de43f-4234-7616-2879-7e2e31a8d522@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C71D3A3@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Neftin, Sasha
> Sent: Wednesday, December 20, 2017 10:57 PM
> To: Benjamin Poirier <bpoirier@suse.com>; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>; Gabriel C
> <nix.or.die@gmail.com>; netdev at vger.kernel.org; Christian Hesse
> <list@eworm.de>; stable at vger.kernel.org; linux-kernel at vger.kernel.org;
> intel-wired-lan at lists.osuosl.org
> Subject: Re: [Intel-wired-lan] [PATCH] e1000e: Fix
> e1000_check_for_copper_link_ich8lan return value.
> 
> On 11/12/2017 9:26, Benjamin Poirier wrote:
> > e1000e_check_for_copper_link() and
> e1000_check_for_copper_link_ich8lan()
> > are the two functions that may be assigned to mac.ops.check_for_link
> when
> > phy.media_type == e1000_media_type_copper. Commit 19110cfbb34d
> ("e1000e:
> > Separate signaling for link check/link up") changed the meaning of the
> > return value of check_for_link for copper media but only adjusted the first
> > function. This patch adjusts the second function likewise.
> >
> > Reported-by: Christian Hesse <list@eworm.de>
> > Reported-by: Gabriel C <nix.or.die@gmail.com>
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=198047
> > Fixes: 19110cfbb34d ("e1000e: Separate signaling for link check/link up")
> > Tested-by: Christian Hesse <list@eworm.de>
> > Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
> > ---
> >   drivers/net/ethernet/intel/e1000e/ich8lan.c | 11 ++++++++---
> >   1 file changed, 8 insertions(+), 3 deletions(-)
> >

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

> Acked by sasha.neftin at intel.com
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
