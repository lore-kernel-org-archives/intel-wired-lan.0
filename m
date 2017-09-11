From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 11 Sep 2017 18:43:36 +0000
Subject: [Intel-wired-lan] [PATCH net 2/2] i40e: Avoid some
	useless	variables and initializers in nvm functions
In-Reply-To: <d0881adf53a3f0a546b3e7940b92b4ce938e7e50.1504684488.git.sbrivio@redhat.com>
References: <cover.1504684488.git.sbrivio@redhat.com>
 <d0881adf53a3f0a546b3e7940b92b4ce938e7e50.1504684488.git.sbrivio@redhat.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EA9F4D@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Stefano Brivio
> Sent: Wednesday, September 6, 2017 1:12 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>;
> netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org
> Cc: David S . Miller <davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH net 2/2] i40e: Avoid some useless variables
> and initializers in nvm functions
> 
> Fixes: 09f79fd49d94 ("i40e: avoid NVM acquire deadlock during NVM
> update")
> Signed-off-by: Stefano Brivio <sbrivio@redhat.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_nvm.c | 20 +++++++-------------
>  1 file changed, 7 insertions(+), 13 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


