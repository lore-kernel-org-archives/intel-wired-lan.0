From: Kangjie Lu <kjlu@umn.edu>
Date: Fri, 21 Dec 2018 13:21:39 -0600
Subject: [Intel-wired-lan] [PATCH] net: 80003es2lan: fix a missing check
 of read failure
In-Reply-To: <7478abbc4022a29414367cacdac1b89bff18c54c.camel@intel.com>
References: <20181220212359.564-1-kjlu@umn.edu>
 <7478abbc4022a29414367cacdac1b89bff18c54c.camel@intel.com>
Message-ID: <CAK8Kejr50jjWDO=ygyJBrmVXyveRuDjPzjYGpWJzcahVDGzaRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Sounds good. Look forward to your alternative patch. Enjoy your shopping.

On Fri, Dec 21, 2018 at 1:19 PM Jeff Kirsher <jeffrey.t.kirsher@intel.com>
wrote:

> On Thu, 2018-12-20 at 15:23 -0600, Kangjie Lu wrote:
> > When e1000_read_kmrn_reg_80003es2lan() fails, "kum_reg_data" is
> > uninitialized and may contain random value. However, it is further
> > used in the following execution, which will lead to undefined
> > behaviors.
> > The fix checks the failure of e1000_read_kmrn_reg_80003es2lan() and
> > returns with its error code if it fails.
> >
> > Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> > ---
> >  drivers/net/ethernet/intel/e1000e/80003es2lan.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
>
> This is a good catch, although we do not want to exit out on failure.  I
> have an alternative patch to resolve both issues, which I will submit later
> today.  Just need to finish holiday shopping for my wife... :-)
>
-- 
Kangjie Lu
Assistant Professor
Department of Computer Science and Engineering
University of Minnesota
Personal homepage <https://www-users.cs.umn.edu/~kjlu>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20181221/798b1ee4/attachment.html>
