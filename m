From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 6 Jun 2018 16:21:45 +0000
Subject: [Intel-wired-lan] [net-queue PATCH 1/2] ixgbe: Avoid loopback
 and fix boolean logic in ipsec_stop_data
In-Reply-To: <b25bee0f-05a0-f21e-4216-12dcafcd43a4@oracle.com>
References: <20180605150520.3359.94409.stgit@ahduyck-green-test.jf.intel.com>
 <20180605151108.3359.9455.stgit@ahduyck-green-test.jf.intel.com>
 <b25bee0f-05a0-f21e-4216-12dcafcd43a4@oracle.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2C62FE@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Shannon Nelson
> Sent: Tuesday, June 5, 2018 9:13 AM
> To: Duyck, Alexander H <alexander.h.duyck@intel.com>; intel-wired-
> lan at osuosl.org
> Subject: Re: [Intel-wired-lan] [net-queue PATCH 1/2] ixgbe: Avoid loopback
> and fix boolean logic in ipsec_stop_data
> 
> On 6/5/2018 8:11 AM, Alexander Duyck wrote:
> > This patch fixes two issues. First we add an early test for the Tx and
> > Rx security block ready bits. By doing this we can avoid the need for
> > waits or loopback in the event that the security block is already flushed out.
> > Secondly we fix the boolean logic that was testing for the Tx OR Rx
> > ready bits being set and change it so that we only exit if the Tx AND
> > Rx ready bits are both set.
> >
> > Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> Fixes: 49a94d74d948 ("ixgbe: add ipsec engine start and stop routines")
> Acked-by: Shannon Nelson <shannon.nelson@oracle.com>
> 
> > ---
> >   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c |   13 +++++++++++--
> >   1 file changed, 11 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


