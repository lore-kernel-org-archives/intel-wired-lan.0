From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Date: Wed, 20 Dec 2017 23:17:35 -0200
Subject: [Intel-wired-lan] [PATCH v3 next-queue 05/10] ixgbe: add ipsec
 offload add and remove SA
In-Reply-To: <1513728002-7643-6-git-send-email-shannon.nelson@oracle.com>
References: <1513728002-7643-1-git-send-email-shannon.nelson@oracle.com>
 <1513728002-7643-6-git-send-email-shannon.nelson@oracle.com>
Message-ID: <20171221010139.GM6122@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

On Tue, Dec 19, 2017 at 03:59:57PM -0800, Shannon Nelson wrote:
> +}
> +
> +static const struct xfrmdev_ops ixgbe_xfrmdev_ops = {
> +	.xdo_dev_state_add = ixgbe_ipsec_add_sa,
> +	.xdo_dev_state_delete = ixgbe_ipsec_del_sa,
> +};
> +

This struct is only declared if XFRM_OFFLOAD is selected. What is
selecting it for ixgbe driver?
mlx5 driver has an extra option for ipsec offload and it then does
'depends on XFRM_OFFLOAD'

  Marcelo
