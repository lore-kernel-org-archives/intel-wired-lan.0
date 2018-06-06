From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 6 Jun 2018 16:20:31 +0000
Subject: [Intel-wired-lan] [net-queue PATCH v2 1/2] ixgbe: Use
 CONFIG_XFRM_OFFLOAD instead of CONFIG_XFRM
In-Reply-To: <cade2841-d561-0c41-4c90-19314730bbda@oracle.com>
References: <20180604204931.5474.94068.stgit@ahduyck-green-test.jf.intel.com>
 <20180604205120.5474.22753.stgit@ahduyck-green-test.jf.intel.com>
 <cade2841-d561-0c41-4c90-19314730bbda@oracle.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2C62DE@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Shannon Nelson
> Sent: Monday, June 4, 2018 2:13 PM
> To: Duyck, Alexander H <alexander.h.duyck@intel.com>; intel-wired-
> lan at osuosl.org; andre at tomt.net
> Subject: Re: [Intel-wired-lan] [net-queue PATCH v2 1/2] ixgbe: Use
> CONFIG_XFRM_OFFLOAD instead of CONFIG_XFRM
> 
> On 6/4/2018 1:51 PM, Alexander Duyck wrote:
> > There is no point in adding code if CONFIG_XFRM is defined that we
> > won't use unless CONFIG_XFRM_OFFLOAD is defined. So instead of leaving
> > this code floating around I am replacing the ifdef with what I believe
> > is the correct one so that we only include the code and variables if
> > they will actually be used.
> >
> > Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> Acked-by: Shannon Nelson <shannon.nelson@oracle.com>
> 
> > ---
> >   drivers/net/ethernet/intel/ixgbe/ixgbe.h      |    4 ++--
> >   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    2 +-
> >   2 files changed, 3 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


