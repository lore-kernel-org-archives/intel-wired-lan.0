From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Mon, 12 Aug 2019 08:46:55 -0700
Subject: [Intel-wired-lan] [PATCH v3 14/17] fm10k: no need to check
 return value of debugfs_create functions
In-Reply-To: <20190810101732.26612-15-gregkh@linuxfoundation.org>
References: <20190810101732.26612-1-gregkh@linuxfoundation.org>
 <20190810101732.26612-15-gregkh@linuxfoundation.org>
Message-ID: <96c726571a7372a763db5ac7a6aa447911cb894b.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sat, 2019-08-10 at 12:17 +0200, Greg Kroah-Hartman wrote:
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic
> should
> never do something different based on this.
> 
> Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_debugfs.c | 2 --
>  1 file changed, 2 deletions(-)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190812/e8bd66a4/attachment.asc>
