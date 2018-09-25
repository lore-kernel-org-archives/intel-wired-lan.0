From: Jakub Kicinski <jakub.kicinski@netronome.com>
Date: Tue, 25 Sep 2018 07:57:14 -0700
Subject: [Intel-wired-lan] [PATCH 3/5] ixgbe: add AF_XDP zero-copy Rx
 support
In-Reply-To: <20180924163557.1187-4-bjorn.topel@gmail.com>
References: <20180924163557.1187-1-bjorn.topel@gmail.com>
 <20180924163557.1187-4-bjorn.topel@gmail.com>
Message-ID: <20180925075714.75db73ac@cakuba.netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 24 Sep 2018 18:35:55 +0200, Bj?rn T?pel wrote:
> +	if (adapter->flags & IXGBE_FLAG_SRIOV_ENABLED)
> +		return -EINVAL;
> +
> +	if (adapter->flags & IXGBE_FLAG_DCB_ENABLED)
> +		return -EINVAL;

Hm, should you add UMEM checks to all the places these may get
enabled?  Like fabf1bce103a ("ixgbe: Prevent unsupported configurations
with XDP") did?
