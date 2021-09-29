From: Simon Horman <simon.horman@corigine.com>
Date: Wed, 29 Sep 2021 12:20:13 +0200
Subject: [Intel-wired-lan] [PATCH net-next 2/5] devlink: Allow
 modification of devlink ops
In-Reply-To: <0e07ad986db7d2f033a97e4c8253940676128237.1632909221.git.leonro@nvidia.com>
References: <cover.1632909221.git.leonro@nvidia.com>
 <0e07ad986db7d2f033a97e4c8253940676128237.1632909221.git.leonro@nvidia.com>
Message-ID: <20210929102012.GE13506@corigine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Sep 29, 2021 at 01:16:36PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Drop const identifier from devlink_ops declaration to allow
> run-time modification of pre-declared ops.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Thanks, for NFP portion:

Acked-by: Simon Horman <simon.horman@corigine.com>

