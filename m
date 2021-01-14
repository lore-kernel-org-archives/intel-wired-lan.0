From: Saeed Mahameed <saeed@kernel.org>
Date: Thu, 14 Jan 2021 14:59:32 -0800
Subject: [Intel-wired-lan] [PATCH net-next 0/4] i40e: small improvements
 on XDP path
In-Reply-To: <20210114143318.2171-1-cristian.dumitrescu@intel.com>
References: <20210114143318.2171-1-cristian.dumitrescu@intel.com>
Message-ID: <68e347348c3f71a92a43a51fb71bce90aec56451.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2021-01-14 at 14:33 +0000, Cristian Dumitrescu wrote:
> This patchset introduces some small and straightforward improvements
> to the Intel i40e driver XDP path. Each improvement is fully
> described
> in its associated patch.
> 
> Cristian Dumitrescu (4):
>   i40e: remove unnecessary memory writes of the next to clean pointer
>   i40e: remove unnecessary cleaned_count updates
>   i40e: remove the redundant buffer info updates
>   i40: consolidate handling of XDP program actions
> 
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c | 149 +++++++++++------
> ----
>  1 file changed, 79 insertions(+), 70 deletions(-)
> 
FWIW,
Reviewed-by: Saeed Mahameed <saeedm@nvidia.com>

