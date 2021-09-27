From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Mon, 27 Sep 2021 12:47:01 -0700
Subject: [Intel-wired-lan] [PATCH net-next v1 06/21] ice: Open devlink
 when device is ready
In-Reply-To: <23884bb7be2cc08ae00c551a6bb7d200a75b5117.1632565508.git.leonro@nvidia.com>
References: <cover.1632565508.git.leonro@nvidia.com>
 <23884bb7be2cc08ae00c551a6bb7d200a75b5117.1632565508.git.leonro@nvidia.com>
Message-ID: <fcea987e-742b-23b7-3219-c490d46e5597@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 9/25/2021 4:22 AM, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Move devlink_registration routine to be the last command, when the
> device is fully initialized.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

For the ice driver, thanks for fixing it!

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
