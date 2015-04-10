From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 09 Apr 2015 21:35:39 -0700
Subject: [Intel-wired-lan] [PATCH 1/3 net-next] e1000: Allocate
 pm_qos_req as needed
In-Reply-To: <1428624503.2729.55.camel@jtkirshe-mobl>
References: <cover.1428622095.git.tgraf@suug.ch>
 <99ad8b242a65a60e2a76e952b4c91de2b54a0013.1428622095.git.tgraf@suug.ch>
 <1428624503.2729.55.camel@jtkirshe-mobl>
Message-ID: <1428640539.2729.67.camel@jtkirshe-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2015-04-09 at 17:08 -0700, Jeff Kirsher wrote:
> On Fri, 2015-04-10 at 01:43 +0200, Thomas Graf wrote:
> > e1000 is the only driver requiring pm_qos_req, instead of causing
> > every device to waste up to 240 bytes. Allocate it for the specific
> > driver.
> > 
> > Signed-off-by: Thomas Graf <tgraf@suug.ch>
> > ---
> >  drivers/net/ethernet/intel/e1000e/netdev.c | 15 +++++++++++----
> >  include/linux/netdevice.h                  |  2 +-
> >  2 files changed, 12 insertions(+), 5 deletions(-)
> 
> Small nitpick, it is e1000e not e1000 that you are modifying.

So other than the patch title and description referencing e1000 instead
of e1000e, patch looks fine.

Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150409/6efb76d3/attachment-0001.asc>
