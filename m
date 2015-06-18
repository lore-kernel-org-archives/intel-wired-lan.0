From: Young, James M <james.m.young@intel.com>
Date: Thu, 18 Jun 2015 00:22:03 +0000
Subject: [Intel-wired-lan] [net-next S5 02/15] i40evf: Allow for
	an	abundance of vectors
In-Reply-To: <1430161042-28494-3-git-send-email-catherine.sullivan@intel.com>
References: <1430161042-28494-1-git-send-email-catherine.sullivan@intel.com>
 <1430161042-28494-3-git-send-email-catherine.sullivan@intel.com>
Message-ID: <68C85B5FC2FE974B87244D7222BC92783EA19B18@ORSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Monday, April 27, 2015 11:57 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [net-next S5 02/15] i40evf: Allow for an abundance
> of vectors
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> The driver currently only maps TX and RX queues to a single MSI-X vector per
> queue pair if there are exactly enough vectors for this.
> Unfortunately, if we have too many vectors it will fail and allocate queues to
> vectors in a suboptimal manner. Change the condition check to allow for
> excess vectors. In this case, the extras just won't be used.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: I23e1e2955c64739c86612db88a25583e6a7e0b17
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Tested-by: Jim Young <james.m.young@intel.com>

