From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 20 Dec 2018 20:31:44 +0000
Subject: [Intel-wired-lan] [next PATCH S1 5/6] i40e: remove debugfs
 tx_timeout support
In-Reply-To: <20181219144542.85924-5-alice.michael@intel.com>
References: <20181219144542.85924-1-alice.michael@intel.com>
 <20181219144542.85924-5-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3439B6@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, December 19, 2018 6:46 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S1 5/6] i40e: remove debugfs
> tx_timeout support
> 
> From: Lihong Yang <lihong.yang@intel.com>
> 
> The tx_timeout command from debugfs was originally intended to support
> early silicon validation efforts. It is no longer needed. Thus remove it to avoid
> misuse of triggering tx_timeout through debugfs.
> 
> Signed-off-by: Lihong Yang <lihong.yang@intel.com>
> ---
>  .../net/ethernet/intel/i40e/i40e_debugfs.c    | 26 +------------------
>  1 file changed, 1 insertion(+), 25 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


