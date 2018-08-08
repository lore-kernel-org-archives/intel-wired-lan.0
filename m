From: Leon Romanovsky <leon@kernel.org>
Date: Wed, 8 Aug 2018 09:10:21 +0300
Subject: [Intel-wired-lan] [PATCH v6 7/9] net/mlx4: Do not call
 pcie_print_link_status()
In-Reply-To: <20180806232600.25694-7-mr.nuke.me@gmail.com>
References: <CAErSpo4PK+SQLNfdkLNt9eLc7bpbxbkZCsa8T-tQpid601n0SQ@mail.gmail.com>
 <20180806232600.25694-1-mr.nuke.me@gmail.com>
 <20180806232600.25694-7-mr.nuke.me@gmail.com>
Message-ID: <20180808061021.GR13378@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Aug 06, 2018 at 06:25:41PM -0500, Alexandru Gagniuc wrote:
> This is now done by the PCI core to warn of sub-optimal bandwidth.
>
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> ---
>  drivers/net/ethernet/mellanox/mlx4/main.c | 7 -------
>  1 file changed, 7 deletions(-)
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180808/cf17c6fa/attachment.asc>
