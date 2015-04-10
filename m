From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri, 10 Apr 2015 08:59:27 -0700
Subject: [Intel-wired-lan] [PATCH 1/2 net-next] e1000e: Move pm_qos_req
	to e1000e adapter
In-Reply-To: <5c4f0f5fc93592d2b4bce2cd7dd494a52a2e19f8.1428672434.git.tgraf@suug.ch>
References: <cover.1428672434.git.tgraf@suug.ch>
 <5c4f0f5fc93592d2b4bce2cd7dd494a52a2e19f8.1428672434.git.tgraf@suug.ch>
Message-ID: <1428681567.2729.90.camel@jtkirshe-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2015-04-10 at 15:52 +0200, Thomas Graf wrote:
> e1000e is the only driver requiring pm_qos_req, instead of causing
> every device to waste up to 240 bytes. Allocate it for the specific
> driver.
> 
> Signed-off-by: Thomas Graf <tgraf@suug.ch>

Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

> ---
>  drivers/net/ethernet/intel/e1000e/e1000.h  | 1 +
>  drivers/net/ethernet/intel/e1000e/netdev.c | 8 ++++----
>  include/linux/netdevice.h                  | 1 -
>  3 files changed, 5 insertions(+), 5 deletions(-)


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150410/bd78a132/attachment.asc>
