From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 5 May 2022 09:53:07 -0700
Subject: [Intel-wired-lan] [PATCH ipsec-next 6/8] netdevsim: rely on
 XFRM state direction instead of flags
In-Reply-To: <54be8183fb49a5486a8137627c204f00595e21af.1651743750.git.leonro@nvidia.com>
References: <cover.1651743750.git.leonro@nvidia.com>
 <54be8183fb49a5486a8137627c204f00595e21af.1651743750.git.leonro@nvidia.com>
Message-ID: <20220505095307.488c093b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu,  5 May 2022 13:06:43 +0300 Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Make sure that netdevsim relies on direction and not on flags.
> 
> Reviewed-by: Raed Salem <raeds@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Acked-by: Jakub Kicinski <kuba@kernel.org>
