From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 4 Sep 2020 18:10:46 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: always propagate error value in
 i40e_set_vsi_promisc()
In-Reply-To: <20200820115312.28099-1-sassmann@kpanic.de>
References: <20200820115312.28099-1-sassmann@kpanic.de>
Message-ID: <DM6PR11MB2890E9ED7AA4ABBCCB790F2EBC2D0@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Stefan Assmann
> Sent: Thursday, August 20, 2020 4:53 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; sassmann at kpanic.de;
> davem at davemloft.net
> Subject: [Intel-wired-lan] [PATCH] i40e: always propagate error value in
> i40e_set_vsi_promisc()
> 
> The for loop in i40e_set_vsi_promisc() reports errors via dev_err() but
> does not propage the error up the call chain. Instead it continues the
> loop and potentially overwrites the reported error value.
> This results in the error being recorded in the log buffer, but the
> caller might never know anything went the wrong way.
> 
> To avoid this situation i40e_set_vsi_promisc() needs to temporary store
> the error after reporting it. This is still not optimal as multiple
> different errors may occur, so store the first error and hope that's
> the main issue.
> 
> Fixes: 37d318d7805f (i40e: Remove scheduling while atomic possibility)
> Reported-by: Michal Schmidt <mschmidt@redhat.com>
> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)

In the summary text:
%s/ propage/propagate/
%s/ temporary/temporarily/

I suspect Tony can fix that up before pushing.  Aside from that,
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
