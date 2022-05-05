From: David Miller <davem@davemloft.net>
Date: Thu, 05 May 2022 12:02:34 +0100 (BST)
Subject: [Intel-wired-lan] [PATCH ipsec-next 1/8] xfrm: free not used
 XFRM_ESP_NO_TRAILER flag
In-Reply-To: <a8b37f45df031108d6b191916570a1005d645d38.1651743750.git.leonro@nvidia.com>
References: <cover.1651743750.git.leonro@nvidia.com>
 <a8b37f45df031108d6b191916570a1005d645d38.1651743750.git.leonro@nvidia.com>
Message-ID: <20220505.120234.829231575836812605.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Leon Romanovsky <leon@kernel.org>
Date: Thu,  5 May 2022 13:06:38 +0300

> From: Leon Romanovsky <leonro@nvidia.com>
> 
> After removal of Innova IPsec support from mlx5 driver, the last user
> of this XFRM_ESP_NO_TRAILER was gone too. This means that we can safely
> remove it as no other hardware is capable (or need) to remove ESP trailer.
> 
> Reviewed-by: Raed Salem <raeds@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Acked-by: David S. Miller <davem@davemloft.net>
