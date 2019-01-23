From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 23 Jan 2019 09:04:27 -0800
Subject: [Intel-wired-lan] [PATCH net-next] intel: Mark expected switch
 fall-throughs
In-Reply-To: <20190123074849.GA24230@embeddedor>
References: <20190123074849.GA24230@embeddedor>
Message-ID: <e356e64d3267bbca1cfa0373b7ce965edaf159bd.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2019-01-23 at 01:48 -0600, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> This patch fixes the following warnings:
> 
> drivers/net/ethernet/intel/igb/e1000_82575.c:636:6: warning: this
> statement may fall through [-Wimplicit-fallthrough=]
> drivers/net/ethernet/intel/igb/igb_main.c:6710:6: warning: this
> statement may fall through [-Wimplicit-fallthrough=]
> drivers/net/ethernet/intel/i40e/i40e_xsk.c:237:3: warning: this
> statement may fall through [-Wimplicit-fallthrough=]
> 
> Warning level 3 was used: -Wimplicit-fallthrough=3
> 
> This patch is part of the ongoing efforts to enabling
> -Wimplicit-fallthrough.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c   | 3 ++-
>  drivers/net/ethernet/intel/igb/e1000_82575.c | 2 +-
>  drivers/net/ethernet/intel/igb/igb_main.c    | 2 +-
>  3 files changed, 4 insertions(+), 3 deletions(-)

NAK on the igb changes.  There is already a "fall through" code comment
which is fine, adding a hyphen does not make the comment any more
readable.

The i40e changes are acceptable, if you want to re-submit with only
those changes.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190123/c1cb4dab/attachment-0001.asc>
