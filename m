From: David Miller <davem@davemloft.net>
Date: Thu, 05 May 2022 12:03:05 +0100 (BST)
Subject: [Intel-wired-lan] [PATCH ipsec-next 2/8] xfrm: delete not used
 number of external headers
In-Reply-To: <099569952c609251ea4c156d6c6aed6031abafa7.1651743750.git.leonro@nvidia.com>
References: <cover.1651743750.git.leonro@nvidia.com>
 <099569952c609251ea4c156d6c6aed6031abafa7.1651743750.git.leonro@nvidia.com>
Message-ID: <20220505.120305.2196682232464025660.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Leon Romanovsky <leon@kernel.org>
Date: Thu,  5 May 2022 13:06:39 +0300

> From: Leon Romanovsky <leonro@nvidia.com>
> 
> num_exthdrs is set but never used, so delete it.
> 
> Reviewed-by: Raed Salem <raeds@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Acked-by: David S. Miller <davem@davemloft.net>
