From: Leon Romanovsky <leon@kernel.org>
Date: Tue, 4 Sep 2018 15:51:08 +0300
Subject: [Intel-wired-lan] [PATCH 7/9] net/mlx4: Do not call
 pcie_print_link_status()
In-Reply-To: <20180903180242.14504-8-mr.nuke.me@gmail.com>
References: <20180903180242.14504-1-mr.nuke.me@gmail.com>
 <20180903180242.14504-8-mr.nuke.me@gmail.com>
Message-ID: <20180904125108.GE2796@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Sep 03, 2018 at 01:02:34PM -0500, Alexandru Gagniuc wrote:
> This is now done by the PCI core to warn of sub-optimal bandwidth.
>
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> ---
>  drivers/net/ethernet/mellanox/mlx4/main.c | 7 -------
>  1 file changed, 7 deletions(-)
>

Thanks,
Acked-by: Leon Romanovsky <leonro@mellanox.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180904/ac23a18e/attachment-0001.asc>
