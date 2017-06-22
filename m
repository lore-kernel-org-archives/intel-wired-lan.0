From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 22 Jun 2017 17:15:46 +0000
Subject: [Intel-wired-lan] [next PATCH S73-V2 3/9] i40e: Handle admin
	Q	timeout when releasing NVM
In-Reply-To: <20170620221701.46765-3-jeffrey.t.kirsher@intel.com>
References: <20170620221701.46765-1-jeffrey.t.kirsher@intel.com>
 <20170620221701.46765-3-jeffrey.t.kirsher@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DAB8EE@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Tuesday, June 20, 2017 3:17 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Stillwell Jr, Paul M <paul.m.stillwell.jr@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S73-V2 3/9] i40e: Handle admin Q
> timeout when releasing NVM
> 
> From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
> 
> There are some rare cases where the release resource call will return an
> admin Q timeout. In these cases the code needs to try to release the
> resource again until it succeeds or it times out.
> 
> Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_nvm.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


