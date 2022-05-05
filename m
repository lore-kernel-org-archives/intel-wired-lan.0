From: David Miller <davem@davemloft.net>
Date: Thu, 05 May 2022 12:03:38 +0100 (BST)
Subject: [Intel-wired-lan] [PATCH ipsec-next 3/8] xfrm: rename
 xfrm_state_offload struct to allow reuse
In-Reply-To: <2a59f8a4bfa849da0b3a9931bc2f687a6efdb74b.1651743750.git.leonro@nvidia.com>
References: <cover.1651743750.git.leonro@nvidia.com>
 <2a59f8a4bfa849da0b3a9931bc2f687a6efdb74b.1651743750.git.leonro@nvidia.com>
Message-ID: <20220505.120338.1740932781798266692.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Leon Romanovsky <leon@kernel.org>
Date: Thu,  5 May 2022 13:06:40 +0300

> From: Leon Romanovsky <leonro@nvidia.com>
> 
> The struct xfrm_state_offload has all fields needed to hold information
> for offloaded policies too. In order to do not create new struct with
> same fields, let's rename existing one and reuse it later.
> 
> Reviewed-by: Raed Salem <raeds@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Acked-by: David S. Miller <davem@davemloft.net>
