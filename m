From: Jakub Kicinski <kuba@kernel.org>
Date: Wed, 17 Nov 2021 20:49:29 -0800
Subject: [Intel-wired-lan] [PATCH net-next 4/6] devlink: Clean
 registration of devlink port
In-Reply-To: <9c3eb77a90a2be10d5c637981a8047160845f60f.1637173517.git.leonro@nvidia.com>
References: <cover.1637173517.git.leonro@nvidia.com>
 <9c3eb77a90a2be10d5c637981a8047160845f60f.1637173517.git.leonro@nvidia.com>
Message-ID: <20211117204929.4bd24597@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 17 Nov 2021 20:26:20 +0200 Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> devlink_port_register() is in-kernel API and as such can't really fail
> as long as driver author didn't make a mistake by providing already existing
> port index. Instead of relying on various error prints from the driver,
> convert the existence check to be WARN_ON(), so such a mistake will be
> caught easier.
> 
> As an outcome of this conversion, it was made clear that this function
> should be void and devlink->lock was intended to protect addition to
> port_list.

Leave this error checking in please.
