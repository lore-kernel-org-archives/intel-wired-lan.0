From: Jakub Kicinski <kuba@kernel.org>
Date: Wed, 29 Sep 2021 06:40:04 -0700
Subject: [Intel-wired-lan] [PATCH net-next v1 0/5] Devlink reload and
 missed notifications fix
In-Reply-To: <cover.1632916329.git.leonro@nvidia.com>
References: <cover.1632916329.git.leonro@nvidia.com>
Message-ID: <20210929064004.3172946e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 29 Sep 2021 15:00:41 +0300 Leon Romanovsky wrote:
> This series starts from the fixing the bug introduced by implementing
> devlink delayed notifications logic, where I missed some of the
> notifications functions.
> 
> The rest series provides a way to dynamically set devlink ops that is
> needed for mlx5 multiport device and starts cleanup by removing
> not-needed logic.
> 
> In the next series, we will delete various publish API, drop general
> lock, annotate the code and rework logic around devlink->lock.
> 
> All this is possible because driver initialization is separated from the
> user input now.

Swapping ops is a nasty hack in my book.

And all that to avoid having two op structures in one driver.
Or to avoid having counters which are always 0?

Sorry, at the very least you need better explanation for this.
