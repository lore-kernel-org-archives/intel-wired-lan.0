From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Mon, 2 May 2022 09:29:56 +0000
Subject: [Intel-wired-lan] [PATCH v5] igb: Convert kmap() to
 kmap_local_page()
In-Reply-To: <YmGZFfcY/Yz6Iv1Y@iweiny-desk3>
References: <20220419234313.10324-1-eng.alaamohamedsoliman.am@gmail.com>
 <YmGZFfcY/Yz6Iv1Y@iweiny-desk3>
Message-ID: <BYAPR11MB3367A2BBE81A95AAEF6D0498FCC19@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Ira Weiny
> Sent: Thursday, April 21, 2022 11:19 PM
> To: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
> Cc: outreachy at lists.linux.dev; intel-wired-lan at lists.osuosl.org; linux-
> kernel at vger.kernel.org; netdev at vger.kernel.org; kuba at kernel.org;
> pabeni at redhat.com; davem at davemloft.net
> Subject: Re: [Intel-wired-lan] [PATCH v5] igb: Convert kmap() to
> kmap_local_page()
> 
> On Wed, Apr 20, 2022 at 01:43:13AM +0200, Alaa Mohamed wrote:
> > kmap() is being deprecated and these usages are all local to the
> > thread so there is no reason kmap_local_page() can't be used.
> >
> > Replace kmap() calls with kmap_local_page().
> >
> > Signed-off-by: Alaa Mohamed
> <eng.alaamohamedsoliman.am@gmail.com>
> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> 
> > ---
> > changes in V2:
> > 	fix kunmap_local path value to take address of the mapped page.
> > ---
> > changes in V3:
> > 	edit commit message to be clearer
> > ---
> > changes in V4:
> > 	edit the commit message
> > ---
> > changes in V5:
> > 	-edit commit subject
> > 	-edit commit message
> > ---
> >  drivers/net/ethernet/intel/igb/igb_ethtool.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >

Tested-by: Gurucharan <gurucharanx.g@intel.com> (A Contingent worker at Intel)
