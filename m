From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri, 24 Aug 2018 11:21:53 -0700
Subject: [Intel-wired-lan] [PATCH] ixgb: replace dma_alloc_coherent +
 memset with dma_zalloc_coherent
In-Reply-To: <20180824165232.21585-1-colin.king@canonical.com>
References: <20180824165232.21585-1-colin.king@canonical.com>
Message-ID: <9f9cff98f1f7f0b9c9250a3a14f1ba0ea7268ed8.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2018-08-24 at 17:52 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Use dma_zalloc_coherent rather than dam_alloc_coherent and memset.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/net/ethernet/intel/ixgb/ixgb_main.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Thanks Colin, I already have this change queued up from another community
member and I am just about to send a pull request to Dave for this change,
as well as several other fixes.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180824/4e8eff84/attachment.asc>
