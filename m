From: Leon Romanovsky <leon@kernel.org>
Date: Mon, 2 May 2016 09:06:53 +0300
Subject: [Intel-wired-lan] [PATCH] i40e: constify i40e_client_ops
	structure
In-Reply-To: <1462104443-30724-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1462104443-30724-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <20160502060653.GD10276@leon.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sun, May 01, 2016 at 02:07:23PM +0200, Julia Lawall wrote:
> The i40e_client_ops structure is never modified, so declare it as const.
> 
> Done with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 

Thanks Julia,

Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160502/2a41ab56/attachment-0001.asc>
