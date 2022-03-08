From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Tue, 8 Mar 2022 12:54:52 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: little endian only valid
 checksums
In-Reply-To: <20220302125702.358999-1-trix@redhat.com>
References: <20220302125702.358999-1-trix@redhat.com>
Message-ID: <BYAPR11MB33679CF5EBB178871DBB63BAFC099@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> trix at redhat.com
> Sent: Wednesday, March 2, 2022 6:27 PM
> To: Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; davem at davemloft.net; kuba at kernel.org
> Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org; linux-
> kernel at vger.kernel.org; Tom Rix <trix@redhat.com>
> Subject: [Intel-wired-lan] [PATCH] i40e: little endian only valid checksums
> 
> From: Tom Rix <trix@redhat.com>
> 
> The calculation of the checksum can fail.
> So move converting the checksum to little endian
> to inside the return status check.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_nvm.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
