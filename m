From: Jiri Pirko <jiri@resnulli.us>
Date: Mon, 9 Aug 2021 11:07:30 +0200
Subject: [Intel-wired-lan] [PATCH net-next] devlink: Set device as early
 as possible
In-Reply-To: <6859503f7e3e6cd706bf01ef06f1cae8c0b0970b.1628449004.git.leonro@nvidia.com>
References: <6859503f7e3e6cd706bf01ef06f1cae8c0b0970b.1628449004.git.leonro@nvidia.com>
Message-ID: <YRDwUrOK1YHsK7CE@nanopsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Sun, Aug 08, 2021 at 08:57:43PM CEST, leon at kernel.org wrote:
>From: Leon Romanovsky <leonro@nvidia.com>
>
>All kernel devlink implementations call to devlink_alloc() during
>initialization routine for specific device which is used later as
>a parent device for devlink_register().
>
>Such late device assignment causes to the situation which requires us to
>call to device_register() before setting other parameters, but that call
>opens devlink to the world and makes accessible for the netlink users.
>
>Any attempt to move devlink_register() to be the last call generates the
>following error due to access to the devlink->dev pointer.
>
>[    8.758862]  devlink_nl_param_fill+0x2e8/0xe50
>[    8.760305]  devlink_param_notify+0x6d/0x180
>[    8.760435]  __devlink_params_register+0x2f1/0x670
>[    8.760558]  devlink_params_register+0x1e/0x20
>
>The simple change of API to set devlink device in the devlink_alloc()
>instead of devlink_register() fixes all this above and ensures that
>prior to call to devlink_register() everything already set.
>
>Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
