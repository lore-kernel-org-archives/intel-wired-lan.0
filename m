From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 5 Aug 2019 17:59:03 -0400
Subject: [Intel-wired-lan] [PATCH 2/2] ixgbe: Use refcount_t for refcount
In-Reply-To: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40F174@ORSMSX104.amr.corp.intel.com>
References: <20190802105507.16650-1-hslester96@gmail.com>
 <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40F174@ORSMSX104.amr.corp.intel.com>
Message-ID: <CA+FuTSf5vWxBxCBEzCGmUg+BMUS=JOk1nzcG7X9Kt-evAxmeiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Aug 5, 2019 at 5:43 PM Bowers, AndrewX <andrewx.bowers@intel.com> wrote:
>
> > -----Original Message-----
> > From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> > Behalf Of Chuhong Yuan
> > Sent: Friday, August 2, 2019 3:55 AM
> > Cc: netdev at vger.kernel.org; Chuhong Yuan <hslester96@gmail.com>; linux-
> > kernel at vger.kernel.org; intel-wired-lan at lists.osuosl.org; David S . Miller
> > <davem@davemloft.net>
> > Subject: [Intel-wired-lan] [PATCH 2/2] ixgbe: Use refcount_t for refcount
> >
> > refcount_t is better for reference counters since its implementation can
> > prevent overflows.
> > So convert atomic_t ref counters to refcount_t.
> >
> > Also convert refcount from 0-based to 1-based.
> >
> > This patch depends on PATCH 1/2.
> >
> > Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> > ---
> >  drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c | 6 +++---
> > drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.h | 2 +-
> >  2 files changed, 4 insertions(+), 4 deletions(-)
>
> Tested-by: Andrew Bowers <andrewx.bowers@intel.com>

To reiterate, this patchset should not be applied as is. It is not
correct to simply change the initial refcount.
