From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Wed, 29 Mar 2017 23:01:02 +0000
Subject: [Intel-wired-lan] [[next PATCH S66-V2 08/11] i40e: clean up
 historic deprecated flag definitions
In-Reply-To: <1490809126.29410.5.camel@intel.com>
References: <20170329082230.3869-1-alice.michael@intel.com>
 <20170329082230.3869-9-alice.michael@intel.com>
 <1490809126.29410.5.camel@intel.com>
Message-ID: <02874ECE860811409154E81DA85FBB5857DEDCF8@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Kirsher, Jeffrey T
> Sent: Wednesday, March 29, 2017 10:39 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-lan at lists.osuosl.org
> Cc: Keller, Jacob E <jacob.e.keller@intel.com>
> Subject: Re: [[next PATCH S66-V2 08/11] i40e: clean up historic deprecated flag
> definitions
> 
> On Wed, 2017-03-29 at 04:22 -0400, Alice Michael wrote:
> > From: Jacob Keller <jacob.e.keller@intel.com>
> >
> > Since an early commit a few flags have no longer
> > been used. Remove these definitions to reduce code clutter.
> >
> > Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> > Change-ID: I3589be4622574e747013cd4dc403e18b039f4965
> 
> This would be a good chance to actually align the flag values so that
> out-of-tree and kernel match.

There are more patches coming along regarding flags, so the plan is Soon(TM) but not quite yet.

Thanks,
Jake

> 
> > ---
> > ?drivers/net/ethernet/intel/i40e/i40e.h | 3 ---
> > ?1 file changed, 3 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e.h
> > b/drivers/net/ethernet/intel/i40e/i40e.h
> > index ef64dc6..e987503 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e.h
> > +++ b/drivers/net/ethernet/intel/i40e/i40e.h
> > @@ -390,11 +390,8 @@ struct i40e_pf {
> > ?#define I40E_FLAG_RSS_ENABLED			BIT_ULL(6)
> > ?#define I40E_FLAG_VMDQ_ENABLED			BIT_ULL(7)
> > ?#define I40E_FLAG_IWARP_ENABLED			BIT_ULL(10)
> > -#define I40E_FLAG_CLEAN_ADMINQ			BIT_ULL(14)
> > ?#define I40E_FLAG_FILTER_SYNC			BIT_ULL(15)
> > ?#define I40E_FLAG_SERVICE_CLIENT_REQUESTED	BIT_ULL(16)
> > -#define I40E_FLAG_PROCESS_MDD_EVENT		BIT_ULL(17)
> > -#define I40E_FLAG_PROCESS_VFLR_EVENT		BIT_ULL(18)
> > ?#define I40E_FLAG_SRIOV_ENABLED			BIT_ULL(19)
> > ?#define I40E_FLAG_DCB_ENABLED			BIT_ULL(20)
> > ?#define I40E_FLAG_FD_SB_ENABLED			BIT_ULL(21)
