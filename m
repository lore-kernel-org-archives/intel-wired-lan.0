From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 11 Sep 2017 18:42:46 +0000
Subject: [Intel-wired-lan] [PATCH net 1/2] i40e: Fix comment about
 locking	for __i40e_read_nvm_word()
In-Reply-To: <4d27bbb33031ac1489fe6d969edd74d44155136c.1504684488.git.sbrivio@redhat.com>
References: <cover.1504684488.git.sbrivio@redhat.com>
 <4d27bbb33031ac1489fe6d969edd74d44155136c.1504684488.git.sbrivio@redhat.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EA9F3D@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH net 1/2] i40e: Fix comment about locking
> for __i40e_read_nvm_word()
> 
> Caller needs to acquire the lock. Called functions will not.
> 
> Fixes: 09f79fd49d94 ("i40e: avoid NVM acquire deadlock during NVM
> update")
> Signed-off-by: Stefano Brivio <sbrivio@redhat.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_nvm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


