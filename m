From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 26 Jun 2019 22:26:11 +0000
Subject: [Intel-wired-lan] [PATCH][net-next] iavf: fix dereference of
 null rx_buffer pointer
In-Reply-To: <20190619143044.10259-1-colin.king@canonical.com>
References: <20190619143044.10259-1-colin.king@canonical.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3FB501@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Colin King
> Sent: Wednesday, June 19, 2019 7:31 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; David S . Miller
> <davem@davemloft.net>; intel-wired-lan at lists.osuosl.org;
> netdev at vger.kernel.org
> Cc: kernel-janitors at vger.kernel.org; linux-kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH][net-next] iavf: fix dereference of null
> rx_buffer pointer
> 
> From: Colin Ian King <colin.king@canonical.com>
> 
> A recent commit efa14c3985828d ("iavf: allow null RX descriptors") added a
> null pointer sanity check on rx_buffer, however, rx_buffer is being
> dereferenced before that check, which implies a null pointer dereference
> bug can potentially occur.  Fix this by only dereferencing rx_buffer until after
> the null pointer check.
> 
> Addresses-Coverity: ("Dereference before null check")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_txrx.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


