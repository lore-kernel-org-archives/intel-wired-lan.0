From: Leon Romanovsky <leonro@nvidia.com>
Date: Wed, 29 Sep 2021 13:40:51 +0300
Subject: [Intel-wired-lan] [PATCH net-next 0/5] Devlink reload and
 missed notifications fix
In-Reply-To: <cover.1632909221.git.leonro@nvidia.com>
References: <cover.1632909221.git.leonro@nvidia.com>
Message-ID: <YVRCs1+09G0g40N8@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Sep 29, 2021 at 01:16:34PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Hi,
> 
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
> 
> Thanks
> 
> Leon Romanovsky (5):
>   devlink: Add missed notifications iterators

I missed WARN_ON(), I'm resending the series.

Thanks
