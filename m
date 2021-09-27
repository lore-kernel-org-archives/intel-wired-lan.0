From: Simon Horman <simon.horman@corigine.com>
Date: Mon, 27 Sep 2021 10:39:24 +0200
Subject: [Intel-wired-lan] [PATCH net-next v1 13/21] nfp: Move
 delink_register to be last command
In-Reply-To: <f393212ad3906808ee7eb5cff06ef2e053eb9d2b.1632565508.git.leonro@nvidia.com>
References: <cover.1632565508.git.leonro@nvidia.com>
 <f393212ad3906808ee7eb5cff06ef2e053eb9d2b.1632565508.git.leonro@nvidia.com>
Message-ID: <20210927083923.GC17484@corigine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sat, Sep 25, 2021 at 02:22:53PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Open user space access to the devlink after driver is probed.

Hi Leon,

I think a description of why is warranted here.

> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
