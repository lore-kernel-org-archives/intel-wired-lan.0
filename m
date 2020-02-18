From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 18 Feb 2020 13:49:58 -0800
Subject: [Intel-wired-lan] [PATCH net-next v2 06/13] e1000(e): use new
 helper tcp_v6_gso_csum_prep
In-Reply-To: <47621909-1b75-e8d1-cf32-857c1601e0af@gmail.com>
References: <fffc8b6d-68ed-7501-18f1-94cf548821fb@gmail.com>
 <47621909-1b75-e8d1-cf32-857c1601e0af@gmail.com>
Message-ID: <3f966849ef8a21343d5a96b1ef89b7ad00b65b80.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2020-02-18 at 21:05 +0100, Heiner Kallweit wrote:
> Use new helper tcp_v6_gso_csum_prep in additional network drivers.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

> ---
>  drivers/net/ethernet/intel/e1000/e1000_main.c | 6 +-----
>  drivers/net/ethernet/intel/e1000e/netdev.c    | 5 +----
>  2 files changed, 2 insertions(+), 9 deletions(-)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200218/d447e677/attachment.asc>
