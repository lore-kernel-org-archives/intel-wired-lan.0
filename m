From: Thomas Graf <tgraf@suug.ch>
Date: Fri, 10 Apr 2015 09:48:56 +0100
Subject: [Intel-wired-lan] [PATCH 1/3 net-next] e1000: Allocate
 pm_qos_req as needed
In-Reply-To: <55278377.8030505@iogearbox.net>
References: <cover.1428622095.git.tgraf@suug.ch>
 <99ad8b242a65a60e2a76e952b4c91de2b54a0013.1428622095.git.tgraf@suug.ch>
 <1428624503.2729.55.camel@jtkirshe-mobl>
 <1428640539.2729.67.camel@jtkirshe-mobl>
 <55278377.8030505@iogearbox.net>
Message-ID: <20150410084856.GC23070@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 04/10/15 at 10:01am, Daniel Borkmann wrote:
> On 04/10/2015 06:35 AM, Jeff Kirsher wrote:
> >On Thu, 2015-04-09 at 17:08 -0700, Jeff Kirsher wrote:
> >>On Fri, 2015-04-10 at 01:43 +0200, Thomas Graf wrote:
> >>>e1000 is the only driver requiring pm_qos_req, instead of causing
> >>>every device to waste up to 240 bytes. Allocate it for the specific
> >>>driver.
> >>>
> >>>Signed-off-by: Thomas Graf <tgraf@suug.ch>
> >>>---
> >>>  drivers/net/ethernet/intel/e1000e/netdev.c | 15 +++++++++++----
> >>>  include/linux/netdevice.h                  |  2 +-
> >>>  2 files changed, 12 insertions(+), 5 deletions(-)
> >>
> >>Small nitpick, it is e1000e not e1000 that you are modifying.
> >
> >So other than the patch title and description referencing e1000 instead
> >of e1000e, patch looks fine.
> >
> >Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> 
> Thanks for working towards reducing struct net_device, that's awesome!
> 
> Wrt this patch, I'm wondering if that couldn't be pushed down into
> struct e1000_adapter entirely?

Sure, since I need to respin this anyway. Jeff are you OK with that?
